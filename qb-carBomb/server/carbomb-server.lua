local QBCore = exports['qb-core']:GetCoreObject()

 
QBCore.Functions.CreateUseableItem("bombtimer", function(source)    
    local Player = QBCore.Functions.GetPlayer(source)
     if Player.Functions.GetItemByName("bombtimer").amount > 0 then
        TriggerClientEvent('Qb-Carbomb:CheckRequirement', source)
     end
end)

RegisterServerEvent ('Remove_Qb-Carbomb:FromInventory')
AddEventHandler('Remove_Qb-Carbomb:FromInventory', function()
    local Player = QBCore.Functions.GetPlayer(source)

    if Player.Functions.GetItemByName("bombtimer").amount > 0 then 
        Player.Functions.RemoveItem('bombtimer', 1)
    end

end)

-- Timer + sit
QBCore.Functions.CreateUseableItem("bombsittimer", function(source)    
    local Player = QBCore.Functions.GetPlayer(source)
     if Player.Functions.GetItemByName("bombsittimer").amount > 0 then
        TriggerClientEvent('Qb-Carbomb:CheckRequirement2', source)
     end
end)

RegisterServerEvent ('Remove_Qb-Carbomb:FromInventory2')
AddEventHandler('Remove_Qb-Carbomb:FromInventory2', function()
    local Player = QBCore.Functions.GetPlayer(source)

    if Player.Functions.GetItemByName("bombsittimer").amount > 0 then 
        Player.Functions.RemoveItem('bombsittimer', 1)
    end
end)


-- Speed 
QBCore.Functions.CreateUseableItem("speedbomb", function(source)    
    local Player = QBCore.Functions.GetPlayer(source)
     if Player.Functions.GetItemByName("speedbomb").amount > 0 then
        TriggerClientEvent('Qb-Carbomb:CheckRequirement3', source)
     end
end)

RegisterServerEvent ('Remove_Qb-Carbomb:FromInventory3')
AddEventHandler('Remove_Qb-Carbomb:FromInventory3', function()
    local Player = QBCore.Functions.GetPlayer(source)

    if Player.Functions.GetItemByName("speedbomb").amount > 0 then 
        Player.Functions.RemoveItem('speedbomb', 1)
    end
end)

--Under Speed
QBCore.Functions.CreateUseableItem("underspeedbomb", function(source)    
    local Player = QBCore.Functions.GetPlayer(source)
     if Player.Functions.GetItemByName("underspeedbomb").amount > 0 then
        TriggerClientEvent('Qb-Carbomb:CheckRequirement4', source)
     end
end)
RegisterServerEvent ('Remove_Qb-Carbomb:FromInventory4')
AddEventHandler('Remove_Qb-Carbomb:FromInventory4', function()
    local Player = QBCore.Functions.GetPlayer(source)

    if Player.Functions.GetItemByName("underspeedbomb").amount > 0 then 
        Player.Functions.RemoveItem('underspeedbomb', 1)
    end
end)

--open bomb
QBCore.Functions.CreateUseableItem("openbomb", function(source)    
    local Player = QBCore.Functions.GetPlayer(source)
     if Player.Functions.GetItemByName("openbomb").amount > 0 then
        TriggerClientEvent('Qb-Carbomb:CheckRequirement5', source)
     end
end)
RegisterServerEvent ('Remove_Qb-Carbomb:FromInventory5')
AddEventHandler('Remove_Qb-Carbomb:FromInventory5', function()
    local Player = QBCore.Functions.GetPlayer(source)

    if Player.Functions.GetItemByName("openbomb").amount > 0 then 
        Player.Functions.RemoveItem('openbomb', 1)
    end
end)

-- Click
QBCore.Functions.CreateUseableItem("clickbomb", function(source)    
    local Player = QBCore.Functions.GetPlayer(source)
     if Player.Functions.GetItemByName("clickbomb").amount > 0 then
        print('0')
        TriggerClientEvent('Qb-Carbomb:CheckRequirement6', source)
     end
end)

RegisterServerEvent ('Remove_Qb-Carbomb:FromInventory6')
AddEventHandler('Remove_Qb-Carbomb:FromInventor6', function()
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemByName("clickbomb").amount > 0 then 
        Player.Functions.RemoveItem('clickbomb', 1)
    end
end)


RegisterServerEvent('AddArmedV')
AddEventHandler('AddArmedV', function(vPlate,bombType,bombStatut)
    MySQL.insert('INSERT INTO vehicule_armed (plate, bombType, bombStatut) VALUES (?,?,?)', {vPlate,bombType,bombStatut})
    print('insert')
end)

RegisterServerEvent('UpdateBombStatut')
AddEventHandler('UpdateBombStatut', function(vPlate,bombType,bombStatut)
    MySQL.update('UPDATE vehicule_armed  SET plate = ? , bombType = ?, bombStatut = ? WHERE plate = ?', {vPlate,bombType,bombStatut,vPlate})
    print('update')
end)



-- RegisterServerEvent('CheckArmedV', function(vPlate,bombType,bombStatut)
--     local result = MySQL.Sync.fetchScalar('SELECT plate FROM vehicule_armed WHERE plate = ? And bombType = ? AND bombStatut = ?', {vPlate,bombStatut,bombType})
--     print('result', result)
-- end)

-- RegisterServerEvent('CheckBombeType')
-- AddEventHandler('CheckBombeType', function(vPlate)
--     local bombT = MySQL.Sync.fetchScalar('SELECT bombType FROM vehicule_armed WHERE plate = ?', {vPlate})
--     return bombT
-- end)


RegisterServerEvent('DeleteArmedV')
AddEventHandler('DeleteArmedV',function(vPlate)
    MySQL.Async.execute('DELETE * vehicule_armed WHERE plate = ?) VALUES (?)',{vPlate})
end)

QBCore.Functions.CreateCallback("CheckArmedV", function(source, cb, vPlate)    
    MySQL.Sync.fetchScalar('SELECT plate FROM vehicule_armed WHERE plate = ? And bombType = ? AND bombStatut = ?', {vPlate,bombStatut,bombType}, function(result)
    if result[1] then
        cb(true)
    else
        cb(false)
    end
        
    end)
end)