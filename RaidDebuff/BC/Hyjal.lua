local zone = BZ["Hyjal Summit"]

--zone, debuffID, order, duration, stackable, color, disable, auraCheck

--Winterchill
GridStatusRaidDebuff:RegisterMenuHeader(zone, 10, BB["Rage Winterchill"])
GridStatusRaidDebuff:RegisterDebuff(zone, 31249, 11, 4) --Ice Bolt

--Aneteron
GridStatusRaidDebuff:RegisterMenuHeader(zone, 20, BB["Anetheron"])
GridStatusRaidDebuff:RegisterDebuff(zone, 31306, 21, 20) --Carrion Swarm
GridStatusRaidDebuff:RegisterDebuff(zone, 31298, 22, 10) --Sleep

--Azgalor
GridStatusRaidDebuff:RegisterMenuHeader(zone, 30, BB["Azgalor"])
GridStatusRaidDebuff:RegisterDebuff(zone, 31347, 31, 20) --Doom
GridStatusRaidDebuff:RegisterDebuff(zone, 31341, 32, 5) --Unquenchable Flames
GridStatusRaidDebuff:RegisterDebuff(zone, 31344, 33, 5) --Howl of Azgalor

--Achimonde
GridStatusRaidDebuff:RegisterMenuHeader(zone, 40, BB["Archimonde"])
GridStatusRaidDebuff:RegisterDebuff(zone, 31944, 41, 45) --Doomfire
GridStatusRaidDebuff:RegisterDebuff(zone, 31972, 42) --Grip