
1. qb-core/server/events.lua.
Search AddEventHandler('playerDropped', function(reason) and replace with this:
    local src = source
    local ped = GetPlayerPed(src)
    local armor = GetPedArmour(ped)
    if not QBCore.Players[src] then return end
    local Player = QBCore.Players[src]
    TriggerEvent('qb-log:server:CreateLog', 'joinleave', 'Dropped', 'red', '**' .. GetPlayerName(src) .. '** (' .. Player.PlayerData.license .. ') left..' ..'\n **Reason:** ' .. reason)
    Player.Functions.SetMetaData('armor', armor)
    Player.Functions.Save()
    QBCore.Player_Buckets[Player.PlayerData.license] = nil
    QBCore.Players[src] = nil
end)```

**2. qb-ambulancejob/server/main.lua. **
*Search RegisterNetEvent('hospital:server:SetArmor', function(amount) and replace with this:*

```RegisterNetEvent('hospital:server:SetArmor', function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    if amount <= 0 then
       amount = 0
    end
    Player.Functions.SetMetaData('armor', amount)
    Player.Functions.Save()
end)```

I have extracted the code from here https://discord.com/channels/831626422232678481/991722333305831444/991722335516242000 and I have used it only to fix armor error, it is the only thing that has worked completely for me and now it is always saved when leaving.
I hope it works for you too.
