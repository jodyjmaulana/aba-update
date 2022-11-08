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
local Minion = dofile( GetScriptDirectory()..'/FunLib/aba_minion' )
local sTalentList = J.Skill.GetTalentList( bot )
local sAbilityList = J.Skill.GetAbilityList( bot )
local sOutfitType = J.Item.GetOutfitType( bot )

local tTalentTreeList = {
	['outfit_carry'] = {
		['t25'] = {10, 0},
		['t20'] = {0, 10},
		['t15'] = {0, 10},
		['t10'] = {10, 0},
	},

	['outfit_mid'] = {
		['t25'] = {10, 0},
		['t20'] = {0, 10},
		['t15'] = {0, 10},
		['t10'] = {10, 0},
	},

	['outfit_priest'] = {
		['t25'] = {0, 10},
		['t20'] = {10, 0},
		['t15'] = {0, 10},
		['t10'] = {0, 10},
	},

	['outfit_mage'] = {
		['t25'] = {0, 10},
		['t20'] = {0, 10},
		['t15'] = {10, 0},
		['t10'] = {0, 10},
	},

	['outfit_tank'] = {
		['t25'] = {10, 0},
		['t20'] = {0, 10},
		['t15'] = {0, 10},
		['t10'] = {10, 0},
	},
}

local tAllAbilityBuildList = {
	['outfit_carry'] = {
		{1,3,1,3,1,6,1,3,2,3,6,2,2,2,6}
	},

	['outfit_mid'] = {
		{1,3,1,3,1,6,1,3,2,3,6,2,2,2,6}
	},

	['outfit_priest'] = {
		{1,3,1,3,2,6,1,3,1,3,6,2,2,2,6}
	},

	['outfit_mage'] = {
		{1,3,1,3,2,6,1,3,1,3,6,2,2,2,6}
	},

	['outfit_tank'] = {
		{1,3,1,3,1,6,1,3,2,3,6,2,2,2,6}
	},
}

local nAbilityBuildList = J.Skill.GetRandomBuild( tAllAbilityBuildList[sOutfitType] )

local nTalentBuildList = J.Skill.GetTalentBuild( tTalentTreeList[sOutfitType] )

local tOutFitList = {}

tOutFitList['outfit_carry'] = {

	"item_tranquil_boots",
	"item_kaya",
	"item_dagon",
	"item_dagon_5",
	"item_ethereal_blade",
	"item_force_staff",
	"item_ultimate_scepter",
	"item_sheepstick",
	"item_aghanims_shard",
	"item_travel_boots",
	"item_hurricane_pike",
	"item_ultimate_scepter_2",
	"item_octarine_core",
	"item_travel_boots_2",
	"item_moon_shard",
	
}

tOutFitList['outfit_mid'] = tOutFitList['outfit_carry']

tOutFitList['outfit_priest'] = {

	"item_tranquil_boots",
	"item_ultimate_scepter",
	"item_pipe",
	"item_force_staff",
	"item_glimmer_cape",
	"item_aeon_disk",
	"item_aghanims_shard",
	"item_hurricane_pike",
	"item_boots_of_bearing",
	"item_ultimate_scepter_2",
	"item_cyclone",
	"item_wind_waker",
	"item_moon_shard",
	
}

tOutFitList['outfit_mage'] = {
	
	"item_tranquil_boots",
	"item_ancient_janggo",
	"item_ultimate_scepter",
	'item_aeon_disk',
	"item_rod_of_atos",
	"item_orchid",
	"item_aghanims_shard",
	"item_boots_of_bearing",
	"item_ghost",
	"item_ethereal_blade",
	"item_gungir",
	"item_bloodthorn",
	"item_ultimate_scepter_2",
	"item_cyclone",
	"item_wind_waker",
	"item_moon_shard",

}

tOutFitList['outfit_tank'] = tOutFitList['outfit_carry']

X['sBuyList'] = tOutFitList[sOutfitType]

X['sSellList'] = {
	"item_travel_boots",
	"item_tranquil_boots",
}

if J.Role.IsPvNMode() or J.Role.IsAllShadow() then X['sBuyList'], X['sSellList'] = { 'PvN_melee_carry' }, {} end

