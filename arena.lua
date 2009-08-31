-- yleaf (yaroot@gmail.com)
if ouf_leaf.noarena then return end

--[[local auraFilter = {
	-- Copied from Gladius,  the Priority would not work here.
	--Spell Name			Priority (higher = more priority)
	--crowd control
	[GetSpellInfo(33786)] 	= 3, 	--Cyclone
	[GetSpellInfo(18658)] 	= 3,	--Hibernate
	[GetSpellInfo(14309)] 	= 3, 	--Freezing Trap Effect
	[GetSpellInfo(60210)]	= 3,	--Freezing arrow effect
	[GetSpellInfo(6770)]	= 3, 	--Sap
	[GetSpellInfo(2094)]	= 3, 	--Blind
	[GetSpellInfo(5782)]	= 3, 	--Fear
	[GetSpellInfo(47860)]	= 3,	--Death Coil Warlock
	[GetSpellInfo(6358)] 	= 3, 	--Seduction
	[GetSpellInfo(5484)] 	= 3, 	--Howl of Terror
	[GetSpellInfo(5246)] 	= 3, 	--Intimidating Shout
	[GetSpellInfo(8122)] 	= 3,	--Psychic Scream
	[GetSpellInfo(12826)] 	= 3,	--Polymorph
	[GetSpellInfo(28272)] 	= 3,	--Polymorph pig
	[GetSpellInfo(28271)] 	= 3,	--Polymorph turtle
	[GetSpellInfo(61305)] 	= 3,	--Polymorph black cat
	[GetSpellInfo(61025)] 	= 3,	--Polymorph serpent
	[GetSpellInfo(51514)]	= 3,	--Hex
	
	--roots
	[GetSpellInfo(53308)] 	= 3, 	--Entangling Roots
	[GetSpellInfo(42917)]	= 3,	--Frost Nova
	[GetSpellInfo(16979)] 	= 3, 	--Feral Charge
	[GetSpellInfo(13809)] 	= 1, 	--Frost Trap
	
	--Stuns and incapacitates
	[GetSpellInfo(8983)] 	= 3, 	--Bash
	[GetSpellInfo(1833)] 	= 3,	--Cheap Shot
	[GetSpellInfo(8643)] 	= 3, 	--Kidney Shot
	[GetSpellInfo(1776)]	= 3, 	--Gouge
	[GetSpellInfo(44572)]	= 3, 	--Deep Freeze
	[GetSpellInfo(49012)]	= 3, 	--Wyvern Sting
	[GetSpellInfo(19503)] 	= 3, 	--Scatter Shot
	[GetSpellInfo(49803)]	= 3, 	--Pounce
	[GetSpellInfo(49802)]	= 3, 	--Maim
	[GetSpellInfo(10308)]	= 3, 	--Hammer of Justice
	[GetSpellInfo(20066)] 	= 3, 	--Repentance
	[GetSpellInfo(46968)] 	= 3, 	--Shockwave
	[GetSpellInfo(49203)] 	= 3,	--Hungering Cold
	[GetSpellInfo(47481)]	= 3,	--Gnaw (dk pet stun)
	
	--Silences
	[GetSpellInfo(18469)] 	= 1,	--Improved Counterspell
	[GetSpellInfo(15487)] 	= 1, 	--Silence
	[GetSpellInfo(34490)] 	= 1, 	--Silencing Shot	
	[GetSpellInfo(18425)]	= 1,	--Improved Kick
	[GetSpellInfo(49916)]	= 1,	--Strangulate
	
	--Disarms
	[GetSpellInfo(676)] 	= 1, 	--Disarm
	[GetSpellInfo(51722)] 	= 1,	--Dismantle
	[GetSpellInfo(53359)] 	= 1,	--Chimera Shot - Scorpid	
	
	--Buffs
	[GetSpellInfo(1022)] 	= 1,	--Blessing of Protection
	[GetSpellInfo(10278)] 	= 1,	--Hand of Protection
	[GetSpellInfo(1044)] 	= 1, 	--Blessing of Freedom
	[GetSpellInfo(2825)] 	= 1, 	--Bloodlust
	[GetSpellInfo(32182)] 	= 1, 	--Heroism
	[GetSpellInfo(33206)] 	= 1, 	--Pain Suppression
	[GetSpellInfo(29166)] 	= 1,	--Innervate
	[GetSpellInfo(18708)]  	= 1,	--Fel Domination
	[GetSpellInfo(54428)]	= 1,	--Divine Plea
	[GetSpellInfo(31821)]	= 1,	--Aura mastery
	
	--immunities
	[GetSpellInfo(34692)] 	= 2, 	--The Beast Within
	[GetSpellInfo(45438)] 	= 2, 	--Ice Block
	[GetSpellInfo(642)] 	= 2,	--Divine Shield
}]]

