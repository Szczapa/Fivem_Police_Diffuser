local QBCore = exports['qb-core']:GetCoreObject()

------------------
-- Requête LSPD --
------------------

RegisterServerEvent('AddArmedV')
AddEventHandler('AddArmedV', function(vPlate,bombType,bombStatut)
    MySQL.insert('INSERT INTO vehicule_armed (plate, bombType, bombStatut) VALUES (?,?,?)', {vPlate,bombType,bombStatut}, function(affectRow)
    if affectRow then
        print('insert')
    end
   end)    
end)

RegisterServerEvent('RemoveBomb')
AddEventHandler('RemoveBomb', function(vPlate)
   MySQL.Async.update('DELETE FROM vehicule_armed  WHERE plate = ? And bombStatut = 3 OR bombStatut = 2', {vPlate}, function(affectRow)
    if affectRow then
        print('Delete')
    end
   end)
end)

RegisterServerEvent('DiffuseArmedV')
AddEventHandler('DiffuseArmedV', function(vPlate)
   MySQL.Async.update('UPDATE vehicule_armed SET bombStatut = 3 WHERE plate = ? And bombStatut = 1', {vPlate}, function(affectRow)
    if affectRow then
        print('Update')
    end
   end)
end)

RegisterServerEvent('ExploseBomb')
AddEventHandler('ExploseBomb', function(vPlate)
   MySQL.Async.update('UPDATE vehicule_armed SET bombStatut = 2 WHERE plate = ? And bombStatut = 1', {vPlate}, function(affectRow)
    if affectRow then
        print('Update explose')
    end
   end)
end)

--------------------
-- Requete Police --
--------------------

QBCore.Functions.CreateCallback('CheckIfBomb', function(source, cb)
 MySQL.Query('SELECT * FROM vehicule_armed WHERE plate = ?', {vPlate}, function(IsBomb)
        if IsBomb then
        cb (true)
        else
        cb (false)
        end
    end)
end)

QBCore.Functions.CreateCallback('CheckIfArmed', function(source, cb)
 MySQL.Query('SELECT * FROM vehicule_armed WHERE plate = ? AND bombStatut = 1', {vPlate}, function(IsBomb)
        if IsBomb then
        cb (true)
        else
        cb (false)
        end
    end)
end)

