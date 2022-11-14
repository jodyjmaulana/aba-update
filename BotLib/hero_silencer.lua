----------------------------------------------------------------------------------------------------
--- The Creation Come From: BOT EXPERIMENT Credit:FURIOUSPUPPY
--- BOT EXPERIMENT Author: Arizona Fauzie 2018.11.21
--- Link:http://steamcommunity.com/sharedfiles/filedetails/?id=837040016
--- Refactor: 决明子 Email: dota2jmz@163.com 微博@Dota2_决明子
--- Link:http://steamcommunity.com/sharedfiles/filedetails/?id=1573671599
--- Link:http://steamcommunity.com/sharedfiles/filedetails/?id=1627071163
--- Updated: Nikel
--- mid, carry, mage, priest
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
		['t20'] = {0, 10},
		['t15'] = {10, 0},
		['t10'] = {10, 0},
	},

	['outfit_mid'] = {
		['t25'] = {0, 10},
		['t20'] = {0, 10},
		['t15'] = {10, 0},
		['t10'] = {10, 0},
	},

	['outfit_priest'] = {
		['t25'] = {10, 0},
		['t20'] = {10, 0},
		['t15'] = {0, 10},
		['t10'] = {0, 10},
	},

	['outfit_mage'] = {
		['t25'] = {10, 0},
		['t20'] = {10, 0},
		['t15'] = {0, 10},
		['t10'] = {0, 10},
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
		{2,1,1,3,1,6,1,3,3,3,6,2,2,2,6}
	},

	['outfit_mid'] = {
		{2,1,1,3,1,6,1,3,3,3,6,2,2,2,6}
	},

	['outfit_priest'] = {
		{1,2,1,3,1,6,1,3,3,3,6,2,2,2,6}
	},

	['outfit_mage'] = {
		{1,2,1,3,1,6,1,3,3,3,6,2,2,2,6}
	},

	['outfit_tank'] = {
		{1,2,1,3,1,6,1,3,3,3,6,2,2,2,6}
	},
}

local nAbilityBuildList = J.Skill.GetRandomBuild( tAllAbilityBuildList[sOutfitType] )

local nTalentBuildList = J.Skill.GetTalentBuild( tTalentTreeList[sOutfitType] )

local sRandomItem = RandomInt( 1, 9 ) > 6 and 0 or 10
local sRandomItem_A1 = sRandomItem == 0 and "item_orchid" or "item_force_staff"
local sRandomItem_A2 = sRandomItem == 0 and "item_bloodthorn" or "item_hurricane_pike"

sRandomItem = RandomInt( 1, 9 ) > 6 and 0 or 10
local sRandomItem_B = sRandomItem == 0 and "item_ethereal_blade" or "item_yasha_and_kaya"

sRandomItem = RandomInt( 1, 9 ) > 6 and 0 or 10
local sRandomItem_C = sRandomItem == 0 and "item_sheepstick" or "item_nullifier"

sRandomItem = RandomInt( 1, 9 ) > 6 and 0 or 10
local sRandomItem_D = sRandomItem == 0 and "item_refresher" or "item_shivas_guard"

local tOutFitList = {}

tOutFitList['outfit_carry'] = {

	"item_mid_silencer_outfit",
	"item_witch_blade",
	"item_aghanims_shard",
	"item_ultimate_scepter",
	"item_invis_sword",
	sRandomItem_A1,
	"item_kaya",
	"item_silver_edge",
	sRandomItem_A2,
	sRandomItem_B,
	"item_travel_boots",
	"item_ultimate_scepter_2",
	sRandomItem_C,
	"item_revenants_brooch",
	"item_moon_shard",
	"item_travel_boots_2",

}

tOutFitList['outfit_mid'] = tOutFitList['outfit_carry']

tOutFitList['outfit_priest'] = {

	"item_mage_lina_outfit",
	"item_veil_of_discord",
	"item_ultimate_scepter",
	"item_aghanims_shard",
	"item_aeon_disk",
	"item_force_staff",
	"item_refresher",
	"item_guardian_greaves",
	"item_hurricane_pike",
	"item_ultimate_scepter_2",
	"item_cyclone",
	"item_wind_waker",
	"item_moon_shard",

}

tOutFitList['outfit_mage'] = {

	"item_mage_silencer_outfit",
	"item_veil_of_discord",
	"item_ultimate_scepter",
	"item_aghanims_shard",
	"item_aether_lens",
	sRandomItem_A1,
	sRandomItem_D,
	"item_octarine_core",
	sRandomItem_A2,
	"item_travel_boots",
	"item_ultimate_scepter_2",
	sRandomItem_C,
	"item_moon_shard",
	"item_travel_boots_2",

}

