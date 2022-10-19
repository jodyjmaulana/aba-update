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
		['t25'] = {10, 0},
		['t20'] = {0, 10},
		['t15'] = {10, 0},
		['t10'] = {0, 10},
	},
}

local tAllAbilityBuildList = {
	['outfit_carry'] = {
		{1,3,1,3,2,6,1,1,3,3,6,2,2,2,6}
	},

	['outfit_mid'] = {
		{1,3,1,3,2,6,1,1,3,3,6,2,2,2,6}
	},

	['outfit_priest'] = {
		{1,3,1,3,2,6,1,1,3,3,6,2,2,2,6}
	},

	['outfit_mage'] = {
		{1,3,1,3,2,6,1,1,3,3,6,2,2,2,6}
	},

	['outfit_tank'] = {
		{1,3,1,3,2,6,1,1,3,3,6,2,2,2,6}
	},
}

local nAbilityBuildList = J.Skill.GetRandomBuild( tAllAbilityBuildList[sOutfitType] )

local nTalentBuildList = J.Skill.GetTalentBuild( tTalentTreeList[sOutfitType] )

local tOutFitList = {}

tOutFitList['outfit_carry'] = {

	"item_sven_outfit",
	"item_echo_sabre",
	"item_black_king_bar",
	"item_basher",
	"item_blink",
	"item_abyssal_blade",
	"item_assault",
	"item_aghanims_shard",
	"item_ultimate_scepter",
	"item_travel_boots",
	"item_overwhelming_blink",
	"item_ultimate_scepter_2",
	"item_nullifier",
	"item_moon_shard",
	"item_travel_boots_2",
	
}

tOutFitList['outfit_mid'] = tOutFitList['outfit_carry']

tOutFitList['outfit_priest'] = tOutFitList['outfit_carry']

tOutFitList['outfit_mage'] = tOutFitList['outfit_carry']

tOutFitList['outfit_tank'] = tOutFitList['outfit_carry']

X['sBuyList'] = tOutFitList[sOutfitType]

X['sSellList'] = {
	"item_basher",
	"item_quelling_blade",

	"item_blink",
	"item_magic_wand",

	"item_assault",
	"item_bracer",

	"item_point_booster",
	"item_echo_sabre",
	
	"item_travel_boots",
	"item_phase_boots",
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

npc_dota_hero_night_stalker

"Ability1"		"night_stalker_void"
"Ability2"		"night_stalker_crippling_fear"
"Ability3"		"night_stalker_hunter_in_the_night"
"Ability4"		"generic_hidden"
"Ability5"		"generic_hidden"
"Ability6"		"night_stalker_darkness"
"Ability10"		"special_bonus_unique_night_stalker_4"
"Ability11"		"special_bonus_unique_night_stalker_7"
"Ability12"		"special_bonus_unique_night_stalker_3"
"Ability13"		"special_bonus_unique_night_stalker_hunter_status_resist"
"Ability14"		"special_bonus_unique_night_stalker_6"
"Ability15"		"special_bonus_strength_20"
"Ability16"		"special_bonus_unique_night_stalker_2"
"Ability17"		"special_bonus_unique_night_stalker"

modifier_night_stalker_void
modifier_stunned
modifier_night_stalker_crippling_fear_aura
modifier_night_stalker_crippling_fear
modifier_night_stalker_hunter_in_the_night
modifier_night_stalker_darkness

--]]

local abilityQ = bot:GetAbilityByName( sAbilityList[1] )
local abilityW = bot:GetAbilityByName( sAbilityList[2] )
local abilityE = bot:GetAbilityByName( sAbilityList[3] )
local abilityR = bot:GetAbilityByName( sAbilityList[6] )
local talent1 = bot:GetAbilityByName( sTalentList[1] )

