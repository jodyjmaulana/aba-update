----------------------------------------------------------------------------------------------------
--- Creat From: BOT EXPERIMENT Credit:FURIOUSPUPPY
--- BOT EXPERIMENT Author: Arizona Fauzie
--- Link:http://steamcommunity.com/sharedfiles/filedetails/?id=837040016
--- Refactor: 决明子 Email: dota2jmz@163.com
--- Link:http://steamcommunity.com/sharedfiles/filedetails/?id=1573671599
--- Link:http://steamcommunity.com/sharedfiles/filedetails/?id=1627071163
----------------------------------------------------------------------------------------------------


local X = {};
-- local J = require( GetScriptDirectory()..'/FunLib/jmz_func')
local A = dofile( GetScriptDirectory()..'/FunLib/aba_ability' )

local bot = GetBot();

local nTeamAncient = GetAncient(GetTeam());
local vTeamAncientLoc = nil;
if nTeamAncient ~= nil then vTeamAncientLoc = nTeamAncient:GetLocation() end;

local nEnemyAncient = GetAncient(GetOpposingTeam());
local vEnemyAncientLoc = nil
if nEnemyAncient ~= nil then vEnemyAncientLoc = nEnemyAncient:GetLocation() end;
local centre = Vector(0, 0, 0);

local attackDesire = 0;
local moveDesire = 0;
local retreatDesire = 0;

local castQDesire = 0;
local castWDesire = 0;
local castEDesire = 0;


function X.IsValidUnit( unit )
	return unit ~= nil
	   and not unit:IsNull()
	   and unit:IsAlive()
end

function X.InitiateAbility( minion )
	minion.abilities = {}
	for i = 0, 3
	do
		minion.abilities[i + 1] = minion:GetAbilityInSlot( i )
	end
end

------------IDENTIFY MINION
function X.IsMinionWithSkill( unitName )
	return unitName == "npc_dota_necronomicon_archer_3"
		or unitName == "npc_dota_neutral_big_thunder_lizard"
		or unitName == "npc_dota_neutral_black_dragon"
		or unitName == "npc_dota_neutral_centaur_khan"
		or unitName == "npc_dota_neutral_dark_troll"
		or unitName == "npc_dota_neutral_dark_troll_warlord"
		or unitName == "npc_dota_neutral_enraged_wildkin"
		or unitName == "npc_dota_neutral_fel_beast"
		or unitName == "npc_dota_neutral_forest_troll_high_priest"
		or unitName == "npc_dota_neutral_harpy_scout"
		or unitName == "npc_dota_neutral_harpy_storm"
		or unitName == "npc_dota_neutral_ice_shaman"
		or unitName == "npc_dota_neutral_mud_golem"
		or unitName == "npc_dota_neutral_mud_golem_split"
		or unitName == "npc_dota_neutral_mud_golem_split_doom"
		or unitName == "npc_dota_neutral_ogre_magi"
		or unitName == "npc_dota_neutral_ogre_mauler"
		or unitName == "npc_dota_neutral_polar_furbolg_ursa_warrior"
		or unitName == "npc_dota_neutral_prowler_shaman"
		or unitName == "npc_dota_neutral_satyr_hellcaller"
		or unitName == "npc_dota_neutral_satyr_soulstealer"
		or unitName == "npc_dota_neutral_satyr_trickster"
		or unitName == "npc_dota_neutral_warpine_raider"
		or unitName == "npc_dota_neutral_wildkin"
end

