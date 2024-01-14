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

----- Police ----

-- Détecteur de bombe
QBCore.Functions.CreateUseableItem("scanner_tool", function(source)    
    TriggerClientEvent("QbCarbomb:client:PoliceScanner",source, "scanner_tool")
    local Player = QBCore.Functions.GetPlayer(source)       
end)

-- Désamorçage de bombe
QBCore.Functions.CreateUseableItem("diffuser", function(source)    
    TriggerClientEvent("QbCarbomb:client:PoliceDiffuser",source, "diffuser")
    local Player = QBCore.Functions.GetPlayer(source)
end)

-- Demontage de bombe
QBCore.Functions.CreateUseableItem("kit_demontage", function(source)    
    TriggerClientEvent("QbCarbomb:client:Demontage",source, "kit_demontage")
    local Player = QBCore.Functions.GetPlayer(source)
end)

-- Bombe d'entrainement
QBCore.Functions.CreateUseableItem("training_bomb", function(source)    
    TriggerClientEvent("QbCarbomb:client:Pose",source, "training_bomb")
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.RemoveItem('training_bomb', 1)
end)