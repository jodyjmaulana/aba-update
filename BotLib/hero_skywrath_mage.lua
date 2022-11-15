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
		['t15'] = {10, 0},
		['t10'] = {10, 0},
	},

	['outfit_mid'] = {
		['t25'] = {10, 0},
		['t20'] = {10, 0},
		['t15'] = {10, 0},
		['t10'] = {10, 0},
	},

	['outfit_priest'] = {
		['t25'] = {0, 10},
		['t20'] = {0, 10},
		['t15'] = {0, 10},
		['t10'] = {0, 10},
	},

	['outfit_mage'] = {
		['t25'] = {0, 10},
		['t20'] = {0, 10},
		['t15'] = {0, 10},
		['t10'] = {0, 10},
	},

	['outfit_tank'] = {
		['t25'] = {10, 0},
		['t20'] = {10, 0},
		['t15'] = {10, 0},
		['t10'] = {10, 0},
	},
}

local tAllAbilityBuildList = {
	['outfit_carry'] = {
		{2,1,1,2,3,6,1,1,3,3,6,3,2,2,6}
	},

	['outfit_mid'] = {
		{2,1,1,2,3,6,1,1,3,3,6,3,2,2,6}
	},

	['outfit_priest'] = {
		{2,1,2,3,2,6,3,3,2,3,6,1,1,1,6}
	},

	['outfit_mage'] = {
		{2,1,2,1,3,6,3,3,2,3,6,1,2,1,6}
	},

	['outfit_tank'] = {
		{2,1,1,2,1,6,1,3,3,3,6,3,2,2,6}
	},
}

local nAbilityBuildList = J.Skill.GetRandomBuild( tAllAbilityBuildList[sOutfitType] )

local nTalentBuildList = J.Skill.GetTalentBuild( tTalentTreeList[sOutfitType] )

local tOutFitList = {}

tOutFitList['outfit_carry'] = {

	"item_mid_skywrath_mage_outfit",
	"item_rod_of_atos",
	"item_blink",
	"item_aghanims_shard",
	"item_ultimate_scepter",
	"item_sheepstick",
	"item_kaya",
	"item_ethereal_blade",
	"item_travel_boots",
	"item_ultimate_scepter_2",
	"item_cyclone",
	"item_wind_waker",
	"item_arcane_blink",
	"item_gungir",
	"item_travel_boots_2",
	"item_moon_shard",

}

tOutFitList['outfit_mid'] = tOutFitList['outfit_carry']

tOutFitList['outfit_priest'] = {

	"item_mage_lina_outfit",
	"item_veil_of_discord",
	"item_rod_of_atos",
	"item_force_staff",
	"item_aeon_disk",
	"item_aghanims_shard",
	"item_ultimate_scepter",
	"item_sheepstick",
	"item_travel_boots",
	"item_ultimate_scepter_2",
	"item_ghost",
	"item_ethereal_blade",
	"item_hurricane_pike",
	"item_gungir",
	"item_travel_boots_2",
	"item_moon_shard",

}

tOutFitList['outfit_mage'] = tOutFitList['outfit_priest']

tOutFitList['outfit_tank'] = tOutFitList['outfit_carry']

X['sBuyList'] = tOutFitList[sOutfitType]

