----------------------------------------------------------------------------------------------------
--- The Creation Come From: BOT EXPERIMENT Credit:FURIOUSPUPPY
--- BOT EXPERIMENT Author: Arizona Fauzie 2018.11.21
--- Link:http://steamcommunity.com/sharedfiles/filedetails/?id=837040016
--- Refactor: 决明子 Email: dota2jmz@163.com 微博@Dota2_决明子
--- Link:http://steamcommunity.com/sharedfiles/filedetails/?id=1573671599
--- Link:http://steamcommunity.com/sharedfiles/filedetails/?id=1627071163
--- Updated: Nikel
--- mid, tank, mage
----------------------------------------------------------------------------------------------------
local X = {}
local bDebugMode = ( 1 == 10 )
local bot = GetBot()

local J = require( GetScriptDirectory()..'/FunLib/jmz_func' )
local A = dofile( GetScriptDirectory()..'/FunLib/aba_ability' )
local Minion = dofile( GetScriptDirectory()..'/FunLib/aba_minion' )
local sTalentList = J.Skill.GetTalentList( bot )
local sAbilityList = J.Skill.GetAbilityList( bot )
local sOutfitType = J.Item.GetOutfitType( bot )

local tTalentTreeList = {
	['outfit_carry'] = {
		['t25'] = {10, 0},
		['t20'] = {10, 0},
		['t15'] = {0, 10},
		['t10'] = {0, 10},
	},

	['outfit_mid'] = {
		['t25'] = {10, 0},
		['t20'] = {10, 0},
		['t15'] = {0, 10},
		['t10'] = {0, 10},
	},

	['outfit_priest'] = {
		['t25'] = {0, 10},
		['t20'] = {0, 10},
		['t15'] = {10, 0},
		['t10'] = {10, 0},
	},

	['outfit_mage'] = {
		['t25'] = {0, 10},
		['t20'] = {0, 10},
		['t15'] = {10, 0},
		['t10'] = {10, 0},
	},

	['outfit_tank'] = {
		['t25'] = {10, 0},
		['t20'] = {10, 0},
		['t15'] = {0, 10},
		['t10'] = {0, 10},
	},
}

local tAllAbilityBuildList = {
	['outfit_carry'] = {
		{1,3,1,2,1,6,1,3,3,3,6,2,2,2,6}
	},

	['outfit_mid'] = {
		{1,3,1,2,1,6,1,3,3,3,6,2,2,2,6}
	},

	['outfit_priest'] = {
		{2,1,3,1,1,6,1,2,2,2,6,3,3,3,6}
	},

	['outfit_mage'] = {
		{2,1,3,1,1,6,1,2,2,2,6,3,3,3,6}
	},

	['outfit_tank'] = {
		{1,3,1,2,1,6,1,3,3,3,6,2,2,2,6}
	},
}

local nAbilityBuildList = J.Skill.GetRandomBuild( tAllAbilityBuildList[sOutfitType] )

local nTalentBuildList = J.Skill.GetTalentBuild( tTalentTreeList[sOutfitType] )

local sRandomItem = RandomInt( 1, 9 ) > 6 and 0 or 10
local sRandomItem_1 = sRandomItem == 0 and "item_blink" or "item_invis_sword"
local sRandomItem_2 = sRandomItem == 0 and "item_arcane_blink" or "item_silver_edge"

local tOutFitList = {}

tOutFitList['outfit_carry'] = {

	"item_mid_lina_outfit",
	"item_black_king_bar",
	sRandomItem_1,
	"item_satanic",
	"item_aghanims_shard",
	"item_ultimate_scepter",
	"item_monkey_king_bar",
	sRandomItem_2,
	"item_travel_boots",
	"item_ultimate_scepter_2",
	"item_greater_crit",
	"item_moon_shard",
	"item_travel_boots_2",

}

tOutFitList['outfit_mid'] = tOutFitList['outfit_carry']

tOutFitList['outfit_priest'] = {

	"item_mage_lina_outfit",
	"item_veil_of_discord",
	"item_cyclone",
	"item_force_staff",
	"item_pipe",
	"item_ultimate_scepter",
	"item_orchid",
	"item_aghanims_shard",
	"item_hurricane_pike",
	"item_bloodthorn",
	"item_ultimate_scepter_2",
	"item_shivas_guard",
	"item_travel_boots",
	"item_wind_waker",
	"item_moon_shard",
	"item_travel_boots_2",

}

tOutFitList['outfit_mage'] = tOutFitList['outfit_priest']

