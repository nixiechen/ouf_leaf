--==============================================================================
--
-- oUF_HealComm
--
-- Uses data from LibHealComm-3.0 to add incoming heal estimate bars onto units 
-- health bars.
--
-- * currently won't update the frame if max HP is unknown (ie, restricted to 
--   players/pets in your group that are in range), hides the bar for these
-- * can define frame.ignoreHealComm in layout to not have the bars appear on 
--   that frame
--
--=============================================================================
if not oUF then return end

--set texture and color here
local color = {
    r = 0,
    g = 1,
    b = 0,
    a = .25,
}

local oUF_HealComm = {}

local healcomm = LibStub("LibHealComm-3.0")

local playerName = UnitName("player")
local playerIsCasting = false
local playerHeals = 0
local playerTarget = ""

--update a specific bar
local updateHealCommBar = function(frame, unit)
    local curHP = UnitHealth(unit)
    local maxHP = UnitHealthMax(unit)
    local percHP = curHP / maxHP

    local incHeals = select(2, healcomm:UnitIncomingHealGet(unit, GetTime())) or 0

    --add player's own heals if casting on this unit
    if playerIsCasting then
        for i = 1, select("#", playerTarget) do
            local target = select(i, playerTarget)
            if target == unit then
                incHeals = incHeals + playerHeals
            end
        end
    end

    --hide if unknown max hp or no heals inc
    if maxHP == 100 or incHeals == 0 then
        frame.HealCommBar:Hide()
        return
    else
        frame.HealCommBar:Show()
    end

    local percInc = incHeals / maxHP

    frame.HealCommBar:SetWidth(percInc * frame.Health:GetWidth())
    frame.HealCommBar:SetPoint("LEFT", frame.Health, "LEFT", frame.Health:GetWidth() * percHP, 0)
end

--used by library callbacks, arguments should be list of units to update
local updateHealCommBars = function(...)
	for i = 1, select("#", ...) do
		local unit = select(i, ...)

        --search current oUF frames for this unit
        for frame in pairs(oUF.units) do
            local name, server = UnitName(frame)
            if server then name = strjoin("-",name,server) end
            if name == unit and not oUF.units[frame].ignoreHealComm then
                updateHealCommBar(oUF.units[frame],unit)
            end
        end
	end
end

local function hook(frame)
	if frame.ignoreHealComm then return end

    --create heal bar here and set initial values
	local hcb = CreateFrame"StatusBar"
	hcb:SetHeight(frame.Health:GetHeight()) -- same height as health bar
    hcb:SetWidth(0) --no initial width
	hcb:SetStatusBarTexture(frame.Health:GetStatusBarTexture():GetTexture())
    hcb:SetStatusBarColor(color.r, color.g, color.b, color.a)
    hcb:SetParent(frame)
    hcb:SetPoint("LEFT", frame.Health, "RIGHT") --attach to immediate right of health bar to start
    hcb:Hide() --hide it for now

    frame.HealCommBar = hcb

	local o = frame.PostUpdateHealth
	frame.PostUpdateHealth = function(...)
		if o then o(...) end
        local name, server = UnitName(frame.unit)
        if server then name = strjoin("-",name,server) end
        updateHealCommBar(frame, name) --update the bar when unit's health is updated
	end
end

--hook into all existing frames
for i, frame in ipairs(oUF.objects) do hook(frame) end

--hook into new frames as they're created
oUF:RegisterInitCallback(hook)

--set up LibHealComm callbacks
function oUF_HealComm:HealComm_DirectHealStart(event, healerName, healSize, endTime, ...)
	if healerName == playerName then
		playerIsCasting = true
		playerTarget = ... 
		playerHeals = healSize
	end
    updateHealCommBars(...)
end

function oUF_HealComm:HealComm_DirectHealUpdate(event, healerName, healSize, endTime, ...)
    updateHealCommBars(...)
end

function oUF_HealComm:HealComm_DirectHealStop(event, healerName, healSize, succeeded, ...)
    if healerName == playerName then
        playerIsCasting = false
    end
    updateHealCommBars(...)
end

function oUF_HealComm:HealComm_HealModifierUpdate(event, unit, targetName, healModifier)
    updateHealCommBars(unit)
end

healcomm.RegisterCallback(oUF_HealComm, "HealComm_DirectHealStart")
healcomm.RegisterCallback(oUF_HealComm, "HealComm_DirectHealUpdate")
healcomm.RegisterCallback(oUF_HealComm, "HealComm_DirectHealStop")
healcomm.RegisterCallback(oUF_HealComm, "HealComm_HealModifierUpdate")
