----------------------------------------------------------------------------------------------------
--- The Creation Come From: BOT EXPERIMENT Credit:FURIOUSPUPPY
--- BOT EXPERIMENT Author: Arizona Fauzie 2018.11.21
--- Link:http://steamcommunity.com/sharedfiles/filedetails/?id=837040016
--- Refactor: 决明子 Email: dota2jmz@163.com 微博@Dota2_决明子
--- Link:http://steamcommunity.com/sharedfiles/filedetails/?id=1573671599
--- Link:http://steamcommunity.com/sharedfiles/filedetails/?id=1627071163
--- Updated: Nikel
--- tank, priest
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
		['t25'] = {10, 0},
		['t20'] = {0, 10},
		['t15'] = {10, 0},
		['t10'] = {10, 0},
	},

	['outfit_mid'] = {
		['t25'] = {10, 0},
		['t20'] = {0, 10},
		['t15'] = {0, 10},
		['t10'] = {10, 0},
	},

	['outfit_priest'] = {
		['t25'] = {10, 0},
		['t20'] = {0, 10},
		['t15'] = {0, 10},
		['t10'] = {10, 0},
	},

	['outfit_mage'] = {
		['t25'] = {0, 10},
		['t20'] = {10, 0},
		['t15'] = {0, 10},
		['t10'] = {0, 10},
	},

	['outfit_tank'] = {
		['t25'] = {0, 10},
		['t20'] = {10, 0},
		['t15'] = {0, 10},
		['t10'] = {0, 10},
	},
}

local tAllAbilityBuildList = {
	['outfit_carry'] = {
		{2,3,3,2,2,6,3,2,3,1,6,1,1,1,6}
	},

	['outfit_mid'] = {
		{1,2,3,3,3,6,3,2,2,2,6,1,1,1,6}
	},

	['outfit_priest'] = {
		{1,3,1,2,1,6,1,3,3,3,6,2,2,2,6}
	},

	['outfit_mage'] = {
		{1,3,1,2,1,6,1,3,3,3,6,2,2,2,6}
	},

	['outfit_tank'] = {
		{1,2,3,3,3,6,3,2,2,2,6,1,1,1,6}
	},
}

local nAbilityBuildList = J.Skill.GetRandomBuild( tAllAbilityBuildList[sOutfitType] )

local nTalentBuildList = J.Skill.GetTalentBuild( tTalentTreeList[sOutfitType] )

local sRandomItem = RandomInt( 1, 9 ) > 6 and 0 or 10
local sRandomItem_1 = sRandomItem == 0 and "item_blink" or "item_force_staff"
local sRandomItem_2 = sRandomItem == 0 and "item_overwhelming_blink" or "item_hurricane_pike"

local tOutFitList = {}

tOutFitList['outfit_carry'] = {

	"item_venomancer_outfit",
	"item_urn_of_shadows",
	"item_ancient_janggo",
	"item_veil_of_discord",
	"item_aghanims_shard",
	sRandomItem_1,
	"item_ultimate_scepter",
	"item_boots_of_bearing",
	"item_ghost",
	"item_spirit_vessel",
	sRandomItem_2,
	"item_ethereal_blade",
	"item_ultimate_scepter_2",
	"item_aether_lens",
	"item_octarine_core",
	"item_moon_shard",

}

tOutFitList['outfit_mid'] = tOutFitList['outfit_carry']

tOutFitList['outfit_priest'] = {
	
	"item_priest_2_outfit",
	"item_force_staff",
	"item_glimmer_cape",
	"item_mekansm",
	"item_aeon_disk",
	"item_aghanims_shard",
	"item_guardian_greaves",
	"item_ghost",
	"item_ultimate_scepter",
	"item_hurricane_pike",
	"item_ethereal_blade",
	"item_ultimate_scepter_2",
	"item_aether_lens",
	"item_octarine_core",
	"item_moon_shard",

}

tOutFitList['outfit_mage'] = tOutFitList['outfit_carry']

tOutFitList['outfit_tank'] = tOutFitList['outfit_carry']

X['sBuyList'] = tOutFitList[sOutfitType]

X['sSellList'] = {
	"item_blink",
	"item_wraith_band",

	"item_force_staff",
	"item_wraith_band",

	"item_ultimate_scepter",
	"item_magic_wand",
}

if J.Role.IsPvNMode() or J.Role.IsAllShadow() then X['sBuyList'], X['sSellList'] = { 'PvN_mage' }, {} end

