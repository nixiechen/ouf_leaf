-- yleaf (yaroot@gmail.com)

local oUF
do
	local parent = debugstack():match[[\AddOns\(.-)\]]
	local global = GetAddOnMetadata(parent, 'X-oUF')
	oUF = _G[global or 'oUF']
end


_G.ouf_leaf = {}
ouf_leaf.noarena = false
ouf_leaf.noraid = false
ouf_leaf.corner_indicators = false
ouf_leaf.corner_indicators_frequent_update = false -- boolean or number
ouf_leaf.nofsr = true
ouf_leaf.nogcd = true
ouf_leaf.noswing = true
ouf_leaf.test_mod = false

ouf_leaf.units = {}

local _,class = UnitClass'player'
local playername = UnitName'player'
ouf_leaf.backdrop = {
	bgFile = [=[Interface\ChatFrame\ChatFrameBackground]=],
	insets = {top = -1, left = -1, bottom = -1, right = -1},
}

ouf_leaf.playerAuraFilter = class == 'DRUID' and {
	[GetSpellInfo(52610)] = true, -- Savage Roar
	[GetSpellInfo(48517)] = true, -- Eclipse
	[GetSpellInfo(50334)] = true, -- Berserk
	[GetSpellInfo(5217)] = true, -- Tiger's Fury
	[GetSpellInfo(16864)] = true, -- Omen of Clarity
	[GetSpellInfo(22812)] = true, -- Barkskin
} or class == 'ROGUE' and {
	[GetSpellInfo(5171)] = true, -- Slice and Dice
}

local colors = setmetatable({
	power = setmetatable({
		['MANA'] = {.3,.5,.85},
		--['MANA'] = {.41,.8,.94},
		['RAGE'] = {.9,.2,.3},
		['ENERGY'] = {1,.85,.1},
		['RUNIC_POWER'] = {0,.8,1},
	}, {__index = oUF.colors}),
	health = {.15,.15,.15},
	disconnected = {.5,.5,.5},
	tapped = {.5,.5,.5},
	smooth = {
		1, 0, 0,
		1, 1, 0,
		0, 1, 0
	},
	revertSmooth = {
		0, 1, 0,
		1, 1, 0,
		1, 0, 0
	},
}, {__index = oUF.colors})
ouf_leaf.colors = colors

do
	for _, addon in pairs{'Grid', 'Grid2', 'VuhDo', 'PerfectRaid', 'sRaidFrames', 'HealBot'} do
		if IsAddOnLoaded(addon) then
			ouf_leaf.noraid = true
			break
		end
	end
end

local function isLeader(unit)
	return (UnitInParty(unit) or UnitInRaid(unit)) and UnitIsPartyLeader(unit)
end
local function isAssistant(unit)
	return UnitInRaid(unit) and UnitIsRaidOfficer(unit) and not UnitIsPartyLeader(unit)
end

function ouf_leaf.updatemasterlooter(self)
	self.MasterLooter:ClearAllPoints()
	if isLeader(self.unit) or isAssistant(self.unit) then
		self.MasterLooter:SetPoint('LEFT', self.Leader, 'RIGHT')
	else
		self.MasterLooter:SetPoint('TOPLEFT', self.Leader)
	end
end

--[[local function menu(self)
	local unit = string.gsub(self.unit, '(.)', string.upper, 1)
	if(_G[unit..'FrameDropDown']) then
		ToggleDropDownMenu(1, nil, _G[unit..'FrameDropDown'], 'cursor')
	end
end]]
local function menu(self)
	local unit = self.unit:gsub('(.)', string.upper, 1) 
	if _G[unit..'FrameDropDown'] then
		ToggleDropDownMenu(1, nil, _G[unit..'FrameDropDown'], 'cursor')
	elseif (self.unit:match('party')) then
		ToggleDropDownMenu(1, nil, _G['PartyMemberFrame'..self.id..'DropDown'], 'cursor')
	else
		FriendsDropDown.unit = self.unit
		FriendsDropDown.id = self.id
		FriendsDropDown.initialize = RaidFrameDropDown_Initialize
		ToggleDropDownMenu(1, nil, FriendsDropDown, 'cursor')
	end
end
ouf_leaf.menu = menu

--[[local utf8sub = function(string, i)
	local bytes = strlen(string)
	if (bytes <= i) then
		return string
	else
		local len, pos = 0, 1
		while(pos <= bytes) do
			len = len + 1
			local c = strbyte(string, pos) -- could use strchar() to check the string
			if (c > 0 and c <= 127) then
				pos = pos + 1
			elseif (c >= 192 and c <= 223) then
				pos = pos + 2
			elseif (c >= 224 and c <= 239) then
				pos = pos + 3
			elseif (c >= 240 and c <= 247) then
				pos = pos + 4
			end
			if (len == i) then break end
		end

		if (len == i and pos <= bytes) then
			return strsub(string, 1, pos - 1)
		else
			return string
		end
	end
end]]

