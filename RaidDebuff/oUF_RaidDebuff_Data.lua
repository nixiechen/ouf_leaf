-- yleaf (yaroot@gmail.com)

local loc = GetLocale()
local L = loc == 'zhCN' and {
	['Karazhan'] = '卡拉赞',
	['Zul\'Aman'] = '祖阿曼',
	['Serpentshrine Cavern'] = '毒蛇神殿',
	['Tempest Keep'] = '风暴要塞',
	['Hyjal Summit'] = '海加尔峰',
	['Black Temple'] = '黑暗神殿',
	['Sunwell Plateau'] = '太阳之井高地',
	['Naxxramas'] = '纳克萨玛斯',
	['The Obsidian Sanctum'] = '黑曜石圣殿',
	['The Eye of Eternity'] = '永恒之眼',
	['Ulduar'] = '奥杜尔',
	['Trial of the Crusader'] = '十字军试炼',
} or loc == 'zhTW' and {
	['Karazhan'] = '卡拉贊',
	['Zul\'Aman'] = '祖阿曼',
	['Serpentshrine Cavern'] = '毒蛇神殿洞穴',
	['Tempest Keep'] = '風暴要塞',
	['Hyjal Summit'] = '海加爾山',
	['Black Temple'] = '黑暗神廟',
	['Sunwell Plateau'] = '太陽之井高地',
	['Naxxramas'] = '納克薩瑪斯',
	['The Obsidian Sanctum'] = '黑曜聖',
	['The Eye of Eternity'] = '永恆之眼',
	['Ulduar'] = '奧杜亞',
	['Trial of the Crusader'] = '十字軍試煉',
}

_G.oUF_RaidDebuff.DebuffData = {}


oUF_RaidDebuff.backupbz = _G.BZ
oUF_RaidDebuff.backupbb = _G.BB


_G.BZ = setmetatable({}, {
	__index = function(t,i)
		t[i] = L and L[i] or i
		return t[i]
	end
})

_G.BB = setmetatable({}, {
	__index = function(t,i)
		t[i] = i
		return t[i]
	end
})


_G.GridStatusRaidDebuff = {}


function GridStatusRaidDebuff:RegisterDebuff(zone, debuffID, order, duration, stackable, color, disable, auraCheck)
	local dd = oUF_RaidDebuff.DebuffData
	dd[zone] = dd[zone] or {}
	local zone_table = dd[zone]
	zone_table[debuffID] = {
		['order'] = order,
		['duration'] = duration,
		['stackable'] = stackable,
		['color'] = color,
		--['disable'] = disable,
		['auraCheck'] = auraCheck,
	}
end

function GridStatusRaidDebuff:RegisterDebuffDelegater(zone, debuffID, ...)
	local dd = oUF_RaidDebuff.DebuffData
	local zone_table = dd[zone]

	local n = select('#',...)
	if n > 0 then
		for i = 1,n do
			local delegaterID = select(i,...)
			zone_table[delegaterID] = CopyTable(zone_table[debuffID])
		end
	end

	
end

function GridStatusRaidDebuff:RegisterMenuHeader(zone, order, header)
end
function GridStatusRaidDebuff:RegisterDebuffDelMod(zone, delID, debuffID, duration, stackable, color)
end

if not ouf_leaf.test_mod then return end

GridStatusRaidDebuff:RegisterDebuff('沙塔斯城', 33763, 1, 7, true)
GridStatusRaidDebuff:RegisterDebuff('沙塔斯城', 33763, 1, 7, true)

GridStatusRaidDebuff:RegisterDebuff('沙塔斯城', 26982, 2, 12)
GridStatusRaidDebuff:RegisterDebuffDelegater('沙塔斯城', 26982, 26981)

