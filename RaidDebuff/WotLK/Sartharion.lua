local zone = BZ["The Obsidian Sanctum"]

--zone, debuffID, order, duration, stackable, color, disable, auraCheck
local colorTable = {	
	["curse"] = { r = .6, g =  0, b =  1, a = 1 },	
}

--Trash
GridStatusRaidDebuff:RegisterDebuff(zone, 39647, 1, nil, false, colorTable["curse"]) --Curse of Mending
GridStatusRaidDebuff:RegisterDebuff(zone, 58936, 2) --Rain of Fire
	
--Sartharion
GridStatusRaidDebuff:RegisterMenuHeader(zone, 10, BB["Sartharion"])
GridStatusRaidDebuff:RegisterDebuff(zone, 60708, 11, 15, true) --Fade Armor (Normal & Heroic)
GridStatusRaidDebuff:RegisterDebuff(zone, 57491, 12, 10) --Flame Tsunami (Normal & Heroic)