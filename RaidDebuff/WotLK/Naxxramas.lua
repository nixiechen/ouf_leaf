local zone = BZ["Naxxramas"]

--zone, debuffID, order, duration, stackable, color, disable, auraCheck
local colorTable = {	
	["curse"] = { r = .6, g =  0, b =  1},
	["magic"] = { r = .2, g = .6, b =  1},
	["poison"] = {r =  0, g = .6, b =  0},
	["disease"] = { r = .6, g = .4, b =  0},	
	["deadly"] = {r = 1, g = 0, b = 0},
	["blue"] = {r = 0, g = 0, b = 1 }	
}
--Trash
GridStatusRaidDebuff:RegisterDebuff(zone, 55314, 1 ,4, false, colorTable["magic"]) --Strangulate

--Anub'Rekhan
GridStatusRaidDebuff:RegisterMenuHeader(zone, 10, BB["Anub'Rekhan"])
GridStatusRaidDebuff:RegisterDebuff(zone, 28786, 11, 6, true) --Locust Swarm (Normal)
GridStatusRaidDebuff:RegisterDebuffDelegater(zone, 28786, 54022) --Locust Swarm (Heroic)

--Grand Widow Faerlina
GridStatusRaidDebuff:RegisterMenuHeader(zone, 20, BB["Grand Widow Faerlina"])
GridStatusRaidDebuff:RegisterDebuff(zone, 28796, 21, 8, true, colorTable["poison"]) --Poison Bolt Volley (Normal)
GridStatusRaidDebuff:RegisterDebuffDelegater(zone, 28796, 54098) --Poison Bolt Volley (Heroic)
GridStatusRaidDebuff:RegisterDebuff(zone, 28794, 22) --Rain of Fire (Normal)
GridStatusRaidDebuff:RegisterDebuffDelegater(zone, 28794, 54099) --Rain of Fire (Heroic)

--Maexxna
GridStatusRaidDebuff:RegisterMenuHeader(zone, 25, BB["Maexxna"])
GridStatusRaidDebuff:RegisterDebuff(zone, 28622, 26) --Web Wrap (Normal & Heroic)
GridStatusRaidDebuff:RegisterDebuff(zone, 54121, 27) --Necrotic Poison (Normal)
GridStatusRaidDebuff:RegisterDebuffDelegater(zone, 54121, 28776) --Necrotic Poison (Heroic)

--Noth the Plaguebringer
GridStatusRaidDebuff:RegisterMenuHeader(zone, 30, BB["Noth the Plaguebringer"])
GridStatusRaidDebuff:RegisterDebuff(zone, 29213, 31, 10, false, colorTable["curse"]) --Curse of the Plaguebringer (Normal)
GridStatusRaidDebuff:RegisterDebuffDelegater(zone, 29213, 54835) --Curse of the Plaguebringer (Heroic)
GridStatusRaidDebuff:RegisterDebuff(zone, 29214, 32, 10) --Wrath of the Plaguebringer (Normal)
GridStatusRaidDebuff:RegisterDebuffDelegater(zone, 29214, 54836) --Wrath of the Plaguebringer (Heroic)
GridStatusRaidDebuff:RegisterDebuff(zone, 29212, 33, nil, false, colorTable["magic"]) --Cripple (Normal & Heroic)

--Heigan the Unclean
GridStatusRaidDebuff:RegisterMenuHeader(zone, 40, BB["Heigan the Unclean"])
GridStatusRaidDebuff:RegisterDebuff(zone, 29998, 41, 21, false, colorTable["disease"]) --Decrepit Fever (Normal)
GridStatusRaidDebuff:RegisterDebuffDelegater(zone, 29998, 55011) --Decrepit Fever  (Heroic)
GridStatusRaidDebuff:RegisterDebuff(zone, 29310, 42, 10, false, nil, true) --Spell Disruption (Normal & Heroic)

--Grobbulus
GridStatusRaidDebuff:RegisterMenuHeader(zone, 50, BB["Grobbulus"])
GridStatusRaidDebuff:RegisterDebuff(zone, 28169, 51, 10, false, colorTable["deadly"]) --Mutating Injection (Normal & Heroic)

--Gluth
GridStatusRaidDebuff:RegisterMenuHeader(zone, 60, BB["Gluth"])
GridStatusRaidDebuff:RegisterDebuff(zone, 54378, 61, 15, true) --Mortal Wound			
GridStatusRaidDebuff:RegisterDebuff(zone, 29306, 62, nil, true) --Infected Wound (Normal & Heroic)

--Thaddius
GridStatusRaidDebuff:RegisterMenuHeader(zone, 65, BB["Thaddius"])
GridStatusRaidDebuff:RegisterDebuff(zone, 28084, 66, nil, false, colorTable["deadly"], true, false, true) --Negative Charge (Normal & Heroic)
GridStatusRaidDebuff:RegisterDebuffDelegater(zone, 28084, 28085) --Negative Charge (Normal & Heroic)
GridStatusRaidDebuff:RegisterDebuff(zone, 28059, 67, nil, false, colorTable["blue"], true, false, true) --Positive Charge (Normal & Heroic)
GridStatusRaidDebuff:RegisterDebuffDelegater(zone, 28059, 28062) --Positive Charge (Normal & Heroic)

--Instructor Razuvious
GridStatusRaidDebuff:RegisterMenuHeader(zone, 70, BB["Instructor Razuvious"])
GridStatusRaidDebuff:RegisterDebuff(zone, 55550, 71, 5) --Jagged Knife (Normal & Heroic)
			
--Sapphiron
GridStatusRaidDebuff:RegisterMenuHeader(zone, 80, BB["Sapphiron"])
GridStatusRaidDebuff:RegisterDebuff(zone, 28522, 81) --Icebolt (Normal & Heroic)
GridStatusRaidDebuff:RegisterDebuff(zone, 28542, 82, nil, false, colorTable["curse"]) --Life Drain (Normal)
GridStatusRaidDebuff:RegisterDebuffDelegater(zone, 28542, 55665) --Life Drain (Heroic)

--Kel'Thuzad
GridStatusRaidDebuff:RegisterMenuHeader(zone, 100, BB["Kel'Thuzad"])
GridStatusRaidDebuff:RegisterDebuff(zone, 28410, 101, 21, false, nil, false, true) --Chains of Kel'Thuzad (Heroic only)
GridStatusRaidDebuff:RegisterDebuff(zone, 27819, 102, 5, false, nil, true) --Detonate Mana (Normal & Heroic)
GridStatusRaidDebuff:RegisterDebuff(zone, 27808, 103, 4) --Frost Blast (Normal & Heroic)


				