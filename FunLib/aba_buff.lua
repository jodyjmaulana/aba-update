----------------------------------------------------------------------------------------------------
--- The Creation Come From: A Beginner AI
--- Author: 决明子 Email: dota2jmz@163.com 微博@Dota2_决明子
--- Link:http://steamcommunity.com/sharedfiles/filedetails/?id=1573671599
--- Link:http://steamcommunity.com/sharedfiles/filedetails/?id=1627071163
----------------------------------------------------------------------------------------------------


local Buff = {}


Buff["creep_is_immune"] = {

"modifier_fountain_glyph",
"modifier_crystal_maiden_frostbite",

}

Buff["enemy_is_immune"] = {

"modifier_winter_wyvern_winters_curse", 		 --冰龙大
"modifier_winter_wyvern_winters_curse_aura", --冰龙大
"modifier_troll_warlord_battle_trance", --巨魔大
"modifier_skeleton_king_reincarnation_scepter_active",
"modifier_naga_siren_song_of_the_siren",
--"modifier_modifier_dazzle_shallow_grave",
--"modifier_oracle_false_promise_timer",
--"modifier_item_blade_mail_reflect",
--"modifier_oracle_fates_edict"

}

Buff["enemy_is_undead"] = {

"modifier_dazzle_shallow_grave",
"modifier_oracle_false_promise_timer",
"modifier_abaddon_borrowed_time",
"modifier_skeleton_king_reincarnation_scepter_active",

}

Buff["enemy_not_illusion"] = {

"modifier_item_satanic_unholy",
"modifier_item_mask_of_madness_berserk",
"modifier_black_king_bar_immune",
"modifier_rune_doubledamage",
"modifier_rune_regen",
"modifier_rune_haste",
"modifier_rune_arcane",
"modifier_item_phase_boots_active",

}


Buff["enemy_is_illusion"] = {

"modifier_illusion",
"modifier_phantom_lancer_doppelwalk_illusion",
"modifier_phantom_lancer_juxtapose_illusion",
"modifier_darkseer_wallofreplica_illusion",
"modifier_terrorblade_conjureimage",

}

Buff["hero_cannot_ability"] = {

"modifier_doom_bringer_doom",
"modifier_item_forcestaff_active",

}

Buff["hero_is_taunted"] = {

"modifier_axe_berserkers_call",
"modifier_legion_commander_duel",
"modifier_winter_wyvern_winters_curse",
"modifier_winter_wyvern_winters_curse_aura",
"modifier_huskar_life_break_taunt",

}

Buff["hero_has_spell_shield"] = {

"modifier_antimage_spell_shield",
"modifier_item_sphere_target",
"modifier_item_lotus_orb_active",
"modifier_item_aeon_disk_buff",
"modifier_dazzle_shallow_grave",
"modifier_abaddon_borrowed_time",


}

--可被打断的回复效果
Buff["hero_is_healing"] = {

"modifier_flask_healing",
"modifier_clarity_potion",
"modifier_item_urn_heal",
"modifier_item_spirit_vessel_heal",
"modifier_bottle_regeneration",
--"modifier_filler_heal",
"modifier_aegis_regen",
"modifier_rune_regen",

}


Buff["truesight_buffs"] = {

	"modifier_item_dustofappearance",
	"modifier_sniper_assassinate",
	"modifier_bounty_hunter_track",
	"modifier_slardar_amplify_damage",
	"modifier_bloodseeker_thirst_vision",
	"modifier_bane_fiends_grip",
	"modifier_bane_fiends_grip_cast_illusion",
	"modifier_oracle_fortunes_end_purge",
	"modifier_shadow_shaman_shackles",
	--渔网诱捕
	"modifier_rod_of_atos_debuff",
	"modifier_gungnir_debuff",
	"modifier_meepo_earthbind",
	"modifier_naga_siren_ensnare",
	"modifier_crystal_maiden_frostbite",
	"modifier_ember_spirit_searing_chains",
	"modifier_legion_commander_duel",
	"modifier_pugna_life_drain",
	"modifier_pudge_dismember",
	"modifier_treant_natures_guise_root",
	"modifier_treant_overgrowth",
	"modifier_abyssal_underlord_pit_of_malice_ensare",
	"modifier_aghsfort_lich_sinister_gaze",
	"modifier_lone_druid_spirit_bear_entangle_effect",
	"modifier_troll_warlord_berserkers_rage_ensnare",
	"modifier_truesight",

}