tOutFitList['outfit_tank'] = tOutFitList['outfit_mage']

X['sBuyList'] = tOutFitList[sOutfitType]

X['sSellList'] = {
	"item_orchid",
	"item_magic_wand",
	
	"item_force_staff",
	"item_magic_wand",

	"item_kaya",
	"item_null_talisman",
	
	"item_travel_boots",
	"item_power_treads",
}

if J.Role.IsPvNMode() or J.Role.IsAllShadow() then X['sBuyList'], X['sSellList'] = { 'PvN_priest' }, {} end

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

npc_dota_hero_abaddon

"Ability1"		"silencer_curse_of_the_silent"
"Ability2"		"silencer_glaives_of_wisdom"
"Ability3"		"silencer_last_word"
"Ability4"		"generic_hidden"
"Ability5"		"generic_hidden"
"Ability6"		"silencer_global_silence"
"Ability10"		"special_bonus_unique_silencer"
"Ability11"		"special_bonus_attack_speed_20"
"Ability12"		"special_bonus_unique_silencer_7"
"Ability13"		"special_bonus_unique_silencer_4"
"Ability14"		"special_bonus_unique_silencer_3"
"Ability15"		"special_bonus_unique_silencer_arcane_curse_undispellable"
"Ability16"		"special_bonus_unique_silencer_glaives_bounces"
"Ability17"		"special_bonus_unique_silencer_2"

modifier_silencer_curse_of_the_silent
modifier_silencer_glaives_of_wisdom
modifier_silencer_glaives_of_wisdom_buff
modifier_silencer_glaives_of_wisdom_buff_counter
modifier_silencer_glaives_of_wisdom_attack_counter
modifier_silencer_glaives_of_wisdom_debuff
modifier_silencer_glaives_of_wisdom_debuff_counter
modifier_silencer_last_word
modifier_silencer_last_word_disarm
modifier_silencer_global_silence

--]]

local abilityQ = bot:GetAbilityByName( sAbilityList[1] )
local abilityW = bot:GetAbilityByName( sAbilityList[2] )
local abilityE = bot:GetAbilityByName( sAbilityList[3] )
local abilityR = bot:GetAbilityByName( sAbilityList[6] )
local talent1 = bot:GetAbilityByName( sTalentList[1] )
local talent4 = bot:GetAbilityByName( sTalentList[4] )
local talent5 = bot:GetAbilityByName( sTalentList[5] )

local castQDesire, castQLocation
local castWDesire, castWTarget
local castEDesire, castETargetLocation
local castRDesire

local nKeepMana, nMP, nHP, nLV, botTarget, hEnemyList, hAllyList, sMotive
local bonusRange = 0

