local zone = BZ["Sunwell Plateau"]

--zone, debuffID, order, duration, stackable, color, disable, auraCheck
local colorTable = {	
	["dark"] = {r = .1, g = .1, b = .1},
	
	["curse"] = { r = .6, g =  0, b = 1},
	["magic"] = { r = .2, g = .6, b = 1},
	["poison"] = {r =  0, g = .6, b = 0},
	["disease"] = { r = .6, g = .4, b = 0},
	
}

--Trash
GridStatusRaidDebuff:RegisterDebuff(zone, 46561, 1, nil, false, colorTable["magic"]) --Fear
GridStatusRaidDebuff:RegisterDebuff(zone, 46562, 2) --Mind Flay
GridStatusRaidDebuff:RegisterDebuff(zone, 46266, 3, nil, false, colorTable["magic"]) --Burn Mana
GridStatusRaidDebuff:RegisterDebuff(zone, 46557, 4) --Slaying Shot
GridStatusRaidDebuff:RegisterDebuff(zone, 46560, 5, nil, false, colorTable["magic"]) --Shadow Word: Pain
GridStatusRaidDebuff:RegisterDebuff(zone, 46543, 6, nil, false, colorTable["magic"]) --Ignite Mana
GridStatusRaidDebuff:RegisterDebuff(zone, 46427, 7, nil, false, colorTable["magic"]) --Domination

--Kalecgos
GridStatusRaidDebuff:RegisterMenuHeader(zone, 10, BB["Kalecgos"])
GridStatusRaidDebuff:RegisterDebuff(zone, 45032, 11, 30,  false, colorTable["curse"]) --Curse of Boundless Agony
GridStatusRaidDebuff:RegisterDebuffDelegater(zone, 45032, 45034)
GridStatusRaidDebuff:RegisterDebuff(zone, 45018, 12, nil, true) --Arcane Buffet

--Brutallus
GridStatusRaidDebuff:RegisterMenuHeader(zone, 20, BB["Brutallus"])
GridStatusRaidDebuff:RegisterDebuff(zone, 46394, 21, 60) --Burn				
GridStatusRaidDebuff:RegisterDebuff(zone, 45150, 22, nil, true) --Meteor Slash

--Felmyst
GridStatusRaidDebuff:RegisterMenuHeader(zone, 30, BB["Felmyst"])
GridStatusRaidDebuff:RegisterDebuff(zone, 45855, 31, nil, false, colorTable["magic"]) --Gas Nova
GridStatusRaidDebuff:RegisterDebuff(zone, 45662, 32, 6, false, nil, false, true) --Encapsulate(dosen't have Combat Log)
GridStatusRaidDebuff:RegisterDebuff(zone, 45402, 33) --Demonic Vapor
GridStatusRaidDebuff:RegisterDebuff(zone, 45717, 34, nil, false, nil, false, true) --Fog of Corruption*unit is hostile in comabtlog event)

--Twins
GridStatusRaidDebuff:RegisterMenuHeader(zone, 40, BB["The Eredar Twins"])
GridStatusRaidDebuff:RegisterDebuff(zone, 45256, 41) --Confounding Blow
GridStatusRaidDebuff:RegisterDebuff(zone, 45333, 42) --Conflagration
GridStatusRaidDebuff:RegisterDebuff(zone, 46771, 43) --Flame Sear
GridStatusRaidDebuff:RegisterDebuff(zone, 45270, 44) --Shadowfury
GridStatusRaidDebuff:RegisterDebuff(zone, 45347, 45, nil, true, colorTable["black"], false, false) --Dark Touched
GridStatusRaidDebuff:RegisterDebuff(zone, 45348, 46, nil, true) --Fire Touched

--Muru
GridStatusRaidDebuff:RegisterMenuHeader(zone, 50, BB["M'uru"])
GridStatusRaidDebuff:RegisterDebuff(zone, 45996, 51) --Darkness

--Kiljaeden
GridStatusRaidDebuff:RegisterMenuHeader(zone, 60, BB["Kil'jaeden"])
GridStatusRaidDebuff:RegisterDebuff(zone, 45442, 61) --Soul Flay
GridStatusRaidDebuff:RegisterDebuff(zone, 45641, 62, 20) --Fire Bloom
GridStatusRaidDebuff:RegisterDebuff(zone, 45885, 63, 10) --Shadow Spike
GridStatusRaidDebuff:RegisterDebuff(zone, 45737, 64, 15) --Flame Dart
GridStatusRaidDebuff:RegisterDebuffDelegater(zone, 45737, 45740, 45741)				