Buff["armor_reduction"] = {

"modifier_templar_assassin_meld_armor",
"modifier_item_medallion_of_courage_armor_reduction",
"modifier_item_solar_crest_armor_reduction",
"modifier_slardar_amplify_damage",
"modifier_alchemist_acid_spray",
"modifier_ancient_rock_golem_weakening",
"modifier_bristleback_viscous_nasal_goo",
"modifier_chaos_knight_reality_rift_debuff",
"modifier_dazzle_bad_juju_armor_counter",
"modifier_forged_spirit_melting_strike_debuff",
"modifier_lycan_howl",
"modifier_naga_siren_rip_tide",
"modifier_pangolier_luckyshot_disarm",
"modifier_razor_eye_of_the_storm_armor",
"modifier_nevermore_presence",
"modifier_snapfire_lil_shredder_debuff",
"modifier_tidehunter_gush",
"modifier_vengefulspirit_wave_of_terror",
"modifier_weaver_swarm_debuff",
"modifier_armor_corruption",
"modifier_item_assault_negative_armor",
"modifier_blight_stone_buff",
"modifier_desolator_buff",
"modifier_orb_of_corrosion_debuff",
"modifier_desolator_2_buff",

}


Buff["dispellable_debuffs"] = {

	"modifier_cold_feet",
	"modifier_arc_warden_flux",
	"modifier_axe_battle_hunger",
	"modifier_bane_enfeeble_effect",
	"modifier_batrider_sticky_napalm",
	"modifier_flamebreak_damage",
	"modifier_beastmaster_axe_stack_counter",
	"modifier_bounty_hunter_wind_walk_slow",
	"modifier_bounty_hunter_track",
	"modifier_brewmaster_cinder_brew",
	"modifier_bristleback_viscous_nasal_goo",
	"modifier_broodmother_spawn_spiderlings",
	"modifier_chaos_knight_reality_rift_debuff",
	"modifier_chen_penitence",
	"modifier_crystal_maiden_crystal_nova",
	-- "modifier_dark_seer_ion_shell",
	"modifier_dark_willow_cursed_crown",
	"modifier_dark_willow_debuff_fear",
	"modifier_dazzle_poison_touch",
	"modifier_death_prophet_spirit_siphon_fear",
	"modifier_disruptor_thunderstrike_slow",
	"modifier_dragonknight_breathefire_reduction",
	"modifier_elder_titan_earth_splitter",
	"modifier_enigma_malefice",
	"modifier_enchantress_enchant_slow",
	"modifier_faceless_void_time_dilation_slow",
	"modifier_grimstroke_dark_artistry_slow",
	"modifier_gyrocopter_call_down_slow",
	"modifier_huskar_inner_fire_disarm",
	"modifier_huskar_life_break_slow",
	"modifier_invoker_cold_snap",
	"modifier_invoker_chaos_meteor_burn",
	"modifier_jakiro_dual_breath_slow",
	"modifier_jakiro_dual_breath_burn",
	"modifier_jakiro_liquid_fire_burn",
	"modifier_jakiro_liquid_ice_debuff",
	"modifier_keeper_of_the_light_blinding_light",
	"modifier_kunkka_torrent_slow",
	"modifier_life_stealer_open_wounds",
	"modifier_lone_druid_savage_roar",
	"modifier_magnataur_shockwave",
	"modifier_naga_siren_rip_tide",
	"modifier_night_stalker_void",
	"modifier_ogre_magi_ignite",
	"modifier_oracle_fortunes_end_purge",
	"modifier_oracle_fates_edict",
	"modifier_pangolier_luckyshot_disarm",
	"modifier_phantom_assassin_stiflingdagger",
	"modifier_phantom_lancer_spirit_lance",
	"modifier_phoenix_icarus_dive_burn",
	"modifier_phoenix_fire_spirit_burn",
	"modifier_pugna_decrepify",
	"modifier_queenofpain_shadow_strike",
	-- "modifier_silencer_curse_of_the_silent",
	"modifier_silencer_last_word",
	"modifier_slardar_amplify_damage",
	"modifier_templar_assassin_meld_armor",
	"modifier_terrorblade_reflection_slow",
	"modifier_tidehunter_gush",
	"modifier_tidehunter_anchor_smash",
	"modifier_shredder_whirling_death_debuff",
	"modifier_tinker_laser_blind",
	"modifier_treant_leech_seed",
	"modifier_treant_overgrowth",
	"modifier_troll_warlord_berserkers_rage_ensnare",
	"modifier_troll_warlord_whirling_axes_slow",
	"modifier_troll_warlord_whirling_axes_blind",
	"modifier_abyssal_underlord_firestorm_burn",
	"modifier_abyssal_underlord_pit_of_malice_ensare",
	"modifier_ursa_earthshock",
	"modifier_vengefulspirit_wave_of_terror",
	"modifier_venomancer_venomous_gale",
	"modifier_visage_grave_chill_debuff",
	"modifier_warlock_fatal_bonds",
	"modifier_warlock_shadow_word",
	"modifier_dark_troll_warlord_ensnare",
	"modifier_lone_druid_spirit_bear_entangle_effect",
	"modifier_item_diffusal_blade_slow",
	"modifier_orchid_malevolence_debuff",
	"modifier_bloodthorn_debuff",
	"modifier_rod_of_atos_debuff",
	"modifier_gungir_debuff",
	"modifier_item_medallion_of_courage_armor_reduction",
	"modifier_item_solar_crest_armor_reduction",
	"modifier_item_urn_damage",
	"modifier_item_spirit_vessel_damage",
	"modifier_item_veil_of_discord_debuff",

}


