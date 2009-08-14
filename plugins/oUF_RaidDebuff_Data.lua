-- yleaf (yaroot@gmail.com)

if not _G.oUF_RaidDebuff then return end

local loc = GetLocale()
_G.oUF_RaidDebuff.locale = loc == 'zhCN' and {
	['卡拉赞'] = "Karazhan",
	['祖阿曼'] = "Zul'Aman",
	['毒蛇神殿'] = "Serpentshrine Cavern",
	['风暴要塞'] = "Tempest Keep",
	['海加尔峰'] = 'Hyjal Summit',
	['黑暗神殿'] = 'Black Temple',
	['太阳之井高地'] = 'Sunwell Plateau',
	['纳克萨玛斯'] = 'Naxxramas',
	['黑曜石圣殿'] = 'The Obsidian Sanctum',
	['永恒之眼'] = 'The Eye of Eternity',
	['奥杜尔'] = "Ulduar",
} or loc == 'zhTW' and {
	['卡拉贊'] = "Karazhan",
	['祖阿曼'] = "Zul'Aman",
	['毒蛇神殿洞穴'] = "Serpentshrine Cavern",
	['風暴要塞'] = "Tempest Keep",
	['海加爾山'] = 'Hyjal Summit',
	['黑暗神廟'] = 'Black Temple',
	['太陽之井高地'] = 'Sunwell Plateau',
	['納克薩瑪斯'] = 'Naxxramas',
	['黑曜聖'] = 'The Obsidian Sanctum',
	['永恆之眼'] = 'The Eye of Eternity',
	['奧杜亞'] = "Ulduar",
}

