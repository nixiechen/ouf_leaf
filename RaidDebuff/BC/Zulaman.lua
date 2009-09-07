local zone = BZ["Zul'Aman"]

--zone, debuffID, order, duration, stackable, color, disable, auraCheck
local colorTable = {	
	["curse"] = { r = .6, g =  0, b =  1},
	["magic"] = { r = .2, g = .6, b =  1},
}

--Nalorakk
GridStatusRaidDebuff:RegisterMenuHeader(zone, 10, BB["Nalorakk"])
GridStatusRaidDebuff:RegisterDebuff(zone, 42398, 11) --Mangle

--Akilzon
GridStatusRaidDebuff:RegisterMenuHeader(zone, 20, BB["Akil'zon"])
GridStatusRaidDebuff:RegisterDebuff(zone, 43657, 21) --Electrical Storm
GridStatusRaidDebuff:RegisterDebuff(zone, 43622, 22) --Static Distruption

--Zanalai
GridStatusRaidDebuff:RegisterMenuHeader(zone, 30, BB["Jan'alai"])
GridStatusRaidDebuff:RegisterDebuff(zone, 43299, 31, nil, false, colorTable["magic"]) --Flame Buffet

--halazzi
GridStatusRaidDebuff:RegisterMenuHeader(zone, 40, BB["Halazzi"])
GridStatusRaidDebuff:RegisterDebuff(zone, 43303, 41, nil, false, colorTable["magic"]) --Flame Shock

--hex lord
GridStatusRaidDebuff:RegisterMenuHeader(zone, 50, BB["Hex Lord Malacrass"])
GridStatusRaidDebuff:RegisterDebuff(zone, 43613, 51, nil, false, colorTable["curse"]) --Cold Stare
GridStatusRaidDebuff:RegisterDebuff(zone, 43501, 52) --Siphon soul

--Zulzin
GridStatusRaidDebuff:RegisterMenuHeader(zone, 60, BB["Zul'jin"])
GridStatusRaidDebuff:RegisterDebuff(zone, 43093, 61) --Throw
GridStatusRaidDebuff:RegisterDebuff(zone, 43095, 62) --Paralyze
GridStatusRaidDebuff:RegisterDebuff(zone, 43150, 63) --Rage