local function utf8sub(str, numChars)
	local currentIndex = 1
	while numChars > 0 and currentIndex <= #str do
		local char = strbyte(str, currentIndex)
		if char >= 240 then
			currentIndex = currentIndex + 4
		elseif char >= 225 then
			currentIndex = currentIndex + 3
		elseif char >= 192 then
			currentIndex = currentIndex + 2
		else
			currentIndex = currentIndex + 1
		end
		numChars = numChars - 1
	end
	return str:sub(1, currentIndex - 1)
end
ouf_leaf.utf8sub = utf8sub

local function Hex(r, g, b)
	if(type(r) == 'table') then
		if(r.r) then r, g, b = r.r, r.g, r.b else r, g, b = unpack(r) end
	end
	
	if(not r or not g or not b) then
		r, g, b = 1, 1, 1
	end
	
	return format('|cff%02x%02x%02x', r*255, g*255, b*255)
end
ouf_leaf.hex = Hex

local function truncate(value)
	if(value >= 1e6) then
		value = format('%.1fm', value / 1e6)
	elseif(value >= 1e3) then
		value = format('%.1fk', value / 1e3)
	end
	return gsub(value, '%.?0+([km])$', '%1')
end
ouf_leaf.truncate = truncate

local classColors = {}
do
	for class, c in pairs(CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS) do
		classColors[class] = format('|cff%02x%02x%02x', c.r*255, c.g*255, c.b*255)
	end
end

---------------------------------------------------------------------

local diffColor = GetQuestDifficultyColor or GetDifficultyColor
oUF.Tags['[leafdifficulty]']  = function(u) local l = UnitLevel(u); return Hex(diffColor((l > 0) and l or 99)) end

oUF.Tags['[leafcurhp]'] = function(u) return truncate(UnitHealth(u)) end
oUF.TagEvents['[leafcurhp]'] = 'UNIT_HEALTH'

oUF.Tags['[leafcurpp]'] = function(u) return truncate(UnitPower(u)) end
oUF.TagEvents['[leafcurpp]'] = 'UNIT_ENERGY UNIT_FOCUS UNIT_MANA UNIT_RAGE UNIT_RUNIC_POWER'

oUF.Tags['[leafmaxhp]'] = function(u) return truncate(UnitHealthMax(u)) end
oUF.TagEvents['[leafmaxhp]'] = 'UNIT_MAXHEALTH'

oUF.Tags['[leafmaxpp]'] = function(u) return truncate(UnitPowerMax(u)) end
oUF.TagEvents['[leafmaxpp]'] = 'UNIT_MAXENERGY UNIT_MAXFOCUS UNIT_MAXMANA UNIT_MAXRAGE UNIT_MAXRUNIC_POWER'

oUF.Tags['[leafraidcolor]'] = function(u) local _, x = UnitClass(u); return x and classColors[x] or '|cffffffff' end

oUF.Tags['[leafperhp]'] = function(u)
	local m = UnitHealthMax(u)
	return m == 0 and 0 or floor(UnitHealth(u)/m*100+0.5)
end
oUF.TagEvents['[leafperhp]'] = 'UNIT_HEALTH UNIT_MAXHEALTH'

oUF.Tags['[leafperpp]'] = function(u)
	local m = UnitPowerMax(u)
	return m == 0 and 0 or floor(UnitPower(u)/m*100+0.5)
end
oUF.TagEvents['[leafperpp]'] = 'UNIT_MAXENERGY UNIT_MAXFOCUS UNIT_MAXMANA UNIT_MAXRAGE UNIT_ENERGY UNIT_FOCUS UNIT_MANA UNIT_RAGE UNIT_MAXRUNIC_POWER UNIT_RUNIC_POWER'

oUF.Tags['[leafsmartpp]'] = function(u)
	if select(2,UnitPowerType(u)) == 'MANA' then
		oUF.Tags['[leafperpp]'](u)
	else
		return UnitPower(u)
	end
end
oUF.TagEvents['[leafsmartpp]'] = 'UNIT_MAXENERGY UNIT_MAXFOCUS UNIT_MAXMANA UNIT_MAXRAGE UNIT_ENERGY UNIT_FOCUS UNIT_MANA UNIT_RAGE UNIT_MAXRUNIC_POWER UNIT_RUNIC_POWER'

oUF.Tags['[leafname]'] = function(u)
	local name, realm = UnitName(u)
	if realm and (realm~='') then name = name .. '-' .. realm end
	return name
end
oUF.TagEvents['[leafname]'] = 'UNIT_NAME_UPDATE'

local color_power = {}
for k, v in pairs(colors.power) do
	color_power[k] = Hex(v)
