local QBCore = exports['qb-core']:GetCoreObject()

local ped = PlayerPedId()
local coords = GetEntityCoords(ped)
local bombFound = false
local TypeBombe

local checkVeh = QBCore.Functions.GetClosestVehicle()
 
 -- Function de check de bomb 

    if not IsPedInAnyVehicle(ped) then
        if checkVeh then            
            local checkCoords = GetEntityCoords(checkVeh)       
            local checkPlate = QBCore.Functions.GetPlate(checkVeh)
            TriggerServerEvent('CheckBombeType',checkPlate)    

            if bombT then
                bomb = true
                TypeBombe = bombT
                AlerteTypeB(TypeBombe)                
            else 
                -- Aucun explosif de détecté 
            end 
        end
    else
        -- Sortez du véhicule pour scanner 
    end

-- Function de désamorçage 

    if bomb = true then
        -- Trigger du jeu de désamorçage
        
        -- Si jeu réussi -> DeletArmedV        
        -- else nouvelle change
        -- end
    end


    function AlerteTypeB(TypeBombe)
        if 1 then
        end
        if 2 then
        end
        if 3 then
        end
        if 4 then
        end
        if 5 then
        end
    end