function X.IsMinionWithNoSkill( unitName )
	return unitName == "npc_dota_necronomicon_archer_1"
		or unitName == "npc_dota_necronomicon_archer_2"
		or unitName == "npc_dota_lesser_eidolon"
		or unitName == "npc_dota_eidolon"
		or unitName == "npc_dota_greater_eidolon"
		or unitName == "npc_dota_dire_eidolon"
		or unitName == "npc_dota_furion_treant"
		or unitName == "npc_dota_furion_treant_large"
		or unitName == "npc_dota_invoker_forged_spirit"
		or unitName == "npc_dota_broodmother_spiderling"
		or unitName == "npc_dota_broodmother_spiderite"
		or unitName == "npc_dota_wraith_king_skeleton_warrior"
		or unitName == "npc_dota_warlock_golem_1"
		or unitName == "npc_dota_warlock_golem_2"
		or unitName == "npc_dota_warlock_golem_3"
		or unitName == "npc_dota_warlock_golem_scepter_1"
		or unitName == "npc_dota_warlock_golem_scepter_2"
		or unitName == "npc_dota_warlock_golem_scepter_3"
		or unitName == "npc_dota_beastmaster_boar"
		or unitName == "npc_dota_beastmaster_greater_boar"
		or unitName == "npc_dota_beastmaster_boar_1"
		or unitName == "npc_dota_beastmaster_boar_2"
		or unitName == "npc_dota_beastmaster_boar_3"
		or unitName == "npc_dota_beastmaster_boar_4"
		or unitName == "npc_dota_lycan_wolf1"
		or unitName == "npc_dota_lycan_wolf2"
		or unitName == "npc_dota_lycan_wolf3"
		or unitName == "npc_dota_lycan_wolf4"
		or unitName == "npc_dota_neutral_kobold"
		or unitName == "npc_dota_neutral_kobold_tunneler"
		or unitName == "npc_dota_neutral_kobold_taskmaster"
		or unitName == "npc_dota_neutral_centaur_outrunner"
		or unitName == "npc_dota_neutral_polar_furbolg_champion"
		or unitName == "npc_dota_neutral_giant_wolf"
		or unitName == "npc_dota_neutral_alpha_wolf"
		or unitName == "npc_dota_neutral_jungle_stalker"
		or unitName == "npc_dota_neutral_elder_jungle_stalker"
		or unitName == "npc_dota_neutral_prowler_acolyte"
		or unitName == "npc_dota_neutral_rock_golem"
		or unitName == "npc_dota_neutral_granite_golem"
		or unitName == "npc_dota_neutral_small_thunder_lizard"
		or unitName == "npc_dota_neutral_gnoll_assassin"
		or unitName == "npc_dota_neutral_ghost"
		or unitName == "npc_dota_wraith_ghost"
		or unitName == "npc_dota_neutral_forest_troll_berserker"
		or unitName == "npc_dota_neutral_black_drake"
		or unitName == "npc_dota_dark_troll_warlord_skeleton_warrior"
		or unitName == "npc_dota_necronomicon_warrior_1"
		or unitName == "npc_dota_necronomicon_warrior_2"
		or unitName == "npc_dota_necronomicon_warrior_3"
end

function X.IsAttackingWard( unitName )
	return unitName == "npc_dota_shadow_shaman_ward_1"
		or unitName == "npc_dota_shadow_shaman_ward_2"
		or unitName == "npc_dota_shadow_shaman_ward_3"
		or unitName == "npc_dota_venomancer_plague_ward_1"
		or unitName == "npc_dota_venomancer_plague_ward_2"
		or unitName == "npc_dota_venomancer_plague_ward_3"
		or unitName == "npc_dota_venomancer_plague_ward_4"
		or unitName == "npc_dota_witch_doctor_death_ward"
end

function X.IsFrozeSigil( unitName )
	return unitName == "npc_dota_tusk_frozen_sigil1"
		or unitName == "npc_dota_tusk_frozen_sigil2"
		or unitName == "npc_dota_tusk_frozen_sigil3"
		or unitName == "npc_dota_tusk_frozen_sigil4"
end

function X.IsHealingWard( unitName )
	return unitName == "npc_dota_juggernaut_healing_ward"
end

function X.IsHawk( unitName )
	return unitName == "npc_dota_scout_hawk"
		or unitName == "npc_dota_greater_hawk"
		or unitName == "npc_dota_beastmaster_hawk"
		or unitName == "npc_dota_beastmaster_hawk_1"
		or unitName == "npc_dota_beastmaster_hawk_2"
		or unitName == "npc_dota_beastmaster_hawk_3"
		or unitName == "npc_dota_beastmaster_hawk_4"
end

function X.IsBear( unitName )
	return unitName == "npc_dota_lone_druid_bear1"
		or unitName == "npc_dota_lone_druid_bear2"
		or unitName == "npc_dota_lone_druid_bear3"
		or unitName == "npc_dota_lone_druid_bear4"
