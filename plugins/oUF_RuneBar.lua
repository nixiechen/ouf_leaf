--[[

	Elements handled:
	 .RuneBar [fontstring or table]

	FontString only:
	- space: [string] The space between each "counter". (Default: " ")
	- symbol: [string] The symbol used when cooldowns are over. (Default: "*")
	- interval: [value] The time offset used for the update script. (Default: 0.5)

	StatusBar only:
	- PostUpdate(bar, event, rune, usable)
--]]
local localized, class = UnitClass('player')
if class ~= 'DEATHKNIGHT' then return end

local unpack = unpack
local floor = math.floor
local format = string.format

local updateBar, updateText
do
	local total = 0
	function updateText(self, elapsed)
		total = total + elapsed

		if(total >= (self.RuneBar.interval or 0.5)) then
			self:UpdateElement('RuneBar')
			total = 0
		end
	end

	function updateBar(self, rune)
		local start, duration, ready = GetRuneCooldown(rune)

		if(ready) then
			self:SetValue(1)
			self:SetScript('OnUpdate', nil)
		else
			self:SetValue((GetTime() - start) / duration)
		end
	end
end	

local function statusbar(self, event, rune, usable)
	local bar = self.RuneBar
	if(rune and not usable and GetRuneType(rune)) then
		bar[rune]:SetScript('OnUpdate', function(self) updateBar(self, rune) end)
	end

	for index = 1, 6 do
		local runetype = GetRuneType(index)
		if(runetype) then
			bar[index]:SetStatusBarColor(unpack(bar.colors[runetype]))
		end
	end	

	if(bar.PostUpdate) then bar:PostUpdate(event, rune, usable) end
end

local function fontstring(self)
	local text, str = self.RuneBar, ''

	for index = 1, 6 do
		local start, duration, ready = GetRuneCooldown(i)
		local r, g, b = unpack(text.colors[GetRuneType(index)])

		str = format('%s|cff%02x%02x%02x%s%s|r', str, r * 255, g * 255, b * 255, ready and (text.symbol or '*') or floor(duration - floor(GetTime() - start)), index ~= 6 and (text.space or ' ') or '')
	end

	text:SetText(str)
end

local function enable(self, unit)
	local bar = self.RuneBar
	if(bar and unit == 'player' and class == 'DEATHKNIGHT') then
		local c = self.colors.runes or {}
		bar.colors = {c[1] or {0.77, 0.12, 0.23}, c[2] or {0.3, 0.8, 0.1}, c[3] or {0, 0.4, 0.7}, c[4] or {0.8, 0.8, 0.8}}

		if(#bar == 0) then
			self:RegisterEvent('RUNE_TYPE_UPDATE', fontstring)
			self:RegisterEvent('RUNE_POWER_UPDATE', fontstring)

			bar.dummy = CreateFrame('Frame', nil, self)
			bar.dummy:SetScript('OnUpdate', function(_, elapsed) updateText(self, elapsed) end)
		else
			self:RegisterEvent('RUNE_TYPE_UPDATE', statusbar)
			self:RegisterEvent('RUNE_POWER_UPDATE', statusbar)

			for index = 1, 6 do
				bar[index]:SetMinMaxValues(0, 1)
			end
		end

		--RuneFrame:Hide()

		return true
	end
end

local function disable(self)
	local bar = self.RuneBar
	if(bar) then
		if(#bar == 0) then
			self:UnregisterEvent('RUNE_TYPE_UPDATE', fontstring)
			self:UnregisterEvent('RUNE_POWER_UPDATE', fontstring)

			bar.dummy:SetScript('OnUpdate', nil)
		else
			self:UnregisterEvent('RUNE_TYPE_UPDATE', statusbar)
			self:UnregisterEvent('RUNE_POWER_UPDATE', statusbar)
		end

		RuneFrame:Show()
	end
end

oUF:AddElement('RuneBar', function(...)
	if(#self.RuneBar == 0) then
		fontstring(...)
	else
		statusbar(...)
	end
end, enable, disable)