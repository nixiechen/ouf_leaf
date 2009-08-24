local zone = BZ["Serpentshrine Cavern"]

--zone, debuffID, order, duration, stackable, color, disable, auraCheck
local colorTable = {	
	["disease"] = { r = .6, g = .4, b =  0, a = 1 },	
}
--Trash
GridStatusRaidDebuff:RegisterDebuff(zone, 39042, 1, nil, false, colorTable["disease"]) --Rampent Infection
GridStatusRaidDebuff:RegisterDebuff(zone, 39044, 2, 10) --Serpentshrine Parasite
				
--Hydross
GridStatusRaidDebuff:RegisterMenuHeader(zone, 10, BB["Hydross the Unstable"])
GridStatusRaidDebuff:RegisterDebuff(zone, 38235, 11, 4) --Water Tomb
GridStatusRaidDebuff:RegisterDebuff(zone, 38246, 12) --Vile Sludge

--Morogrim
GridStatusRaidDebuff:RegisterMenuHeader(zone, 20, BB["Morogrim Tidewalker"])
GridStatusRaidDebuff:RegisterDebuff(zone, 37850, 21, 6) --Watery Grave
GridStatusRaidDebuff:RegisterDebuffDelegater(zone, 37850, 38023, 38024, 38025)

--Leotheras
GridStatusRaidDebuff:RegisterMenuHeader(zone, 30, BB["Leotheras the Blind"])
GridStatusRaidDebuff:RegisterDebuff(zone, 37676, 31) --insidious whisper
GridStatusRaidDebuff:RegisterDebuff(zone, 37641, 32, 15) --Whirl wind
GridStatusRaidDebuff:RegisterDebuff(zone, 37749, 33) --Madness

--Vashj
GridStatusRaidDebuff:RegisterMenuHeader(zone, 40, BB["Lady Vashj"])
GridStatusRaidDebuff:RegisterDebuff(zone, 38280, 34, 20) --Static Charge