Buff["dispellable_buffs"] = {

	"modifier_abaddon_aphotic_shield",
	"modifier_bloodseeker_bloodrage",
	"modifier_dark_seer_ion_shell",
	"modifier_dark_seer_surge",
	"modifier_earthshaker_enchant_totem",
	"modifier_grimstroke_spirit_walk_buff",
	"modifier_gyrocopter_rocket_barrage",
	"modifier_invoker_alacrity",
	"modifier_legion_commander_overwhelming_odds",
	"modifier_legion_commander_press_the_attack",
	"modifier_lich_frost_shield",
	"modifier_magnataur_empower",
	"modifier_mirana_leap_buff",
	"modifier_monkey_king_quadruple_tap_bonuses",
	"modifier_necrolyte_sadist_active",
	"modifier_ogre_magi_bloodlust",
	"modifier_omninight_guardian_angel",
	"modifier_oracle_purifying_flames",
	"modifier_pangolier_shield_crash_buff",
	"modifier_phantom_assassin_phantom_strike",
	"modifier_phantom_lancer_phantom_edge_agility",
	"modifier_pugna_decrepify",
	"modifier_slardar_sprint",
	"modifier_spirit_breaker_bulldoze",
	"modifier_storm_spirit_overload",
	"modifier_storm_spirit_electric_rave",
	"modifier_sven_warcry",
	"modifier_treant_living_armor",
	"modifier_ursa_fury_swipes",
	"modifier_visage_grave_chill_buff",
	"modifier_warlock_shadow_word",
	"modifier_windrunner_windrun",
	"modifier_item_ancient_janggo_active",
	"modifier_item_forcestaff_active",
	"modifier_ghost_state",
	"modifier_item_glimmer_cape_fade",
	"modifier_item_hurricane_pike_active",
	"modifier_item_medallion_of_courage_armor_addition",
	"modifier_item_urn_heal",
	"modifier_item_solar_crest_armor_addition",
	"modifier_item_ethereal_blade_ethereal",
	"modifier_item_crimson_guard_extra",
	"modifier_item_mask_of_madness_berserk",
	"modifier_item_mjollnir_static",
	"modifier_rune_arcane",
	"modifier_rune_doubledamage",
	"modifier_rune_haste",
	"modifier_rune_regen",
	
}


Buff["invisible_buffs"] = {

	"modifier_invisible",
	"modifier_bounty_hunter_wind_walk",
	"modifier_clinkz_wind_walk",
	"modifier_item_glimmer_cape_fade",
	"modifier_item_trickster_cloak_invis",
	-- Hoodwink Decoy buff
	"modifier_rune_invis",
	"modifier_invoker_ghost_walk_self",
	"modifier_mirana_moonlight_shadow",
	"modifier_nyx_assassin_vendetta",
	"modifier_nyx_assassin_burrow",
	"modifier_oracle_false_promise_invis",
	"modifier_sandking_sand_storm",
	"modifier_item_shadow_amulet_fade",
	"modifier_item_invisibility_edge_windwalk",
	"modifier_item_silver_edge_windwalk",
	"modifier_templar_assassin_meld",
	"modifier_weaver_shukuchi",
	"modifier_windrunner_windrun_invis",

}


return Buff
-- dota2jmz@163.com QQ:2462331592..