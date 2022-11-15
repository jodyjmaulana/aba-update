----------------------------------------------------------------------------------------------------
--- The Creation Come From: Nikel
----------------------------------------------------------------------------------------------------


local X = {}
local ability = nil
local bonusRange, nMP, nHP, nLV, botTarget, hEnemyList, hAllyList

local J = require( GetScriptDirectory()..'/FunLib/jmz_func')


function X.Init( bot )

	nLV = bot:GetLevel()
	nMP = bot:GetMana() / bot:GetMaxMana()
	nHP = bot:GetHealth() / bot:GetMaxHealth()
	botTarget = J.GetProperTarget( bot )
	hEnemyList = bot:GetNearbyHeroes( 1400, true, BOT_MODE_NONE )
	hAllyList = J.GetAlliesNearLoc( bot:GetLocation(), 1400 )
	bonusRange = J.GetBonusCastRange( bot )

end


-- npc_dota_hero_abaddon
-- npc_dota_hero_abyssal_underlord
-- npc_dota_hero_alchemist
-- npc_dota_hero_ancient_apparition
-- npc_dota_hero_antimage
-- npc_dota_hero_arc_warden
-- npc_dota_hero_axe
-- npc_dota_hero_bane
-- npc_dota_hero_batrider
-- npc_dota_hero_beastmaster
-- npc_dota_hero_bloodseeker
-- npc_dota_hero_bounty_hunter
-- npc_dota_hero_brewmaster
-- npc_dota_hero_bristleback
-- npc_dota_hero_broodmother
-- npc_dota_hero_centaur
-- npc_dota_hero_chaos_knight
-- npc_dota_hero_chen
-- npc_dota_hero_clinkz
-- npc_dota_hero_crystal_maiden
-- npc_dota_hero_dark_seer
-- npc_dota_hero_dark_willow
-- npc_dota_hero_dawnbreaker
-- npc_dota_hero_dazzle
-- npc_dota_hero_disruptor
-- npc_dota_hero_death_prophet
-- npc_dota_hero_doom_bringer
-- npc_dota_hero_dragon_knight
-- npc_dota_hero_drow_ranger
-- npc_dota_hero_earth_spirit
-- npc_dota_hero_earthshaker
-- npc_dota_hero_elder_titan
-- npc_dota_hero_ember_spirit
-- npc_dota_hero_enchantress
-- npc_dota_hero_enigma
-- npc_dota_hero_faceless_void
-- npc_dota_hero_furion
-- npc_dota_hero_grimstroke
function X.ConsiderGrimstrokeStrokeOfFate( bot )

	X.Init( bot )
	ability = bot:GetAbilityByName( 'grimstroke_dark_artistry' )

	if ability == nil then return BOT_ACTION_DESIRE_NONE, nil end
	if not ability:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end

	local nSkillLV = ability:GetLevel()
	local nCastRange = ability:GetCastRange() + bonusRange
	local nRadius = ability:GetSpecialValueInt( 'end_radius' )
	local nCastPoint = ability:GetCastPoint()
	local nManaCost = ability:GetManaCost()
	local nDamage = ability:GetSpecialValueInt( 'damage' )
	local nEnemyHeroesInRange = bot:GetNearbyHeroes( 1400, true, BOT_MODE_NONE )
	local nTargetLocation = nil

	
	for _, npcEnemy in pairs( nEnemyHeroesInRange )
	do
		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.GetHP( npcEnemy ) < 0.55
		then
			nTargetLocation = npcEnemy:GetExtrapolatedLocation( nCastPoint )
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "Q-Attack:"..J.Chat.GetNormName( npcEnemy )
		end

		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.WillMagicKillTarget( bot, npcEnemy, nDamage, nCastPoint )
		then
			nTargetLocation = npcEnemy:GetExtrapolatedLocation( nCastPoint )
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "Q-Kill:"..J.Chat.GetNormName( npcEnemy )
		end

		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.IsHealing( npcEnemy )
			and not npcEnemy:HasModifier( 'modifier_templar_assassin_refraction_absorb' )
		then
            nTargetLocation = npcEnemy:GetExtrapolatedLocation( nCastPoint )
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "Q-DispelHeal:"..J.Chat.GetNormName( npcEnemy )
		end
	end
	

	local nAoeLoc = J.GetAoeEnemyHeroLocation( bot, nCastRange, nRadius, 2 )
	if nAoeLoc ~= nil
		and J.IsAllowedToSpam( bot, nManaCost * 0.72 )
		and nMP > 0.38
	then
		nTargetLocation = nAoeLoc
		return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "Q-Harass"
	end

	if #hAllyList == 1
		and #nEnemyHeroesInRange == 1
	then
		nAoeLoc = J.GetAoeEnemyHeroLocation( bot, nCastRange, nRadius, 1 )
		if nAoeLoc ~= nil
			and J.IsAllowedToSpam( bot, nManaCost * 0.72 )
			and nMP > 0.38
			and not nEnemyHeroesInRange[1]:HasModifier( 'modifier_templar_assassin_refraction_absorb' )
		then
			nTargetLocation = nAoeLoc
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "Q-Harass"
		end
	end


	if J.IsGoingOnSomeone( bot )
	then
		if J.IsValidHero( botTarget )
			and J.CanCastOnNonMagicImmune( botTarget )
			and J.IsInRange( botTarget, bot, nCastRange )
		then
			nTargetLocation = botTarget:GetExtrapolatedLocation( nCastPoint )
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "Q-Attack:"..J.Chat.GetNormName( botTarget )
		end
	end


	if J.IsRetreating( bot )
	then
		for _, npcEnemy in pairs( nEnemyHeroesInRange )
		do
			if J.IsValidHero( npcEnemy )
				and J.CanCastOnNonMagicImmune( npcEnemy )
				and bot:WasRecentlyDamagedByHero( npcEnemy, 5.0 )
				and bot:IsFacingLocation( npcEnemy:GetExtrapolatedLocation( nCastPoint ), 20 )
			then
				nTargetLocation = npcEnemy:GetExtrapolatedLocation( nCastPoint )
				return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "Q-Retreat:"..J.Chat.GetNormName( npcEnemy )
			end
		end
	end

	
	if ( J.IsPushing( bot ) or J.IsDefending( bot ) or J.IsFarming( bot ) )
		and J.IsAllowedToSpam( bot, nManaCost * 0.72 )
		and nSkillLV >= 2 and DotaTime() > 8 * 60
		and nLV >= 15
	then
		local nEnemyCreeps = bot:GetNearbyLaneCreeps( nCastRange + nRadius, true )
		if #nEnemyCreeps >= 3
			and J.IsValid( nEnemyCreeps[1] )
			and not nEnemyCreeps[1]:HasModifier( "modifier_fountain_glyph" )
		then
			nAoeLoc = bot:FindAoELocation( true, false, bot:GetLocation(), nCastRange, nRadius, 0, 0 )
			if ( nAoeLoc.count >= 3 )
			then
				nTargetLocation = nAoeLoc.targetloc
				return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "Q-Push:"..nAoeLoc.count
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
		if #nNeutralCreeps >= 2
		then
			local targetCreep = nNeutralCreeps[1]
			if J.IsValid( targetCreep )
				and targetCreep:GetHealth() >= 200
				and J.GetAroundTargetEnemyUnitCount( targetCreep, 300 ) >= 1
			then
				nTargetLocation = targetCreep:GetExtrapolatedLocation( nCastPoint )
				return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "Q-Farm:"..( #nNeutralCreeps )
			end
		end
	end

	
	if bot:GetActiveMode() == BOT_MODE_ROSHAN
		and nMP >= 0.78
	then
		if J.IsRoshan( botTarget )
			and J.GetHP( botTarget ) > 0.15
		then
			nTargetLocation = botTarget:GetLocation()
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "Q-Roshan"
		end
	end


	return BOT_ACTION_DESIRE_NONE, nil

end

function X.ConsiderGrimstrokePhantomsEmbrace( bot )

	X.Init( bot )
	ability = bot:GetAbilityByName( 'grimstroke_ink_creature' )

	if ability == nil then return BOT_ACTION_DESIRE_NONE, nil end
	if not ability:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end

	local nCastRange = ability:GetCastRange() + bonusRange
	local nCastPoint = ability:GetCastPoint()
	local nEnemyHeroesInRange = bot:GetNearbyHeroes( 1400, true, BOT_MODE_NONE )

	
	local npcMostDangerousEnemy = nil
	local npcMostDangerousDamage = 0
	for _, npcEnemy in pairs( nEnemyHeroesInRange )
	do
		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.CanCastOnTargetAdvanced( npcEnemy )
			and J.ShouldInterrupt( npcEnemy )
			and ( nLV >= 6 or nMP > 0.55 )
		then
			return BOT_ACTION_DESIRE_HIGH, npcEnemy, "W-Interrupt:"..J.Chat.GetNormName( npcEnemy )
		end

		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.CanCastOnTargetAdvanced( npcEnemy )
			and npcEnemy:HasModifier( 'modifier_grimstroke_soul_chain' )
		then
			return BOT_ACTION_DESIRE_HIGH, npcEnemy, "W-Ult:"..J.Chat.GetNormName( npcEnemy )
		end

		local npcEnemyDamage = npcEnemy:GetEstimatedDamageToTarget( false, bot, 3.0, DAMAGE_TYPE_MAGICAL )
		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.CanCastOnTargetAdvanced( npcEnemy )
			and not J.IsDisabled( npcEnemy )
			and npcEnemyDamage > npcMostDangerousDamage
			and ( nLV >= 6 or J.GetHP( npcEnemy ) < 0.65 )
		then
			npcMostDangerousDamage = npcEnemyDamage
			npcMostDangerousEnemy = npcEnemy
		end
	end

	if npcMostDangerousEnemy ~= nil
	then
		return BOT_ACTION_DESIRE_HIGH, npcMostDangerousEnemy, "W-Battle:"..J.Chat.GetNormName( npcMostDangerousEnemy )
	end


	if J.IsGoingOnSomeone( bot )
	then
		if J.IsValidHero( botTarget )
			and J.CanCastOnNonMagicImmune( botTarget )
			and J.CanCastOnTargetAdvanced( botTarget )
			and J.IsInRange( botTarget, bot, nCastRange )
			and not J.IsDisabled( botTarget )
		then
			return BOT_ACTION_DESIRE_HIGH, botTarget, "W-Chase:"..J.Chat.GetNormName( botTarget )
		end
	end


	if J.IsRetreating( bot )
	then
		for _, npcEnemy in pairs( nEnemyHeroesInRange )
		do
			if J.IsValidHero( npcEnemy )
				and J.CanCastOnNonMagicImmune( npcEnemy )
				and J.CanCastOnTargetAdvanced( npcEnemy )
				and bot:WasRecentlyDamagedByHero( npcEnemy, 5.0 )
				and bot:IsFacingLocation( npcEnemy:GetExtrapolatedLocation( nCastPoint ), 20 )
				and not J.IsDisabled( npcEnemy )
			then
				return BOT_ACTION_DESIRE_HIGH, npcEnemy, "W-Retreat:"..J.Chat.GetNormName( npcEnemy )
			end
		end
	end

	
	if bot:GetActiveMode() == BOT_MODE_ROSHAN
		and nMP >= 0.78
	then
		if J.IsRoshan( botTarget )
			and J.GetHP( botTarget ) > 0.15
		then
			nTargetLocation = botTarget:GetLocation()
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "W-Roshan"
		end
	end


	return BOT_ACTION_DESIRE_NONE, nil

end

function X.ConsiderGrimstrokeInkSwell( bot )

	X.Init( bot )
	ability = bot:GetAbilityByName( 'grimstroke_spirit_walk' )

	if ability == nil then return BOT_ACTION_DESIRE_NONE, nil end
	if not ability:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end

	local nRadius = ability:GetSpecialValueInt( 'radius' )
	local nAlliedHeroesInRange = bot:GetNearbyHeroes( 1400, false, BOT_MODE_NONE )


	for _, npcAlly in pairs( nAlliedHeroesInRange )
	do
		if J.IsValidHero( npcAlly )
			and ( J.IsDisabled( npcAlly ) or J.ShouldDispelStrongDebuff( npcAlly ) )
		then
			return BOT_ACTION_DESIRE_HIGH, npcAlly, "E-Protect:"..J.Chat.GetNormName( npcAlly )
		end

		if J.IsValidHero( npcAlly )
			and not npcAlly:HasModifier( 'modifier_fountain_aura' )
			and J.GetHP( npcAlly ) < 0.85
			and npcAlly:WasRecentlyDamagedByAnyHero( 1.0 )
		then
			return BOT_ACTION_DESIRE_HIGH, npcAlly, "E-Protect:"..J.Chat.GetNormName( npcAlly )
		end

		if J.IsValidHero( npcAlly )
			and J.GetAroundTargetEnemyHeroCount( npcAlly, nRadius ) >= 1
		then
			return BOT_ACTION_DESIRE_HIGH, npcAlly, "E-Buff:"..J.Chat.GetNormName( npcAlly )
		end
	end

	
	if J.IsGoingOnSomeone( bot )
	then
		local npcAlly = J.GetMeleeAlly( bot )
		if J.IsValidHero( npcAlly )
		then
			return BOT_ACTION_DESIRE_HIGH, npcAlly, "E-Chase:"..J.Chat.GetNormName( botTarget )
		end
	end

	
	if bot:GetActiveMode() == BOT_MODE_ROSHAN
		and nMP >= 0.78
	then
		if J.IsRoshan( botTarget )
			and J.GetHP( botTarget ) > 0.15
		then
			local npcAlly = J.GetMeleeAlly( bot )
			if J.IsValidHero( npcAlly )
			then
				return BOT_ACTION_DESIRE_HIGH, npcAlly, "E-Roshan"
			end
		end
	end


	return BOT_ACTION_DESIRE_NONE, nil

end

function X.ConsiderGrimstrokeDarkPortrait( bot )

	X.Init( bot )
	ability = bot:GetAbilityByName( 'grimstroke_dark_portrait' )

	if ability == nil then return BOT_ACTION_DESIRE_NONE, nil end
	if not ability:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end

	local nCastRange = ability:GetCastRange() + bonusRange
	local nEnemyHeroesInRange = bot:GetNearbyHeroes( 1400, true, BOT_MODE_NONE )


	local npcMostDangerousEnemy = nil
	local npcMostDangerousDamage = 0
	for _, npcEnemy in pairs( nEnemyHeroesInRange )
	do
		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.CanCastOnTargetAdvanced( npcEnemy )
			and npcEnemy:HasModifier( 'modifier_grimstroke_soul_chain' )
		then
			return BOT_ACTION_DESIRE_HIGH, npcEnemy, "D-Ult:"..J.Chat.GetNormName( npcEnemy )
		end

		local npcEnemyDamage = npcEnemy:GetEstimatedDamageToTarget( false, bot, 3.0, DAMAGE_TYPE_PHYSICAL )
		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.CanCastOnTargetAdvanced( npcEnemy )
			and npcEnemyDamage > npcMostDangerousDamage
		then
			npcMostDangerousDamage = npcEnemyDamage
			npcMostDangerousEnemy = npcEnemy
		end
	end

	if npcMostDangerousEnemy ~= nil
	then
		return BOT_ACTION_DESIRE_HIGH, npcMostDangerousEnemy, "D-Battle:"..J.Chat.GetNormName( npcMostDangerousEnemy )
	end


	if J.IsGoingOnSomeone( bot )
	then
		if J.IsValidHero( botTarget )
			and J.CanCastOnNonMagicImmune( botTarget )
			and J.CanCastOnTargetAdvanced( botTarget )
			and J.IsInRange( botTarget, bot, nCastRange )
		then
			return BOT_ACTION_DESIRE_HIGH, botTarget, "D-Chase:"..J.Chat.GetNormName( botTarget )
		end
	end


end

function X.ConsiderGrimstrokeSoulbind( bot )

	X.Init( bot )
	ability = bot:GetAbilityByName( 'grimstroke_soul_chain' )

	if ability == nil then return BOT_ACTION_DESIRE_NONE, nil end
	if not ability:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end

	local nSkillLV = ability:GetLevel()
	local nCastRange = ability:GetCastRange() + bonusRange
	local nRadius = ability:GetSpecialValueInt( 'chain_latch_radius' )
	local nCastPoint = ability:GetCastPoint()
	local nManaCost = ability:GetManaCost()
	local nEnemyHeroesInRange = bot:GetNearbyHeroes( 1400, true, BOT_MODE_NONE )

	if #nEnemyHeroesInRange < 2 then return BOT_ACTION_DESIRE_NONE, nil end

	
	local npcMostDangerousEnemy = nil
	local npcMostDangerousDamage = 0
	for _, npcEnemy in pairs( nEnemyHeroesInRange )
	do
		local npcEnemyDamage = npcEnemy:GetEstimatedDamageToTarget( false, bot, 3.0, DAMAGE_TYPE_PHYSICAL )
		if J.IsValidHero( npcEnemy )
			and J.CanCastOnMagicImmune( npcEnemy )
			and J.CanCastOnTargetAdvanced( npcEnemy )
			and not J.IsDisabled( npcEnemy )
			and npcEnemyDamage > npcMostDangerousDamage
			and J.GetAroundTargetEnemyHeroCount( npcEnemy, nRadius ) >= 1
		then
			npcMostDangerousDamage = npcEnemyDamage
			npcMostDangerousEnemy = npcEnemy
		end
	end

	if npcMostDangerousEnemy ~= nil
	then
		return BOT_ACTION_DESIRE_HIGH, npcMostDangerousEnemy, "R-Battle:"..J.Chat.GetNormName( npcMostDangerousEnemy )
	end


	if J.IsGoingOnSomeone( bot )
	then
		if J.IsValidHero( botTarget )
			and J.CanCastOnMagicImmune( botTarget )
			and J.CanCastOnTargetAdvanced( botTarget )
			and J.IsInRange( botTarget, bot, nCastRange )
			and J.GetAroundTargetEnemyHeroCount( npcEnemy, nRadius ) >= 1
		then
			return BOT_ACTION_DESIRE_HIGH, botTarget, "R-Chase:"..J.Chat.GetNormName( botTarget )
		end
	end


	return BOT_ACTION_DESIRE_NONE, nil

end

-- npc_dota_hero_gyrocopter
-- npc_dota_hero_hoodwink
-- npc_dota_hero_huskar
-- npc_dota_hero_invoker
-- npc_dota_hero_jakiro
-- npc_dota_hero_juggernaut
-- npc_dota_hero_keeper_of_the_light
-- npc_dota_hero_kunkka
-- npc_dota_hero_legion_commander
-- npc_dota_hero_leshrac
-- npc_dota_hero_lich
-- npc_dota_hero_life_stealer
-- npc_dota_hero_lina
-- npc_dota_hero_lion
-- npc_dota_hero_lone_druid
-- npc_dota_hero_luna
-- npc_dota_hero_lycan
-- npc_dota_hero_magnataur
-- npc_dota_hero_marci
-- npc_dota_hero_mars
-- npc_dota_hero_medusa
-- npc_dota_hero_meepo
-- npc_dota_hero_mirana
-- npc_dota_hero_morphling
-- npc_dota_hero_monkey_king
-- npc_dota_hero_naga_siren
-- npc_dota_hero_necrolyte
-- npc_dota_hero_nevermore
-- npc_dota_hero_night_stalker
-- npc_dota_hero_nyx_assassin
-- npc_dota_hero_obsidian_destroyer
-- npc_dota_hero_ogre_magi
-- npc_dota_hero_omniknight
-- npc_dota_hero_oracle
-- npc_dota_hero_pangolier
-- npc_dota_hero_phantom_lancer
-- npc_dota_hero_phantom_assassin
-- npc_dota_hero_phoenix
-- npc_dota_hero_primal_beast
-- npc_dota_hero_puck
-- npc_dota_hero_pudge
-- npc_dota_hero_pugna
-- npc_dota_hero_queenofpain
-- npc_dota_hero_rattletrap
-- npc_dota_hero_razor
-- npc_dota_hero_riki
-- npc_dota_hero_rubick
-- npc_dota_hero_sand_king
-- npc_dota_hero_shadow_demon
-- npc_dota_hero_shadow_shaman
-- npc_dota_hero_shredder
-- npc_dota_hero_silencer
-- npc_dota_hero_skeleton_king
-- npc_dota_hero_skywrath_mage
-- npc_dota_hero_slardar
-- npc_dota_hero_slark
-- npc_dota_hero_snapfire
-- npc_dota_hero_sniper
-- npc_dota_hero_spectre
-- npc_dota_hero_spirit_breaker
-- npc_dota_hero_storm_spirit
-- npc_dota_hero_sven
-- npc_dota_hero_techies
-- npc_dota_hero_terrorblade
-- npc_dota_hero_templar_assassin
-- npc_dota_hero_tidehunter
-- npc_dota_hero_tinker
-- npc_dota_hero_tiny
-- npc_dota_hero_treant
-- npc_dota_hero_troll_warlord
-- npc_dota_hero_tusk
-- npc_dota_hero_undying
-- npc_dota_hero_ursa
-- npc_dota_hero_vengefulspirit
-- npc_dota_hero_venomancer
-- npc_dota_hero_viper
-- npc_dota_hero_visage
-- npc_dota_hero_void_spirit
-- npc_dota_hero_warlock
-- npc_dota_hero_weaver
-- npc_dota_hero_windrunner
-- npc_dota_hero_winter_wyvern
-- npc_dota_hero_wisp
-- npc_dota_hero_witch_doctor
-- npc_dota_hero_zuus
-- neutral

return X