end

function X.IsFamiliar( unitName )
	return unitName == "npc_dota_visage_familiar1"
		or unitName == "npc_dota_visage_familiar2"
		or unitName == "npc_dota_visage_familiar3"
end

function X.IsTornado( unitName )
	return unitName == "npc_dota_enraged_wildkin_tornado"
end

function X.IsUncontrollableUnit( unitName )
	return unitName == "dota_death_prophet_exorcism_spirit"
		or unitName == "npc_dota_beastmaster_axe"
		or unitName == "npc_dota_broodmother_web"
		or unitName == "npc_dota_dark_willow_creature"
		or unitName == "npc_dota_death_prophet_torment"
		or unitName == "npc_dota_grimstroke_ink_creature"
		or unitName == "npc_dota_gyrocopter_homing_missile"
		or unitName == "npc_dota_phoenix_sun"
		or unitName == "npc_dota_plasma_field"
		or unitName == "npc_dota_pugna_nether_ward_1"
		or unitName == "npc_dota_pugna_nether_ward_2"
		or unitName == "npc_dota_pugna_nether_ward_3"
		or unitName == "npc_dota_pugna_nether_ward_4"
		or unitName == "npc_dota_rattletrap_cog"
		or unitName == "npc_dota_rattletrap_rocket"
		or unitName == "npc_dota_techies_minefield_sign"
		or unitName == "npc_dota_treant_eyes"
		or unitName == "npc_dota_troll_warlord_axe"
		or unitName == "npc_dota_unit_tombstone1"
		or unitName == "npc_dota_unit_tombstone2"
		or unitName == "npc_dota_unit_tombstone3"
		or unitName == "npc_dota_unit_tombstone4"
		or unitName == "npc_dota_unit_undying_zombie"
		or unitName == "npc_dota_unit_undying_zombie_torso"
		or unitName == "npc_dota_weaver_swarm"
		or unitName == "npc_dota_wisp_spirit"
		or unitName == "npc_dota_zeus_cloud"
end

function X.IsRemnant( unitName )
	return unitName == "npc_dota_stormspirit_remnant"
		or unitName == "npc_dota_ember_spirit_remnant"
		or unitName == "npc_dota_earth_spirit_stone"
		or unitName == "npc_dota_aether_remnant"
end

local trap = {
	"npc_dota_templar_assassin_psionic_trap",
	"npc_dota_techies_remote_mine",
	"npc_dota_techies_land_mine",
	"npc_dota_techies_stasis_trap"
}

local independent = {
	"npc_dota_brewmaster_earth_1",
	"npc_dota_brewmaster_earth_2",
	"npc_dota_brewmaster_earth_3",
	"npc_dota_brewmaster_storm_1",
	"npc_dota_brewmaster_storm_2",
	"npc_dota_brewmaster_storm_3",
	"npc_dota_brewmaster_fire_1",
	"npc_dota_brewmaster_fire_2",
	"npc_dota_brewmaster_fire_3",
	"npc_dota_brewmaster_void_1",
	"npc_dota_brewmaster_void_2",
	"npc_dota_brewmaster_void_3"
}


------------MINION THINK
function X.MinionThink( hMinionUnit )

	if bot == nil then bot = GetBot() end
	local unitName = hMinionUnit:GetUnitName()
	
	if X.IsValidUnit( hMinionUnit )
	then
		if hMinionUnit:IsIllusion()
		then
			if hMinionUnit:HasModifier( 'modifier_phantom_lancer_phantom_edge_boost' ) then return end
			X.IllusionThink( hMinionUnit )
			return

		elseif X.IsAttackingWard( unitName )
		then
			X.AttackingWardThink( hMinionUnit )
			return

		elseif X.IsUncontrollableUnit( unitName )
			or X.IsRemnant( unitName )
		then
			return

		else
			X.MinionWithSkillThink( hMinionUnit )
			return
		end
	end
	
end

