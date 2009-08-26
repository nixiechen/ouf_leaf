--[[
	most of the codes are copied from oUF_Freebgrid by Freebaser
	yleaf (yaroot@gmail.com)
	
	use the tag system to build a grid-like CornerIndicators for ouf
	
	- CornerIndicators
]]
if ouf_leaf.noraid or (not ouf_leaf.corner_indicators) then return end


local _, eclass = UnitClass'player'
local ci_data = {
	['DRUID'] = {
		['TR'] = '[ci:rejuv][ci:regrow][ci:wg]',
		['BR'] = '[ci:lb]',
	},
	['PRIEST'] = {
		['TR'] = '[ci:renew][ci:shield][ci:ws]',
		['BR'] = '[ci:pom]',
	},
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

local indicators = ci_data[eclass]
if not indicators then return end

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
	--local c = select(4, UnitAura(u, 'Prayer of Mending')) return c and '|cffFFCF7F'..oUF.pomCount[c]..'|r' or '' 
	local name, count = aurafunc(u, 33076, true)
	if name and count then
		return '|cffFFCF7F'..count..'|r'
	end
end
oUF.TagEvents['[ci:pom]'] = 'UNIT_AURA'

oUF.Tags['[ci:renew]'] = function(u) if aurafunc(u, 139, true) then return '|cff33FF33.|r' end end
oUF.TagEvents['[ci:renew]'] = 'UNIT_AURA'

oUF.Tags['[ci:shield]'] = function(u) if aurafunc(u, 17) then return '|cff33FF33.|r' end end
oUF.TagEvents['[ci:shield]'] = 'UNIT_AURA'

oUF.Tags['[ci:ws]'] = function(u) if aurafunc(u, 6788) then return '|cffFF5500.|r' end end
oUF.TagEvents['[ci:ws]'] = 'UNIT_AURA'


--druid

oUF.Tags['[ci:lb]'] = function(u)
	local name, count = aurafunc(u, 33763, true)
	if count then
		return '|cffA7FD0A'..count..'|r'
	end
end
oUF.Tags['[ci:rejuv]'] = function(u) if aurafunc(u, 774, true) then return '|cff00FEBF.|r' end end
oUF.Tags['[ci:regrow]'] = function(u) if aurafunc(u, 8936, true) then return '|cff00FF10.|r' end end
oUF.Tags['[ci:wg]'] = function(u) if aurafunc(u, 48438, true) then return '|cff33FF33.|r' end end

oUF.TagEvents['[ci:lb]'] = 'UNIT_AURA'
oUF.TagEvents['[ci:rejuv]'] = 'UNIT_AURA'
oUF.TagEvents['[ci:regrow]'] = 'UNIT_AURA'
oUF.TagEvents['[ci:wg]'] = 'UNIT_AURA'

--warrior
--oUF.Tags['[cishout]'] = function(u) if aurafunc(u, 11553) or aurafunc(u, 469) then return '|cffffff00.|r' end end
--oUF.TagEvents['[cishout]'] = 'UNIT_AURA'

local SetFontString = ouf_leaf.createfont

local function Setup(self)
	if not self.CornerIndicators then return end

	if type(self.CornerIndicators) ~= 'table' then self.CornerIndicators = {} end
	
	local tl, tr, bl, br
	tl = indicators['TL']
	tr = indicators['TR']
	bl = indicators['BL']
	br = indicators['BR']
	
	if tl then
		self.CornerIndicators.TL = SetFontString(self.Health, 22)
		self.CornerIndicators.TL:SetPoint('BOTTOMLEFT', self, 'TOPLEFT', -5, -5)
		self:Tag(self.CornerIndicators.TL, tl)
	end
	
	if tr then
		self.CornerIndicators.TR = SetFontString(self.Health, 22)
		self.CornerIndicators.TR:SetPoint('BOTTOMRIGHT', self, 'TOPRIGHT', 5, -5)
		self:Tag(self.CornerIndicators.TR, tr)
	end
	
	if bl then
		self.CornerIndicators.BL = SetFontString(self.Health, 22)
		self.CornerIndicators.BL:ClearAllPoints()
		self.CornerIndicators.BL:SetPoint('BOTTOMLEFT', self, 'BOTTOMLEFT', -5, 5)
		self:Tag(self.CornerIndicators.BL, bl)
	end
	
	if br then
		self.CornerIndicators.BR = SetFontString(self.Health, 10)
		self.CornerIndicators.BR:SetPoint('BOTTOMRIGHT', self, 'BOTTOMRIGHT', -5, 0)
		self:Tag(self.CornerIndicators.BR, br)
	end
	
	return self
end

for i, frame in ipairs(oUF.objects) do Setup(frame) end
oUF:RegisterInitCallback(Setup)

_G.oUF_CornerIndicators = {}
oUF_CornerIndicators.Setup = Setup

