-- yleaf (yaroot@gmail.com)

if ouf_leaf.noraid then return end

local _, class = UnitClass'player'
local texture = [[Interface\AddOns\oUF_leaf\media\white]]
local SetFontString = ouf_leaf.createfont
local backdrop = ouf_leaf.backdrop

--[[local backdrop = {
	bgFile = [=[Interface\ChatFrame\ChatFrameBackground]=], tile = true, tileSize = 16,
	insets = {top = -1, left = -1, bottom = -1, right = -1},
}]]

local function OverrideUpdateHealth(self, event, unit, bar, min, max)
	if bar.disconnected or UnitIsDeadOrGhost(unit) then
		bar.c = self.colors.disconnected
	else
		bar.c = self.colors.class[select(2, UnitClass(unit))]
	end
	if bar.c then
		bar.bg:SetVertexColor(unpack(bar.c))
	end
end

local ci_data = {
	['DRUID'] = {
		['TR'] = '[ci:rejuv][ci:regrowth][ci:wg]',
		['BR'] = '[ci:lb]',
	},
	['PRIEST'] = {
		['TR'] = '[ci:renew][ci:shield][ci:ws]',
		['BR'] = '[ci:pom]',
	},
	['PALADIN'] = {
		['TR'] = '[ci:bol]'
	}
--[[	['WARRIOR'] = {
		['TR'] = '[ci:shout]',
	},	]]
--[[
	['EN-CLASS'] = {
		['TL'] = '',
		['TR'] = '',
		['BL'] = '',
		['BR'] = '',
	},
]]
}

local indicators = ci_data[class]

local id2spell = setmetatable({}, {
	__index = function(t,i)
		t[i] = GetSpellInfo(i)
		return t[i]
	end
})

local mine = {['player'] = true, ['vehicle'] = true}

local function aurafunc(unit, spellid, is_mine)
	local spell = id2spell[spellid]
	
	local name, _, _, count, _, _, _, caster, _ = UnitAura(unit, spell)
	if not name then return end
	
	if is_mine and (not mine[caster]) then return end
	return name, count
end

-- priest
oUF.Tags['[ci:pom]'] = function(u)
	local name, count = aurafunc(u, 33076, true)
	if name and count then
		return '|cffFFCF7F'..count..'|r'
	end
end
oUF.Tags['[ci:renew]'] = function(u) if aurafunc(u, 139, true) then return '|cff33FF33.|r' end end
oUF.Tags['[ci:shield]'] = function(u) if aurafunc(u, 17) then return '|cff33FF33.|r' end end
oUF.Tags['[ci:ws]'] = function(u) if aurafunc(u, 6788) then return '|cffFF5500.|r' end end

oUF.TagEvents['[ci:pom]'] = 'UNIT_AURA'
oUF.TagEvents['[ci:renew]'] = 'UNIT_AURA'
oUF.TagEvents['[ci:shield]'] = 'UNIT_AURA'
oUF.TagEvents['[ci:ws]'] = 'UNIT_AURA'

-- druid
oUF.Tags['[ci:lb]'] = function(u)
	local name, count = aurafunc(u, 33763, true)
	if count then
		return '|cffA7FD0A'..count..'|r'
	end
end
oUF.Tags['[ci:rejuv]'] = function(u) if aurafunc(u, 774, true) then return '|cff00FEBF.|r' end end
oUF.Tags['[ci:regrowth]'] = function(u) if aurafunc(u, 8936, true) then return '|cff00FF10.|r' end end
oUF.Tags['[ci:wg]'] = function(u) if aurafunc(u, 48438, true) then return '|cff33FF33.|r' end end

oUF.TagEvents['[ci:lb]'] = 'UNIT_AURA'
oUF.TagEvents['[ci:rejuv]'] = 'UNIT_AURA'
oUF.TagEvents['[ci:regrowth]'] = 'UNIT_AURA'
oUF.TagEvents['[ci:wg]'] = 'UNIT_AURA'

-- warrior
--oUF.Tags['[cishout]'] = function(u) if aurafunc(u, 11553) or aurafunc(u, 469) then return '|cffffff00.|r' end end
--oUF.TagEvents['[cishout]'] = 'UNIT_AURA'

