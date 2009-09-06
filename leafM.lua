-- yleaf (yaroot@gmail.com)

local oUF
do
	local parent = debugstack():match[[\AddOns\(.-)\]]
	local global = GetAddOnMetadata(parent, 'X-oUF')
	oUF = _G[global or 'oUF']
end


local mt_max = 5
local ma_max = 2
local pt_max = 5
local no_target = '<no target>'
local addon = CreateFrame('Frame', 'oUF_leaf_PT_Menu_Frame', UIParent, 'UIDropDownMenuTemplate')
local menu = {}
local tooltip
local pendingUpdate = true
local attrs = {
	'showRaid', true,
	--'showSolo', true,
	--'groupFilter', nil,
	--'nameList', nil,
	'yOffset', -5,
	--'maxColumns', 1,
	'template', 'ouf_leaf_tar_tartar',
}

oUF:SetActiveStyle('leaf')

local mt = oUF:Spawn('header', 'oUF_MainTank')
mt:SetPoint('TOPLEFT', UIParent, 'TOPLEFT', 10, -25)
mt:SetManyAttributes(unpack(attrs))
mt:SetManyAttributes('groupFilter', 'MAINTANK', 'unitsPerColumn', mt_max)
mt:Show()

local ma = oUF:Spawn('header', 'oUF_MainAssist')
ma:SetPoint('TOPLEFT', mt, 'BOTTOMLEFT', 0, -10)
ma:SetManyAttributes(unpack(attrs))
ma:SetManyAttributes('groupFilter', 'MAINASSIST', 'unitsPerColumn', ma_max)
ma:Show()

local pt = oUF:Spawn('header', 'oUF_PlayerTarget')
pt:SetPoint('TOPLEFT', ma, 'BOTTOMLEFT', 0, -10)
pt:SetManyAttributes(unpack(attrs))
pt:SetManyAttributes('nameList', 'MAINTANK', 'unitsPerColumn', pt_max)
pt:Show()

pt.list = {}
pt.listed = ''

local function output(...)
	DEFAULT_CHAT_FRAME:AddMessage('|cff33ff99oUF leaf:|r ' .. tostringall(...))
end

local function refreshPT()
	pendingUpdate = true

	pt.listed = ''
	for i = 1, pt_max do
		if pt.list[i] then
			pt.listed = pt.listed .. ',' .. pt.list[i]
		end
	end
	
	pt:SetAttribute('nameList', pt.listed)
	pt:Show()
end

StaticPopupDialogs["OUF_LEAF_PT_LIST_WIPE"] = {
	text = 'Are you sure to wipe oUF leaf PT list?',
	button1 = OKAY,
	button2 = CANCEL,
	OnAccept = function()
		wipe(pt.list)
		refreshPT()
		output('PT list wiped')
	end,
	timeout = 10,
	whileDead = 1,
	hideOnEscape = 1,
}

local function handleClick(i)
	if InCombatLockdown() then
		output('cannot set PT during combat')
	else
		if UnitExists('target') then
			local name, realm = UnitName'target'
			if UnitPlayerOrPetInRaid('target') and name and (name ~= '') and (name ~= UNKNOWNOBJECT) then
				if realm and (realm~='') then name = name..'-'..realm end
				for j = 1, pt_max do
					if pt.list[j] == name then
						pt.list[j] = nil
					end
				end
				pt.list[i] = name
				
				refreshPT()
				output(name .. ' has been added to PT list')
			else
				output('target cannot be added into PT list')
			end
		else
			if not pt.list[i] then return end
			output(pt.list[i] .. ' has been removed from PT list')
			pt.list[i] = nil
			refreshPT()
		end
	end
end

