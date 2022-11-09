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
	"item_magic_wand",

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

	if Minion.IsValidUnit( hMinionUnit )
	then
		Minion.IllusionThink( hMinionUnit )
	end

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
local talent4 = bot:GetAbilityByName( sTalentList[4] )
local talent8 = bot:GetAbilityByName( sTalentList[8] )

local castQDesire, castQLocation
local castWDesire, castWLocation
local castDDesire
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

	
	castDDesire, sMotive = X.ConsiderD()
	if castDDesire > 0
	then
		J.SetReportMotive( bDebugMode, sMotive )

		J.SetQueuePtToINT( bot, true )

		bot:ActionQueue_UseAbility( abilityD )
		return
	end

	castWDesire, castWLocation, sMotive = X.ConsiderW()
	if ( castWDesire > 0 )
	then
		J.SetReportMotive( bDebugMode, sMotive )

		J.SetQueuePtToINT( bot, true )

		bot:ActionQueue_UseAbilityOnLocation( abilityW, castWLocation )
		return
	end
	
	castQDesire, castQLocation, sMotive = X.ConsiderQ()
	if ( castQDesire > 0 )
	then
		J.SetReportMotive( bDebugMode, sMotive )

		J.SetQueuePtToINT( bot, true )

		bot:ActionQueue_UseAbilityOnLocation( abilityQ, castQLocation )
		return
	end

	castRDesire, castRTarget, sMotive = X.ConsiderR()
	if ( castRDesire > 0 )
	then
		J.SetReportMotive( bDebugMode, sMotive )

		J.SetQueuePtToINT( bot, true )

		bot:ActionQueue_UseAbilityOnEntity( abilityR, castRTarget )
		return

	end

end


