--[[
	by yleaf (yaroot@gmail.com)
	A GridStatusRaidDebuff-like ouf plugin
	
	Debuff data come from GridStatusRaidDebuff
	
	
	* layout setup
	- RaidDebuffIcon
	- RaidDebuffIcon_Size
	
	reset the mod:
		/oufrd
		/oufraiddebuff
		/raiddebuff
		/ord
]]

local oUF
do
	local parent = debugstack():match[[\AddOns\(.-)\]]
	local global = GetAddOnMetadata(parent, 'X-oUF')
	oUF = _G[global or 'oUF']
end


local debug, debugf = function() end
local SetFontString = ouf_leaf.createfont
local frame_pool, roster = {}, {}

local addon = CreateFrame('Frame', 'oUF_RaidDebuff')
addon:RegisterEvent'PLAYER_LOGIN'
addon:SetScript('OnEvent', function(self, event, ...) self[event](self, event, ...) end)

function addon:GetDebufFrameByGUID(GUID)
	local unit = roster[GUID]
	--print(GUID, unit)
	if not unit then return end
	local uframe
	
	for i = 1, #frame_pool do
		if frame_pool[i].unit == unit then
			uframe = frame_pool[i]
			break
		end
	end
	
	return uframe and uframe.RaidDebuff, unit
end

function addon:PLAYER_LOGIN()
	self.PLAYER_LOGIN = nil
	self:UnregisterEvent('PLAYER_LOGIN')
	if not self.DebuffData then
		return
	end
	
	-- tekDebug
	debugf = tekDebug and tekDebug:GetFrame('oUF_RaidDebuff')
	if debugf then
		debug = function(...) debugf:AddMessage(string.join(', ', ...)) end
	end
	
	self.roster = roster
	self.frame_pool = frame_pool
	
	-- check if in raid
	self:RAID_ROSTER_UPDATE()
	
	-- events
	self:RegisterEvent'RAID_ROSTER_UPDATE'
	self:RegisterEvent'PLAYER_ENTERING_WORLD'
end

local band = bit.band
function addon:COMBAT_LOG_EVENT_UNFILTERED(event, timeStamp, eventType, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, spellID, ...)
	if band(destFlags, 0x00006868) == 0 then
		--debug(timeStamp, eventType, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, spellID, ...)
		if eventType == 'SPELL_AURA_APPLIED' or eventType == 'SPELL_AURA_APPLIED_DOSE' or eventType == 'SPELL_AURA_REMOVED_DOSE'then
			self:Add(destGUID, spellID)
		elseif eventType =='SPELL_AURA_REMOVED' then
			self:Remove(destGUID, spellID)
		elseif eventType == 'UNIT_DIED' then
			self:UNIT_DIED(destGUID)
		end
	end
end

-- GUID => UNIT ID
function addon:RAID_ROSTER_UPDATE()
	debug'RAID_ROSTER_UPDATE'
	wipe(roster)
	if ouf_leaf.test_mod then
		roster[UnitGUID('player')] = 'player'
	end
	local num = GetRealNumRaidMembers()
	debug('raid num', num)
	if num > 1 then
		for i = 1, num do
			local u = 'raid'..i
			if UnitExists(u) then
				roster[UnitGUID(u)] = u
			end
		end
	end
end

function addon:PLAYER_ENTERING_WORLD()
	local curZone = GetRealZoneText()
	local DebuffList = self.DebuffData[curZone]
	if DebuffList then
		self.DebuffList = DebuffList
		self:RegisterEvent'COMBAT_LOG_EVENT_UNFILTERED'
		debug('POWER ON', curZone)
	else
		self.DebuffList = {}
		self:UnregisterEvent'COMBAT_LOG_EVENT_UNFILTERED'
		debug('POWER OFF', curZone)
	end
	
	for dummy, frame in pairs(frame_pool) do
		if frame then
			wipe(frame.RaidDebuff.Debuffs)
			self:UpdateDebuff(frame.unit, frame.RaidDebuff)
		end
	end
end

function addon:Add(destGUID, spellID)
	debug('Add', destGUID, spellID)
	local debuffinfo = self.DebuffList[spellID]
	if debuffinfo then
		debug'adding'
		local frame, unit = self:GetDebufFrameByGUID(destGUID)
		if not (frame and unit) then return end
		debug('Adding',unit, 'spellID', spellID)
		
		frame.Debuffs[spellID] = frame.Debuffs[spellID] or {}
		local gained = frame.Debuffs[spellID]
		
		gained.GainTime = GetTime()
		if debuffinfo.stackable then
			gained.stack = gained.stack and (gained.stack + 1) or 1
		end
		self:UpdateDebuff(unit, frame)
	end
