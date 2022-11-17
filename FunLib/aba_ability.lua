----------------------------------------------------------------------------------------------------
--- The Creation Come From: Nikel
----------------------------------------------------------------------------------------------------


local X = {}
local ability = nil
local bonusRange, nMP, nHP, nLV, botTarget, nEnemyHeroesInRange, nAlliedHeroesInRange
-- local BOT_ACTION_DESIRE_NONE, BOT_ACTION_DESIRE_HIGH, BOT_MODE_ROSHAN, DAMAGE_TYPE_MAGICAL, DAMAGE_TYPE_PHYSICAL, DAMAGE_TYPE_PURE, BOT_MODE_NONE, ATTRIBUTE_INTELLECT

local J = require( GetScriptDirectory()..'/FunLib/jmz_func')


function X.Init( bot )

	nLV = bot:GetLevel()
	nMP = bot:GetMana() / bot:GetMaxMana()
	nHP = bot:GetHealth() / bot:GetMaxHealth()
	botTarget = J.GetProperTarget( bot )
	nEnemyHeroesInRange = bot:GetNearbyHeroes( 1400, true, BOT_MODE_NONE )
	nAlliedHeroesInRange = J.GetAlliesNearLoc( bot:GetLocation(), 1400 )
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
	local nTargetLocation

	
	for _, npcEnemy in pairs( nEnemyHeroesInRange )
	do
		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.IsInRange( npcEnemy, bot, nCastRange + nRadius )
			and J.GetHP( npcEnemy ) < 0.55
		then
			nTargetLocation = npcEnemy:GetExtrapolatedLocation( nCastPoint )
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "StrokeOfFate-Attack:"..J.Chat.GetNormName( npcEnemy )
		end

		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.WillMagicKillTarget( bot, npcEnemy, nDamage, nCastPoint )
		then
			nTargetLocation = npcEnemy:GetExtrapolatedLocation( nCastPoint )
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "StrokeOfFate-Kill:"..J.Chat.GetNormName( npcEnemy )
		end

		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.IsInRange( npcEnemy, bot, nCastRange + nRadius )
			and J.IsHealing( npcEnemy )
			and not npcEnemy:HasModifier( 'modifier_templar_assassin_refraction_absorb' )
		then
            nTargetLocation = npcEnemy:GetExtrapolatedLocation( nCastPoint )
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "StrokeOfFate-DispelHeal:"..J.Chat.GetNormName( npcEnemy )
		end
	end
	

	local nAoeLoc = J.GetAoeEnemyHeroLocation( bot, nCastRange, nRadius, 2 )
	if nAoeLoc ~= nil
		and J.IsAllowedToSpam( bot, nManaCost * 0.72 )
		and nMP > 0.38
	then
		nTargetLocation = nAoeLoc
		return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "StrokeOfFate-Harass"
	end

	if #nAlliedHeroesInRange == 1
		and #nEnemyHeroesInRange == 1
	then
		nAoeLoc = J.GetAoeEnemyHeroLocation( bot, nCastRange, nRadius, 1 )
		if nAoeLoc ~= nil
			and J.IsAllowedToSpam( bot, nManaCost * 0.72 )
			and nMP > 0.38
			and not nEnemyHeroesInRange[1]:HasModifier( 'modifier_templar_assassin_refraction_absorb' )
		then
			nTargetLocation = nAoeLoc
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "StrokeOfFate-Harass"
		end
	end


	if J.IsGoingOnSomeone( bot )
	then
		if J.IsValidHero( botTarget )
			and J.CanCastOnNonMagicImmune( botTarget )
			and J.IsInRange( botTarget, bot, nCastRange )
		then
			nTargetLocation = botTarget:GetExtrapolatedLocation( nCastPoint )
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "StrokeOfFate-Attack:"..J.Chat.GetNormName( botTarget )
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
				return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "StrokeOfFate-Retreat:"..J.Chat.GetNormName( npcEnemy )
			end
		end
	end

	
	if ( J.IsPushing( bot ) or J.IsDefending( bot ) or J.IsFarming( bot ) )
		and J.IsAllowedToSpam( bot, nManaCost * 0.72 )
		and nSkillLV >= 2 and DotaTime() > 8 * 60
	then
		local nEnemyCreeps = bot:GetNearbyLaneCreeps( nCastRange + nRadius, true )
		if #nEnemyCreeps >= 3
			and J.IsValid( nEnemyCreeps[1] )
			and not nEnemyCreeps[1]:HasModifier( "modifier_fountain_glyph" )
		then
			nAoeLoc = bot:FindAoELocation( true, false, bot:GetLocation(), nCastRange, nRadius, 0, 0 )
			if nAoeLoc.count >= 3
			then
				nTargetLocation = nAoeLoc.targetloc
				return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "StrokeOfFate-Push:"..nAoeLoc.count
			end
		end
	end
	

	if J.IsFarming( bot )
		and not ( J.IsPushing( bot ) or J.IsDefending( bot ) )
		and J.IsAllowedToSpam( bot, nManaCost * 0.25 )
		and nSkillLV >= 3
		and #nEnemyHeroesInRange == 0
		and #nAlliedHeroesInRange <= 2
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
				return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "StrokeOfFate-Farm:"..( #nNeutralCreeps )
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
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "StrokeOfFate-Roshan"
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

	
	local nMostDangerousEnemy = nil
	local nMostDangerousDamage = 0
	for _, npcEnemy in pairs( nEnemyHeroesInRange )
	do
		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.CanCastOnTargetAdvanced( npcEnemy )
			and J.ShouldInterrupt( npcEnemy )
			and ( nLV >= 6 or nMP > 0.55 )
		then
			return BOT_ACTION_DESIRE_HIGH, npcEnemy, "PhantomsEmbrace-Interrupt:"..J.Chat.GetNormName( npcEnemy )
		end

		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.CanCastOnTargetAdvanced( npcEnemy )
			and npcEnemy:HasModifier( 'modifier_grimstroke_soul_chain' )
		then
			return BOT_ACTION_DESIRE_HIGH, npcEnemy, "PhantomsEmbrace-Ult:"..J.Chat.GetNormName( npcEnemy )
		end
		
		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.IsInRange( npcEnemy, bot, nCastRange )
			and J.GetHP( npcEnemy ) < 0.55
			and ( not J.IsDisabled( npcEnemy ) or not npcEnemy:IsSilenced() )
		then
			return BOT_ACTION_DESIRE_HIGH, npcEnemy, "PhantomsEmbrace-Attack:"..J.Chat.GetNormName( npcEnemy )
		end

		local nEnemyDamage = npcEnemy:GetEstimatedDamageToTarget( false, bot, 3.0, DAMAGE_TYPE_MAGICAL )
		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.CanCastOnTargetAdvanced( npcEnemy )
			and ( not J.IsDisabled( npcEnemy ) or not npcEnemy:IsSilenced() )
			and nEnemyDamage > nMostDangerousDamage
			and ( nLV >= 6 or J.GetHP( npcEnemy ) < 0.65 )
		then
			nMostDangerousDamage = nEnemyDamage
			nMostDangerousEnemy = npcEnemy
		end
	end

	if nMostDangerousEnemy ~= nil
		and J.IsInRange( nMostDangerousEnemy, bot, nCastRange )
	then
		return BOT_ACTION_DESIRE_HIGH, nMostDangerousEnemy, "PhantomsEmbrace-Battle:"..J.Chat.GetNormName( nMostDangerousEnemy )
	end


	if J.IsGoingOnSomeone( bot )
	then
		if J.IsValidHero( botTarget )
			and J.CanCastOnNonMagicImmune( botTarget )
			and J.CanCastOnTargetAdvanced( botTarget )
			and J.IsInRange( botTarget, bot, nCastRange )
			and ( not J.IsDisabled( botTarget ) or not botTarget:IsSilenced() )
		then
			return BOT_ACTION_DESIRE_HIGH, botTarget, "PhantomsEmbrace-Chase:"..J.Chat.GetNormName( botTarget )
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
				and ( not J.IsDisabled( npcEnemy ) or not npcEnemy:IsSilenced() )
			then
				return BOT_ACTION_DESIRE_HIGH, npcEnemy, "PhantomsEmbrace-Retreat:"..J.Chat.GetNormName( npcEnemy )
			end
		end
	end

	
	if bot:GetActiveMode() == BOT_MODE_ROSHAN
		and nMP >= 0.78
	then
		if J.IsRoshan( botTarget )
			and J.GetHP( botTarget ) > 0.15
		then
			return BOT_ACTION_DESIRE_HIGH, botTarget, "PhantomsEmbrace-Roshan"
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


	for _, npcAlly in pairs( nAlliedHeroesInRange )
	do
		if J.IsValidHero( npcAlly )
			and J.CanCastOnMagicImmune( npcAlly )
			and ( J.IsDisabled( npcAlly ) or J.ShouldDispelStrongDebuff( npcAlly ) )
		then
			return BOT_ACTION_DESIRE_HIGH, npcAlly, "InkSwell-Protect:"..J.Chat.GetNormName( npcAlly )
		end

		if J.IsValidHero( npcAlly )
			and J.CanCastOnMagicImmune( npcAlly )
			and not npcAlly:HasModifier( 'modifier_fountain_aura' )
			and J.GetHP( npcAlly ) < 0.85
			and npcAlly:WasRecentlyDamagedByAnyHero( 1.0 )
			and #nEnemyHeroesInRange >= 1
		then
			return BOT_ACTION_DESIRE_HIGH, npcAlly, "InkSwell-Protect:"..J.Chat.GetNormName( npcAlly )
		end

		if J.IsValidHero( npcAlly )
			and J.CanCastOnMagicImmune( npcAlly )
			and J.GetAroundTargetEnemyHeroCount( npcAlly, nRadius ) >= 1
		then
			return BOT_ACTION_DESIRE_HIGH, npcAlly, "InkSwell-Buff:"..J.Chat.GetNormName( npcAlly )
		end
	end

	
	if J.IsGoingOnSomeone( bot )
	then
		local npcAlly = J.GetMeleeAlly( bot )
		if J.IsValidHero( npcAlly )
			and J.CanCastOnMagicImmune( npcAlly )
		then
			return BOT_ACTION_DESIRE_HIGH, npcAlly, "InkSwell-Chase:"..J.Chat.GetNormName( botTarget )
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
				and J.CanCastOnMagicImmune( npcAlly )
			then
				return BOT_ACTION_DESIRE_HIGH, npcAlly, "InkSwell-Roshan"
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


	local nMostDangerousEnemy = nil
	local nMostDangerousDamage = 0
	for _, npcEnemy in pairs( nEnemyHeroesInRange )
	do
		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.CanCastOnTargetAdvanced( npcEnemy )
			and npcEnemy:HasModifier( 'modifier_grimstroke_soul_chain' )
		then
			return BOT_ACTION_DESIRE_HIGH, npcEnemy, "DarkPortrait-Ult:"..J.Chat.GetNormName( npcEnemy )
		end

		local nEnemyDamage = npcEnemy:GetEstimatedDamageToTarget( false, bot, 3.0, DAMAGE_TYPE_PHYSICAL )
		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.CanCastOnTargetAdvanced( npcEnemy )
			and nEnemyDamage > nMostDangerousDamage
		then
			nMostDangerousDamage = nEnemyDamage
			nMostDangerousEnemy = npcEnemy
		end
	end

	if nMostDangerousEnemy ~= nil
		and J.IsInRange( nMostDangerousEnemy, bot, nCastRange )
	then
		return BOT_ACTION_DESIRE_HIGH, nMostDangerousEnemy, "DarkPortrait-Battle:"..J.Chat.GetNormName( nMostDangerousEnemy )
	end


	if J.IsGoingOnSomeone( bot )
	then
		if J.IsValidHero( botTarget )
			and J.CanCastOnNonMagicImmune( botTarget )
			and J.CanCastOnTargetAdvanced( botTarget )
			and J.IsInRange( botTarget, bot, nCastRange )
		then
			return BOT_ACTION_DESIRE_HIGH, botTarget, "DarkPortrait-Chase:"..J.Chat.GetNormName( botTarget )
		end
	end


end

function X.ConsiderGrimstrokeSoulbind( bot )

	X.Init( bot )
	ability = bot:GetAbilityByName( 'grimstroke_soul_chain' )

	if ability == nil then return BOT_ACTION_DESIRE_NONE, nil end
	if not ability:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end

	local nCastRange = ability:GetCastRange() + bonusRange
	local nRadius = ability:GetSpecialValueInt( 'chain_latch_radius' )

	if #nEnemyHeroesInRange < 2 then return BOT_ACTION_DESIRE_NONE, nil end

	
	local nMostDangerousEnemy = nil
	local nMostDangerousDamage = 0
	for _, npcEnemy in pairs( nEnemyHeroesInRange )
	do
		local nEnemyDamage = npcEnemy:GetEstimatedDamageToTarget( false, bot, 3.0, DAMAGE_TYPE_PHYSICAL )
		if J.IsValidHero( npcEnemy )
			and J.CanCastOnMagicImmune( npcEnemy )
			and J.CanCastOnTargetAdvanced( npcEnemy )
			and nEnemyDamage > nMostDangerousDamage
			and J.GetAroundTargetEnemyHeroCount( npcEnemy, nRadius + 250 ) >= 1
		then
			nMostDangerousDamage = nEnemyDamage
			nMostDangerousEnemy = npcEnemy
		end
	end

	if nMostDangerousEnemy ~= nil
	then
		return BOT_ACTION_DESIRE_HIGH, nMostDangerousEnemy, "SoulBind-Battle:"..J.Chat.GetNormName( nMostDangerousEnemy )
	end


	if J.IsGoingOnSomeone( bot )
	then
		if J.IsValidHero( botTarget )
			and J.CanCastOnMagicImmune( botTarget )
			and J.CanCastOnTargetAdvanced( botTarget )
			and J.IsInRange( botTarget, bot, nCastRange )
			and J.GetAroundTargetEnemyHeroCount( botTarget, nRadius + 250 ) >= 1
		then
			return BOT_ACTION_DESIRE_HIGH, botTarget, "SoulBind-Chase:"..J.Chat.GetNormName( botTarget )
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
function X.ConsiderLinaDragonSlave( bot )

	X.Init( bot )
	ability = bot:GetAbilityByName( 'lina_dragon_slave' )

	if ability == nil then return BOT_ACTION_DESIRE_NONE, nil end
	if not ability:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end

	local nSkillLV = ability:GetLevel()
	local nCastRange = ability:GetCastRange() + bonusRange
	local nRadius = ability:GetSpecialValueInt( "dragon_slave_width_end" )
	local nCastPoint = ability:GetCastPoint()
	local nManaCost = ability:GetManaCost()
	local nDamage = ability:GetSpecialValueInt( "AbilityDamage" )
	local nTargetLocation

	
	for _, npcEnemy in pairs( nEnemyHeroesInRange )
	do
		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.IsInRange( npcEnemy, bot, nCastRange + nRadius )
			and J.GetHP( npcEnemy ) < 0.55
		then
			nTargetLocation = botTarget:GetExtrapolatedLocation( nCastPoint )
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'DragonSlave-Attack:'..J.Chat.GetNormName( npcEnemy )
		end

		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.WillMagicKillTarget( bot, npcEnemy, nDamage, nCastPoint )
		then
			nTargetLocation = botTarget:GetExtrapolatedLocation( nCastPoint )
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'DragonSlave-Kill:'..J.Chat.GetNormName( npcEnemy )
		end
		
		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.IsInRange( npcEnemy, bot, nCastRange + nRadius )
			and J.IsHealing( npcEnemy )
			and not npcEnemy:HasModifier( 'modifier_templar_assassin_refraction_absorb' )
		then
			nTargetLocation = botTarget:GetExtrapolatedLocation( nCastPoint )
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'DragonSlave-DispelHeal:'..J.Chat.GetNormName( npcEnemy )
		end
	end
	
	
	local nAoeLoc = J.GetAoeEnemyHeroLocation( bot, nCastRange, nRadius, 2 )
	if nAoeLoc ~= nil
		and J.IsAllowedToSpam( bot, nManaCost * 0.72 )
		and nMP > 0.38
	then
		nTargetLocation = nAoeLoc
		return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'DragonSlave-Harass'
	end

	if #nAlliedHeroesInRange == 1
		and #nEnemyHeroesInRange == 1
	then
		nAoeLoc = J.GetAoeEnemyHeroLocation( bot, nCastRange, nRadius, 1 )
		if nAoeLoc ~= nil
			and J.IsAllowedToSpam( bot, nManaCost * 0.72 )
			and nMP > 0.38
			and not nEnemyHeroesInRange[1]:HasModifier( 'modifier_templar_assassin_refraction_absorb' )
			and nSkillLV >= 2
		then
			nTargetLocation = nAoeLoc
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "DragonSlave-Harass"
		end
	end


	if J.IsGoingOnSomeone( bot )
	then
		if J.IsValidHero( botTarget )
			and J.CanCastOnNonMagicImmune( botTarget )
			and J.IsInRange( botTarget, bot, nCastRange )
		then
			nTargetLocation = botTarget:GetExtrapolatedLocation( nCastPoint )
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'DragonSlave-Attack:'..J.Chat.GetNormName( botTarget )
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
				return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'DragonSlave-Retreat:'..J.Chat.GetNormName( npcEnemy )
			end
		end
	end

	
	if ( J.IsPushing( bot ) or J.IsDefending( bot ) or J.IsFarming( bot ) )
		and J.IsAllowedToSpam( bot, nManaCost * 0.72 )
		and nSkillLV >= 2 and DotaTime() > 8 * 60
	then
		local nEnemyCreeps = bot:GetNearbyLaneCreeps( nCastRange + nRadius, true )
		if #nEnemyCreeps >= 3
			and J.IsValid( nEnemyCreeps[1] )
			and not nEnemyCreeps[1]:HasModifier( "modifier_fountain_glyph" )
		then
			nAoeLoc = bot:FindAoELocation( true, false, bot:GetLocation(), nCastRange, nRadius, 0, 0 )
			if nAoeLoc.count >= 3
			then
				nTargetLocation = nAoeLoc.targetloc
				return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "DragonSlave-Push:"..nAoeLoc.count
			end
		end
	end

	
	if J.IsFarming( bot )
		and not ( J.IsPushing( bot ) or J.IsDefending( bot ) )
		and J.IsAllowedToSpam( bot, nManaCost * 0.25 )
		and nSkillLV >= 3
		and #nEnemyHeroesInRange == 0
		and #nAlliedHeroesInRange <= 2
		and nMP >= 0.55
	then
		local nNeutralCreeps = bot:GetNearbyNeutralCreeps( nCastRange + nRadius )
		if #nNeutralCreeps >= 3 or nMP >= 0.7
		then
			local targetCreep = nNeutralCreeps[1]
			if J.IsValid( targetCreep )
				and targetCreep:GetHealth() >= 300
				and J.GetAroundTargetEnemyUnitCount( targetCreep, 300 ) >= 1
			then
				nTargetLocation = targetCreep:GetExtrapolatedLocation( nCastPoint )
				return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "DragonSlave-Farm:"..( #nNeutralCreeps )
			end
		end
	end

	
	if bot:GetActiveMode() == BOT_MODE_ROSHAN
		and bot:GetMana() >= 400
	then
		if J.IsRoshan( botTarget ) and J.GetHP( botTarget ) > 0.15
			and J.IsInRange( botTarget, bot, nCastRange )
		then
			nTargetLocation = botTarget:GetLocation()
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'DragonSlave-Roshan'
		end
	end

	
	return BOT_ACTION_DESIRE_NONE, nil

end

function X.ConsiderLinaLightStrikeArray( bot )

	X.Init( bot )
	ability = bot:GetAbilityByName( 'lina_light_strike_array' )

	if ability == nil then return BOT_ACTION_DESIRE_NONE, nil end
	if not ability:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end

	local nSkillLV = ability:GetLevel()
	local nCastRange = ability:GetCastRange() + bonusRange
	local nRadius = ability:GetSpecialValueInt( "light_strike_array_aoe" )
	local nCastPoint = ability:GetCastPoint()
	local nCastDelay = 0.5
	local nManaCost = ability:GetManaCost()
	local nDamage = ability:GetSpecialValueInt( 'light_strike_array_damage' )
	local nTargetLocation


	for _, npcEnemy in pairs( nEnemyHeroesInRange )
	do
		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.ShouldInterrupt( npcEnemy )
			and ( nLV >= 6 or nMP > 0.55 )
		then
			nTargetLocation = J.GetDelayCastLocation( bot, npcEnemy, nCastRange, nRadius, nCastPoint + nCastDelay )
			if nTargetLocation ~= nil
			then
				return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "LightStrikeArray-Interrupt:"..J.Chat.GetNormName( npcEnemy )
			end
		end

		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.WillMagicKillTarget( bot, npcEnemy, nDamage, nCastPoint + nCastDelay )
		then
			nTargetLocation = J.GetDelayCastLocation( bot, npcEnemy, nCastRange, nRadius, nCastPoint + nCastDelay )
			if nTargetLocation ~= nil
			then
				return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "LightStrikeArray-Kill:"..J.Chat.GetNormName( npcEnemy )
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
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "LightStrikeArray-ChainStun:"..J.Chat.GetNormName( npcEnemy )
		end
		
		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.IsInRange( npcEnemy, bot, nCastRange + nRadius )
			and J.GetHP( npcEnemy ) < 0.55
			and not J.IsDisabled( npcEnemy )
		then
			nTargetLocation = J.GetDelayCastLocation( bot, npcEnemy, nCastRange, nRadius, nCastPoint + nCastDelay )
			if nTargetLocation ~= nil
			then
				return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "LightStrikeArray-Attack:"..J.Chat.GetNormName( npcEnemy )
			end
		end
	end
	
	
	local nAoeLoc = J.GetAoeEnemyHeroLocation( bot, nCastRange, nRadius, 1 )
	if nAoeLoc ~= nil
	then
		nTargetLocation = nAoeLoc
		return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'LightStrikeArray-Harass'
	end


	if J.IsGoingOnSomeone( bot )
	then
		if J.IsValidHero( botTarget )
			and J.CanCastOnNonMagicImmune( botTarget )
			and J.IsInRange( botTarget, bot, nCastRange )
			and not J.IsDisabled( botTarget )
		then
			nTargetLocation = J.GetDelayCastLocation( bot, botTarget, nCastRange, nRadius, nCastPoint + nCastDelay )
			if nTargetLocation ~= nil
			then
				return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'LightStrikeArray-Attack:'..J.Chat.GetNormName( botTarget )
			end
		end
	end


	if J.IsRetreating( bot )
	then
		nAoeLoc = J.GetAoeEnemyHeroLocation( bot, nCastRange, nRadius, 2 )
		if nAoeLoc ~= nil
		then
			nTargetLocation = nAoeLoc
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'LightStrikeArray-Retreat'
		end

		for _, npcEnemy in pairs( nEnemyHeroesInRange )
		do
			if J.IsValidHero( npcEnemy )
				and bot:WasRecentlyDamagedByHero( npcEnemy, 5.0 )
				and J.CanCastOnNonMagicImmune( npcEnemy )
				and bot:IsFacingLocation( npcEnemy:GetExtrapolatedLocation( nCastPoint ), 20 )
				and not J.IsDisabled( npcEnemy )
			then
				nTargetLocation = J.GetDelayCastLocation( bot, npcEnemy, nCastRange, nRadius, nCastPoint + nCastDelay )
				if nTargetLocation ~= nil
				then
					return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'LightStrikeArray-Retreat:'..J.Chat.GetNormName( npcEnemy )
				end
			end
		end
	end

	
	if ( J.IsPushing( bot ) or J.IsDefending( bot ) or J.IsFarming( bot ) )
		and J.IsAllowedToSpam( bot, nManaCost * 0.72 )
		and nSkillLV >= 2 and DotaTime() > 8 * 60
	then
		local nEnemyCreeps = bot:GetNearbyLaneCreeps( nCastRange + nRadius, true )
		if #nEnemyCreeps >= 3
			and J.IsValid( nEnemyCreeps[1] )
			and not nEnemyCreeps[1]:HasModifier( "modifier_fountain_glyph" )
		then
			nAoeLoc = bot:FindAoELocation( true, false, bot:GetLocation(), nCastRange, nRadius, 0, 0 )
			if nAoeLoc.count >= 3
			then
				nTargetLocation = nAoeLoc.targetloc
				return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "LightStrikeArray-ClearWave:"..nAoeLoc.count
			end
		end
	end

	
	if J.IsFarming( bot )
		and not ( J.IsPushing( bot ) or J.IsDefending( bot ) )
		and J.IsAllowedToSpam( bot, nManaCost * 0.25 )
		and nSkillLV >= 3
		and #nEnemyHeroesInRange == 0
		and #nAlliedHeroesInRange <= 2
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
				return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "LightStrikeArray-Farm:"..( #nNeutralCreeps )
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
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'LightStrikeArray-Roshan'
		end
	end

	
	return BOT_ACTION_DESIRE_NONE, nil

end

function X.ConsiderLinaFlameCloak( bot )

	X.Init( bot )
	ability = bot:GetAbilityByName( 'lina_flame_cloak' )

	if ability == nil then return BOT_ACTION_DESIRE_NONE, nil end
	if not ability:IsFullyCastable()
		or not bot:HasScepter()
	then
		return BOT_ACTION_DESIRE_NONE, nil
	end


	if J.IsInTeamFight( bot, 1400 )
	then
		if #nEnemyHeroesInRange >= #nAlliedHeroesInRange
		then
			return BOT_ACTION_DESIRE_HIGH, "FlameCloak-Battle"
		end
	end


	if J.IsGoingOnSomeone( bot )
	then
		if J.IsValidHero( botTarget )
			and J.IsInRange( botTarget, bot, 700 )
			and J.CanCastOnNonMagicImmune( botTarget )
		then
			return BOT_ACTION_DESIRE_HIGH, "FlameCloak-Chase:"..J.Chat.GetNormName( botTarget )
		end
	end


	if J.IsRetreating( bot )
	then
		if #nEnemyHeroesInRange >= 1
			and J.IsValidHero( nEnemyHeroesInRange[1] )
			and J.WasRecentlyDamagedByAnyHero( bot, 5.0 )
		then
			return BOT_ACTION_DESIRE_HIGH, "FlameCloak-Retreat"
		end
	end

	
	return BOT_ACTION_DESIRE_NONE, nil

end

function X.ConsiderLinaLagunaBlade( bot )

	X.Init( bot )
	ability = bot:GetAbilityByName( 'lina_laguna_blade' )
	local talent = bot:GetAbilityByName( 'special_bonus_unique_lina_7' )

	if ability == nil then return BOT_ACTION_DESIRE_NONE, nil end
	if not ability:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end

	local nCastRange = ability:GetCastRange() + bonusRange
	local nCastPoint = ability:GetCastPoint()
	local nDamage = ability:GetSpecialValueInt( "damage" )
	local nDamageType = talent:IsTrained() and DAMAGE_TYPE_PURE or DAMAGE_TYPE_MAGICAL

	
	local nWeakestEnemy = nil
	local nWeakestEnemyHealth = 100000
	for _, npcEnemy in pairs( nEnemyHeroesInRange )
	do
		if J.IsValidHero( npcEnemy )
			and X.CanCastAbilityLinaLagunaBlade( npcEnemy, talent )
		then
			if ( nDamageType == DAMAGE_TYPE_MAGICAL
					and J.WillMagicKillTarget( bot, npcEnemy, nDamage, nCastPoint ) )
				or J.WillKillTarget( npcEnemy, nDamage, nDamageType, nCastPoint )
			then
				return BOT_ACTION_DESIRE_HIGH, npcEnemy, "LagunaBlade-Kill:"..J.Chat.GetNormName( npcEnemy )
			end
		end

		if J.IsValidHero( npcEnemy )
			and X.CanCastAbilityLinaLagunaBlade( botTarget, talent )
			and J.GetHP( npcEnemy ) < 0.45
			and npcEnemy:GetHealth() < nWeakestEnemyHealth
		then
			nWeakestEnemyHealth = npcEnemy:GetHealth()
			nWeakestEnemy = npcEnemy
		end
	end

	if nWeakestEnemy ~= nil
		and J.IsInRange( nWeakestEnemy, bot, nCastRange )
	then
		return BOT_ACTION_DESIRE_HIGH, nWeakestEnemy, "LagunaBlade-Battle:"..J.Chat.GetNormName( nWeakestEnemy )
	end
	
	
	if J.IsGoingOnSomeone( bot )
	then
		if J.IsValidHero( botTarget )
			and X.CanCastAbilityLinaLagunaBlade( botTarget, talent )
			and J.IsInRange( botTarget, bot, nCastRange )
			and J.WillMagicKillTarget( bot, botTarget, nDamage * 1.88, nCastPoint )
		then
			return BOT_ACTION_DESIRE_HIGH, botTarget, "LagunaBlade-Attack:"..J.Chat.GetNormName( botTarget )
		end
	end

	
	return BOT_ACTION_DESIRE_NONE, nil

end

function X.CanCastAbilityLinaLagunaBlade( nTarget, talent )

	if J.CanCastOnTargetAdvanced( nTarget )
		and not nTarget:HasModifier( "modifier_arc_warden_tempest_double" )
	then
		if talent:IsTrained()
		then
			return J.CanCastOnMagicImmune( nTarget )
		else
			return J.CanCastOnNonMagicImmune( nTarget )
		end
	end

	return false

end

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
function X.ConsiderNecronomiconPurge( bot )

	X.Init( bot )
	ability = bot:GetAbilityByName( 'necronomicon_archer_purge' )

	if ability == nil then return BOT_ACTION_DESIRE_NONE, nil end
	if not ability:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end

	local nCastRange = ability:GetCastRange() + bonusRange

	
	for _, npcEnemy in pairs( nEnemyHeroesInRange )
	do
		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.CanCastOnTargetAdvanced( npcEnemy )
			and J.IsInRange( npcEnemy, bot, nCastRange )
			and J.ShouldDispelBuff( npcEnemy )
		then
			return BOT_ACTION_DESIRE_HIGH, npcEnemy, "Purge-Dispel:"..J.Chat.GetNormName( npcEnemy )
		end
	end


	if J.IsGoingOnSomeone( bot )
	then
		if J.IsValidHero( botTarget )
			and J.CanCastOnNonMagicImmune( botTarget )
			and J.CanCastOnTargetAdvanced( botTarget )
			and J.IsInRange( botTarget, bot, nCastRange )
		then
			return BOT_ACTION_DESIRE_HIGH, botTarget, "Purge-Chase:"..J.Chat.GetNormName( botTarget )
		end
	end

	
	for _, npcAlly in pairs( nAlliedHeroesInRange )
	do
		if J.IsValidHero( npcAlly )
			and J.IsRetreating( npcAlly )
			and bot:WasRecentlyDamagedByAnyHero( 5.0 )
			and not J.IsDisabled( nEnemyHeroesInRange[1] )
		then
			return BOT_ACTION_DESIRE_HIGH, nEnemyHeroesInRange[1], "Purge-Retreat:"..J.Chat.GetNormName( nEnemyHeroesInRange[1] )
		end
	end


	return BOT_ACTION_DESIRE_NONE, nil

end

function X.ConsiderNeutralFrenzy( bot )

	X.Init( bot )
	ability = bot:GetAbilityByName( 'big_thunder_lizard_frenzy' )

	if ability == nil then return BOT_ACTION_DESIRE_NONE, nil end
	if not ability:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end

	local nCastRange = ability:GetCastRange() + bonusRange

	
	local nStrongestAlly = nil
	local nStrongestDamage = 0
	for _, npcAlly in pairs( nAlliedHeroesInRange )
	do
		local npcAllyDamage = npcAlly:GetEstimatedDamageToTarget( false, bot, 3.0, DAMAGE_TYPE_PHYSICAL )
		if J.IsValidHero( npcAlly )
			and J.CanCastOnMagicImmune( npcAlly )
			and ( not J.IsDisabled( npcAlly ) or not npcAlly:IsDisarmed() )
			and npcAllyDamage > nStrongestDamage
			and #nEnemyHeroesInRange >= 1
		then
			nStrongestDamage = npcAllyDamage
			nStrongestAlly = npcAlly
		end
	end

	if nStrongestAlly ~= nil
		and J.IsInRange( nStrongestAlly, bot, nCastRange )
	then
		return BOT_ACTION_DESIRE_HIGH, nStrongestAlly, "Frenzy-Buff:"..J.Chat.GetNormName( nStrongestAlly )
	end


	return BOT_ACTION_DESIRE_NONE, nil

end

function X.ConsiderNeutralSlam( bot )

	X.Init( bot )
	ability = bot:GetAbilityByName( 'big_thunder_lizard_slam' )

	if ability == nil then return BOT_ACTION_DESIRE_NONE, nil end
	if not ability:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end

	local nRadius = ability:GetSpecialValueInt( 'radius' )

	
	for _, npcEnemy in pairs( nEnemyHeroesInRange )
	do
		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.IsInRange( npcEnemy, bot, nRadius )
			and not J.IsDisabled( npcEnemy )
		then
			return BOT_ACTION_DESIRE_HIGH, "Slam-Slow:"..J.Chat.GetNormName( npcEnemy )
		end
	end

	
	if bot:GetActiveMode() == BOT_MODE_ROSHAN
		and nMP >= 0.78
	then
		if J.IsRoshan( botTarget )
			and J.GetHP( botTarget ) > 0.15
			and J.IsInRange( botTarget, bot, nRadius )
			and not J.IsDisabled( botTarget )
		then
			return BOT_ACTION_DESIRE_HIGH, "Slam-Roshan"
		end
	end


	return BOT_ACTION_DESIRE_NONE, nil

end

function X.ConsiderNeutralFireball( bot )

	X.Init( bot )
	ability = bot:GetAbilityByName( 'black_dragon_fireball' )

	if ability == nil then return BOT_ACTION_DESIRE_NONE, nil end
	if not ability:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end

	local nCastRange = ability:GetCastRange() + bonusRange
	local nRadius = ability:GetSpecialValueInt( 'radius' )
	local nTargetLocation


	if #nEnemyHeroesInRange >= 1
	then
		local nAoeLoc = J.GetAoeEnemyHeroLocation( bot, nCastRange, nRadius, 1 )
		if nAoeLoc ~= nil
		then
			nTargetLocation = nAoeLoc
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "Fireball-Battle"
		end
	end

	
	if J.IsGoingOnSomeone( bot )
	then
		if J.IsValidHero( botTarget )
			and J.CanCastOnNonMagicImmune( botTarget )
			and J.IsInRange( botTarget, bot, nCastRange )
		then
			nTargetLocation = J.GetCastLocation( bot, botTarget, nCastRange, nRadius )
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "Fireball-Attack:"..J.Chat.GetNormName( botTarget )
		end
	end

	
	if J.IsRetreating( bot )
	then
		for _, npcEnemy in pairs( nEnemyHeroesInRange )
		do
			if J.IsValidHero( npcEnemy )
				and bot:WasRecentlyDamagedByHero( npcEnemy, 5.0 )
				and J.CanCastOnNonMagicImmune( npcEnemy )
				and bot:IsFacingLocation( npcEnemy:GetExtrapolatedLocation( 0.3 ), 20 )
			then
				nTargetLocation = J.GetCastLocation( bot, npcEnemy, nCastRange, nRadius )
				return BOT_ACTION_DESIRE_HIGH, nTargetLocation, 'Fireball-Retreat:'..J.Chat.GetNormName( npcEnemy )
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
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "Fireball-Roshan"
		end
	end


	return BOT_ACTION_DESIRE_NONE, nil

end

function X.ConsiderNeutralWarStomp( bot )

	X.Init( bot )
	ability = bot:GetAbilityByName( 'centaur_khan_war_stomp' )

	if ability == nil then return BOT_ACTION_DESIRE_NONE, nil end
	if not ability:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end

	local nRadius = ability:GetSpecialValueInt( 'radius' )

	
	for _, npcEnemy in pairs( nEnemyHeroesInRange )
	do
		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.IsInRange( npcEnemy, bot, nRadius )
			and J.ShouldInterrupt( npcEnemy )
		then
			return BOT_ACTION_DESIRE_HIGH, "WarStomp-Interrupt:"..J.Chat.GetNormName( npcEnemy )
		end

		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.IsInRange( npcEnemy, bot, nRadius )
			and not J.IsDisabled( npcEnemy )
		then
			return BOT_ACTION_DESIRE_HIGH, "WarStomp-Stun:"..J.Chat.GetNormName( npcEnemy )
		end
	end

	
	if bot:GetActiveMode() == BOT_MODE_ROSHAN
		and nMP >= 0.78
	then
		if J.IsRoshan( botTarget )
			and J.GetHP( botTarget ) > 0.15
			and J.IsInRange( botTarget, bot, nRadius )
			and not J.IsDisabled( botTarget )
		then
			return BOT_ACTION_DESIRE_HIGH, "WarStomp-Roshan"
		end
	end


	return BOT_ACTION_DESIRE_NONE, nil

end

function X.ConsiderNeutralEnsnare( bot )

	X.Init( bot )
	ability = bot:GetAbilityByName( 'dark_troll_warlord_ensnare' )

	if ability == nil then return BOT_ACTION_DESIRE_NONE, nil end
	if not ability:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end
	
	local nCastRange = ability:GetCastRange() + bonusRange


	for _, npcEnemy in pairs( nEnemyHeroesInRange )
	do
		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.CanCastOnTargetAdvanced( npcEnemy )
			and npcEnemy:IsChanneling()
			and npcEnemy:HasModifier( 'modifier_teleporting' )
		then
			return BOT_ACTION_DESIRE_HIGH, npcEnemy, "Ensnare-Root"
		end
	end

	
	if J.IsGoingOnSomeone( bot )
	then
		if J.IsValidHero( botTarget )
			and J.CanCastOnNonMagicImmune( botTarget )
			and J.CanCastOnTargetAdvanced( botTarget )
			and not J.IsDisabled( botTarget )
			and J.IsInRange( botTarget, bot, nCastRange )
		then
			return BOT_ACTION_DESIRE_HIGH, botTarget, "Ensnare-Chase:"..J.Chat.GetNormName( botTarget )
		end
	end


	return BOT_ACTION_DESIRE_NONE, nil

end

function X.ConsiderNeutralRaiseDead( bot )

	X.Init( bot )
	ability = bot:GetAbilityByName( 'dark_troll_warlord_raise_dead' )

	if ability == nil then return BOT_ACTION_DESIRE_NONE, nil end
	if not ability:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end

	return BOT_ACTION_DESIRE_HIGH, "RaiseDead"
	
end

function X.ConsiderNeutralHurricane( bot )

	X.Init( bot )
	ability = bot:GetAbilityByName( 'enraged_wildkin_hurricane' )

	if ability == nil then return BOT_ACTION_DESIRE_NONE, nil end
	if not ability:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end

	local nCastRange = ability:GetCastRange() + bonusRange
	local nTargetLocation


	for _, npcEnemy in pairs( nEnemyHeroesInRange )
	do
		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.CanCastOnTargetAdvanced( npcEnemy )
			and J.IsInRange( npcEnemy, bot, nCastRange )
		then
			nTargetLocation = J.GetFaceTowardDistanceLocation( botTarget, nCastRange )
			return BOT_ACTION_DESIRE_HIGH, botTarget, nTargetLocation, "Hurricane-Battle:"..J.Chat.GetNormName( npcEnemy )
		end
	end

	
	if J.IsGoingOnSomeone( bot )
	then
		if J.IsValidHero( botTarget )
			and J.CanCastOnNonMagicImmune( botTarget )
			and J.CanCastOnTargetAdvanced( botTarget )
			and J.IsInRange( botTarget, bot, nCastRange )
		then
			nTargetLocation = J.GetFaceTowardDistanceLocation( botTarget, nCastRange * -1 )
			return BOT_ACTION_DESIRE_HIGH, botTarget, nTargetLocation, "Hurricane-Chase:"..J.Chat.GetNormName( botTarget )
		end
	end

	
	if J.IsRetreating( bot )
	then
		for _, npcAlly in pairs( nAlliedHeroesInRange )
		do
			if #nEnemyHeroesInRange >= 1
				and J.IsValidHero( npcAlly )
				and npcAlly:WasRecentlyDamagedByAnyHero( 5.0 )
				and J.CanCastOnNonMagicImmune( nEnemyHeroesInRange[1] )
				and J.CanCastOnTargetAdvanced( nEnemyHeroesInRange[1] )
			then
				nTargetLocation = J.GetFaceTowardDistanceLocation( botTarget, nCastRange * -1 )
				return BOT_ACTION_DESIRE_HIGH, botTarget, nTargetLocation, "Hurricane-Retreat:"..J.Chat.GetNormName( botTarget )
			end
		end
	end

	
	return BOT_ACTION_DESIRE_NONE, nil

end

function X.ConsiderNeutralTornado( bot )

	X.Init( bot )
	ability = bot:GetAbilityByName( 'enraged_wildkin_tornado' )

	if ability == nil then return BOT_ACTION_DESIRE_NONE, nil end
	if not ability:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end

	local nCastRange = ability:GetCastRange() + bonusRange
	local nRadius = 150
	local nTargetLocation


	if #nEnemyHeroesInRange >= 1
		and J.IsValidHero( nEnemyHeroesInRange[1] )
		and J.CanCastOnNonMagicImmune( nEnemyHeroesInRange[1] )
		and J.IsInRange( nEnemyHeroesInRange[1], bot, nCastRange + 200 )
	then
		nTargetLocation = J.GetCastLocation( bot, nEnemyHeroesInRange[1], nCastRange, nRadius )
		return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "Tornado-Battle:"..J.Chat.GetNormName( nEnemyHeroesInRange[1] )
	end

	
	return BOT_ACTION_DESIRE_NONE, nil

end

function X.ConsiderNeutralVex( bot )

	X.Init( bot )
	ability = bot:GetAbilityByName( 'fel_beast_haunt' )

	if ability == nil then return BOT_ACTION_DESIRE_NONE, nil end
	if not ability:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end

	local nCastRange = ability:GetCastRange() + bonusRange

	
	for _, npcEnemy in pairs( nEnemyHeroesInRange )
	do
		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.CanCastOnTargetAdvanced( npcEnemy )
			and J.IsInRange( npcEnemy, bot, nCastRange )
			and J.ShouldInterrupt( npcEnemy )
		then
			return BOT_ACTION_DESIRE_HIGH, npcEnemy, "Vex-Interrupt:"..J.Chat.GetNormName( npcEnemy )
		end

		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.CanCastOnTargetAdvanced( npcEnemy )
			and J.IsInRange( npcEnemy, bot, nCastRange )
			and ( not J.IsDisabled( npcEnemy ) or not npcEnemy:IsSilenced() )
		then
			return BOT_ACTION_DESIRE_HIGH, npcEnemy, "Vex-Silence:"..J.Chat.GetNormName( npcEnemy )
		end
	end

	
	if bot:GetActiveMode() == BOT_MODE_ROSHAN
		and nMP >= 0.78
	then
		if J.IsRoshan( botTarget )
			and J.GetHP( botTarget ) > 0.15
			and ( not J.IsDisabled( botTarget ) or not botTarget:IsSilenced() )
		then
			return BOT_ACTION_DESIRE_HIGH, botTarget, "Vex-Roshan"
		end
	end


	return BOT_ACTION_DESIRE_NONE, nil

end

function X.ConsiderNeutralHeal( bot )

	X.Init( bot )
	ability = bot:GetAbilityByName( 'forest_troll_high_priest_heal' )

	if ability == nil then return BOT_ACTION_DESIRE_NONE, nil end
	if not ability:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end

	local nCastRange = ability:GetCastRange() + bonusRange
	local nHealAmount = ability:GetSpecialValueInt( 'health' )


	local nLowestHealthAlly = nil
	local nLowestHealthPct = 100
	for _, npcAlly in pairs( nAlliedHeroesInRange )
	do
		if J.IsValidHero( npcAlly )
			and J.CanCastOnMagicImmune( npcAlly )
			and J.GetHealth( npcAlly ) < nHealAmount * 1.12
			and J.GetHP( npcAlly ) < nLowestHealthPct
		then
			nLowestHealthPct = J.GetHP( npcAlly )
			nLowestHealthAlly = npcAlly
		end
	end

	if nLowestHealthAlly ~= nil
		and J.IsInRange( nLowestHealthAlly, bot, nCastRange )
	then
		return BOT_ACTION_DESIRE_HIGH, nLowestHealthAlly, "Heal-Heal:"..J.Chat.GetNormName( nLowestHealthAlly )
	end

	
	return BOT_ACTION_DESIRE_NONE, nil

end

function X.ConsiderNeutralTakeOff( bot )

	X.Init( bot )
	ability = bot:GetAbilityByName( 'harpy_scout_take_off' )

	if ability == nil then return BOT_ACTION_DESIRE_NONE, nil end
	if not ability:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end


	--------
	--TODO--
	--------

	
	return BOT_ACTION_DESIRE_NONE, nil

end

function X.ConsiderNeutralChainLightning( bot )

	X.Init( bot )
	ability = bot:GetAbilityByName( 'harpy_storm_chain_lightning' )

	if ability == nil then return BOT_ACTION_DESIRE_NONE, nil end
	if not ability:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end

	local nCastRange = ability:GetCastRange() + bonusRange


	for _, npcEnemy in pairs( nEnemyHeroesInRange )
	do
		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.CanCastOnTargetAdvanced( npcEnemy )
			and J.IsInRange( npcEnemy, bot, nCastRange )
		then
			return BOT_ACTION_DESIRE_HIGH, nil, "ChainLightning-Battle:"..J.Chat.GetNormName( npcEnemy )
		end
	end

	
	return BOT_ACTION_DESIRE_NONE, nil

end

function X.ConsiderNeutralIcefireBomb( bot )

	X.Init( bot )
	ability = bot:GetAbilityByName( 'ice_shaman_incendiary_bomb' )

	if ability == nil then return BOT_ACTION_DESIRE_NONE, nil end
	if not ability:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end

	local nCastRange = ability:GetCastRange() + bonusRange


	for _, npcEnemy in pairs( nEnemyHeroesInRange )
	do
		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.CanCastOnTargetAdvanced( npcEnemy )
			and J.IsInRange( npcEnemy, bot, nCastRange )
		then
			return BOT_ACTION_DESIRE_HIGH, nil, "IcefireBomb-Battle:"..J.Chat.GetNormName( npcEnemy )
		end
	end


	local nTowerList = bot:GetNearbyTowers( 1000, true )
	local nBarrackList = bot:GetNearbyBarracks( 1000, true )
	local nEnemyAncient = GetAncient( GetOpposingTeam() )
	local nBuildingList = {
		botTarget,
		nTowerList[1],
		nBarrackList[1],
		nEnemyAncient,
	}

	for _, building in pairs( nBuildingList )
	do
		if J.IsValidBuilding( building )
			and J.IsInRange( bot, building, nCastRange )
			and not building:HasModifier( 'modifier_fountain_glyph' )
			and not building:HasModifier( 'modifier_invulnerable' )
			and not building:HasModifier( 'modifier_backdoor_protection' )
			and not J.IsKeyWordUnit( "DOTA_Outpost", building )
		then
			return BOT_ACTION_DESIRE_HIGH, building, "IcefireBomb-Tower"
		end
	end

	
	if bot:GetActiveMode() == BOT_MODE_ROSHAN
		and nMP >= 0.78
	then
		if J.IsRoshan( botTarget )
			and J.GetHP( botTarget ) > 0.15
		then
			return BOT_ACTION_DESIRE_HIGH, botTarget, "IcefireBomb-Roshan"
		end
	end

	
	return BOT_ACTION_DESIRE_NONE, nil

end

function X.ConsiderNeutralHurlBoulder( bot )

	X.Init( bot )
	ability = bot:GetAbilityByName( 'mud_golem_hurl_boulder' )

	if ability == nil then return BOT_ACTION_DESIRE_NONE, nil end
	if not ability:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end

	local nCastRange = ability:GetCastRange() + bonusRange


	for _, npcEnemy in pairs( nEnemyHeroesInRange )
	do
		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.CanCastOnTargetAdvanced( npcEnemy )
			and J.ShouldInterrupt( npcEnemy )
		then
			return BOT_ACTION_DESIRE_HIGH, npcEnemy, "HurlBoulder-Interrupt:"..J.Chat.GetNormName( npcEnemy )
		end
	end


	if J.IsValidHero( botTarget )
		and J.CanCastOnNonMagicImmune( botTarget )
		and J.CanCastOnTargetAdvanced( botTarget )
		and J.IsInRange( botTarget, bot, nCastRange )
		and not J.IsDisabled( botTarget )
	then
		return BOT_ACTION_DESIRE_HIGH, botTarget, "HurlBoulder-Chase:"..J.Chat.GetNormName( botTarget )
	end


	if J.IsRetreating( bot )
	then
		for _, npcEnemy in pairs( nEnemyHeroesInRange )
		do
			if J.IsValidHero( npcEnemy )
				and J.CanCastOnNonMagicImmune( npcEnemy )
				and J.CanCastOnTargetAdvanced( npcEnemy )
				and bot:WasRecentlyDamagedByHero( npcEnemy, 5.0 )
				and bot:IsFacingLocation( npcEnemy:GetExtrapolatedLocation( 0.3 ), 20 )
				and not J.IsDisabled( npcEnemy )
			then
				return BOT_ACTION_DESIRE_HIGH, npcEnemy, "HurlBoulder-Retreat:"..J.Chat.GetNormName( npcEnemy )
			end
		end
	end

	
	if bot:GetActiveMode() == BOT_MODE_ROSHAN
		and nMP >= 0.78
	then
		if J.IsRoshan( botTarget )
			and J.GetHP( botTarget ) > 0.15
			and not J.IsDisabled( botTarget )
		then
			return BOT_ACTION_DESIRE_HIGH, botTarget, "HurlBoulder-Roshan"
		end
	end

	
	return BOT_ACTION_DESIRE_NONE, nil

end

function X.ConsiderNeutralIceArmor( bot )

	X.Init( bot )
	ability = bot:GetAbilityByName( 'ogre_magi_frost_armor' )

	if ability == nil then return BOT_ACTION_DESIRE_NONE, nil end
	if not ability:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end


	for _, npcAlly in pairs( nAlliedHeroesInRange )
	do
		if J.IsValidHero( npcAlly )
			and J.CanCastOnMagicImmune( npcAlly )
			and not npcAlly:HasModifier( 'modifier_ogre_magi_frost_armor' )
		then
			return BOT_ACTION_DESIRE_HIGH, npcAlly, "IceArmor-Protect:"..J.Chat.GetNormName( npcAlly )
		end
	end


	
	return BOT_ACTION_DESIRE_NONE, nil

end

function X.ConsiderNeutralOgreSmash( bot )

	X.Init( bot )
	ability = bot:GetAbilityByName( 'ogre_bruiser_ogre_smash' )

	if ability == nil then return BOT_ACTION_DESIRE_NONE, nil end
	if not ability:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end

	local nRadius = ability:GetSpecialValueInt( 'radius' )
	local nCastPoint = ability:GetCastPoint()


	for _, npcEnemy in pairs( nEnemyHeroesInRange )
	do
		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.ShouldInterrupt( npcEnemy )
			and bot:IsFacingLocation( npcEnemy:GetExtrapolatedLocation( nCastPoint ), 20 )
			and J.IsInRange( npcEnemy, bot, nRadius * 2 )
		then
			return BOT_ACTION_DESIRE_HIGH, npcEnemy, "OgreSmash-Interrupt:"..J.Chat.GetNormName( npcEnemy )
		end
	end

	
	return BOT_ACTION_DESIRE_NONE, nil

end

function X.ConsiderNeutralThunderClap( bot )

	X.Init( bot )
	ability = bot:GetAbilityByName( 'polar_furbolg_ursa_warrior_thunder_clap' )

	if ability == nil then return BOT_ACTION_DESIRE_NONE, nil end
	if not ability:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end

	local nRadius = ability:GetSpecialValueInt( 'radius' )


	for _, npcEnemy in pairs( nEnemyHeroesInRange )
	do
		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.IsInRange( npcEnemy, bot, nRadius )
			and not J.IsDisabled( npcEnemy )
		then
			return BOT_ACTION_DESIRE_HIGH, "ThunderClap-Slow"
		end
	end
	
	
	if bot:GetActiveMode() == BOT_MODE_ROSHAN
		and nMP >= 0.78
	then
		if J.IsRoshan( botTarget )
			and J.GetHP( botTarget ) > 0.15
			and J.IsInRange( botTarget, bot, nRadius )
		then
			return BOT_ACTION_DESIRE_HIGH, botTarget, "ThunderClap-Roshan"
		end
	end

	
	return BOT_ACTION_DESIRE_NONE, nil

end

function X.ConsiderNeutralShockwave( bot )

	X.Init( bot )
	ability = bot:GetAbilityByName( 'satyr_hellcaller_shockwave' )

	if ability == nil then return BOT_ACTION_DESIRE_NONE, nil end
	if not ability:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end

	local nCastRange = ability:GetCastRange() + bonusRange
	local nRadius = ability:GetSpecialValueInt( 'radius_end' )
	local nCastPoint = ability:GetCastPoint()
	local nDamage = ability:GetAbilityDamage()
	local nTargetLocation

	
	for _, npcEnemy in pairs( nEnemyHeroesInRange )
	do
		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.GetHP( npcEnemy ) < 0.55
		then
			nTargetLocation = npcEnemy:GetExtrapolatedLocation( nCastPoint )
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "Shockwave-Attack:"..J.Chat.GetNormName( npcEnemy )
		end

		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.WillMagicKillTarget( bot, npcEnemy, nDamage, nCastPoint )
		then
			nTargetLocation = npcEnemy:GetExtrapolatedLocation( nCastPoint )
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "Shockwave-Kill:"..J.Chat.GetNormName( npcEnemy )
		end
	end

	
	local nAoeLoc = J.GetAoeEnemyHeroLocation( bot, nCastRange, nRadius, 1 )
	if nAoeLoc ~= nil
	then
		nTargetLocation = nAoeLoc
		return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "Shockwave-Harass"
	end


	if J.IsGoingOnSomeone( bot )
	then
		if J.IsValidHero( botTarget )
			and J.CanCastOnNonMagicImmune( botTarget )
			and J.IsInRange( botTarget, bot, nCastRange )
		then
			nTargetLocation = botTarget:GetExtrapolatedLocation( nCastPoint )
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "Shockwave-Attack:"..J.Chat.GetNormName( botTarget )
		end
	end
	

	local nEnemyCreeps = bot:GetNearbyLaneCreeps( nCastRange + nRadius, true )
	if #nEnemyCreeps >= 3
		and J.IsValid( nEnemyCreeps[1] )
		and not nEnemyCreeps[1]:HasModifier( "modifier_fountain_glyph" )
	then
		nAoeLoc = bot:FindAoELocation( true, false, bot:GetLocation(), nCastRange, nRadius, 0, 0 )
		if ( nAoeLoc.count >= 3 )
		then
			nTargetLocation = nAoeLoc.targetloc
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "Shockwave-Push:"..nAoeLoc.count
		end
	end
	

	local nNeutralCreeps = bot:GetNearbyNeutralCreeps( nCastRange + nRadius )
	if #nNeutralCreeps >= 2
	then
		local targetCreep = nNeutralCreeps[1]
		if J.IsValid( targetCreep )
			and targetCreep:GetHealth() >= 200
			and J.GetAroundTargetEnemyUnitCount( targetCreep, 300 ) >= 1
		then
			nTargetLocation = targetCreep:GetExtrapolatedLocation( nCastPoint )
			return BOT_ACTION_DESIRE_HIGH, nTargetLocation, "Shockwave-Farm:"..( #nNeutralCreeps )
		end
	end

	
	return BOT_ACTION_DESIRE_NONE, nil

end

function X.ConsiderNeutralManaBurn( bot )

	X.Init( bot )
	ability = bot:GetAbilityByName( 'satyr_soulstealer_mana_burn' )

	if ability == nil then return BOT_ACTION_DESIRE_NONE, nil end
	if not ability:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end

	local nCastRange = ability:GetCastRange() + bonusRange


	local nHighestIntEnemy = nil
	local nHighestInt = 0
	for _, npcEnemy in pairs( nEnemyHeroesInRange )
	do
		local npcEnemyInt = npcEnemy:GetAttributeValue( ATTRIBUTE_INTELLECT )
		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.CanCastOnTargetAdvanced( npcEnemy )
			and npcEnemyInt > nHighestInt
		then
			nHighestInt = npcEnemyInt
			nHighestIntEnemy = npcEnemy
		end
	end

	if nHighestIntEnemy ~= nil
		and J.IsInRange( nHighestIntEnemy, bot, nCastRange )
	then
		return BOT_ACTION_DESIRE_HIGH, nHighestIntEnemy, "ManaBurn-Attack:"..J.Chat.GetNormName( nHighestIntEnemy )
	end

	
	return BOT_ACTION_DESIRE_NONE, nil

end

function X.ConsiderNeutralPurge( bot )

	X.Init( bot )
	ability = bot:GetAbilityByName( 'satyr_trickster_purge' )

	if ability == nil then return BOT_ACTION_DESIRE_NONE, nil end
	if not ability:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end

	local nCastRange = ability:GetCastRange() + bonusRange

	
	for _, npcEnemy in pairs( nEnemyHeroesInRange )
	do
		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.CanCastOnTargetAdvanced( npcEnemy )
			and J.IsInRange( npcEnemy, bot, nCastRange )
			and J.ShouldDispelBuff( npcEnemy )
		then
			return BOT_ACTION_DESIRE_HIGH, npcEnemy, "Purge-Dispel:"..J.Chat.GetNormName( npcEnemy )
		end
	end

	
	for _, npcAlly in pairs( nAlliedHeroesInRange )
	do
		if J.IsValidHero( npcAlly )
			and J.CanCastOnMagicImmune( npcAlly )
			and J.IsInRange( npcAlly, bot, nCastRange )
			and J.ShouldDispelDebuff( npcAlly )
		then
			return BOT_ACTION_DESIRE_HIGH, npcAlly, "Purge-Dispel:"..J.Chat.GetNormName( npcAlly )
		end
	end


	if J.IsGoingOnSomeone( bot )
	then
		if J.IsValidHero( botTarget )
			and J.CanCastOnNonMagicImmune( botTarget )
			and J.CanCastOnTargetAdvanced( botTarget )
			and J.IsInRange( botTarget, bot, nCastRange )
		then
			return BOT_ACTION_DESIRE_HIGH, botTarget, "Purge-Chase:"..J.Chat.GetNormName( botTarget )
		end
	end

	
	for _, npcAlly in pairs( nAlliedHeroesInRange )
	do
		if J.IsValidHero( npcAlly )
			and J.IsRetreating( npcAlly )
			and bot:WasRecentlyDamagedByAnyHero( 5.0 )
			and not J.IsDisabled( nEnemyHeroesInRange[1] )
		then
			return BOT_ACTION_DESIRE_HIGH, nEnemyHeroesInRange[1], "Purge-Retreat:"..J.Chat.GetNormName( nEnemyHeroesInRange[1] )
		end
	end

	
	return BOT_ACTION_DESIRE_NONE, nil

end

function X.ConsiderNeutralSeedShot( bot )

	X.Init( bot )
	ability = bot:GetAbilityByName( 'warpine_raider_seed_shot' )

	if ability == nil then return BOT_ACTION_DESIRE_NONE, nil end
	if not ability:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end

	local nCastRange = ability:GetCastRange() + bonusRange
	local nRadius = ability:GetSpecialValueInt( 'bounce_range' )


	for _, npcEnemy in pairs( nEnemyHeroesInRange )
	do
		if J.IsValidHero( npcEnemy )
			and J.CanCastOnNonMagicImmune( npcEnemy )
			and J.CanCastOnTargetAdvanced( npcEnemy )
			and not J.IsDisabled( npcEnemy )
			and J.GetAroundTargetEnemyUnitCount( npcEnemy, nRadius ) >= 2
		then
			return BOT_ACTION_DESIRE_HIGH, npcEnemy, "SeedShot-Battle:"..J.Chat.GetNormName( npcEnemy )
		end
	end


	if J.IsValidHero( botTarget )
		and J.CanCastOnNonMagicImmune( botTarget )
		and J.CanCastOnTargetAdvanced( botTarget )
		and J.IsInRange( botTarget, bot, nCastRange )
		and not J.IsDisabled( botTarget )
		and J.GetAroundTargetEnemyUnitCount( botTarget, nRadius ) >= 2
	then
		return BOT_ACTION_DESIRE_HIGH, botTarget, "SeedShot-Chase:"..J.Chat.GetNormName( botTarget )
	end


	if J.IsRetreating( bot )
	then
		for _, npcEnemy in pairs( nEnemyHeroesInRange )
		do
			if J.IsValidHero( npcEnemy )
				and J.CanCastOnNonMagicImmune( npcEnemy )
				and J.CanCastOnTargetAdvanced( npcEnemy )
				and bot:WasRecentlyDamagedByHero( npcEnemy, 5.0 )
				and bot:IsFacingLocation( npcEnemy:GetExtrapolatedLocation( 0.3 ), 20 )
				and not J.IsDisabled( npcEnemy )
			then
				return BOT_ACTION_DESIRE_HIGH, npcEnemy, "HurlBoulder-Retreat:"..J.Chat.GetNormName( npcEnemy )
			end
		end
	end

	
	return BOT_ACTION_DESIRE_NONE, nil

end

--[[
function X.ConsiderNeutral( bot )

	X.Init( bot )
	ability = bot:GetAbilityByName( '' )

	if ability == nil then return BOT_ACTION_DESIRE_NONE, nil end
	if not ability:IsFullyCastable() then return BOT_ACTION_DESIRE_NONE, nil end

	local nCastRange = ability:GetCastRange() + bonusRange

	
	return BOT_ACTION_DESIRE_NONE, nil

end
]]

return X