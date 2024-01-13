-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADQUAKE
-----------------------------------------------------------------------------------------------------------------------------------------
if AutoQuake then
	CreateThread(function()
    	while true do
        	Wait(60000)
		
        	AutoQuake()
    	end
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- AUTOQUAKE
-----------------------------------------------------------------------------------------------------------------------------------------
function AutoQuake()
	if QuakeTimers[os.date("%H:%M")] then
		GlobalState["Weather"] = "THUNDER"
		GlobalState["Blackout"] = true
		TriggerClientEvent("Notify",-1,"roxo","Um grande terremoto se aproxima, abriguem-se enquanto há tempo pois o terremoto chegará em 5 minutos.",false,60000)
		print("Terremoto Automático Anunciado")

		Wait(300000)

		local List = vRP.Players()
		for _,Sources in pairs(List) do
			vRP.Kick(Sources,"Desconectado, a cidade reiniciou.")
			Wait(100)
		end

		TriggerEvent("SaveServer",false)

		Wait(30000)

		os.execute("start \"\" \"G:\\Development\\Github2\\alternative-server\\server\\server.bat\"")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GENERATECHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.GenerateChest(Passport,Item,Amount,Slot)
	local Number = vRP.GenerateString("DDDD0000")
	local Datatable = vRP.Query("entitydata/GetData",{ dkey = Item..":"..Number })
	if Datatable[1] then
		return
	else
		vRP.GiveItem(Passport,Item.."-"..os.time().."-"..Number,Amount,false,Slot)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ONRESOURCESTART
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("onResourceStart",function(Resource)
    if "vrp" == Resource then
        Wait(3000)
		if AutoQuake then
        	exports["vrp"]:Embed("Admin","***Cidade Online***\n\n***Quer conectar mais rápido?***\n *Use: "..ServerConnect.."*",0x2b2d31)
		end	
	end
end)