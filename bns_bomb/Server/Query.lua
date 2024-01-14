local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('Time')
AddEventHandler('Time', function(vPlate)
    local timer = os.time() + Config.TimeUntilDetonation 
    local vehiclesData = readJsonFile()  
    if vehiclesData[vPlate] then     
        vehiclesData[vPlate].timer = timer      
        writeJsonFile(vehiclesData)     
    end
end)


RegisterServerEvent('ArmedStatus')
AddEventHandler('ArmedStatus', function(vPlate, bombType, bombStatut)
    print('ArmedStatus')
    local timer = os.time() + Config.TimeUntilDetonation
    local vehiclesData = readJsonFile()
    QBCore.Debug(vehiclesData)
    if not vehiclesData[vPlate] then
        vehiclesData[vPlate] = {
            bombType = bombType,
            bombStatut = bombStatut,
            timer = timer
        }       
        writeJsonFile(vehiclesData)        
    else
       print('exist')
    end
end)


RegisterServerEvent('ExploseStatus')
AddEventHandler('ExploseStatus', function(vPlate)
    local vehiclesData = readJsonFile()   
    if vehiclesData[vPlate] and vehiclesData[vPlate].bombStatut == 1 then
        -- Mettre à jour le statut de la bombe à 2
        vehiclesData[vPlate].bombStatut = 2
        writeJsonFile(vehiclesData)      
    end
end)

QBCore.Functions.CreateCallback('CheckStatus', function(source, cb, vPlate)
    -- Lire les données existantes à partir du fichier JSON
    local vehiclesData = readJsonFile()
    if vehiclesData[vPlate] and vehiclesData[vPlate].bombStatut == 1 then
        local data = {
            status = vehiclesData[vPlate].bombStatut,
            bombType = vehiclesData[vPlate].bombType
        }
        cb(data)
    else
        cb(nil)
    end
end)
