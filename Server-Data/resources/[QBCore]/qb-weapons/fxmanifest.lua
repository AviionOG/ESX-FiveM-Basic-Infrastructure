fx_version "adamant"

game "gta5"

description 'QB:Weapons'

server_scripts {
    "config.lua",
    "server/main.lua",
}

client_scripts {
	"config.lua",
	"client/main.lua",
}

files {
    'weaponsnspistol.meta',
}

data_file 'WEAPONINFO_FILE_PATCH' 'weaponsnspistol.meta'