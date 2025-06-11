Config = {}

Config.Marker = {
    type = 2,
    color = { r = 0, g = 255, b = 50, a = 100 },
    size = { x = 0.2, y = 0.2, z = 0.2 },
    rotate = true,
    bobUpAndDown = true
}

Config.Blip = {
    enabled = true,           -- Blip aktivieren/deaktivieren
    coords = vector3(90.4017, 6546.4272, 31.6765),  -- Koordinaten des Blips
    sprite = 867,              -- Blip Typ (Sprite-ID)
    color = 1,                -- Blip Farbe
    scale = 0.6,              -- Blip Größe
    name = "Bauarbeiter Job"  -- Name des Blips auf der Karte
}

Config.Seller = {
    npcModel = "s_m_y_construct_01", -- NPC Modelname (z.B. für Shopkeeper)
    coords = vector3(82.0223, 6553.6729, 32.2482), -- Position des NPC
    heading = 234.7681, -- Richtung, in die der NPC schaut

    itemsForSale = {
        -- Jedes Item mit Min/Max-Preis für Verkauf
        { name = "beton", priceMin = 6, priceMax = 15 },
        { name = "wood", priceMin = 6, priceMax = 15 },
    }
}

Config.Points = {
    { coords = vector3(83.5373, 6534.3491, 31.6764), heading = 324.56 },
    { coords = vector3(87.3503, 6538.5767, 31.6764), heading = 314.94 },
    { coords = vector3(92.2721, 6543.8916, 31.6764), heading = 317.44 },
    { coords = vector3(98.3649, 6549.9468, 31.6764), heading = 313.60 },
    { coords = vector3(95.2752, 6553.4614, 31.6764), heading = 50.06 },
    { coords = vector3(89.8688, 6552.2852, 31.6764), heading = 134.47 },
    { coords = vector3(85.2975, 6547.1665, 31.6764), heading = 139.77 },
    { coords = vector3(80.5644, 6542.2271, 31.6764), heading = 135.92 },
    { coords = vector3(75.6248, 6537.1050, 31.6764), heading = 136.01 },
}

Config.HammerPoints = {
    { coords = vector3(94.6918, 6539.2124, 31.6630), heading = 45.6829 },
    { coords = vector3(96.6721, 6541.5664, 31.6630), heading = 49.1451 },
    { coords = vector3(98.7079, 6543.6812, 31.6630), heading = 43.9359 },
	{ coords = vector3(98.2488, 6546.0596, 31.6765), heading = 220.9512 },
    { coords = vector3(100.8590, 6548.8799, 31.6765), heading = 223.2030 },
    { coords = vector3(93.1788, 6540.8906, 31.6765), heading = 228.8059 },
	{ coords = vector3(91.9387, 6548.4253, 31.6765), heading = 318.6121 },
    { coords = vector3(93.6232, 6550.3789, 31.6765), heading = 139.9938 },
}

Config.Progress = {
    time = 20000, -- 8 Sekunden
    label = "Bohre..."
}

-- Belohnung für Bohrpunkte
Config.Reward = {
    type = "item", -- "item" oder "money"
    name = "beton", -- Itemname (nur bei item)
    amount = {min = 1, max = 4}, -- Zufallsbereich
    moneyType = "cash" -- oder "bank", falls Geld
}

-- Belohnung für Hammerpunkte (anders als bei Bohrpunkten)
Config.HammerReward = {
    type = "item", -- "item" oder "money"
    name = "wood", -- Optional, falls du Items geben willst (hier z.B. Hammer)
    amount = {min = 1, max = 4}, -- Zufallsbereich (z.B. Geldbetrag)
    moneyType = "bank" -- oder "cash"
}
