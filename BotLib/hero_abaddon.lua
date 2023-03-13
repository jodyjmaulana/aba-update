----------------------------------------------------------------------------------------------------
--- The Creation Come From: BOT EXPERIMENT Credit:FURIOUSPUPPY
--- BOT EXPERIMENT Author: Arizona Fauzie 2018.11.21
--- Link:http://steamcommunity.com/sharedfiles/filedetails/?id=837040016
--- Refactor: 决明子 Email: dota2jmz@163.com 微博@Dota2_决明子
--- Link:http://steamcommunity.com/sharedfiles/filedetails/?id=1573671599
--- Link:http://steamcommunity.com/sharedfiles/filedetails/?id=1627071163
--- Updated: Nikel
--- carry, tank, mage, priest
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
		['t25'] = {0, 10},
		['t20'] = {10, 0},
		['t15'] = {0, 10},
		['t10'] = {10, 0},
	},

	['outfit_mid'] = {
		['t25'] = {0, 10},
		['t20'] = {10, 0},
		['t15'] = {0, 10},
		['t10'] = {10, 0},
	},

	['outfit_priest'] = {
		['t25'] = {10, 0},
		['t20'] = {0, 10},
		['t15'] = {10, 0},
		['t10'] = {0, 10},
	},

	['outfit_mage'] = {
		['t25'] = {10, 0},
		['t20'] = {0, 10},
		['t15'] = {10, 0},
		['t10'] = {0, 10},
	},

	['outfit_tank'] = {
		['t25'] = {0, 10},
		['t20'] = {10, 0},
		['t15'] = {0, 10},
		['t10'] = {10, 0},
	},
}

local tAllAbilityBuildList = {
	['outfit_carry'] = {
		{2,3,3,2,3,6,3,2,2,1,6,1,1,1,6}
	},

	['outfit_mid'] = {
		{2,3,3,2,3,6,3,2,2,1,6,1,1,1,6}
	},

	['outfit_priest'] = {
		{2,1,3,2,1,6,2,2,1,1,6,3,3,3,6}
	},

	['outfit_mage'] = {
		{2,1,3,2,1,6,2,2,1,1,6,3,3,3,6}
	},

	['outfit_tank'] = {
		{2,3,2,1,3,6,2,3,2,3,6,1,1,1,6}
	},
}

local nAbilityBuildList = J.Skill.GetRandomBuild( tAllAbilityBuildList[sOutfitType] )

local nTalentBuildList = J.Skill.GetTalentBuild( tTalentTreeList[sOutfitType] )

local sRandomItem_1 = RandomInt( 1, 9 ) > 6 and "item_manta" or "item_black_king_bar"

local tOutFitList = {}

tOutFitList['outfit_carry'] = {

	"item_sven_outfit",
	"item_echo_sabre",
	"item_basher",
	sRandomItem_1,
	"item_assault",
	"item_abyssal_blade",
	"item_ultimate_scepter",
	"item_radiance",
	"item_aghanims_shard",
	"item_travel_boots",
	"item_ultimate_scepter_2",
	"item_nullifier",
	"item_moon_shard",
	"item_travel_boots_2",

}

tOutFitList['outfit_mid'] = tOutFitList['outfit_carry']

tOutFitList['outfit_priest'] = {

	"item_priest_outfit",
	"item_mekansm",
	"item_vladmir",
	"item_holy_locket",
	"item_ultimate_scepter",
	"item_guardian_greaves",
	"item_spirit_vessel",
	"item_solar_crest",
	"item_wraith_pact",
	"item_aghanims_shard",
	"item_ultimate_scepter_2",
	"item_shivas_guard",
	"item_moon_shard",

}

tOutFitList['outfit_mage'] = {

	"item_abaddon_outfit",
	"item_ancient_janggo",
	"item_pipe",
	"item_ultimate_scepter",
	"item_medallion_of_courage",
	"item_boots_of_bearing",
	"item_crimson_guard",
	"item_lotus_orb",
	"item_solar_crest",
	"item_aghanims_shard",
	"item_ultimate_scepter_2",
	"item_shivas_guard",
	"item_moon_shard",

}

