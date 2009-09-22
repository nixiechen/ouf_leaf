-- based on p3lim's work
-- yleaf (yaroot@gmail.com)

local oUF
do
	local parent = debugstack():match[[\AddOns\(.-)\]]
	local global = GetAddOnMetadata(parent, 'X-oUF')
	oUF = _G[global or 'oUF']
end


local _, class = UnitClass'player'
local texture = [=[Interface\AddOns\oUF_leaf\media\FlatSmooth]=]
local backdrop = ouf_leaf.backdrop

local function playerAuraFilter(icons, unit, icon, name, rank, texture, count, dtype, duration, timeLeft, caster)
	return ouf_leaf.playerAuraFilter[name]
end

local function PostCastStart(self)
	if self.Castbar.interrupt then
		self.Castbar.Text:SetTextColor(1,0,0)
	else
		self.Castbar.Text:SetTextColor(1,1,1)
	end
end

local function PostCreateAuraIcon(self, button, icons)
	button.icon:SetTexCoord(.1, .9, .1, .9)
	button.overlay:SetTexture([=[Interface\AddOns\oUF_leaf\media\phish]=])
	button.overlay:SetTexCoord(0, 1, 0, 1)
	button.overlay:SetPoint('TOPLEFT', button, -1, 1)
	button.overlay:SetPoint('BOTTOMRIGHT', button, 1, -1)
	--button.overlay:SetVertexColor(.25, .25, .25)
	button.overlay.SetVertexColor = function() end
	button.overlay.Hide = function() end
	
	local parent = button:GetParent()
	if parent.noTooltip then
		button:SetScript('OnEnter', nil)
		button:SetScript('OnLeave', nil)
		button:SetScript('OnClick', nil)
	end
end

local _is_mine = {player = true, vehicle = true, pet = true}
local function PostUpdateAuraIcon(self, icons, unit, icon, index, offset, filter, isDebuff)
	if not icon.debuff then return end
	if (not _is_mine[icon.owner]) and (not UnitIsFriend('player', unit)) then
		icon.icon:SetDesaturated(true)
	else
		icon.icon:SetDesaturated(false)
	end
end

local function CustomTimeText(self, duration)
	if self.casting then
		self.Time:SetFormattedText('%.1f / %.1f', (self.max - duration), self.max)
	elseif self.channeling then
		self.Time:SetFormattedText('%.1f / %.1f', duration, self.max)
	end
end

