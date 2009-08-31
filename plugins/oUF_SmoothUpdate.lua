--local oUF = _G.oUF

local MAX = 1

local objects = {}
local function Smooth(self, value)
	if value ~= self:GetValue() or value == 0 then
		objects[self] = value
	else
		objects[self] = nil
	end
end

local function hook(self)
	if self.Health and self.Health.SmoothUpdate then
		self.Health.Smooth_SetValue = self.Health.SetValue
		self.Health.SetValue = Smooth
	end
	if self.Power and self.Power.SmoothUpdate then
		self.Power.Smooth_SetValue = self.Power.SetValue
		self.Power.SetValue = Smooth
	end
end

for i, frame in ipairs(oUF.objects) do hook(frame) end
oUF:RegisterInitCallback(hook)

local updateFrame = CreateFrame('Frame', 'oUF_SmoothUpdate', UIParent)
updateFrame:SetScript('OnUpdate', function(self, elps)
	local rate = elps/MAX
	
	for bar, value in pairs(objects) do
		local cur = bar:GetValue()
		local new = cur + value * rate
		if new >= value then
			new = value
			objects[bar] = nil
		end
		
		bar:Smooth_SetValue(new)
	end
end)