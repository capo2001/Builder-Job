local ESX = exports["es_extended"]:getSharedObject()


RegisterNetEvent('drill:reward', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if not xPlayer then
        print('Spieler nicht gefunden')
        return
    end

    local rewardType = Config.Reward.type
    local amount = math.random(Config.Reward.amount.min, Config.Reward.amount.max)

    if rewardType == "item" then
        local itemName = Config.Reward.name
        xPlayer.addInventoryItem(itemName, amount)
        TriggerClientEvent('a_hud::AddNotification', src, 'success', 'Bohrung abgeschlossen', ('Du hast %sx %s erhalten.'):format(amount, itemName), 5000)
    elseif rewardType == "money" then
        xPlayer.addAccountMoney(Config.Reward.moneyType, amount)
        TriggerClientEvent('a_hud::AddNotification', src, 'success', 'Bohrung abgeschlossen', ('Du hast $%s erhalten.'):format(amount), 5000)
    end
end)

RegisterNetEvent('hammer:reward', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if not xPlayer then
        print('Spieler nicht gefunden')
        return
    end

    local rewardType = Config.HammerReward.type
    local amount = math.random(Config.HammerReward.amount.min, Config.HammerReward.amount.max)

    if rewardType == "item" then
        local itemName = Config.HammerReward.name
        xPlayer.addInventoryItem(itemName, amount)
        TriggerClientEvent('a_hud::AddNotification', src, 'success', 'Hammeraktion abgeschlossen', ('Du hast %sx %s erhalten.'):format(amount, itemName), 5000)
    elseif rewardType == "money" then
        xPlayer.addAccountMoney(Config.HammerReward.moneyType, amount)
        TriggerClientEvent('a_hud::AddNotification', src, 'success', 'Hammeraktion abgeschlossen', ('Du hast $%s erhalten.'):format(amount), 5000)
    end
end)

RegisterNetEvent('seller:sellItem', function(itemName, quantity)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if not xPlayer then return end

    local item = nil
    for _, v in pairs(Config.Seller.itemsForSale) do
        if v.name == itemName then
            item = v
            break
        end
    end

    if not item then
        TriggerClientEvent('a_hud::AddNotification', src, 'error', 'Fehler', 'Dieses Item kannst du hier nicht verkaufen.', 5000)
        return
    end

    local playerItemCount = xPlayer.getInventoryItem(itemName).count

    if playerItemCount < quantity then
        TriggerClientEvent('a_hud::AddNotification', src, 'error', 'Fehler', 'Du hast nicht genug von diesem Item.', 5000)
        return
    end

    local pricePerItem = math.random(item.priceMin, item.priceMax)
    local totalPrice = pricePerItem * quantity

    xPlayer.removeInventoryItem(itemName, quantity)
    xPlayer.addMoney(totalPrice)

    TriggerClientEvent('a_hud::AddNotification', src, 'success', 'Verkauf abgeschlossen', ('Du hast %sx %s verkauft und %s€ erhalten'):format(quantity, itemName, totalPrice), 5000)
end)
