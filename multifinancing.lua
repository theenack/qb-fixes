First change this line in qb-vehicleshop/config.lua fom this.. Config.FinanceZone = vector3(x, y, z)
to this

Config.FinanceZones = {
    vector3(-29.53, -1103.67, 26.42), -- Add Vec3
    vector3(-702.0, -417.49, 35.08),  -- Add Vec3
}

then in qb-vehicleshop/client.lua around line 384 change this..

CreateThread(function()
        local financeZone = BoxZone:Create(Config.FinanceZone, 2.0, 2.0, {
            name = "vehicleshop_financeZone",
            offset = {0.0, 0.0, 0.0},
            scale = {1.0, 1.0, 1.0},
            minZ = Config.FinanceZone.z - 1,
            maxZ = Config.FinanceZone.z + 1,
            debugPoly = false,
        })

        financeZone:onPlayerInOut(function(isPointInside)
            if isPointInside then
                exports['qb-menu']:showHeader(financeMenu)
            else
                exports['qb-menu']:closeMenu()
            end
        end)
    end)

to this..

CreateThread(function()
        for _, financeZonePos in ipairs(Config.FinanceZones) do
            local financeZone = BoxZone:Create(financeZonePos, 2.0, 2.0, {
                name = "vehicleshop_financeZone",
                offset = {0.0, 0.0, 0.0},
                scale = {1.0, 1.0, 1.0},
                minZ = financeZonePos.z - 1,
                maxZ = financeZonePos.z + 1,
                debugPoly = false,
            })
    
            financeZone:onPlayerInOut(function(isPointInside)
                if isPointInside then
                    exports['qb-menu']:showHeader(financeMenu)
                else
                    exports['qb-menu']:closeMenu()
                end
            end)
        end
    end)

Save that up and refresh or restart the server and Whammo you can add finance zones to every managed shop for that more personal feel to going to your dealership to pay your bill or check your payments.