X['sSellList'] = {
	"item_sheepstick",
	"item_bottle",

	"item_kaya",
	"item_null_talisman",

	"item_travel_boots",
	"item_arcane_boots",

	"item_sheepstick",
	"item_veil_of_discord",
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

npc_dota_hero_skywrath_mage

"Ability1"		"skywrath_mage_arcane_bolt"
"Ability2"		"skywrath_mage_concussive_shot"
"Ability3"		"skywrath_mage_ancient_seal"
"Ability4"		"skywrath_mage_shield_of_the_scion"
"Ability5"		"generic_hidden"
"Ability6"		"skywrath_mage_mystic_flare"
"Ability10"		"special_bonus_hp_175"
"Ability11"		"special_bonus_intelligence_8"
"Ability12"		"special_bonus_unique_skywrath"
"Ability13"		"special_bonus_unique_skywrath_2"
"Ability14"		"special_bonus_unique_skywrath_4"
"Ability15"		"special_bonus_unique_skywrath_3"
"Ability16"		"special_bonus_unique_skywrath_6"
"Ability17"		"special_bonus_unique_skywrath_5"

modifier_projectile_vision
modifier_skywrath_mage_concussive_shot_slow
modifier_skywrath_mage_ancient_seal
modifier_skywrath_mage_shard
modifier_skywrath_mage_shard_bonus
modifier_skywrath_mage_shard_bonus_counter
modifier_skywrath_mage_mystic_flare
modifier_skywrath_mystic_flare_aura_effect

--]]

local abilityQ = bot:GetAbilityByName( sAbilityList[1] )
local abilityW = bot:GetAbilityByName( sAbilityList[2] )
local abilityE = bot:GetAbilityByName( sAbilityList[3] )
local abilityR = bot:GetAbilityByName( sAbilityList[6] )
local talent5 = bot:GetAbilityByName( sTalentList[5] )
local talent7 = bot:GetAbilityByName( sTalentList[7] )

local castQDesire, castQTarget
local castWDesire
local castEDesire, castETarget
local castRDesire, castRLocation
local castComboDesire, castComboTarget

local nKeepMana, nMP, nHP, nLV, botTarget, hEnemyList, hAllyList, sMotive
local bonusRange = 0

local itemAtos = nil
local itemGleipnir = nil
local itemHex = nil

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

	itemAtos = J.IsItemAvailable( "item_rod_of_atos" )
	itemGleipnir = J.IsItemAvailable( "item_gungir" )
	itemHex = J.IsItemAvailable( "item_sheepstick" )

	
	castWDesire, sMotive = X.ConsiderW()
	if ( castWDesire > 0 )
	then
		J.SetReportMotive( bDebugMode, sMotive )

		J.SetQueuePtToINT( bot, true )

		bot:ActionQueue_UseAbility( abilityW )
		return
	end

	castComboDesire, castComboTarget, sMotive = X.ConsiderCombo()
	if ( castComboDesire > 0 )
	then
		J.SetReportMotive( bDebugMode, sMotive )

		J.SetQueuePtToINT( bot, true )

		if itemHex ~= nil and itemHex:IsFullyCastable()
		then
			bot:ActionQueue_UseAbilityOnEntity( itemHex, castComboTarget )
		end

		if itemAtos ~= nil and itemAtos:IsFullyCastable()
		then
			bot:ActionQueue_UseAbilityOnEntity( itemAtos, castComboTarget )
		end

		if itemGleipnir ~= nil and itemGleipnir:IsFullyCastable()
		then
			bot:ActionQueue_UseAbilityOnLocation( itemGleipnir, castComboTarget:GetLocation() )
		end

		bot:ActionQueue_UseAbilityOnEntity( abilityE, castComboTarget )
		bot:ActionQueue_UseAbilityOnLocation( abilityR, castComboTarget:GetLocation() )
		return
	end

	castEDesire, castETarget, sMotive = X.ConsiderE()
	if ( castEDesire > 0 )
	then
		J.SetReportMotive( bDebugMode, sMotive )

		J.SetQueuePtToINT( bot, true )

		bot:ActionQueue_UseAbilityOnEntity( abilityE, castETarget )
		return
	end

	castRDesire, castRLocation, sMotive = X.ConsiderR()
	if ( castRDesire > 0 )
	then
		J.SetReportMotive( bDebugMode, sMotive )

		J.SetQueuePtToINT( bot, true )

		bot:ActionQueue_UseAbilityOnLocation( abilityR, castRLocation )
		return

	end

	castQDesire, castQTarget, sMotive = X.ConsiderQ()
	if ( castQDesire > 0 )
	then
		J.SetReportMotive( bDebugMode, sMotive )

		J.SetQueuePtToINT( bot, true )

		bot:ActionQueue_UseAbilityOnEntity( abilityQ, castQTarget )
		return
	end