nAbilityBuildList, nTalentBuildList, X['sBuyList'], X['sSellList'] = J.SetUserHeroInit( nAbilityBuildList, nTalentBuildList, X['sBuyList'], X['sSellList'] )

X['sSkillList'] = J.Skill.GetSkillList( sAbilityList, nAbilityBuildList, sTalentList, nTalentBuildList )

X['bDeafaultAbility'] = false
X['bDeafaultItem'] = false

function X.MinionThink( hMinionUnit )

	if Minion.IsValidUnit( hMinionUnit )
		and hMinionUnit:GetUnitName() ~= 'npc_dota_ignis_fatuus'
	then
		Minion.IllusionThink( hMinionUnit )
	end

end

--[[

npc_dota_hero_keeper_of_the_light

"Ability1"		"keeper_of_the_light_illuminate"
"Ability2"		"keeper_of_the_light_radiant_bind"
"Ability3"		"keeper_of_the_light_chakra_magic"
"Ability4"		"keeper_of_the_light_blinding_light"
"Ability5"		"keeper_of_the_light_will_o_wisp"
"Ability6"		"keeper_of_the_light_spirit_form"
"Ability7"		"keeper_of_the_light_illuminate_end"
"Ability8"		"keeper_of_the_light_spirit_form_illuminate"
"Ability9"		"keeper_of_the_light_spirit_form_illuminate_end"
"Ability10"		"keeper_of_the_light_recall"
"Ability11"		"special_bonus_unique_keeper_of_the_light_8"
"Ability12"		"special_bonus_unique_keeper_of_the_light_illuminate_cooldown"
"Ability13"		"special_bonus_unique_keeper_of_the_light_7"
"Ability14"		"special_bonus_unique_keeper_of_the_light_13"
"Ability15"		"special_bonus_unique_keeper_of_the_light_11"
"Ability16"		"special_bonus_unique_keeper_of_the_light_14"
"Ability17"		"special_bonus_unique_keeper_of_the_light_10"
"Ability18"		"special_bonus_unique_keeper_of_the_light"

modifier_keeper_of_the_light_illuminate
modifier_keeper_of_the_light_spirit_form_illuminate
modifier_keeper_of_the_light_radiant_bind
modifier_blinding_light_knockback
modifier_keeper_of_the_light_blinding_light
modifier_bashed
modifier_keeper_of_the_light_will_o_wisp_aura
modifier_keeper_of_the_light_will_o_wisp
modifier_keeper_of_the_light_spirit_form
modifier_keeper_of_the_light_recall

--]]

local abilityQ = bot:GetAbilityByName( sAbilityList[1] )
local abilityW = bot:GetAbilityByName( sAbilityList[2] )
local abilityE = bot:GetAbilityByName( sAbilityList[3] )
local abilityD = bot:GetAbilityByName( sAbilityList[4] )
local abilityF = bot:GetAbilityByName( sAbilityList[5] )
local abilityR = bot:GetAbilityByName( sAbilityList[6] )
local abilityQEnd = bot:GetAbilityByName( sAbilityList[7] )
local abilityQ2 = bot:GetAbilityByName( sAbilityList[8] )
local abilityQ2End = bot:GetAbilityByName( sAbilityList[9] )
local abilityR2 = bot:GetAbilityByName( sAbilityList[10] )
local talent6 = bot:GetAbilityByName( sTalentList[6] )

local castQDesire, castQLocation
local castWDesire, castWTarget
local castEDesire, castETarget
local castDDesire, castDLocation
local castFDesire, castFLocation
local castRDesire
local castQEndDesire
local castQ2Desire, castQ2Location
local castQ2EndDesire
local castR2Desire, castR2Target

local nKeepMana, nMP, nHP, nLV, botTarget, hEnemyList, hAllyList, sMotive
local bonusRange = 0