function X.IllusionThink( minion )
	minion.attackDesire, minion.target = X.ConsiderIllusionAttack( minion )
	minion.moveDesire, minion.loc      = X.ConsiderIllusionMove( minion )

	if minion.attackDesire > 0
	then
		if minion.target:IsAttackImmune()
			or minion.target:IsInvulnerable()
		then
			minion:Action_MoveToLocation( minion.target:GetLocation() )
			return
		else
			minion:Action_AttackUnit( minion.target, true )
			return
		end
	end

	if minion.moveDesire > 0
	then
		minion:Action_MoveToLocation(minion.loc);
		return
	end
end

function X.MinionWithSkillThink( minion )
	if X.IsBusy( minion ) then return end
	
	if minion.abilities == nil
	then
		X.InitiateAbility( minion )
	end

	X.CastAbilityThink( minion )
	minion.attackDesire, minion.target = X.ConsiderIllusionAttack( minion )
	minion.moveDesire, minion.loc      = X.ConsiderIllusionMove( minion )

	if minion.attackDesire > 0
	then
		if minion.target:IsAttackImmune()
			or minion.target:IsInvulnerable()
		then
			minion:Action_MoveToLocation( minion.target:GetLocation() )
			return
		else
			minion:Action_AttackUnit( minion.target, true )
			return
		end
	end

	if minion.moveDesire > 0
	then
		minion:Action_MoveToLocation( minion.loc )
		return
	end

end

function X.AttackingWardThink( minion )

	minion.attackDesire, minion.target = X.ConsiderWardAttack( minion );
	if minion.attackDesire > 0
		--and minion:GetAnimActivity() ~= 1503
	then
		minion:Action_AttackUnit( minion.target, true )
		return
	end

end
function X.HealingWardThink(minion)

	local nEnemyHeroes = minion:GetNearbyHeroes( 1200, true, BOT_MODE_DESIRE_NONE )

	local targetLocation = nil
	local weakestHero = nil
	local weakestHP = 0.99
	for i = 1, 5
	do
		local allyHero = GetTeamMember( i )
		if allyHero ~= nil
			and allyHero:IsAlive()
			and GetUnitToUnitDistance( allyHero, minion ) <= 1200
		then
			local allyHP = allyHero:GetHealth() / allyHero:GetMaxHealth()
			if allyHP < weakestHP
			then
				weakestHP = allyHP
				weakestHero = allyHero
			end
		end
	end

	if #nEnemyHeroes == 0
	then
		local nAoeHeroTable = minion:FindAoELocation( false, true, minion:GetLocation(), 1000, 400 , 0, 0 )
		if nAoeHeroTable.count >= 2
		then
			targetLocation = nAoeHeroTable.targetloc
		end
		
		if targetLocation == nil
		then
			if weakestHero ~= nil
			then
				targetLocation = weakestHero:GetLocation()
			end
		end

		if targetLocation == nil
		then
			local nAoeCreepTable = minion:FindAoELocation( false, false, minion:GetLocation(), 800, 400 , 0, 0 )
			if nAoeCreepTable.count >= 1
			then
				targetLocation = nAoeCreepTable.targetloc
			end
		end
		
	else
		if weakestHero ~= nil
		then
			targetLocation = weakestHero:GetLocation()
		end
	end

	
	if targetLocation ~= nil
	then
		if targetLocation == GetBot():GetLocation()
		then
			return
		else
			minion:Action_MoveToLocation( targetLocation )
		end
	else
		minion:Action_MoveToLocation( vTeamAncientLoc )
	end

end

function X.HawkThink( minion )

	if X.CantMove( minion ) then return end
	minion:Action_MoveToLocation( bot:GetLocation() )
	return

end


------------MINION THINK HELPER
function X.ConsiderIllusionAttack( minion )
	if X.CantAttack( minion ) then return BOT_MODE_DESIRE_NONE, nil end
	local target = X.GetIllusionAttackTarget( minion )

	if target ~= nil
	then
		return BOT_MODE_DESIRE_HIGH, target
	end

	return BOT_MODE_DESIRE_NONE, nil

end

