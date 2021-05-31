local ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) 
            ESX = obj 
        end)

        Citizen.Wait(0)
    end
end)
RegisterNetEvent("SendAlert")
AddEventHandler("SendAlert", function(msg, msg2)
    SendNUIMessage({
        type    = "alert",
        enable  = true,
        issuer  = msg,
        message = msg2,
        volume  = Config.FRL.Volume
    })
end)

RegisterNetEvent("alert:Send")
AddEventHandler("alert:Send", function(msg, departments, playerRank)
    ESX.TriggerServerCallback("feril-alert:fetchUserRank", function(playerRank)
    for i, v in pairs(departments) do
        if msg == i and playerRank == "admin" or playerRank == "superadmin" or playerRank == "mod" then
            DisplayOnscreenKeyboard(1, "", "", "", "", "", "", 600)
            while (UpdateOnscreenKeyboard() == 0) do
                DisableAllControlActions(0);
                Wait(0);
            end
            if (GetOnscreenKeyboardResult()) then
                msg = departments[i].name
                local msg2 = GetOnscreenKeyboardResult()
                TriggerServerEvent("alert:sv", msg, msg2)
                SendAlert(msg, msg2)
            end
        end
    end
end)
end)