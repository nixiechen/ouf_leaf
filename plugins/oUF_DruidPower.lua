--[[
	yleaf (yaroot@gmail.com)
	most of the codes are done by p3lim
	
	DruidPower
	DruidPower.Text

--]]
if select(2, UnitClass'player') ~= 'DRUID' then return end

local function Update(self, event, unit)
	if(unit and unit ~= self.unit) then return end
	local bar = self.DruidPower
	if not bar then return end
	
	local mana = UnitPowerType('player') == 0
	local min, max = UnitPower('player', mana and 3 or 0), UnitPowerMax('player', mana and 3 or 0)

	local r,g,b = unpack(self.colors.power[mana and 'ENERGY' or 'MANA'])
	bar:SetStatusBarColor(r,g,b)
	bar:SetMinMaxValues(0, max)
	bar:SetValue(min)
	bar:SetAlpha(min ~= max and 1 or 0)
	
	local text = bar.Text
	if text then
		text:SetTextColor(r,g,b)
		if mana then
			text:SetFormattedText('%d', ouf_leaf.truncate(min))
		else
			text:SetFormattedText('%d%%', floor(min/max*100))
		end
	end
	
	if bar.PostUpdate then
		bar:PostUpdate(min ~= max)
	end
end

local function Enable(self)
	if self.DruidPower and (self.unit == 'player') then
		self:RegisterEvent('UNIT_MANA', Update)
		self:RegisterEvent('UNIT_ENERGY', Update)
		self:RegisterEvent('UPDATE_SHAPESHIFT_FORM', Update)
	end

	return true
end

local function Disable(self)
	if self.DruidPower then
		self:UnregisterEvent('UNIT_MANA', Update)
		self:UnregisterEvent('UNIT_ENERGY', Update)
		self:UnregisterEvent('UPDATE_SHAPESHIFT_FORM', Update)
	end
end

oUF:AddElement('DruidPower', Update, Enable, Disable)