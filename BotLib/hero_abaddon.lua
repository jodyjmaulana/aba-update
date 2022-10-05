----------------------------------------------------------------------------------------------------
--- The Creation Come From: BOT EXPERIMENT Credit:FURIOUSPUPPY
--- BOT EXPERIMENT Author: Arizona Fauzie 2018.11.21
--- Link:http://steamcommunity.com/sharedfiles/filedetails/?id=837040016
--- Refactor: 决明子 Email: dota2jmz@163.com 微博@Dota2_决明子
--- Link:http://steamcommunity.com/sharedfiles/filedetails/?id=1573671599
--- Link:http://steamcommunity.com/sharedfiles/filedetails/?id=1627071163
--- Updated: Nikel
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
		['t10'] = {0, 10},
	},

	['outfit_mid'] = {
		['t25'] = {10, 0},
		['t20'] = {0, 10},
		['t15'] = {10, 0},
		['t10'] = {0, 10},
	},

	['outfit_priest'] = {
		['t25'] = {0, 10},
		['t20'] = {10, 0},
		['t15'] = {0, 10},
		['t10'] = {10, 0},
	},

	['outfit_mage'] = {
		['t25'] = {0, 10},
		['t20'] = {10, 0},
		['t15'] = {0, 10},
		['t10'] = {10, 0},
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
		{2,3,3,2,3,6,3,2,2,1,1,6,1,1,6}
	},

	['outfit_mid'] = {
		{2,3,3,2,3,6,3,2,2,1,1,6,1,1,6}
	},

	['outfit_priest'] = {
		{2,1,3,2,1,6,2,2,1,1,3,6,3,3,6}
	},

	['outfit_mage'] = {
		{2,1,3,2,1,6,2,2,1,1,3,6,3,3,6}
	},

	['outfit_tank'] = {
		{2,3,2,1,3,6,2,3,2,3,1,6,1,1,6}
	},
}

local nAbilityBuildList = J.Skill.GetRandomBuild( tAllAbilityBuildList[sOutfitType] )

local nTalentBuildList = J.Skill.GetTalentBuild( tTalentTreeList[sOutfitType] )

local sRandomItem_1 = RandomInt( 1, 9 ) > 6 and "item_manta" or "item_black_king_bar"

local tOutFitList = {}

tOutFitList['outfit_carry'] = {

	"item_sven_outfit",
	"item_echo_sabre",
	"item_basher",
	sRandomItem_1,
	"item_assault",
	"item_abyssal_blade",
	"item_ultimate_scepter",
	"item_radiance",
	"item_aghanims_shard",
	"item_travel_boots",
	"item_ultimate_scepter_2",
	"item_nullifier",
	"item_moon_shard",
	"item_travel_boots_2",

}

tOutFitList['outfit_mid'] = tOutFitList['outfit_carry']

tOutFitList['outfit_priest'] = {

	"item_priest_outfit",
	"item_mekansm",
	"item_vladmir",
	"item_holy_locket",
	"item_ultimate_scepter",
	"item_guardian_greaves",
	"item_spirit_vessel",
	"item_solar_crest",
	"item_wraith_pact",
	"item_aghanims_shard",
	"item_ultimate_scepter_2",
	"item_shivas_guard",
	"item_moon_shard",

}

tOutFitList['outfit_mage'] = {

	"item_abaddon_outfit",
	"item_ancient_janggo",
	"item_pipe",
	"item_ultimate_scepter",
	"item_medallion_of_courage",
	"item_boots_of_bearing",
	"item_crimson_guard",
	"item_lotus_orb",
	"item_solar_crest",
	"item_aghanims_shard",
	"item_ultimate_scepter_2",
	"item_shivas_guard",
	"item_moon_shard",

}

tOutFitList['outfit_tank'] = {

	"item_tank_outfit",
	"item_vanguard",
	"item_soul_ring",
	"item_blade_mail",
	"item_lotus_orb",
	"item_crimson_guard",
	"item_heavens_halberd",
	"item_ultimate_scepter",
	"item_assault",
	"item_aghanims_shard",
	"item_travel_boots",
	"item_ultimate_scepter_2",
	"item_radiance",
	"item_moon_shard",
	"item_travel_boots_2",

}

X['sBuyList'] = tOutFitList[sOutfitType]

X['sSellList'] = {
	"item_quelling_blade",
	"item_magic_wand",
	"item_bracer",
	"item_soul_ring",
	"item_blade_mail",
	"item_echo_sabre",
	"item_power_treads",
	"item_phase_boots",
}

if J.Role.IsPvNMode() or J.Role.IsAllShadow() then X['sBuyList'], X['sSellList'] = { 'PvN_str_carry' }, {} end

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

