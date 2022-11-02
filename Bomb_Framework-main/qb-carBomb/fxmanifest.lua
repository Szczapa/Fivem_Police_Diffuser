fx_version 'cerulean'
game 'gta5'

description 'QB-CarBomb'
version '1.0.0'

shared_script 'carbomb-config.lua'

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/carbomb-server.lua'
} 

client_scripts {
    'client/carbomb-Sit.lua',
    'client/carbomb-Timer.lua',
    'client/carbomb-Speed.lua',
    'client/carbomb-UnderSpeed.lua',
    'client/carbomb-Open.lua',
    'client/carbomb-Click.lua'
}

lua54 'yes'