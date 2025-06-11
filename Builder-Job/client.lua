local ESX = exports["es_extended"]:getSharedObject()

local nearMarker = false

CreateThread(function()
    while true do
        Wait(0)
        local player = PlayerPedId()
        local coords = GetEntityCoords(player)
        nearMarker = false

        -- Drill-Punkte anzeigen und prüfen
        for _, point in pairs(Config.Points) do
            local dist = #(coords - point.coords)

            if dist < 10.0 then
                DrawMarker(Config.Marker.type, point.coords.x, point.coords.y, point.coords.z - 0.0,
                    0.0, 0.0, 0.0,
                    0.0, 0.0, 0.0,
                    Config.Marker.size.x, Config.Marker.size.y, Config.Marker.size.z,
                    Config.Marker.color.r, Config.Marker.color.g, Config.Marker.color.b, Config.Marker.color.a,
                    Config.Marker.bobUpAndDown, Config.Marker.rotate, 2, nil, nil, false)

                if dist < 1.5 then
                    nearMarker = true
                    TriggerEvent('a_hud::HelpNotification', nil, '[E] Bohrung starten')

                    if IsControlJustReleased(0, 38) then
                        StartDrilling(point.coords, point.heading)
                    end
                end
            end
        end

        -- Hammer-Punkte anzeigen und prüfen
        for _, point in pairs(Config.HammerPoints) do
            local dist = #(coords - point.coords)

            if dist < 10.0 then
                DrawMarker(Config.Marker.type, point.coords.x, point.coords.y, point.coords.z - 0.0,
                    0.0, 0.0, 0.0,
                    0.0, 0.0, 0.0,
                    Config.Marker.size.x, Config.Marker.size.y, Config.Marker.size.z,
                    Config.Marker.color.r, Config.Marker.color.g, Config.Marker.color.b, Config.Marker.color.a,
                    Config.Marker.bobUpAndDown, Config.Marker.rotate, 2, nil, nil, false)

                if dist < 1.5 then
                    nearMarker = true
                    TriggerEvent('a_hud::HelpNotification', nil, '[E] Hammeraktion starten')

                    if IsControlJustReleased(0, 38) then
                        StartHammering(point.coords, point.heading)
                    end
                end
            end
        end
    end
end)

function StartDrilling(coords, heading)
    local player = PlayerPedId()

    SetEntityHeading(player, heading)
    TaskStartScenarioInPlace(player, "WORLD_HUMAN_CONST_DRILL", 0, true)

    TriggerEvent('a_hud::StartProgressBar', Config.Progress.time, Config.Progress.label)
    FreezeEntityPosition(player, true)

    Wait(Config.Progress.time)

    ClearPedTasks(player)
    FreezeEntityPosition(player, false)

    RemoveNearbyDrillProps()

    TriggerServerEvent('drill:reward')
end

function StartHammering(coords, heading)
    local player = PlayerPedId()

    SetEntityHeading(player, heading)
    -- Hammer-Animation starten (z.B. Hammer schlagen)
    TaskStartScenarioInPlace(player, "WORLD_HUMAN_HAMMERING", 0, true)

    TriggerEvent('a_hud::StartProgressBar', Config.Progress.time, "Hämmern...") -- Eigenes Label für Hammern
    FreezeEntityPosition(player, true)

    Wait(Config.Progress.time)

    ClearPedTasks(player)
    FreezeEntityPosition(player, false)

    TriggerServerEvent('hammer:reward')
end

function RemoveNearbyDrillProps()
    local playerCoords = GetEntityCoords(PlayerPedId())
    local objectModel = GetHashKey('prop_tool_concdrill')

    for _, obj in pairs(GetGamePool('CObject')) do
        if GetEntityModel(obj) == objectModel then
            local objCoords = GetEntityCoords(obj)
            if #(playerCoords - objCoords) < 2.0 then
                DeleteObject(obj)
                break
            end
        end
    end
end

CreateThread(function()
    if Config.Blip.enabled then
        local blip = AddBlipForCoord(Config.Blip.coords.x, Config.Blip.coords.y, Config.Blip.coords.z)
        SetBlipSprite(blip, Config.Blip.sprite)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, Config.Blip.scale)
        SetBlipColour(blip, Config.Blip.color)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.Blip.name)
        EndTextCommandSetBlipName(blip)
    end
end)

local sellerNPC = nil

CreateThread(function()
    -- NPC Laden und spawnen
    RequestModel(GetHashKey(Config.Seller.npcModel))
    while not HasModelLoaded(GetHashKey(Config.Seller.npcModel)) do Wait(100) end

    sellerNPC = CreatePed(4, GetHashKey(Config.Seller.npcModel), Config.Seller.coords.x, Config.Seller.coords.y, Config.Seller.coords.z - 1.0, Config.Seller.heading, false, true)
    SetEntityInvincible(sellerNPC, true)
    FreezeEntityPosition(sellerNPC, true)
    SetBlockingOfNonTemporaryEvents(sellerNPC, true)
end)

CreateThread(function()
    while true do
        Wait(0)
        local player = PlayerPedId()
        local coords = GetEntityCoords(player)
        local dist = #(coords - Config.Seller.coords)

        if dist < 3.0 then
            -- Hilfetext zum Öffnen
            TriggerEvent('a_hud::HelpNotification', nil, '[E] Verkaufen')

            if IsControlJustReleased(0, 38) then
                OpenSellMenu()
            end
        end
    end
end)

function OpenSellMenu()
    local elements = {}

    for _, item in pairs(Config.Seller.itemsForSale) do
        table.insert(elements, {
            label = item.name,
            value = item.name
        })
    end

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'sell_menu', {
        title = 'Was willst du verkaufen?',
        align = 'bottom-right',
        elements = elements
    }, function(data, menu)
        local selectedItem = data.current.value

        -- Menü für Menge öffnen
        ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'sell_quantity', {
            title = 'Wie viele willst du verkaufen?'
        }, function(data2, menu2)
            local quantity = tonumber(data2.value)

            if quantity == nil or quantity <= 0 then
                ESX.ShowNotification('Ungültige Anzahl')
            else
                menu2.close()
                menu.close()
                TriggerServerEvent('seller:sellItem', selectedItem, quantity)
            end
        end, function(data2, menu2)
            menu2.close()
        end)
    end, function(data, menu)
        menu.close()
    end)
end