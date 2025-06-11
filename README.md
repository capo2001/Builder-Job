# 👷‍♂️ Builder Job Script for FiveM (ESX)

A dynamic construction job for your FiveM server. Players interact with drill and hammer points, receive configurable rewards, and sell collected materials to an NPC. Includes integrated blip, NPC, animation, progress bar, and text UI support.

---

## 🧰 Requirements

This script requires the following resources:

- [`es_extended`](https://github.com/esx-framework/es_extended)
- [`esx_inventory`](https://github.com/esx-framework/esx_inventory)
- [`ox_lib`](https://github.com/overextended/ox_lib) for progress bars and text UI

---

## 🚀 Features

- 🛠️ Multiple drilling and hammering work points
- 🪓 Two separate reward types: Beton (drill), Wood (hammer)
- 📍 Optional map blip for job location
- 🧍 NPC to sell collected materials with random pricing
- 🧱 Configurable progress duration and animations
- 🔧 Fully customizable reward types: items or money
- 🧠 Smart text UI for feedback and location prompts
- 🔋 0.00ms idle performance

---

## ⚙️ Configuration (`config.lua`)

### 🔧 Blip Settings

```lua
Config.Blip = {
    enabled = true,
    coords = vector3(90.40, 6546.42, 31.67),
    sprite = 867,
    color = 1,
    scale = 0.6,
    name = "Bauarbeiter Job"
}

🧍 NPC Seller

Config.Seller = {
    npcModel = "s_m_y_construct_01",
    coords = vector3(82.02, 6553.67, 32.24),
    heading = 234.76,
    itemsForSale = {
        { name = "beton", priceMin = 6, priceMax = 15 },
        { name = "wood", priceMin = 6, priceMax = 15 },
    }
}

🔨 Work Zones

Config.Points = { -- Drilling points
    { coords = vector3(83.53, 6534.34, 31.67), heading = 324.56 },
    -- More...
}

Config.HammerPoints = { -- Hammering points
    { coords = vector3(94.69, 6539.21, 31.66), heading = 45.68 },
    -- More...
}

⏳ Progress Settings

Config.Progress = {
    time = 20000,
    label = "Bohre..."
}

🎁 Rewards

Config.Reward = {
    type = "item",
    name = "beton",
    amount = {min = 1, max = 4},
    moneyType = "cash"
}

Config.HammerReward = {
    type = "item",
    name = "wood",
    amount = {min = 1, max = 4},
    moneyType = "bank"
}

🛠️ Installation
Add the script to your resources folder.

Make sure all required dependencies are running.

Add required items (e.g. beton, wood) to your inventory system.

Start the script in your server.cfg:

cfg
Kopieren
Bearbeiten
ensure builderjob