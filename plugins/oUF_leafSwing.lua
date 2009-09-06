--[[
	Credits:	oUF_AutoShot by p3lim
			ACB_Swing by Aezay
			yleaf(yaroot@gmail.com)
	
	Elements handled:
	 .Swing [statusbar]
	 .Swing.Text [fontstring]

	Functions that can be overridden from within a layout:
	 - :OverrideSwing(startTime, endTime, currentTime)

--]]
local oUF
do
	local parent = debugstack():match[[\AddOns\(.-)\]]
	local global = GetAddOnMetadata(parent, 'X-oUF')
	oUF = _G[global or 'oUF']
end

local _, pClass = UnitClass('player')
if (pClass == 'WARLOCK') or (pClass == 'MAGE') or (pClass == 'PRIEST') then return end

local pGUID = UnitGUID('player')
local start, finish, current = 0, 0, 0
local GetTime = GetTime
local spellSwingReset = {}
for _, v in pairs{	78, -- Heroic Strike
					1464, -- Slam
					6807, -- Maul
						} do
	local name = GetSpellInfo(v)
	spellSwingReset[name] = true
end

local function UpdateDuration(self, elapsed)
	current = GetTime()
	if(current > finish) then
		self:SetAlpha(0)
		self:SetScript('OnUpdate', nil)
	else
		self:SetValue(current)
		
		if(self.Text) then
			if(self.OverrideSwing) then
				self:OverrideSwing(start, finish, current)
			else
				self.Text:SetFormattedText('%.1f', finish - current)
			end
		end
	end
end

local function Update(self,event,timeStamp,eventType,sourceGUID,sourceName,sourceFlags,destGUID,destName,destFlags,a,b)
	if (sourceGUID ~= pGUID) and (destGUID ~= pGUID) then return end
	if (not eventType) then return end
	local prefix, suffix = eventType:match('(.-)_(.+)')
	local swing = self.Swing
	if sourceGUID == pGUID then
		if (prefix == 'SWING') then
			start = GetTime()
			finish = start + UnitAttackSpeed('player')
			
			swing:SetScript('OnUpdate', UpdateDuration)
			swing:SetAlpha(1)
			swing:SetMinMaxValues(start, finish)
		elseif (prefix == 'RANGE') and (a == 75) then
			start = GetTime()
			finish = start + UnitRangedDamage('player')
			
			swing:SetScript('OnUpdate', UpdateDuration)
			swing:SetAlpha(1)
			swing:SetMinMaxValues(start, finish)
		elseif (prefix == 'SPELL') and spellSwingReset[b] then
			start = GetTime()
			finish = start + UnitAttackSpeed('player')
			
			swing:SetScript('OnUpdate', UpdateDuration)
			swing:SetAlpha(1)
			swing:SetMinMaxValues(start, finish)
		end
	elseif destGUID == pGUID then
		if (suffix == 'MISSED') and (a == 'PARRY') then
			if finish > GetTime() then
				finish = finish - ((finish - GetTime()) * 0.5)
				swing:SetMinMaxValues(start, finish)
			end
		end
	end
end

local function Enable(self)
	local swing = self.Swing
	if(swing) then
		self:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED', Update)

		if(not swing:GetStatusBarTexture()) then
			swing:SetStatusBarTexture([=[Interface\TargetingFrame\UI-StatusBar]=])
		end

		swing:SetAlpha(0)

		return true
	end
end

local function Disable(self)
	if(self.Swing) then
		self:UnregisterEvent('COMBAT_LOG_EVENT_UNFILTERED', Update)
	end
end

oUF:AddElement('Swing', Update, Enable, Disable)
