local zone = BZ["Ulduar"]

--zone, debuffID, order, duration, stackable, color, disable, auraCheck

local colorTable = {
	["curse"] = { r = .6, g =  0, b =  1},
	["magic"] = { r = .2, g = .6, b =  1},
	["poison"] = {r =  0, g = .6, b =  0},
	["disease"] = { r = .6, g = .4, b = 0},
	["warning"] = {r = 1, g = .6, b = 0},
	["deadly"] = {r = 1, g = 0, b = 0}
}

--Trash
GridStatusRaidDebuff:RegisterDebuff(zone, 62310, 1, 5) --Impale (Normal)
GridStatusRaidDebuff:RegisterDebuffDelegater(zone, 62310, 62928) --Impale (Heroic)
GridStatusRaidDebuff:RegisterDebuff(zone, 63612, 2, 20, true) --Lightning Brand (Normal)
GridStatusRaidDebuff:RegisterDebuffDelegater(zone, 63612, 63673) --Lightning Brand (Heroic)
GridStatusRaidDebuff:RegisterDebuff(zone, 63615, 3, 19, true) --Ravage Armor (Normal & Heroic)
GridStatusRaidDebuff:RegisterDebuff(zone, 62283, 5) --Iron Roots (Normal)
GridStatusRaidDebuff:RegisterDebuffDelegater(zone, 62283, 62438) --Iron Roots (Heroic)
GridStatusRaidDebuff:RegisterDebuff(zone, 63169, 6, 20, true) --Petrify Joints (Normal)
GridStatusRaidDebuff:RegisterDebuffDelegater(zone, 63169, 63549) --Petrify Joints (Heroic)
			
--Razorscale
GridStatusRaidDebuff:RegisterMenuHeader(zone, 10, BB["Razorscale"])
GridStatusRaidDebuff:RegisterDebuff(zone, 64771, 11, 20, true) --Fuse Armor (Normal & Heroic)
			
--Ignis the Furnace Master
GridStatusRaidDebuff:RegisterMenuHeader(zone, 15, BB["Ignis the Furnace Master"])
GridStatusRaidDebuff:RegisterDebuff(zone, 62548, 16) --Scorch (Normal)
GridStatusRaidDebuff:RegisterDebuffDelegater(zone, 62548, 63476) --Scorch (Heroic)
GridStatusRaidDebuff:RegisterDebuff(zone, 62680, 17, 6) --Flame Jet (Normal)
GridStatusRaidDebuff:RegisterDebuffDelegater(zone, 62680, 63472) --Flame Jet (Heroic)
GridStatusRaidDebuff:RegisterDebuff(zone, 62717, 18, 10) --Slag Pot (Normal)
GridStatusRaidDebuff:RegisterDebuffDelegater(zone, 62717, 63477) --Slag Pot (Heroic)
			
--XT-002
GridStatusRaidDebuff:RegisterMenuHeader(zone, 20, BB["XT-002 Deconstructor"])
GridStatusRaidDebuff:RegisterDebuff(zone, 63024, 21, 9) --Gravity Bomb (Normal)
GridStatusRaidDebuff:RegisterDebuffDelegater(zone, 63024, 64234) --Gravity Bomb (Heroic)
GridStatusRaidDebuff:RegisterDebuff(zone, 63018, 22, 9) --Light Bomb (Normal)
GridStatusRaidDebuff:RegisterDebuffDelegater(zone, 63018, 65121) --Light Bomb (Heroic)
			
--The Assembly of Iron
GridStatusRaidDebuff:RegisterMenuHeader(zone, 30, BB["The Iron Council"])
GridStatusRaidDebuff:RegisterDebuff(zone, 61888, 31, 35) --Overwhelming Power(Heroic)
GridStatusRaidDebuff:RegisterDebuffDelMod(zone, 61888, 64637, 60) --Overwhelming Power (Normal)
GridStatusRaidDebuff:RegisterDebuff(zone, 62269, 33) --Rune of Death (Normal)
GridStatusRaidDebuff:RegisterDebuffDelegater(zone, 62269, 63490) --Rune of Death (Heroic)
GridStatusRaidDebuff:RegisterDebuff(zone, 61903, 34, 4, false, colorTable["magic"]) --Fusion Punch (Normal)
GridStatusRaidDebuff:RegisterDebuffDelegater(zone, 61903, 63493) --Fusion Punch (Heroic)
GridStatusRaidDebuff:RegisterDebuff(zone, 61912, 35, 20) --Static Disruption(Normal)
GridStatusRaidDebuff:RegisterDebuffDelegater(zone, 61912, 63494) --Static Disruption(Heroic)
			
--Kologarn
GridStatusRaidDebuff:RegisterMenuHeader(zone, 40, BB["Kologarn"])
GridStatusRaidDebuff:RegisterDebuff(zone, 64290, 41) --Stone Grip (Normal)
GridStatusRaidDebuff:RegisterDebuffDelegater(zone, 64290, 64292) --Stone Grip (Heroic)
GridStatusRaidDebuff:RegisterDebuff(zone, 63355, 42, 45, true) --Crunch Armor (Normal)
GridStatusRaidDebuff:RegisterDebuffDelegater(zone, 63355, 64002) --Crunch Armor (Heroic)
GridStatusRaidDebuff:RegisterDebuff(zone, 62055, 43, 8, true) --Brittle Skin (Normal& Heroic)			
			
