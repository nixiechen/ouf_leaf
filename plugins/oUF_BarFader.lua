--[[

	Shared:
	 - BarFade [boolean]
	 - BarFadeMinAlpha [value] default: 0.25
	 - BarFadeMaxAlpha [value] default: 1

--]]
local oUF
do
	local parent = debugstack():match[[\AddOns\(.-)\]]
	local global = GetAddOnMetadata(parent, 'X-oUF')
	oUF = _G[global or 'oUF']
end


local function pending(self, unit)
	local num, str = UnitPowerType(unit)
	if(self.Castbar and (self.Castbar.casting or self.Castbar.channeling)) then return true end
	if(UnitAffectingCombat(unit)) then return true end
	if(unit == 'pet' and GetPetHappiness() and GetPetHappiness() < 3) then return true end
	if(UnitExists(unit..'target')) then	return true end
	if(UnitHealth(unit) < UnitHealthMax(unit)) then return true end
	if((str == 'RAGE' or str == 'RUNIC_POWER') and UnitPower(unit) > 0) then return true end
	if((str ~= 'RAGE' and str ~= 'RUNIC_POWER') and UnitMana(unit) < UnitManaMax(unit)) then return true end
end

local function update(self, event, unit)
	if(unit and unit ~= self.unit) then return end

	if(not pending(self, self.unit)) then
		self:SetAlpha(self.BarFaderMinAlpha or 0.25)
	else
		self:SetAlpha(self.BarFaderMaxAlpha or 1)
	end
end

local function enable(self, unit)
	if(unit and self.BarFade) then
		update(self)

		self:RegisterEvent('UNIT_COMBAT', update)
		self:RegisterEvent('UNIT_HAPPINESS', update)
		self:RegisterEvent('UNIT_TARGET', update)
		self:RegisterEvent('UNIT_FOCUS', update)
		self:RegisterEvent('UNIT_HEALTH', update)
		self:RegisterEvent('UNIT_POWER', update)
		self:RegisterEvent('UNIT_ENERGY', update)
		self:RegisterEvent('UNIT_RAGE', update)
		self:RegisterEvent('UNIT_MANA', update)
		self:RegisterEvent('UNIT_RUNIC_POWER', update)

		if(self.Castbar) then
			self:RegisterEvent('UNIT_SPELLCAST_START', update)
			self:RegisterEvent('UNIT_SPELLCAST_FAILED', update)
			self:RegisterEvent('UNIT_SPELLCAST_STOP', update)
			self:RegisterEvent('UNIT_SPELLCAST_INTERRUPTED', update)
			self:RegisterEvent('UNIT_SPELLCAST_DELAYED', update)
			self:RegisterEvent('UNIT_SPELLCAST_CHANNEL_START', update)
			self:RegisterEvent('UNIT_SPELLCAST_CHANNEL_UPDATE', update)
			self:RegisterEvent('UNIT_SPELLCAST_CHANNEL_INTERRUPTED', update)
			self:RegisterEvent('UNIT_SPELLCAST_CHANNEL_STOP', update)
		end

		return true
	end
end

local function disable(self)
	if(self.BarFade) then
		self:UnregisterEvent('UNIT_COMBAT', update)
		self:UnregisterEvent('UNIT_HAPPINESS', update)
		self:UnregisterEvent('UNIT_TARGET', update)
		self:UnregisterEvent('UNIT_FOCUS', update)
		self:UnregisterEvent('UNIT_HEALTH', update)
		self:UnregisterEvent('UNIT_POWER', update)
		self:UnregisterEvent('UNIT_ENERGY', update)
		self:UnregisterEvent('UNIT_RAGE', update)
		self:UnregisterEvent('UNIT_MANA', update)
		self:UnregisterEvent('UNIT_RUNIC_POWER', update)

		if(self.Castbar) then
			self:UnregisterEvent('UNIT_SPELLCAST_START', update)
			self:UnregisterEvent('UNIT_SPELLCAST_FAILED', update)
			self:UnregisterEvent('UNIT_SPELLCAST_STOP', update)
			self:UnregisterEvent('UNIT_SPELLCAST_INTERRUPTED', update)
			self:UnregisterEvent('UNIT_SPELLCAST_DELAYED', update)
			self:UnregisterEvent('UNIT_SPELLCAST_CHANNEL_START', update)
			self:UnregisterEvent('UNIT_SPELLCAST_CHANNEL_UPDATE', update)
			self:UnregisterEvent('UNIT_SPELLCAST_CHANNEL_INTERRUPTED', update)
			self:UnregisterEvent('UNIT_SPELLCAST_CHANNEL_STOP', update)
		end
	end
end

oUF:AddElement('BarFader', update, enable, disable)