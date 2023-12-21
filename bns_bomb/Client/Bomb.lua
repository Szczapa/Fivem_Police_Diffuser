local QBCore = exports['qb-core']:GetCoreObject()

local armedVeh
local ped = PlayerPedId()
local coords = GetEntityCoords(ped)

RegisterNetEvent("QbCarbomb:client:Pose",function(item) 
  local veh = QBCore.Functions.GetClosestVehicle()
  local item = item
  if not IsPedInAnyVehicle(ped) then
     if veh then      
         local ped = PlayerPedId()
         local coords = GetEntityCoords(ped)
         local vCoords = GetEntityCoords(veh)
         local vPlate = QBCore.Functions.GetPlate(veh)
         local armedVeh = veh
          if #(coords - vCoords) < 3.0 and not IsPedInAnyVehicle(ped) then          
            PlayAnim()
            QBCore.Functions.Progressbar('Armement', 'Armement', Config.TimeTakenToArm, false, true, {
                disableMovement = true,
                disableMouse = false,
            }, {},{},{}, function()
                if item == "bomb_remote" then
                  local bombType = 1
                  QBCore.Functions.Notify("Explosion à l'appuis", "error") 
                  TriggerServerEvent('AddArmedV',vPlate, bombType, 1)
                  TriggerEvent('RandomAlerte',source,vPlate,vCoords)                              
                  WaitClick (source,armedVeh,vPlate)
                  ClearPedTasks(ped)                
                elseif item == "bomb_open" then
                  local bombType = 2
                  QBCore.Functions.Notify("Explosion à l'ouverture", "error")                
                  TriggerServerEvent('AddArmedV',vPlate, bombType, 1)                              
                  TriggerEvent('RandomAlerte',source,vPlate,vCoords)
                  -- WaitOpen(source,armedVeh,vPlate)
                  ClearPedTasks(ped)
                elseif item == "bomb_underspeed" then
                  local bombType = 3
                  QBCore.Functions.Notify("Vitesse activation "..Config.minSpeed .. "kmh", "error")                 
                  TriggerServerEvent('AddArmedV',vPlate, bombType, 1)                              
                  TriggerEvent('RandomAlerte',source,vPlate,vCoords)
                  -- WaitLockSpeed(source,armedVeh,vPlate)
                  ClearPedTasks(ped)
                elseif item == "bomb_speed" then
                  local bombType = 4
                  QBCore.Functions.Notify("Vitesse nécessaire pour explosion "..Config.maxSpeed.."kmh", "error")                 
                  TriggerServerEvent('AddArmedV',vPlate, bombType, 1)                              
                  TriggerEvent('RandomAlerte',source,vPlate,vCoords)
                  -- WaitMaxSpeed(source,armedVeh,vPlate)
                  ClearPedTasks(ped)
                elseif item == "bomb_sittimer" then
                   --local bombType = 5
                   --TriggerServerEvent('AddArmedV',vPlate, bombType, 1)
                   --TriggerServerEvent('RandomAlerte',source,vPlate)
                   print("inactif")
                elseif item == "bomb_timer" then
                   local bombType = 6
                  QBCore.Functions.Notify("Explosion dans: "..Config.TimeUntilDetonation.." Secondes", "error")                 
                  TriggerServerEvent('AddArmedV',vPlate, bombType, 1)                 
                  TriggerEvent('RandomAlerte',source,vPlate,vCoords)
                  RunTimer(source,armedVeh,vPlate)
                  ClearPedTasks(ped)                               
                elseif item == "training_bomb" then
                   local bombType = 7
                  QBCore.Functions.Notify("Explosion dans: "..Config.TimeUntilDetonation.." Secondes", "error")                 
                  TriggerServerEvent('AddArmedV',vPlate, bombType, 1)                 
                  TriggerEvent('RandomAlerte',source,vPlate,vCoords)
                  RunTraining(source,armedVeh,vPlate)
                  ClearPedTasks(ped)
                end                
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