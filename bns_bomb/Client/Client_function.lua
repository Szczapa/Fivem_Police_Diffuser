local QBCore = exports['qb-core']:GetCoreObject()

-- Detonation du véhicule --
function DetonateVehicle(veh)
    local vCoords = GetEntityCoords(veh)
    if DoesEntityExist(veh) then
        -- TriggerEvent('ExplosionAlerte',source,vCoords)
        armedVeh = nil        
        AddExplosion(vCoords.x, vCoords.y, vCoords.z, 5, 50.0, true, false, true)        
    end
end

RegisterNetEvent('RandomAlerte',function(source,vPlate,vCoords)
    local random = math.random(1, 100) -- Génère un nombre entre 1 et 100
    if random <= config.alert then
        print('alerte send')
        exports["ps-dispatch"]:CustomAlert({
            coords = vector3(vCoords.x, vCoords.y, vCoords.z),
            message = "Véhicule Suspect",
            dispatchCode = "10-4 On the way",
            description = "Véhicule suspect ! " ..vPlate,
            radius = 0,
            sprite = 822,
            color = 3,
            scale = 1.0,
            length = 3,
        })        
    else
        print('pas send')
        return
    end
end)

function WaitClick(source,veh,vPlate)
    local vPlate = vPlate
    local armedVeh = veh
    Citizen.CreateThread(function()
        while armedVeh do 
            Citizen.Wait(10)
            if armedVeh then
                if IsControlJustReleased(0, Config.TriggerKey) then
                    QBCore.Functions.TriggerCallback('CheckStatus', function(cb)
                        if cb ~= nil then
                            DetonateVehicle(armedVeh)
                            TriggerServerEvent('ExploseStatus',vPlate)                        
                            armedVeh = nil
                         else
                            QBCore.Functions.Notify("Système Désactivé", "error")
                            armedVeh = nil
                         end
                    end, vPlate)
                end
            end       
        end
    end)
end


function WaitOpen(source,veh,vPlate)
    local random = math.random(1, 100)
    if random < 15 then
        local Player = PlayerPedId(source)
        QBCore.Functions.Notify("Alerte : Intégrité du véhicule compromise", "error")
    end
   local armedVeh = veh    
   while armedVeh do           
        Citizen.Wait(0)
        --print(armdeVeh)
        if armedVeh then
            if not IsVehicleSeatFree(armedVeh, -1)  then
                --print('notfree-1')
                QBCore.Functions.TriggerCallback('CheckStatus', function(cb) 
                    if cb ~= nil then              
                    DetonateVehicle(veh)
                    armedVeh = nil
                    else 
                        QBCore.Functions.Notify("Système Désactivé", "error")
                        armedVeh = nil
                     end
                end, vPlate)                
            elseif not IsVehicleSeatFree(armedVeh, 0) then 
                --print('notfree 0')
                QBCore.Functions.TriggerCallback('CheckStatus', function(cb) 
                    if cb ~= nil then        
                        DetonateVehicle(veh)
                        TriggerServerEvent('ExploseStatus',vPlate)
                        armedVeh = nil
                    else
                        QBCore.Functions.Notify("Système Désactivé", "error")
                        armedVeh = nil
                     end
                end, vPlate) 
            end
        end
    end
end

function RunTimer(source, veh, vPlate)
    local armedVeh = veh
    local timer = Config.TimeUntilDetonation    
    Citizen.CreateThread(function()        
        while timer > 0 do
            timer = timer - 1           
            Citizen.Wait(1000)
        end
        
        QBCore.Functions.TriggerCallback('CheckStatus', function(cb) 
            if cb ~= nil then 
                DetonateVehicle(armedVeh)
                TriggerServerEvent('ExploseStatus', vPlate)
                armedVeh = nil
            else
                QBCore.Functions.Notify("Système Désactivé", "error")
                armedVeh = nil
            end
        end, vPlate) 
    end)
end


