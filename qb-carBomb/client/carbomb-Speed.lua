local QBCore = exports['qb-core']:GetCoreObject()

local timer = 0
local armedVeh
local ped = PlayerPedId()
local coords = GetEntityCoords(ped)

RegisterNetEvent('Qb-Carbomb:CheckRequirement3')
AddEventHandler('Qb-Carbomb:CheckRequirement3', function()
    
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
                QBCore.Functions.Notify("Vitesse pour explosion"..Config.maxSpeed, "error")                 
                armedVeh = veh                 
                Attente(armedVeh)                              
                ClearPedTasks(ped)
                TriggerServerEvent('Remove_Qb-Carbomb:FromInventory3')
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

function Attente(armedVeh)
    while armedVeh do 
        print("ui")
        Citizen.Wait(0)
        if  armedVeh then
            local speed = GetEntitySpeed(armedVeh)
            local SpeedKMH = speed * 3.6
            if SpeedKMH >= Config.maxSpeed then
                DetonateVehicle(armedVeh)
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