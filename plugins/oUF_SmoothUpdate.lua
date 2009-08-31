--local oUF = _G.oUF

local MAX = 1

local objects = {}
local function SetValue(self, value)
	if value ~= self:GetValue() or value == 0 then
		objects[self] = value
	else
		objects[self] = nil
	end
end

local function setup(self)
	if self.SmoothUpdate then
		self.Smooth_orig_SetValue = self.SetValue
		self.SetValue = SetValue
	end
end

local function hook(self)
	setup(self.Health)
	setup(self.Power)
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
		
		bar:Smooth_orig_SetValue(new)
	end
end)