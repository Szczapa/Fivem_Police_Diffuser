local QBCore = exports['qb-core']:GetCoreObject()

-- Bomb timer
QBCore.Functions.CreateUseableItem("bomb_timer", function(source)    
    local Player = QBCore.Functions.GetPlayer(source)    
    Player.Functions.RemoveItem("bomb_timer", 1, false)
    TriggerClientEvent("QbCarbomb:client:Pose",source, "bomb_timer")    
end)


-- Timer + sit
QBCore.Functions.CreateUseableItem("bomb_sittimer", function(source)    
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("QbCarbomb:client:Pose",source, "bomb_sittimer")    
    Player.Functions.RemoveItem('bomb_sittimer', 1)
end)

-- Speed 
QBCore.Functions.CreateUseableItem("bomb_speed", function(source)    
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.RemoveItem('bomb_speed', 1)
    TriggerClientEvent("QbCarbomb:client:Pose",source, "bomb_speed")
end)

--Under Speed
QBCore.Functions.CreateUseableItem("bomb_underspeed", function(source)    
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.RemoveItem('bomb_underspeed', 1)
    TriggerClientEvent("QbCarbomb:client:Pose",source, "bomb_underspeed")
end)
--open bomb
QBCore.Functions.CreateUseableItem("bomb_open", function(source)    
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.RemoveItem('bomb_open', 1)
    TriggerClientEvent("QbCarbomb:client:Pose",source, "bomb_open")
end)

-- Click
QBCore.Functions.CreateUseableItem("bomb_remote", function(source)    
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.RemoveItem('bomb_remote', 1)
    TriggerClientEvent("QbCarbomb:client:Pose",source,"bomb_remote")   
    
end)