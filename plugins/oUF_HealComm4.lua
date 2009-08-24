--[[
	oUF_HealComm4
		makes use of LibHealComm-4.0


]]

local HealComm = LibStub and LibStub('LibHealComm-4.0')
assert(HealComm, 'oUF_HealComm4 needs LibHealComm-4.0')

_G.oUF_HealComm4 = {}
local addon = oUF_HealComm4
function addon:dump(...)
	print(123)
	print(...)
end

HealComm.RegisterCallback(addon, 'HealComm_HealStarted', 'dump')
HealComm.RegisterCallback(addon, 'HealComm_HealDelayed', 'dump')
HealComm.RegisterCallback(addon, 'HealComm_HealUpdated', 'dump')
HealComm.RegisterCallback(addon, 'HealComm_HealStopped', 'dump')
HealComm.RegisterCallback(addon, 'HealComm_ModifierChanged', 'dump')
