local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("WaitClick",function(armdeVeh,Vplate)
    while armedVeh do 
        -- TriggerServerEvent('CheckArmedV',vPlate,bombType,1)            
        Citizen.Wait(0)
        -- if result then
            if armedVeh then                
                if IsControlJustReleased(0, Config.TriggerKey) then
                    print('press')
                    TriggerClientEvent("DetonateVehicle",armedVeh)                    
                    TriggerServerEvent('UpdateBombStatut',vPlate,bombType,2)
                    armedVeh = nil
                end
            end
        -- else
            -- armedVeh = nil
        -- end
    end
end)