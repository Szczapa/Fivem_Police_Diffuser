local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('CheckRemainingTime', function(source, cb, vPlate)  
    local vehiclesData = readJsonFile()
    if vehiclesData[vPlate] and vehiclesData[vPlate].bombStatut == 1 then
        local timer = vehiclesData[vPlate].timer
        local remainingTime = timer - os.time() 
        if remainingTime < 0 then 
            remainingTime = 0
        end
        cb(remainingTime)
    else
        cb(0)
    end
end)


QBCore.Functions.CreateCallback('CheckIfBomb', function(source, cb, vPlate)
    QBCore.Debug(vPlate)
    local vehiclesData = readJsonFile()   
    if vehiclesData[vPlate] and (vehiclesData[vPlate].bombStatut == 1 or vehiclesData[vPlate].bombStatut == 2 or vehiclesData[vPlate].bombStatut == 3) then
        local bombType = vehiclesData[vPlate].bombType
        QBCore.Debug(bombType)
        cb(bombType)
    else
        cb(nil)
    end
end)


RegisterNetEvent('CheckbombType')
AddEventHandler('CheckbombType', function(vPlate)
    local Player = QBCore.Functions.GetPlayer(source)

    local vehiclesData = readJsonFile()


    if vehiclesData[vPlate] and (vehiclesData[vPlate].bombStatut == 2 or vehiclesData[vPlate].bombStatut == 3) then
        local bombType = vehiclesData[vPlate].bombType

        -- Effectuer des actions en fonction du type de bombe
        if bombType == 1 then
            Player.Functions.AddItem("bomb_remote", 1, false)
        elseif bombType == 2 then
            Player.Functions.AddItem("bomb_open", 1, false)
        elseif bombType == 3 then
            Player.Functions.AddItem("bomb_underspeed", 1, false)
        elseif bombType == 4 then
            Player.Functions.AddItem("bomb_speed", 1, false)
        elseif bombType == 5 then
            Player.Functions.AddItem("bomb_sittimer", 1, false)
        elseif bombType == 6 then
            Player.Functions.AddItem("bomb_timer", 1, false)
        elseif bombType == 7 then
            Player.Functions.AddItem("training_bomb", 1, false)
        end

        TriggerEvent('RemoveBomb', vPlate)
    else
        return
    end
end)


RegisterServerEvent('RemoveBomb')
AddEventHandler('RemoveBomb', function(vPlate)  
    local vehiclesData = readJsonFile()

    if vehiclesData[vPlate] and (vehiclesData[vPlate].bombStatut == 2 or vehiclesData[vPlate].bombStatut == 3) then
        vehiclesData[vPlate] = nil

        writeJsonFile(vehiclesData)
        print('Delete')
    end
end)


RegisterServerEvent('DiffuseStatus')
AddEventHandler('DiffuseStatus', function(vPlate)
    print(vPlate)
    local vehiclesData = readJsonFile()

    if vehiclesData[vPlate] and vehiclesData[vPlate].bombStatut == 1 then
        vehiclesData[vPlate].bombStatut = 3 

        writeJsonFile(vehiclesData)
        print('Update')
    end
end)
