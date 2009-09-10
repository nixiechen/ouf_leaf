--[[
	yleaf (yaroot@gmail.com)
	oUF_DebuffHighlight
	
	.DebuffHighlight [boolean or Texture]	
	.DebuffFilter [boolean]
	.CustomDebuffFilter(name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable)
]]

local oUF
do
	local parent = debugstack():match[[\AddOns\(.-)\]]
	local global = GetAddOnMetadata(parent, 'X-oUF')
	oUF = _G[global or 'oUF']
end


local _, class = UnitClass'player'
local orig_colors = {}
local classFilter, debuffColors

do
	t = {
		['PRIEST'] = {
			['Magic'] = true,
			['Disease'] = true,
		},
		['SHAMAN'] = {
			['Poison'] = true,
			['Disease'] = true,
			['Curse'] = true,
		},
		['PALADIN'] = {
			['Poison'] = true,
			['Magic'] = true,
			['Disease'] = true,
		},
		['MAGE'] = {
			['Curse'] = true,
		},
		['DRUID'] = {
			['Curse'] = true,
			['Poison'] = true,
		},
	}
	
	classFilter = t[class]
end

do
	debuffColors = {}
	local t = {
		'Magic',
		'Curse',
		'Disease',
		'Poison',
	}
	
	for k, v in pairs(t) do
		local c = DebuffTypeColor[v]
		debuffColors[v] = {c.r, c.g, c.b}
	end
end

local function Update(self, event, unit)
	if unit ~= self.unit then return end
	local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable
	local i = 1
	
	if UnitCanAssist('player', unit) then
		repeat
			name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable = UnitAura(unit, i, 'HARMFUL')
			
			if self.CustomDebuffFilter then
				if self:CustomDebuffFilter(name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable) then
					break
				end
			elseif debuffType then
				if (not self.DebuffFilter) then
					break
				else
					if classFilter[debuffType] then
						break
					end
				end
			end
			i = i + 1
		until (not name)
	end
	
	if icon then
		if orig_colors[self] then
			local c = debuffColors[debuffType] or orig_colors[self]
			self:SetBackdropColor(unpack(c))
		else
			self.DebuffHighlight:SetTexture(icon)
			self.DebuffHighlight:Show()
		end
	else
		local c = orig_colors[self]
		if c then
			self:SetBackdropColor(unpack(c))
		else
			self.DebuffHighlight:Hide()
		end
	end
end

local function Enable(self)
	if self.DebuffHighlight then
		if self.DebuffFilter and (not classFilter) then return end
		if type(self.DebuffHighlight) == 'table' then
			self.DebuffHighlight:Hide()
		else
			orig_colors[self] = {self:GetBackdropColor()}
		end
		
		self:RegisterEvent('UNIT_AURA', Update)
		
		return true
	end
end

local function Disable(self)
	if self.DebuffHighlight then
		self:UnregisterEvent('UNIT_AURA', Update)
		
		if type(self.DebuffHighlight) == 'table' then
			self.DebuffHighlight:Hide()
		else
			orig_colors[self] = nil
			self:SetBackdropColor(unpack(orig_colors[self]))
		end
	end
end

oUF:AddElement('DebuffHighlight', Update, Enable, Disable)
