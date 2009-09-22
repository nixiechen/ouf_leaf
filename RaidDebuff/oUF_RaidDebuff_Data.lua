-- yleaf (yaroot@gmail.com)

local L = GetLocale() == 'zhCN' and {
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
	['Vault of Archavon'] = '阿尔卡冯的宝库',
} or GetLocale() == 'zhTW' and {
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
	['Vault of Archavon'] = '亞夏梵穹殿',
} or {}

oUF_RaidDebuff.DebuffData = {}

GridStatusRaidDebuff = {}

function GridStatusRaidDebuff:Debuff(en_zone, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon)
	local ddata = oUF_RaidDebuff.DebuffData
	local zone = L[en_zone] or en_zone
	ddata[zone] = ddata[zone] or {}
	local zone_table = ddata[zone]
	zone_table[debuffID] = {
		['order'] = order or 0,
		['timer'] = timer,
		['stackable'] = stackable,
		['color'] = color,
	}
end

function GridStatusRaidDebuff:BossName(en_zone, order, en_boss)
end

function GridStatusRaidDebuff:Wipe()
	wipe(GridStatusRaidDebuff)
	GridStatusRaidDebuff = nil
end

if not ouf_leaf.test_mod then return end

GridStatusRaidDebuff:Debuff('沙塔斯城', 33763, 1, 7, true)
GridStatusRaidDebuff:Debuff('沙塔斯城', 33763, 1, 7, true)

GridStatusRaidDebuff:Debuff('沙塔斯城', 26982, 2, 12)
GridStatusRaidDebuff:Debuff('沙塔斯城', 26982, 26981)

