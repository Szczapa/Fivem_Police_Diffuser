local QBCore = exports['qb-core']:GetCoreObject()

-- Detonation du véhicule --
function DetonateVehicle(veh)
    local vCoords = GetEntityCoords(veh)
    if DoesEntityExist(veh) then
        armedVeh = nil        
        AddExplosion(vCoords.x, vCoords.y, vCoords.z, 5, 50.0, true, false, true)        
    end
end

function WaitClick(armdeVeh,vPlate)
    local isArmed = false
    local vPlate = vPlate
    while armedVeh do
        Citizen.Wait(0)
        QBCore.Functions.TriggerCallback('CheckIfArmed', function(cb)
            isArmed = cb
            if isArmed then
                if armedVeh then                
                    if IsControlJustReleased(0, Config.TriggerKey) then
                        print('press')
                        DetonateVehicle(armedVeh)
                        TriggerServerEvent('ExploseBomb',vPlate)                        
                        armedVeh = nil
                     end
                end   
            else
                armedVeh = nil
            end
        end, Vplate)
    end
end

function WaitOpen(armdeVeh,Vplate)
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

function RunTimer(armedVeh)
    timer = Config.TimeUntilDetonation
    while timer > 0 do
        timer = timer - 1
        Citizen.Wait(1000)
        if timer == 0 then
            DetonateVehicle(armedVeh)
        end
    end
end

function WaitMaxSpeed()
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

function WaitLockSpeed(armedVeh)
    local armed
    while armedVeh do
        Citizen.Wait(0)
        if armedVeh and not armed then
            local speed = GetEntitySpeed(armedVeh)
            local SpeedKMH = speed * 3.6
            if SpeedKMH >= Config.maxSpeed then
                armed = true
                QBCore.Functions.Notify("système active  restez au dessus de " ..Config.minSpeed, "error")
            end        
        elseif armedVeh and armed then
            local speed = GetEntitySpeed(armedVeh)
            local SpeedKMH = speed * 3.6
            if SpeedKMH < Config.maxSpeed then                
                DetonateVehicle(armedVeh)
                armed = nil
                armedVeh = nil              
            end
        end
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