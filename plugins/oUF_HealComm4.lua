--[[
	oUF_leafHealComm
		makes use of LibHealComm-4.0
	
	setup:
	.leafHealComm [boolean]
	.leafHealComm_Color [table]	default: {0,1,0,.5}
	.leafHealComm_BarTexture [string]	nil for Health bar texture
	.PostleafHealCommUpdate [function] (self, guid, modifiedIncoming)
	
	.leafHealCommBar [statusbar]
]]

--local oUF = _G.oUF
local HealComm = LibStub and LibStub('LibHealComm-4.0')
assert(HealComm, 'oUF_leafHealComm requires LibHealComm-4.0')
local debug = false

if debug then debug = function(...) print(...) end
else debug = function() end end

oUF_leafHealComm = {}
local addon = oUF_leafHealComm
local objs = {}
addon.objects = objs

local healFLAG = bit.bor(HealComm.DIRECT_HEALS, HealComm.CHANNEL_HEALS)

local function updateHCB(self, guid)
	local incoming = HealComm:GetHealAmount(guid, healFLAG)
	if incoming then
		incoming = incoming * HealComm:GetHealModifier(guid)
		local bar = self.leafHealCommBar
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
		self.leafHealCommBar:Hide()
	end
	if self.PostleafHealCommUpdate then self:PostleafHealCommUpdate(guid, incoming) end
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
	if self.leafHealCommBar.PostUpdateHealth then self.leafHealCommBar.PostUpdateHealth(...) end
	updateHCB(self, self.GUID)
end

local function setPostUpdateHealth(self)
	self.leafHealCommBar.PostUpdateHealth = self.PostUpdateHealth
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
	if self.leafHealComm then
		self.leafHealCommBar = CreateFrame('StatusBar', nil, self)
		local bar = self.leafHealCommBar
		bar.VERTICAL = self.Health:GetOrientation() == 'VERTICAL'
		if bar.VERTICAL then
			bar:SetOrientation('VERTICAL')
		end
		bar:SetStatusBarTexture(self.leafHealComm_BarTexture or self.Health:GetStatusBarTexture():GetTexture())
		bar:SetStatusBarColor(unpack(self.leafHealComm_Color or default_color))
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