function X.ConsiderQ()

	if not abilityQ:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end

	local nSkillLV = abilityQ:GetLevel()
	local nCastRange = abilityQ:GetCastRange() + bonusRange
	local nRadius = abilityQ:GetSpecialValueInt( "dragon_slave_width_end" )
	local nCastPoint = abilityQ:GetCastPoint()
	local nManaCost = abilityQ:GetManaCost()
	local nDamage = abilityQ:GetSpecialValueInt( "AbilityDamage" )
	local nDamageType = DAMAGE_TYPE_MAGICAL
	local nEnemyHeroesInRange = bot:GetNearbyHeroes( nCastRange + nRadius, true, BOT_MODE_NONE )
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
		
		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.IsInRange( npcEnemy, bot, nCastRange + nRadius )
			and J.IsHealing( npcEnemy )
		then
			nTargetLocation = botTarget:GetExtrapolatedLocation( nCastPoint )
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'Q-DispelHeal:'..J.Chat.GetNormName( npcEnemy )
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
		nAoeLoc = J.GetAoeEnemyHeroLocation( bot, nCastRange, nRadius, 2 )
		if nAoeLoc ~= nil
			and nMP > 0.58
		then
			nTargetLocation = nAoeLoc
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'Q-Harass'
		end

		if #hAllyList == 1
			and #nEnemyHeroesInRange == 1
			and nMP > 0.48
		then
			nAoeLoc = J.GetAoeEnemyHeroLocation( bot, nCastRange, nRadius, 1 )
			if nAoeLoc ~= nil
			then
				nTargetLocation = nAoeLoc
				return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "Q-Harass"
			end
		end

		if #hAllyList == 1 and nMP > 0.38
		then
			local locationAoEKill = bot:FindAoELocation( true, false, bot:GetLocation(), nCastRange, nRadius, 0, 0 )
			if locationAoEKill.count >= 3
			then
				nTargetLocation = locationAoEKill.targetloc
				return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "Q-ClearWave:"..locationAoEKill.count
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
			local locationAoEKill = bot:FindAoELocation( true, false, bot:GetLocation(), nCastRange, nRadius, 0, 0 )
			if locationAoEKill.count >= 2
			then
				nTargetLocation = locationAoEKill.targetloc
				return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "Q-ClearWave:"..locationAoEKill.count
			end
			
			local locationAoEHurt = bot:FindAoELocation( true, false, bot:GetLocation(), nCastRange, nRadius, 0, nDamage )
			if ( locationAoEHurt.count >= 3 and #nEnemyCreeps >= 4 )
			then
				nTargetLocation = locationAoEHurt.targetloc
				return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "Q-Push:"..locationAoEHurt.count
			end
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
		if #nNeutralCreeps >= 3 or nMP >= 0.7
		then
			local targetCreep = nNeutralCreeps[1]
			if J.IsValid( targetCreep )
				and targetCreep:GetHealth() >= 500
				and J.GetAroundTargetEnemyUnitCount( targetCreep, 300 ) >= 1
			then
				nTargetLocation = targetCreep:GetExtrapolatedLocation( nCastPoint )
				return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "Q-Farm:"..( #nNeutralCreeps )
			end
		end
	end

	
	if J.IsDefending( bot )
	then
		nAoeLoc = J.GetAoeEnemyHeroLocation( bot, nCastRange, nRadius, 1 )
		if nAoeLoc ~= nil
		then
			nTargetLocation = nAoeLoc
			return BOT_ACTION_DESIRE_VERYHIGH, nTargetLocation, 'Q-Defend'
		end
	end

	
	if bot:GetActiveMode() == BOT_MODE_ROSHAN
		and bot:GetMana() >= 400
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

function X.ConsiderW()

	if not abilityW:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end

	local nSkillLV = abilityW:GetLevel()
	local nCastRange = abilityW:GetCastRange() + bonusRange
	local nRadius = abilityW:GetSpecialValueInt( "light_strike_array_aoe" )
	local nCastPoint = abilityW:GetCastPoint()
	local nCastDelay = 0.5
	local nManaCost = abilityW:GetManaCost()
	local nDamage = abilityW:GetSpecialValueInt( 'light_strike_array_damage' )
	local nDamageType = DAMAGE_TYPE_MAGICAL
	local nEnemyHeroesInRange = bot:GetNearbyHeroes( nCastRange + nRadius, true, BOT_MODE_NONE )
	local nTargetLocation = nil

	if talent4:IsTrained() then nDamage = nDamage + talent4:GetSpecialValueInt( "value" ) end


	for _, npcEnemy in pairs( nEnemyHeroesInRange )
	do
		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and ( npcEnemy:IsChanneling() or npcEnemy:IsCastingAbility() )
		then
			nTargetLocation = J.GetDelayCastLocation( bot, npcEnemy, nCastRange, nRadius, nCastPoint + nCastDelay )
			if nTargetLocation ~= nil
			then
				return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "W-Interrupt:"..J.Chat.GetNormName( npcEnemy )
			end
		end

		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.WillMagicKillTarget( bot, npcEnemy, nDamage, nCastPoint + nCastDelay )
		then
			nTargetLocation = J.GetDelayCastLocation( bot, npcEnemy, nCastRange, nRadius, nCastPoint + nCastDelay )
			if nTargetLocation ~= nil
			then
				return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "W-Kill:"..J.Chat.GetNormName( npcEnemy )
			end
		end

		if J.IsValidHero( npcEnemy )
			and J.IsInRange( botTarget, bot, nCastRange + nRadius )
			and ( ( botTarget:HasModifier( 'modifier_obsidian_destroyer_astral_imprisonment_prison' )
					and J.GetModifierTime( botTarget, 'modifier_obsidian_destroyer_astral_imprisonment_prison' ) < nCastPoint + nCastDelay
					and J.GetModifierTime( botTarget, 'modifier_obsidian_destroyer_astral_imprisonment_prison' ) >= ( nCastPoint + nCastDelay - 0.5 )
				)
				or (
					botTarget:HasModifier( 'modifier_shadow_demon_disruption' )
					and J.GetModifierTime( botTarget, 'modifier_shadow_demon_disruption' ) < nCastPoint + nCastDelay
					and J.GetModifierTime( botTarget, 'modifier_shadow_demon_disruption' ) >= ( nCastPoint + nCastDelay - 0.5 )
				)
				or (
					botTarget:HasModifier( 'modifier_wind_waker' )
					and J.GetModifierTime( botTarget, 'modifier_wind_waker' ) < nCastPoint + nCastDelay
					and J.GetModifierTime( botTarget, 'modifier_wind_waker' ) >= ( nCastPoint + nCastDelay - 0.5 )
				)
				or (
					botTarget:HasModifier( 'modifier_eul_cyclone' )
					and J.GetModifierTime( botTarget, 'modifier_eul_cyclone' ) < nCastPoint + nCastDelay
					and J.GetModifierTime( botTarget, 'modifier_eul_cyclone' ) >= ( nCastPoint + nCastDelay - 0.5 )
				)
				or (
					botTarget:HasModifier( 'modifier_invoker_tornado' )
					and J.GetModifierTime( botTarget, 'modifier_invoker_tornado' ) < nCastPoint + nCastDelay
					and J.GetModifierTime( botTarget, 'modifier_invoker_tornado' ) >= ( nCastPoint + nCastDelay - 0.5 )
				)
			)
		then
			nTargetLocation = J.GetCastLocation( bot, botTarget, nCastRange, nRadius )
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "W-ChainStun:"..J.Chat.GetNormName( npcEnemy )
		end
	end
	
	
	local nAoeLoc = J.GetAoeEnemyHeroLocation( bot, nCastRange, nRadius, 2 )
	if nAoeLoc ~= nil and bot:GetActiveMode() ~= BOT_MODE_RETREAT
	then
		nTargetLocation = nAoeLoc
		return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'W-Harass'
	end
	

	if J.IsInTeamFight( bot, 1200 )
	then
		nAoeLoc = J.GetAoeEnemyHeroLocation( bot, nCastRange, nRadius, 2 )
		if nAoeLoc ~= nil
		then
			nTargetLocation = nAoeLoc
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'W-Battle'
		end
	end


	if J.IsGoingOnSomeone( bot )
	then
		if J.IsValidHero( botTarget )
			and J.CanCastOnNonMagicImmune( botTarget )
			and J.IsInRange( botTarget, bot, nCastRange )
		then
			nTargetLocation = J.GetDelayCastLocation( bot, botTarget, nCastRange, nRadius, nCastPoint + nCastDelay )
			if nTargetLocation ~= nil
			then
				return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'Q-Attack:'..J.Chat.GetNormName( botTarget )
			end
		end
	end


	if J.IsRetreating( bot )
	then
		nAoeLoc = J.GetAoeEnemyHeroLocation( bot, nCastRange, nRadius, 2 )
		if nAoeLoc ~= nil
		then
			nTargetLocation = nAoeLoc
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'W-Retreat'
		end

		for _, npcEnemy in pairs( nEnemyHeroesInRange )
		do
			if J.IsValidHero( npcEnemy )
				and bot:WasRecentlyDamagedByHero( npcEnemy, 5.0 )
				and J.CanCastOnNonMagicImmune( npcEnemy )
				and bot:IsFacingLocation( npcEnemy:GetExtrapolatedLocation( nCastPoint ), 20 )
			then
				nTargetLocation = J.GetDelayCastLocation( bot, npcEnemy, nCastRange, nRadius, nCastPoint + nCastDelay )
				return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'W-Retreat:'..J.Chat.GetNormName( npcEnemy )
			end
		end
	end

	
	if J.IsLaning( bot )
	then
		nAoeLoc = J.GetAoeEnemyHeroLocation( bot, nCastRange, nRadius, 2 )
		if nAoeLoc ~= nil and nMP > 0.58
		then
			nTargetLocation = nAoeLoc
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'W-Harass'
		end

		if #hAllyList == 1 and nMP > 0.38
		then
			local locationAoEKill = bot:FindAoELocation( true, false, bot:GetLocation(), nCastRange, nRadius, 0, 0 )
			if locationAoEKill.count >= 3
			then
				nTargetLocation = locationAoEKill.targetloc
				return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "W-ClearWave:"..locationAoEKill.count
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
			local locationAoEKill = bot:FindAoELocation( true, false, bot:GetLocation(), nCastRange, nRadius, 0, 0 )
			if locationAoEKill.count >= 2
			then
				nTargetLocation = locationAoEKill.targetloc
				return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "W-ClearWave:"..locationAoEKill.count
			end
			
			local locationAoEHurt = bot:FindAoELocation( true, false, bot:GetLocation(), nCastRange, nRadius, 0, nDamage )
			if ( locationAoEHurt.count >= 3 and #nEnemyCreeps >= 4 )
			then
				nTargetLocation = locationAoEHurt.targetloc
				return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "W-Push:"..locationAoEHurt.count
			end
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
		if #nNeutralCreeps >= 3 or nMP >= 0.7
		then
			local targetCreep = nNeutralCreeps[1]
			if J.IsValid( targetCreep )
				and targetCreep:GetHealth() >= 500
				and J.GetAroundTargetEnemyUnitCount( targetCreep, 300 ) >= 1
			then
				nTargetLocation = targetCreep:GetExtrapolatedLocation( nCastPoint )
				return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "W-Farm:"..( #nNeutralCreeps )
			end
		end
	end

	
	if J.IsDefending( bot )
	then
		nAoeLoc = J.GetAoeEnemyHeroLocation( bot, nCastRange, nRadius, 1 )
		if nAoeLoc ~= nil
		then
			nTargetLocation = nAoeLoc
			return BOT_ACTION_DESIRE_VERYHIGH, nTargetLocation, 'W-Defend'
		end
	end

	
	if bot:GetActiveMode() == BOT_MODE_ROSHAN
		and bot:GetMana() >= 400
	then
		if J.IsRoshan( botTarget ) and J.GetHP( botTarget ) > 0.15
			and J.IsInRange( botTarget, bot, nCastRange )
		then
			nTargetLocation = botTarget:GetLocation()
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'W-Roshan'
		end
	end


	return BOT_ACTION_DESIRE_NONE, nil

end

function X.ConsiderD()
	
	if not abilityD:IsFullyCastable()
		or not bot:HasScepter()
	then
		return BOT_ACTION_DESIRE_NONE, nil
	end


	if J.IsInTeamFight( bot, 1200 )
	then
		if #hEnemyList >= #hAllyList
		then
			return BOT_ACTION_DESIRE_HIGH, "D-Battle"
		end
	end


	if J.IsGoingOnSomeone( bot )
	then
		if J.IsValidHero( botTarget )
			and J.IsInRange( botTarget, bot, 700 )
			and J.CanCastOnNonMagicImmune( botTarget )
		then
			return BOT_ACTION_DESIRE_HIGH, "D-Chase:"..J.Chat.GetNormName( botTarget )
		end
	end


	return BOT_ACTION_DESIRE_NONE, nil

end

function X.ConsiderR()

	if not abilityR:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end

	local nSkillLV = abilityR:GetLevel()
	local nCastRange = abilityR:GetCastRange() + bonusRange
	local nCastPoint = abilityR:GetCastPoint()
	local nManaCost = abilityR:GetManaCost()
	local nDamage = abilityR:GetSpecialValueInt( "damage" )
	local nDamageType = talent8:IsTrained() and DAMAGE_TYPE_PURE or DAMAGE_TYPE_MAGICAL
	local nEnemyHeroesInRange = bot:GetNearbyHeroes( nCastRange, true, BOT_MODE_NONE )

	
	for _, npcEnemy in pairs( nEnemyHeroesInRange )
	do
		if J.IsValidHero( npcEnemy )
			and X.CanCastAbilityROnTarget( npcEnemy )
			and not J.IsHaveAegis( npcEnemy )
		then
			if ( nDamageType == DAMAGE_TYPE_MAGICAL
					and J.WillMagicKillTarget( bot, npcEnemy, nDamage, nCastPoint ) )
				or J.WillKillTarget( npcEnemy, nDamage, nDamageType, nCastPoint )
			then
				return BOT_ACTION_DESIRE_HIGH, npcEnemy, 'R-Kill'..J.Chat.GetNormName( npcEnemy )
			end
		end
	end
	
	
	if J.IsGoingOnSomeone( bot )
	then
		if J.IsValidHero( botTarget )
			and X.CanCastAbilityROnTarget( botTarget )
			and J.IsInRange( botTarget, bot, nCastRange )
			and J.WillMagicKillTarget( bot, botTarget, nDamage * 1.88, nCastPoint + 0.25 )
		then
			return BOT_ACTION_DESIRE_HIGH, botTarget, "R-Attack"..J.Chat.GetNormName( botTarget )
		end
	end
	

	if J.IsInTeamFight( bot, 1200 )
		or ( nHP < 0.3 and nSkillLV >= 2 )
	then
		local npcWeakestEnemy = nil
		local npcWeakestEnemyHealth = 10000
		for _, npcEnemy in pairs( nEnemyHeroesInRange )
		do
			if J.IsValidHero( npcEnemy )
				and X.CanCastAbilityROnTarget( npcEnemy )
				and npcEnemy:GetHealth() < npcWeakestEnemyHealth
			then
				npcWeakestEnemyHealth = npcEnemy:GetHealth()
				npcWeakestEnemy = npcEnemy
			end
		end

		if ( npcWeakestEnemy ~= nil )
		then
			return BOT_ACTION_DESIRE_HIGH, npcWeakestEnemy, 'R-Battle'..J.Chat.GetNormName( npcWeakestEnemy )
		end
	end


	return BOT_ACTION_DESIRE_NONE, nil

end

function X.CanCastAbilityROnTarget( nTarget )

	if J.CanCastOnTargetAdvanced( nTarget )
		and not nTarget:HasModifier( "modifier_arc_warden_tempest_double" )
	then
		if talent8:IsTrained()
		then
			return J.CanCastOnMagicImmune( nTarget )
		else
			return J.CanCastOnNonMagicImmune( nTarget )
		end
	end

	return false

end

return X