--Hodir
GridStatusRaidDebuff:RegisterMenuHeader(zone, 50, BB["Hodir"])
GridStatusRaidDebuff:RegisterDebuff(zone, 62469, 51, 10, false, colorTable["magic"]) --Freeze (Normal & Heroic)
GridStatusRaidDebuff:RegisterDebuff(zone, 61969, 52) --Flash Freeze (Normal)
GridStatusRaidDebuff:RegisterDebuffDelegater(zone, 61969, 61990) --Flash Freeze (Heroic)
GridStatusRaidDebuff:RegisterDebuff(zone, 62188, 53, nil, true) --Biting Cold (Normal& Heroic)
			
--Thorim
GridStatusRaidDebuff:RegisterMenuHeader(zone, 60, BB["Thorim"])
GridStatusRaidDebuff:RegisterDebuff(zone, 62042, 61, 2) --Stormhammer (Normal & Heroic)				
GridStatusRaidDebuff:RegisterDebuff(zone, 62130, 62, 15, true) --Unbalancing Strike (Normal & Heroic)
GridStatusRaidDebuff:RegisterDebuff(zone, 62526, 63, 4) --Rune Detonation (Normal & Heroic)
GridStatusRaidDebuff:RegisterDebuff(zone, 62470, 64, 8) --Deafening Thunder (Normal & Heroic)
GridStatusRaidDebuff:RegisterDebuff(zone, 62331, 65, 8) --Impale (Normal)
GridStatusRaidDebuff:RegisterDebuffDelegater(zone, 62331, 62418) --Impale (Heroic)
			
--Freya
GridStatusRaidDebuff:RegisterMenuHeader(zone, 70, BB["Freya"])
GridStatusRaidDebuff:RegisterDebuff(zone, 62589, 71, 10) --Nature's Fury (Normal)
GridStatusRaidDebuff:RegisterDebuffDelegater(zone, 62589, 63571) --Nature's Fury (Heroic)
GridStatusRaidDebuff:RegisterDebuff(zone, 62861, 73) --Iron Roots (Normal)
GridStatusRaidDebuff:RegisterDebuffDelegater(zone, 62861, 62930) --Iron Roots (Heroic)
			
--Mimiron
GridStatusRaidDebuff:RegisterMenuHeader(zone, 80, BB["Mimiron"])
GridStatusRaidDebuff:RegisterDebuff(zone, 63666, 81, 8) --Napalm Shell (Normal)
GridStatusRaidDebuff:RegisterDebuffDelegater(zone, 63666, 65026) --Napalm Shell (Heroic)
GridStatusRaidDebuff:RegisterDebuff(zone, 62997, 82, 6) --Plasma Blast (Normal)
GridStatusRaidDebuff:RegisterDebuffDelegater(zone, 62997, 64529) --Plasma Blast (Heroic)
GridStatusRaidDebuff:RegisterDebuff(zone, 64668, 83, 6) --Magnetic Field (Normal & Heroic)

--General Vezax
GridStatusRaidDebuff:RegisterMenuHeader(zone, 90, BB["General Vezax"])
GridStatusRaidDebuff:RegisterDebuff(zone, 63276, 91, 10) --Mark of the Faceless (Normal & Heroic)
GridStatusRaidDebuff:RegisterDebuff(zone, 63322, 92, nil, true) --Saronite Vapors (Normal & Heroic)

--Yogg-Saron
GridStatusRaidDebuff:RegisterMenuHeader(zone, 100, BB["Yogg-Saron"])
GridStatusRaidDebuff:RegisterDebuff(zone, 63134, 101, 20) --Sara's Bless(Normal & Heroic)
GridStatusRaidDebuff:RegisterDebuff(zone, 63138, 102, 15, true, colorTable["deadly"]) --Sara's Fevor(Normal & Heroic)
GridStatusRaidDebuff:RegisterDebuff(zone, 63830, 103, 4, false, colorTable["disease"]) --Malady of the Mind (Heroic)
GridStatusRaidDebuff:RegisterDebuff(zone, 63802, 104, 30, false, colorTable["warning"]) --Brain Link(Heroic)
GridStatusRaidDebuff:RegisterDebuff(zone, 63042, 105, 30, false, nil, true) --Dominate Mind (Heroic)
GridStatusRaidDebuff:RegisterDebuff(zone, 64156, 106, 20, false, colorTable["magic"]) --Apathy (Heroic)
GridStatusRaidDebuff:RegisterDebuff(zone, 64153, 107, 24) --Black Plague (Heroic)
GridStatusRaidDebuff:RegisterDebuff(zone, 64157, 108, 12, false, colorTable["curse"]) --Curse of Doom (Heroic)
GridStatusRaidDebuff:RegisterDebuff(zone, 64152, 109, 18, false, colorTable["poison"]) --Draining Poison (Heroic)
GridStatusRaidDebuff:RegisterDebuff(zone, 64125, 110, nil, false, colorTable["deadly"]) --Squeeze (Normal)
GridStatusRaidDebuff:RegisterDebuffDelegater(zone, 64125, 64126) --Squeeze (Heroic)
GridStatusRaidDebuff:RegisterDebuff(zone, 63050, 111, nil, true, nil, true) --Sanity (Normal & Heroic)

--Algalon
GridStatusRaidDebuff:RegisterMenuHeader(zone, 120, BB["Algalon the Observer"])
GridStatusRaidDebuff:RegisterDebuff(zone, 64412, 121, 45, true, colorTable["warning"]) --Phase Punch
 