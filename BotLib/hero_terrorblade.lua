----------------------------------------------------------------------------------------------------
--- The Creation Come From: BOT EXPERIMENT Credit:FURIOUSPUPPY
--- BOT EXPERIMENT Author: Arizona Fauzie 2018.11.21
--- Link:http://steamcommunity.com/sharedfiles/filedetails/?id=837040016
--- Refactor: 决明子 Email: dota2jmz@163.com 微博@Dota2_决明子
--- Link:http://steamcommunity.com/sharedfiles/filedetails/?id=1573671599
--- Link:http://steamcommunity.com/sharedfiles/filedetails/?id=1627071163
--- Updated: Nikel
--- carry
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
		['t15'] = {10, 0},
		['t10'] = {10, 0},
	},

	['outfit_mid'] = {
		['t25'] = {0, 10},
		['t20'] = {10, 0},
		['t15'] = {10, 0},
		['t10'] = {10, 0},
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
		{1,3,2,2,3,6,2,2,3,3,6,1,1,1,6}
	},

	['outfit_mid'] = {
		{1,3,2,2,3,6,2,2,3,3,6,1,1,1,6}
	},

	['outfit_priest'] = {
		{1,3,2,2,3,6,2,2,3,3,6,1,1,1,6}
	},

	['outfit_mage'] = {
		{1,3,2,2,3,6,2,2,3,3,6,1,1,1,6}
	},

	['outfit_tank'] = {
		{1,3,2,2,3,6,2,2,3,3,6,1,1,1,6}
	},
}

local nAbilityBuildList = J.Skill.GetRandomBuild( tAllAbilityBuildList[sOutfitType] )

local nTalentBuildList = J.Skill.GetTalentBuild( tTalentTreeList[sOutfitType] )

local tOutFitList = {}

tOutFitList['outfit_carry'] = {

	"item_melee_carry_outfit",
    "item_manta",
    "item_black_king_bar",
    "item_skadi",
	"item_lifesteal",
	"item_aghanims_shard",
    "item_satanic",
	"item_ultimate_scepter",
    "item_blink",
	"item_ultimate_scepter_2",
    "item_butterfly",
    "item_swift_blink",
	"item_moon_shard",
    
}

tOutFitList['outfit_mid'] = tOutFitList['outfit_carry']

tOutFitList['outfit_priest'] = tOutFitList['outfit_carry']

tOutFitList['outfit_mage'] = tOutFitList['outfit_carry']

tOutFitList['outfit_tank'] = tOutFitList['outfit_carry']

X['sBuyList'] = tOutFitList[sOutfitType]

X['sSellList'] = {
    "item_skadi",
    "item_quelling_blade",

    "item_lifesteal",
    "item_magic_wand",
    
	"item_ultimate_scepter",
    "item_wraith_band",

    "item_blink",
    "item_power_treads",
}

if J.Role.IsPvNMode() or J.Role.IsAllShadow() then X['sBuyList'], X['sSellList'] = { 'PvN_melee_carry' }, {} end

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

npc_dota_hero_terrorblade

"Ability1"		"terrorblade_reflection"
"Ability2"		"terrorblade_conjure_image"
"Ability3"		"terrorblade_metamorphosis"
"Ability4"		"terrorblade_demon_zeal"
"Ability5"		"terrorblade_terror_wave"
"Ability6"		"terrorblade_sunder"
"Ability10"		"special_bonus_unique_terrorblade_2"
"Ability11"		"special_bonus_unique_terrorblade_4"
"Ability12"		"special_bonus_hp_300"
"Ability13"		"special_bonus_unique_terrorblade_6"
"Ability14"		"special_bonus_all_stats_10"
"Ability15"		"special_bonus_unique_terrorblade_5"
"Ability16"		"special_bonus_unique_terrorblade"
"Ability17"		"special_bonus_unique_terrorblade_3"