"Ability1"		"abaddon_death_coil"
"Ability2"		"abaddon_aphotic_shield"
"Ability3"		"abaddon_frostmourne"
"Ability4"		"generic_hidden"
"Ability5"		"generic_hidden"
"Ability6"		"abaddon_borrowed_time"
"Ability10"		"special_bonus_unique_abaddon_6"
"Ability11"		"special_bonus_strength_8"
"Ability12"		"special_bonus_attack_damage_65"
"Ability13"		"special_bonus_unique_abaddon_2"
"Ability14"		"special_bonus_unique_abaddon"
"Ability15"		"special_bonus_unique_abaddon_5"
"Ability16"		"special_bonus_unique_abaddon_3"
"Ability17"		"special_bonus_unique_abaddon_4"

modifier_abaddon_aphotic_shield
modifier_abaddon_frostmourne
modifier_abaddon_frostmourne_buff
modifier_abaddon_frostmourne_debuff
modifier_abaddon_frostmourne_debuff_bonus
modifier_abaddon_borrowed_time_passive
modifier_abaddon_borrowed_time
modifier_abaddon_borrowed_time_damage_redirect

--]]

local abilityQ = bot:GetAbilityByName( sAbilityList[1] )
local abilityW = bot:GetAbilityByName( sAbilityList[2] )
local abilityR = bot:GetAbilityByName( sAbilityList[6] )
local talent4 = bot:GetAbilityByName( sTalentList[4] )
local talent8 = bot:GetAbilityByName( sTalentList[8] )