tOutFitList['outfit_tank'] = {

	"item_tank_lina_outfit",
	"item_cyclone",
	"item_blink",
	"item_black_king_bar",
	"item_ultimate_scepter",
	"item_aghanims_shard",
	"item_sheepstick",
	"item_travel_boots",
	"item_ultimate_scepter_2",
	"item_kaya",
	"item_ethereal_blade",
	"item_wind_waker",
	"item_arcane_blink",
	"item_moon_shard",
	"item_travel_boots_2",

}

X['sBuyList'] = tOutFitList[sOutfitType]

X['sSellList'] = {

	"item_ultimate_orb",
	"item_bottle",

	"item_monkey_king_bar",
	"item_falcon_blade",

	"item_travel_boots",
	"item_phase_boots",

	"item_orchid",
	"item_veil_of_discord",

	"item_travel_boots",
	"item_arcane_boots",
	
	"item_sheepstick",
	"item_null_talisman",

}

if J.Role.IsPvNMode() or J.Role.IsAllShadow() then X['sBuyList'], X['sSellList'] = { 'PvN_mage' }, {} end

nAbilityBuildList, nTalentBuildList, X['sBuyList'], X['sSellList'] = J.SetUserHeroInit( nAbilityBuildList, nTalentBuildList, X['sBuyList'], X['sSellList'] )

X['sSkillList'] = J.Skill.GetSkillList( sAbilityList, nAbilityBuildList, sTalentList, nTalentBuildList )

X['bDeafaultAbility'] = false
X['bDeafaultItem'] = false


function X.MinionThink( hMinionUnit )

	Minion.MinionThink( hMinionUnit )

end

--[[


npc_dota_hero_lina


"Ability1"		"lina_dragon_slave"
"Ability2"		"lina_light_strike_array"
"Ability3"		"lina_fiery_soul"
"Ability4"		"lina_flame_cloak"
"Ability5"		"generic_hidden"
"Ability6"		"lina_laguna_blade"
"Ability10"		"special_bonus_attack_damage_20"
"Ability11"		"special_bonus_unique_lina_1"
"Ability12"		"special_bonus_hp_350"
"Ability13"		"special_bonus_unique_lina_3"
"Ability14"		"special_bonus_spell_amplify_11"
"Ability15"		"special_bonus_unique_lina_2"
"Ability16"		"special_bonus_unique_lina_6"
"Ability17"		"special_bonus_unique_lina_7"


modifier_lina_light_strike_array
modifier_lina_fiery_soul
modifier_lina_flame_cloak
modifier_lina_laguna_blade


--]]

local abilityQ = bot:GetAbilityByName( sAbilityList[1] )
local abilityW = bot:GetAbilityByName( sAbilityList[2] )
local abilityD = bot:GetAbilityByName( sAbilityList[4] )
local abilityR = bot:GetAbilityByName( sAbilityList[6] )

local castQDesire, castQLocation
local castWDesire, castWLocation
local castDDesire
local castRDesire, castRTarget

local sMotive


function X.SkillsComplement()

	if J.CanNotUseAbility( bot ) or bot:IsInvisible() then return end

	
	castDDesire, sMotive = A.ConsiderLinaFlameCloak( bot )
	if castDDesire > 0
	then
		J.SetReportMotive( bDebugMode, sMotive )
		J.SetQueuePtToINT( bot, true )
		bot:ActionQueue_UseAbility( abilityD )
		return
	end

	castWDesire, castWLocation, sMotive = A.ConsiderLinaLightStrikeArray( bot )
	if ( castWDesire > 0 )
	then
		J.SetReportMotive( bDebugMode, sMotive )
		J.SetQueuePtToINT( bot, true )
		bot:ActionQueue_UseAbilityOnLocation( abilityW, castWLocation )
		return
	end
	
	castQDesire, castQLocation, sMotive = A.ConsiderLinaDragonSlave( bot )
	if ( castQDesire > 0 )
	then
		J.SetReportMotive( bDebugMode, sMotive )
		J.SetQueuePtToINT( bot, true )
		bot:ActionQueue_UseAbilityOnLocation( abilityQ, castQLocation )
		return
	end

	castRDesire, castRTarget, sMotive = A.ConsiderLinaLagunaBlade( bot )
	if ( castRDesire > 0 )
	then
		J.SetReportMotive( bDebugMode, sMotive )
		J.SetQueuePtToINT( bot, true )
		bot:ActionQueue_UseAbilityOnEntity( abilityR, castRTarget )
		return
	end

end

return X