local castQDesire, castQTargetLocation
local castWDesire
local castEDesire, castETarget
local castRDesire

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

	
	castRDesire, sMotive = X.ConsiderR()
	if castRDesire > 0
	then
		J.SetReportMotive( bDebugMode, sMotive )

		J.SetQueuePtToINT( bot, false )

		bot:ActionQueue_UseAbility( abilityR )
		return
	end
	
	castQDesire, castQTargetLocation, sMotive = X.ConsiderQ()
	if castQDesire > 0
	then
		J.SetReportMotive( bDebugMode, sMotive )

		J.SetQueuePtToINT( bot, false )

		if bot:HasScepter()
		then
			bot:ActionQueue_UseAbilityOnLocation( abilityQ, castQTargetLocation )
		else
			bot:ActionQueue_UseAbilityOnEntity( abilityQ, castQTargetLocation )
		end
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

	castEDesire, castETarget, sMotive = X.ConsiderE()
	if castEDesire > 0
	then
		J.SetReportMotive( bDebugMode, sMotive )

		J.SetQueuePtToINT( bot, false )

		bot:ActionQueue_UseAbilityOnEntity( abilityE, castETarget )
		return
	end

end


function X.ConsiderQ()

	if not abilityQ:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end

	local nSkillLV = abilityQ:GetLevel()
	local nCastRange = abilityQ:GetCastRange() + bonusRange
	local nRadius = 0
	local nCastPoint = abilityQ:GetCastPoint()
	local nManaCost = abilityQ:GetManaCost()
	local nDamage = abilityQ:GetSpecialValueInt( 'damage' )
	local nTargetLocation = nil

	if bot:HasScepter() then nRadius = abilityQ:GetSpecialValueInt( 'radius_scepter' ) end
	if talent1:IsTrained() then nDamage = nDamage + 50 end

	local nEnemyHeroesInRange = bot:GetNearbyHeroes( nCastRange + nRadius, true, BOT_MODE_NONE )


	for _, npcEnemy in pairs( nEnemyHeroesInRange )
	do
		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and ( bot:HasScepter() or J.CanCastOnTargetAdvanced( npcEnemy ) )
			and J.WillMagicKillTarget( bot, npcEnemy, nDamage, nCastPoint )
		then
			if bot:HasScepter()
			then
				nTargetLocation = npcEnemy:GetLocation()
				return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'Q-Kill:'..J.Chat.GetNormName( npcEnemy )
			else
				return BOT_ACTION_DESIRE_HIGH, npcEnemy, 'Q-Kill:'..J.Chat.GetNormName( npcEnemy )
			end
		end

		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and ( bot:HasScepter() or J.CanCastOnTargetAdvanced( npcEnemy ) )
			and npcEnemy:IsChanneling()
		then
			if bot:HasScepter()
			then
				nTargetLocation = npcEnemy:GetLocation()
				return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'Q-Interrupt:'..J.Chat.GetNormName( npcEnemy )
			else
				return BOT_ACTION_DESIRE_HIGH, npcEnemy, 'Q-Interrupt:'..J.Chat.GetNormName( npcEnemy )
			end
		end
	end


	if J.IsInTeamFight( bot, 1200 )
	then
		if bot:HasScepter()
		then
			local nAoeLoc = J.GetAoeEnemyHeroLocation( bot, nCastRange, nRadius, 2 )
			if nAoeLoc ~= nil
			then
				nTargetLocation = nAoeLoc
				return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'Q-Battle'
			end
		else
			local npcWeakestEnemy = J.GetVulnerableWeakestUnitWithLotusCheck( bot, true, true, nCastRange )
			if npcWeakestEnemy ~= nil
			then
				return BOT_ACTION_DESIRE_HIGH, npcWeakestEnemy, 'Q-Battle-Weakest:'..J.Chat.GetNormName( npcWeakestEnemy )
			end
		end
	end


	if J.IsGoingOnSomeone( bot )
	then
		if J.IsValidHero( botTarget )
			and J.CanCastOnNonMagicImmune( botTarget )
			and ( bot:HasScepter() or J.CanCastOnTargetAdvanced( botTarget ) )
			and J.IsInRange( botTarget, bot, nCastRange + nRadius )
		then
			if bot:HasScepter()
			then
				nTargetLocation = botTarget:GetLocation()
				return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'Q-Attack:'..J.Chat.GetNormName( botTarget )
			else
				return BOT_ACTION_DESIRE_HIGH, botTarget, 'Q-Attack:'..J.Chat.GetNormName( botTarget )
			end
		end
	end


	if J.IsRetreating( bot )
	then
		for _, npcEnemy in pairs( nEnemyHeroesInRange )
		do
			if J.IsValid( npcEnemy )
				and bot:WasRecentlyDamagedByHero( npcEnemy, 3.0 )
				and J.CanCastOnNonMagicImmune( npcEnemy )
				and ( bot:HasScepter() or J.CanCastOnTargetAdvanced( npcEnemy ) )
				and bot:IsFacingLocation( npcEnemy:GetExtrapolatedLocation( nCastPoint ), 20 )
			then
				if bot:HasScepter()
				then
					nTargetLocation = J.GetCastLocation( bot, npcEnemy, nCastRange, nRadius )
					return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'Q-Retreat:'..J.Chat.GetNormName( npcEnemy )
				else
					return BOT_ACTION_DESIRE_HIGH, npcEnemy, 'Q-Retreat:'..J.Chat.GetNormName( npcEnemy )
				end
			end
		end
	end

	
	if J.IsLaning( bot )
		and J.IsAllowedToSpam( bot, nManaCost )
		and nMP >= 0.55
	then
		local nEnemyCreeps = bot:GetNearbyCreeps( nCastRange + nRadius, true )
		for _, creep in pairs( nEnemyCreeps )
		do
			if J.IsValid( creep )
				and not creep:HasModifier( 'modifier_fountain_glyph' )
				and J.IsKeyWordUnit( 'ranged', creep )
				and J.WillMagicKillTarget( bot, creep, nDamage, nCastPoint )
			then
				if bot:HasScepter()
				then
					nTargetLocation = J.GetCastLocation( bot, creep, nCastRange, nRadius )
					return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'Q-Farm'
				else
					return BOT_ACTION_DESIRE_HIGH, creep, 'Q-Farm'
				end
			end
		end

		for _, npcEnemy in pairs( nEnemyHeroesInRange )
		do
			if J.IsValid( npcEnemy )
				and J.CanCastOnNonMagicImmune( npcEnemy )
				and ( bot:HasScepter() or J.CanCastOnTargetAdvanced( npcEnemy ) )
				and X.IsNighttime()
			then
				if bot:HasScepter()
				then
					nTargetLocation = J.GetAoeEnemyHeroLocation( bot, nCastRange, nRadius, 2 )
					return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'Q-Harass'
				else
					return BOT_ACTION_DESIRE_HIGH, npcEnemy, 'Q-Harass:'..J.Chat.GetNormName( npcEnemy )
				end
			end
		end
	end

	
	if ( J.IsPushing( bot ) or J.IsDefending( bot ) or J.IsFarming( bot ) )
		and J.IsAllowedToSpam( bot, nManaCost )
		and nSkillLV >= 3 and DotaTime() > 8 * 60
		and bot:HasScepter()
	then
		local nEnemyCreeps = bot:GetNearbyCreeps( nCastRange + nRadius, true )
		if #nEnemyCreeps >= 3
			and J.IsValid( nEnemyCreeps[1] )
			and not nEnemyCreeps[1]:HasModifier( "modifier_fountain_glyph" )
		then
			local nAoeLoc = bot:FindAoELocation( true, false, bot:GetLocation(), nCastRange, nRadius, 0, 0 )
			if nAoeLoc.count >= 3
			then
				nTargetLocation = nAoeLoc.targetloc
				return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "Q-ClearWave:"..nAoeLoc.count
			end
		end
	end


	return BOT_ACTION_DESIRE_NONE, nil


