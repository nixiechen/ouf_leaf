local zone = BZ["Black Temple"]

--en_zone, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon

--Trash
GridStatusRaidDebuff:Debuff(zone, 34654, 1, 5, 5, true) --Blind
GridStatusRaidDebuff:Debuff(zone, 39674, 2, 5, 5, true) --Banish
GridStatusRaidDebuff:Debuff(zone, 41150, 3, 5, 5, true) --Fear
GridStatusRaidDebuff:Debuff(zone, 41168, 4, 5, 5) --Sonic Strike

--Najentus
GridStatusRaidDebuff:Debuff(zone, 39837, 11, 5, 5) --Impaling Spine

--Terron
GridStatusRaidDebuff:Debuff(zone, 40239, 21, 5, 5, true) --Incinerate
GridStatusRaidDebuff:Debuff(zone, 40251, 22, 5, 5, true) --Shadow of death

--Gurtogg
GridStatusRaidDebuff:Debuff(zone, 40604, 31, 5, 5, true) --FelRage
GridStatusRaidDebuff:Debuff(zone, 40481, 32, 5, 5, true, true) --Acidic Wound				
GridStatusRaidDebuff:Debuff(zone, 40508, 33, 5, 5, true) --Fel-Acid Breath
GridStatusRaidDebuff:Debuff(zone, 42005, 34, 5, 5, true, true) --bloodboil

--ROS
GridStatusRaidDebuff:Debuff(zone, 41303, 41, 5, 5) --soulDrain
GridStatusRaidDebuff:Debuff(zone, 41410, 42, 5, 5, true) --Deaden
GridStatusRaidDebuff:Debuff(zone, 41376, 43, 5, 5, true) --Spite

--Mother
GridStatusRaidDebuff:Debuff(zone, 40860, 51, 5, 5, true) --Vile Beam
GridStatusRaidDebuff:Debuff(zone, 41001, 52, 5, 5) --Attraction

--Council
GridStatusRaidDebuff:Debuff(zone, 41485, 61, 5, 5, true) --Deadly Poison
GridStatusRaidDebuff:Debuff(zone, 41472, 62, 5, 5, true) --Wrath

--Illiidan
GridStatusRaidDebuff:Debuff(zone, 41914, 71, 5, 5, true) --Parasitic Shadowfiend
GridStatusRaidDebuff:Debuff(zone, 41917, 71, 5, 5, true)
GridStatusRaidDebuff:Debuff(zone, 40585, 72, 5, 5, true) --Dark Barrage
GridStatusRaidDebuff:Debuff(zone, 41032, 73, 5, 5) --Shear
GridStatusRaidDebuff:Debuff(zone, 40932, 74, 5, 5, true) --Flames			