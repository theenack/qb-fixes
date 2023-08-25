client.lua
RegisterNetEvent('randol_littleteapot:client:openTrash', function()
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "teapottrash", {
        maxweight = 4000000,
        slots = 300,
    })
    TriggerEvent("inventory:client:SetCurrentStash", "teapottrash")
end)

server.lua

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        CreateThread(function()
            MySQL.query("DELETE FROM stashitems WHERE stash = 'teapottrash'")
        end)
    end
end)