modifier_terrorblade_reflection_invulnerability
modifier_illusion
modifier_invulnerable
modifier_terrorblade_reflection_slow
modifier_terrorblade_conjureimage
modifier_terrorblade_metamorphosis_transform
modifier_terrorblade_metamorphosis
modifier_terrorblade_metamorphosis_transform_aura
modifier_terrorblade_metamorphosis_transform_aura_applier
modifier_terrorblade_demon_zeal
modifier_metamorphosis_fear_thinker
modifier_terrorblade_fear

--]]

local abilityQ = bot:GetAbilityByName( sAbilityList[1] )
local abilityW = bot:GetAbilityByName( sAbilityList[2] )
local abilityE = bot:GetAbilityByName( sAbilityList[3] )
local abilityD = bot:GetAbilityByName( sAbilityList[4] )
local abilityF = bot:GetAbilityByName( sAbilityList[5] )
local abilityR = bot:GetAbilityByName( sAbilityList[6] )

local castQDesire, castQLocation
local castWDesire
local castEDesire
local castDDesire
local castFDesire
local castRDesire, castRTarget

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

	
	castFDesire, sMotive = X.ConsiderF()
	if castFDesire > 0
	then
		J.SetReportMotive( bDebugMode, sMotive )

		J.SetQueuePtToINT( bot, false )

		bot:ActionQueue_UseAbility( abilityF )
		return
	end
	
	castRDesire, castRTarget, sMotive = X.ConsiderR()
	if castRDesire > 0
	then
		J.SetReportMotive( bDebugMode, sMotive )

		J.SetQueuePtToINT( bot, false )

		bot:ActionQueue_UseAbilityOnEntity( abilityR, castRTarget )
		return
	end
	
	castQDesire, castQLocation, sMotive = X.ConsiderQ()
	if castQDesire > 0
	then
		J.SetReportMotive( bDebugMode, sMotive )

		J.SetQueuePtToINT( bot, false )

		bot:ActionQueue_UseAbilityOnLocation( abilityQ, castQLocation )
		return
	end

	castWDesire, sMotive = X.ConsiderW()
	if castWDesire > 0
	then
		J.SetReportMotive( bDebugMode, sMotive )

		J.SetQueuePtToINT( bot, false )

		bot:ActionQueue_UseAbility( abilityW )
		return
	end

	castEDesire, sMotive = X.ConsiderE()
	if castEDesire > 0
	then
		J.SetReportMotive( bDebugMode, sMotive )

		J.SetQueuePtToINT( bot, false )

		bot:ActionQueue_UseAbility( abilityE )
		return
	end

	castDDesire, sMotive = X.ConsiderD()
	if castDDesire > 0
	then
		J.SetReportMotive( bDebugMode, sMotive )

		J.SetQueuePtToINT( bot, false )

		bot:ActionQueue_UseAbility( abilityD )
		return
	end

end


