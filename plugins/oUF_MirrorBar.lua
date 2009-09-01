




MIRROR_TIMER_START ("name", value, maxvalue, step, pause, "label")
MIRROR_TIMER_PAUSE (duration)
MIRROR_TIMER_STOP ("name")

for i = 1, MIRRORTIMER_NUMTIMERS do
	local f = _G['MirrorTimer'..i]
	f:UnregisterAllEvents()
end
UIParent:UnregisterEvent'MIRROR_TIMER_START'
