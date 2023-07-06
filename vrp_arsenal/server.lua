local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

vRPclient = Tunnel.getInterface("vRP")

src = {}
Tunnel.bindInterface(GetCurrentResourceName(),src)

local Config = module(GetCurrentResourceName(),"config")

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

--

local items = {
    ["desert"]  = "WEAPON_HEAVYPISTOL",
    ["glock"]  = "weapon_combatpistol",
    ["mpx"] = "weapon_carbinerifle_mk2",
    ["scar"] = "weapon_carbinerifle",
    ["sig"] = "weapon_combatpdw",
    ["shotgun"] = "weapon_pumpshotgun_mk2",
    ["taser"] = "weapon_stungun",
}

-- [FUNÇÕES] --

function src.checkPermissao() -- MUDE AQUI A PERMISSÃO
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,Config.Permission) then
        return true
    else
        TriggerClientEvent('Notify',source,'aviso','aviso','Você não possui permissão.')
        return false
    end
end

function src.buy(name)
    local source = source
	local user_id = vRP.getUserId(source)
    local time = false
    if user_id then
        if name ~= "kit" then
            TriggerClientEvent("Notify", source, "sucesso","Você equipou 1x <b>"..name.."</b>")
            vRPclient.giveWeapons(source,{[items[name]] = { ammo = Config.Ammo }})
            SendWebhookMessage(Config.webhookArmas, "```\nARMAS\n[ID]: "..user_id.." \n[PEGOU X1]: "..name.." ```")
        else
            TriggerClientEvent("Notify", source, "sucesso","Você pegou um <b>Kit</b>")
            SendWebhookMessage(Config.webhookKit, "```\nKIT BÁSICO \nID: ["..user_id.."] - PEGOU 1x KIT```")
            time = true
            -- ITENS QUE VEM NO KIT
            vRP.giveInventoryItem(user_id,"radio",1)
            vRP.giveInventoryItem(user_id,"bandagem",3)
            vRP.giveInventoryItem(user_id,"energetico",5)

        end
        
    end
end

function src.remEquip()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRPclient._replaceWeapons(source,{["WEAPON_UNARMED"] = { ammo = 0 }})
	end
end

function src.coleteEquip()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRPclient.setArmour(source,100)
		return true
	end
end

function src.coleteRem()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRPclient.setArmour(source,0)
		return true
	end
end