nAbilityBuildList, nTalentBuildList, X['sBuyList'], X['sSellList'] = J.SetUserHeroInit( nAbilityBuildList, nTalentBuildList, X['sBuyList'], X['sSellList'] )

X['sSkillList'] = J.Skill.GetSkillList( sAbilityList, nAbilityBuildList, sTalentList, nTalentBuildList )

X['bDeafaultAbility'] = false
X['bDeafaultItem'] = false

function X.MinionThink( hMinionUnit )

	if Minion.IsValidUnit( hMinionUnit )
	then
		if Minion.IsAttackingWard( hMinionUnit:GetUnitName() )
		then
			Minion.AttackingWardThink( hMinionUnit )
		else
			Minion.IllusionThink( hMinionUnit )
		end
	end

end

--[[

npc_dota_hero_venomancer

"Ability1"		"venomancer_venomous_gale"
"Ability2"		"venomancer_poison_sting"
"Ability3"		"venomancer_plague_ward"
"Ability4"		"venomancer_latent_poison"
"Ability5"		"generic_hidden"
"Ability6"		"venomancer_poison_nova"
"Ability10"		"special_bonus_unique_venomancer_3"
"Ability11"		"special_bonus_unique_venomancer_poisonsting_regen_reduction"
"Ability12"		"special_bonus_unique_venomancer_8"
"Ability13"		"special_bonus_unique_venomancer_2"
"Ability14"		"special_bonus_unique_venomancer_4"
"Ability15"		"special_bonus_unique_venomancer_gale_plagueward"
"Ability16"		"special_bonus_unique_venomancer_5"
"Ability17"		"special_bonus_unique_venomancer"

modifier_projectile_vision
modifier_venomancer_venomous_gale
modifier_venomancer_poison_sting_applier
modifier_venomancer_poison_sting
modifier_venomancer_poison_sting_ward
modifier_kill
modifier_magic_immune
modifier_plague_wards_bonus
modifier_venomancer_latent_poison
modifier_stunned
modifier_venomancer_poison_nova_thinker
modifier_venomancer_poison_nova

--]]

local abilityQ = bot:GetAbilityByName( sAbilityList[1] )
local abilityE = bot:GetAbilityByName( sAbilityList[3] )
local abilityD = bot:GetAbilityByName( sAbilityList[4] )
local abilityR = bot:GetAbilityByName( sAbilityList[6] )

local castQDesire, castQLocation
local castEDesire, castELocation
local castDDesire, castDTarget
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

		J.SetQueuePtToINT( bot, true )

		bot:ActionQueue_UseAbility( abilityR )
		return
	end
	
	castQDesire, castQLocation, sMotive = X.ConsiderQ()
	if castQDesire > 0
	then
		J.SetReportMotive( bDebugMode, sMotive )

		J.SetQueuePtToINT( bot, true )

		bot:ActionQueue_UseAbilityOnLocation( abilityQ, castQLocation )
		return
	end

	castDDesire, castDTarget, sMotive = X.ConsiderD()
	if ( castDDesire > 0 )
	then
		J.SetReportMotive( bDebugMode, sMotive )

		J.SetQueuePtToINT( bot, false )

		bot:ActionQueue_UseAbilityOnEntity( abilityD, castDTarget )
		return
	end

	castEDesire, castELocation, sMotive = X.ConsiderE()
	if castEDesire > 0
	then
		J.SetReportMotive( bDebugMode, sMotive )

		J.SetQueuePtToINT( bot, false )

		bot:ActionQueue_UseAbilityOnLocation( abilityE, castELocation )
		return
	end

end