function X.SkillsComplement()

	X.ConsiderCombo()

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
	if abilityR:IsTrained()
		and bot:HasModifier( 'modifier_keeper_of_the_light_spirit_form' )
	then
		bonusRange = bonusRange + abilityR:GetSpecialValueInt( 'cast_range' )
	else
		bonusRange = bonusRange
	end

	
	castRDesire, sMotive = X.ConsiderR()
	if castRDesire > 0
	then
		J.SetReportMotive( bDebugMode, sMotive )

		J.SetQueuePtToINT( bot, false )

		bot:ActionQueue_UseAbility( abilityR )
		return
	end
	
	castR2Desire, castR2Target, sMotive = X.ConsiderR2()
	if castR2Desire > 0
	then
		J.SetReportMotive( bDebugMode, sMotive )

		J.SetQueuePtToINT( bot, false )

		bot:ActionQueue_UseAbilityOnEntity( abilityR2, castR2Target )
		return
	end
	
	castWDesire, castWTarget, sMotive = X.ConsiderW()
	if castWDesire > 0
	then
		J.SetReportMotive( bDebugMode, sMotive )

		J.SetQueuePtToINT( bot, false )

		bot:ActionQueue_UseAbilityOnEntity( abilityW, castWTarget )
		return
	end
	
	castDDesire, castDLocation, sMotive = X.ConsiderD()
	if castDDesire > 0
	then
		J.SetReportMotive( bDebugMode, sMotive )

		J.SetQueuePtToINT( bot, false )

		bot:ActionQueue_UseAbilityOnLocation( abilityD, castDLocation )
		return
	end
	
	castFDesire, castFLocation, sMotive = X.ConsiderF()
	if castFDesire > 0
	then
		J.SetReportMotive( bDebugMode, sMotive )

		J.SetQueuePtToINT( bot, false )

		bot:ActionQueue_UseAbilityOnLocation( abilityF, castFLocation )
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
	
	castQEndDesire, sMotive = X.ConsiderQEnd()
	if castQEndDesire > 0
	then
		J.SetReportMotive( bDebugMode, sMotive )

		J.SetQueuePtToINT( bot, false )

		bot:ActionQueue_UseAbility( abilityQEnd )
		return
	end
	
	castQ2Desire, castQ2Location, sMotive = X.ConsiderQ2()
	if castQ2Desire > 0
	then
		J.SetReportMotive( bDebugMode, sMotive )

		J.SetQueuePtToINT( bot, false )

		bot:ActionQueue_UseAbilityOnLocation( abilityQ2, castQ2Location )
		return
	end
	
	castQ2EndDesire, sMotive = X.ConsiderQ2End()
	if castQ2EndDesire > 0
	then
		J.SetReportMotive( bDebugMode, sMotive )

		J.SetQueuePtToINT( bot, false )

		bot:ActionQueue_UseAbility( abilityQ2End )
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

	if not abilityQ:IsFullyCastable()
		or abilityQ:IsHidden()
	then
		return BOT_ACTION_DESIRE_NONE, nil
	end

	local nSkillLV = abilityQ:GetLevel()
	local nCastRange = abilityQ:GetCastRange() + bonusRange
	local nRadius = abilityQ:GetSpecialValueInt( 'radius' )
	local nCastPoint = abilityQ:GetCastPoint()
	local nManaCost = abilityQ:GetManaCost()
	local nDamage = abilityQ:GetSpecialValueInt( 'total_damage' )
	local nDamageType = DAMAGE_TYPE_MAGICAL
	local nAlliedHeroesInRange = bot:GetNearbyHeroes( nCastRange, false, BOT_MODE_NONE )
	local nEnemyHeroesInRange = bot:GetNearbyHeroes( nCastRange, true, BOT_MODE_NONE )
	local nTargetLocation = nil
	local nAoeLoc = nil


	if J.IsInTeamFight( bot, 1200 )
	then
		nAoeLoc = J.GetAoeEnemyHeroLocation( bot, nCastRange, nRadius, 2)
		if nAoeLoc ~= nil
		then
			nTargetLocation = nAoeLoc
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'Q-Battle'
		end
	end


	if J.IsLaning( bot )
	then
		nAoeLoc = J.GetAoeEnemyHeroLocation( bot, nCastRange, nRadius, 2 )
		if nAoeLoc ~= nil
		then
			nTargetLocation = nAoeLoc
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'Q-Harass'
		end

		if #hAllyList == 1
		then
			nAoeLoc = bot:FindAoELocation( true, false, bot:GetLocation(), nCastRange, nRadius, 3, nDamage )
			if nAoeLoc.count >= 3
			then
				nTargetLocation = nAoeLoc.targetloc
				return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "Q-ClearWave"..nAoeLoc.count
			end
		end
	end
	

	if ( J.IsPushing( bot ) or J.IsDefending( bot ) or J.IsFarming( bot ) )
		and DotaTime() > 8 * 60
	then
		local nEnemyCreeps = bot:GetNearbyLaneCreeps( nCastRange + nRadius, true )
		if #nEnemyCreeps >= 3
			and J.IsValid( nEnemyCreeps[1] )
			and not nEnemyCreeps[1]:HasModifier( "modifier_fountain_glyph" )
		then
			nTargetLocation = J.GetCastLocation( bot, nEnemyCreeps[1], nCastRange, nRadius )
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "Q-Push"
		end
	end

	
	if J.IsFarming( bot )
		and not ( J.IsPushing( bot ) or J.IsDefending( bot ) )
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
				nTargetLocation = J.GetCastLocation( bot, targetCreep, nCastRange, nRadius )
				return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "Q-Farm:"..( #nNeutralCreeps )
			end
		end
	end

	
	if bot:GetActiveMode() == BOT_MODE_ROSHAN
	then
		if J.IsRoshan( botTarget )
			and J.GetHP( botTarget ) > 0.15
			and J.IsInRange( botTarget, bot, nCastRange )
		then
			nTargetLocation = J.GetCastLocation( bot, botTarget, nCastRange, nRadius )
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'E-Roshan'
		end
	end



	return BOT_ACTION_DESIRE_NONE, nil


end

function X.ConsiderQEnd()

	return BOT_ACTION_DESIRE_NONE, nil

end

function X.ConsiderQ2()

	if not abilityQ2:IsFullyCastable()
		or abilityQ2:IsHidden()
	then
		return BOT_ACTION_DESIRE_NONE, nil
	end

	local nSkillLV = abilityQ2:GetLevel()
	local nCastRange = abilityQ2:GetCastRange() + bonusRange
	local nRadius = abilityQ2:GetSpecialValueInt( 'radius' )
	local nCastPoint = abilityQ2:GetCastPoint()
	local nManaCost = abilityQ2:GetManaCost()
	local nDamage = abilityQ2:GetSpecialValueInt( 'total_damage' )
	local nDamageType = DAMAGE_TYPE_MAGICAL
	local nAlliedHeroesInRange = bot:GetNearbyHeroes( nCastRange, false, BOT_MODE_NONE )
	local nEnemyHeroesInRange = bot:GetNearbyHeroes( nCastRange, true, BOT_MODE_NONE )
	local nTargetLocation = nil
	local nAoeLoc = nil


	if J.IsInTeamFight( bot, 1200 )
	then
		nAoeLoc = J.GetAoeEnemyHeroLocation( bot, nCastRange, nRadius, 2)
		if nAoeLoc ~= nil
		then
			nTargetLocation = nAoeLoc
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'Q-Battle'
		end
	end


	if J.IsRetreating( bot )
	then
		if bot:WasRecentlyDamagedByAnyHero( 2.5 )
			and #nEnemyHeroesInRange >= 1
		then
			nTargetLocation = bot:GetXUnitsInFront(400)
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'Q-Retreat:'
		end
	end


	if J.IsLaning( bot )
	then
		nAoeLoc = J.GetAoeEnemyHeroLocation( bot, nCastRange, nRadius, 2 )
		if nAoeLoc ~= nil
		then
			nTargetLocation = nAoeLoc
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'Q-Harass'
		end

		if #hAllyList == 1
		then
			nAoeLoc = bot:FindAoELocation( true, false, bot:GetLocation(), nCastRange, nRadius, 3, nDamage )
			if nAoeLoc.count >= 3
			then
				nTargetLocation = nAoeLoc.targetloc
				return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "Q-ClearWave"..nAoeLoc.count
			end
		end
	end
	

	if ( J.IsPushing( bot ) or J.IsDefending( bot ) or J.IsFarming( bot ) )
		and DotaTime() > 8 * 60
	then
		local nEnemyCreeps = bot:GetNearbyLaneCreeps( nCastRange + nRadius, true )
		if #nEnemyCreeps >= 3
			and J.IsValid( nEnemyCreeps[1] )
			and not nEnemyCreeps[1]:HasModifier( "modifier_fountain_glyph" )
		then
			nTargetLocation = J.GetCastLocation( bot, nEnemyCreeps[1], nCastRange, nRadius )
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "Q-Push"
		end
	end

	
	if J.IsFarming( bot )
		and not ( J.IsPushing( bot ) or J.IsDefending( bot ) )
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
				nTargetLocation = J.GetCastLocation( bot, targetCreep, nCastRange, nRadius )
				return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "Q-Farm:"..( #nNeutralCreeps )
			end
		end
	end

	
	if bot:GetActiveMode() == BOT_MODE_ROSHAN
	then
		if J.IsRoshan( botTarget )
			and J.GetHP( botTarget ) > 0.15
			and J.IsInRange( botTarget, bot, nCastRange )
		then
			nTargetLocation = J.GetCastLocation( bot, botTarget, nCastRange, nRadius )
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'E-Roshan'
		end
	end



	return BOT_ACTION_DESIRE_NONE, nil


end

function X.ConsiderQ2End()

	return BOT_ACTION_DESIRE_NONE, nil

end

function X.ConsiderW()

	if not abilityW:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end

	local nCastRange = abilityW:GetCastRange() + bonusRange
	local nCastPoint = abilityW:GetCastPoint()
	local nEnemyHeroesInRange = bot:GetNearbyHeroes( nCastRange, true, BOT_MODE_NONE )


	if J.IsInTeamFight( bot, 1200 )
	then
		for _, npcEnemy in pairs( nEnemyHeroesInRange )
		do
			if J.CanCastOnNonMagicImmune( npcEnemy )
				and J.CanCastOnTargetAdvanced( npcEnemy )
				and not npcEnemy:HasModifier( 'modifier_keeper_of_the_light_radiant_bind' )
			then
				return BOT_ACTION_DESIRE_HIGH, npcEnemy, 'W-Battle-Weakest:'..J.Chat.GetNormName( npcEnemy )
			end
		end
	end


	if J.IsGoingOnSomeone( bot )
	then
		if J.IsValidHero( botTarget )
			and J.CanCastOnNonMagicImmune( botTarget )
			and J.CanCastOnTargetAdvanced( botTarget )
		then
			return BOT_ACTION_DESIRE_HIGH, botTarget, 'W-Attack:'..J.Chat.GetNormName( botTarget )
		end
	end
	

	if J.IsRetreating( bot )
	then
		for _, npcEnemy in pairs( nEnemyHeroesInRange )
		do
			if bot:WasRecentlyDamagedByHero( npcEnemy, 5.0 )
				and J.CanCastOnNonMagicImmune( npcEnemy )
				and bot:IsFacingLocation( npcEnemy:GetExtrapolatedLocation( nCastPoint ), 20 )
			then
				return BOT_ACTION_DESIRE_HIGH, npcEnemy, 'W-Retreat:'..J.Chat.GetNormName( npcEnemy )
			end
		end
	end


	return BOT_ACTION_DESIRE_NONE, nil

end

function X.ConsiderE()

	if not abilityE:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end

	local nSkillLV = abilityE:GetLevel()
	local nCastRange = abilityE:GetCastRange() + bonusRange
	local nCastPoint = abilityE:GetCastPoint()
	local nManaRestored = abilityE:GetSpecialValueInt( 'mana_restore' )
	local nAlliedHeroesInRange = bot:GetNearbyHeroes( nCastRange, false, BOT_MODE_NONE )

	
	local npcLowestManaAlly = nil
	local npcLowestManaAllyManaPct = 1
	for _, npcAlly in pairs ( nAlliedHeroesInRange )
	do
		if talent6:IsTrained()
			and J.ShouldDispelDebuff( npcAlly )
		then
			return BOT_ACTION_DESIRE_HIGH, npcAlly, "E-Dispel:"..J.Chat.GetNormName( npcAlly )
		end


		if J.CanCastOnMagicImmune( npcAlly )
			and J.GetMP( npcAlly ) <= npcLowestManaAllyManaPct
			and npcAlly:GetMaxMana() - npcAlly:GetMana() > nManaRestored
		then
			npcLowestManaAlly = npcAlly
			npcLowestManaAllyManaPct = J.GetMP( npcAlly )
		end
	end

	if npcLowestManaAlly ~= nil
	then
		return BOT_ACTION_DESIRE_HIGH, npcLowestManaAlly, "E-Restore:"..J.Chat.GetNormName( npcLowestManaAlly )
	end


	return BOT_ACTION_DESIRE_NONE, nil

end

function X.ConsiderD()
	
	if not abilityD:IsFullyCastable()
		or abilityD:IsHidden()
	then
		return BOT_ACTION_DESIRE_NONE, nil
	end

	local nSkillLV = abilityD:GetLevel()
	local nCastRange = abilityD:GetCastRange() + bonusRange
	local nRadius = abilityD:GetSpecialValueInt( 'radius' )
	local nCastPoint = abilityD:GetCastPoint()
	local nManaCost = abilityD:GetManaCost()
	local nEnemyHeroesInRange = bot:GetNearbyHeroes( nCastRange, true, BOT_MODE_NONE )
	local nTargetLocation = nil
	local nAoeLoc = nil


	if J.IsInTeamFight( bot, 1200 )
	then
		nAoeLoc = J.GetAoeEnemyHeroLocation( bot, nCastRange, nRadius, 2)
		if nAoeLoc ~= nil
		then
			nTargetLocation = nAoeLoc
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'D-Battle'
		end
	end


	if J.IsRetreating( bot )
	then
		local enemyHeroList = bot:GetNearbyHeroes( nRadius, true, BOT_MODE_NONE )
		local targetHero = enemyHeroList[1]
		if J.IsValidHero( targetHero )
			and J.CanCastOnNonMagicImmune( targetHero )
		then
			return BOT_ACTION_DESIRE_HIGH, targetHero:GetExtrapolatedLocation( 1.0 ), 'D-Retreat'
		end
	end


	if J.IsGoingOnSomeone( bot )
	then
		if J.IsValidHero( botTarget )
			and J.IsInRange( botTarget, bot, nCastRange )
			and J.CanCastOnNonMagicImmune( botTarget )
		then
			return BOT_ACTION_DESIRE_HIGH, botTarget:GetExtrapolatedLocation( 1.0 ), "D-Chase:"..J.Chat.GetNormName( botTarget )
		end
	end


	return BOT_ACTION_DESIRE_NONE, nil

end

function X.ConsiderF()
	
	if not abilityF:IsFullyCastable()
		or abilityF:IsHidden()
		or not bot:HasScepter()
	then
		return BOT_ACTION_DESIRE_NONE, nil
	end

	local nSkillLV = abilityF:GetLevel()
	local nCastRange = abilityF:GetCastRange() + bonusRange
	local nRadius = abilityF:GetSpecialValueInt( 'radius' )
	local nCastPoint = abilityF:GetCastPoint()
	local nManaCost = abilityF:GetManaCost()
	local nEnemyHeroesInRange = bot:GetNearbyHeroes( nCastRange, true, BOT_MODE_NONE )
	local nTargetLocation = nil
	local nAoeLoc = nil


	if J.IsInTeamFight( bot, 1200 )
	then
		nAoeLoc = J.GetAoeEnemyHeroLocation( bot, nCastRange, nRadius, 2)
		if nAoeLoc ~= nil
		then
			nTargetLocation = nAoeLoc
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'F-Battle'
		end
	end


	if J.IsRetreating( bot )
	then
		local enemyHeroList = bot:GetNearbyHeroes( nRadius, true, BOT_MODE_NONE )
		local targetHero = enemyHeroList[1]
		if J.IsValidHero( targetHero )
			and J.CanCastOnNonMagicImmune( targetHero )
			and not targetHero:HasModifier( 'modifier_keeper_of_the_light_blinding_light' )
			and not targetHero:HasModifier( 'modifier_keeper_of_the_light_radiant_bind' )
		then
			return BOT_ACTION_DESIRE_HIGH, bot:GetLocation(), 'F-Retreat'
		end
	end


	if J.IsGoingOnSomeone( bot )
	then
		if J.IsValidHero( botTarget )
			and J.IsInRange( botTarget, bot, nCastRange )
			and J.CanCastOnNonMagicImmune( botTarget )
			and not botTarget:HasModifier( 'modifier_keeper_of_the_light_blinding_light' )
			and not botTarget:HasModifier( 'modifier_keeper_of_the_light_radiant_bind' )
		then
			return BOT_ACTION_DESIRE_HIGH, botTarget:GetLocation(), "F-Chase:"..J.Chat.GetNormName( botTarget )
		end
	end


	return BOT_ACTION_DESIRE_NONE, nil

end

function X.ConsiderR()
	
	if not abilityR:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end


	if J.IsInTeamFight( bot, 1200 )
	then
		return BOT_ACTION_DESIRE_HIGH, "R-Battle"
	end


	if J.IsGoingOnSomeone( bot )
	then
		if J.IsValidHero( botTarget )
			and J.IsInRange( botTarget, bot, 700 )
		then
			return BOT_ACTION_DESIRE_HIGH, "R-Chase:"..J.Chat.GetNormName( botTarget )
		end
	end


	return BOT_ACTION_DESIRE_NONE, nil

end

function X.ConsiderR2()
	
	if not abilityR2:IsFullyCastable()
		or abilityR2:IsHidden()
		or not abilityR2:IsTrained()
	then
		return BOT_ACTION_DESIRE_NONE, nil
	end

	local nAlliedHeroesInRange = bot:GetNearbyHeroes( 1200, false, BOT_MODE_NONE )

	
	local npcFurthestAlly = nil
	local npcFurthestAllyDistance = 0
	local numPlayer = GetTeamPlayers( GetTeam() )
	for i = 1, #numPlayer
	do
		local npcAlly = GetTeamMember( i )

		if J.IsValidHero( npcAlly )
			and J.CanCastOnMagicImmune( npcAlly )
			and npcAlly ~= bot
			and GetUnitToUnitDistance( bot, npcAlly ) >= 1800
			and GetUnitToUnitDistance( bot, npcAlly ) >= npcFurthestAllyDistance
		then
			npcFurthestAlly = npcAlly
			npcFurthestAllyDistance = GetUnitToUnitDistance( bot, npcAlly )
		end

		if J.IsValidHero( npcAlly )
			and J.CanCastOnMagicImmune( npcAlly )
			and GetUnitToUnitDistance( bot, npcAlly ) >= 1800
			and npcAlly ~= bot
			and J.IsRetreating( npcAlly )
			and npcAlly:WasRecentlyDamagedByAnyHero( 2.0 )
		then
			return BOT_ACTION_DESIRE_HIGH, npcAlly, 'R-Save:'..J.Chat.GetNormName( npcAlly )
		end
	end


	if #nAlliedHeroesInRange >= 2
		and ( J.IsInTeamFight( bot, 1200 )
			or J.IsPushing( bot )
			or J.IsDefending( bot ) )
	then
		return BOT_ACTION_DESIRE_HIGH, npcFurthestAlly, 'R-Recall:'..J.Chat.GetNormName( npcFurthestAlly )
	end


	return BOT_ACTION_DESIRE_NONE, nil

end

function X.ConsiderCombo()
	if bot:IsAlive()
		and not bot:IsInvisible()
		and botTarget ~= nil
		and botTarget:HasModifier( 'modifier_keeper_of_the_light_radiant_bind' )
	then
		local item = J.IsItemAvailable( 'item_ethereal_blade' )
		if item ~= nil
			and item:IsFullyCastable()
		then
			bot:Action_UseAbilityOnEntity( item, botTarget )
		end
		
		item = J.IsItemAvailable( 'item_dagon' )
		if item ~= nil
			and item:IsFullyCastable()
		then
			bot:Action_UseAbilityOnEntity( item, botTarget )
		end
		
		item = J.IsItemAvailable( 'item_dagon_2' )
		if item ~= nil
			and item:IsFullyCastable()
		then
			bot:Action_UseAbilityOnEntity( item, botTarget )
		end
		
		item = J.IsItemAvailable( 'item_dagon_3' )
		if item ~= nil
			and item:IsFullyCastable()
		then
			bot:Action_UseAbilityOnEntity( item, botTarget )
		end
		
		item = J.IsItemAvailable( 'item_dagon_4' )
		if item ~= nil
			and item:IsFullyCastable()
		then
			bot:Action_UseAbilityOnEntity( item, botTarget )
		end
		
		item = J.IsItemAvailable( 'item_dagon_5' )
		if item ~= nil
			and item:IsFullyCastable()
		then
			bot:Action_UseAbilityOnEntity( item, botTarget )
		end

		return
	end
end

return X