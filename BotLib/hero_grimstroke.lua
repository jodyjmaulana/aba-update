----------------------------------------------------------------------------------------------------
--- The Creation Come From: BOT EXPERIMENT Credit:FURIOUSPUPPY
--- BOT EXPERIMENT Author: Arizona Fauzie 2018.11.21
--- Link:http://steamcommunity.com/sharedfiles/filedetails/?id=837040016
--- Refactor: 决明子 Email: dota2jmz@163.com 微博@Dota2_决明子
--- Link:http://steamcommunity.com/sharedfiles/filedetails/?id=1573671599
--- Link:http://steamcommunity.com/sharedfiles/filedetails/?id=1627071163
--- Updated: Nikel
--- mid, mage, priest
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
		['t20'] = {0, 10},
		['t15'] = {0, 10},
		['t10'] = {0, 10},
	},

	['outfit_mid'] = {
		['t25'] = {10, 0},
		['t20'] = {0, 10},
		['t15'] = {0, 10},
		['t10'] = {0, 10},
	},

	['outfit_priest'] = {
		['t25'] = {0, 10},
		['t20'] = {10, 0},
		['t15'] = {10, 0},
		['t10'] = {10, 0},
	},

	['outfit_mage'] = {
		['t25'] = {0, 10},
		['t20'] = {10, 0},
		['t15'] = {10, 0},
		['t10'] = {10, 0},
	},

	['outfit_tank'] = {
		['t25'] = {0, 10},
		['t20'] = {10, 0},
		['t15'] = {10, 0},
		['t10'] = {10, 0},
	},
}

local tAllAbilityBuildList = {
	['outfit_carry'] = {
        {1,2,1,2,1,6,2,3,1,2,6,3,3,3,6}
	},

	['outfit_mid'] = {
        {1,2,1,2,1,6,2,3,1,2,6,3,3,3,6}
	},

	['outfit_priest'] = {
        {1,3,1,3,2,6,3,3,1,1,6,2,2,2,6}
	},

	['outfit_mage'] = {
        {1,3,1,3,2,6,3,1,3,1,6,2,2,2,6}
	},

	['outfit_tank'] = {
        {1,3,1,3,2,6,3,1,3,1,6,2,2,2,6}
	},
}

local nAbilityBuildList = J.Skill.GetRandomBuild( tAllAbilityBuildList[sOutfitType] )

local nTalentBuildList = J.Skill.GetTalentBuild( tTalentTreeList[sOutfitType] )

local sRandomItem = RandomInt( 1, 9 ) > 6 and 0 or 10
local sRandomItem_1 = sRandomItem == 0 and "item_aether_lens" or "item_orchid"
local sRandomItem_2 = sRandomItem == 0 and "item_octarine_core" or "item_bloodthorn"

local tOutFitList = {}

tOutFitList['outfit_carry'] = {

    "item_mid_skywrath_mage_outfit",
	"item_dagon",
    sRandomItem_1,
	"item_dagon_2",
	"item_aghanims_shard",
	"item_ultimate_scepter",
	"item_dagon_3",
	"item_sheepstick",
	"item_dagon_4",
    "item_blink",
	"item_dagon_5",
	"item_travel_boots",
    sRandomItem_2,
	"item_ultimate_scepter_2",
    "item_kaya",
    "item_ethereal_blade",
	"item_travel_boots_2",
	"item_moon_shard",

}

tOutFitList['outfit_mid'] = tOutFitList['outfit_carry']

tOutFitList['outfit_priest'] = {

    "item_priest_2_outfit",
    "item_aether_lens",
    "item_glimmer_cape",
    "item_force_staff",
	"item_ultimate_scepter",
	"item_aghanims_shard",
    "item_aeon_disk",
    "item_guardian_greaves",
    "item_octarine_core",
    "item_hurricane_pike",
	"item_ultimate_scepter_2",
    "item_sheepstick",
	"item_moon_shard",

}

tOutFitList['outfit_mage'] = {

    "item_mage_grimstroke_outfit",
    "item_aether_lens",
    "item_ancient_janggo",
    "item_force_staff",
	"item_ultimate_scepter",
	"item_aghanims_shard",
    "item_boots_of_bearing",
    "item_aeon_disk",
    "item_sheepstick",
    "item_octarine_core",
    "item_hurricane_pike",
	"item_ultimate_scepter_2",
    "item_cyclone",
    "item_wind_waker",
	"item_moon_shard",

}

