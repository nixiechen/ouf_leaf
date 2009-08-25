--[[
	oUF_HealComm4
		makes use of LibHealComm-4.0


]]

local HealComm = LibStub and LibStub('LibHealComm-4.0')
assert(HealComm, 'oUF_HealComm4 needs LibHealComm-4.0')


--[[local addon = {}
function addon:dump(...)
	print(123)
	print(...)
end

HealComm.RegisterCallback(addon, 'HealComm_HealStarted', 'dump')
HealComm.RegisterCallback(addon, 'HealComm_HealDelayed', 'dump')
HealComm.RegisterCallback(addon, 'HealComm_HealUpdated', 'dump')
HealComm.RegisterCallback(addon, 'HealComm_HealStopped', 'dump')
HealComm.RegisterCallback(addon, 'HealComm_ModifierChanged', 'dump')]]
-- DEBUG
local Test = {}
function Test:Dump(...)
	print(...)
end

HealComm.RegisterCallback(Test, "HealComm_HealStarted", "Dump")
HealComm.RegisterCallback(Test, "HealComm_HealDelayed", "Dump")
HealComm.RegisterCallback(Test, "HealComm_HealUpdated", "Dump")
HealComm.RegisterCallback(Test, "HealComm_HealStopped", "Dump")
HealComm.RegisterCallback(Test, "HealComm_ModifierChanged", "Dump")
