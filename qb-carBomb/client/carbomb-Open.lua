local QBCore = exports['qb-core']:GetCoreObject()

local timer = 0
local armedVeh
local ped = PlayerPedId()
local coords = GetEntityCoords(ped)

RegisterNetEvent('Qb-Carbomb:CheckRequirement5')
AddEventHandler('Qb-Carbomb:CheckRequirement5', function()
    
    local veh = QBCore.Functions.GetClosestVehicle()  
    if not IsPedInAnyVehicle(ped) then        
        if veh then
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            local vCoords = GetEntityCoords(veh)
            if #(coords - vCoords) < 3.0 and not IsPedInAnyVehicle(ped) then
            print('Clothest')            
            PlayAnim()
            QBCore.Functions.Progressbar('Armement', 'Armement', Config.TimeTakenToArm, false, true, {
                disableMovement = true,
                disableMouse = false,
            }, {},{},{}, function()
                QBCore.Functions.Notify("Explosion à l'ouverture", "error")                 
                armedVeh = veh                 
                Attente5(armedVeh)                              
                ClearPedTasks(ped)
                TriggerServerEvent('Remove_Qb-Carbomb:FromInventory5')
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


function Attente5(armedVeh)
    while armedVeh do       
        Citizen.Wait(0)
        if armedVeh then
            if not IsVehicleSeatFree(armedVeh, -1)  then               
                DetonateVehicle(veh)
                armedVeh = nil                
            elseif not IsVehicleSeatFree(armedVeh, 0) then   
                DetonateVehicle(veh)
                armedVeh = nil
            end
        end
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