function RunTraining(source, veh, vPlate)
    local armedVeh = veh
    local timer = Config.TimeUntilDetonation    
    Citizen.CreateThread(function()
        while timer > 0 do
            timer = timer - 1            
            Citizen.Wait(1000)
        end        
        QBCore.Functions.TriggerCallback('CheckStatus', function(cb)
            if cb ~= nil then 
                QBCore.Functions.Notify("Explosion de l'engin", "error")
                TriggerServerEvent('ExploseStatus', vPlate)
                armedVeh = nil
            else
                QBCore.Functions.Notify("Système Désactivé", "error")
                armedVeh = nil
            end
        end, vPlate) 
    end)
end


function WaitMaxSpeed(source,veh,vPlate)
        local random = math.random(1, 100)
    if random < 15 then
        local Player = PlayerPedId(source)
        QBCore.Functions.Notify("Alerte : Intégrité du véhicule compromise", "error")
    end
    local armedVeh = veh    
    while armedVeh do  
        Citizen.Wait(5)
        if  armedVeh then
            local speed = GetEntitySpeed(armedVeh)
            local SpeedKMH = speed * 3.6
            if SpeedKMH >= Config.maxSpeed then
                QBCore.Functions.TriggerCallback('CheckStatus', function(cb) 
                    if cb ~= nil then
                        DetonateVehicle(armedVeh)
                        TriggerServerEvent('ExploseStatus',vPlate)
                        armedVeh = nil
                    else
                        QBCore.Functions.Notify("Système Désactivé", "error")
                        armedVeh = nil
                    end
                end, vPlate) 
            end
        end
    end
end

function WaitLockSpeed(source,veh,vPlate)
    local armedVeh = veh
    local armed
        local random = math.random(1, 100)
    if random < 15 then
        local Player = PlayerPedId(source)
        QBCore.Functions.Notify("Alerte : Intégrité du véhicule compromise", "error")
    end

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
                QBCore.Functions.TriggerCallback('CheckStatus', function(cb) 
                    if cb ~= nil then
                        DetonateVehicle(armedVeh)
                        armed = nil
                        TriggerServerEvent('ExploseStatus',vPlate)
                        armedVeh = nil
                    else
                        QBCore.Functions.Notify("Système Désactivé", "error")
                         armedVeh = nil
                    end
                 end, vPlate)               
            end
        end
    end
end

Citizen.CreateThread(function()
    local prevVehicle = nil
    local prevSeat = nil
    local inVehicle = false

    while true do
        Citizen.Wait(500) -- Vérifie l'état du joueur toutes les 500 ms
        local playerPed = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        local vPlate = QBCore.Functions.GetPlate(vehicle)
        if vehicle ~= 0 then
            local seat = GetPedInVehicleSeat(vehicle, playerPed)

            if (vehicle ~= prevVehicle or seat ~= prevSeat) and not inVehicle and (seat == -1 or seat == 0) then
                prevSeat = seat
                CheckPlayerEnter(vehicle,vPlate) -- Appelle la fonction CheckPlayerEnter
                inVehicle = true
            elseif seat ~= -1 and seat ~= 0 then
                inVehicle = false
            end
        else
            inVehicle = false
        end
        prevVehicle = vehicle
    end
end)


function CheckPlayerEnter(vehicle,vPlate)
    local Player = PlayerPedId()
    local veh = vehicle
    local vPlate = vPlate
    QBCore.Functions.TriggerCallback('CheckStatus', function(cb)
        if cb ~= nil then
            local status = cb.status
            local bombType = cb.bombType
            if status == 1 then
                if bombType == 2 then
                    WaitOpen(source, veh, vPlate)
                elseif bombType == 3 then
                    WaitLockSpeed(source, veh, vPlate)
                elseif bombType == 4 then
                    WaitMaxSpeed(source, veh, vPlate)
                elseif bombType == 5 then
                    -- Code pour le type de bombe 5                
                end           
            end
        else
            print("RAS")           
        end       
    end, vPlate)
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