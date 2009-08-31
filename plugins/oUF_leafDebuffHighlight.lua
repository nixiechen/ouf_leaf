--[[
	yleaf (yaroot@gmail.com)
	oUF_leafDebuffHighlight
	
	.leafDebuffHighlight [boolean or Texture]	
	.leafDebuffFilter [boolean]
]]

--local oUF = _G.oUF

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
	
	repeat
		name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable = UnitAura(unit, i, 'HARMFUL') 
		if debuffType then
			if (not self.leafDebuffFilter) then
				break
			else
				if classFilter[debuffType] then
					break
				end
			end
		end
		i = i + 1
	until (not name)
	
	if debuffType then
		if self.leafDebuffHighlighted ~= debuffType then
			self.leafDebuffHighlighted = debuffType
			
			if orig_colors[self] then
				local c = debuffColors[debuffType]
				self:SetBackdropColor(unpack(c))
			else
				self.leafDebuffHighlight:SetTexture(icon)
				self.leafDebuffHighlight:Show()
			end
		end
	else
		if self.leafDebuffHighlighted then
			self.leafDebuffHighlighted = nil
			local c = orig_colors[self]
			if c then
				self:SetBackdropColor(unpack(c))
			else
				self.leafDebuffHighlight:Hide()
			end
		end
	end
end

local function Enable(self)
	if self.leafDebuffHighlight then
		if self.leafDebuffFilter and (not classFilter) then return end
		if type(self.leafDebuffHighlight) == 'table' then
			self.leafDebuffHighlight:Hide()
		else
			orig_colors[self] = {self:GetBackdropColor()}
		end
		
		self:RegisterEvent('UNIT_AURA', Update)
		
		return true
	end
end

local function Disable(self)
	if self.leafDebuffHighlight then
		self:UnregisterEvent('UNIT_AURA', Update)
		
		if type(self.leafDebuffHighlight) == 'table' then
			self.leafDebuffHighlight:Hide()
		else
			orig_colors[self] = nil
			self:SetBackdropColor(unpack(orig_colors[self]))
		end
	end
end

oUF:AddElement('leafDebuffHighlight', Update, Enable, Disable)
