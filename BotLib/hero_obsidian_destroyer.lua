----------------------------------------------------------------------------------------------------
--- The Creation Come From: BOT EXPERIMENT Credit:FURIOUSPUPPY
--- BOT EXPERIMENT Author: Arizona Fauzie 2018.11.21
--- Link:http://steamcommunity.com/sharedfiles/filedetails/?id=837040016
--- Refactor: 决明子 Email: dota2jmz@163.com 微博@Dota2_决明子
--- Link:http://steamcommunity.com/sharedfiles/filedetails/?id=1573671599
--- Link:http://steamcommunity.com/sharedfiles/filedetails/?id=1627071163
--- Updated: Nikel
--- carry, mid, tank
----------------------------------------------------------------------------------------------------
local X = {}
local bDebugMode = ( 1 == 10 )
local bot = GetBot()

local J = require( GetScriptDirectory()..'/FunLib/jmz_func' )
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
		['t25'] = {10, 0},
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
		['t25'] = {10, 0},
		['t20'] = {10, 0},
		['t15'] = {0, 10},
		['t10'] = {10, 0},
	},
}

local tAllAbilityBuildList = {
	['outfit_carry'] = {
		{1,3,2,1,1,6,1,3,3,3,6,2,2,2,6}
	},

	['outfit_mid'] = {
		{1,3,2,2,2,6,2,1,1,1,6,3,3,3,6}
	},

	['outfit_priest'] = {
		{1,3,2,2,2,6,2,1,1,1,6,3,3,3,6}
	},

	['outfit_mage'] = {
		{1,3,2,2,2,6,2,1,1,1,6,3,3,3,6}
	},

	['outfit_tank'] = {
		{1,3,2,2,2,6,2,1,1,1,6,3,3,3,6}
	},
}

local nAbilityBuildList = J.Skill.GetRandomBuild( tAllAbilityBuildList[sOutfitType] )

local nTalentBuildList = J.Skill.GetTalentBuild( tTalentTreeList[sOutfitType] )

local tOutFitList = {}

tOutFitList['outfit_carry'] = {

	"item_crystal_maiden_outfit",
	"item_witch_blade",
	"item_dragon_lance",
	"item_black_king_bar",
	"item_hurricane_pike",
	"item_ultimate_scepter",
	"item_aghanims_shard",
	"item_orchid",
	"item_travel_boots",
	"item_bloodthorn",
	"item_ultimate_scepter_2",
	"item_sheepstick",
	"item_revenants_brooch",
	"item_moon_shard",
	"item_travel_boots_2",

}

tOutFitList['outfit_mid'] = {

	"item_obsidian_destroyer_outfit",
	"item_hand_of_midas",
	"item_blink",
	"item_ultimate_scepter",
	"item_aghanims_shard",
	"item_sphere",
	"item_sheepstick",
	"item_ultimate_scepter_2",
	"item_cyclone",
	"item_wind_waker",
	"item_travel_boots",
	"item_moon_shard",
	"item_octarine_core",
	"item_arcane_blink",
	"item_travel_boots_2",

}

tOutFitList['outfit_priest']  = tOutFitList['outfit_carry']

tOutFitList['outfit_mage'] = tOutFitList['outfit_carry']

tOutFitList['outfit_tank'] = tOutFitList['outfit_mid']

X['sBuyList'] = tOutFitList[sOutfitType]

X['sSellList'] = {
	"item_sheepstick",
	"item_meteor_hammer",
	
	"item_hand_of_midas",
	"item_octarine_core",

	"item_travel_boots",
	"item_power_treads",

	"item_ultimate_scepter",
	"item_magic_wand",

	"item_orchid",
	"item_null_talisman",
}

if J.Role.IsPvNMode() or J.Role.IsAllShadow() then X['sBuyList'], X['sSellList'] = { 'PvN_mid' }, {} end

nAbilityBuildList, nTalentBuildList, X['sBuyList'], X['sSellList'] = J.SetUserHeroInit( nAbilityBuildList, nTalentBuildList, X['sBuyList'], X['sSellList'] )

X['sSkillList'] = J.Skill.GetSkillList( sAbilityList, nAbilityBuildList, sTalentList, nTalentBuildList )

X['bDeafaultAbility'] = false
X['bDeafaultItem'] = false

function X.MinionThink( hMinionUnit )

	if Minion.IsValidUnit( hMinionUnit )
	then
		Minion.IllusionThink( hMinionUnit )
	end

end