function X.ConsiderQ()

	if not abilityQ:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end

	local nSkillLV = abilityQ:GetLevel()
	local nCastRange = abilityQ:GetCastRange() + bonusRange
	local nRadius = abilityQ:GetSpecialValueInt( 'radius' )
	local nCastPoint = abilityQ:GetCastPoint()
	local nManaCost = abilityQ:GetManaCost()
	local nDamage = abilityQ:GetSpecialValueInt( 'strike_damage' ) + ( abilityQ:GetSpecialValueInt( 'tick_damage' ) * 3 )
	local nDamageType = DAMAGE_TYPE_MAGICAL
	local nAlliedHeroesInRange = bot:GetNearbyHeroes( nCastRange, false, BOT_MODE_NONE )
	local nEnemyHeroesInRange = bot:GetNearbyHeroes( nCastRange, true, BOT_MODE_NONE )
	local nTargetLocation = nil


	for _, npcEnemy in pairs( nEnemyHeroesInRange )
	do
		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.WillMagicKillTarget( bot, npcEnemy, nDamage, nCastPoint )
		then
			nTargetLocation = botTarget:GetExtrapolatedLocation( nCastPoint )
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'Q-Kill:'..J.Chat.GetNormName( npcEnemy )
		end
	end
	
	
	local nAoeLoc = J.GetAoeEnemyHeroLocation( bot, nCastRange, nRadius, 2 )
	if nAoeLoc ~= nil and bot:GetActiveMode() ~= BOT_MODE_RETREAT
	then
		nTargetLocation = nAoeLoc
		return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'Q-Harass'
	end
	

	if J.IsInTeamFight( bot, 1200 )
	then
		nAoeLoc = J.GetAoeEnemyHeroLocation( bot, nCastRange, nRadius, 2 )
		if nAoeLoc ~= nil
		then
			nTargetLocation = nAoeLoc
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'Q-Battle'
		end
	end


	if J.IsGoingOnSomeone( bot )
	then
		if J.IsValidHero( botTarget )
			and J.CanCastOnNonMagicImmune( botTarget )
			and J.IsInRange( botTarget, bot, nCastRange )
		then
			nTargetLocation = botTarget:GetExtrapolatedLocation( nCastPoint )
			if J.IsInLocRange( bot, nTargetLocation, nCastRange )
			then
				return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'Q-Attack:'..J.Chat.GetNormName( botTarget )
			end
		end
	end


	if J.IsRetreating( bot )
	then
		for _, npcEnemy in pairs( nEnemyHeroesInRange )
		do
			if J.IsValid( npcEnemy )
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
		nAoeLoc = J.GetAoeEnemyHeroLocation( bot, nCastRange, nRadius, 2 )
		if nAoeLoc ~= nil and nMP > 0.58
		then
			nTargetLocation = nAoeLoc
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'Q-Harass'
		end

		if #hAllyList == 1 and nMP > 0.38
		then
			local locationAoEKill = bot:FindAoELocation( true, false, bot:GetLocation(), nCastRange, nRadius, 0, nDamage )
			if locationAoEKill.count >= 3
			then
				nTargetLocation = locationAoEKill.targetloc
				return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "Q-ClearWave"..locationAoEKill.count
			end
		end
	end

	
	if bot:GetActiveMode() == BOT_MODE_ROSHAN
		and nMP >= 0.78
	then
		if J.IsRoshan( botTarget ) and J.GetHP( botTarget ) > 0.15
			and J.IsInRange( botTarget, bot, nCastRange )
		then
			nTargetLocation = botTarget:GetLocation()
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'Q-Roshan'
		end
	end


	return BOT_ACTION_DESIRE_NONE, nil

end