end


function X.ConsiderQ()

	if not abilityQ:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end

	local nSkillLV = abilityQ:GetLevel()
	local nCastRange = abilityQ:GetCastRange() + bonusRange
	local nCastPoint = abilityQ:GetCastPoint()
	local nManaCost = abilityQ:GetManaCost()
	local nDamage = abilityQ:GetSpecialValueInt( "bolt_damage" ) + bot:GetAttributeValue( ATTRIBUTE_INTELLECT ) * 1.5
	local nEnemyHeroesInRange = bot:GetNearbyHeroes( 1200, true, BOT_MODE_NONE )


	local npcWeakestEnemy = nil
	local npcWeakestEnemyHealth = 10000
	for _, npcEnemy in pairs( nEnemyHeroesInRange )
	do
		if J.IsValidHero( npcEnemy )
			and X.CanCastAbilityQOnTarget( npcEnemy )
			and nSkillLV >= 2
			and J.GetHP( npcEnemy ) < 0.55
		then
			return BOT_ACTION_DESIRE_HIGH, npcEnemy, 'Q-Attack:'..J.Chat.GetNormName( npcEnemy )
		end

		if J.IsValidHero( npcEnemy )
			and X.CanCastAbilityQOnTarget( npcEnemy )
			and J.WillMagicKillTarget( bot, npcEnemy, nDamage, nCastPoint )
		then
			return BOT_ACTION_DESIRE_HIGH, npcEnemy, 'Q-Kill:'..J.Chat.GetNormName( npcEnemy )
		end

		if J.IsValidHero( npcEnemy )
			and X.CanCastAbilityQOnTarget( npcEnemy )
			and J.IsHealing( npcEnemy )
		then
			return BOT_ACTION_DESIRE_HIGH, npcEnemy, 'Q-DispelHeal:'..J.Chat.GetNormName( npcEnemy )
		end

		if J.IsValidHero( npcEnemy )
			and X.CanCastAbilityQOnTarget( npcEnemy )
			and npcEnemy:GetHealth() < npcWeakestEnemyHealth
			and not npcEnemy:HasModifier( 'modifier_templar_assassin_refraction_absorb' )
		then
			npcWeakestEnemy = npcEnemy
			npcWeakestEnemyHealth = npcEnemy:GetHealth()
		end
	end


	if npcWeakestEnemy ~= nil
		and J.IsAllowedToSpam( bot, nManaCost * 0.72 )
		and nMP > 0.42
	then
		return BOT_ACTION_DESIRE_HIGH, npcWeakestEnemy, 'Q-Harass:'..J.Chat.GetNormName( npcWeakestEnemy )
	end


	if J.IsGoingOnSomeone( bot )
	then
		if J.IsValidHero( botTarget )
			and X.CanCastAbilityQOnTarget( botTarget )
			and J.IsInRange( botTarget, bot, nCastRange )
		then
			return BOT_ACTION_DESIRE_HIGH, botTarget, 'Q-Attack:'..J.Chat.GetNormName( botTarget )
		end
	end


	if J.IsRetreating( bot )
	then
		for _, npcEnemy in pairs( nEnemyHeroesInRange )
		do
			if J.IsValidHero( npcEnemy )
				and X.CanCastAbilityQOnTarget( npcEnemy )
				and bot:WasRecentlyDamagedByHero( npcEnemy, 5.0 )
				and bot:IsFacingLocation( npcEnemy:GetExtrapolatedLocation( nCastPoint ), 20 )
			then
				return BOT_ACTION_DESIRE_HIGH, npcEnemy, 'Q-Retreat:'..J.Chat.GetNormName( npcEnemy )
			end
		end
	end

	
	if ( J.IsPushing( bot ) or J.IsDefending( bot ) or J.IsFarming( bot ) )
		and J.IsAllowedToSpam( bot, nManaCost * 0.72 )
		and nSkillLV >= 2 and DotaTime() > 8 * 60
		and nLV >= 15
	then
		local nEnemyCreeps = bot:GetNearbyLaneCreeps( nCastRange, true )
		if #nEnemyCreeps >= 3
			and J.IsValid( nEnemyCreeps[1] )
			and not nEnemyCreeps[1]:HasModifier( "modifier_fountain_glyph" )
		then
			return BOT_ACTION_DESIRE_HIGH, nEnemyCreeps[1], "Q-Push"
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
		local nNeutralCreeps = bot:GetNearbyNeutralCreeps( nCastRange )
		if #nNeutralCreeps >= 1
		then
			local targetCreep = nNeutralCreeps[1]
			if J.IsValid( targetCreep )
				and targetCreep:GetHealth() >= 200
				and J.GetAroundTargetEnemyUnitCount( targetCreep, 300 ) >= 1
			then
				return BOT_ACTION_DESIRE_HIGH, targetCreep, "Q-Farm"
			end
		end
	end

	
	if bot:GetActiveMode() == BOT_MODE_ROSHAN
		and nMP >= 0.78
	then
		return BOT_ACTION_DESIRE_HIGH, botTarget, 'Q-Roshan'
	end


	return BOT_ACTION_DESIRE_NONE, nil

