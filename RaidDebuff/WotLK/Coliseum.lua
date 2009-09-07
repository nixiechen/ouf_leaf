zone = BZ["Trial of the Crusader"] 


local colorTable = {	
	["dark"] = {r = .7, g = .1, b = .1},
	["light"] = {r = 0, g = 1, b = 1},	
	["curse"] = { r = .6, g =  0, b = 1},
	["magic"] = { r = .2, g = .6, b = 1},
	--["poison"] = {r =  0, g = .6, b =  0},
	--["disease"] = { r = .6, g = .4, b =  0},
	--["warning"] = {r = 1, g = .6, b = 0},
	["deadly"] = {r = 1, g = 0, b = 0},
}

--zone, debuffID, order, duration, stackable, color, disable, auraCheck, noicon

--<< Beast of Northrend >> 
--Gormok the Impaler
GridStatusRaidDebuff:RegisterMenuHeader(zone, 10, BB["Gormok the Impaler"])
GridStatusRaidDebuff:RegisterDebuff(zone, 66331, 11, 30, true) --Impale(10)
GridStatusRaidDebuff:RegisterDebuffDelMod(zone, 66331, 67477, 40, true) --Impale(25)
GridStatusRaidDebuff:RegisterDebuffDelMod(zone, 66331, 67478, 30, true) --Impale(10H)
GridStatusRaidDebuff:RegisterDebuffDelMod(zone, 66331, 67479, 45, true) --Impale(25H)
GridStatusRaidDebuff:RegisterDebuff(zone, 67475, 13) --Fire Bomb(25H)
GridStatusRaidDebuff:RegisterDebuffDelegater(zone, 67475, 67473) --Fire Bomb(10H)
GridStatusRaidDebuff:RegisterDebuff(zone, 66406, 14, nil, false, nil, false, true) --Snowbolled!_not event

--Acidmaw --Dreadscale
GridStatusRaidDebuff:RegisterMenuHeader(zone, 20, BB["Jormungar Behemoth"])
GridStatusRaidDebuff:RegisterDebuff(zone, 67618, 23, 60) --Paralytic Toxin(25)
GridStatusRaidDebuff:RegisterDebuffDelegater(zone, 67618, 66823, 67619, 67620) --Paralytic Toxin(10,10H,25H)
GridStatusRaidDebuff:RegisterDebuff(zone, 66869, 24, 24) --Burning Bile

--Icehowl
GridStatusRaidDebuff:RegisterMenuHeader(zone, 30, BB["Icehowl"])
GridStatusRaidDebuff:RegisterDebuff(zone, 67654, 31) --Ferocious Butt(25)
GridStatusRaidDebuff:RegisterDebuffDelegater(zone, 67654, 66770, 67655, 67656) --Ferocious Butt(10, 10H, 25H)
GridStatusRaidDebuff:RegisterDebuff(zone, 66689, 32, 5) --Arctic Breathe(10)
GridStatusRaidDebuff:RegisterDebuffDelegater(zone, 66689, 67650, 67651, 67652)--Arctic Breathe(25, 10H, 25H)
GridStatusRaidDebuff:RegisterDebuff(zone, 66683, 33) --Massive Crash

--Lord Jaraxxus
GridStatusRaidDebuff:RegisterMenuHeader(zone, 40, BB["Lord Jaraxxus"])
GridStatusRaidDebuff:RegisterDebuff(zone, 66532, 41, 5) --Fel Fireball (10?)
GridStatusRaidDebuff:RegisterDebuffDelegater(zone, 66532, 66963, 66964, 66965) --Fel Fireball (25, 10H, 25H)
GridStatusRaidDebuff:RegisterDebuff(zone, 66237, 42, 12) --Incinerate Flesh(10)
GridStatusRaidDebuff:RegisterDebuffDelegater(zone, 66237, 67049, 67050, 67051) --Incinerate Flesh(25, 10H, 25H)
GridStatusRaidDebuff:RegisterDebuff(zone, 66242, 43, 5) --Burning Inferno (10)
GridStatusRaidDebuff:RegisterDebuffDelegater(zone, 66242, 67059, 67060, 67061) --Burning Inferno (25, 10H, 25H)
GridStatusRaidDebuff:RegisterDebuff(zone, 66197, 44) --Legion Flame (10First)
GridStatusRaidDebuff:RegisterDebuffDelegater(zone, 66197, 68123, 66199, 68126, 68127, 68128, 68124, 68125) --Legion Flame
GridStatusRaidDebuff:RegisterDebuff(zone, 66283, 45, 3) --Spinning Pain Spike
GridStatusRaidDebuff:RegisterDebuff(zone, 66209, 46, 12) --Touch of Jaraxxus(hard)
GridStatusRaidDebuff:RegisterDebuff(zone, 66211, 47, 15, false, colorTable["curse"]) --Curse of the Nether(hard)
GridStatusRaidDebuff:RegisterDebuff(zone, 67906, 48, 8) --Mistress's Kiss 10H
GridStatusRaidDebuff:RegisterDebuff(zone, 67906, 67907) --Mistress's Kiss 25H