local function updateMenu()
	pendingUpdate = false
	menu = wipe(menu)
	
	local title = {text = 'PT list\n ', isTitle = true}
	tinsert(menu, title)
	
	for i = 1, pt_max do
		tinsert(menu, {
			text = i..'. '..(pt.list[i] or no_target),
			func = function() handleClick(i) end,
		})
	end
	
	tinsert(menu, {text = '', disabled = true})
	tinsert(menu, {
		text = '|cffff0000Wipe PT list|r',
		func = function() StaticPopup_Show('OUF_LEAF_PT_LIST_WIPE') end,
	})
	
	tinsert(menu, {text = '', disabled = true})
	tinsert(menu, {text = '|cff00ff00Click to set or remove PT|r', disabled = true})
end

local LibDataBroker = LibStub('LibDataBroker-1.1')
local dataobj = LibDataBroker:NewDataObject('oUF_leaf',{
	type = 'data source',
	text = 'oUF leaf',
	icon = [[Interface\Icons\spell_holy_devotionaura]]
})

function dataobj.OnClick(self, button)
	if button == 'RightButton' then
		if pendingUpdate then
			updateMenu()
		end
		EasyMenu(menu, addon, self, 0, 0, 'MENU')
		local onleave = self:GetScript'OnLeave'
		if onleave then onleave() end
		return
	elseif button == 'LeftButton' then
		refreshPT()
		output('PT list refreshed')
	end
	
	if self and tooltip then
		dataobj.OnTooltipShow(tooltip)
	end
end


function dataobj.OnTooltipShow(tooltip)
	if not tooltip or not tooltip.AddLine then return end
	
	tooltip:AddLine('|cffff8800oUF leaf PT|r')
	tooltip:AddLine('\n')
	
	for i = 1, pt_max do
		tooltip:AddLine(i..'. '..(pt.list[i] or no_target), 1,1,1)
	end
	
	tooltip:AddLine('\n')
	tooltip:AddDoubleLine('LeftClick', 'Refresh PT')
	tooltip:AddDoubleLine('RightClick', 'Toggle menu')
end

ouf_leaf.units.mt = mt
ouf_leaf.units.ma = ma
ouf_leaf.units.pt = pt
refreshPT()


--[[
List of the various configuration attributes
======================================================
showRaid = [BOOLEAN] -- true if the header should be shown while in a raid
showParty = [BOOLEAN] -- true if the header should be shown while in a party and not in a raid
showPlayer = [BOOLEAN] -- true if the header should show the player when not in a raid
showSolo = [BOOLEAN] -- true if the header should be shown while not in a group (implies showPlayer)
nameList = [STRING] -- a comma separated list of player names (not used if 'groupFilter' is set)
groupFilter = [1-8, STRING] -- a comma seperated list of raid group numbers and/or uppercase class names and/or uppercase roles
strictFiltering = [BOOLEAN] - if true, then characters must match both a group and a class from the groupFilter list
point = [STRING] -- a valid XML anchoring point (Default: 'TOP')
xOffset = [NUMBER] -- the x-Offset to use when anchoring the unit buttons (Default: 0)
yOffset = [NUMBER] -- the y-Offset to use when anchoring the unit buttons (Default: 0)
sortMethod = ['INDEX', 'NAME'] -- defines how the group is sorted (Default: 'INDEX')
sortDir = ['ASC', 'DESC'] -- defines the sort order (Default: 'ASC')
template = [STRING] -- the XML template to use for the unit buttons
templateType = [STRING] - specifies the frame type of the managed subframes (Default: 'Button')
groupBy = [nil, 'GROUP', 'CLASS', 'ROLE'] - specifies a 'grouping' type to apply before regular sorting (Default: nil)
groupingOrder = [STRING] - specifies the order of the groupings (ie. '1,2,3,4,5,6,7,8')
maxColumns = [NUMBER] - maximum number of columns the header will create (Default: 1)
unitsPerColumn = [NUMBER or nil] - maximum units that will be displayed in a singe column, nil is infinate (Default: nil)
startingIndex = [NUMBER] - the index in the final sorted unit list at which to start displaying units (Default: 1)
columnSpacing = [NUMBER] - the ammount of space between the rows/columns (Default: 0)
columnAnchorPoint = [STRING] - the anchor point of each new column (ie. use LEFT for the columns to grow to the right)
]]