local ultTime = 0
local ultDuration = 0


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
		ultTime = DotaTime()
		ultDuration = abilityR:GetDuration()
		return
	end
	
	castEDesire, castETargetLocation, sMotive = X.ConsiderE()
	if castEDesire > 0
	then
		J.SetReportMotive( bDebugMode, sMotive )

		J.SetQueuePtToINT( bot, false )

		if bot:HasScepter()
		then
			bot:ActionQueue_UseAbilityOnLocation( abilityE, castETargetLocation )
		else
			bot:ActionQueue_UseAbilityOnEntity( abilityE, castETargetLocation )
		end

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

	castWDesire, castWTarget, sMotive = X.ConsiderW()
	if castWDesire > 0
	then
		J.SetReportMotive( bDebugMode, sMotive )

		J.SetQueuePtToINT( bot, false )

		bot:ActionQueue_UseAbilityOnEntity( abilityW, castWTarget )
		return
	end

	local itemRO = J.IsItemAvailable( "item_refresher_shard" )
	if itemRO == nil then itemRO = J.IsItemAvailable( "item_refresher" ) end
	if itemRO ~= nil
		and itemRO:IsFullyCastable()
		and bot:GetMana() > itemRO:GetManaCost() + abilityR:GetManaCost()
		and X.ShouldUseRO()
	then
		bot:ActionQueue_UseAbility( itemRO )
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
	local nDamage = abilityQ:GetSpecialValueInt( 'application_damage' ) + ( abilityQ:GetSpecialValueInt( 'duration' ) * abilityQ:GetSpecialValueInt( 'damage' ) )
	local nEnemyHeroesInRange = bot:GetNearbyHeroes( nCastRange, true, BOT_MODE_NONE )
	local nTargetLocation = nil

	if talent1:IsTrained() then nDamage = nDamage + ( abilityQ:GetSpecialValueInt( 'duration' ) * 12 ) end

	
	for _, npcEnemy in pairs( nEnemyHeroesInRange )
	do
		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.WillMagicKillTarget( bot, npcEnemy, nDamage, nCastPoint )
		then
			nTargetLocation = J.GetCastLocation( bot, npcEnemy, nCastRange, nRadius )
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'Q-Kill:'..J.Chat.GetNormName( npcEnemy )
		end
		
		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.IsInRange( npcEnemy, bot, nCastRange + nRadius )
			and J.IsHealing( npcEnemy )
		then
			nTargetLocation = J.GetCastLocation( bot, npcEnemy, nCastRange, nRadius )
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
			nTargetLocation = J.GetCastLocation( bot, botTarget, nCastRange, nRadius )
			if nTargetLocation ~= nil
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
				nTargetLocation = J.GetCastLocation( bot, npcEnemy, nCastRange, nRadius )
				return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'Q-Retreat:'..J.Chat.GetNormName( npcEnemy )
			end
		end
	end

	
	if J.IsLaning( bot )
	then
		nAoeLoc = J.GetAoeEnemyHeroLocation( bot, nCastRange, nRadius, 2 )
		if nAoeLoc ~= nil and nMP > 0.38
		then
			nTargetLocation = nAoeLoc
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'Q-Harass'
		end

		if #hAllyList == 1
			and #nEnemyHeroesInRange == 1
			and nMP > 0.38
		then
			nAoeLoc = J.GetAoeEnemyHeroLocation( bot, nCastRange, nRadius, 1 )
			if nAoeLoc ~= nil and nMP > 0.38
			then
				nTargetLocation = nAoeLoc
				return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'Q-Harass'
			end
		end
	end

	
	if ( J.IsPushing( bot ) or J.IsDefending( bot ) or J.IsFarming( bot ) )
		and J.IsAllowedToSpam( bot, nManaCost * 0.72 )
		and nSkillLV >= 2 and DotaTime() > 8 * 60
		and nLV >= 15
		and not bot:HasScepter()
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
		and nMP >= 0.55
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

function X.ConsiderW()

	if not abilityW:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end

	local nSkillLV = abilityW:GetLevel()
	local nAttackDamage = bot:GetAttackDamage()
	local nAttackRange = bot:GetAttackRange()
	local nAbilityDamage = abilityW:GetSpecialValueInt( 'intellect_damage_pct' ) * 0.01 * bot:GetAttributeValue( ATTRIBUTE_INTELLECT ) * ( 1 + bot:GetSpellAmp() )
	local nDamageType = DAMAGE_TYPE_PURE

	if talent5:IsTrained() then nAbilityDamage = ( abilityW:GetSpecialValueInt( 'intellect_damage_pct' ) + 10 ) * 0.01 * bot:GetAttributeValue( ATTRIBUTE_INTELLECT ) * ( 1 + bot:GetSpellAmp() ) end

	
	if nLV > 9
		and nMP >= 0.55
	then
		if not abilityW:GetAutoCastState()
		then
			abilityW:ToggleAutoCast()
		end
	else
		if abilityW:GetAutoCastState()
		then
			abilityW:ToggleAutoCast()
		end
	end


	if J.IsValidHero( botTarget )
		and J.CanCastOnNonMagicImmune( botTarget )
		and J.IsInRange( bot, botTarget, nAttackRange )
		and not botTarget:IsAttackImmune()
		and not abilityW:GetAutoCastState()
	then
		return BOT_ACTION_DESIRE_HIGH, botTarget, 'W-Attack:'..J.Chat.GetNormName( botTarget )
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
				and J.WillMixedDamageKillTarget( creep, nAttackDamage, 0, nAbilityDamage, nAttackProDelayTime )
			then
				return BOT_ACTION_DESIRE_HIGH, creep, "W-KillCreep"
			end
		end
	end


	if bot:GetActiveMode() == BOT_MODE_ROSHAN
		and nMP >= 0.78
		and not abilityW:GetAutoCastState()
	then
		if J.IsRoshan( botTarget )
			and J.IsInRange( botTarget, bot, nAttackRange )
		then
			return BOT_ACTION_DESIRE_HIGH, botTarget, 'W-Roshan'
		end
	end
	

	return BOT_ACTION_DESIRE_NONE, nil

