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
          if #(coords - vCoords) < 3.0 and not IsPedInAnyVehicle(ped) then
            print('Clothest')            
            PlayAnim()
            QBCore.Functions.Progressbar('Armement', 'Armement', Config.TimeTakenToArm, false, true, {
                disableMovement = true,
                disableMouse = false,
            }, {},{},{}, function()
                if item == "bomb_remote" then
                  local bombType = 1
                  QBCore.Functions.Notify("Explosion à l'appuis", "error")                 
                  armedVeh = veh  
                  WaitClick (armedVeh,vPlate)                              
                  TriggerServerEvent('AddArmedV',vPlate, bombType, 1)
                  ClearPedTasks(ped)                
                elseif item == "bomb_open" then
                  local bombType = 2
                  QBCore.Functions.Notify("Explosion à l'ouverture", "error")                 
                  armedVeh = veh                 
                  WaitOpen(armedVeh)
                  TriggerServerEvent('AddArmedV',vPlate, bombType, 1)                              
                  ClearPedTasks(ped)
                elseif item == "bomb_underspeed" then
                  local bombType = 3
                  QBCore.Functions.Notify("Vitesse activation "..Config.minSpeed .. "kmh", "error")                 
                  armedVeh = veh                 
                  WaitLockSpeed(armedVeh)
                  TriggerServerEvent('AddArmedV',vPlate, bombType, 1)                              
                  ClearPedTasks(ped)
                elseif item == "bomb_speed" then
                  local bombType = 4
                  QBCore.Functions.Notify("Vitesse pour explosion"..Config.maxSpeed, "error")                 
                  armedVeh = veh                 
                  WaitMaxSpeed(armedVeh)
                  TriggerServerEvent('AddArmedV',vPlate, bombType, 1)                              
                  ClearPedTasks(ped)
                elseif item == "bombsittimer" then
                   local bombType = 5
                   TriggerServerEvent('AddArmedV',vPlate, bombType, 1)
                   print("inactif")
                elseif item == "bomb_timer" then
                   local bombType = 6
                  QBCore.Functions.Notify("Explosion dans: "..Config.TimeUntilDetonation.." Secondes", "error")                 
                  armedVeh = veh 
                  RunTimer(armedVeh)
                  TriggerServerEvent('AddArmedV',vPlate, bombType, 1)                 
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