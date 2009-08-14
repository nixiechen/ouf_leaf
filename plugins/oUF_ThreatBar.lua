--[[
	yleaf (yaroot@gmail.com)

	.ThreatBar
		.smooth
	
	.frequent
	
	.Text
		.smooth
	
	.bg
		.multiplier
--]]

local parent = debugstack():match[[\AddOns\(.-)\]]
local global = GetAddOnMetadata(parent, 'X-oUF')
global = global or 'oUF'
local oUF = _G[global]

local frequent = 1
--local active = false
local ColorGradient = oUF.ColorGradient
local smooth = {80/255,160/255,80/255, 225/255,225/255,65/255, 240/255,55/255,0/255}
--if (not UnitExists(tv.unit)) or (not UnitCanAttack('player', tv.unit)) or (not UnitExists'pet' and GetNumPartyMembers() == 0 and GetNumRaidMembers() == 0) then

local total = 0
local function OnUpdate(self, elps)
	total = total - elps
	if total > 0 then return end
	total = frequent
	local isTanking, status, threatpct, rawthreatpct, threatvalue
	if UnitExists('target') then
		isTanking, status, threatpct, rawthreatpct, threatvalue = UnitDetailedThreatSituation('player', 'target')
	end
	if self.PostUpdate then
		self:PostUpdate(isTanking, status, threatpct, rawthreatpct, threatvalue)
	end
	
	if not threatpct then
		self:Hide()
		self.Text:Hide()
		return
	end
	
	if isTanking then threatpct = 100 end
	self:SetValue(threatpct)
	
	if self.smooth then
		local r,g,b = ColorGradient(threatpct / 100, unpack(self.smooth))
		self:SetStatusBarColor(r,g,b)
		
		local bg = self.bg
		if bg then
			local mu = bg.multiplier or 1
			bg:SetVertexColor(r*mu, g*mu, b*mu)
		end
	end
	
	local text = self.Text
	if text then
		text:SetText(isTanking and 'Aggro' or format('%d%%', threatpct))
		local r,g,b = ColorGradient(threatpct / 100, unpack(text.smooth))
		text:SetTextColor(r,g,b)
	end
end

local function Update(self, event, unit)
	if (self.unit == unit) then
		total = 0
		if not self.ThreatBar:IsShown() then
			self.ThreatBar:Show()
			self.ThreatBar.Text:Show()
		end
	end
end

local function Enable(self, unit)
	local bar = self.ThreatBar
	if bar and (unit == 'player') then
		if bar.frequent then frequent = bar.frequent end
		if bar.smooth and type(bar.smooth) ~= 'table' then
			bar.smooth = smooth
		end
		
		local text = bar.Text
		if text.smooth and type(text.smooth) ~= 'table' then
			text.smooth = smooth
		end
		
		bar:SetMinMaxValues(0, 100)
		bar:Hide()
		bar.Text:Hide()
		bar:SetScript('OnUpdate', OnUpdate)
		self:RegisterEvent('UNIT_THREAT_SITUATION_UPDATE', Update)
		self:RegisterEvent('UNIT_TARGET', Update)
		
		return true
	end
end

local function Disable(self)
	local bar = self.ThreatBar
	if bar then
		bar:SetScript('OnUpdate', nil)
		bar:Hide()
		self:UnregisterEvent('UNIT_THREAT_SITUATION_UPDATE', Update)
		self:UnregisterEvent('UNIT_TARGET', Update)
	end
end

oUF:AddElement('ThreatBar', Update, Enable, Disable)