function X.ConsiderQ()

	if not abilityQ:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end

	local nCastRange = abilityQ:GetCastRange() + bonusRange
	local nRadius = abilityQ:GetSpecialValueInt( 'range' )
	local nCastPoint = abilityQ:GetCastPoint()
	local nEnemyHeroesInRange = bot:GetNearbyHeroes( nCastRange + 300, true, BOT_MODE_NONE )
	local nTargetLocation = nil
	

	if J.IsInTeamFight( bot, 1200 )
	then
        local npcMostDangerousEnemy = nil
        local npcMostDangerousDamage = 0
		for _, npcEnemy in pairs( nEnemyHeroesInRange )
		do
            local npcEnemyDamage = npcEnemy:GetEstimatedDamageToTarget( false, bot, 3.0, DAMAGE_TYPE_PHYSICAL )

			if J.IsValidHero( npcEnemy )
                and J.CanCastOnNonMagicImmune( npcEnemy )
				and not J.IsDisabled( npcEnemy )
				and not npcEnemy:IsDisarmed()
                and npcEnemyDamage > nMostDangerousDamage
			then
				npcMostDangerousEnemy = npcEnemy
				npcMostDangerousDamage = npcEnemyDamage
			end
		end

		if ( npcMostDangerousEnemy ~= nil )
		then
			nTargetLocation = J.GetCastLocation( bot, botTarget, nCastRange, nRadius )
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'Q-Battle:'..J.Chat.GetNormName( botTarget )
		end
	end


	if J.IsGoingOnSomeone( bot )
	then
        local nAoeLoc = J.GetAoeEnemyHeroLocation( bot, nCastRange, nRadius, 2 )
		if nAoeLoc ~= nil
		then
            nTargetLocation = nAoeLoc
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'Q-Attack'
		end


		if J.IsValidHero( botTarget )
			and J.IsInRange( bot, botTarget, nCastRange + nRadius )
			and J.CanCastOnNonMagicImmune( botTarget )
			and not botTarget:IsAttackImmune()
		then
			nTargetLocation = J.GetCastLocation( bot, botTarget, nCastRange, nRadius )
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'Q-Attack:'..J.Chat.GetNormName( botTarget )
		end
	end


	if J.IsRetreating( bot )
	then
		for _, npcEnemy in pairs( nEnemyHeroesInRange )
		do
			if J.IsValidHero( npcEnemy )
				and bot:WasRecentlyDamagedByHero( npcEnemy, 5.0 )
				and J.CanCastOnNonMagicImmune( npcEnemy )
				and bot:IsFacingLocation( npcEnemy:GetExtrapolatedLocation( nCastPoint ), 20 )
			then
				nTargetLocation = npcEnemy:GetExtrapolatedLocation( nCastPoint )
				return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'Q-Retreat:'..J.Chat.GetNormName( npcEnemy )
			end
		end
	end


	if J.IsLaning( bot )
	then
		local nAoeLoc = J.GetAoeEnemyHeroLocation( bot, nCastRange, nRadius, 2 )
		if nAoeLoc ~= nil and nMP > 0.7
		then
			nTargetLocation = nAoeLoc
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'Q-Harass'
		end
	end


	return BOT_ACTION_DESIRE_NONE, nil


end

function X.ConsiderW()

	if not abilityW:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end

	local nSkillLV = abilityW:GetLevel()
	local nManaCost = abilityW:GetManaCost()

	
	if J.IsInTeamFight( bot, 1200 )
	then
		if #hEnemyList >= 2
		then
			return BOT_ACTION_DESIRE_HIGH, "W-Battle"
		end
	end


	if J.IsGoingOnSomeone ( bot )
	then
		if J.IsValidHero( botTarget )
			and J.IsInRange( bot, botTarget, 700 )
		then
			return BOT_ACTION_DESIRE_HIGH, "W-Attack"
		end
	end


	if J.IsRetreating( bot )
	then
		if bot:WasRecentlyDamagedByAnyHero( 1.5 )
		then
			return BOT_ACTION_DESIRE_HIGH, 'W-Retreat:'
		end
	end

	
	if J.IsLaning( bot )
	then
		if J.IsValidHero( botTarget )
			and J.IsInRange( bot, botTarget, 700 )
			and nMP > 0.5
		then
			return BOT_ACTION_DESIRE_HIGH, "W-Harass"
		end
	end


	if ( J.IsPushing( bot ) or J.IsDefending( bot ) or J.IsFarming( bot ) )
		and J.IsAllowedToSpam( bot, nManaCost )
		and nSkillLV >= 4 and DotaTime() > 8 * 60
		and nMP > 0.45
	then

		local nEnemyCreeps = bot:GetNearbyLaneCreeps( 700, true )
		if #nEnemyCreeps >= 3
			and J.IsValidUnit( nEnemyCreeps[1] )
			and not nEnemyCreeps[1]:HasModifier( "modifier_fountain_glyph" )
		then
			return BOT_ACTION_DESIRE_HIGH, "W-Farm"
		end

	end
	
	
	if nSkillLV >= 4
		and J.IsAllowedToSpam( bot, nManaCost )
		and nMP >= 0.5
	then
		local nEnemyCreeps = bot:GetNearbyCreeps( 700, true )
		if #nEnemyCreeps >= 1
			or #hEnemyList >= 1
		then
			return BOT_ACTION_DESIRE_HIGH, "W-Spam"
		end
	end


	return BOT_ACTION_DESIRE_NONE, nil

