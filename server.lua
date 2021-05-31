local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) 
    ESX = obj 
end)

ESX.RegisterServerCallback("feril-alert:fetchUserRank", function(source, cb)
    local player = ESX.GetPlayerFromId(source)

    if player ~= nil then
        local playerGroup = player.getGroup()

        if playerGroup ~= nil then 
            cb(playerGroup)
        else
            cb("user")
        end
    else
        cb("user")
    end
end)

local function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end
RegisterServerEvent("alert:sv")
AddEventHandler("alert:sv", function (msg, msg2)
local player = GetPlayerName(source)
			TriggerClientEvent("SendAlert", -1, msg, msg2)
			print('^1Sunucu Duyurusu: ^9' .. msg2 .. ' ^6Yetkili:^2 ' .. player .. '^0')
			PerformHttpRequest(Config.Webhook, 
			function(err, msg2, player) end, 
			'POST', 
			--json.encode({username = player, content = '```fix\nDuyuru: \n' .. msg2 .. '```', avatar_url=Config.Resim }), {['Content-Type'] = 'application/json'}) 
			json.encode({username = player, avatar_url= Config.resim, embeds = {
				{
					["color"] = "1127128",
					["title"] = 'Duyuru',
					["description"] = '**Yetkili: ** '.. player ..' \n **Mesaj: **'  .. msg2 
				}
				}}), { ['Content-Type'] = 'application/json' })
		end)

AddEventHandler('chatMessage', function(source, name, msg, msg2)
		local command = stringsplit(msg, " ")[1];
		if command == "/alert" then
		CancelEvent()
		TriggerClientEvent("alert:Send", source, string.sub(msg, 8), Config.FRL.Departments)
		end
end)