end

function X.ConsiderW()

	if not abilityW:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end

	local nRadius = abilityW:GetSpecialValueInt( 'radius' )
	local nEnemyHeroesInRange = bot:GetNearbyHeroes( nRadius + 150, true, BOT_MODE_NONE )


	if J.IsInTeamFight( bot, 1200 )
	then
		for _, npcEnemy in pairs( nEnemyHeroesInRange )
		do
			if J.IsValidHero( npcEnemy )
				and J.CanCastOnNonMagicImmune( npcEnemy )
			then
				return BOT_ACTION_DESIRE_HIGH, 'W-Battle'
			end
		end
	end


	if J.IsGoingOnSomeone( bot )
	then
		if J.IsValidHero( botTarget )
			and J.CanCastOnNonMagicImmune( botTarget )
			and J.CanCastOnTargetAdvanced( botTarget )
			and J.IsInRange( botTarget, bot, nRadius )
		then
			return BOT_ACTION_DESIRE_HIGH, 'W-Chase:'..J.Chat.GetNormName( botTarget )
		end
	end


	if J.IsRetreating( bot )
	then
		if bot:WasRecentlyDamagedByAnyHero( 1.5 )
			and #nEnemyHeroesInRange >= 1
		then
			return BOT_ACTION_DESIRE_HIGH, 'W-Retreat'
		end
	end


	return BOT_ACTION_DESIRE_NONE, nil

