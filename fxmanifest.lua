fx_version 'cerulean'
game 'gta5'
lua54 'yes'

description 'Desync Spawn Selection'
version '1.0.0'

shared_scripts {
    'config.lua',
    '@ox_lib/init.lua',
}

client_script 'client.lua'

server_script 'server.lua'

ui_page 'web/build/index.html'

files {
    'web/build/index.html',
    'web/build/**/*'
}