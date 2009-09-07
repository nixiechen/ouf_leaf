local zone = BZ["Black Temple"]

--zone, debuffID, order, duration, stackable, color, disable, auraCheck
local colorTable = {		
	["magic"] = { r = .2, g = .6, b =  1},	
}

--Trash
GridStatusRaidDebuff:RegisterDebuff(zone, 34654, 1, 10, false, colorTable["magic"]) --Blind
GridStatusRaidDebuff:RegisterDebuff(zone, 39674, 2, 15) --Banish
GridStatusRaidDebuff:RegisterDebuff(zone, 41150, 3, 3,  false, colorTable["magic"]) --Fear
GridStatusRaidDebuff:RegisterDebuff(zone, 41168, 4, 5) --Sonic Strike

--Najentus
GridStatusRaidDebuff:RegisterMenuHeader(zone, 10, BB["High Warlord Naj'entus"])
GridStatusRaidDebuff:RegisterDebuff(zone, 39837, 11) --Impaling Spine

--Terron
GridStatusRaidDebuff:RegisterMenuHeader(zone, 20, BB["Teron Gorefiend"])
GridStatusRaidDebuff:RegisterDebuff(zone, 40239, 21, 3, false, colorTable["magic"]) --Incinerate
GridStatusRaidDebuff:RegisterDebuff(zone, 40251, 22, 55) --Shadow of death

--Gurtogg
GridStatusRaidDebuff:RegisterMenuHeader(zone, 30, BB["Gurtogg Bloodboil"])
GridStatusRaidDebuff:RegisterDebuff(zone, 40604, 31, 30) --FelRage
GridStatusRaidDebuff:RegisterDebuff(zone, 40481, 32, 60, true) --Acidic Wound				
GridStatusRaidDebuff:RegisterDebuff(zone, 40508, 33, 20) --Fel-Acid Breath
GridStatusRaidDebuff:RegisterDebuff(zone, 42005, 34, 24, true) --bloodboil

--ROS
GridStatusRaidDebuff:RegisterMenuHeader(zone, 40, BB["Reliquary of Souls"])
GridStatusRaidDebuff:RegisterDebuff(zone, 41303, 41) --soulDrain
GridStatusRaidDebuff:RegisterDebuff(zone, 41410, 42, 10) --Deaden
GridStatusRaidDebuff:RegisterDebuff(zone, 41376, 43, 6) --Spite

--Mother
GridStatusRaidDebuff:RegisterMenuHeader(zone, 50, BB["Mother Shahraz"])
GridStatusRaidDebuff:RegisterDebuff(zone, 40860, 51, 8) --Vile Beam
GridStatusRaidDebuff:RegisterDebuff(zone, 41001, 52) --Attraction

--Council
GridStatusRaidDebuff:RegisterMenuHeader(zone, 60, BB["The Illidari Council"])
GridStatusRaidDebuff:RegisterDebuff(zone, 41485, 61, 4) --Deadly Poison
GridStatusRaidDebuff:RegisterDebuff(zone, 41472, 62, 8) --Wrath

--Illiidan
GridStatusRaidDebuff:RegisterMenuHeader(zone, 70, BB["Illidan Stormrage"])
GridStatusRaidDebuff:RegisterDebuff(zone, 41914, 71, 10) --Parasitic Shadowfiend
GridStatusRaidDebuff:RegisterDebuffDelegater(zone, 41914, 41917)
GridStatusRaidDebuff:RegisterDebuff(zone, 40585, 72, 10) --Dark Barrage
GridStatusRaidDebuff:RegisterDebuff(zone, 41032, 73) --Shear
GridStatusRaidDebuff:RegisterDebuff(zone, 40932, 74, 60) --Flames			