local texture = [=[Interface\AddOns\oUF_leaf\media\FlatSmooth]=]
local SetFontString = ouf_leaf.createfont

local function CustomTimeText(self, duration)
	if self.casting then
		self.Time:SetFormattedText('%.1f', self.max - duration)
	elseif self.channeling then
		self.Time:SetFormattedText('%.1f', duration)
	end
end

--[[local function CustomAuraFilter(icons, unit, icon, name, rank, texture, count, dtype, duration, timeLeft, caster)
	return auraFilter[name]
end

local function PostCreateAuraIcon(self, button, icons, index, debuff)
	button.icon:SetTexCoord(.1, .9, .1, .9)
	button.overlay.Show = function() end
	button.overlay:Hide()
	button:SetScript('OnEnter', nil)
	button:SetScript('OnLeave', nil)
end]]

local function styleFunc(settings, self, unit)
	self.colors = ouf_leaf.colors
	self:SetScript('OnEnter', UnitFrame_OnEnter)
	self:SetScript('OnLeave', UnitFrame_OnLeave)
	self:SetBackdrop(ouf_leaf.backdrop)
	self:SetBackdropColor(0, 0, 0, .6)
	
	self.Health = CreateFrame('StatusBar', nil, self)
	self.Health:SetPoint('TOPRIGHT', self)
	self.Health:SetPoint('TOPLEFT', self)
	self.Health:SetStatusBarTexture(texture)
	self.Health:SetHeight(20)
	
	self.Health.frequentUpdates = true
	self.Health.colorClass = true
	self.Health.colorClassPet = true
	self.Health.colorDisconnected = true
	
	self.Health.bg = self.Health:CreateTexture(nil, 'BORDER')
	self.Health.bg:SetAllPoints(self.Health)
	self.Health.bg:SetTexture(texture)
	self.Health.bg.multiplier = .3
	
	self.Power = CreateFrame('StatusBar', nil, self)
	self.Power:SetStatusBarTexture(texture)
	
	self.Power.frequentUpdates = true
	self.Power.colorPower = true
	
	self.Power.bg = self.Power:CreateTexture(nil, 'BORDER')
	self.Power.bg:SetAllPoints(self.Power)
	self.Power.bg:SetTexture(texture)
	self.Power.bg.multiplier = .3
	
	self.RaidIcon = self.Health:CreateTexture(nil, 'OVERLAY')
	self.RaidIcon:SetPoint('TOP', self, 0, 8)
	self.RaidIcon:SetHeight(16)
	self.RaidIcon:SetWidth(16)
	
	self.leafRange = .5
	self.inRangeAlpha = 1
	self.outsideRangeAlpha = .4
	
	local tag1 = SetFontString(self.Health)
	tag1:SetPoint('RIGHT', self.Health, -2, 0)
	self:Tag(tag1, '|cff50a050[leafperhp]|r%')
	
	if settings.style ~= 'pet' then
		local tag2 = SetFontString(self.Health)
		tag2:SetPoint('LEFT', self.Health, 2, 0)
		self:Tag(tag2, '[leafperhp]')
	end
	
	if settings.style == 'pet' then
		self.Health:SetHeight(9)
		self.Power:SetPoint('TOPLEFT', self.Health, 'BOTTOMLEFT')
		self.Power:SetPoint('BOTTOMRIGHT', self)
	elseif settings.style == 'target' then
		self.Health:SetHeight(19)
		self.Power:SetPoint('TOPLEFT', self.Health, 'BOTTOMLEFT')
		self.Power:SetPoint('BOTTOMRIGHT', self)
	elseif settings.style == 'normal' then
		self.Power:SetPoint('TOPLEFT', self.Health, 'BOTTOMLEFT')
		self.Power:SetPoint('RIGHT', self)
		self.Power:SetHeight(7)
		
		--[[self.Buffs = CreateFrame('Frame', nil, self)
		self.Buffs:SetHeight(20)
		self.Buffs:SetWidth(20)
		self.Buffs:SetPoint('TOPRIGHT', self, 'TOPLEFT', 2, 0)
		self.Buffs.num = 1
		self.Buffs.size = settings['initial-height']
		self.Buffs.initialAnchor = 'TOPRIGHT'
		self.Buffs['growth-x'] = 'LEFT'
		
		self.Debuffs = CreateFrame('Frame', nil, self)
		self.Debuffs:SetHeight(20)
		self.Debuffs:SetWidth(20)
		self.Debuffs:SetPoint('TOPRIGHT', self, 'TOPLEFT', 2, 0)
		self.Debuffs.num = 1
		self.Debuffs.size = settings['initial-height']
		self.Debuffs.initialAnchor = 'TOPRIGHT'
		self.Debuffs['growth-x'] = 'LEFT'
		
		self.CustomAuraFilter = CustomAuraFilter
		self.PostCreateAuraIcon = PostCreateAuraIcon]]
		
		self.Castbar = CreateFrame('StatusBar', nil, self)
		self.Castbar:SetStatusBarTexture(texture)
		self.Castbar:SetStatusBarColor(1,.8,.0)
		
		self.Castbar:SetPoint('TOPLEFT', self.Power, 'BOTTOMLEFT')
		self.Castbar:SetPoint('BOTTOMRIGHT', self)
		
		self.Castbar.Icon = self.Castbar:CreateTexture(nil, 'ARTWORK')
		self.Castbar.Icon:SetHeight(settings['initial-height'])
		self.Castbar.Icon:SetWidth(settings['initial-height'])
		self.Castbar.Icon:SetPoint('TOPRIGHT', self, 'TOPLEFT', -2, 0)
		self.Castbar.Icon:SetTexCoord(.1,.9,.1,.9)
		
		self.Castbar.Text = SetFontString(self.Castbar)
		self.Castbar.Text:SetPoint('LEFT', self.Castbar, 2, 0)
		
		self.Castbar.Time = SetFontString(self.Castbar)
		self.Castbar.Time:SetPoint('RIGHT', self.Castbar, -2, 0)
		
		self.Castbar.CustomTimeText = CustomTimeText
		
		
		--self.Debuffs:SetFrameLevel(self.Buffs:GetFrameLevel() + 1)
		--self.Castbar:SetFrameLevel(self.Debuffs:GetFrameLevel() + 1)
	end
	
	self.ignoreHealComm = true