end

function addon:Remove(destGUID, spellID)
	--debug('Remove', destGUID, spellID)
	if self.DebuffList[spellID] then
		local frame, unit = self:GetDebufFrameByGUID(destGUID)
		if not (frame and unit) then return end
		
		frame.Debuffs[spellID] = nil
		self:UpdateDebuff(unit, frame)
	end
end

function addon:UNIT_DIED(destGUID)
	--debug('UNIT_DIED', destGUID)
	local frame, unit = self:GetDebufFrameByGUID(destGUID)
	if not (frame and unit) then return end
	debug('UNIT_DIED', destGUID)
	
	frame.Debuffs = {}
	self:UpdateDebuff(unit, frame)
end

function addon:UpdateDebuff(unit, frame)
	if (not unit) or (not frame) then return end
	--debug'update called'
	
	local order,id,debuffData = -1
	for k,v in pairs(frame.Debuffs) do
		local data = self.DebuffList[k]
		data.order = data.order or 0
		if data.order > order then
			order = data.order
			id = k
			debuffData = data
		end
	end
	
	if id then
		debug('updating !got id!', id, 'and order', order)
		local data = frame.Debuffs[id]
		
		local debuffName, _, debuffIcon = GetSpellInfo(id)
		
		local startTime, debuffDuration, debuffType = data.GainTime, debuffData.duration, debuffData.debuffType
		debug'got cd timer from addon data'
		
		if startTime and debuffDuration then
			frame.cd:SetCooldown(startTime, debuffDuration)
			frame.cd:Show()
			debug'cd show'
		else
			frame.cd:Hide()
			debug'cd hide'
		end
		if debuffData.stackable and data.stack then
			frame.stack:SetText(data.stack)
			frame.stack:Show()
			debug'stack show'
		else
			--frame.stack:SetText''
			frame.stack:Hide()
			debug'stack hide'
		end
		frame.icon:SetTexture(debuffIcon)
		frame.icon:Show()
		debug'icon show'
		
		frame:Show()
		debug'update show debuff'
	else
		frame:Hide()
		debug'update hide debuff'
	end
	--debug'update finished'
end

local function Setup(self)
	if not self.RaidDebuffIcon then return end
	local size = self.RaidDebuffIcon_Size or 20
	
	local f = CreateFrame('Frame', nil, self)
	f:SetWidth(size)
	f:SetHeight(size)
	f:SetPoint('CENTER', self)
	f:SetFrameStrata('HIGH')
	f:Hide()
	
	f.cd = CreateFrame'Cooldown'
	f.cd:SetParent(f)
	f.cd:SetAllPoints(f)
	
	f.icon = f:CreateTexture()
	f.icon:SetDrawLayer'BACKGROUND'
	f.icon:SetAllPoints(f)
	f.icon:SetTexCoord(.1,.9,.1,.9)
	
	f.stack = SetFontString(f, 10)
	f.stack:SetPoint('BOTTOMRIGHT', f, -2, 0)
	f.stack:SetJustifyH'RIGHT'
	
	f.Debuffs = {}
	
	self.RaidDebuff = f
	tinsert(frame_pool, self)
	
	return self
end
addon.Setup = Setup

for i, frame in ipairs(oUF.objects) do Setup(frame) end
oUF:RegisterInitCallback(Setup)

SlashCmdList.OUFRAIDDEBUFF = function(msg)
	addon:RAID_ROSTER_UPDATE()
	addon:PLAYER_ENTERING_WORLD()
end
SLASH_OUFRAIDDEBUFF1 = '/oufrd'
SLASH_OUFRAIDDEBUFF2 = '/oufraiddebuff'
SLASH_OUFRAIDDEBUFF3 = '/raiddebuff'
SLASH_OUFRAIDDEBUFF4 = '/ord'

local LDB = LibStub and LibStub:GetLibrary('LibDataBroker-1.1', true)

addon.dataobj = LDB and LDB:NewDataObject('oUF_RaidDebuff',{
	type = 'launcher',
	lable = 'oUF_RaidDebuff',
	icon = [[Interface\Icons\spell_fire_felfire]],
	OnClick = SlashCmdList.OUFRAIDDEBUFF,
})