function X.ConsiderIllusionMove( minion )

	if X.CantMove( minion ) then return BOT_MODE_DESIRE_NONE, nil end

	if not bot:IsAlive()
	then
		return BOT_MODE_DESIRE_HIGH, X.GetXUnitsTowardsLocation( minion, vEnemyAncientLoc, 540 )
	end

	if bot:GetActiveMode() ~= BOT_MODE_RETREAT
	then
		return BOT_MODE_DESIRE_HIGH, X.GetXUnitsTowardsLocation( bot, vEnemyAncientLoc, 240 )
	end

	return BOT_MODE_DESIRE_NONE, nil

end


function X.CastAbilityThink(minion)

	if X.CanCastAbility(minion.abilities[1]) then
		X.CastThink(minion, minion.abilities[1]);
	end

	if X.CanCastAbility(minion.abilities[2]) then
		X.CastThink(minion, minion.abilities[2]);
	end

	if X.CanCastAbility(minion.abilities[3]) then
		X.CastThink(minion, minion.abilities[3]);
	end

	if X.CanCastAbility(minion.abilities[4]) then
		X.CastThink(minion, minion.abilities[4]);
	end

end

function X.CanCastAbility(ability)

	return ability ~= nil and ability:IsFullyCastable() and ability:IsPassive() == false
	
end