end

function X.ConsiderW()

	if not abilityW:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end

	local nSkillLV = abilityW:GetLevel()
	local nCastRange = abilityW:GetCastRange() + bonusRange
	local nManaCost = abilityW:GetManaCost()
	local nEnemyHeroesInRange = bot:GetNearbyHeroes( nCastRange, true, BOT_MODE_NONE )

	
	if talent5:IsTrained()
	then
		return BOT_ACTION_DESIRE_HIGH, 'W-SpamGlobal'
	end


	if #nEnemyHeroesInRange >= 1
	then
		if J.IsValidHero( nEnemyHeroesInRange[1] )
			and J.CanCastOnNonMagicImmune( nEnemyHeroesInRange[1] )
			and J.GetHP( nEnemyHeroesInRange[1] ) < 0.55
		then
			return BOT_ACTION_DESIRE_HIGH, 'W-Attack'
		end

		if J.IsValidHero( nEnemyHeroesInRange[1] )
			and J.CanCastOnNonMagicImmune( nEnemyHeroesInRange[1] )
			and J.IsAllowedToSpam( bot, nManaCost * 0.72 )
			and nMP > 0.42
			and not nEnemyHeroesInRange[1]:HasModifier( 'modifier_templar_assassin_refraction_absorb' )
		then
			return BOT_ACTION_DESIRE_HIGH, 'W-Harass'
		end
	end


	if J.IsRetreating( bot )
	then
		if #nEnemyHeroesInRange >= 1
			and J.IsValidHero( nEnemyHeroesInRange[1] )
			and J.CanCastOnNonMagicImmune( nEnemyHeroesInRange[1] )
			and bot:WasRecentlyDamagedByHero( nEnemyHeroesInRange[1], 5.0 )
		then
			return BOT_ACTION_DESIRE_HIGH, 'W-Retreat'
		end
	end

	
	if ( J.IsPushing( bot ) or J.IsDefending( bot ) or J.IsFarming( bot ) )
		and J.IsAllowedToSpam( bot, nManaCost * 0.72 )
		and nSkillLV >= 2 and DotaTime() > 8 * 60
		and nLV >= 15
	then
		local nEnemyCreeps = bot:GetNearbyLaneCreeps( nCastRange, true )
		if #nEnemyCreeps >= 3
			and J.IsValid( nEnemyCreeps[1] )
			and not nEnemyCreeps[1]:HasModifier( "modifier_fountain_glyph" )
		then
			return BOT_ACTION_DESIRE_HIGH, "W-Push"
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
		local nNeutralCreeps = bot:GetNearbyNeutralCreeps( nCastRange )
		if #nNeutralCreeps >= 1
		then
			local targetCreep = nNeutralCreeps[1]
			if J.IsValid( targetCreep )
				and targetCreep:GetHealth() >= 200
				and J.GetAroundTargetEnemyUnitCount( targetCreep, 300 ) >= 1
			then
				return BOT_ACTION_DESIRE_HIGH, "W-Farm"
			end
		end
	end

	
	if bot:GetActiveMode() == BOT_MODE_ROSHAN
		and nMP > 0.74
	then
		if J.IsRoshan( botTarget ) and J.GetHP( botTarget ) > 0.15
			and J.IsInRange( botTarget, bot, nCastRange )
		then
			return BOT_ACTION_DESIRE_HIGH, 'W-Roshan'
		end
	end


	return BOT_ACTION_DESIRE_NONE, nil

