local zone = BZ["Vault of Archavon"]

--zone, debuffID, order, duration, stackable, color, disable, auraCheck

--Koralon	
GridStatusRaidDebuff:RegisterMenuHeader(zone, 10, BB["Koralon the Flame Watcher"])
GridStatusRaidDebuff:RegisterDebuff(zone, 67332, 11) --Flaming Cinder(25)
GridStatusRaidDebuff:RegisterDebuffDelegater(zone, 67332, 66684) --Flaming Cinder(10)