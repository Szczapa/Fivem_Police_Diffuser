local QBCore = exports['qb-core']:GetCoreObject()
local armedVeh
local ped = PlayerPedId()
local coords = GetEntityCoords(ped)
local bombType = 2

RegisterNetEvent('Qb-Carbomb:CheckRequirement6')
AddEventHandler('Qb-Carbomb:CheckRequirement6', function()    
    local veh = QBCore.Functions.GetClosestVehicle()  
    print('click ')
    if not IsPedInAnyVehicle(ped) then 
        print('click detecte')       
        if veh then
            print('click detecte + veh') 
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            local vCoords = GetEntityCoords(veh)       
            local vPlate = QBCore.Functions.GetPlate(veh)     

            if #(coords - vCoords) < 3.0 and not IsPedInAnyVehicle(ped) then
            print('Clothest')            
            PlayAnim()
            QBCore.Functions.Progressbar('Armement', 'Armement', Config.TimeTakenToArm, false, true, {
                disableMovement = true,
                disableMouse = false,
            }, {},{},{}, function()
                QBCore.Functions.Notify("Explosion à l'appuis", "error")                 
                armedVeh = veh                                 
                Attente6(armedVeh, vPlate)                              
                ClearPedTasks(ped)
                TriggerServerEvent('Remove_Qb-Carbomb:FromInventory6')
                TriggerServerEvent('AddArmedV',vPlate, bombType, 1)
            end, function()
                QBCore.Functions.Notify("Processus Annulé", "error")                      
                ClearPedTasks(ped)
            end)
            else
                QBCore.Functions.Notify("Annulé...", "error")
            end            
        else 
            QBCore.Functions.Notify("Pas de véhicule Proche ...", "error")
        end        
    else
        QBCore.Functions.Notify("Sortez du véhicule ...", "error")
    end    

end)


function Attente6(armedVeh, vPlate,bombType)
    while armedVeh do 
        -- TriggerServerEvent('CheckArmedV',vPlate,bombType,1)            
        Citizen.Wait(0)
        -- if result then
            if armedVeh then                
                if IsControlJustReleased(0, Config.TriggerKey) then
                    print('press')
                    DetonateVehicle(armedVeh)                    
                    TriggerServerEvent('UpdateBombStatut',vPlate,bombType,2)
                    armedVeh = nil
                end
            end
        -- else
            -- armedVeh = nil
        -- end
    end
end


-- Detonation du véhicule --
function DetonateVehicle(veh)
    local vCoords = GetEntityCoords(veh)
    if DoesEntityExist(veh) then
        armedVeh = nil        
        AddExplosion(vCoords.x, vCoords.y, vCoords.z, 5, 50.0, true, false, true)
    end
end


-- Animation --
function PlayAnim()
    local ped = PlayerPedId()
    local anim = "weed_spraybottle_crouch_base_inspector"    
    LoadAnim('anim@amb@business@weed@weed_inspecting_lo_med_hi@')
    TaskPlayAnim(ped, 'anim@amb@business@weed@weed_inspecting_lo_med_hi@',anim,3.0, 1.0, -1, 0, 1, 0, 0, 0)
end

function LoadAnim(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(1)
    end
end