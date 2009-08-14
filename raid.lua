-- yleaf (yaroot@gmail.com)

if ouf_leaf.noraid then return end

local _, class = UnitClass'player'
local texture = [[Interface\AddOns\oUF_leaf\media\white]]
local SetFontString = ouf_leaf.createfont

local backdrop = {
	bgFile = [=[Interface\ChatFrame\ChatFrameBackground]=], tile = true, tileSize = 16,
	insets = {top = -1, left = -1, bottom = -1, right = -1},
}

local function OverrideUpdateHealth(self, event, unit, bar, min, max)
	if bar.disconnected or UnitIsDeadOrGhost(unit) then
		bar.c = self.colors.disconnected
	else
		bar.c = self.colors.class[select(2, UnitClass(unit))]
	end
	bar.bg:SetVertexColor(unpack(bar.c))
end

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
	text:SetPoint('CENTER', self.Health)
	--text.frequentUpdates = .5
	self:Tag(text, '[leafraid]')
	
	if class == 'DRUID' then
		local lifebloom = SetFontString(self.Health, 10)
		lifebloom:SetPoint('BOTTOM', self.Health, 0, 1)
		lifebloom.frequentUpdates = 1
		self:Tag(lifebloom, '[leaflifebloom]')
	end
	
	self.DebuffHighlightBackdrop = true
	self.DebuffHighlightFilter = true
	
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
	
	self.Threat = CreateFrame('Frame', nil, self)
	self.Threat:SetPoint('TOPLEFT', self, 'TOPLEFT', -4, 4)
	self.Threat:SetPoint('BOTTOMRIGHT', self, 4.5, -4.5)
	self.Threat:SetFrameStrata('BACKGROUND')
	self.Threat:SetBackdrop({
		edgeFile = [[Interface\AddOns\oUF_leaf\media\glowTex]], edgeSize = 5,
		insets = {left = 3, right = 3, top = 3, bottom = 3}
	})
	
	self.CornerIndicators = true
	self.RaidDebuffIcon = true
	self.RaidDebuffIcon_Size = 20
	
	self.OverrideUpdateThreat = ouf_leaf.OverrideUpdateThreat
	
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


--oUF:Spawn('player'):SetPoint('CENTER', UIParent)
--oUF:Spawn('target'):SetPoint('CENTER', UIParent,55,0)

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