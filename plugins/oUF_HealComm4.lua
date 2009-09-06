--[[
	oUF_HealComm
		makes use of LibHealComm-4.0
	
	setup:
	.HealComm [boolean]
	.HealComm_Color [table]	default: {0,1,0,.5}
	.HealComm_BarTexture [string]	nil for Health bar texture
	.PostHealCommUpdate [function] (self, guid, modifiedIncoming)
	
	.HealCommBar [statusbar]
]]

local oUF
do
	local parent = debugstack():match[[\AddOns\(.-)\]]
	local global = GetAddOnMetadata(parent, 'X-oUF')
	oUF = _G[global or 'oUF']
end

oUF_HealComm = {}
oUF_HealComm.debug = false

local HealComm = LibStub and LibStub('LibHealComm-4.0')
assert(HealComm, 'oUF_HealComm requires LibHealComm-4.0')

local addon = oUF_HealComm
local objs = {}
addon.objects = objs

local function debug(...)
	if addon.debug then print(...) end
end

local healFLAG = bit.bor(HealComm.DIRECT_HEALS, HealComm.CHANNEL_HEALS)

local function updateHCB(self, guid)
	local incoming = HealComm:GetHealAmount(guid, healFLAG)
	if incoming then
		incoming = incoming * HealComm:GetHealModifier(guid)
		local bar = self.HealCommBar
		local c,m = UnitHealth(self.unit), UnitHealthMax(self.unit)
		local w,h = self.Health:GetWidth(), self.Health:GetHeight()
		if bar.VERTICAL then
			bar:SetHeight(incoming/m * h)
			bar:SetWidth(w)
			bar:SetPoint('BOTTOMLEFT', self.Health, 0, c/m * h)
		else
			bar:SetHeight(h)
			bar:SetWidth(incoming/m * w)
			bar:SetPoint('BOTTOMLEFT', self.Health, c/m * w, 0)
		end
		bar:Show()
	else
		self.HealCommBar:Hide()
	end
	if self.PostHealCommUpdate then self:PostHealCommUpdate(guid, incoming) end
end

local function updateGUIDs(...)
	for i = 1, select('#', ...) do
		local guid = select(i, ...)
		
		for dummy, obj in pairs(objs) do
			if (guid == obj.GUID) and obj:IsShown() then
				debug('updateHCB', obj.unit)
				updateHCB(obj, guid)
			end
		end
	end
end

function addon:HealComm_HealStarted(casterGUID, spellID, healType, endTime, ...)
	debug('HealComm_HealStarted')
	updateGUIDs(...)
end

function addon:HealComm_HealUpdated(casterGUID, spellID, type, endTime, ...)
	debug('HealComm_HealUpdated')
	updateGUIDs(...)
end

function addon:HealComm_HealDelayed(casterGUID, spellID, type, endTime, ...)
	debug('HealComm_HealDelayed')
	updateGUIDs(...)
end

function addon:HealComm_HealStopped(casterGUID, spellID, type, interrupted, ...)
	debug('HealComm_HealStopped')
	updateGUIDs(...)
end

function addon:HealComm_ModifierChanged(guid, newModifier)
	debug('HealComm_ModifierChanged')
	updateGUIDs(guid)
end

HealComm.RegisterCallback(addon, 'HealComm_HealStarted')
--HealComm.RegisterCallback(addon, 'HealComm_HealDelayed')
HealComm.RegisterCallback(addon, 'HealComm_HealUpdated')
HealComm.RegisterCallback(addon, 'HealComm_HealStopped')
HealComm.RegisterCallback(addon, 'HealComm_ModifierChanged')


local function updateObjGUID(self)
	debug('updateObjGUID', self.unit)
	self.GUID = self.unit and UnitGUID(self.unit)
end

local function PostUpdateHealth(self, ...)
	if self.HealCommBar.PostUpdateHealth then self.HealCommBar.PostUpdateHealth(...) end
	updateHCB(self, self.GUID)
end

local function setPostUpdateHealth(self)
	self.HealCommBar.PostUpdateHealth = self.PostUpdateHealth
	self.PostUpdateHealth = PostUpdateHealth
end

local function setGUIDUpdate(self)
	if not self.GUIDUpdate then
		self.GUIDUpdate = true
		updateObjGUID(self)
		tinsert(self.__elements, updateObjGUID)
		--self:RegisterEvent('PLAYER_ENTERING_WORLD', updateObjGUID)
	end
end

local default_color = {0,1,0,.5}
local function setup(self)
	if self.HealComm then
		self.HealCommBar = CreateFrame('StatusBar', nil, self)
		local bar = self.HealCommBar
		bar.VERTICAL = self.Health:GetOrientation() == 'VERTICAL'
		if bar.VERTICAL then
			bar:SetOrientation('VERTICAL')
		end
		bar:SetStatusBarTexture(self.HealComm_BarTexture or self.Health:GetStatusBarTexture():GetTexture())
		bar:SetStatusBarColor(unpack(self.HealComm_Color or default_color))
		bar:SetMinMaxValues(0,1)
		bar:SetValue(1)
		bar:SetFrameStrata('TOOLTIP')
		bar:Hide()
		
		setPostUpdateHealth(self)
		setGUIDUpdate(self)
		
		tinsert(objs, self)
	end
end

for i, frame in ipairs(oUF.objects) do setup(frame) end
oUF:RegisterInitCallback(setup)
