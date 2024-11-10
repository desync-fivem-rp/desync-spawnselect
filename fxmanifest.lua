-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
fx_version 'cerulean'
game 'gta5'
lua54 'yes'

description 'BreN Laptop'
author 'BreN#0001'
version '1.0.0'

shared_scripts {
  'config.lua',
  '@ox_lib/init.lua'
}

client_scripts {
  'client.lua'
}

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  'server.lua'
}

ui_page('html/index.html')

files {
  'html/index.html',
  'html/style.css',
  'html/script.js'
}