tOutFitList['outfit_tank'] = tOutFitList['outfit_carry']

X['sBuyList'] = tOutFitList[sOutfitType]

X['sSellList'] = {
	"item_sheepstick",
	"item_bottle",
    
    "item_blink",
    "item_null_talisman",
    
	"item_travel_boots",
	"item_arcane_boots",

    "item_aeon_disk",
    "item_magic_wand",
    
    "item_sheepstick",
    "item_ring_of_basilius",
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

npc_dota_hero_grimstroke

"Ability1"				"grimstroke_dark_artistry"
"Ability2"				"grimstroke_ink_creature"
"Ability3"				"grimstroke_spirit_walk"
"Ability4"				"grimstroke_dark_portrait"
"Ability5"				"generic_hidden"
"Ability6"				"grimstroke_soul_chain"
"Ability10"				"special_bonus_unique_grimstroke_8"
"Ability11"				"special_bonus_unique_grimstroke_7"
"Ability12"				"special_bonus_unique_grimstroke_soul_chain_reflect_damage"
"Ability13"				"special_bonus_unique_grimstroke_6"
"Ability14"				"special_bonus_unique_grimstroke_3"
"Ability15"				"special_bonus_unique_grimstroke_4"
"Ability16"				"special_bonus_unique_grimstroke_1"
"Ability17"				"special_bonus_unique_grimstroke_2"

modifier_grimstroke_dark_artistry_slow
modifier_grimstroke_ink_creature_spawning
modifier_grimstroke_ink_creature
modifier_grimstroke_ink_creature_latched
modifier_grimstroke_ink_creature_debuff
modifier_grimstroke_spirit_walk_buff
modifier_grimstroke_scepter_buff
modifier_grimstroke_soul_chain_channel_check
modifier_grimstroke_soul_chain

--]]

local abilityQ = bot:GetAbilityByName( sAbilityList[1] )
local abilityW = bot:GetAbilityByName( sAbilityList[2] )
local abilityE = bot:GetAbilityByName( sAbilityList[3] )
local abilityD = bot:GetAbilityByName( sAbilityList[4] )
local abilityR = bot:GetAbilityByName( sAbilityList[6] )

local castQDesire, castQLocation
local castWDesire, castWTarget
local castEDesire, castETarget
local castDDesire, castDTarget
local castRDesire, castRTarget

local sMotive


function X.SkillsComplement()

	if J.CanNotUseAbility( bot ) or bot:IsInvisible() then return end

	
	castRDesire, castRTarget, sMotive = A.ConsiderGrimstrokeSoulbind( bot )
	if castRDesire > 0
	then
		J.SetReportMotive( bDebugMode, sMotive )
		J.SetQueuePtToINT( bot, true )
		bot:ActionQueue_UseAbilityOnEntity( abilityR, castRTarget )
		return
	end

	castWDesire, castWTarget, sMotive = A.ConsiderGrimstrokePhantomsEmbrace( bot )
	if castWDesire > 0
	then
		J.SetReportMotive( bDebugMode, sMotive )
		J.SetQueuePtToINT( bot, true )
		bot:ActionQueue_UseAbilityOnEntity( abilityW, castWTarget )
		return
	end

	castDDesire, castDTarget, sMotive = A.ConsiderGrimstrokeDarkPortrait( bot )
	if castDDesire > 0
	then
		J.SetReportMotive( bDebugMode, sMotive )
		J.SetQueuePtToINT( bot, true )
		bot:ActionQueue_UseAbilityOnEntity( abilityD, castDTarget )
		return
	end
	
	castEDesire, castETarget, sMotive = A.ConsiderGrimstrokeInkSwell( bot )
	if castEDesire > 0
	then
		J.SetReportMotive( bDebugMode, sMotive )
		J.SetQueuePtToINT( bot, true )
		bot:ActionQueue_UseAbilityOnEntity( abilityE, castETarget )
		return
	end
	
	castQDesire, castQLocation, sMotive = A.ConsiderGrimstrokeStrokeOfFate( bot )
	if castQDesire > 0
	then
		J.SetReportMotive( bDebugMode, sMotive )
		J.SetQueuePtToINT( bot, true )
		bot:ActionQueue_UseAbilityOnLocation( abilityQ, castQLocation )
		return
	end

end

return X