--[[

npc_dota_hero_obsidian_destroyer

"Ability1"		"obsidian_destroyer_arcane_orb"
"Ability2"		"obsidian_destroyer_astral_imprisonment"
"Ability3"		"obsidian_destroyer_equilibrium"
"Ability4"		"generic_hidden"
"Ability5"		"generic_hidden"
"Ability6"		"obsidian_destroyer_sanity_eclipse"
"Ability10"		"special_bonus_hp_200"
"Ability11"		"special_bonus_attack_speed_20"
"Ability12"		"special_bonus_unique_outworld_devourer_astral_castrange"
"Ability13"		"special_bonus_movement_speed_30"
"Ability14"		"special_bonus_strength_20"
"Ability15"		"special_bonus_unique_outworld_devourer_4"
"Ability16"		"special_bonus_unique_outworld_devourer"
"Ability17"		"special_bonus_unique_outworld_devourer_5"

modifier_obsidian_destroyer_arcane_orb
modifier_obsidian_destroyer_astral_imprisonment_prison
modifier_obsidian_destroyer_equilibrium_buff
modifier_obsidian_destroyer_equilibrium_buff_counter
modifier_obsidian_destroyer_equilibrium_debuff
modifier_obsidian_destroyer_equilibrium_debuff_counter
modifier_obsidian_destroyer_equilibrium

--]]

local abilityQ = bot:GetAbilityByName( sAbilityList[1] )
local abilityW = bot:GetAbilityByName( sAbilityList[2] )
local abilityR = bot:GetAbilityByName( sAbilityList[6] )
local talent6 = bot:GetAbilityByName( sTalentList[6] )
local talent7 = bot:GetAbilityByName( sTalentList[7] )

local castQDesire, castQTarget
local castWDesire, castWTarget
local castRDesire, castRLocation

local nKeepMana, nMP, nHP, nLV, botTarget, hEnemyList, hAllyList, sMotive
local bonusRange = 0


function X.SkillsComplement()

	if J.CanNotUseAbility( bot ) or bot:IsInvisible() then return end

	nKeepMana = 400
	bonusRange = 0
	nLV = bot:GetLevel()
	nMP = bot:GetMana()/bot:GetMaxMana()
	nHP = bot:GetHealth()/bot:GetMaxHealth()
	botTarget = J.GetProperTarget( bot )
	hEnemyList = bot:GetNearbyHeroes( 1600, true, BOT_MODE_NONE )
	hAllyList = J.GetAlliesNearLoc( bot:GetLocation(), 1600 )
	
	bonusRange = J.GetBonusCastRange( bot )


	castWDesire, castWTarget, sMotive = X.ConsiderW()
	if castWDesire > 0
	then
		J.SetReportMotive( bDebugMode, sMotive )

		J.SetQueuePtToINT( bot, false )

		bot:ActionQueue_UseAbilityOnEntity( abilityW, castWTarget )
		return
	end
	
	castQDesire, castQTarget, sMotive = X.ConsiderQ()
	if castQDesire > 0
	then
		J.SetReportMotive( bDebugMode, sMotive )

		J.SetQueuePtToINT( bot, false )

		bot:ActionQueue_UseAbilityOnEntity( abilityQ, castQTarget )
		return
	end
	
	castRDesire, castRLocation, sMotive = X.ConsiderR()
	if castRDesire > 0
	then
		J.SetReportMotive( bDebugMode, sMotive )

		J.SetQueuePtToINT( bot, false )

		bot:ActionQueue_UseAbilityOnLocation( abilityR, castRLocation )
		return
	end

end


function X.ConsiderQ()

	if not abilityQ:IsFullyCastable() or bot:IsDisarmed() then return BOT_ACTION_DESIRE_NONE, nil end

	local nSkillLV = abilityQ:GetLevel()
	local nAttackDamage = bot:GetAttackDamage()
	local nAttackRange = bot:GetAttackRange()
	local nAbilityDamage = abilityQ:GetSpecialValueInt( 'mana_pool_damage_pct' ) * bot:GetMana()
	local nDamageType = DAMAGE_TYPE_PURE

	if talent7:isTrained()
	then
		nAbilityDamage = ( abilityQ:GetSpecialValueInt( 'mana_pool_damage_pct' ) + 2 ) * bot:GetMana()
	end

	
	if nSkillLV == 4
	then
		if not abilityQ:GetAutoCastState()
		then
			abilityQ:ToggleAutoCast()
		end
	else
		if abilityQ:GetAutoCastState()
		then
			abilityQ:ToggleAutoCast()
		end
	end

	if J.IsValidHero( botTarget )
		and J.CanCastOnNonMagicImmune( botTarget )
		and not botTarget:IsAttackImmune()
		and nSkillLV < 4
	then
		return BOT_ACTION_DESIRE_HIGH, botTarget, "Q-Attack:"..J.Chat.GetNormName( botTarget )
	end

	
	if ( J.IsLaning( bot ) or J.IsFarming( bot ) )
		and nSkillLV < 4
	then
		local nEnemyCreeps = bot:GetNearbyLaneCreeps( nAttackRange, true )
		for _, creep in pairs( nEnemyCreeps )
		do

			local nAttackProDelayTime = J.GetAttackProDelayTime( bot, creep )

			if J.IsValid( creep )
				and not creep:HasModifier( "modifier_fountain_glyph" )
				and creep:GetHealth() <= X.GetRealAttackDamage( nAttackDamage, nAbilityDamage, creep )
				and J.WillMixedDamageKillTarget( creep, nAttackDamage, 0, nAbilityDamage, nAttackProDelayTime )
			then
				return BOT_ACTION_DESIRE_HIGH, creep, "Q-KillCreep"
			end
		end
	end


	return BOT_ACTION_DESIRE_NONE, nil