end

function X.ConsiderE()

	if not abilityE:IsFullyCastable()
		or ( J.GetHP( bot ) < 0.3 and not abilityR:IsFullyCastable() )
	then
		return BOT_ACTION_DESIRE_NONE, nil
	end

	local nSkillLV = abilityE:GetLevel()
	local nCastPoint = abilityE:GetCastPoint()
	local nManaCost = abilityE:GetManaCost()


	if J.IsInTeamFight( bot, 1200 )
	then
		if #hEnemyList >= 2
		then
			return BOT_ACTION_DESIRE_HIGH, "E-Battle"
		end
	end


	if J.IsGoingOnSomeone( bot )
	then
		if J.IsValidHero( botTarget )
			and J.IsInRange( botTarget, bot, 700 )
		then
			return BOT_ACTION_DESIRE_HIGH, "E-Attack"
		end
	end


	if ( J.IsPushing( bot ) or J.IsFarming( bot ) or J.IsDefending( bot ) )
		and nLV <= 16
	then
		if #hAllyList >= #hEnemyList
		then
			return BOT_ACTION_DESIRE_HIGH, "E-Farm/Push/Defend"
		end
	end
	

	return BOT_ACTION_DESIRE_NONE, nil

end

function X.ConsiderD()
	
	if not abilityD:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end

	local nSkillLV = abilityD:GetLevel()
	local nCastPoint = abilityD:GetCastPoint()
	local nManaCost = abilityD:GetManaCost()


	if J.IsInTeamFight( bot, 1200 )
	then
		if #hEnemyList >= 2
		then
			return BOT_ACTION_DESIRE_HIGH, "D-Battle"
		end
	end


	if J.IsGoingOnSomeone( bot )
	then
		if J.IsValidHero( botTarget )
			and J.IsInRange( botTarget, bot, 700 )
		then
			return BOT_ACTION_DESIRE_HIGH, "D-Attack"
		end
	end


	if J.IsRetreating( bot )
	then
		if bot:WasRecentlyDamagedByAnyHero( 1.5 )
		then
			return BOT_ACTION_DESIRE_HIGH, 'D-Retreat'
		end
	end


	if ( J.IsPushing( bot ) or J.IsFarming( bot ) or J.IsDefending( bot ) )
	then
		if #hAllyList >= #hEnemyList
		then
			return BOT_ACTION_DESIRE_HIGH, "D-Farm/Push/Defend"
		end
	end


end

function X.ConsiderF()
	
	if not abilityF:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end

	local nSkillLV = abilityF:GetLevel()
	local nCastPoint = abilityF:GetCastPoint()
	local nManaCost = abilityF:GetManaCost()
	local nRadius = abilityF:GetSpecialValueInt( 'scepter_radius' )
	local nAlliedHeroesInRange = bot:GetNearbyHeroes( nRadius, false, BOT_MODE_NONE )
	local nEnemyHeroesInRange = bot:GetNearbyHeroes( nRadius, true, BOT_MODE_NONE )


	if J.IsInTeamFight( bot, 1200 )
	then
		for _, npcEnemy in pairs( nEnemyHeroesInRange )
		do
			if J.IsValidHero( npcEnemy )
				and J.CanCastOnNonMagicImmune( npcEnemy )
				and npcEnemy:IsChanneling()
			then
				return BOT_ACTION_DESIRE_HIGH, "F-Battle-Interrupt"
			end
		end
		
		for _, npcAlly in pairs( nAlliedHeroesInRange )
		do
			if J.IsValidHero( npcAlly )
				and J.IsDisabled( npcAlly )
			then
				return BOT_ACTION_DESIRE_HIGH, "F-Battle-Protect"
			end
		end

		-- if #nEnemyHeroesInRange >= 4
		-- then
		-- 	return BOT_ACTION_DESIRE_HIGH, "F-Battle"
		-- end
	end


	if J.IsGoingOnSomeone( bot )
	then
		if J.IsValidHero( botTarget )
			and J.IsInRange( botTarget, bot, nRadius )
			and botTarget:IsChanneling()
			and J.CanCastOnNonMagicImmune( botTarget )
		then
			return BOT_ACTION_DESIRE_HIGH, "F-Chase:"..J.Chat.GetNormName( botTarget )
		end
	end


	if J.IsRetreating( bot )
	then
		if bot:WasRecentlyDamagedByAnyHero( 1.5 )
			and #nAlliedHeroesInRange < #nEnemyHeroesInRange
		then
			return BOT_ACTION_DESIRE_HIGH, 'F-Retreat'
		end
	end


	if J.IsDefending( bot )
	then
		if #hAllyList <= #hEnemyList
			and #hEnemyList >= 3
		then
			return BOT_ACTION_DESIRE_HIGH, "F-Defend"
		end
	end