end

function X.ConsiderE()

	if not abilityE:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end

	local nCastRange = abilityE:GetCastRange() + bonusRange
	local nCastPoint = abilityE:GetCastPoint()
	local nEnemyHeroesInRange = bot:GetNearbyHeroes( 1200, true, BOT_MODE_NONE )

	
	local npcMostDangerousEnemy = nil
	local npcMostDangerousDamage = 0
	for _, npcEnemy in pairs( nEnemyHeroesInRange )
	do
		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.CanCastOnTargetAdvanced( npcEnemy )
			and ( npcEnemy:IsChanneling() or npcEnemy:IsCastingAbility() )
		then
			return BOT_ACTION_DESIRE_HIGH, npcEnemy, "E-Interrupt:"..J.Chat.GetNormName( npcEnemy )
		end

		local incProj = npcEnemy:GetIncomingTrackingProjectiles()
		for _, proj in pairs( incProj )
		do
			if GetUnitToLocationDistance( npcEnemy, proj.location ) < nCastRange
				and proj.ability ~= nil
				and proj.ability:GetName() == "skywrath_mage_concussive_shot"
			then
				return BOT_ACTION_DESIRE_HIGH, npcEnemy, "E-Silence:"..J.Chat.GetNormName( npcEnemy )
			end
		end

		local npcEnemyDamage = npcEnemy:GetEstimatedDamageToTarget( false, bot, 3.0, DAMAGE_TYPE_MAGICAL )
		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.CanCastOnTargetAdvanced( npcEnemy )
			and not J.IsDisabled( npcEnemy )
			and npcEnemyDamage > npcMostDangerousDamage
			and #nEnemyHeroesInRange >= 2
		then
			npcMostDangerousDamage = npcEnemyDamage
			npcMostDangerousEnemy = npcEnemy
		end
	end

	if npcMostDangerousEnemy ~= nil
	then
		return BOT_ACTION_DESIRE_HIGH, npcMostDangerousEnemy, "E-Battle:"..J.Chat.GetNormName( npcMostDangerousEnemy )
	end


	if J.IsGoingOnSomeone( bot )
	then
		if J.IsValidHero( botTarget )
			and J.CanCastOnNonMagicImmune( botTarget )
			and J.CanCastOnTargetAdvanced( botTarget )
			and not J.IsDisabled( botTarget )
		then
			return BOT_ACTION_DESIRE_HIGH, botTarget, 'E-Chase:'..J.Chat.GetNormName( botTarget )
		end
	end


	if J.IsRetreating( bot )
	then
		for _, npcEnemy in pairs( nEnemyHeroesInRange )
		do
			if J.IsValidHero( npcEnemy )
				and J.CanCastOnNonMagicImmune( npcEnemy )
				and J.CanCastOnTargetAdvanced( npcEnemy )
				and bot:WasRecentlyDamagedByHero( npcEnemy, 3.1 )
				and bot:IsFacingLocation( npcEnemy:GetExtrapolatedLocation( nCastPoint ), 20 )
				and not J.IsDisabled( botTarget )
			then
				return BOT_ACTION_DESIRE_HIGH, npcEnemy, 'E-Retreat:'..J.Chat.GetNormName( npcEnemy )
			end
		end
	end

	
	if bot:GetActiveMode() == BOT_MODE_ROSHAN
		and nMP >= 0.78
	then
		return BOT_ACTION_DESIRE_HIGH, botTarget, 'E-Roshan'
	end


	return BOT_ACTION_DESIRE_NONE, nil

