local zone = BZ["Tempest Keep"]

--zone, debuffID, order, duration, stackable, color, disable, auraCheck

--Trash
GridStatusRaidDebuff:RegisterDebuff(zone, 37123, 1) --Saw Blade
GridStatusRaidDebuff:RegisterDebuff(zone, 37120, 2) --Fragmentation Bomb
GridStatusRaidDebuff:RegisterDebuff(zone, 37118, 3) --Shell Shock

--Solarian
GridStatusRaidDebuff:RegisterMenuHeader(zone, 30, BB["High Astromancer Solarian"])
GridStatusRaidDebuff:RegisterDebuff(zone, 42783, 31, 6) --Wrath of the Astromancer

--Kaeltahas
GridStatusRaidDebuff:RegisterMenuHeader(zone, 40, BB["Kael'thas Sunstrider"])
GridStatusRaidDebuff:RegisterDebuff(zone, 37027, 41) --Remote Toy
GridStatusRaidDebuff:RegisterDebuff(zone, 36798, 42) --Mind Control