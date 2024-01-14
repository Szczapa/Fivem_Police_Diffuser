
-- RegisterServerEvent('Time')
-- AddEventHandler('Time', function(vPlate)
--     local timer = os.time() + Config.TimeUntilDetonation -- calcul du timestamp actuel + la durée Config.TimeUntilDetonation
--     MySQL.Async.execute('UPDATE vehicule_armed SET timer = ? WHERE plate = ?', {timer, vPlate}, function(affectRow)
--         if affectRow > 0 then -- vérifie que la ligne a été mise à jour avec succès
--             -- print('update timer')
--         end
--     end)
-- end)

-- RegisterServerEvent('ArmedStatus')
-- AddEventHandler('ArmedStatus', function(vPlate,bombType,bombStatut)
--     local timer = os.time() + Config.TimeUntilDetonation -- calcul du timestamp actuel + la durée Config.TimeUntilDetonation
--     MySQL.Async.fetchScalar('SELECT plate FROM vehicule_armed WHERE plate = ?',{vPlate},function(exist)
--     if exist then
--         return
--         -- print('exist')
--     else
--         MySQL.insert('INSERT INTO vehicule_armed (plate, bombType, bombStatut,timer) VALUES (?,?,?,?)', {vPlate,bombType,bombStatut,timer}, function(affectRow)
--             if affectRow then
--                 -- print('insert')
--             end
--            end) 
--         end
--     end)
      
-- end)

-- RegisterServerEvent('ExploseStatus')
-- AddEventHandler('ExploseStatus', function(vPlate)
--     MySQL.Async.execute('UPDATE vehicule_armed SET bombStatut = 2 WHERE plate = ? And bombStatut = 1', {vPlate}, function(affectRow)
--     if affectRow then
--         -- print('Update explose')
--     end
--    end)
-- end)

-- QBCore.Functions.CreateCallback('CheckStatus', function(source, cb, vPlate)    
--     MySQL.Async.fetchAll('SELECT bombStatut as bs, bombType as bt FROM vehicule_armed WHERE plate = ? AND bombStatut = 1', {vPlate}, function(results)
--         if results[1] ~= nil then        
--             local data = {
--                 status = results[1].bs,
--                 bombType = results[1].bt
--             }
--             cb(data)
--         else
--             cb(nil)           
--         end
--     end)
-- end)

-------------------

-- local QBCore = exports['qb-core']:GetCoreObject()

-- QBCore.Functions.CreateCallback('CheckRemainingTime', function(source, cb, vPlate)
--     MySQL.Async.fetchScalar('SELECT timer FROM vehicule_armed WHERE plate = ? AND bombStatut = 1', {vPlate}, function(timer)
--         if timer then
--             local remainingTime = timer - os.time() -- soustraire le timestamp stocké par l'heure actuelle pour obtenir le temps restant
--             if remainingTime < 0 then -- si le temps restant est inférieur à zéro, la bombe a déjà explosé
--                remainingTime = 0
--             end           
--             cb(remainingTime)
--         else
--             cb(0)
--         end
--     end)
-- end)


-- QBCore.Functions.CreateCallback('CheckIfBomb', function(source, cb, vPlate)
--    QBCore.Debug(vPlate)
--    MySQL.Async.fetchScalar('SELECT bombType FROM vehicule_armed WHERE plate = ? AND bombStatut = 1 OR bombStatut = 2 OR bombstatut = 3', {vPlate}, function(bombType)
--         if bombType then
--             QBCore.Debug(bombType)
--             cb(bombType)
--         else           
--             cb(nil)
--         end
--     end)
-- end)


-- RegisterNetEvent('CheckbombType',function(vPlate)
--     local Player = QBCore.Functions.GetPlayer(source)
--     MySQL.Async.fetchScalar('SELECT bombType FROM vehicule_armed WHERE plate = ? AND bombStatut = 2 OR bombstatut = 3', {vPlate}, function(bombType)
--        if bombType then            
--              if bombType == 1 then               
--                 Player.Functions.AddItem("bomb_remote",1, false)                
--             elseif bombType == 2 then
--                 Player.Functions.AddItem("bomb_open",1, false)
--             elseif bombType == 3 then
--                 Player.Functions.AddItem("bomb_underspeed",1, false)
--             elseif bombType == 4 then
--                 Player.Functions.AddItem("bomb_speed",1, false)
--             elseif bombType == 5 then
--                 Player.Functions.AddItem("bomb_sittimer",1, false)
--             elseif bombType == 6 then
--                 Player.Functions.AddItem("bomb_timer",1, false)
--             elseif bombType == 7 then
--                 Player.Functions.AddItem("training_bomb",1, false)      
--             end
--             TriggerEvent('RemoveBomb',vPlate)
--         else
--             return
--         end
--     end)
-- end)

-- RegisterServerEvent('RemoveBomb')
-- AddEventHandler('RemoveBomb', function(vPlate)
--    MySQL.Async.execute('DELETE FROM vehicule_armed  WHERE plate = ? And bombStatut = 3 OR bombStatut = 2', {vPlate}, function(affectRow)
--     if affectRow then
--         print('Delete')
--     end
--    end)
-- end)

-- RegisterServerEvent('DiffuseStatus')
-- AddEventHandler('DiffuseStatus', function(vPlate)
--     print(vPlate)
--     MySQL.Async.execute('UPDATE vehicule_armed SET bombStatut = 3 WHERE plate = ? And bombStatut = 1', {vPlate}, function(affectRow)
--     if affectRow then
--         print('Update')
--     end
--    end)
-- end)