end

function X.ConsiderE()

	if not abilityE:IsFullyCastable()
		or abilityE:GetBehavior() ~= ABILITY_BEHAVIOR_UNIT_TARGET
	then
		return BOT_ACTION_DESIRE_NONE, nil
	end

	local nCastRange = abilityE:GetSpecialValueInt( 'shard_cast_range' ) + bonusRange

	
	if nHP <= 0.65
		or nMP <= 0.75
		or ( nHP <= 0.7 and nMP <= 0.8 )
	then
		local nEnemyCreeps = bot:GetNearbyCreeps( nCastRange + 400, true )
		for _, creep in pairs( nEnemyCreeps )
		do
			if J.IsValid( creep )
			then
				return BOT_ACTION_DESIRE_HIGH, creep, 'E-Heal-EnemyCreep'
			end
		end

		local nNeutralCreeps = bot:GetNearbyNeutralCreeps( nCastRange + 400 )
		for _, creep in pairs( nNeutralCreeps )
		do
			if J.IsValid( creep )
				and ( not creep:IsAncientCreep() or X.IsNighttime() )
			then
				return BOT_ACTION_DESIRE_HIGH, creep, 'E-Heal-NeutralCreep'
			end
		end

		local nAlliedCreeps = bot:GetNearbyCreeps( nCastRange + 400, false )
		for _, creep in pairs( nAlliedCreeps )
		do
			if J.IsValid( creep )
			then
				return BOT_ACTION_DESIRE_HIGH, creep, 'E-Heal-AlliedCreep'
			end
		end
	end
	

	return BOT_ACTION_DESIRE_NONE, nil

end

function X.ConsiderR()
	
	if not abilityR:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end


	if J.IsInTeamFight( bot, 1200 )
	then
		if #hEnemyList >= #hAllyList
		then
			return BOT_ACTION_DESIRE_HIGH, "R-Battle"
		end
	end


	if J.IsGoingOnSomeone( bot )
	then
		if J.IsValidHero( botTarget )
			and J.IsInRange( botTarget, bot, 700 )
			and abilityQ:IsFullyCastable()
			and J.CanCastOnNonMagicImmune( botTarget )
			and ( bot:HasScepter() or J.CanCastOnTargetAdvanced( botTarget ) )
		then
			return BOT_ACTION_DESIRE_HIGH, "R-Chase:"..J.Chat.GetNormName( botTarget )
		end
	end


	return BOT_ACTION_DESIRE_NONE, nil

end

function X.IsNighttime()

	if bot:HasModifier( 'modifier_phoenix_sun_debuff' )
	then
		return false
	end

	if bot:HasModifier( 'modifier_night_stalker_darkness' )
	then
		return true
	end


	local nCurrentTime = DotaTime()
	local nCurrentMinute = math.floor( nCurrentTime / 60 )

	if nCurrentMinute % 10 >= 5
	then
		return true
	end

end

return X