end

function X.ConsiderR()
	
	if not abilityR:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end

	local nSkillLV = abilityR:GetLevel()
	local nCastRange = abilityR:GetCastRange() + bonusRange
	local nCastPoint = abilityR:GetCastPoint()
	local nManaCost = abilityR:GetManaCost()
	local nMinThreshold = abilityR:GetSpecialValueInt( 'hit_point_minimum_pct' ) + 5
	local nAlliedHeroesInRange = bot:GetNearbyHeroes( nCastRange, false, BOT_MODE_NONE )
	local nEnemyHeroesInRange = bot:GetNearbyHeroes( nCastRange, true, BOT_MODE_NONE )


	if nHP > nMinThreshold * 0.01 then return BOT_ACTION_DESIRE_NONE, nil end


	local npcStrongestEnemy = nil
	local npcStrongestEnemyHealth = 0
	for _, npcEnemy in pairs( nEnemyHeroesInRange )
	do
		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.CanCastOnTargetAdvanced( npcEnemy )
			and J.GetHP( npcEnemy ) > npcStrongestEnemyHealth
		then
			npcStrongestEnemy = npcEnemy
			npcStrongestEnemyHealth = J.GetHP( npcEnemy )
		end
	end

	local npcStrongestAlly = nil
	local npcStrongestAllyHealth = 0
	if J.IsInTeamFight( bot, 1200 )
	then
		for _, npcAlly in pairs( nAlliedHeroesInRange )
		do
			if J.IsValidHero( npcAlly )
				and J.CanCastOnMagicImmune( npcAlly )
				and J.GetHP( npcAlly ) > npcStrongestAllyHealth
				and npcAlly ~= bot
			then
				npcStrongestAlly = npcAlly
				npcStrongestAllyHealth = npcWeakestAlly:GetHealth()
			end
		end
	end
	

	if npcStrongestEnemy ~= nil
		and npcStrongestAlly ~= nil
	then
		if npcStrongestEnemyHealth > npcStrongestAllyHealth
		then
			return BOT_ACTION_DESIRE_HIGH, npcStrongestEnemy, 'R-Swap:'..J.Chat.GetNormName( npcStrongestEnemy )
		else
			return BOT_ACTION_DESIRE_HIGH, npcStrongestAlly, 'R-Swap:'..J.Chat.GetNormName( npcStrongestAlly )
		end
	end

	if npcStrongestEnemy ~= nil
		and npcStrongestAlly == nil
	then
		return BOT_ACTION_DESIRE_HIGH, npcStrongestEnemy, 'R-Swap:'..J.Chat.GetNormName( npcStrongestEnemy )
	end

	if npcStrongestEnemy == nil
		and npcStrongestAlly ~= nil
	then
		return BOT_ACTION_DESIRE_HIGH, npcStrongestAlly, 'R-Swap:'..J.Chat.GetNormName( npcStrongestAlly )
	end



	return BOT_ACTION_DESIRE_NONE, nil

end

return X