function X.ConsiderE()

	if not abilityE:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end

	local nSkillLV = abilityE:GetLevel()
	local nCastRange = abilityE:GetCastRange() + bonusRange
	local nRadius = 600
	local nCastPoint = abilityE:GetCastPoint()
	local nManaCost = abilityE:GetManaCost()
	local nEnemyHeroesInRange = bot:GetNearbyHeroes( nCastRange, true, BOT_MODE_NONE )
	local nTargetLocation = nil


	if J.IsGoingOnSomeone( bot )
	then
		if J.IsValidHero( botTarget )
			and J.IsInRange( bot, botTarget, nCastRange + nRadius - 100 )
			and not botTarget:IsAttackImmune()
		then
			nTargetLocation = J.GetCastLocation( bot, botTarget, nCastRange, nRadius ) + RandomVector( nRadius * 0.1 )
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'E-Attack:'..J.Chat.GetNormName( botTarget )
		end
	end
	

	if J.IsInTeamFight( bot, 1200 )
	then
		for _, npcEnemy in pairs( nEnemyHeroesInRange )
		do
			if J.IsValidHero( botTarget )
				and not npcEnemy:IsAttackImmune()
			then
				nTargetLocation = J.GetCastLocation( bot, npcEnemy, nCastRange, nRadius ) + RandomVector( nRadius * 0.5 )
				return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'E-Battle'
			end
		end
	end


	if J.IsLaning( bot )
	then
		for _, npcEnemy in pairs( nEnemyHeroesInRange )
		do
			if J.IsValidHero( npcEnemy )
				and not botTarget:IsAttackImmune()
				and J.IsAllowedToSpam( bot, nManaCost )
				and nMP >= 0.5
			then
				nTargetLocation = J.GetCastLocation( bot, botTarget, nCastRange, nRadius ) + RandomVector( nRadius * 0.5 )
				return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "E-SpamHarass:"..J.Chat.GetNormName( npcEnemy )
			end
		end
	end

	
	if ( J.IsPushing( bot ) or J.IsDefending( bot ) or J.IsFarming( bot ) )
		and J.IsAllowedToSpam( bot, nManaCost * 0.32 )
		and nSkillLV >= 2 and DotaTime() > 8 * 60
	then

		local nEnemyCreeps = bot:GetNearbyLaneCreeps( nCastRange + nRadius, true )
		if #nEnemyCreeps >= 3
			and J.IsValid( nEnemyCreeps[1] )
			and not nEnemyCreeps[1]:HasModifier( "modifier_fountain_glyph" )
		then
				nTargetLocation = J.GetCastLocation( bot, creep, nCastRange, nRadius ) + RandomVector( nRadius * 0.5 )
				return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "E-Push"
		end


	end

	
	if J.IsFarming( bot )
		and not ( J.IsPushing( bot ) or J.IsDefending( bot ) )
		and J.IsAllowedToSpam( bot, nManaCost * 0.25 )
		and nSkillLV >= 3
		and #hEnemyList == 0
		and #hAllyList <= 2
	then
		local nNeutralCreeps = bot:GetNearbyNeutralCreeps( nCastRange + nRadius )
		if #nNeutralCreeps >= 3 or nMP >= 0.8
		then
			local targetCreep = nNeutralCreeps[1]
			if J.IsValid( targetCreep )
				and targetCreep:GetHealth() >= 500
				and targetCreep:GetMagicResist() < 0.3
				and J.GetAroundTargetEnemyUnitCount( targetCreep, 300 ) >= 1
			then
				nTargetLocation = J.GetCastLocation( bot, targetCreep, nCastRange, nRadius ) + RandomVector( nRadius * 0.5 )
				return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "E-Farm:"..( #nNeutralCreeps )
			end
		end
	end

	
	if bot:GetActiveMode() == BOT_MODE_ROSHAN
		and nMP >= 0.65
	then
		if J.IsRoshan( botTarget ) and J.GetHP( botTarget ) > 0.15
			and J.IsInRange( botTarget, bot, nCastRange )
		then
			nTargetLocation = J.GetCastLocation( bot, botTarget, nCastRange, nRadius )
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'E-Roshan'
		end
	end


	local nRManaCost = abilityR:GetManaCost()
	if #hEnemyList >= 1
		and ( not abilityR:IsFullyCastable() or bot:GetMana() > nRManaCost )
	then
		local nAlliedCreeps = bot:GetNearbyLaneCreeps( nCastRange + nRadius, false )
		if J.IsValidHero( hEnemyList[1] )
			and not hEnemyList[1]:IsAttackImmune()
			and J.IsAllowedToSpam( bot, nManaCost )
			and nMP >= 0.5
			and ( #nAlliedCreeps >= 1 or #hAllyList >= 2)
		then
			nTargetLocation =  J.GetCastLocation( bot, hEnemyList[1], nCastRange, nRadius ) + RandomVector( nRadius * 0.5 )
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'E-Spam'
		end
	end


	local nTowerList = bot:GetNearbyTowers( 990, true )
	local nBarrackList = bot:GetNearbyBarracks( 990, true )
	local nEnemyAncient = GetAncient( GetOpposingTeam() )
	local hBuildingList = {
		botTarget,
		nTowerList[1],
		nBarrackList[1],
		nEnemyAncient,
	}

	for _, building in pairs( hBuildingList )
	do
		if J.IsValidBuilding( building )
			and J.IsInRange( bot, building, nCastRange + nRadius )
			and not nBuilding:HasModifier( 'modifier_fountain_glyph' )
			and not nBuilding:HasModifier( 'modifier_invulnerable' )
			and not nBuilding:HasModifier( 'modifier_backdoor_protection' )
			and not J.IsKeyWordUnit( "DOTA_Outpost", building )
		then
			nTargetLocation = building:GetLocation() + RandomVector( nRadius * 0.5 )
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "E-Push-Tower"
		end
	end


	nTowerList = bot:GetNearbyTowers( 990, false )
	nBarrackList = bot:GetNearbyBarracks( 990, false )
	nEnemyAncient = GetAncient( GetOpposingTeam() )
	hBuildingList = {
		nTowerList[1],
		nBarrackList[1],
		nEnemyAncient,
	}

	for _, building in pairs (hBuildingList )
	do
		if J.IsValidBuilding( building )
			and J.IsInRange( bot, building, nCastRange + nRadius )
			and not J.IsKeyWordUnit( "DOTA_Outpost", building )
			and ( J.GetAroundTargetEnemyUnitCount( building, 600 ) >= 1 or J.IsDefending( bot ) )
		then
			nTargetLocation = building:GetLocation() + RandomVector( nRadius * 0.5 )
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "E-Defend-Tower"
		end
	end


	return BOT_ACTION_DESIRE_NONE, nil

end


function X.ConsiderD()

	if not abilityD:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end

	local nSkillLV = abilityD:GetLevel()
	local nCastRange = abilityD:GetCastRange() + bonusRange
	local nCastPoint = abilityD:GetCastPoint()
	local nManaCost = abilityD:GetManaCost()
	local nAlliedHeroesInRange = bot:GetNearbyHeroes( nCastRange, false, BOT_MODE_NONE )
	local nEnemyHeroesInRange = bot:GetNearbyHeroes( nCastRange, true, BOT_MODE_NONE )


	if J.IsInTeamFight( bot, 1200 )
	then
		local npcWeakestEnemy = J.GetVulnerableWeakestUnitWithLotusCheck( bot, true, true, nCastRange )
		if ( npcWeakestEnemy ~= nil )
		then
			return BOT_ACTION_DESIRE_HIGH, npcWeakestEnemy, 'D-Battle-Weakest:'..J.Chat.GetNormName( npcWeakestEnemy )
		end
	end


	if J.IsGoingOnSomeone( bot )
	then
		if J.IsValidHero( botTarget )
			and J.CanCastAbilityOnTarget( botTarget, false )
			and J.CanCastOnTargetAdvanced( botTarget )
			and J.IsInRange( botTarget, bot, nCastRange )
		then
			return BOT_ACTION_DESIRE_HIGH, botTarget, 'D-Slow:'..J.Chat.GetNormName( botTarget )
		end
	end


	if J.IsRetreating( bot )
	then
		for _, npcEnemy in pairs( nEnemyHeroesInRange )
		do
			if J.IsValid( npcEnemy )
				and bot:WasRecentlyDamagedByHero( npcEnemy, 3.5 )
				and J.CanCastAbilityOnTarget( botTarget, false )
				and J.CanCastOnTargetAdvanced( npcEnemy )
				and bot:IsFacingLocation( npcEnemy:GetExtrapolatedLocation( nCastPoint ), 20 )
			then
				return BOT_ACTION_DESIRE_HIGH, npcEnemy, 'D-Retreat:'..J.Chat.GetNormName( npcEnemy )
			end
		end
	end
	

	return BOT_ACTION_DESIRE_NONE, nil

end


function X.ConsiderR()
	
	if not abilityR:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end

	local nSkillLV = abilityR:GetLevel()
	local nRadius = abilityR:GetSpecialValueInt( 'start_radius' ) + abilityR:GetSpecialValueInt( 'radius' )
	local nCastPoint = abilityR:GetCastPoint()
	local nManaCost = abilityR:GetManaCost()
	local nEnemyHeroesInRange = bot:GetNearbyHeroes( nRadius - 150, true, BOT_MODE_NONE )
	local nTargetLocation = nil


	if J.IsInTeamFight( bot, 1200 )
	then
		local nAoeCount = 0
		for _, npcEnemy in pairs( nEnemyHeroesInRange )
		do 
			if J.IsValidHero( npcEnemy )
				and J.CanCastOnNonMagicImmune( npcEnemy )
			then
				nAoeCount = nAoeCount + 1
			end
		end

		if nAoeCount >= 3
		then
			return BOT_ACTION_DESIRE_HIGH, 'R-Battle'
		end
	end

	
	if J.IsRetreating( bot )
		and #nEnemyHeroesInRange >= 2
		and #nEnemyHeroesInRange >= #hAllyList
	then
		local nAoeCount = 0
		for _, npcEnemy in pairs( nEnemyHeroesInRange )
		do 
			if J.IsValidHero( npcEnemy )
				and J.CanCastOnNonMagicImmune( npcEnemy )
				and bot:WasRecentlyDamagedByHero( npcEnemy, 3.0 )
			then
				nAoeCount = nAoeCount + 1
			end
		end

		if nAoeCount >= 1
		then
			return BOT_ACTION_DESIRE_HIGH, 'R-Retreat'
		end
	end


	return BOT_ACTION_DESIRE_NONE, nil

end

return X