end

function X.ConsiderR()
	
	if not abilityR:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end

	local nCastRange = abilityR:GetCastRange() + bonusRange
	local nRadius = abilityR:GetSpecialValueInt( 'radius' )
	local nEnemyHeroesInRange = bot:GetNearbyHeroes( nCastRange + nRadius, true, BOT_MODE_NONE )


	for _, npcEnemy in pairs( nEnemyHeroesInRange )
	do
		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.IsInRange( bot, npcEnemy, nCastRange + 200 )
			and J.GetAroundTargetEnemyHeroCount( npcEnemy, nRadius ) <= 1
			and npcEnemy:HasModifier( 'modifier_skywrath_mage_ancient_seal' )
		then
			if ( not J.IsRunning( npcEnemy ) and not J.IsMoving( npcEnemy ) )
				or J.IsDisabled( npcEnemy )
				or npcEnemy:GetCurrentMovementSpeed() < 180
				or npcEnemy:HasModifier( 'modifier_skywrath_mage_concussive_shot_slow' )
			then
				-- return BOT_ACTION_DESIRE_HIGH, J.GetFaceTowardDistanceLocation( npcEnemy, nRadius - 30 ), 'R-Attack-'..J.Chat.GetNormName( npcEnemy )
				return BOT_ACTION_DESIRE_HIGH, npcEnemy:GetLocation(), 'R-Attack-'..J.Chat.GetNormName( npcEnemy )
			end
		end
	end


	return BOT_ACTION_DESIRE_NONE, nil

end

function X.ConsiderCombo()
	
	if not abilityR:IsFullyCastable()
		or not abilityE:IsFullyCastable()
	then
		return BOT_ACTION_DESIRE_NONE, nil
	end

	local nCastRange = abilityE:GetCastRange() + bonusRange
	local nRadius = abilityR:GetSpecialValueInt( 'radius' )
	local nManaCost = abilityE:GetManaCost() + abilityR:GetManaCost() + 450
	local nEnemyHeroesInRange = bot:GetNearbyHeroes( 1200, true, BOT_MODE_NONE )


	if bot:GetMana() < nManaCost then return BOT_ACTION_DESIRE_NONE, nil end


	for _, npcEnemy in pairs( nEnemyHeroesInRange )
	do
		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.GetAroundTargetEnemyHeroCount( npcEnemy, nRadius ) <= 1
		then
			if ( not J.IsRunning( npcEnemy ) and not J.IsMoving( npcEnemy ) )
				or J.IsDisabled( npcEnemy )
				or npcEnemy:GetCurrentMovementSpeed() < 180
				or npcEnemy:HasModifier( 'modifier_skywrath_mage_concussive_shot_slow' )
			then
				return BOT_ACTION_DESIRE_HIGH, npcEnemy, 'ER-Combo-'..J.Chat.GetNormName( npcEnemy )
			end
		end
	end


	return BOT_ACTION_DESIRE_NONE, nil

end

function X.CanCastAbilityQOnTarget( nTarget )

	if J.CanCastOnTargetAdvanced( nTarget )
	then
		if talent7:IsTrained()
		then
			return J.CanCastOnMagicImmune( nTarget )
		else
			return J.CanCastOnNonMagicImmune( nTarget )
		end
	end

	return false
	
end

return X