--Faction Champions
GridStatusRaidDebuff:RegisterMenuHeader(zone, 50, BB["Faction Champions"])
GridStatusRaidDebuff:RegisterDebuff(zone, 65812, 51, 15, true, colorTable["deadly"]) --Unstable Affliction(10) (stack on : for bg color)
GridStatusRaidDebuff:RegisterDebuffDelegater(zone, 65812, 68154, 68155, 68156) --Unstable Affliction(25, 10H, 25H)
GridStatusRaidDebuff:RegisterDebuff(zone, 65960, 52) --Blind
GridStatusRaidDebuff:RegisterDebuff(zone, 65801, 53, nil, false, colorTable["magic"]) --Polymorph
GridStatusRaidDebuff:RegisterDebuff(zone, 65543, 54, nil, false, colorTable["magic"]) --Psychic Scream
GridStatusRaidDebuff:RegisterDebuff(zone, 66054, 55, nil, false, colorTable["magic"]) --Hex
GridStatusRaidDebuff:RegisterDebuff(zone, 65809, 56, nil, false, colorTable["magic"]) --Fear

--The Twin Val'kyr
GridStatusRaidDebuff:RegisterMenuHeader(zone, 60, BB["The Twin Val'kyr"])
GridStatusRaidDebuff:RegisterDebuff(zone, 67176, 61, nil, false, colorTable["dark"], true, false, true) --Dark Essence
GridStatusRaidDebuff:RegisterDebuffDelegater(zone, 67176, 67177, 67178, 65684)
GridStatusRaidDebuff:RegisterDebuff(zone, 67222, 62, nil, false, colorTable["light"], true, false, true) --Light Essence
GridStatusRaidDebuff:RegisterDebuffDelegater(zone, 67222, 67223, 67224, 65686)
GridStatusRaidDebuff:RegisterDebuff(zone, 67283, 63) --Dark Touch(25Hard)
GridStatusRaidDebuff:RegisterDebuffDelegater(zone, 67283, 67282) --10
GridStatusRaidDebuff:RegisterDebuff(zone, 67298, 64) --Ligth Touch(25Hard)
GridStatusRaidDebuff:RegisterDebuffDelegater(zone, 67298, 67297) --10
GridStatusRaidDebuff:RegisterDebuff(zone, 67309, 65, nil, true, nil, false, true) --Twin Spike(10)
GridStatusRaidDebuff:RegisterDebuffDelegater(zone, 67309, 67310, 67311, 67312) --Twin Spike(25, 10H, 25H)

--Anub'arak
GridStatusRaidDebuff:RegisterMenuHeader(zone, 70, BB["Anub'arak"])
GridStatusRaidDebuff:RegisterDebuff(zone, 67574, 71) --Pursued by Anub'arak
GridStatusRaidDebuff:RegisterDebuff(zone, 66013, 72) --Penetrating Cold (10?)
GridStatusRaidDebuff:RegisterDebuffDelegater(zone, 66013, 68509, 67700, 68510) --Penetrating Cold (25, 10H, 25H)
GridStatusRaidDebuff:RegisterDebuff(zone, 67847, 73, nil, true) --Expose Weakness
GridStatusRaidDebuff:RegisterDebuff(zone, 66012, 74, 3) --Freezing Slash
GridStatusRaidDebuff:RegisterDebuff(zone, 67863, 75, 60, true) --Acid-Drenched Mandibles(25H)
GridStatusRaidDebuff:RegisterDebuffDelegater(zone, 67863, 67861, 67862) --Acid-Drenched Mandibles(10/10H,25)
