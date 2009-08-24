local zone = BZ["The Eye of Eternity"]

--zone, debuffID, order, duration, stackable, color, disable, auraCheck

--Malygos	
GridStatusRaidDebuff:RegisterMenuHeader(zone, 10, BB["Malygos"])
GridStatusRaidDebuff:RegisterDebuff(zone, 57407, 11, 3) --Surge of Power (Normal)
GridStatusRaidDebuff:RegisterDebuffDelegater(zone, 57407, 60936) --Surge of Power (Heroic)
GridStatusRaidDebuff:RegisterDebuff(zone, 56272, 12, 5) --Arcane Breath (Normal)
GridStatusRaidDebuff:RegisterDebuffDelegater(zone, 56272, 60072) --Arcane Breath (Heroic)