end
oUF.Tags['[leafcolorpower]'] = function(u) local n,s = UnitPowerType(u) return color_power[s] end

oUF.Tags['[leafsmartlevel]'] = function(u)
	local c = UnitClassification(u)
	if(c == 'worldboss') then
		return '++'
	else
		local l  = UnitLevel(u)
		if(c == 'elite' or c == 'rareelite') then
			return (l > 0) and l..'+' or '+'
		else
			return (l > 0) and l or '??'
		end
	end
end

do
	local cp_color = {
		[1] = '|cffffffff1|r',
		[2] = '|cffffffff2|r',
		[3] = '|cffffffff3|r',
		[4] = '|cffffd8194|r',
		[5] = '|cffff00005|r',
	}
	oUF.Tags['[leafcp]'] = function(u)
		local cp = GetComboPoints(PlayerFrame.unit, 'target')
		return cp_color[cp]
	end
	oUF.TagEvents['[leafcp]'] = 'UNIT_COMBO_POINTS UNIT_TARGET'
end

oUF.Tags['[leafthreat]'] = function(u) local s = UnitThreatSituation(u) return s and (s>2) and '|cffff0000.|r' end
oUF.TagEvents['[leafthreat]'] = 'UNIT_THREAT_SITUATION_UPDATE'

do
	local ThreatStatusColor = {
		[1] = Hex(1, 1, .47),
		[2] = Hex(1, .6, 0),
		[3] = Hex(1, 0, 0),
	}
	oUF.Tags['[leafthreatcolor]'] = function(u) return ThreatStatusColor[UnitThreatSituation(u)] or '|cffffffff' end
	oUF.TagEvents['[leafthreatcolor]'] = 'UNIT_THREAT_SITUATION_UPDATE'
end

oUF.Tags['[leafstatus]'] = function(u)
	return UnitIsDead(u) and 'Dead' or UnitIsGhost(u) and 'Ghost' or not UnitIsConnected(u) and 'Offline'
end
oUF.TagEvents['[leafstatus]'] = 'UNIT_HEALTH'

do
	local lb = GetSpellInfo(33763)
	oUF.Tags['[leaflifebloom]'] = function(u)
		local status = oUF.Tags['[leafstatus]'](u)
		if status then return status end
		local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable = UnitAura(u, lb)
		if name and count and (unitCaster == 'player') then
			local timeLeft = expirationTime - GetTime()
			return format('|cff64ff64%d - %ds|r', count, timeLeft)
		end
	end
end

do
	local mark = GetSpellInfo(1126)
	local gmark = GetSpellInfo(21849)
	oUF.Tags['[leafmisswild]'] = function(u)
		if UnitAura(u, mark) or UnitAura(u, gmark) then return end
		return '|cff00FEBF.|r'
	end
end
oUF.TagEvents['[leafmisswild]'] = 'UNIT_AURA'

oUF.Tags['[leafthreatpct]'] = function(u)
	local isTanking, status, threatpct, rawthreatpct, threatvalue = UnitDetailedThreatSituation(u, 'target')
	if not threatpct then return end
	
	if isTanking then threatpct = 100 end
	local r,g,b = oUF.ColorGradient(threatpct/100, unpack(colors.revertSmooth))
	return Hex(r,g,b) .. (isTanking and 'Aggro' or ceil(threatpct) .. '%')
end
oUF.TagEvents['[leafthreatpct]'] = 'UNIT_THREAT_SITUATION_UPDATE'

oUF.Tags['[leafdruidpower]'] = function(u)
	local mana = UnitPowerType(u) == 0
	local min, max = UnitPower(u, mana and 3 or 0), UnitPowerMax(u, mana and 3 or 0)
	if min~=max then
		local r,g,b = unpack(colors.power[mana and 'ENERGY' or 'MANA'])
		local text = mana and format('%d', truncate(min)) or format('%d%%', floor(min/max*100))
		return Hex(r,g,b) .. text
	end
end
oUF.TagEvents['[leafdruidpower]'] = 'UNIT_MANA UNIT_ENERGY UPDATE_SHAPESHIFT_FORM'

local raidtag_cache = {}
local function cache_tag(u)
	local name = UnitName(u)
	local c = oUF.Tags['[leafraidcolor]'](u) or ''
	local str
	if (strbyte(name,1) > 224) then
		str = utf8sub(name, 3)
	else
		str = utf8sub(name, 5)
	end
	
	raidtag_cache[name] = c .. str
	return raidtag_cache[name]
end

--local c_red = '|cffff8080'
--local c_green = '|cff559655'
--local c_gray = '|cffD7BEA5'

oUF.Tags['[leafraid]'] = function(u)
	return raidtag_cache[UnitName(u)] or cache_tag(u)
end
oUF.TagEvents['[leafraid]'] = 'UNIT_NAME_UPDATE'