tOutFitList['outfit_tank'] = {

	"item_tank_outfit",
	"item_vanguard",
	"item_blade_mail",
	"item_lotus_orb",
	"item_crimson_guard",
	"item_heavens_halberd",
	"item_ultimate_scepter",
	"item_assault",
	"item_aghanims_shard",
	"item_travel_boots",
	"item_ultimate_scepter_2",
	"item_radiance",
	"item_moon_shard",
	"item_travel_boots_2",

}

X['sBuyList'] = tOutFitList[sOutfitType]

X['sSellList'] = {
	"item_lotus_orb",
	"item_quelling_blade",

	"item_basher",
	"item_quelling_blade",

	"item_heavens_halberd",
	"item_bracer",

	"item_ultimate_scepter",
	"item_magic_wand",

	"item_assault",
	"item_magic_wand",

	"item_ultimate_scepter",
	"item_soul_ring",

	"item_assault",
	"item_blade_mail",

	"item_travel_boots",
	"item_power_treads",

	"item_medallion_of_courage",
	"item_magic_wand",

	"item_radiance",
	"item_echo_sabre",

	"item_travel_boots",
	"item_phase_boots",
}

if J.Role.IsPvNMode() or J.Role.IsAllShadow() then X['sBuyList'], X['sSellList'] = { 'PvN_str_carry' }, {} end

nAbilityBuildList, nTalentBuildList, X['sBuyList'], X['sSellList'] = J.SetUserHeroInit( nAbilityBuildList, nTalentBuildList, X['sBuyList'], X['sSellList'] )

X['sSkillList'] = J.Skill.GetSkillList( sAbilityList, nAbilityBuildList, sTalentList, nTalentBuildList )

X['bDeafaultAbility'] = false
X['bDeafaultItem'] = false

function X.MinionThink( hMinionUnit )

	Minion.MinionThink( hMinionUnit )

end

--[[

npc_dota_hero_abaddon

"Ability1"		"abaddon_death_coil"
"Ability2"		"abaddon_aphotic_shield"
"Ability3"		"abaddon_frostmourne"
"Ability4"		"generic_hidden"
"Ability5"		"generic_hidden"
"Ability6"		"abaddon_borrowed_time"
"Ability10"		"special_bonus_unique_abaddon_6"
"Ability11"		"special_bonus_strength_8"
"Ability12"		"special_bonus_attack_damage_65"
"Ability13"		"special_bonus_unique_abaddon_2"
"Ability14"		"special_bonus_unique_abaddon"
"Ability15"		"special_bonus_unique_abaddon_5"
"Ability16"		"special_bonus_unique_abaddon_3"
"Ability17"		"special_bonus_unique_abaddon_4"

modifier_abaddon_aphotic_shield
modifier_abaddon_frostmourne
modifier_abaddon_frostmourne_buff
modifier_abaddon_frostmourne_debuff
modifier_abaddon_frostmourne_debuff_bonus
modifier_abaddon_borrowed_time_passive
modifier_abaddon_borrowed_time
modifier_abaddon_borrowed_time_damage_redirect

--]]

local abilityQ = bot:GetAbilityByName( sAbilityList[1] )
local abilityW = bot:GetAbilityByName( sAbilityList[2] )
local abilityR = bot:GetAbilityByName( sAbilityList[6] )

local castQDesire, castQTarget
local castWDesire, castWTarget
local castRDesire

local sMotive


function X.SkillsComplement()

	if J.CanNotUseAbility( bot ) or bot:IsInvisible() then return end

	
	castRDesire, sMotive = A.ConsiderAbaddonBorrowedTime( bot )
	if castRDesire > 0
	then
		J.SetReportMotive( bDebugMode, sMotive )
		J.SetQueuePtToINT( bot, false )
		bot:ActionQueue_UseAbility( abilityR )
		return
	end
	
	castQDesire, castQTarget, sMotive = A.ConsiderAbaddonMistCoil( bot )
	if castQDesire > 0
	then
		J.SetReportMotive( bDebugMode, sMotive )
		J.SetQueuePtToINT( bot, false )
		bot:ActionQueue_UseAbilityOnEntity( abilityQ, castQTarget )
		return
	end

	castWDesire, castWTarget, sMotive = A.ConsiderAbaddonAphoticShield( bot )
	if castWDesire > 0
	then
		J.SetReportMotive( bDebugMode, sMotive )
		J.SetQueuePtToINT( bot, true )
		bot:ActionQueue_UseAbilityOnEntity( abilityW, castWTarget )
		return
	end

end

return X