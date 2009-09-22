local zone = "Sunwell Plateau"

--en_zone, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon

--Trash
GridStatusRaidDebuff:Debuff(zone, 46561, 1, 5, 5) --Fear
GridStatusRaidDebuff:Debuff(zone, 46562, 2, 5, 5) --Mind Flay
GridStatusRaidDebuff:Debuff(zone, 46266, 3, 5, 5) --Burn Mana
GridStatusRaidDebuff:Debuff(zone, 46557, 4, 5, 5) --Slaying Shot
GridStatusRaidDebuff:Debuff(zone, 46560, 5, 5, 5) --Shadow Word: Pain
GridStatusRaidDebuff:Debuff(zone, 46543, 6, 5, 5) --Ignite Mana
GridStatusRaidDebuff:Debuff(zone, 46427, 7, 5, 5) --Domination

--Kalecgos
GridStatusRaidDebuff:Debuff(zone, 45032, 11, 5, 5, true) --Curse of Boundless Agony
GridStatusRaidDebuff:Debuff(zone, 45034, 11, 5, 5, true)
GridStatusRaidDebuff:Debuff(zone, 45018, 12, 5, 5, true, true) --Arcane Buffet

--Brutallus
GridStatusRaidDebuff:Debuff(zone, 46394, 21, 5, 5, true) --Burn				
GridStatusRaidDebuff:Debuff(zone, 45150, 22, 5, 5, true, true) --Meteor Slash

--Felmyst
GridStatusRaidDebuff:Debuff(zone, 45855, 31, 5, 5) --Gas Nova
GridStatusRaidDebuff:Debuff(zone, 45662, 32, 5, 5, true) --Encapsulate(dosen't have Combat Log)
GridStatusRaidDebuff:Debuff(zone, 45402, 33, 5, 5) --Demonic Vapor
GridStatusRaidDebuff:Debuff(zone, 45717, 34, 5, 5) --Fog of Corruption*unit is hostile in comabtlog event)

--Twins
GridStatusRaidDebuff:Debuff(zone, 45256, 41, 5, 5) --Confounding Blow
GridStatusRaidDebuff:Debuff(zone, 45333, 42, 5, 5) --Conflagration
GridStatusRaidDebuff:Debuff(zone, 46771, 43, 5, 5) --Flame Sear
GridStatusRaidDebuff:Debuff(zone, 45270, 44, 5, 5) --Shadowfury
GridStatusRaidDebuff:Debuff(zone, 45347, 45, 5, 5, nil, true) --Dark Touched
GridStatusRaidDebuff:Debuff(zone, 45348, 46, 5, 5, nil, true) --Fire Touched

--Muru
GridStatusRaidDebuff:Debuff(zone, 45996, 51, 5, 5) --Darkness

--Kiljaeden
GridStatusRaidDebuff:Debuff(zone, 45442, 61, 5, 5) --Soul Flay
GridStatusRaidDebuff:Debuff(zone, 45641, 62, 5, 5, true) --Fire Bloom
GridStatusRaidDebuff:Debuff(zone, 45885, 63, 5, 5, true) --Shadow Spike
GridStatusRaidDebuff:Debuff(zone, 45737, 64, 5, 5, true) --Flame Dart
GridStatusRaidDebuff:Debuff(zone, 45740, 64, 5, 5, true)
GridStatusRaidDebuff:Debuff(zone, 45741, 64, 5, 5, true)