end

function X.ConsiderW()

	if not abilityW:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end

	local nSkillLV = abilityW:GetLevel()
	local nCastRange = abilityW:GetSpecialValueInt( 'AbilityCastRange' ) + bonusRange
	local nCastPoint = abilityW:GetCastPoint()
	local nManaCost = abilityW:GetManaCost()
	local nDamage = abilityW:GetSpecialValueInt( 'damage' )
	local nDamageType = DAMAGE_TYPE_MAGICAL
	local nAlliedHeroesInRange = bot:GetNearbyHeroes( nCastRange, false, BOT_MODE_NONE )
	local nEnemyHeroesInRange = bot:GetNearbyHeroes( nCastRange, true, BOT_MODE_NONE )

	
	local nMostManaEnemy = nil
	local nMostMana = 0
	for _, npcEnemy in pairs( nEnemyHeroesInRange )
	do
		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.CanCastOnTargetAdvanced( npcEnemy )
			and ( npcEnemy:IsChanneling() or npcEnemy:IsCastingAbility() )
		then
			return BOT_ACTION_DESIRE_HIGH, npcEnemy, 'W-Interrupt:'..J.Chat.GetNormName( npcEnemy )
		end

		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.CanCastOnTargetAdvanced( npcEnemy )
			and J.WillMagicKillTarget( bot, npcEnemy, nDamage, nCastPoint )
		then
			return BOT_ACTION_DESIRE_HIGH, npcEnemy, 'W-Kill:'..J.Chat.GetNormName( npcEnemy )
		end
		
		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.CanCastOnTargetAdvanced( npcEnemy )
			and npcEnemy:GetMaxMana() > nMostMana
		then
			nMostManaEnemy = npcEnemy
			nMostMana = npcEnemy:GetMaxMana()
		end

		if ( nMostManaEnemy ~= nil )
		then
			return BOT_ACTION_DESIRE_HIGH, nMostManaEnemy, 'W-Attack:'..J.Chat.GetNormName( npcEnemy )
		end
	end

	
	if J.IsGoingOnSomeone( bot )
	then
		if J.IsValidHero( botTarget )
			and J.CanCastOnNonMagicImmune( botTarget )
			and J.CanCastOnTargetAdvanced( botTarget )
			and J.IsInRange( botTarget, bot, nCastRange )
		then
			return BOT_ACTION_DESIRE_HIGH, botTarget, 'W-Attack:'..J.Chat.GetNormName( botTarget )
		end
	end


	return BOT_ACTION_DESIRE_NONE, nil

end

function X.ConsiderR()
	
	if not abilityR:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end

	local nSkillLV = abilityR:GetLevel()
	local nCastRange = abilityR:GetSpecialValueInt( 'cast_range' ) + bonusRange
	local nRadius = abilityR:GetSpecialValueInt( 'radius' )
	local nCastPoint = abilityR:GetCastPoint()
	local nManaCost = abilityR:GetManaCost()
	local nBaseDamage = abilityR:GetSpecialValueInt( 'base_damage' )
	local nDamageMultiplier = abilityR:GetSpecialValueFloat( 'damage_multiplier' )
	local nDamageType = DAMAGE_TYPE_MAGICAL
	local nAlliedHeroesInRange = bot:GetNearbyHeroes( nCastRange + nRadius, false, BOT_MODE_NONE )
	local nEnemyHeroesInRange = bot:GetNearbyHeroes( nCastRange + nRadius, true, BOT_MODE_NONE )


	local nMinDamageThreshold = nBaseDamage + ( nSkillLV * 200 )
	local nAoeCount = 0
	local nAoe = bot:FindAoELocation( true, true, bot:GetLocation(), nCastRange, nRadius, 0, 0 )

	for _, npcEnemy in pairs( nEnemyHeroesInRange )
	do
		if J.IsValidHero( npcEnemy )
			and GetUnitToLocationDistance( npcEnemy, nAoe.targetloc ) <= nRadius
			and J.CanCastOnNonMagicImmune( npcEnemy )
		then
			local nMagicalDamage = ( bot:GetMaxMana() - npcEnemy:GetMaxMana() ) * nDamageMultiplier
			local nRealMagicalDamge = npcEnemy:GetActualIncomingDamage( nMagicalDamage, DAMAGE_TYPE_MAGICAL )
		
			if nRealMagicalDamge >= nMinDamageThreshold
			then
				nAoeCount = nAoeCount + 1
			end
		end
	end

	if nAoeCount >= 3
	then
		return BOT_ACTION_DESIRE_HIGH, 'R-Battle'
	end


	return BOT_ACTION_DESIRE_NONE, nil

end

function X.GetRealAttackDamage( nAttackDamage, nAbilityDamage, target )
	
	local RealDamage = target:GetActualIncomingDamage( nAttackDamage, DAMAGE_TYPE_PHYSICAL ) + target:GetActualIncomingDamage( nAbilityDamage, DAMAGE_TYPE_PURE )

	return RealDamage

end

return X