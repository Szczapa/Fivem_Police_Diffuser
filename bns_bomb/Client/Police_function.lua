local QBCore = exports['qb-core']:GetCoreObject()
local IsBomb = false

function OnDiffuseDone(success)

  TriggerEvent('mhacking:hide')
  if not success then return end
  TriggerEvent('DiffuserArmedV',source)
end

RegisterNetEvent('DiffuserArmedV',function(source)
  local veh = QBCore.Functions.GetClosestVehicle()
  local ped = PlayerPedId()
  local coords = GetEntityCoords(ped)
  local vCoords = GetEntityCoords(veh)
  local vPlate = QBCore.Functions.GetPlate(veh)
  print(vPlate,'police_f')
  TriggerServerEvent('DiffuseArmedV',vPlate)

end)

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
                if cb ~= nil then
                    if cb ==1 then
                      QBCore.Functions.Notify("Bombe télécommandé détecté", "error")
                    elseif cb == 2 then
                      QBCore.Functions.Notify("Bombe à ouverture détecté", "error")
                    elseif cb == 3 then
                      QBCore.Functions.Notify("Bombe verrouillage vitesse détecté", "error")
                    elseif cb == 4 then
                      QBCore.Functions.Notify("Bombe accéléromètre détecté", "error")
                    elseif cb ==5 then
                      QBCore.Functions.Notify("bomb présence + timer détecté", "error")
                    elseif cb == 6 then                      
                      QBCore.Functions.TriggerCallback('CheckTime', function(cb)
                        QBCore.Functions.Notify("Bombe à Timer détecté "..cb.." Secondes Restantes", "error")
                      end, vPlate)
                    elseif cb == 7 then                      
                      QBCore.Functions.TriggerCallback('CheckTime', function(cb)                        
                        QBCore.Functions.Notify("Engin Factice détecté "..cb.." Secondes Restantes", "error")                        
                      end, vPlate)
                    end
                    QBCore.Functions.TriggerCallback('CheckIfArmed', function(cb)
                      if cb ~= nil then                
                        QBCore.Functions.Notify("Engin armée", "error")
                      else
                          QBCore.Functions.Notify("Engin inactif", "error")
                      end
                  end, vPlate)
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

RegisterNetEvent('QbCarbomb:client:PoliceDiffuser',function()
     local veh = QBCore.Functions.GetClosestVehicle()
      if not IsPedInAnyVehicle(ped) then
        if veh then
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            local vCoords = GetEntityCoords(veh)
            local vPlate = QBCore.Functions.GetPlate(veh)
          if #(coords - vCoords) < 3.0 and not IsPedInAnyVehicle(ped) then        
             PlayAnim()
              QBCore.Functions.Progressbar('Désamorsage', 'Désamorsage', Config.TimeToCheck, false, true, {
                disableMovement = true,
                disableMouse = false,
            }, {},{},{}, function()  

            QBCore.Functions.TriggerCallback('CheckIfArmed', function(cb)
                if cb ~= nil then                
                    TriggerEvent("mhacking:show")
                    TriggerEvent("mhacking:start", 8, 15, OnDiffuseDone)
                else
                    QBCore.Functions.Notify("Engin inactif", "error")
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

RegisterNetEvent('QbCarbomb:client:Demontage',function()
     local veh = QBCore.Functions.GetClosestVehicle()
      if not IsPedInAnyVehicle(ped) then
        if veh then
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            local vCoords = GetEntityCoords(veh)
            local vPlate = QBCore.Functions.GetPlate(veh)
          if #(coords - vCoords) < 3.0 and not IsPedInAnyVehicle(ped) then        
             PlayAnim()
              QBCore.Functions.Progressbar('Récupération', 'Récupération', Config.TimeToCheck, false, true, {
                disableMovement = true,
                disableMouse = false,
            }, {},{},{}, function()
              QBCore.Functions.TriggerCallback('CheckIfArmed', function(cb)
                if cb ~= nil then                                 
                  QBCore.Functions.Notify("Engin armée récupération impossible", "error")
                else
                  TriggerServerEvent('CheckbombType',vPlate) 
                    QBCore.Functions.Notify("Engin Récupéré", "success")
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