-- paladin
oUF.Tags['[ci:bol]'] = function(u) if aurafunc(u, 53563, true) then return '|cffff0100.|r' end end
oUF.TagEvents['[ci:bol]'] = 'UNIT_AURA'


local function styleFunc(self, unit)
	self.colors = ouf_leaf.colors
	self.menu = ouf_leaf.menu
	self:RegisterForClicks('AnyUp')
	self:SetAttribute('type3', 'menu')
	self:SetScript('OnEnter', UnitFrame_OnEnter)
	self:SetScript('OnLeave', UnitFrame_OnLeave)
	
	self:SetBackdrop(backdrop)
	self:SetBackdropColor(0, 0, 0, 1)
	
	self:SetAttribute('initial-height', 35)
	self:SetAttribute('initial-width', 45)
	
	self.Health = CreateFrame('StatusBar', nil, self)
	self.Health:SetOrientation('VERTICAL')
	self.Health:SetWidth(40)
	self.Health:SetPoint('TOPLEFT', self)
	self.Health:SetPoint('BOTTOMLEFT', self)
	self.Health:SetStatusBarTexture(texture)
	self.Health:SetStatusBarColor(.15, .15, .15, .8)
	
	self.Health.frequentUpdates = true
	
	self.Health.bg = self.Health:CreateTexture(nil, 'BORDER')
	self.Health.bg:SetAllPoints(self.Health)
	self.Health.bg:SetTexture(texture)
	
	self.OverrideUpdateHealth = OverrideUpdateHealth
	
	self.Power = CreateFrame('StatusBar', nil, self)
	self.Power:SetOrientation('VERTICAL')
	self.Power:SetStatusBarTexture(texture)
	
	self.Power.colorPower = true
	
	self.Power:SetPoint('TOPLEFT', self.Health, 'TOPRIGHT')
	self.Power:SetPoint'BOTTOMRIGHT'

	self.Power.bg = self.Power:CreateTexture(nil, 'BORDER')
	self.Power.bg:SetAllPoints(self.Power)
	self.Power.bg:SetTexture(texture)
	self.Power.bg.multiplier = .3
	
	local text = SetFontString(self.Health)
	text:SetPoint('CENTER', self.Health, 1, 0)
	--text.frequentUpdates = .5
	self:Tag(text, '[leafraid]')
	
	local aggro = SetFontString(self.Health, 36)
	aggro:SetPoint('TOPLEFT', self.Health, 0, 22)
	self:Tag(aggro, '[leafthreat]')
	
	--[[if class == 'DRUID' then
		local lifebloom = SetFontString(self.Health, 10)
		lifebloom:SetPoint('BOTTOM', self.Health, 1, 1)
		lifebloom.frequentUpdates = 1
		self:Tag(lifebloom, '|cff64ff64[leaflifebloom]')
	end]]
	
	self.DebuffHighlight = true
	self.DebuffFilter = true
	
	--self.Range = true
	self.SpellRange = .5
	self.inRangeAlpha = 1
	self.outsideRangeAlpha = .4
	
	self.RaidIcon = self.Health:CreateTexture(nil, 'OVERLAY')
	self.RaidIcon:SetPoint('TOP', self, 0, 4)
	self.RaidIcon:SetHeight(12)
	self.RaidIcon:SetWidth(12)
	
	self.Leader = self.Health:CreateTexture(nil, 'OVERLAY')
	self.Leader:SetPoint('TOPLEFT', self, 0, 6)
	self.Leader:SetHeight(12)
	self.Leader:SetWidth(12)
	
	self.Assistant = self.Health:CreateTexture(nil, 'OVERLAY')
	self.Assistant:SetAllPoints(self.Leader)
		
	self.MasterLooter = self.Health:CreateTexture(nil, 'OVERLAY')
	self.MasterLooter:SetPoint('LEFT', self.Leader, 'RIGHT')
	self.MasterLooter:SetHeight(12)
	self.MasterLooter:SetWidth(12)
	
	table.insert(self.__elements, ouf_leaf.updatemasterlooter)
	self:RegisterEvent('PARTY_LOOT_METHOD_CHANGED', ouf_leaf.updatemasterlooter)
	self:RegisterEvent('PARTY_MEMBERS_CHANGED', ouf_leaf.updatemasterlooter)
	self:RegisterEvent('PARTY_LEADER_CHANGED', ouf_leaf.updatemasterlooter)
	
	self.ReadyCheck = self.Health:CreateTexture(nil, 'OVERLAY')
	self.ReadyCheck:SetPoint('BOTTOM', self)
	self.ReadyCheck:SetHeight(12)
	self.ReadyCheck:SetWidth(12)
	
	self.RaidDebuffIcon = true
	self.RaidDebuffIcon_Size = 20
	
	self.leafHealComm = true
	
	if ouf_leaf.corner_indicators then
		local fu = ouf_leaf.corner_indicators_frequent_update and 1
		
		self.CI = {}
		
		local tl, tr, bl, br
		tl = indicators['TL']
		tr = indicators['TR']
		bl = indicators['BL']
		br = indicators['BR']
		
		if tl then
			self.CI.TL = SetFontString(self.Health, 22)
			self.CI.TL:SetPoint('BOTTOMLEFT', self, 'TOPLEFT', -5, -5)
			self.CI.TL.frequentUpdates = fu
			self:Tag(self.CI.TL, tl)
		end
		
		if tr then
			self.CI.TR = SetFontString(self.Health, 22)
			self.CI.TR:SetPoint('BOTTOMRIGHT', self, 'TOPRIGHT', 5, -5)
			self.CI.TR.frequentUpdates = fu
			self:Tag(self.CI.TR, tr)
		end
		
		if bl then
			self.CI.BL = SetFontString(self.Health, 22)
			self.CI.BL:SetPoint('BOTTOMLEFT', self, 'BOTTOMLEFT', -5, 5)
			self.CI.BL.frequentUpdates = fu
			self:Tag(self.CI.BL, bl)
		end
		
		if br then
			self.CI.BR = SetFontString(self.Health, 10)
			self.CI.BR:SetPoint('BOTTOMRIGHT', self, 'BOTTOMRIGHT', -5, 0)
			self.CI.BR.frequentUpdates = fu
			self:Tag(self.CI.BR, br)
		end
	end
	
	return self