function X.CastThink( minion, ability )

	local abilityName = ability:GetName()
	local castDesire, castTarget, castLocation, sMotive

	if abilityName == "necronomicon_archer_purge"
	then
		castDesire, castTarget, sMotive = A.ConsiderNecronomiconPurge( minion )
		if castDesire > 0
		then
			bot:ActionQueue_UseAbilityOnEntity( ability, castTarget )
			return
		end

	elseif abilityName == "big_thunder_lizard_frenzy"
	then
		castDesire, castTarget, sMotive = A.ConsiderNeutralFrenzy( minion )
		if castDesire > 0
		then
			bot:ActionQueue_UseAbilityOnEntity( ability, castTarget )
			return
		end

	elseif abilityName == "big_thunder_lizard_slam"
	then
		castDesire, sMotive = A.ConsiderNeutralSlam( minion )
		if castDesire > 0
		then
			bot:ActionQueue_UseAbility( ability )
			return
		end

	elseif abilityName == "black_dragon_fireball"
	then
		castDesire, castLocation, sMotive = A.ConsiderNeutralFireball( minion )
		if castDesire > 0
		then
			bot:ActionQueue_UseAbilityOnLocation( ability, castLocation )
			return
		end

	elseif abilityName == "centaur_khan_war_stomp"
	then
		castDesire, sMotive = A.ConsiderNeutralWarStomp( minion )
		if castDesire > 0
		then
			bot:ActionQueue_UseAbility( ability )
			return
		end

	elseif abilityName == "dark_troll_warlord_ensnare"
	then
		castDesire, castTarget, sMotive = A.ConsiderNeutralEnsnare( minion )
		if castDesire > 0
		then
			bot:ActionQueue_UseAbilityOnEntity( ability, castTarget )
			return
		end

	elseif abilityName == "dark_troll_warlord_raise_dead"
	then
		castDesire, sMotive = A.ConsiderNeutralRaiseDead( minion )
		if castDesire > 0
		then
			bot:ActionQueue_UseAbility( ability )
			return
		end

	elseif abilityName == "enraged_wildkin_hurricane"
	then
		castDesire, castTarget, castLocation, sMotive = A.ConsiderNeutralHurricane( minion )
		if castDesire > 0
		then
			bot:CastAbilityOnPosition( castLocation, ability, castTarget )
			return
		end

	elseif abilityName == "enraged_wildkin_tornado"
	then
		castDesire, castLocation, sMotive = A.ConsiderNeutralTornado( minion )
		if castDesire > 0
		then
			bot:ActioQueue_UseAbilityOnLocation( ability, castLocation )
			return
		end

	elseif abilityName == "fel_beast_haunt"
	then
		castDesire, castTarget, sMotive = A.ConsiderNeutralVex( minion )
		if castDesire > 0
		then
			bot:ActionQueue_UseAbilityOnEntity( ability, castTarget )
			return
		end

	elseif abilityName == "forest_troll_high_priest_heal"
	then
		castDesire, castTarget, sMotive = A.ConsiderNeutralHeal( minion )
		if castDesire > 0
		then
			bot:ActionQueue_UseAbilityOnEntity( ability, castTarget )
			return
		end

	elseif abilityName == "harpy_scout_take_off"
	then
		castDesire, sMotive = A.ConsiderNeutralTakeOff( minion )
		if castDesire > 0
		then
			bot:ActionQueue_UseAbility( ability )
			return
		end

	elseif abilityName == "harpy_storm_chain_lightning"
	then
		castDesire, castTarget, sMotive = A.ConsiderNeutralChainLightning( minion )
		if castDesire > 0
		then
			bot:ActionQueue_UseAbilityOnEntity( ability, castTarget )
			return
		end

	elseif abilityName == "ice_shaman_incendiary_bomb"
	then
		castDesire, castTarget, sMotive = A.ConsiderNeutralIcefireBomb( minion )
		if castDesire > 0
		then
			bot:ActionQueue_UseAbilityOnEntity( ability, castTarget )
			return
		end

	elseif abilityName == "mud_golem_hurl_boulder"
	then
		castDesire, castTarget, sMotive = A.ConsiderNeutralHurlBoulder( minion )
		if castDesire > 0
		then
			bot:ActionQueue_UseAbilityOnEntity( ability, castTarget )
			return
		end

	elseif abilityName == "ogre_magi_frost_armor"
	then
		castDesire, castTarget, sMotive = A.ConsiderNeutralIceArmor( minion )
		if castDesire > 0
		then
			bot:ActionQueue_UseAbilityOnEntity( ability, castTarget )
			return
		end

	elseif abilityName == "ogre_bruiser_ogre_smash"
	then
		castDesire, sMotive = A.ConsiderNeutralOgreSmash( minion )
		if castDesire > 0
		then
			bot:ActionQueue_UseAbility( ability )
			return
		end

	elseif abilityName == "polar_furbolg_ursa_warrior_thunder_clap"
	then
		castDesire, sMotive = A.ConsiderNeutralThunderClap( minion )
		if castDesire > 0
		then
			bot:ActionQueue_UseAbility( ability )
			return
		end

	elseif abilityName == "polar_furbolg_ursa_warrior_thunder_clap"
	then
		castDesire, sMotive = A.ConsiderNeutralThunderClap( minion )
		if castDesire > 0
		then
			bot:ActionQueue_UseAbility( ability )
			return
		end

	elseif abilityName == "satyr_hellcaller_shockwave"
	then
		castDesire, castLocation, sMotive = A.ConsiderNeutralShockwave( minion )
		if castDesire > 0
		then
			bot:ActioQueue_UseAbilityOnLocation( ability, castLocation )
			return
		end

	elseif abilityName == "satyr_soulstealer_mana_burn"
	then
		castDesire, castTarget, sMotive = A.ConsiderNeutralManaBurn( minion )
		if castDesire > 0
		then
			bot:ActionQueue_UseAbilityOnEntity( ability, castTarget )
			return
		end

	elseif abilityName == "satyr_trickster_purge"
	then
		castDesire, castTarget, sMotive = A.ConsiderNeutralPurge( minion )
		if castDesire > 0
		then
			bot:ActionQueue_UseAbilityOnEntity( ability, castTarget )
			return
		end

	elseif abilityName == "warpine_raider_seed_shot"
	then
		castDesire, castTarget, sMotive = A.ConsiderNeutralSeedShot( minion )
		if castDesire > 0
		then
			bot:ActionQueue_UseAbilityOnEntity( ability, castTarget )
			return
		end
	end

end


function X.ConsiderWardAttack( minion )
	local target = X.GetWardAttackTarget( minion )

	if target ~= nil
	then
		return BOT_MODE_DESIRE_HIGH, target
	end

	return BOT_MODE_DESIRE_NONE, nil
end

function X.GetWardAttackTarget( minion )
	local range = minion:GetAttackRange()
	local target = bot:GetAttackTarget()

	if not X.IsValidTarget( target )
		or ( X.IsValidTarget( target ) and GetUnitToUnitDistance( minion, target ) > range )
	then
		target = X.GetWeakestHero( range, minion )
		if target == nil then target = X.GetWeakestCreep( range, minion ) end
		if target == nil then target = X.GetWeakestTower( range, minion ) end
		if target == nil then target = X.GetWeakestBarracks( range, minion ) end
	end

	return target
