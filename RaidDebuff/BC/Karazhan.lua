local zone = BZ["Karazhan"]

--zone, debuffID, order, duration, stackable, color, disable, auraCheck

local colorTable = {	
	["magic"] = { r = .2, g = .6, b =  1 },	
}

--Moroes
GridStatusRaidDebuff:RegisterMenuHeader(zone, 10, BB["Moroes"])
GridStatusRaidDebuff:RegisterDebuff(zone, 37066, 11) --Garrote

--Maiden
GridStatusRaidDebuff:RegisterMenuHeader(zone, 20, BB["Maiden of Virtue"])
GridStatusRaidDebuff:RegisterDebuff(zone, 29522, 21, nil, false, colorTable["magic"]) --Holy Fire
GridStatusRaidDebuff:RegisterDebuff(zone, 29511, 22, 12) --Repentance

--Opera : Bigbad wolf
GridStatusRaidDebuff:RegisterMenuHeader(zone, 30, BB["The Big Bad Wolf"])
GridStatusRaidDebuff:RegisterDebuff(zone, 30753, 31, 20) --Red riding hood

--Illhoof
GridStatusRaidDebuff:RegisterMenuHeader(zone, 40, BB["Terestian Illhoof"])
GridStatusRaidDebuff:RegisterDebuff(zone, 30115, 41) --Holy Fire

--Malche
GridStatusRaidDebuff:RegisterMenuHeader(zone, 50, BB["Prince Malchezaar"])
GridStatusRaidDebuff:RegisterDebuff(zone, 30843, 51) --Holy Fire