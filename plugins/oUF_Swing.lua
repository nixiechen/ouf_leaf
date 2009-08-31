--[[

	Elements handled:
	 .Swing [statusbar]
	 .Swing.Text [fontstring]

	Shared:
	 - disableMelee [boolean]
	 - disableRanged [boolean]

	Functions that can be overridden from within a layout:
	 - :OverrideText(elapsed)

--]]

local OnDurationUpdate
do
	local elapsed = 0
	function OnDurationUpdate(self)
		elapsed = GetTime()
		if(elapsed > self.max) then
			self:Hide()
			self:SetScript('OnUpdate', nil)
		else
			self:SetValue(self.min + (elapsed - self.min))

			if(self.Text) then
				if(self.OverrideText) then
					self:OverrideText(elapsed)
				else
					self.Text:SetFormattedText('%.1f', self.max - elapsed)
				end
			end
		end
	end
end

local function Melee(self, _, _, event, GUID)
	if(UnitGUID(self.unit) ~= GUID) then return end
	if(not string.find(event, 'SWING')) then return end

	local bar = self.Swing
	bar.min = GetTime()
	bar.max = bar.min + UnitAttackSpeed(self.unit)

	bar:Show()
	bar:SetMinMaxValues(bar.min, bar.max)
	bar:SetScript('OnUpdate', OnDurationUpdate)
end

local shoots = {
	[GetSpellInfo(75)] = true
	[GetSpellInfo(5019)] = true
}
local function Ranged(self, event, unit, spellName)
	if not shoots[spellName] then return end

	local bar = self.Swing
	bar.min = GetTime()
	bar.max = bar.min + UnitRangedDamage(unit)

	bar:Show()
	bar:SetMinMaxValues(bar.min, bar.max)
	bar:SetScript('OnUpdate', OnDurationUpdate)
end

local function Enable(self, unit)
	local swing = self.Swing
	if(swing and unit == 'player') then
		if(not swing.disableRanged) then
			self:RegisterEvent('UNIT_SPELLCAST_SUCCEEDED', Ranged)
		end

		if(not swing.disableMelee) then
			self:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED', Melee)
		end

		swing:Hide()
		if(not swing:GetStatusBarTexture() and not swing:GetTexture()) then
			swing:SetStatusBarTexture([=[Interface\TargetingFrame\UI-StatusBar]=])
		end

		return true
	end
end

local function Disable(self)
	local swing = self.Swing
	if(swing) then
		if(not swing.disableRanged) then
			self:UnregisterEvent('UNIT_SPELLCAST_SUCCEEDED', Ranged)
		end

		if(not swing.disableMelee) then
			self:UnregisterEvent('COMBAT_LOG_EVENT_UNFILTERED', Melee)
		end
	end
end

oUF:AddElement('Swing', nil, Enable, Disable)