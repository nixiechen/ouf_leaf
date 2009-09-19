--[[****************************************************************************
	by yleaf (yaroot@gmail.com)
	
	.SpellRange [boolean] <or> [num] update rate
	.inRangeAlpha [num] - Frame alpha value for units in range.
	.outsideRangeAlpha [num] - Frame alpha for units out of range.
  ****************************************************************************]]
local oUF
do
	local parent = debugstack():match[[\AddOns\(.-)\]]
	local global = GetAddOnMetadata(parent, 'X-oUF')
	oUF = _G[global or 'oUF']
end

local UpdateRate = 0.2

local UpdateFrame = CreateFrame('Frame')
local Objects = {}
local mySpell
do 
	local _, class = UnitClass('player')
	local spellsData = {
		['DRUID'] = 5176, -- ["Wrath"], -- 30 (Nature's Reach: 33, 36)
		['HUNTER'] = 75, -- ["Auto Shot"], -- 5-35 (Hawk Eye: 37, 39, 41)
		['MAGE'] = 44614, -- ["Frostfire Bolt"], -- 40
		['PALADIN'] = 24275, -- ["Hammer of Wrath"],  -- 30 (Glyph of Hammer of Wrath: +5)
		['PRIEST'] = 585, -- ["Smite"], -- 30 (Holy Reach: 33, 36)
		['ROGUE'] = 26679, -- ["Deadly Throw"], -- 30 (Glyph of Deadly Throw: +5)
		['SHAMAN'] = 403, -- ["Lightning Bolt"], -- 30 (Storm Reach: 33, 36)
		['WARRIOR'] = 355, -- ["Taunt"], -- 30
		['WARLOCK'] = 348, -- ["Immolate"], -- 30 (Destructive Reach: 33, 36)
		['DEATHKNIGHT'] = 47541, -- ["Death Coil"], -- 30
	}
	mySpell = GetSpellInfo(spellsData[class])
end

function IsInRange(u)
	if UnitIsUnit(u, 'player') then
		return true
	elseif UnitCanAttack('player', u) then
		return UnitIsDead(u) or (IsSpellInRange(mySpell, u) == 1)
	elseif (UnitIsUnit(u, 'pet') or UnitPlayerOrPetInParty(u) or UnitPlayerOrPetInRaid(u)) then -- UnitCanAssist('player', u)
		return UnitInRange(u)
	else
		return true
	end
end

function UpdateRange(self)
	local InRange = not not IsInRange(self.unit)
	if self.isInRange ~= InRange then
		self.isInRange = InRange
		self:SetAlpha(InRange and self.inRangeAlpha or self.outsideRangeAlpha)
	end
end

local NextUpdate = 0
local function OnUpdate(self, Elapsed)
	NextUpdate = NextUpdate - Elapsed
	if ( NextUpdate > 0 ) then return end
	NextUpdate = UpdateRate
	
	for obj in pairs(Objects) do
		if obj and obj:IsVisible() then
			UpdateRange(obj)
		end
	end
end

local function Enable(self)
	if self.SpellRange and (self.unit ~= 'player') then
		UpdateRate = (type(self.SpellRange) == 'number') and self.SpellRange or UpdateRate
		Objects[self] = true
		return true
	end
end

local function Disable(self)
	Objects[self] = nil
end

UpdateFrame:SetScript('OnUpdate', OnUpdate)
oUF:AddElement('SpellRange', UpdateRange, Enable, Disable)