_G.oUF_RaidDebuff.DebuffData = {
	--=========TEST=============
		--[[
		['沙塔斯城'] = {
			[33763] = {
				order = 1,
			},
			[774] = {
				order = 2,
				duration = 5,
			},
		},
		['暴风城'] = {
			[33763] = {
				order = 1,
			},
			[774] = {
				order = 2,
				duration = 5,
			},
		},
		]]
	--=========TEST=============
	
		["Karazhan"] = {
			--Moroes
			[37066] = { --Garrote
				enable = true,
				order = 1,
			},
			--Maiden
			[29522] = { --Holy Fire
				enable = true,
				order = 4,
				debuffType = 1,
			},
			[29511] = { --Repentance
				enable = true,
				order = 5,
				duration = 12,
			},
			--Opera : Bigbad wolf
			[30753] = { -- Red riding hood
				enable = true,
				order = 6,
				duration = 20,
			},
			--Illhoof
			[30115] = { --sacrifice
				enable = true,
				order = 7,
			},
			--Malche
			[30843]= { --Enfeeble
				enable = true,
				order = 8,
			},
		},
		["Zul'Aman"] = {
			--Nalorakk
			[42389] = { --Mangle
				enable = true,
				order = 1,
			},
			--Akilzon
			[43657] = { --Electrical Storm
				enable = true,
				order = 2,
			},
			[43622] = { --Static Distruption
				enable = true,
				order = 3,
			},
			--Zanalai
			[43299] = { --Flame Buffet
				enable = true,
				order = 4,
				debuffType = 1,
			},
			--halazzi
			[43303] = { --Flame Shock
				enable = true,
				order = 5,
				debuffType = 1,
			},
			--hex lord
			[43613] = { --Cold Stare
				enable = true,
				order = 6,
				debuffType = 4,
			},
			[43501] = { --Siphon soul
				enable = true,
				order = 7,
			},
			--Zulzin
			[43093] = { --Throw
				enable = true,
				order = 8,
			},
			[43095] = { --Paralyze
				enable = true,
				order = 9,
			},
			[43150] = { --Rage
				enable = true,
				order = 10,
			},
		},
		["Serpentshrine Cavern"] = {
			-- Trash
			[39042] = { --Rampent Infection
				enable = true,
				debuffType = 3,
				order = 1,
			},
			[39044] = { --Serpentshrine Parasite
				enable = true,
				order = 2,
				duration = 10,
			},
			--Hydross
			[38235] = { --Water Tomb
				enable = true,
				order = 3,
				duration = 4,
			},
			[38246] = { --Vile Sludge
				enable = true,
				order = 4,
			},
			--Morogrim
			[37850] = { --Watery Grave
				enable = true,
				order = 5,
				duration = 6,
			},
			[38023] = {
				delegater = 37850,
			},
			[38024] = {
				delegater = 37850,
			},
			[38025] = {
				delegater = 37850,
			},
			--Leotheras
			[37676] = { --insidious whisper
				enable = true,
				order = 6,
			},
			[37641] = { --Whirl wind
				enable = true,
				order = 7,
				duration = 15,
			},
			[37749] = { --Madness
				enable = true,
				order = 8,
			},
			--Vashj
			[38280] = { --Static Charge
				enable = true,
				order = 9,
				duration = 20,
			},
		},
		["Tempest Keep"] = {
			--Trash
			[37123] = { --Saw Blade
				enable = true,
				order = 1,
			},
			[37120] = { --Fragmentation Bomb
				enable = true,
				order = 2,
			},
			[37118] = { --Shell Shock
				enable = true,
				order = 3,
			},
			--Solarian
			[42783] = { --Wrath of the Astromancer
				enable = true,
				order = 4,
				duration = 6,
			},
			--Kaeltahas
			[37027] = { --Remote Toy
				enable = true,
				order = 5,
			},
			[36798] = { --Mind Control
				enable = true,
				order = 6,
			},
		},
		["Hyjal Summit"] = {
			--Winterchill
			[31249] = { --Ice Bolt
				enable = true,
				order = 1,
				duration = 4,
			},
			--Aneteron
			[31306] = { --Carrion Swarm
				enable = true,
				order = 2,
				duration = 20,
			},
			[31298] = { --Sleep
				enable = true,
				order = 3,
				duration = 10,
			},
			--Azgalor
			[31347] = { --Doom
				enable = true,
				order = 4,
				duration = 20,
			},
			[31341] = { --Unquenchable Flames
				enable = true,
				order = 5,
				duration = 5,
			},
			[31344] = { --Howl of Azgalor
				enable = true,
				order = 6,
				duration = 5,
			},
			--Achimonde
			[31944] = { --Doomfire
				enable = true,
				order = 8,
				duration = 45,
			},
			[31972] = { --Grip
				enable = true,
				order = 9,
				debuffType = 4,
			},
		},
		["Black Temple"] = {
			--Trash
			[34654] = { --Blind
				enable = true,
				order = 1,
				debuffType = 1,
				duration = 10,
			},
			[39674] = { --Banish
				enable = true,
				order = 2,
				duration = 15,
			},
			[41150] = { --Fear
				enable = true,
				order = 3,
				debuffType = 1,
				duration = 3,
			},
			[41168] = { --Sonic Strike
				enable = true,
				order = 4,
				duration = 5,
			},
			--Najentus
			[39837] = { --Impaling Spine
				enable = true,
				order = 10,
			},
			--Terron
			[40239] = { --Incinerate
				enable = true,
				order = 20,
				debuffType = 1,
				duration = 3,
			},
			[40251] = { --Shadow of death
				enable = true,
				order = 30,
				duration = 55,
			},
			--Gurtogg
			[40604] = { --FelRage
				enable = true,
				order = 40,
				duration = 30,
			},
			[40481] = { --Acidic Wound
				enable = true,
				order = 41,
				stackable = true,
				duration = 60,
			},
			[40508] = { --Fel-Acid Breath
				enable = true,
				order = 42,
				duration = 20,
			},
			[42005] = { --bloodboil
				enable = true,
				order = 43,
				stackable = true,
				duration = 24,
			},
			--ROS
			[41303] = { --soulDrain
				enable = true,
				order = 50,
			},
			[41410] = { --Deaden
				enable = true,
				order = 51,
				duration = 10,
			},
			[41376] = { --Spite
				enable = true,
				order = 52,
				duration = 6,
			},
			--Mother
			[40860] = { --Vile Beam
				enable = true,
				order = 60,
				duration = 8,
			},
			[41001] = { --Attraction
				enable = true,
				order = 61,
			},
			--Council
			[41485] = { --Deadly Poison
				enable = true,
				order = 70,
				duration = 4,
			},
			[41472] = { --Wrath
				enable = true,
				order = 71,
				duration = 8,
			},
			--Illiidan
			[41914] = { --Parasitic Shadowfiend
				enable = true,
				order = 80,
				duration = 10,
			},
			[41917] = {
				delegater = 41914,
			},
			[40585] = { --Dark Barrage
				enable = true,
				order = 81,
				duration = 10,
			},
			[41032] = { --Shear
				enable = true,
				order = 82,
			},
			[40932] = { --Flames
				enable = true,
				order = 83,
				duration = 60,
			},
		},
		["Sunwell Plateau"] = {
			--Trash
			[46561] = { --Fear
				enable = true,
				order = 1,
				debuffType = 1,
			},
			[46562] = { --Mind Flay
				enable = true,
				order = 2,
			},
			[46266] = { --Burn Mana
				enable = true,
				order = 3,
				debuffType = 1,
			},
			[46557] = { --Slaying Shot
				enable = true,
				order = 4,
			},
			[46560] = { --Shadow Word: Pain
				enable = true,
				order = 5,
				debuffType = 1,
			},
			[46543] = { --Ignite Mana
				enable = true,
				order = 6,
				debuffType = 1,
			},
			[46427] = { --Domination
				enable = true,
				order = 7,
				debuffType = 1,
			},
			--Kalecgos
			[45032] = { --Curse of Boundless Agony
				enable = true,
				order = 10,
				debuffType = 4,
				duration = 30,
			},
			[45034] = {
				delegater = 45032,
			},
		--	[45018] = { --Arcane Buffet
		--		enable = true,
		--		order = 12,
		--		stackable = true,
		--	},
			--Brutallus
			[46394] = { --Burn
				enable = true,
				order = 20,
				duration = 60,
			},
			[45150] = { --Meteor Slash
				enable = true,
				order = 21,
				stackable = true,
			},
			--Felmyst
			[45855] = { --Gas Nova
				enable = true,
				order = 30,
				debuffType = 1,
			},
			[45662] = { --Encapsulate
				enable = true,
				order = 31,
				duration = 6,
				auraCheck = true, -- doesn't have a combatlog event
			},
			[45402] = { --Demonic Vapor
				enable = true,
				order = 32,
			},
			[45717] = { --Fog of Corruption
				enable = true,
				order = 33,
				auraCheck = true, -- unit is hostile in comabtlog event
			},
			--Twins
			[45256] = { --Confounding Blow
				enable = true,
				order = 41,
			},
			[45333] = { --Conflagration
				enable = true,
				order = 42,
			},
			[46771] = { --Flame Sear
				enable = true,
				order = 43,
			},
			[45270] = { --Shadowfury
				enable = true,
				order = 44,
			},
			[45347] = { --Dark Touched
				enable = true,
				order = 45,
				stackable = true,
				color = { r = 0, g = 0, b = 0, a = 1},
			},
			[45348] = { --Fire Touched
				enable = true,
				order = 46,
				stackable = true,
			},
			--Muru
			[45996] = { --Darkness
				enable = true,
				order = 50,
			},
			--Kiljaeden
			[45442] = { --Soul Flay
				enable = true,
				order = 61,
			},
			[45641] = { --Fire Bloom
				enable = true,
				order = 62,
				duration = 20,
			},
			[45885] = { --Shadow Spike
				enable = true,
				order = 63,
				duration = 10,
			},
			[45737] = { --Flame Dart
				enable = true,
				order = 64,
				duration = 15,
			},
			[45740] = {
				delegater = 45737,
			},
			[45741] = {
				delegater = 45737,
			},
		},
		["Naxxramas"] = {
			--Trash
			[55314] = { --Strangulate
				enable = true,
				order = 1,
				duration = 4,
				debuffType = 1,
			},
			--Anub'Rekhan
			[28786] = { --Locust Swarm (Normal)
				enable = true,
				order = 5,
				stackable = true,
				duration = 6,
			},
			[54022] = { --Locust Swarm (Heroic)
				delegater = 28786,
			},
			--Grand Widow Faerlina
			[28796] = { --Poison Bolt Volley (Normal)
				enable = true,
				order = 10,
				stackable = true,
				debuffType = 2,
				duration = 8,
			},
			[54098] = { --Poison Bolt Volley (Heroic)
				delegater = 28796,
			},
			[28794] = { --Rain of Fire (Normal)
				enable = true,
				order = 11,
			},
			[54099] = { --Rain of Fire (Heroic)
				delegater = 28794,
			},
			--Noth the Plaguebringer
			[29213] = { --Curse of the Plaguebringer (Normal)
				enable = true,
				order = 20,
				debuffType = 4,
				duration = 10,
			},
			[54835] = { --Curse of the Plaguebringer (Heroic)
				delegater = 29213,
			},
			[29214] = { --Wrath of the Plaguebringer (Normal)
				enable = true,
				order = 21,
				duration = 10,
			},
			[54836] = { --Wrath of the Plaguebringer (Heroic)
				delegater = 29214,
			},
			[29212] = { --Cripple (Normal & Heroic)
				enable = true,
				order = 22,
				debuffType = 1,
			},
			--Heigan the Unclean
			[29998] = { --Decrepit Fever (Normal)
				enable = true,
				order = 30,
				duration = 21,
				debuffType = 3,
			},
			[55011] = { --Decrepit Fever  (Heroic)
				delegater = 29998,
			},
			[29310] = { --Spell Disruption (Normal & Heroic)
				enable = true,
				order = 31,
				duration = 10,
			},
			--Grobbulus
			[28169] = { --Mutating Injection (Normal & Heroic)
				enable = true,
				order = 40,
				debuffType = 3,
				duration = 10,
			},
			--Gluth
			[54378] = { --Mortal Wound
				enable = true,
				order = 50,
				stackable = true,
				duration = 15,
			},
			[29306] = { --Infected Wound (Normal & Heroic)
				enable = true,
				order = 51,
				stackable = true,
			},
			--Instructor Razuvious
			[55550] = { --Jagged Knife (Normal & Heroic)
				enable = true,
				order = 60,
				duration = 5,
			},
			--Sapphiron
			[28522] = { --Icebolt (Normal & Heroic)
				enable = true,
				order = 70,
			},
			[28542] = { --Life Drain (Normal)
				enable = true,
				order = 71,
				debuffType = 4,
			},
			[55665] = { --Life Drain (Heroic)
				delegater = 28542,
			},
			--Thaddius
			[28084] = { --Negative Charge (Normal & Heroic)
				enable = true,
				order = 76,
			},
			[28085] = { --Negative Charge (Normal & Heroic)
				enable = true,
				order = 76,
			},
			[28059] = { --Positive Charge (Normal & Heroic)
				enable = true,
				order = 77,
			},
			[28062] = { --Positive Charge (Normal & Heroic)
				enable = true,
				order = 77,
			},
			--Kel'Thuzad
			[28410] = { --Chains of Kel'Thuzad (Heroic only)
				enable = false,
				order = 80,
				duration = 21,
				auraCheck = true, -- unit is hostile in combatlog event
			},
			[27819] = { --Detonate Mana (Normal & Heroic)
				enable = false,
				order = 81,
				duration = 5,
			},
			[27808] = { --Frost Blast (Normal & Heroic)
				enable = true,
				order = 82,
				duration = 4,
			},
			--Maexxna
			[28622] = { --Web Wrap (Normal & Heroic)
				enable = true,
				order = 90,
			},
			[54121] = { --Necrotic Poison (Normal)
				enable = true,
				order = 91,
				debuffType = 2,
			},
			[28776] = { --Necrotic Poison (Heroic)
				delegater = 54121,
			},
		},
		["The Obsidian Sanctum"] = {
			--Trash
			[39647] = { --Curse of Mending
				enable = true,
				order = 1,
				debuffType = 4,
			},
			[58936] = { --Rain of Fire
				enable = true,
				order = 2,
			},
			--Sartharion
			[60708] = { --Fade Armor (Normal & Heroic)
				enable = true,
				order = 3,
				stackable = true,
				duration = 15,
			},
			[57491] = { --Flame Tsunami (Normal & Heroic)
				enable = true,
				order = 4,
				duration = 10,
			},
		},
		["The Eye of Eternity"] = {
			--Malygos
			[57407] = { --Surge of Power (Normal)
				enable = true,
				order = 1,
				duration = 3,
			},
			[60936] = { --Surge of Power (Heroic)
				delegater = 57407,
			},
			[56272] = { --Arcane Breath (Normal)
				enable = true,
				order = 2,
				duration = 5,
			},
			[60072] = { --Arcane Breath (Heroic)
				delegater = 56272,
			},
		},
		["Ulduar"] = {
			--Trash
			[62310] = { --Impale (Normal)
				enable = true,
				order = 1,
				duration = 5,
			},
			[62928] = { --Impale (Heroic)
				delegater = 62310,
			},
			[63612] = { --Lightning Brand (Normal)
				enable = true,
				stackable = true,
				order = 2,
				duration = 20,
			},
			[63673] = { --Lightning Brand (Heroic)
				delegater = 63612,
			},
			[63615] = { --Ravage Armor (Normal & Heroic)
				enable = true,
				stackable = true,
				order = 3,
				duration = 19,
			},
			[64705] = { --Unquenchable Flames (Normal)
				enable = true,
				stackable = true,
				order = 4,
				duration = 5,
			},
			[64706] = { --Unquenchable Flames (Heroic)
				delegater = 64705,
			},
			[62283] = { --Iron Roots (Normal)
				enable = true,
				order = 5,
			},
			[62438] = { --Iron Roots (Heroic)
				delegater = 62283,
			},
			[63169] = { --Petrify Joints (Normal)
				enable = true,
				stackable = true,
				order = 6,
				duration = 20,
			},
			[63549] = { --Petrify Joints (Heroic)
				delegater = 63169,
			},
			--Freya
			[62589] = { --Nature's Fury (Normal)
				enable = true,
				order = 10,
				duration = 10,
			},
			[63571] = { --Nature's Fury (Heroic)
				delegater = 62589,
			},
			[62532] = { --Conservator's Grip (Normal & Heroic)
				enable = true,
				order = 11,
				auraCheck = true,
			},
			[62861] = { --Iron Roots (Normal)
				enable = true,
				order = 12,
			},
			[62930] = { --Iron Roots (Heroic)
				delegater = 62861,
			},
			--Hodir
			[62469] = { --Freeze (Normal & Heroic)
				enable = true,
				order = 20,
				debuffType = 1,
				duration = 10,
			},
			[61969] = { --Flash Freeze (Normal)
				enable = true,
				order = 21,
			},
			[61990] = { --Flash Freeze (Heroic)
				delegater = 61969,
			},
			[62188] = { --Biting Cold (Normal& Heroic)
				enable = true,
				stackable = true,
				order = 22,
			},
			--Ignis the Furnace Master
			[62548] = { --Scorch (Normal)
				enable = true,
				order = 30,
			},
			[63476] = { --Scorch (Heroic)
				delegater = 62548,
			},
			[62680] = { --Flame Jet (Normal)
				enable = true,
				order = 31,
				duration = 8,
			},
			[63472] = { --Flame Jet (Heroic)
				delegater = 62680,
			},
			[62717] = { --Slag Pot (Normal)
				enable = true,
				order = 32,
				duration = 10,
			},
			[63477] = { --Slag Pot (Heroic)
				delegater = 62717,
			},
			--Kologarn
			[64290] = { --Stone Grip (Normal)
				enable = true,
				order = 40,
			},
			[64292] = { --Stone Grip (Heroic)
				delegater = 64290,
			},
			[63355] = { --Crunch Armor (Normal)
				enable = true,
				order = 41,
				stackable = true,
				duration = 45,
			},
			[64002] = { --Crunch Armor (Heroic)
				delegater = 63355,
			},
			[62055] = { --Brittle Skin (Normal& Heroic)
				enable = true,
				order = 42,
				stackable = true,
				duration = 8,
			},
			--Thorim
			[62042] = { --Stormhammer (Normal & Heroic)
				enable = true,
				order = 50,
				duration = 2,
			},
			[62130] = { --Unbalancing Strike (Normal & Heroic)
				enable = true,
				order = 51,
				stackable = true,
				duration = 15,
			},
			[62526] = { --Rune Detonation (Normal & Heroic)
				enable = true,
				order = 52,
				duration = 4,
			},
			[62470] = { --Deafening Thunder (Normal & Heroic)
				enable = true,
				order = 53,
				duration = 8,
			},
			[62331] = { --Impale (Normal)
				enable = true,
				order = 54,
				duration = 8,
			},
			[62418] = { --Impale (Heroic)
				delegater = 62331,
			},
			--XT-002
			[63024] = { --Gravity Bomb (Normal)
				enable = true,
				order = 60,
				duration = 9,
			},
			[64234] = { --Gravity Bomb (Heroic)
				delegater = 63024,
			},
			[63018] = { --Light Bomb (Normal)
				enable = true,
				order = 61,
				duration = 9,
			},
			[65121] = { --Light Bomb (Heroic)
				delegater = 63018,
			},
			--The Assembly of Iron
			[61888] = { --Overwhelming Power(Normal)
				enable = true,
				order = 70,
				duration = 30,
			},
			[64637] = { --Overwhelming Power (Heroic)
				enable = true,
				order = 71,
				duration = 60,
			},
			[62269] = { --Rune of Death (Normal)
				enable = true,
				order = 72,
			},
			[63490] = { --Rune of Death (Heroic)
				delegater = 62269,
			},
			[61903] = { --Fusion Punch (Normal)
				enable = true,
				order = 73,
				duration = 4,
				debuffType = 1,
			},
			[63493] = { --Fusion Punch (Heroic)
				delegater = 61903,
			},
			--Mimiron
			[63666] = { --Napalm Shell (Normal)
				enable = true,
				order = 80,
				duration = 8,
			},
			[65026] = { --Napalm Shell (Heroic)
				delegater = 63666,
			},
			[62997] = { --Plasma Blast (Normal)
				enable = true,
				order = 81,
				duration = 6,
			},
			[64529] = { --Plasma Blast (Heroic)
				delegater = 62997,
			},
			[64668] = { --Magnetic Field (Normal & Heroic)
				enable = true,
				order = 82,
				duration = 6,
			},
			--General Vezax
			[63276] = { --Mark of the Faceless (Normal & Heroic)
				enable = true,
				order = 90,
				duration = 10,
			},
			[63322] = { --Saronite Vapors (Normal & Heroic)
				enable = true,
				stackable = true,
				order = 91,
			},
			--Yogg-Saron
			[63830] = { --Malady of the Mind (Heroic)
				enable = true,
				order = 100,
				debuffType = 1,
				duration = 4,
			},
			[63802] = { --Brain Link(Heroic)
				enable = true,
				order = 101,
				duration = 30,
			},
			[63042] = { --Dominate Mind (Heroic)
				enable = false,
				order = 102,
				debuffType = 1,
				duration = 30,
			},
			[64156] = { --Apathy (Heroic)
				enable = true,
				order = 103,
				debuffType = 1,
				duration = 20,
			},
			[64153] = { --Black Plague (Heroic)
				enable = true,
				order = 104,
				debuffType = 3,
				duration = 24,
			},
			[64157] = { --Curse of Doom (Heroic)
				enable = true,
				order = 105,
				debuffType = 4,
				duration = 12,
			},
			[64152] = { --Draining Poison (Heroic)
				enable = true,
				order = 106,
				debuffType = 2,
				duration = 18,
			},
			[64125] = { --Squeeze (Normal)
				enable = true,
				order = 107,
			},
			[64126] = { --Squeeze (Heroic)
				delegater = 64125,
			},
			[63050] = { --Sanity (Normal & Heroic)
				enable = false,
				stackable = true,
				order = 108,
			},
			--Razorscale
			[64771] = { --Fuse Armor (Normal & Heroic)
				enable = true,
				stackable = true,
				order = 110,
				duration = 20,
			},
		},
}
