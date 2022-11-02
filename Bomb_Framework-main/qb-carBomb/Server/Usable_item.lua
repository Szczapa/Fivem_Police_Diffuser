local QBCore = exports['qb-core']:GetCoreObject()

-- Bomb timer
QBCore.Functions.CreateUseableItem("bomb_timer", function(source)    
    local Player = QBCore.Functions.GetPlayer(source)    
        Player.Functions.RemoveItem("bomb_timer", 1, false)
        TriggerClientEvent("QbCarbomb:client:Pose", "bomb_timer")    
end)


-- Timer + sit
QBCore.Functions.CreateUseableItem("bombsittimer", function(source)    
    local Player = QBCore.Functions.GetPlayer(source)
         Player.Functions.RemoveItem('bomb_sittimer', 1)
        TriggerClientEvent("QbCarbomb:client:Pose", "bombsittimer")    
end)

-- Speed 
QBCore.Functions.CreateUseableItem("bomb_speed", function(source)    
    local Player = QBCore.Functions.GetPlayer(source)
         Player.Functions.RemoveItem('bomb_speed', 1)
        TriggerClientEvent("QbCarbomb:client:Pose", "bomb_speed")
end)

--Under Speed
QBCore.Functions.CreateUseableItem("bomb_underspeed", function(source)    
    local Player = QBCore.Functions.GetPlayer(source)
           Player.Functions.RemoveItem('bomb_underspeed', 1)
       TriggerClientEvent("QbCarbomb:client:Pose", "bomb_underspeed")
end)
--open bomb
QBCore.Functions.CreateUseableItem("bomb_open", function(source)    
    local Player = QBCore.Functions.GetPlayer(source)
        Player.Functions.RemoveItem('openbomb', 1)
        TriggerClientEvent("QbCarbomb:client:Pose", "bomb_open")
end)

-- Click
QBCore.Functions.CreateUseableItem("bomb_remote", function(source)    
    local Player = QBCore.Functions.GetPlayer(source)
       Player.Functions.RemoveItem('bomb_remote', 1)
       TriggerClientEvent("QbCarbomb:client:Pose", "bomb_remote")
end)


-- Détecteur de bombe
QBCore.Functions.CreateUseableItem("Scanner_tool", function(source)    
    local Player = QBCore.Functions.GetPlayer(source)       
       TriggerClientEvent("QbCarbomb:client:PoliceScanner", "Scanner_tool")
end)

-- Désamorçage de bombe
QBCore.Functions.CreateUseableItem("bomb_tool", function(source)    
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("QbCarbomb:client:PoliceDiffuser", "bomb_tools")
end)
