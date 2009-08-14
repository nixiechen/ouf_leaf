-- yleaf (yaroot@gmail.com)

local texture = [[Interface\AddOns\oUF_leaf\media\RoundBar]]
local bgtexture = [[Interface\AddOns\oUF_leaf\media\RoundBarBG]]

local xOffset, yOffset = 150, -50
local width, heigh = 100, 180
local GAP = 20

local texture_normal = ouf_leaf.texture
local SetFontString = ouf_leaf.createfont
--local backdrop = ouf_leaf.backdrop

local function SetMinMaxValues(self, min, max)
	self.maxvalue = max
	--self.minvalue = min
end

local function SetValue(self, value)
	self.tex:SetTexCoord(self.left and 1 or 0, self.left and 0 or 1, self.maxvalue == 0 and 1 or (1-value/self.maxvalue), 1)
end

local function setupStatusbar(self, texture)
	local tex = self:CreateTexture(nil, 'BACKGROUND')
	tex:SetBlendMode('BLEND')
	tex:SetTexture(texture)
	tex:SetAllPoints(self)
	
	self:SetStatusBarTexture(tex)
	self.tex = tex
	
	self.SetMinMaxValues = SetMinMaxValues
	self.SetValue = SetValue
end

local index = 0
local function styleFunc(self, unit)
	self.menu = ouf_leaf.menu
	self:RegisterForClicks('AnyUp')
	self:SetAttribute('type2', 'menu')
	
	self.Health = CreateFrame('StatusBar', nil, self)
	self.Health.frequentUpdates = true
	self.Health.colorSmooth = true
	self.Health.left = true
	
	self.Health:SetWidth(width)
	self.Health:SetHeight(heigh)
	self.Health:SetPoint('CENTER', UIParent, - xOffset - (GAP*index), yOffset)
	
	setupStatusbar(self.Health, texture)
	
	local healthbg = self.Health:CreateTexture(nil, 'BORDER')
	healthbg:SetAllPoints(self.Health)
	healthbg:SetTexture(bgtexture)
	healthbg:SetTexCoord(1,0,0,1)
	healthbg:SetAlpha(.3)
	
	self.Power = CreateFrame('StatusBar', nil, self)
	self.Power.frequentUpdates = true
	self.Power.colorPower = true
	
	self.Power:SetWidth(width)
	self.Power:SetHeight(heigh)
	self.Power:SetPoint('CENTER', UIParent, xOffset + (GAP*index), yOffset)
	
	setupStatusbar(self.Power, texture)
	
	local powerbg = self.Power:CreateTexture(nil, 'BORDER')
	powerbg:SetAllPoints(self.Power)
	powerbg:SetTexture(bgtexture)
	powerbg:SetAlpha(.3)
	
	local mp = SetFontString(self.Power)
	mp.frequentUpdates = 0.5
	if unit == 'player' then
		mp:SetPoint('BOTTOMLEFT', self.Health, 'BOTTOMRIGHT', 0, 15)
	else
		mp:SetPoint('BOTTOMRIGHT', self.Power, 'BOTTOMLEFT', 0 - GAP, 15)
	end
	self:Tag(mp, '[perpp]')
	
	local hp = SetFontString(self.Health)
	hp.frequentUpdates = 0.5
	hp:SetPoint('BOTTOM', mp, 'TOP', 0, 5)
	self:Tag(hp, '[perhp]')
	
	--local name = SetFontString(self)
	--name:SetPoint('CENTER', self)
	
	--[[if unit == 'player' then
		self.Castbar = CreateFrame('StatusBar', nil, self)
		self.Castbar:SetFrameStrata('HIGH')
		self.Castbar:SetStatusBarTexture(texture_normal)
		self.Castbar:SetStatusBarColor(.4,.6,.8)
		self.Castbar:SetBackdrop(backdrop)
		self.Castbar:SetBackdropColor(0, 0, 0, .6)
		
		self.Castbar:SetHeight(20)
		self.Castbar:SetWidth(xOffset+16)
		self.Castbar:SetPoint('CENTER', UIParent, 0, -heigh/2+20)
		
		self.Castbar.Text = SetFontString(self.Castbar)
		self.Castbar.Text:SetPoint('LEFT', self.Castbar, 2, 0)
		
		self.Castbar.Time = SetFontString(self.Castbar)
		self.Castbar.Time:SetPoint('RIGHT', self.Castbar, -2, 0)
		
		self.Castbar.SafeZone = self.Castbar:CreateTexture(nil,'ARTWORK')
		self.Castbar.SafeZone:SetPoint('TOPRIGHT')
		self.Castbar.SafeZone:SetPoint('BOTTOMRIGHT')
		self.Castbar.SafeZone:SetTexture(texture_normal)
		self.Castbar.SafeZone:SetVertexColor(.8, .2, .2, .7)	
	end]]
	
	--[[if unit == 'target' then
		self:Tag(name, '[difficulty][smartlevel]|r [raidcolor][name]|r')
		
		self.Buffs = CreateFrame('Frame', nil, self)
		self.Buffs:SetPoint('TOP', self, 'BOTTOM', 0, -5)
		self.Buffs:SetHeight(16)
		self.Buffs:SetWidth(320)
		self.Buffs.size = 16
		self.Buffs.spacing = 4
		self.Buffs.initialAnchor = 'TOPLEFT'
		self.Buffs['growth-x'] = 'RIGHT'
		self.Buffs['growth-y'] = 'DOWN'
		
		self.Debuffs = CreateFrame('Frame', nil, self)
		self.Debuffs:SetPoint('TOP', self, 'BOTTOM', 0, -45)
		self.Debuffs:SetHeight(16)
		self.Debuffs:SetWidth(320)
		self.Debuffs.size = 16
		self.Debuffs.spacing = 4
		self.Debuffs.initialAnchor = 'TOPLEFT'
		self.Debuffs['growth-x'] = 'RIGHT'
		self.Debuffs['growth-y'] = 'DOWN'
	else
		self:Tag(name, '[difficulty][smartlevel]|r')
	end]]
	
	self.ignoreHealComm = true
	
	if unit == 'target' then
		self.SpellRange = true
		self.inRangeAlpha = 1
		self.outsideRangeAlpha = .4
		--[[self:SetAttribute('initial-height', 20)
		self:SetAttribute('initial-width', 140)]]
	else
		self.BarFade = true
		--[[self:SetAttribute('initial-height', 20)
		self:SetAttribute('initial-width', 20)]]
	end
	self:SetAttribute('initial-height', 0.000001)
	self:SetAttribute('initial-width', 0.000001)
	
	index = index + 1
end
oUF:RegisterStyle('hud', styleFunc)
oUF:SetActiveStyle'hud'

--oUF:Spawn('player'):SetPoint('CENTER', UIParent, -100, - heigh/2 - 10)
--oUF:Spawn('target'):SetPoint('CENTER', UIParent, 0, - heigh/2 - 10)

oUF:Spawn('player'):SetPoint('TOPRIGHT', UIParent)
oUF:Spawn('target'):SetPoint('TOPRIGHT', UIParent)
