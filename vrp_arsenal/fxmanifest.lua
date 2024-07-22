fx_version "bodacious"
game "gta5"
description 'Edited By Unity FiveM | discord.gg/pbT5wVp8e9'
-- Versão 1.0.1

ui_page "web/index.html"
ui_page_preload 'yes'

files {
    "web/style.css",
    "web/index.html",
    "web/script.js"
}

client_scripts {
	"@vrp/lib/utils.lua",
	"client.lua",
	"config.lua"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"server.lua",
	"config.lua"
}                             