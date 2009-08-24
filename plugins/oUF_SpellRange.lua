--[[****************************************************************************
	by yleaf (yaroot@gmail.com)
	
	.SpellRange [boolean] <or> [num] update rate
		.inRangeAlpha [num] - Frame alpha value for units in range.
		.outsideRangeAlpha [num] - Frame alpha for units out of range.
  ****************************************************************************]]

local UpdateRate = 0.2

local UpdateFrame = CreateFrame('Frame')
local Objects = {}
local mySpell
do 
	local _, class = UnitClass('player')
	local spellsData = {
		DEATHKNIGHT = 6789, -- Death Coil
		DRUID = 5176, -- Wrath
		HUNTER = 75, -- Auto Shot
		MAGE = 133, -- Fireball
		PALADIN = 62124, -- Hand of Reckoning
		PRIEST = 585, -- Smite
		SHAMAN = 403, -- Lightning Bolt
		WARLOCK = 686, -- Shadow Bolt
		WARRIOR = 355, -- Taunt
	}
	mySpell = GetSpellInfo(spellsData[class])
end

function IsInRange(u)
	if UnitIsUnit(u, 'player') then
		return true
	elseif UnitCanAttack('player', u) then
		return IsSpellInRange(mySpell, u) == 1
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
		if self.Range then -- Disable default range checking
			self:DisableElement('Range')
			self.Range = nil
		end
		
		UpdateRate = (type(self.SpellRange) == 'number') and self.SpellRange or UpdateRate
		Objects[self] = true
		return true
	end
end

local function Disable(self)
	Objects[self] = nil
end

local function Update(self,event,unit)
	UpdateRange(self)
end

UpdateFrame:SetScript('OnUpdate', OnUpdate)
oUF:AddElement('SpellRange', Update, Enable, Disable)
