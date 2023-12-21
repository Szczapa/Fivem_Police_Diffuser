fx_version 'cerulean'
game 'gta5'

description 'QB-CarBomb'
version '1.0.0'

shared_script 'Config.lua'

client_scripts {
    'Client/bomb.lua',
    'Client/Client_function.lua' 
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',    
    'Server/Query.lua',
    'Server/Usable_item.lua',
} 

lua54 'yes'