end

oUF:RegisterStyle('leafRaid', styleFunc)
oUF:SetActiveStyle'leafRaid'

ouf_leaf.units.raid = {}
local raid = ouf_leaf.units.raid
for i = 1, 8 do
	local group = oUF:Spawn('header', 'oUF_Group'..i)
	group:SetManyAttributes('groupFilter', tostring(i), 'showRaid', true, 'yOffset', -5)
	tinsert(raid, group)
	if(i == 1) then
		group:SetManyAttributes('showParty', true, 'showPlayer', true)
		group:SetPoint('BOTTOMRIGHT', UIParent, -10, 10)
	else
		group:SetPoint('BOTTOMRIGHT', raid[i-1], 'BOTTOMLEFT', -5, 0)
	end
	group:Show()
end

local f = CreateFrame'frame'
f:RegisterEvent('PLAYER_ENTERING_WORLD')
f:SetScript('OnEvent', function(self, event, ...)
	if InCombatLockdown() then
		return self:RegisterEvent('PLAYER_REGEN_ENABLED')
	elseif self:IsEventRegistered('PLAYER_REGEN_ENABLED') then
		self:UnregisterEvent('PLAYER_REGEN_ENABLED')
	end
	
	local isIn, instanceType = IsInInstance()
	local pvp = false
	if isIn and instanceType == 'pvp' then
		pvp = true
	end
	
	for i = 6, 8 do
		local group = raid[i]
		local isshown = group:IsShown()
		if pvp then
			if not isshown then group:Show() end
		else
			if isshown then group:Hide() end
		end
	end
end)

if ouf_leaf.test_mod then
	oUF:Spawn('player'):SetPoint('CENTER', UIParent)
	oUF:Spawn('target'):SetPoint('CENTER', UIParent,55,0)
end

--[[

for i=1,4 do
	local party = 'PartyMemberFrame'..i
	local frame = _G[party]
	
	frame:UnregisterAllEvents()
	frame.Show = function() end
	frame:Hide()
	
	_G[party..'HealthBar']:UnregisterAllEvents()
	_G[party..'ManaBar']:UnregisterAllEvents()
end

]]