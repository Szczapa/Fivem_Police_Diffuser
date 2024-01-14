-- Définir le chemin du fichier JSON ici
filePath = './Vehicle_bomb.json'  -- Assurez-vous que cette variable ne soit pas en conflit avec d'autres variables globales

-- Fonction pour écrire dans le fichier JSON
function writeJsonFile(data)
    local file = io.open(filePath, 'w')
    if file then
        print('File write')
        file:write(json.encode(data))
        file:close()
    else
        print('File not found write')
    end
end

-- Fonction pour lire le fichier JSON
function readJsonFile()
    local file = io.open(filePath, 'r')
    if file then
        print('File read')
        local content = file:read('*a')
        file:close()
        content = json.decode(content)        
        if content == nil then
            return {}
        else
            return content
        end
    else
        print('File not found read')
        return {}  -- Retourne une table vide si le fichier n'existe pas
    end
end
