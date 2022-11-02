local QBCore = exports['qb-core']:GetCoreObject()
local IsBomb = false

RegisterNetEvent('QbCarbomb:client:PoliceScanner',function()
     local veh = QBCore.Functions.GetClosestVehicle()
      if not IsPedInAnyVehicle(ped) then
        if veh then
             local ped = PlayerPedId()
             local coords = GetEntityCoords(ped)
             local vCoords = GetEntityCoords(veh)
              local vPlate = QBCore.Functions.GetPlate(veh)
          if #(coords - vCoords) < 3.0 and not IsPedInAnyVehicle(ped) then        
             PlayAnim()
              QBCore.Functions.Progressbar('Vérification', 'Vérification', Config.TimeToCheck, false, true, {
                disableMovement = true,
                disableMouse = false,
            }, {},{},{}, function()  

            QBCore.Functions.TriggerCallback('CheckIfBomb', function(cb)
                isBomb = cb
                if isBomb then
                    QBCore.Functions.Notify("Engin détecté", "error")
                else
                    QBCore.Functions.Notify("Aucun engin détecté", "error")
                end
            end, vPlate)

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

