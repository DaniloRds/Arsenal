local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

src = {}
Tunnel.bindInterface(GetCurrentResourceName(), src)

vSERVER = Tunnel.getInterface(GetCurrentResourceName())

local Config = module(GetCurrentResourceName(),"config")

local menuactive = false
function ToggleActionMenu()
    menuactive = not menuactive
	
    if menuactive then
        SetNuiFocus(true,true)
        SendNUIMessage({arsenal = true})
    else
        SetNuiFocus(false)
        SendNUIMessage({arsenal = false})
    end
end


local markers = Config.Coords

RegisterNUICallback("buy",function(data,cb)
	if data.name then
		vSERVER.buy(data.name)
	end
end)

RegisterNUICallback("guardar",function(data,cb)
	local ped = PlayerPedId()
	RemoveAllPedWeapons(ped,0)
	vSERVER.remEquip()
	TriggerEvent('Notify', 'sucesso', 'Você guardou suas armas.')
end)

RegisterNUICallback("colete",function(data,cb)
	local ped = PlayerPedId()
	vSERVER.coleteEquip()
	TriggerEvent('Notify', 'sucesso', 'Você equipou o colete.')
end)

RegisterNUICallback("guardarColete",function(data,cb)
	local ped = PlayerPedId()
	vSERVER.coleteRem()
	TriggerEvent('Notify', 'sucesso', 'Você guardou o colete.')
end)

RegisterNUICallback("fechar2", function(data)
	ToggleActionMenu()
end)

RegisterCommand('arsenal',function(source,args)
	for _,mark in pairs(markers) do
		local x,y,z = table.unpack(mark)
		local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),x,y,z,true)
		if distance <= 3.5 then
			if vSERVER.checkPermissao() then
				ToggleActionMenu()
			else
				TriggerEvent('Notify', 'negado', 'Você não tem permissão para acessar o arsenal.')
			end
		else
			TriggerEvent('Notify', 'importante', 'Você está longe do arsenal.')
		end
	end
end)