end

oUF:RegisterStyle('leafArena', setmetatable({
	['initial-width'] = 180,
	['initial-height'] = 40,
	['style'] = 'normal',
}, {__call = styleFunc}))

oUF:RegisterStyle('leafArena - pet', setmetatable({
	['initial-width'] = 120,
	['initial-height'] = 12,
	['style'] = 'pet',
}, {__call = styleFunc}))

oUF:RegisterStyle('leafArena - target', setmetatable({
	['initial-width'] = 120,
	['initial-height'] = 23,
	['style'] = 'target',
}, {__call = styleFunc}))

--[[
oUF:SetActiveStyle'leafArena'
local player = oUF:Spawn'player'
player:SetPoint('TOPRIGHT', UIParent, 'BOTTOMRIGHT', -200, 230)

oUF:SetActiveStyle'leafArena - pet'
local pet = oUF:Spawn'player'
pet:SetPoint('BOTTOMLEFT', player, 'BOTTOMRIGHT', 5, 0)

oUF:SetActiveStyle'leafArena - target'
local target = oUF:Spawn'player'
target:SetPoint('TOPLEFT', player, 'TOPRIGHT', 5, 0)
]]


local f = CreateFrame'Frame'
f:RegisterEvent'PLAYER_ENTERING_WORLD'
f:SetScript('OnEvent', function(self)
	local isIn, instanceType = IsInInstance()
	if instanceType ~= 'arena' then return end
	
	self:UnregisterAllEvents()
	self:SetScript('OnEvent', nil)
	
	SetCVar('showArenaEnemyFrames', '0')
	
	if ArenaEnemyFrames then
		ArenaEnemyFrames:UnregisterAllEvents()
		ArenaEnemyFrames:Hide()
		
		hooksecurefunc('ArenaEnemyFrame_OnLoad', function(self) self:UnregisterAllEvents() end)
		hooksecurefunc('ArenaEnemyPetFrame_OnLoad', function(self) self:UnregisterAllEvents() end)
	end
	
	local arenas = {}
	
	oUF:SetActiveStyle('leafArena')
	for i = 1, 5 do
		local unit = 'arena' .. i
		local frame = oUF:Spawn(unit)
		arenas[unit] = frame
		
		if i == 1 then
			frame:SetPoint('TOPRIGHT', UIParent, 'BOTTOMRIGHT', -200, 230)
		else
			frame:SetPoint('TOPLEFT', arenas['arena' .. (i - 1)], 'BOTTOMLEFT', 0, -5)
		end
	end
	
	oUF:SetActiveStyle('leafArena - target')
	for i = 1, 5 do
		local unit = 'arena' .. i .. 'target'
		local frame = oUF:Spawn(unit)
		arenas[unit] = frame
		frame:SetPoint('TOPLEFT', arenas['arena' .. i], 'TOPRIGHT', 5, 0)
	end
	
	oUF:SetActiveStyle('leafArena - pet')
	for i = 1, 5 do
		local unit = 'arenapet' .. i
		local frame = oUF:Spawn(unit)
		arenas[unit] = frame
		frame:SetPoint('BOTTOMLEFT', arenas['arena' .. i], 'BOTTOMRIGHT', 5, 0)
	end
	
	ouf_leaf.units.arenas = arenas
end)
