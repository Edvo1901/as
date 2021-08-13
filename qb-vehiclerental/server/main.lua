QBCore = nil

TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

-- Code

local RentedVehicles = {}

RegisterServerEvent('qb-vehiclerental:server:SetVehicleRented')
AddEventHandler('qb-vehiclerental:server:SetVehicleRented', function(plate, bool, vehicleData)
    local src = source
    local ply = QBCore.Functions.GetPlayer(src)

    if bool then
        if ply.getMoney() >= vehicleData.price then
            ply.removeMoney(vehicleData.price)
            RentedVehicles["Rental"] = plate
            TriggerClientEvent("pNotify:SetQueueMax", -1, 'You have the deposit of €'..vehicleData.price..' paid in cash.', 1)
            TriggerClientEvent('qb-vehiclerental:server:SpawnRentedVehicle', src, plate, vehicleData) 
        elseif ply.getAccount('bank').money >= vehicleData.price then 
            ply.removeAccountMoney('bank', vehicleData.price) 
            RentedVehicles["Rental"] = plate
            TriggerClientEvent("pNotify:SetQueueMax", -1, 'You have the deposit of €'..vehicleData.price..' paid with your bank account.', 1)
            TriggerClientEvent('qb-vehiclerental:server:SpawnRentedVehicle', src, plate, vehicleData) 
        else
            TriggerClientEvent("pNotify:SetQueueMax", -1, 'You do not have enough money.', 1)
        end
        return
    end
    TriggerClientEvent("pNotify:SetQueueMax", -1, 'You got back your deposit €'..vehicleData.price..'.', 1)
    ply.addMoney(vehicleData.price)
    RentedVehicles[plyCid] = nil
end)




