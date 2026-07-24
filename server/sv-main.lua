RegisterNetEvent('filo_muffler:server:checkVehicle', function(netId)
    local vehicle = NetworkGetEntityFromNetworkId(netId)
    if not vehicle or not DoesEntityExist(vehicle) then return end

    local vehicleObj = lib.vehicle:new(vehicle)
    local plate = vehicleObj:getPlate()
    local vehicleData = GetVehicleData(plate)

    vehicleObj:setr('mufflerSound', vehicleData and vehicleData.mufflerSound or 'default')
end)

lib.callback.register('filo_muffler:server:setMufflerSound', function(source, netId, sound)
    local vehicle = NetworkGetEntityFromNetworkId(netId)
    if not vehicle or not DoesEntityExist(vehicle) then return false end

    local vehicleObj = lib.vehicle:new(vehicle)
    local plate = vehicleObj:getPlate()
    local vehicleData = GetVehicleData(plate) or {}

    vehicleData.mufflerSound = sound
    SetVehicleData(plate, vehicleData)

    vehicleObj:setr('mufflerSound', sound)

    return true
end)

lib.callback.register('filo_muffler:server:resetMufflerSound', function(source, netId)
    local vehicle = NetworkGetEntityFromNetworkId(netId)
    if not vehicle or not DoesEntityExist(vehicle) then return false end

    local vehicleObj = lib.vehicle:new(vehicle)
    local plate = vehicleObj:getPlate()
    local vehicleData = GetVehicleData(plate) or {}

    vehicleData.mufflerSound = nil
    SetVehicleData(plate, vehicleData)
    vehicleObj:setr('mufflerSound', 'default')

    return true
end)

lib.addCommand(Config.Command, {
    help = 'Change engine sound',
    restricted = Config.CommandPermissions
}, function(source, args, raw)
    TriggerClientEvent('filo_muffler:client:openMenu', source, true)
end)
