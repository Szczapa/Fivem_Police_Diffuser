local QBCore = exports['qb-core']:GetCoreObject()


RegisterServerEvent('Time')
AddEventHandler('Time', function(vPlate)
    local timer = os.time() + Config.TimeUntilDetonation -- calcul du timestamp actuel + la durée Config.TimeUntilDetonation
    MySQL.Async.execute('UPDATE vehicule_armed SET timer = ? WHERE plate = ?', {timer, vPlate}, function(affectRow)
        if affectRow > 0 then -- vérifie que la ligne a été mise à jour avec succès
            -- print('update timer')
        end
    end)
end)



RegisterServerEvent('AddArmedV')
AddEventHandler('AddArmedV', function(vPlate,bombType,bombStatut)
    local timer = os.time() + Config.TimeUntilDetonation -- calcul du timestamp actuel + la durée Config.TimeUntilDetonation
    MySQL.Async.fetchScalar('SELECT plate FROM vehicule_armed WHERE plate = ?',{vPlate},function(exist)
    if exist then
        return
        -- print('exist')
    else
        MySQL.insert('INSERT INTO vehicule_armed (plate, bombType, bombStatut,timer) VALUES (?,?,?,?)', {vPlate,bombType,bombStatut,timer}, function(affectRow)
            if affectRow then
                -- print('insert')
            end
           end) 
        end
    end)
      
end)


RegisterServerEvent('ExploseBomb')
AddEventHandler('ExploseBomb', function(vPlate)
    MySQL.Async.execute('UPDATE vehicule_armed SET bombStatut = 2 WHERE plate = ? And bombStatut = 1', {vPlate}, function(affectRow)
    if affectRow then
        -- print('Update explose')
    end
   end)
end)

QBCore.Functions.CreateCallback('CheckIfArmed', function(source, cb, vPlate)    
    MySQL.Async.fetchAll('SELECT bombStatut as bs, bombType as bt FROM vehicule_armed WHERE plate = ? AND bombStatut = 1', {vPlate}, function(results)
        if results[1] ~= nil then        
            local data = {
                status = results[1].bs,
                bombType = results[1].bt
            }
            cb(data)
        else
            cb(nil)           
        end
    end)
end)


