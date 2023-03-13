----------------------------------------------------------------------------------------------------
--- The Creation Come From: BOT EXPERIMENT Credit:FURIOUSPUPPY
--- BOT EXPERIMENT Author: Arizona Fauzie 2018.11.21
--- Link:http://steamcommunity.com/sharedfiles/filedetails/?id=837040016
--- Refactor: 决明子 Email: dota2jmz@163.com 微博@Dota2_决明子
--- Link:http://steamcommunity.com/sharedfiles/filedetails/?id=1573671599
--- Link:http://steamcommunity.com/sharedfiles/filedetails/?id=1627071163
--- Updated: Nikel
--- carry, tank
----------------------------------------------------------------------------------------------------
local X = {}
local bDebugMode = ( 10 == 10 )
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
		['t20'] = {0, 10},
		['t15'] = {10, 0},
		['t10'] = {0, 10},
	},

	['outfit_mid'] = {
		['t25'] = {0, 10},
		['t20'] = {0, 10},
		['t15'] = {10, 0},
		['t10'] = {0, 10},
	},

	['outfit_priest'] = {
		['t25'] = {10, 0},
		['t20'] = {10, 0},
		['t15'] = {0, 10},
		['t10'] = {10, 0},
	},

	['outfit_mage'] = {
		['t25'] = {10, 0},
		['t20'] = {10, 0},
		['t15'] = {0, 10},
		['t10'] = {10, 0},
	},

	['outfit_tank'] = {
		['t25'] = {10, 0},
		['t20'] = {10, 0},
		['t15'] = {0, 10},
		['t10'] = {10, 0},
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
        {1,3,1,2,1,6,1,2,2,2,6,3,3,3,6}
	},

	['outfit_mage'] = {
        {1,3,1,2,1,6,1,2,2,2,6,3,3,3,6}
	},

	['outfit_tank'] = {
        {1,3,1,2,1,6,1,2,2,2,6,3,3,3,6}
	},
}

local nAbilityBuildList = J.Skill.GetRandomBuild( tAllAbilityBuildList[sOutfitType] )

local nTalentBuildList = J.Skill.GetTalentBuild( tTalentTreeList[sOutfitType] )

local sRandomItem_1 = RandomInt( 1, 9 ) > 6 and "item_nullifier" or "item_silver_edge"

local tOutFitList = {}

tOutFitList['outfit_carry'] = {

    "item_carry_alchemist_outfit",
    "item_soul_ring",
    "item_radiance",
    "item_black_king_bar",
    "item_blink",
	"item_aghanims_shard",
    "item_maelstrom",
    "item_mjollnir",
    "item_basher",
    "item_abyssal_blade",
    sRandomItem_1,
	"item_moon_shard",
	-- "item_ultimate_scepter",

}

tOutFitList['outfit_mid'] = tOutFitList['outfit_carry']

tOutFitList['outfit_priest'] = {

	"item_carry_alchemist_outfit",
    "item_soul_ring",
    "item_radiance",
    "item_black_king_bar",
    "item_blink",
	"item_aghanims_shard",
    "item_assault",
    "item_basher",
    "item_abyssal_blade",
    sRandomItem_1,
	"item_moon_shard",
	-- "item_ultimate_scepter",

}

tOutFitList['outfit_mage'] = tOutFitList['outfit_priest']

tOutFitList['outfit_tank'] = tOutFitList['outfit_priest']

X['sBuyList'] = tOutFitList[sOutfitType]

X['sSellList'] = {
    "item_black_king_bar",
	"item_quelling_blade",

    "item_blink",
	"item_magic_wand",

	"item_maelstrom",
	"item_bracer",
    
	"item_assault",
	"item_bracer",

    "item_basher",
	"item_soul_ring",

    "item_nullifier",
	"item_phase_boots",

    "item_silver_edge",
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

npc_dota_hero_alchemist

"Ability1"		"alchemist_acid_spray"
"Ability2"		"alchemist_unstable_concoction"
"Ability3"		"alchemist_goblins_greed"
"Ability4"		"alchemist_berserk_potion"
"Ability5"		"generic_hidden"
"Ability6"		"alchemist_chemical_rage"
"Ability7"		"alchemist_unstable_concoction_throw"
"Ability10"		"special_bonus_unique_alchemist_5"
"Ability11"		"special_bonus_unique_alchemist"
"Ability12"		"special_bonus_unique_alchemist_3"
"Ability13"		"special_bonus_unique_alchemist_7"
"Ability14"		"special_bonus_unique_alchemist_8"
"Ability15"		"special_bonus_unique_alchemist_2"
"Ability16"		"special_bonus_unique_alchemist_6"
"Ability17"		"special_bonus_unique_alchemist_4"

modifier_alchemist_acid_spray_thinker
modifier_alchemist_acid_spray
modifier_alchemist_unstable_concoction
modifier_stunned
modifier_alchemist_goblins_greed
modifier_alchemist_berserk_potion
modifier_alchemist_chemical_rage_transform
modifier_alchemist_chemical_rage

--]]

local abilityQ = bot:GetAbilityByName( sAbilityList[1] )
local abilityW = bot:GetAbilityByName( sAbilityList[2] )
local abilityWEnd = bot:GetAbilityByName( sAbilityList[7] )
local abilityD = bot:GetAbilityByName( sAbilityList[4] )
local abilityR = bot:GetAbilityByName( sAbilityList[6] )

local castQDesire, castQLocation
local castWDesire
local castWEndDesire, castWEndTarget, castWEndNow
local castDDesire, castDTarget
local castRDesire

local sMotive
local timeCheck = 0


function X.SkillsComplement()

	if J.CanNotUseAbility( bot ) or bot:IsInvisible() then return end

	
	castRDesire, sMotive = A.ConsiderAlchemistChemicalRage( bot )
	if castRDesire > 0
	then
		J.SetReportMotive( bDebugMode, sMotive )
		J.SetQueuePtToINT( bot, false )
		bot:ActionQueue_UseAbility( abilityR )
		return
	end
	
	castQDesire, castQLocation, sMotive = A.ConsiderAlchemistAcidSpray( bot )
	if castQDesire > 0
	then
		J.SetReportMotive( bDebugMode, sMotive )
		J.SetQueuePtToINT( bot, true )
		bot:ActionQueue_UseAbilityOnLocation( abilityQ, castQLocation )
		return
	end

	castWDesire, sMotive = A.ConsiderAlchemistUnstableConcoction( bot )
	if castWDesire > 0
	then
		J.SetReportMotive( bDebugMode, sMotive )
		J.SetQueuePtToINT( bot, false )
		bot:ActionQueue_UseAbility( abilityW )
		timeCheck = DotaTime()
		return
	end

	castWEndDesire, castWEndTarget, castWEndNow, sMotive = A.ConsiderAlchemistUnstableConcoctionThrow( bot )
	if castWEndDesire > 0
		and ( DotaTime() > timeCheck + 4.5 or castWEndNow )
	then
		J.SetReportMotive( bDebugMode, sMotive )
		J.SetQueuePtToINT( bot, false )
		bot:ActionQueue_UseAbilityOnEntity( abilityWEnd, castWEndTarget )
		return
	end

	castDDesire, castDTarget, sMotive = A.ConsiderAlchemistBerserkPotion( bot )
	if castDDesire > 0
	then
		J.SetReportMotive( bDebugMode, sMotive )
		J.SetQueuePtToINT( bot, false )
		bot:ActionQueue_UseAbilityOnEntity( abilityD, castDTarget )
		return
	end

end

return X