local function styleFunc(self, unit)
	self.colors = ouf_leaf.colors
	
	if (unit == 'player') or (unit == 'pet') or (unit == 'target') or (unit == 'focus') then
		self.menu = ouf_leaf.menu
		self:RegisterForClicks('AnyUp')
		self:SetAttribute('type2', 'menu')
	end
	
	self:SetScript('OnEnter', UnitFrame_OnEnter)
	self:SetScript('OnLeave', UnitFrame_OnLeave)
	--self:SetScript('OnLeave', function(...) UnitFrame_OnLeave(...); GameTooltip:Hide() end)
	
	self:SetBackdrop(backdrop)
	self:SetBackdropColor(0, 0, 0, .6)
	
	self.Health = CreateFrame('StatusBar', nil, self)
	self.Health:SetPoint('TOPRIGHT', self)
	self.Health:SetPoint('TOPLEFT', self)
	self.Health:SetStatusBarTexture(texture)
	self.Health:SetStatusBarColor(.15,.15,.15)
	self.Health:SetHeight(23)
	
	self.Health.frequentUpdates = true
	self.Health.colorHealth = true
	self.Health.colorTapping = true
	self.Health.colorDisconnected = true
	--[[
	 - colorTapping
	 - colorDisconnected
	 - colorHappiness
	 - colorClass (Colors player units based on class)
	 - colorClassPet (Colors pet units based on class)
	 - colorClassNPC (Colors non-player units based on class)
	 - colorReaction
	 - colorSmooth - will use smoothGradient instead of the internal gradient if set.
	 - colorHealth
	]]
	self.Health.bg = self.Health:CreateTexture(nil, 'BORDER')
	self.Health.bg:SetAllPoints(self.Health)
	self.Health.bg:SetTexture(texture)
	--self.Health.bg:SetVertexColor(.3,.3,.3)
	self.Health.bg.multiplier = 2
	
	self.Power = CreateFrame('StatusBar', nil, self)
	self.Power:SetPoint('TOPLEFT', self.Health, 'BOTTOMLEFT')
	self.Power:SetPoint('BOTTOMRIGHT', self)
	self.Power:SetStatusBarTexture(texture)
	
	self.Power.frequentUpdates = true
	self.Power.colorClass = true
	self.Power.colorClassNPC = true
	self.Power.colorHappiness = true
	--[[
	 - colorTapping
	 - colorDisconnected
	 - colorHappiness
	 - colorPower
	 - colorClass (Colors player units based on class)
	 - colorClassPet (Colors pet units based on class)
	 - colorClassNPC (Colors non-player units based on class)
	 - colorReaction
	 - colorSmooth - will use smoothGradient instead of the internal gradient if set.
	]]
	self.Power.bg = self.Power:CreateTexture(nil, 'BORDER')
	self.Power.bg:SetAllPoints(self.Power)
	self.Power.bg:SetTexture(texture)
	self.Power.bg.multiplier = .5
	
	local tag1 = self.Health:CreateFontString(nil, 'OVERLAY')
	tag1:SetFont(STANDARD_TEXT_FONT, 11, 'OUTLINE')
	tag1:SetPoint('LEFT', self.Health, 2, 0)
	local tag2 = self.Health:CreateFontString(nil, 'OVERLAY')
	tag2:SetFont(STANDARD_TEXT_FONT, 11, 'OUTLINE')
	tag2:SetPoint('RIGHT', self.Health, -2, 0)
	
	if unit == 'target' or unit == 'player' then
		self:Tag(tag2, '|cff50a050[leafcurhp] |r- |cff50a050[leafperhp]|r%')
		if unit == 'player' then
			self:Tag(tag1, '[leafcolorpower][leafcurpp]|r - [leafcolorpower][leafperpp]|r%')
		else
			self:Tag(tag1, '[leafdifficulty][leafsmartlevel] [leafraidcolor][leafname]')
		end
	else
		if unit == 'pet' then
			self:Tag(tag1, '[leafthreatcolor][leafname]')
		else
			self:Tag(tag1, '[leafraidcolor][leafname]')
		end
		self:Tag(tag2, '|cff50a050[leafperhp]|r%')
	end
	
	if unit == 'player' or unit == 'target' then
		self:SetAttribute('initial-height', 30)
		self:SetAttribute('initial-width', 230)
	
	elseif(unit == 'pet') then
		self.Health:SetHeight(19)
		
		self.Power.colorPower = true
		self.Power.colorHappiness = true
		self.Power.colorReaction = false
		
		self.Auras = CreateFrame('Frame', nil, self)
		self.Auras:SetPoint('TOPRIGHT', self, 'TOPLEFT', -5, 0)
		self.Auras:SetHeight(22)
		self.Auras:SetWidth(180)
		self.Auras.size = 22
		self.Auras.spacing = 2
		self.Auras['growth-x'] = 'LEFT'
		self.Auras['growth-y'] = 'DOWN'
		self.Auras.initialAnchor = 'TOPRIGHT'
		self.Auras.numBuffs = 14
		self.Auras.numDebuffs = 21
		
		self:SetAttribute('initial-height', 23)
		self:SetAttribute('initial-width', 190)
		
	elseif(unit == 'focus' or unit == 'focustarget' or unit == 'targettarget' or unit == 'targettargettarget') then
		self.Health:SetHeight(18)
		
		self.Debuffs = CreateFrame('Frame', nil, self)
		self.Debuffs:SetHeight(20)
		self.Debuffs:SetWidth(40)
		self.Debuffs.num = 2
		self.Debuffs.size = 21
		self.Debuffs.spacing = 3
		if unit == 'targettarget' or unit == 'targettargettarget' then
			self.Debuffs:SetPoint('TOPRIGHT', self, 'TOPLEFT', -3, 0)
			self.Debuffs.initialAnchor = 'TOPRIGHT'
			self.Debuffs['growth-x'] = 'LEFT'
		else
			self.Debuffs:SetPoint('TOPLEFT', self, 'TOPRIGHT', 3, 0)
			self.Debuffs.initialAnchor = 'TOPLEFT'
		end
		
		self:SetAttribute('initial-height', 22)
		self:SetAttribute('initial-width', 180)
		
	elseif not unit then
		self.Health:SetHeight(18)
		self:SetAttribute('initial-height', 22)
		self:SetAttribute('initial-width', 130)
	end
	
	if(unit == 'player' or unit == 'target' or unit == 'focus' or unit == 'pet') then
		self.Castbar = CreateFrame('StatusBar', nil, self)
		self.Castbar:SetStatusBarTexture(texture)
		self.Castbar:SetStatusBarColor(.15,.15,.15)
		
		self.Castbar.bg = self.Castbar:CreateTexture(nil, 'BACKGROUND')
		self.Castbar.bg:SetAllPoints(self.Castbar)
		self.Castbar.bg:SetTexture(texture)
		self.Castbar.bg:SetVertexColor(.5,.5,.5,.5)
		
		self.Castbar.Text = self.Castbar:CreateFontString(nil, 'OVERLAY')
		self.Castbar.Text:SetFont(STANDARD_TEXT_FONT, 11, 'OUTLINE')
		self.Castbar.Text:SetPoint('LEFT', self.Castbar, 2, 0)
		
		self.Castbar.Time = self.Castbar:CreateFontString(nil, 'OVERLAY')
		self.Castbar.Time:SetFont(STANDARD_TEXT_FONT, 11, 'OUTLINE')
		self.Castbar.Time:SetPoint('RIGHT', self.Castbar, -2, 0)
		
		if unit == 'player' then
			self.Castbar:SetHeight(20)
			self.Castbar:SetWidth(300)
			self.Castbar:SetPoint('CENTER', UIParent, 0, -180)
			
			self.Castbar.SafeZone = self.Castbar:CreateTexture(nil,'BORDER')
			self.Castbar.SafeZone:SetPoint('TOPRIGHT')
			self.Castbar.SafeZone:SetPoint('BOTTOMRIGHT')
			self.Castbar.SafeZone:SetTexture(texture)
			self.Castbar.SafeZone:SetVertexColor(.8, .2, .2)
			
			self.Castbar.CustomTimeText = CustomTimeText
			
			--[[if (not ouf_leaf.nogcd) then
				self.GCDBar = CreateFrame('StatusBar', nil, self)
				self.GCDBar:SetHeight(1)
				self.GCDBar:SetWidth(self.Castbar:GetWidth())
				
				self.GCDBar:SetStatusBarTexture(texture)
				self.GCDBar:SetStatusBarColor(0.55, 0.57, 0.61, 0.5)
				self.GCDBar:SetBackdrop(backdrop)
				self.GCDBar:SetBackdropColor(0, 0, 0, .3)
				self.GCDBar:SetPoint('TOPLEFT', self.Castbar, 'BOTTOMLEFT', 0, -1)
			end]]
			
			--[[if (not ouf_leaf.noswing) then
				self.Swing = CreateFrame('StatusBar', nil, self)
				self.Swing:SetHeight(1)
				self.Swing:SetWidth(self.Castbar:GetWidth())
				
				self.Swing:SetStatusBarTexture(texture)
				self.Swing:SetStatusBarColor(0.55, 0.57, 0.61, 0.5)
				self.Swing:SetBackdrop(backdrop)
				self.Swing:SetBackdropColor(0, 0, 0, .3)
				self.Swing:SetPoint('BOTTOMLEFT', self.Castbar, 'TOPLEFT', 0, 1)
			end]]
			
			self.MirrorBar = {}
			for i = 1, MIRRORTIMER_NUMTIMERS do
				self.MirrorBar[i] = CreateFrame('StatusBar', nil, UIParent)
				self.MirrorBar[i]:SetHeight(15)
				self.MirrorBar[i]:SetWidth(200)
				self.MirrorBar[i]:SetStatusBarTexture(texture)
				self.MirrorBar[i]:SetBackdrop(backdrop)
				self.MirrorBar[i]:SetBackdropColor(.5,.5,.5,.5)
				
				if i == 1 then
					self.MirrorBar[i]:SetPoint('TOP', UIParent, 0, -100)
				else
					self.MirrorBar[i]:SetPoint('TOP', self.MirrorBar[i-1], 'BOTTOM', 0, -5)
				end
				
				self.MirrorBar[i].Text = self.MirrorBar[i]:CreateFontString(nil, 'OVERLAY')
				self.MirrorBar[i].Text:SetFont(STANDARD_TEXT_FONT, 9, 'OUTLINE')
				self.MirrorBar[i].Text:SetPoint('CENTER', self.MirrorBar[i])
				
				self.MirrorBar[i].Time = self.MirrorBar[i]:CreateFontString(nil, 'OVERLAY')
				self.MirrorBar[i].Time:SetFont(STANDARD_TEXT_FONT, 9, 'OUTLINE')
				self.MirrorBar[i].Time:SetPoint('RIGHT', self.MirrorBar[i], -2, 0)
			end
			
		elseif unit == 'pet' then
			self.Castbar:SetPoint('BOTTOMLEFT', self, 'TOPLEFT', 0, 1)
			self.Castbar:SetPoint('TOPRIGHT', self, 0, 15)
		else
			self.PostChannelStart = PostCastStart
			self.PostCastStart = PostCastStart
			self.Castbar:SetHeight(16)
			self.Castbar:SetWidth(230)
			if unit == 'target' then
				self.Castbar:SetPoint('BOTTOMLEFT', self, 'TOPLEFT', 0, 100)
			else -- focus
				self.Castbar:SetPoint('BOTTOMRIGHT', oUF.units.player, 'TOPRIGHT', 0, 100)
			end
		end
	end
	
	if(unit == 'target') then
		self.Buffs = CreateFrame('Frame', nil, self)
		self.Buffs:SetPoint('BOTTOMRIGHT', self, 'TOPRIGHT', 0, 5)
		self.Buffs:SetHeight(22)
		self.Buffs:SetWidth(230)
		self.Buffs.size = 22
		self.Buffs.spacing = 4
		self.Buffs.initialAnchor = 'BOTTOMRIGHT'
		self.Buffs['growth-x'] = 'LEFT'
		
		self.Debuffs = CreateFrame('Frame', nil, self)
		self.Debuffs:SetPoint('TOPLEFT', self, 'TOPRIGHT', 5, 0)
		self.Debuffs:SetHeight(22)
		self.Debuffs:SetWidth(240)
		self.Debuffs.size = 22
		self.Debuffs.spacing = 2
		self.Debuffs.initialAnchor = 'TOPLEFT'
		self.Debuffs['growth-y'] = 'DOWN'
		
		self.Auras = CreateFrame('Frame', nil, self)
		self.Auras:SetPoint('CENTER', UIParent, 90, -85)
		self.Auras:SetHeight(24)
		self.Auras:SetWidth(24)
		self.Auras.size = 24
		self.Auras.spacing = 4
		self.Auras.initialAnchor = 'BOTTOMRIGHT'
		self.Auras.onlyShowPlayer = true
		self.Auras.numBuffs = 0
		self.Auras.numDebuffs = 6
		
		self.Auras.noTooltip = true
		
		self.PostUpdateAuraIcon = PostUpdateAuraIcon
	elseif unit == 'player' then
		if ouf_leaf.playerAuraFilter then
			self.Auras = CreateFrame('Frame', nil, self)
			self.Auras:SetPoint('CENTER', UIParent, -90, -85)
			self.Auras:SetHeight(24)
			self.Auras:SetWidth(24)
			self.Auras.size = 24
			self.Auras.spacing = 4
			self.Auras.initialAnchor = 'BOTTOMRIGHT'
			self.Auras.numBuffs = 6
			self.Auras.numDebuffs = 0
			
			self.Auras.noTooltip = true
			
			self.CustomAuraFilter = playerAuraFilter
		end
		
		self.Health.SmoothUpdate = true
		
		local cp = self.Health:CreateFontString(nil, 'OVERLAY')
		cp:SetFont(DAMAGE_TEXT_FONT, 50, 'OUTLINE')
		cp:SetPoint('BOTTOM', UIParent, 'CENTER', 0, -150)
		self:Tag(cp, '[leafcp]')
		
		self.Leader = self.Health:CreateTexture(nil, 'OVERLAY')
		self.Leader:SetPoint('TOPLEFT', self, 0, 8)
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
		
		self.Resting = self.Health:CreateTexture(nil, 'OVERLAY')
		self.Resting:SetHeight(14)
		self.Resting:SetWidth(14)
		self.Resting:SetPoint('CENTER', self, 'BOTTOMLEFT')
		self.Resting:SetTexture[[Interface\CharacterFrame\UI-StateIcon]]
		self.Resting:SetTexCoord(.08, .41, .08, 0.41)
		
		self.Combat = self.Health:CreateTexture(nil, 'OVERLAY')
		self.Combat:SetHeight(14)
		self.Combat:SetWidth(14)
		self.Combat:SetPoint('CENTER', self, 'BOTTOMLEFT')
		self.Combat:SetTexture('Interface\\CharacterFrame\\UI-StateIcon')
		self.Combat:SetTexCoord(0.58, 0.90, 0.08, 0.41)
		
		self.PvP = self.Health:CreateTexture(nil, 'OVERLAY')
		self.PvP:SetHeight(30)
		self.PvP:SetWidth(30)
		self.PvP:SetPoint('CENTER', self, 'TOPLEFT', 5, -10)
		
		local threatText = self.Health:CreateFontString(nil, 'OVERLAY')
		threatText:SetFont(STANDARD_TEXT_FONT, 14, 'OUTLINE')
		threatText:SetPoint('CENTER', self.Health)
		threatText.frequentUpdates = .5
		self:Tag(threatText, '[leafthreatpct]')
		
		--[=[if (not ouf_leaf.nofsr) then
			self.FSR = CreateFrame('frame', nil, self)
			self.FSR:SetAllPoints(self.Power)
			self.FSR.width = 230
			self.FSR.height = 7
			
			self.FSR.Spark = self.Power:CreateTexture(nil, 'OVERLAY')
			self.FSR.Spark:SetTexture[[Interface\CastingBar\UI-CastingBar-Spark]]
			self.FSR.Spark:SetBlendMode('ADD')
			self.FSR.Spark:SetHeight(self.FSR.height*2)
			self.FSR.Spark:SetWidth(self.FSR.height)
		end]=]
		
		
		
		if class == 'DRUID' then
			local druidPower = self.Health:CreateFontString(nil, 'OVERLAY')
			druidPower:SetFont(STANDARD_TEXT_FONT, 11, 'OUTLINE')
			druidPower:SetPoint('BOTTOM', self.Power)
			self:Tag(druidPower, '[leafdruidpower]')
		elseif class == 'DEATHKNIGHT' then
			self.Runes = CreateFrame('Frame', nil, self)
			self.Runes:SetPoint('BOTTOMLEFT', self, 'TOPLEFT', 0, 1)
			self.Runes:SetPoint('RIGHT', self, 'RIGHT')
			self.Runes:SetHeight(7)
			self.Runes:SetBackdrop(backdrop)
			self.Runes:SetBackdropColor(0, 0, 0, .5)
			
			self.Runes.height = 7
			self.Runes.width = 230/6 - 1
			
			self.Runes.spacing = 1
			self.Runes.anchor = 'BOTTOMLEFT'
			self.Runes.growth = 'RIGHT'
			--self.Runes.order = {1,2,3,4,5,6}

			for i = 1, 6 do
				self.Runes[i] = CreateFrame('StatusBar', nil, self.Runes)
				self.Runes[i]:SetStatusBarTexture(texture)
				
				self.Runes[i].bg = self.Runes[i]:CreateTexture(nil, 'BORDER')
				self.Runes[i].bg:SetAllPoints(self.Runes[i])
				self.Runes[i].bg:SetTexture(texture)
				self.Runes[i].bg.multiplier = .5
			end
		elseif class == 'SHAMAN' then
			self.TotemBar = {}
			self.TotemBar.destroy = true
			for i = 1, 4 do
				self.TotemBar[i] = CreateFrame('StatusBar', nil, self)
				
				self.TotemBar[i]:SetHeight(7)
				self.TotemBar[i]:SetWidth(230/4 - .85)
				if i == 1 then
					self.TotemBar[i]:SetPoint('BOTTOMLEFT', self, 'TOPLEFT', 0, 1)
				else
					self.TotemBar[i]:SetPoint('TOPLEFT', self.TotemBar[i-1], 'TOPRIGHT', 1, 0)
				end
				
				self.TotemBar[i]:SetStatusBarTexture(texture)
				self.TotemBar[i]:SetBackdrop(backdrop)
				self.TotemBar[i]:SetBackdropColor(0, 0, 0)
				self.TotemBar[i]:SetMinMaxValues(0, 1)
				
				self.TotemBar[i].bg = self.TotemBar[i]:CreateTexture(nil, 'BORDER')
				self.TotemBar[i].bg:SetAllPoints(self.TotemBar[i])
				self.TotemBar[i].bg:SetTexture(texture)
				--self.TotemBar[i].bg:SetVertexColor(0.15, 0.15, 0.15)
				self.TotemBar[i].bg.multiplier = .3
			end
		end
	end
	
	self.RaidIcon = self.Health:CreateTexture(nil, 'OVERLAY')
	self.RaidIcon:SetPoint('TOP', self, 0, 8)
	self.RaidIcon:SetHeight(16)
	self.RaidIcon:SetWidth(16)
	
	if (unit == 'pet') or (unit == 'player') then
		self.BarFade = true
	end
	
	if unit then
		self.HealComm = true
	else
		self.ignoreHealComm = true
	end
	
	if (unit ~= 'player') then
		self.SpellRange = .5
		self.inRangeAlpha = 1
		self.outsideRangeAlpha = .4
	end
	
	self.disallowVehicleSwap = true
	
	self.DebuffHighlight = true
	self.DebuffFilter = true
	
	self.PostCreateAuraIcon = PostCreateAuraIcon
	
	return self
end

oUF:RegisterStyle('leaf', styleFunc)
oUF:SetActiveStyle('leaf')

oUF:Spawn('player'):SetPoint('CENTER', UIParent, -300, -180)
oUF:Spawn('target'):SetPoint('CENTER', UIParent, 300, -180)
oUF:Spawn('targettarget'):SetPoint('TOPRIGHT', oUF.units.target, 'BOTTOMRIGHT', 0, -10)
--oUF:Spawn('targettargettarget'):SetPoint('TOPRIGHT', oUF.units.targettarget, 'BOTTOMRIGHT', 0, -5)
oUF:Spawn('focus'):SetPoint('TOPLEFT', oUF.units.player, 'BOTTOMLEFT', 0, -10)
--oUF:Spawn('focustarget'):SetPoint('TOPLEFT', oUF.units.focus, 'BOTTOMLEFT', 0, -5)
oUF:Spawn('pet'):SetPoint('BOTTOMLEFT', oUF.units.player, 'TOPLEFT', 0, 13)

RuneFrame:UnregisterAllEvents()
RuneFrame:Hide()
TotemFrame:UnregisterAllEvents()
TotemFrame:Hide()