end




function X.GetXUnitsTowardsLocation( hUnit, vLocation, nDistance)
    local direction = (vLocation - hUnit:GetLocation()):Normalized()
    return hUnit:GetLocation() + direction * nDistance
end

function X.IsValidTarget(target)
	return target ~= nil
	   and not target:IsNull()
	   and target:CanBeSeen()
	   and not target:IsInvulnerable()
	   and not target:IsAttackImmune()
	   and target:IsAlive();
end

function X.IsInRange(unit, target, range)
	return GetUnitToUnitDistance(unit, target) <= range;
end

local globRadius = 1600;

function X.GetWeakest( unitList )

	local target = nil
	local minKillTime = 10000
	if #unitList > 0 
	then
		for i=1, #unitList 
		do
			local unit = unitList[i]
			if X.IsValidTarget( unit ) 
			then
				local killUnitTime = unit:GetHealth() / unit:GetActualIncomingDamage( 3000, DAMAGE_TYPE_PHYSICAL )
				if killUnitTime < minKillTime 
				then
					target = unit
					minKillTime = killUnitTime
				end
			end
		end
	end
	
	return target
	
end

function X.GetWeakestHero(radius, minion)

	local enemies = minion:GetNearbyHeroes( radius * 0.5, true, BOT_MODE_NONE);
	
	if #enemies == 0 then enemies = minion:GetNearbyHeroes( radius, true, BOT_MODE_NONE) end
	
	return X.GetWeakest(enemies);
end

function X.GetWeakestCreep(radius, minion)

	local creeps = minion:GetNearbyLaneCreeps(radius, true)
	
	if #creeps == 0 then creeps = minion:GetNearbyNeutralCreeps(radius * 0.5) end
	
	if #creeps == 0 then creeps = minion:GetNearbyNeutralCreeps(radius) end
	
	return X.GetWeakest(creeps)
	
end

function X.GetWeakestTower(radius, minion)
	local towers = minion:GetNearbyTowers(radius, true);
	return X.GetWeakest(towers);
end

function X.GetWeakestBarracks(radius, minion)
	local barracks = minion:GetNearbyBarracks(radius, true);
	if nEnemyAncient ~= nil
		and X.IsInRange(minion,nEnemyAncient,radius)
	then
		table.insert(barracks,nEnemyAncient)
	end
	return X.GetWeakest(barracks);
end

function X.GetIllusionAttackTarget(minion)


	local target = bot:GetAttackTarget();

	if bot:HasModifier('modifier_bane_nightmare') and not bot:IsInvulnerable() then target = bot end

	if target == nil then target = bot:GetTarget() end

	if ( not bot:IsAlive() )
		or ( target == nil and bot:GetLevel() >= 8 and bot:GetActiveMode() ~= BOT_MODE_LANING )
		or ( target == nil and GetUnitToUnitDistance(minion, bot) > 2200 )
		or ( target == nil and bot:GetActiveMode() == BOT_MODE_RETREAT )
		or ( target ~= nil and GetUnitToUnitDistance(minion,target) > 1600 )
	then
		target = X.GetWeakestHero(globRadius, minion);
		if target == nil then target = X.GetWeakestCreep(globRadius, minion); end
		if target == nil then target = X.GetWeakestTower(globRadius, minion); end
		if target == nil then target = X.GetWeakestBarracks(globRadius, minion); end
	end

	return target

end


function X.IsBusy(unit)
	return unit:IsUsingAbility() or unit:IsCastingAbility() or unit:IsChanneling();
end

function X.CantMove(unit)
	return unit:IsStunned() or unit:IsRooted() or unit:IsNightmared() or unit:IsInvulnerable();
end

function X.CantAttack(unit)
	return unit:IsStunned() or unit:IsRooted() or unit:IsNightmared() or unit:IsDisarmed() or unit:IsInvulnerable() or unit:GetAttackDamage() <= 0;
end




function X.CheckFlag(bitfield, flag)
    return ((bitfield/flag) % 2) >= 1
end

return X;
-- dota2jmz@163.com QQ:2462331592..