end

function X.ConsiderE()

	if not abilityE:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end

	local nSkillLV = abilityE:GetLevel()
	local nCastRange = abilityE:GetCastRange() + bonusRange
	local nRadius = 0
	local nCastPoint = abilityE:GetCastPoint()
	local nManaCost = abilityE:GetManaCost()
	local nBaseDamage = abilityE:GetSpecialValueInt( 'damage' )
	local nDamageMultiplier = abilityE:GetSpecialValueInt( 'int_multiplier' )
	local nDamageType = DAMAGE_TYPE_MAGICAL
	local nTargetLocation = nil
	
	if bot:HasScepter() then nRadius = abilityE:GetSpecialValueInt( 'scepter_radius' ) end
	if talent4:IsTrained() then nDamageMultiplier = nDamageMultiplier + 0.8 end

	local nAlliedHeroesInRange = bot:GetNearbyHeroes( nCastRange + nRadius, false, BOT_MODE_NONE )
	local nEnemyHeroesInRange = bot:GetNearbyHeroes( nCastRange + nRadius, true, BOT_MODE_NONE )

	
	for _, npcEnemy in pairs( nEnemyHeroesInRange )
	do
		local nIntDiff = bot:GetAttributeValue( ATTRIBUTE_INTELLECT ) - bot:GetAttributeValue( ATTRIBUTE_INTELLECT )
		if nIntDiff < 0 then nIntDiff = 0 end
		local nDamage = nBaseDamage + ( nIntDiff * nDamageMultiplier )

		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and ( bot:HasScepter() or J.CanCastOnTargetAdvanced( npcEnemy ) )
			and J.WillMagicKillTarget( bot, npcEnemy, nDamage, nCastPoint )
		then
			if bot:HasScepter()
			then
				nTargetLocation = npcEnemy:GetLocation()
				return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'E-Kill:'..J.Chat.GetNormName( npcEnemy )
			else
				return BOT_ACTION_DESIRE_HIGH, npcEnemy, 'E-Kill:'..J.Chat.GetNormName( npcEnemy )
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
				return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'E-Interrupt:'..J.Chat.GetNormName( npcEnemy )
			else
				return BOT_ACTION_DESIRE_HIGH, npcEnemy, 'E-Interrupt:'..J.Chat.GetNormName( npcEnemy )
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
				return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'E-Battle'
			end
		else
			local npcWeakestEnemy = J.GetVulnerableWeakestUnitWithLotusCheck( bot, true, true, nCastRange )
			if npcWeakestEnemy ~= nil
			then
				return BOT_ACTION_DESIRE_HIGH, npcWeakestEnemy, 'E-Battle-Weakest:'..J.Chat.GetNormName( npcWeakestEnemy )
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
				return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'E-Attack:'..J.Chat.GetNormName( botTarget )
			else
				return BOT_ACTION_DESIRE_HIGH, botTarget, 'E-Attack:'..J.Chat.GetNormName( botTarget )
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
					return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'E-Retreat:'..J.Chat.GetNormName( npcEnemy )
				else
					return BOT_ACTION_DESIRE_HIGH, npcEnemy, 'E-Retreat:'..J.Chat.GetNormName( npcEnemy )
				end
			end
		end
	end

	
	if ( J.IsPushing( bot ) or J.IsDefending( bot ) or J.IsFarming( bot ) )
		and J.IsAllowedToSpam( bot, nManaCost * 0.32 )
		and nSkillLV >= 2 and DotaTime() > 8 * 60
		and bot:HasScepter()
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
				return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "E-ClearWave:"..locationAoEKill.count
			end
		end
	end

	
	if J.IsFarming( bot )
		and not ( J.IsPushing( bot ) or J.IsDefending( bot ) )
		and J.IsAllowedToSpam( bot, nManaCost * 0.25 )
		and nSkillLV >= 3
		and #hEnemyList == 0
		and #hAllyList <= 2
		and nMP >= 0.45
		and bot:HasScepter()
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
				return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "E-Farm:"..( #nNeutralCreeps )
			end
		end
	end

	
	if J.IsDefending( bot )
	then
		if bot:HasScepter()
		then
			local nAoeLoc = J.GetAoeEnemyHeroLocation( bot, nCastRange, nRadius, 1 )
			if nAoeLoc ~= nil
			then
				nTargetLocation = nAoeLoc
				return BOT_ACTION_DESIRE_VERYHIGH, nTargetLocation, 'E-Defend'
			end
		else
			local npcWeakestEnemy = J.GetVulnerableWeakestUnitWithLotusCheck( bot, true, true, nCastRange )
			if npcWeakestEnemy ~= nil
			then
				return BOT_ACTION_DESIRE_HIGH, npcWeakestEnemy, 'E-Battle-Weakest:'..J.Chat.GetNormName( npcWeakestEnemy )
			end
		end
	end

	
	if bot:GetActiveMode() == BOT_MODE_ROSHAN
		and nMP >= 76
	then
		if J.IsRoshan( botTarget ) and J.GetHP( botTarget ) > 0.15
			and J.IsInRange( botTarget, bot, nCastRange )
		then
			if bot:HasScepter()
			then
				nTargetLocation = botTarget:GetLocation()
				return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'E-Roshan'
			else
				return BOT_ACTION_DESIRE_HIGH, botTarget, 'E-Roshan'
			end
		end
	end


	return BOT_ACTION_DESIRE_NONE, nil

end

function X.ConsiderR()
	
	if not abilityR:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end

	local nSkillLV = abilityR:GetLevel()
	local nRadius = 1400
	local nCastPoint = abilityR:GetCastPoint()
	local nManaCost = abilityR:GetManaCost()
	local nAlliedHeroesInRange = bot:GetNearbyHeroes( nRadius, false, BOT_MODE_NONE )
	local nEnemyHeroesInRange = bot:GetNearbyHeroes( nRadius, true, BOT_MODE_NONE )

	
	for _, npcEnemy in pairs( nEnemyHeroesInRange )
	do
		if J.IsValidHero( npcEnemy )
			and J.CanCastOnMagicImmune( npcEnemy )
			and npcEnemy:IsChanneling()
			and not npcEnemy:HasModifier( 'modifier_teleporting' )
		then
			return BOT_ACTION_DESIRE_HIGH, 'R-Interrupt:'..J.Chat.GetNormName( npcEnemy )
		end
	end


	if J.IsInTeamFight( bot, 1200 )
	then
		if #nEnemyHeroesInRange >= 3
		then
			return BOT_ACTION_DESIRE_HIGH, 'R-Battle'
		end
	end


	if J.IsGoingOnSomeone( bot )
	then
		if J.IsValidHero( botTarget )
			and J.CanCastOnMagicImmune( botTarget )
			and J.IsInRange( botTarget, bot, 800 )
			and #nEnemyHeroesInRange >= 2
			and #nEnemyHeroesInRange >= #nAlliedHeroesInRange
		then
			return BOT_ACTION_DESIRE_HIGH, 'R-Chase:'..J.Chat.GetNormName( botTarget )
		end
	end


	if J.IsRetreating( bot )
	then
		if #nEnemyHeroesInRange >= 2
			and #nEnemyHeroesInRange >= #nAlliedHeroesInRange
		then
			return BOT_ACTION_DESIRE_MODERATE, 'R-Retreat'
		end
	end


	local numPlayer =  GetTeamPlayers( GetTeam() )
	for i = 1, #numPlayer
	do
		local npcAlly =  GetTeamMember( i )
		if npcAlly ~= nil and npcAlly:IsAlive()
		then
			if J.IsInTeamFight( npcAlly, 1200 )
			then
				local locationAoE = npcAlly:FindAoELocation( true, true, npcAlly:GetLocation(), 1400, 600, 0, 0 )
				if ( locationAoE.count >= 2 ) then
					return BOT_ACTION_DESIRE_HIGH, 'R-Battle-Global'
				end
			end
		end
	end


	return BOT_ACTION_DESIRE_NONE, nil

end

function X.ShouldUseRO()
	
	local nEnemyHeroesInRange = bot:GetNearbyHeroes( 1400, true, BOT_MODE_NONE )

	if DotaTime() < ultTime + ultDuration
	then
		for _, npcEnemy in pairs( nEnemyHeroesInRange )
		do
			if J.IsValidHero( npcEnemy )
				and J.CanCastOnMagicImmune( npcEnemy )
				and not npcEnemy:HasModifier( 'modifier_silencer_global_silence' )
				and npcEnemy:HasModifier( 'modifier_black_king_bar_immune' )
			then
				return true
			end
		end
	end

	if DotaTime() >= ultTime + ultDuration
	then
		if #nEnemyHeroesInRange >= 2
		then
			return true
		end
	end

	return false

end

return X