local castQDesire, castQTarget
local castWDesire, castWTarget
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
	
	castQDesire, castQTarget, sMotive = X.ConsiderQ()
	if castQDesire > 0
	then
		J.SetReportMotive( bDebugMode, sMotive )

		J.SetQueuePtToINT( bot, false )

		bot:ActionQueue_UseAbilityOnEntity( abilityQ, castQTarget )
		return
	end

	castWDesire, castWTarget, sMotive = X.ConsiderW()
	if castWDesire > 0
	then
		J.SetReportMotive( bDebugMode, sMotive )

		J.SetQueuePtToINT( bot, true )

		bot:ActionQueue_UseAbilityOnEntity( abilityW, castWTarget )
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
	local nDamage = abilityQ:GetSpecialValueInt( 'target_damage' )
	local nDamageType = DAMAGE_TYPE_MAGICAL
	local nAlliedHeroesInRange = bot:GetNearbyHeroes( nCastRange, false, BOT_MODE_NONE )
	local nEnemyHeroesInRange = bot:GetNearbyHeroes( nCastRange, true, BOT_MODE_NONE )

	if talent4:IsTrained() then nDamage = nDamage + talent4:GetSpecialValueInt( 'value' ) end
	if talent8:IsTrained() then nRadius = 250 end


	for _, npcEnemy in pairs( nEnemyHeroesInRange )
	do
		if J.IsValid( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.CanCastOnTargetAdvanced( npcEnemy )
			and J.WillMagicKillTarget( bot, npcEnemy, nDamage, nCastPoint )
		then
			return BOT_ACTION_DESIRE_HIGH, npcEnemy, 'Q-Kill:'..J.Chat.GetNormName( npcEnemy )
		end
	end


	if bot:GetHealth() - ( nDamage * abilityQ:GetSpecialValueInt( 'self_damage' ) / 100 ) > 400
		or bot:HasModifier( 'modifier_abaddon_borrowed_time' )
	then
		local npcWeakestAlly = nil
		local npcWeakestAllyHealth = 100000
		for _, npcAlly in pairs( nAlliedHeroesInRange )
		do
			if J.CanCastOnNonMagicImmune( npcAlly )
				and npcAlly:GetHealth() <= npcWeakestAllyHealth
				and J.GetHP( npcAlly ) <= 0.75
				and npcAlly ~= bot
			then
				npcWeakestAlly = npcAlly
				npcWeakestAllyHealth = npcWeakestAlly:GetHealth()
			end
		end

		if ( npcWeakestAlly ~= nil )
		then
			return BOT_ACTION_DESIRE_HIGH, npcWeakestAlly, 'Q-Heal:'..J.Chat.GetNormName( npcWeakestAlly )
		end
	end


	if J.IsInTeamFight( bot, 1200 )
	then
		
		local npcWeakestEnemy = nil
		local npcWeakestEnemyHealth = 10000
		for _, npcEnemy in pairs( nEnemyHeroesInRange )
		do
			if J.IsValid( npcEnemy )
				and J.CanCastOnNonMagicImmune( npcEnemy )
				and J.CanCastOnTargetAdvanced( npcEnemy )
			then
				local npcEnemyHealth = npcEnemy:GetHealth()
				if ( npcEnemyHealth < npcWeakestEnemyHealth )
				then
					npcWeakestEnemyHealth = npcEnemyHealth
					npcWeakestEnemy = npcEnemy
				end
			end
		end

		if ( npcWeakestEnemy ~= nil )
		then
			return BOT_ACTION_DESIRE_HIGH, npcWeakestEnemy, 'Q-Battle-Weakest:'..J.Chat.GetNormName( npcWeakestEnemy )
		end

	end


	if J.IsGoingOnSomeone( bot )
	then
		if J.IsValidHero( botTarget )
			and J.CanCastOnMagicImmune( botTarget )
			and J.CanCastOnTargetAdvanced( botTarget )
			and J.IsInRange( botTarget, bot, nCastRange )
		then
			return BOT_ACTION_DESIRE_HIGH, botTarget, 'Q-Attack:'..J.Chat.GetNormName( botTarget )
		end
	end


	if J.IsLaning( bot )
	then
		for _, npcEnemy in pairs( nEnemyHeroesInRange )
		do
			if J.IsValidHero( npcEnemy )
				and J.CanCastOnMagicImmune( npcEnemy )
				and J.CanCastOnTargetAdvanced( npcEnemy )
				and J.IsInRange( npcEnemy, bot, nCastRange )
				and J.IsHealing( npcEnemy )
				and not npcEnemy:HasModifier( 'modifier_templar_assassin_refraction_absorb' )
			then
				return BOT_ACTION_DESIRE_HIGH, npcEnemy, "Q-DispelHeal:"..J.Chat.GetNormName( npcEnemy )
			end
		end
	end


	if ( J.IsPushing( bot ) or J.IsDefending( bot ) or J.IsFarming( bot ) )
		and J.IsAllowedToSpam( bot, 30 )
		and nSkillLV >= 3
		and #hEnemyList == 0
		and #hAllyList <= 3
		and talent8:isTrained()
		and ( bot:GetHealth() - ( nDamage * abilityQ:GetSpecialValueInt( 'self_damage' ) / 100 ) > 400
			or bot:HasModifier( 'modifier_abaddon_borrowed_time' ) )
	then
		local nEnemyCreeps = bot:GetNearbyLaneCreeps( nCastRange + nRadius, true )
		for _, creep in pairs( nEnemyCreeps )
		do
			if J.IsValid( creep )
				and not creep:HasModifier( "modifier_fountain_glyph" )
				and J.IsInRange( creep, bot, nCastRange + nRadius )
			then

				if J.GetAroundTargetEnemyUnitCount( creep, nRadius ) >= 2
					and #nEnemyCreeps >= 4
				then
					return BOT_ACTION_DESIRE_HIGH, creep, "Q-PushAoe"
				end

				if J.IsKeyWordUnit( 'ranged', creep )
					and J.WillKillTarget( creep, nDamage, nDamageType, nCastPoint )
				then
					return BOT_ACTION_DESIRE_HIGH, creep, "Q-PushRanged"
				end

				if J.IsKeyWordUnit( 'melee', creep )
					and J.WillKillTarget( creep, nDamage, nDamageType, nCastPoint )
					and ( J.GetAroundTargetEnemyUnitCount( creep, nRadius ) >= 2 or nMP > 0.8 )
				then
					return BOT_ACTION_DESIRE_HIGH, creep, "Q-PushMelee"
				end
			end
		end
	end

	
	if J.IsFarming( bot )
		and not ( J.IsPushing( bot ) or J.IsDefending( bot ) )
		and J.IsAllowedToSpam( bot, nManaCost )
		and nSkillLV >= 3
		and #hEnemyList == 0
		and #hAllyList <= 2
		and talent8:isTrained()
		and ( bot:GetHealth() - ( nDamage * abilityQ:GetSpecialValueInt( 'self_damage' ) / 100 ) > 400
			or bot:HasModifier( 'modifier_abaddon_borrowed_time' ) )
	then
		local nNeutralCreeps = bot:GetNearbyNeutralCreeps( nCastRange + nRadius )
		if #nNeutralCreeps >= 3 or nMP >= 0.8
		then
			local targetCreep = nNeutralCreeps[1]
			if J.IsValid( targetCreep )
				and targetCreep:GetHealth() >= 500
				and targetCreep:GetMagicResist() < 0.3
				and J.GetAroundTargetEnemyUnitCount( targetCreep, 300 ) >= 2
			then
				return BOT_ACTION_DESIRE_HIGH, targetCreep, "Q-Farm:"..( #nNeutralCreeps )
			end
		end
	end


	return BOT_ACTION_DESIRE_NONE, nil

end

function X.ConsiderW()

	if not abilityW:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end

	local nSkillLV = abilityW:GetLevel()
	local nCastRange = abilityW:GetCastRange() + bonusRange
	local nCastPoint = abilityW:GetCastPoint()
	local nManaCost = abilityW:GetManaCost()
	local nAlliedHeroesInRange = bot:GetNearbyHeroes( nCastRange, false, BOT_MODE_NONE )

	
	for _, npcAlly in pairs( nAlliedHeroesInRange )
	do
		if J.IsDisabled( npcAlly )
		then
			return BOT_ACTION_DESIRE_HIGH, npcAlly, "W-Protect:"..J.Chat.GetNormName( npcAlly )
		end
		
		if J.IsRetreating( npcAlly )
			and not npcAlly:HasModifier( 'modifier_fountain_aura' )
			and not npcAlly:HasModifier( 'modifier_abaddon_aphotic_shield' )
			and J:GetHP( npcAlly ) <= 0.75
			and npcAlly:WasRecentlyDamagedByAnyHero( 1.0 )
		then
			return BOT_ACTION_DESIRE_HIGH, npcAlly, "W-Protect:"..J.Chat.GetNormName( npcAlly )
		end
	end

	
	if J.IsRetreating( bot )
		-- and not bot:HasModifier( 'modifier_fountain_aura' )
		-- and not bot:HasModifier( 'modifier_abaddon_aphotic_shield' )
		-- and J:GetHP( bot ) <= 0.75
		-- and bot:WasRecentlyDamagedByAnyHero( 1.0 )
	then
		return BOT_ACTION_DESIRE_HIGH, bot, "W-Protect:"..J.Chat.GetNormName( bot )
	end


	if J.IsGoingOnSomeone( bot )
	then
		if J.IsValidHero( botTarget )
			and J.CanCastOnMagicImmune( botTarget )
			and J.IsInRange( botTarget, bot, 600 )
			and not bot:HasModifier( 'modifier_abaddon_aphotic_shield' )
		then
			return BOT_ACTION_DESIRE_HIGH, bot, "W-Protect-Offensive:"..J.Chat.GetNormName( bot )
		end
	end


	if J.IsLaning( bot )
	then
		local nAlliedCreeps = bot:GetNearbyLaneCreeps( nCastRange, false )
		for _, creep in pairs( nAlliedCreeps )
		do
			if J.GetAroundTargetOtherAllyHeroCount( bot, creep, nCastRange )
				and nMP >= 0.75
				and creep:HasModifier( 'modifier_dark_seer_ion_shell' )
			then
				return BOT_ACTION_DESIRE_HIGH, creep, "W-PurgeIonShell"
			end
		end

		if #hEnemyList >= 2
			and J.IsAllowedToSpam( bot, nManaCost )
			and nMP >= 0.82
		then
			return BOT_ACTION_DESIRE_MODERATE, bot, "W-Laning"
		end
	end

	
	if ( bot:GetActiveMode() == BOT_MODE_ROSHAN )
	then
		if not bot:HasModifier( 'modifier_abaddon_aphotic_shield' )
			and bot:GetAttackTarget() ~= nil
		then
			return BOT_ACTION_DESIRE_HIGH, bot, "W-Roshan"
		end
	end
	

	return BOT_ACTION_DESIRE_NONE, nil

end

function X.ConsiderR()
	
	if not abilityR:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end

	local nSkillLV = abilityR:GetLevel()
	local nRadius = 0
	local nAlliedHeroesInRange = bot:GetNearbyHeroes( 1200, false, BOT_MODE_NONE )

	if bot:HasScepter() then nRadius = abilityR:GetSpecialValueInt( 'redirect_range_scepter' ) end


	if ( bot:GetHealth() < 500 or nHP < 0.23 )
		and bot:WasRecentlyDamagedByAnyHero( 2.0 )
	then
		return BOT_ACTION_DESIRE_HIGH, "R-Defensive"
	end

	
	if bot:HasScepter()
	then
		for _, npcAlly in pairs( nAlliedHeroesInRange )
		do
			if J.IsInTeamFight( npcAlly, nRadius )
				and npcAlly:WasRecentlyDamagedByAnyHero( 2.0 )
				and J.GetHP( npcAlly ) < 0.75
			then
				return BOT_ACTION_DESIRE_HIGH, "R-ProtectTeam-Teamfight"
			end

			if J.IsRetreating( npcAlly )
				and npcAlly:WasRecentlyDamagedByAnyHero( 2.0 )
				and J.GetHP( npcAlly ) < 0.55
			then
				return BOT_ACTION_DESIRE_HIGH, "R-ProtectTeam-Retreating"
			end
		end
	end


	return BOT_ACTION_DESIRE_NONE, nil

end

return X