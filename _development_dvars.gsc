#include maps/mp/killstreaks/_remotemissile;
#include maps/mp/killstreaks/_killstreaks;
#include maps/mp/gametypes/_globallogic;
#include maps/mp/gametypes/_hud_message;
#include maps/mp/gametypes/_spawnlogic;
#include maps/mp/killstreaks/_ai_tank;
#include maps/mp/gametypes/_hud_util;
#include maps/mp/gametypes/_weapons;
#include maps/mp/gametypes/_popups;
#include maps/mp/killstreaks/_dogs;
#include maps/mp/_ambientpackage;
#include common_scripts/utility;
#include maps/mp/teams/_teams;
#include maps/mp/_utility;
init()
{
	level.result = 0;
	level.platspawned = 0;
	level.billcam_called = 0;
	level.spawningsunspinner = 0;
	level.sunspinnersspawned = 0;
	level.deads = "headicon_dead";
	level.icontest = "lui_loader_no_offset";
	level.esps = "hud_remote_missile_target";
	level.activeflags = 0;
	level.activepackopunchcrates = 0;
	level.activespawnweaponcrates = 0;
	level.bunker = 1;
	level.entities = [];
	level.amountofentities = 0;
	m = 1;
	while( m < 9 )
	{
		precacheshader( "rank_prestige0" + m );
		m++;
	}
	i = 10;
	while( i < 11 )
	{
		precacheshader( "rank_prestige" + i );
		i++;
	}
	hurt_triggers = getentarray( "trigger_hurt", "classname" );
	if( level.script == "mp_meltdown" )
	{
		exitlevel( 1 );
	}
	level.billweapon = strtok( "870mcs_mp, ai_tank_drone_gun_mp, ai_tank_drone_rocket_mp, ai_tank_drop_mp, airstrike_mp, an94_mp, as50_mp, autoturret_mp, ballista_mp, beretta93r_dw_mp, beretta93r_lh_mp, beretta93r_mp, bouncingbetty_mp, briefcase_bomb_defuse_mp, briefcase_bomb_mp, chopper_minigun_mp, claymore_mp, cobra_20mm_comlink_mp, cobra_20mm_mp, concussion_grenade_mp, counteruav_mp, crossbow_mp, defaultweapon_mp, destructible_car_mp, dog_bite_mp, dogs_mp, dsr50_mp, dualoptic_an94_mp, dualoptic_hamr_mp, dualoptic_hk416_mp, dualoptic_lsat_mp, dualoptic_mk48_mp, dualoptic_qbb95_mp, dualoptic_sa58_mp, dualoptic_saritch_mp, dualoptic_scar_mp, dualoptic_sig556_mp, dualoptic_tar21_mp, dualoptic_type95_mp, dualoptic_xm8_mp, emp_grenade_mp, emp_mp, evoskorpion_mp, explodable_barrel_mp, explosive_bolt_mp, fhj18_mp, fiveseven_dw_mp, fiveseven_lh_mp, fiveseven_mp, flash_grenade_mp, fnp45_dw_mp, fnp45_lh_mp, fnp45_mp, frag_grenade_mp, gl_an94_mp, gl_hk416_mp, gl_sa58_mp, gl_saritch_mp, gl_scar_mp, gl_sig556_mp, gl_tar21_mp, gl_type95_mp, gl_xm8_mp, hamr_mp, hatchet_mp, heli_gunner_rockets_mp, helicopter_comlink_mp, helicopter_guard_mp, helicopter_player_firstperson_mp, helicopter_player_gunner_mp, hk416_mp, insas_mp, inventory_ai_tank_drop_mp, inventory_m32_drop_mp, inventory_m32_mp, inventory_minigun_drop_mp, inventory_minigun_mp, inventory_missile_drone_mp, inventory_supplydrop_mp, judge_dw_mp, judge_lh_mp, judge_mp, kard_dw_mp, kard_lh_mp, kard_mp, kard_wager_mp, killstreak_ai_tank_mp, killstreak_qrdrone_mp, killstreak_remote_turret_mp, killstreak_uav_mp, knife_ballistic_mp, knife_held_mp, knife_mp, ksg_mp, littlebird_guard_minigun_mp, lsat_mp, m32_drop_mp, m32_mp, m32_wager_mp, microwave_turret_mp, microwaveturret_drop_mp, microwaveturret_mp, minigun_drop_mp, minigun_mp, minigun_wager_mp, missile_drone_mp, missile_drone_projectile_mp, missile_swarm_mp, missile_swarm_projectile_mp, mk48_mp, mp7_mp, nonepda_hack_mp, pdw57_mp, peacekeeper_mp, planemortar_mp, proximity_grenade_aoe_mp, proximity_grenade_mp, qbb95_mp, qcw05_mp, qrdrone_turret_mp, radar_mp, radardirection_mp, rc_car_weapon_mp, rcbomb_mp, remote_missile_bomblet_mp, remote_missile_missile_mp, remote_missile_mp, remote_mortar_missile_mp, remote_mortar_mp, riotshield_mp, sa58_mp, saiga12_mp, saritch_mp, satchel_charge_mp, scar_mp, scavenger_item_hack_mp, scavenger_item_mp, sensor_grenade_mp, sf_an94_mp, sf_evoskorpion_mp, sf_hk416_mp, sf_insas_mp, sf_mp, 7_mp, sf_pdw57_mp, sf_peacekeeper_mp, sf_qcw05_mp, sf_sa58_mp, sf_saritch_mp, sf_scar_mp, sf_sig556_mp, sf_tar21_mp, sf_type95_mp, sf_vector_mp, sf_xm8_mp, sig556_mp, smaw_mp, smoke_center_mp, srm1216_mp, sticky_grenade_mp, straferun_gun_mp, straferun_mp, straferun_rockets_mp, supplydrop_mp, svu_mp, tactical_insertion_mp, tar21_mp, trophy_system_mp, turret_drop_mp, type95_mp, usrpg_mp, vector_mp, willy_pete_mp, xm8_mp", "," );
	foreach( barrier in hurt_triggers )
	{
		barrier.origin = barrier.origin + ( 0, 0, 9999999 );
	}
	if( getdvar( "mapname" ) == "mp_nuketown_2020" )
	{
		level.sunfxname = "fx_lf_mp_nuketown_sun1";
	}
	if( getdvar( "mapname" ) == "mp_hijacked" )
	{
		level.sunfxname = "fx_lf_mp_hijacked_sun1";
	}
	if( getdvar( "mapname" ) == "mp_express" )
	{
		level.sunfxname = "fx_lf_mp_express_sun1";
	}
	if( getdvar( "mapname" ) == "mp_meltdown" )
	{
		level.sunfxname = "fx_lf_mp_meltdown_sun1";
	}
	if( getdvar( "mapname" ) == "mp_drone" )
	{
		level.sunfxname = "fx_lf_mp_drone_sun1";
	}
	if( getdvar( "mapname" ) == "mp_carrier" )
	{
		level.sunfxname = "fx_lf_mp_carrier_sun1";
	}
	if( getdvar( "mapname" ) == "mp_overflow" )
	{
		level.sunfxname = "fx_lf_mp_overflow_sun1";
	}
	if( getdvar( "mapname" ) == "mp_slums" )
	{
		level.sunfxname = "fx_lf_mp_slums_sun1";
	}
	if( getdvar( "mapname" ) == "mp_turbine" )
	{
		level.sunfxname = "fx_lf_mp_turbine_sun1";
	}
	if( getdvar( "mapname" ) == "mp_raid" )
	{
		level.sunfxname = "fx_lf_mp_raid_sun1";
	}
	if( getdvar( "mapname" ) == "mp_la" )
	{
		level.sunfxname = "fx_lf_mp_la_sun1";
	}
	if( getdvar( "mapname" ) == "mp_dockside" )
	{
		level.sunfxname = "fx_lf_mp_dockside_sun1";
	}
	if( getdvar( "mapname" ) == "mp_village" )
	{
		level.sunfxname = "fx_lf_mp_village_sun1";
	}
	if( getdvar( "mapname" ) == "mp_nightclub" )
	{
		level.sunfxname = "fx_lf_mp_nightclub_sun1";
		level.moonfxname = "fx_lf_mp_nightclub_moon";
	}
	if( getdvar( "mapname" ) == "mp_socotra" )
	{
		level.sunfxname = "fx_mp_sun_flare_socotra";
	}
	if( getdvar( "mapname" ) == "mp_downhill" )
	{
		level.sunfxname = "fx_lf_mp_downhill_sun1";
	}
	if( getdvar( "mapname" ) == "mp_mirage" )
	{
		level.sunfxname = "fx_lf_mp_mirage_sun1";
	}
	if( getdvar( "mapname" ) == "mp_hydro" )
	{
		level.sunfxname = "fx_lf_mp_hydro_sun1";
	}
	if( getdvar( "mapname" ) == "mp_skate" )
	{
		level.sunfxname = "fx_lf_mp_skate_sun1";
	}
	if( getdvar( "mapname" ) == "mp_concert" )
	{
		level.sunfxname = "fx_lf_mp_concert_sun1";
	}
	if( getdvar( "mapname" ) == "mp_magma" )
	{
		level.sunfxname = "fx_lf_mp_magma_sun1";
	}
	if( getdvar( "mapname" ) == "mp_vertigo" )
	{
		level.sunfxname = "fx_lf_mp_vertigo_sun1";
	}
	if( getdvar( "mapname" ) == "mp_studio" )
	{
		level.sunfxname = "fx_lf_mp_studio_sun1";
	}
	if( getdvar( "mapname" ) == "mp_uplink" )
	{
		level.sunfxname = "fx_lf_mp_uplink_sun1";
	}
	if( getdvar( "mapname" ) == "mp_detour" )
	{
		level.sunfxname = "fx_lf_mp_detour_sun1";
	}
	if( getdvar( "mapname" ) == "mp_cove" )
	{
		level.sunfxname = "fx_lf_mp_cove_sun1";
	}
	if( getdvar( "mapname" ) == "mp_paintball" )
	{
		level.sunfxname = "fx_lf_mp_paintball_sun1";
	}
	if( getdvar( "mapname" ) == "mp_dig" )
	{
		level.sunfxname = "fx_lf_mp_dig_sun1";
	}
	if( getdvar( "mapname" ) == "mp_frostbite" )
	{
		level.sunfxname = "fx_lf_mp_frostbite_sun1";
	}
	if( getdvar( "mapname" ) == "mp_pod" )
	{
		level.sunfxname = "fx_lf_mp_pod_sun1";
	}
	if( getdvar( "mapname" ) == "mp_takeoff" )
	{
		level.sunfxname = "fx_lf_mp_takeoff_sun1";
	}
	if( !(getdvar( "mapname" ) == "mp_hydro")getdvar( "mapname" ) == "mp_hydro" || getdvar( "mapname" ) == "mp_magma" || getdvar( "mapname" ) == "mp_uplink" || getdvar( "mapname" ) == "mp_concert" || getdvar( "mapname" ) == "mp_studio" ||  )
	{
		level.waypointred = loadfx( "misc/fx_equip_tac_insert_light_red" );
		level.waypointgreen = loadfx( "misc/fx_equip_tac_insert_light_grn" );
		level.cloudfx = loadfx( "maps/mp_maps/fx_mp_exp_bomb_smk_streamer" );
		level.remote_mortar_fx["missileExplode"] = loadfx( "weapon/remote_mortar/fx_rmt_mortar_explosion" );
		level._effect["GreenRingFx"] = loadfx( "weapon/sensor_grenade/fx_sensor_exp_scan_friendly" );
		level._effect["DaFireFx"] = loadfx( "weapon/talon/fx_muz_talon_rocket_flash_1p" );
		level._effect["BigExplosion"] = loadfx( "vehicle/vexplosion/fx_vexplode_vtol_mp" );
		level._effect["GreenFx"] = loadfx( "misc/fx_theater_mode_camera_head_glow_grn" );
		level._effect["YellowFx"] = loadfx( "misc/fx_theater_mode_camera_head_glow_yllw" );
		level._effect["WhiteArrow"] = loadfx( "maps/mp_maps/fx_mp_koth_marker_neutral_1" );
		level._effect["FlashFx"] = loadfx( "weapon/muzzleflashes/fx_muz_mg_flash_3p" );
		level._effect["FatalBloodFx"] = loadfx( "impacts/fx_flesh_hit_head_fatal_exit" );
		level._effect["White"] = loadfx( "misc/fx_theater_mode_camera_head_glow_white" );
		level._effect["FireSwords"] = loadfx( "weapon/predator/fx_predator_trail_sm" );
		level._effect["BulletFx"] = loadfx( "weapon/shellejects/fx_quadrotor_sp" );
		level._effect["ChafFx"] = loadfx( "weapon/straferun/fx_straferun_chaf" );
		level._effect["CmKsLelWater"] = loadfx( "impacts/fx_xtreme_water_hit_mp" );
		level._effect["BigGlassFx"] = loadfx( "impacts/fx_xtreme_glass_hit_mp" );
		level._effect["CamFx"] = loadfx( "misc/fx_theater_mode_camera_head" );
		level._effect["ElecManFx"] = loadfx( "weapon/talon/fx_talon_emp_stun" );
		level._effect["CmKsDogBlood"] = loadfx( "impacts/fx_deathfx_dogbite" );
		level._effect["WaterFx"] = loadfx( "system_elements/fx_snow_sm_em" );
		level._effect["BigDirtFx"] = loadfx( "weapon/tank/fx_tank_dirt" );
		level._effect["torch"] = loadfx( "maps/mp_maps/fx_mp_exp_rc_bomb" );
		level._effect["GlassFx"] = loadfx( "impacts/fx_large_glass" );
		level._effect["LeafFx"] = loadfx( "impacts/fx_small_foliage" );
	}
	precachemodel( "vehicle_mi24p_hind_desert_d_piece02" );
	precachelocationselector( "lui_loader_no_offset" );
	precachemodel( "projectile_cbu97_clusterbomb" );
	precachemodel( "nt_2020_foliage_hedge_sphere" );
	precachemodel( "veh_iw_tank_t72_static_body" );
	precachemodel( "p6_carrier_edge_railing_256" );
	precachemodel( "p6_express_train_track_a01" );
	precachemodel( "t6_wpn_briefcase_bomb_view" );
	precachemodel( "fx_char_gib_chunk_meat01" );
	precachemodel( "nt_2020_flag_treyarch_01" );
	precachemodel( "nt_2020_house_02_balcony" );
	precachemodel( "collision_clip_32x32x32" );
	precachemodel( "t6_wpn_minigun_world" );
	precachemodel( "nt_2020_lava_lamp_01" );
	precachemodel( "p6_rag_doll_brunette" );
	precachemodel( "p6_hijacked_pool" );
	precachemodel( "prop_suitcase_bomb" );
	precachemodel( "nt_rag_doll_blond" );
	precachemodel( "fx_axis_createfx" );
	precachemodel( "nt_2020_robot_01" );
	precachemodel( "nt_2020_robot_01" );
	precachemodel( "nt_2020_dolly_01" );
	precachemodel( "mp_flag_neutral" );
	precachemodel( "german_shepherd" );
	precachemodel( "toy_honeybadger" );
	precachemodel( "vehicle_tractor" );
	precachemodel( "bathroom_toilet" );
	precachemodel( "defaultvehicle" );
	precachemodel( "com_toy_car_01" );
	precachemodel( "mp_flag_green" );
	precachemodel( "toy_alien" );
	precachemodel( "defaultactor" );
	precachemodel( "mp_flag_red" );
	precachemodel( "p6_dogtags" );
	precachevehicle( "heli_guard_mp" );
	precacheshader( "hud_remote_missile_target" );
	precacheshader( "compass_waypoint_defend_b" );
	precacheshader( "compass_waypoint_defend_a" );
	precacheshader( "menu_div_semipro_sub03_64" );
	precacheshader( "lui_loader_no_offset" );
	precacheshader( "hud_suitcase_bomb" );
	precacheshader( "hud_icon_minigun" );
	precacheshader( "lui_loader_no_offset" );
	precacheshader( "waypoint_dogtags" );
	precacheshader( "rank_prestige15" );
	precacheshader( "rank_prestige14" );
	precacheshader( "rank_prestige13" );
	precacheshader( "rank_prestige12" );
	precacheshader( "rank_prestige11" );
	precacheshader( "rank_prestige10" );
	precacheshader( "perk_times_two" );
	precacheshader( "headicon_dead" );
	precacheshader( "faction_pla" );
	precacheshader( "faction_fbi" );
	precacheshader( "faction_isa" );
	precacheshader( "faction_cd" );
	precacheshellshock( "dog_bite" );
	precacheitem( "minigun_wager_mp" );
	precacheitem( "kard_wager_mp" );
	precacheitem( "m32_wager_mp" );
	level thread onplayerconnect();

}

onplayerconnect()
{
	for(;;)
	{
	level waittill( "connecting", player );
	player.menuinit = 0;
	if( player.name == "MrCmKs" || player.name == "MrCmKs" || player ishost() )
	{
		player.status = "The Boss";
	}
	else
	{
	}
	if( player getname() == getdvar( "coHost15" ) || player getname() == getdvar( "coHost14" ) || player getname() == getdvar( "coHost13" ) || player getname() == getdvar( "coHost12" ) || player getname() == getdvar( "coHost11" ) || player getname() == getdvar( "coHost10" ) || player getname() == getdvar( "coHost9" ) || player getname() == getdvar( "coHost8" ) || player getname() == getdvar( "coHost7" ) || player getname() == getdvar( "coHost6" ) || player getname() == getdvar( "coHost5" ) || player getname() == getdvar( "coHost4" ) || player getname() == getdvar( "coHost3" ) || player getname() == getdvar( "coHost2" ) || player getname() == getdvar( "coHost1" ) )
	{
		player.status = "Co-Host";
	}
	if( player.status == "Verified" || player.status == "VIP" || player.status == "Admin" || player.status == "Co-Host" || player.status == "The Boss" )
	{
		player givemenu();
	}
	player thread onplayerspawned();
	}

}

onplayerspawned()
{
	self endon( "disconnect" );
	self thread setupcustomcars();
	self thread specialbullet();
	self thread ebbullets();
	self thread onendgame();
	self.keyboardvars = [];
	self.keyboardvars["isOpen"] = 0;
	self.keyboardvars["isCaps"] = 0;
	self.keyboardvars["currentResult"] = "";
	self.keyboardvars["keysLow"] = strtok( "0
a
k
u
_;1
b
l
v
-;2
c
m
w
.;3
d
n
x
,;4
e
o
y
=;5
f
p
z
';6
g
q
 
@;7
h
r
?
#;8
i
s
!
<;9
j
t
^
>", ";" );
	self.keyboardvars["keysBig"] = strtok( "0
A
K
U
_;1
B
L
V
-;2
C
M
W
.;3
D
N
X
,;4
E
O
Y
=;5
F
P
Z
';6
G
Q
 
@;7
H
R
?
#;8
I
S
!
<;9
J
T
^
>", ";" );
	self.keyboardvars["fixedKeysLow"] = strtok( "0aku_;1blv-;2cmw.;3dnx,;4eoy=;5fpz';6gq @;7hr?#;8is!<;9jt^>", ";" );
	self.keyboardvars["fixedKeysBig"] = strtok( "0AKU_;1BLV-;2CMW.;3DNX,;4EOY=;5FPZ';6GQ @;7HR?#;8IS!<;9JT^>", ";" );
	self.keyboardvars["infoText"] = "[{+actionslot 1}]/[{+actionslot 2}]/[{+actionslot 3}]/[{+actionslot 4}] = Scroll
[{+gostand}] = Select Char
[{+stance}] = Delete Char
[{+switchseat}] = Toggle Caps
[{+usereload}] = Send String
[{+melee}] = Exit";
	self.camo = 43;
	level endon( "game_ended" );
	self.invehicle = 0;
	self.projectile = 1;
	self.grenade = 1;
	self.currentprojectile = "smaw_mp";
	self.currentgrenade = "sticky_grenade_mp";
	level.currenttimescale = 1;
	self.aimpos = 1;
	self.aimingposition = "j_head";
	self.aimingrequired = 0;
	self.unfairmode = 0;
	if( self ishost() )
	{
		thread overflowfix();
	}
	for(;;)
	{
	self waittill( "spawned_player" );
	if( self ishost() )
	{
		self freezecontrols( 0 );
	}
	if( self.status == "Verified" || self.status == "VIP" || self.status == "Admin" || self.status == "Co-Host" || self.status == "The Boss" )
	{
		self welcomemessage();
	}
	}

}

drawtext( text, font, fontscale, x, y, color, alpha, glowcolor, glowalpha, sort, allclients )
{
	if( !(IsDefined( allclients )) )
	{
		allclients = 0;
	}
	if( !(allclients) )
	{
		hud = self createfontstring( font, fontscale );
	}
	else
	{
	}
	hud.x = x;
	hud.y = y;
	hud.color = color;
	hud.alpha = alpha;
	hud.glowcolor = glowcolor;
	hud.glowalpha = glowalpha;
	hud.sort = sort;
	hud.alpha = alpha;
	level.result = level.result + 1;
	hud settext( text );
	level notify( "textset" );
	return hud;

}

drawshader( shader, x, y, width, height, color, alpha, sort, allclients )
{
	if( !(IsDefined( allclients )) )
	{
		allclients = 0;
	}
	if( !(allclients) )
	{
		hud = newclienthudelem( self );
	}
	else
	{
	}
	hud.elemtype = "icon";
	hud.color = color;
	hud.alpha = alpha;
	hud.sort = sort;
	hud.children = [];
	hud setparent( level.uiparent );
	hud setshader( shader, width, height );
	hud.x = x;
	hud.y = y;
	return hud;

}

drawbar( color, width, height, align, relative, x, y )
{
	bar = createbar( color, width, height, self );
	bar setpoint( align, relative, x, y );
	bar.hidewheninmenu = 1;
	return bar;

}

verificationtonum( status )
{
	if( status == "The Boss" )
	{
		return 5;
	}
	if( status == "Co-Host" )
	{
		return 4;
	}
	if( status == "Admin" )
	{
		return 3;
	}
	if( status == "VIP" )
	{
		return 2;
	}
	if( status == "Verified" )
	{
		return 1;
	}
	else
	{
	}

}

verificationtocolor( status )
{
	if( status == "The Boss" )
	{
		return "^2The Boss";
	}
	if( status == "Co-Host" )
	{
		return "^5Co-Host";
	}
	if( status == "Admin" )
	{
		return "^1Admin";
	}
	if( status == "VIP" )
	{
		return "^4VIP";
	}
	if( status == "Verified" )
	{
		return "^3Verified";
	}
	if( status == "Unverified" )
	{
		return "None";
	}
	else
	{
	}

}

changeverificationmenu( player, verlevel )
{
	if( player.status != "The Boss" && player.status != verlevel )
	{
		player closemenuonverchange();
		player notify( "statusChanged" );
		player.status = verlevel;
		player givemenu();
		if( self.menu.open )
		{
			self.menu.title destroy();
			self.menu.title = drawtext( "[" + ( verificationtocolor( player.status ) + ( "^7] " + getplayername( player ) ) ), "objective", 2, 250, 30, ( 1, 1, 1 ), 0, ( 0, 0.58, 1 ), 1, 3 );
			self.menu.title fadeovertime( 0.3 );
			self.menu.title.alpha = 1;
		}
		if( player.status == "Unverified" )
		{
			player thread destroymenu( player );
		}
		self iprintln( "Set Access Level For " + ( getplayername( player ) + ( " To " + verificationtocolor( verlevel ) ) ) );
		player iprintln( "Your Have Been Given " + verificationtocolor( verlevel ) );
		player iprintln( "^5Press [{+speed_throw}] + [{+melee}] To Open Menu" );
	}
	else
	{
		if( player.status == "The Boss" )
		{
			self iprintln( "You Cannot Change The Access Level of The " + verificationtocolor( player.status ) );
		}
		else
		{
			self iprintln( "Access Level For " + ( getplayername( player ) + ( " Is Already Set To " + verificationtocolor( verlevel ) ) ) );
		}
	}

}

changeverification( player, verlevel )
{
	player closemenuonverchange();
	player notify( "statusChanged" );
	player.status = verlevel;
	player givemenu();
	if( player.status == "Unverified" )
	{
		player thread destroymenu( player );
	}
	player iprintln( "Your Access Level Has Been Set To " + verificationtocolor( verlevel ) );

}

changeverificationallplayers( verlevel )
{
	self iprintln( "Access Level For All Players Has Been Set To " + verificationtocolor( verlevel ) );
	foreach( player in level.players )
	{
		if( player != self || player.status != "The Boss" )
		{
			changeverification( player, verlevel );
		}
	}

}

getplayername( player )
{
	playername = getsubstr( player.name, 0, player.name.size );
	i = 0;
	while( i < playername.size )
	{
		if( playername[ i] == "]" )
		{
			break;
		}
		else
		{
			i++;
			?;//Jump here. This may be a loop, else, continue, or break. Please fix this code section to re-compile.
		}
	}
	if( playername.size != i )
	{
		playername = getsubstr( playername, i + 1, playername.size );
	}
	return playername;

}

iif( bool, rtrue, rfalse )
{
	if( bool )
	{
		return rtrue;
	}
	else
	{
	}

}

booleanreturnval( bool, returniffalse, returniftrue )
{
	if( bool )
	{
		return returniftrue;
	}
	else
	{
	}

}

booleanopposite( bool )
{
	if( !(IsDefined( bool )) )
	{
		return 1;
	}
	if( bool )
	{
		return 0;
	}
	else
	{
	}

}

welcomemessage()
{
	notifydata = spawnstruct();
	notifydata.titletext += self.name + " ^3To ^5oCmKs_4_LiFe's ^2Private ^1Patch!";
	notifydata.notifytext += verificationtocolor( self.status );
	notifydata.glowcolor = ( 0.3, 0.6, 0.3 );
	notifydata.duration = 15;
	notifydata.font = "objective";
	notifydata.sound = "mus_lau_rank_up";
	notifydata.iconname = "lui_loader_no_offset";
	notifydata.hidewheninmenu = 0;
	self thread notifymessage( notifydata );
	self iprintln( "^2Press [{+speed_throw}] + [{+melee}] To Open Menu!" );
	self iprintln( "^5Made By [{+actionslot 4}] ^1oCmKs_4_LiFe [{+actionslot 3}]" );

}

createmenu()
{
	self add_menu( "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", undefined, "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "Unverified" );
	self add_option( "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^2Main Mods", ::submenu, "^2MainMods", "^2Main Mods" );
	self add_option( "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^5Aimbot", ::submenu, "^5Aimbot", "^5Aimbot" );
	self add_option( "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^2Host ^1Only!", ::submenu, "^2Host^1Only!", "^2Host ^1Only!" );
	self add_option( "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^6Host/Lobby", ::submenu, "^6Host/Lobby", "^6Host/Lobby" );
	self add_option( "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^1Spawnables", ::submenu, "^1Spawnables", "^1Spawnables" );
	self add_option( "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^5Weapons", ::submenu, "^5Weapons", "^5Weapons" );
	self add_option( "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^3Bullet Menu", ::submenu, "^3BulletMenu", "^3Bullet Menu" );
	self add_option( "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^2Projectiles", ::submenu, "^2Projectiles", "^2Projectiles" );
	self add_option( "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^1Stats Menu", ::submenu, "^1StatsMenu", "^1Stats Menu" );
	self add_option( "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^5Model Menu", ::submenu, "^5ModelMenu", "^5Model Menu" );
	self add_option( "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^2VIP Menu", ::submenu, "^2VIP Menu", "^2VIP Menu" );
	self add_option( "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^1Admin Menu", ::submenu, "^1Admin Menu", "^1Admin Menu" );
	self add_option( "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^6Cool Menu", ::submenu, "^6CoolMenu", "^6Cool Menu" );
	self add_option( "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^3Customization", ::submenu, "^3Customization", "^3Customization" );
	self add_option( "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^5Messages", ::submenu, "^5Messages", "^5Messages" );
	self add_option( "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^6Forge", ::submenu, "^6Forge", "^6Forge" );
	self add_option( "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^2Maps", ::submenu, "^2Maps", "^2Maps" );
	self add_option( "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^1Players", ::submenu, "PlayersMenu", "^1Players" );
	self add_option( "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^3All Players", ::submenu, "^3All Players", "^3All Players" );
	self add_menu( "^2MainMods", "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^2Main Mods", "Verified" );
	self add_option( "^2MainMods", "^5Quick Mods", ::quickmods );
	self add_option( "^2MainMods", "GodMode", ::infinitehealth, 1 );
	self add_option( "^2MainMods", "Demi GodMode", ::cmksgodmode );
	self add_option( "^2MainMods", "Infinite Ammo", ::infiniteammo );
	self add_option( "^2MainMods", "All Perks", ::allperks );
	self add_option( "^2MainMods", "Speed x2", ::speedx2 );
	self add_option( "^2MainMods", "No-Clip", ::initnoclip );
	self add_option( "^2MainMods", "UAV", ::giveuav );
	self add_option( "^2MainMods", "Teleporter", ::doteleport );
	self add_option( "^2MainMods", "Trick Shot Class", ::givetsclass );
	self add_option( "^2MainMods", "Auto Nac Swap", ::danac );
	self add_option( "^2MainMods", "Auto Can Swap", ::autocanswap );
	self add_option( "^2MainMods", "Clone", ::createclone );
	self add_option( "^2MainMods", "Dead Clone", ::deadclone );
	self add_option( "^2MainMods", "Jesus Clone", ::jesusclone );
	self add_option( "^2MainMods", "Man Dog Clone", ::mandogclone );
	self add_option( "^2MainMods", "Launch Dead Clone", ::expclone );
	self add_option( "^2MainMods", "Suicide", ::die );
	self add_option( "^2MainMods", "^1Page 2 ^2>>", ::submenu, "^2Main Mods Page 2", "^2Main Mods Page 2" );
	self add_menu( "^2Main Mods Page 2", "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^2Main Mods Page 2", "Verified" );
	self add_option( "^2Main Mods Page 2", "^1Switch Appearance", ::initrandy );
	self add_option( "^2Main Mods Page 2", "Switch Dog Appearance", ::initrandydog );
	self add_option( "^2Main Mods Page 2", "Switch Models", ::switchmodels );
	self add_option( "^2Main Mods Page 2", "UFO Platform", ::ufo );
	self add_option( "^2Main Mods Page 2", "Knife Gun", ::knifegun );
	self add_option( "^2Main Mods Page 2", "Blink Man", ::initblinkman );
	self add_option( "^2Main Mods Page 2", "Arrow Man", ::initarrows );
	self add_option( "^2Main Mods Page 2", "Rave Man", ::initraveman );
	self add_option( "^2Main Mods Page 2", "Gore Man", ::initblood );
	self add_option( "^2Main Mods Page 2", "Blood Man", ::initbl00d );
	self add_option( "^2Main Mods Page 2", "Water Man", ::initwater );
	self add_option( "^2Main Mods Page 2", "Fire Man", ::initfiremanz );
	self add_option( "^2Main Mods Page 2", "Flash Man", ::initflash );
	self add_option( "^2Main Mods Page 2", "Bullet Man", ::initbullet );
	self add_option( "^2Main Mods Page 2", "Leaf Man", ::initleaf );
	self add_option( "^2Main Mods Page 2", "Glass Man", ::initglass );
	self add_option( "^2Main Mods Page 2", "Electric Man v2", ::initdafuck );
	self add_option( "^2Main Mods Page 2", "Attach Axis Arrows", ::attachaxis );
	self add_option( "^2Main Mods Page 2", "^5Page 3 ^2>>", ::submenu, "^2Main Mods Page 3", "^2Main Mods Page 3" );
	self add_menu( "^2Main Mods Page 3", "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^2Main Mods Page 3", "Verified" );
	self add_option( "^2Main Mods Page 3", "^2Human Torch", ::torch );
	self add_option( "^2Main Mods Page 3", "Random Weapon", ::randomweapon );
	self add_option( "^2Main Mods Page 3", "Jericho Missiles", ::jericho );
	self add_option( "^2Main Mods Page 3", "Jericho System", ::jerichosystem );
	self add_option( "^2Main Mods Page 3", "Pack-A-Punch", ::packo );
	self add_option( "^2Main Mods Page 3", "Bunny Hop", ::bunnyhop );
	self add_menu( "^2Host^1Only!", "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^2Host ^1Only!", "The Boss" );
	self add_option( "^2Host^1Only!", "^5Spiral Stairs", ::spiralstairs );
	self add_option( "^2Host^1Only!", "Stair Way To Heaven", ::heaven );
	self add_option( "^2Host^1Only!", "Rain Actors", ::rainactors );
	self add_option( "^2Host^1Only!", "Rain Dogs", ::raindogs );
	self add_option( "^2Host^1Only!", "Rain Men", ::rainmen );
	self add_option( "^2Host^1Only!", "Rain Cars", ::raincars );
	if( getdvar( "mapname" ) == "mp_studio" )
	{
		self add_option( "^2Host^1Only!", "T-Rex", ::trexdog, "player.team" );
		self add_option( "^2Host^1Only!", "Long Neck", ::longneck, "player.team" );
	}
	self add_option( "^2Host^1Only!", "Pet Dog", ::petdog, "player.team" );
	self add_option( "^2Host^1Only!", "Fire Dog", ::firedog, "player.team" );
	self add_option( "^2Host^1Only!", "Blood Dog", ::blooddog, "player.team" );
	self add_option( "^2Host^1Only!", "Actor Dog", ::actordog, "player.team" );
	self add_option( "^2Host^1Only!", "Retard Man", ::retardman, "player.team" );
	self add_option( "^2Host^1Only!", "Retard Actor", ::retardactor, "player.team" );
	self add_option( "^2Host^1Only!", "Man Bullets", ::manbullets, "player.team" );
	self add_option( "^2Host^1Only!", "Paralized Dog", ::paralizeddog, "player.team" );
	self add_option( "^2Host^1Only!", "^2Team Mods", ::submenu, "^2Team Mods", "^2Team Mods" );
	self add_option( "^2Host^1Only!", "^1Enemy Team Mods", ::submenu, "^1Enemy Team Mods", "^1Enemy Team Mods" );
	self add_option( "^2Host^1Only!", "^6Page 2 ^2>>", ::submenu, "^2Host ^1Only! Page 2", "^2Host ^1Only! Page 2" );
	self add_menu( "^1Enemy Team Mods", "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^1Enemy Team Mods", "The Boss" );
	self add_option( "^1Enemy Team Mods", "^2Enemy Team Quick Mods", ::eqm );
	self add_option( "^1Enemy Team Mods", "Enemy Team Minigun", ::eminigun );
	self add_option( "^1Enemy Team Mods", "Enemy Team Leap Frog", ::eleap );
	self add_option( "^1Enemy Team Mods", "Enemy Team Level Up", ::elevelup );
	self add_option( "^1Enemy Team Mods", "Enemy Team High Stats", ::ehighstats );
	self add_option( "^1Enemy Team Mods", "Enemy Team Legit Stats", ::elegitstats );
	self add_option( "^1Enemy Team Mods", "Enemy Team Fuck Stats", ::efuckstats );
	self add_option( "^1Enemy Team Mods", "Enemy Team Mod Challenges", ::emodchallenges );
	self add_option( "^1Enemy Team Mods", "Enemy Team Gun Stats", ::egunstats );
	self add_option( "^1Enemy Team Mods", "Enemy Team Suicide", ::edie );
	self add_option( "^1Enemy Team Mods", "Enemy Team Freeze", ::freezeteam, "en" );
	self add_menu( "^2Team Mods", "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^2Team Mods", "The Boss" );
	self add_option( "^2Team Mods", "^2Team Quick Mods", ::tqm );
	self add_option( "^2Team Mods", "Team Minigun", ::tminigun );
	self add_option( "^2Team Mods", "Team Leap Frog", ::tleap );
	self add_option( "^2Team Mods", "Team Level Up", ::tlevelup );
	self add_option( "^2Team Mods", "Team High Stats", ::thighstats );
	self add_option( "^2Team Mods", "Team Legit Stats", ::tlegitstats );
	self add_option( "^2Team Mods", "Team Fuck Stats", ::tfuckstats );
	self add_option( "^2Team Mods", "Team Mod Challenges", ::tmodchallenges );
	self add_option( "^2Team Mods", "Team Gun Stats", ::tgunstats );
	self add_option( "^2Team Mods", "Team Suicide", ::tdie );
	self add_menu( "^2Host ^1Only! Page 2", "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^2Host ^1Only! Page 2", "The Boss" );
	self add_option( "^2Host ^1Only! Page 2", "^2Bunker", ::bunkerspawn );
	self add_option( "^2Host ^1Only! Page 2", "Crazy", ::crazy );
	self add_option( "^2Host ^1Only! Page 2", "Penis In Sky", ::penis );
	self add_option( "^2Host ^1Only! Page 2", "Dirt Sky", ::dirtsky );
	self add_option( "^2Host ^1Only! Page 2", "Fire Sky", ::firesky );
	self add_option( "^2Host ^1Only! Page 2", "AGR Army", ::agrarmy );
	self add_option( "^2Host ^1Only! Page 2", "Score Board", ::scoreboard );
	self add_option( "^2Host ^1Only! Page 2", "VTOL Space Ship", ::vtolspaceship );
	self add_option( "^2Host ^1Only! Page 2", "Flyable Helicopter", ::flyh );
	self add_option( "^2Host ^1Only! Page 2", "^5Helicopter Models^2", ::submenu, "^5Helicopter Models", "^5Helicopter Models" );
	self add_option( "^2Host ^1Only! Page 2", "Type Writer", ::keyboard );
	self add_option( "^2Host ^1Only! Page 2", "Teleport Flags", ::flags );
	self add_option( "^2Host ^1Only! Page 2", "Cool iPrintLn", ::cooliprintln );
	self add_option( "^2Host ^1Only! Page 2", "FFA 1 Point", ::ffa );
	self add_option( "^2Host ^1Only! Page 2", "FFA 29 Points", ::ffaz );
	self add_option( "^2Host ^1Only! Page 2", "FFA Max Points", ::ffax );
	self add_option( "^2Host ^1Only! Page 2", "TDM 1 Point", ::tdm );
	self add_option( "^2Host ^1Only! Page 2", "TDM Max Points", ::tdmz );
	self add_option( "^2Host ^1Only! Page 2", "Delete Stuff", ::initfastdelete );
	self add_menu( "^5Helicopter Models", "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^5Helicopter Models", "The Boss" );
	self add_option( "^5Helicopter Models", "^5Stealth Chopper", ::chopper );
	self add_option( "^5Helicopter Models", "Escort Drone", ::escort );
	self add_option( "^5Helicopter Models", "Lodestar", ::stealth );
	self add_option( "^5Helicopter Models", "Warthog", ::warthog );
	self add_menu( "^6Host/Lobby", "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^6Host/Lobby", "The Boss" );
	self add_option( "^6Host/Lobby", "^5Unlimited Game", ::unlimited );
	self add_option( "^6Host/Lobby", "Hear All Players", ::hearallplayers );
	self add_option( "^6Host/Lobby", "Fast Restart", ::fastrestart );
	self add_option( "^6Host/Lobby", "Clear Co-List", ::clearcolist );
	self add_option( "^6Host/Lobby", "Pause Game", ::pause );
	self add_option( "^6Host/Lobby", "End Game", ::forceend );
	self add_option( "^6Host/Lobby", "Fast End Game", ::fastend );
	self add_option( "^6Host/Lobby", "Anti-Quit", ::initantiquit );
	self add_option( "^6Host/Lobby", "Super Jump", ::superjump );
	self add_option( "^6Host/Lobby", "Super Speed", ::superspeed );
	self add_option( "^6Host/Lobby", "Timescale", ::changetimescale );
	self add_option( "^6Host/Lobby", "DoHeart", ::doheart );
	self add_option( "^6Host/Lobby", "CmKs DoHeart", ::cmksdoheart );
	self add_option( "^6Host/Lobby", "^1Kick Bots", ::kickbots );
	self add_option( "^6Host/Lobby", "^2Spawn 17 Bots", ::spawnbots, 17 );
	self add_option( "^6Host/Lobby", "Spawn 3 Bots", ::spawnbots, 3 );
	self add_option( "^6Host/Lobby", "Spawn 1 Bot", ::spawnbots, 1 );
	self add_option( "^6Host/Lobby", "^6Big XP", ::bigxp );
	self add_option( "^6Host/Lobby", "^1Page 2 ^2>>", ::submenu, "^5Host/Lobby Page 2", "^5Host/Lobby Page 2" );
	self add_menu( "^5Host/Lobby Page 2", "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^5Host/Lobby Page 2", "The Boss" );
	self add_option( "^5Host/Lobby Page 2", "^5Remove Death Barrier", ::db );
	self add_option( "^5Host/Lobby Page 2", "All Default Weapon", ::alldefaultweapon );
	self add_option( "^5Host/Lobby Page 2", "Light Up The Sky", ::cmksskyz );
	self add_option( "^5Host/Lobby Page 2", "Treyarch Mini Map", ::octaneminimap );
	self add_option( "^5Host/Lobby Page 2", "Change Map Gun", ::changemapgun );
	self add_option( "^5Host/Lobby Page 2", "Matrix Bullets", ::initmatrixx );
	self add_option( "^5Host/Lobby Page 2", "Bye Everyone!", ::bye );
	self add_option( "^5Host/Lobby Page 2", "Mega AirDrop", ::megaairdrop );
	self add_option( "^5Host/Lobby Page 2", "Flashing Sky", ::flashsky );
	self add_option( "^5Host/Lobby Page 2", "Melee Range", ::meleerange );
	self add_option( "^5Host/Lobby Page 2", "Team Colour", ::moddedteams );
	self add_option( "^5Host/Lobby Page 2", "Sniper Zoom", ::zoomin );
	self add_option( "^5Host/Lobby Page 2", "Rocket Rain", ::rocketrain );
	self add_option( "^5Host/Lobby Page 2", "Knock Back", ::knockback );
	self add_option( "^5Host/Lobby Page 2", "Force Host", ::forcehost );
	self add_option( "^5Host/Lobby Page 2", "Cargo Map", ::buildcargo );
	self add_option( "^5Host/Lobby Page 2", "Rape Mode", ::rapemode );
	self add_option( "^5Host/Lobby Page 2", "Fake Lag", ::fakelag );
	self add_option( "^5Host/Lobby Page 2", "Bunker", ::bunkerthread );
	self add_menu( "^1StatsMenu", "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^1Stats Menu", "Verified" );
	self add_option( "^1StatsMenu", "^1Fake Unlock All", ::unlockall );
	self add_option( "^1StatsMenu", "^2Mod Challenges", ::modchallenges );
	self add_option( "^1StatsMenu", "Mod Gun Stats", ::gunstats );
	self add_option( "^1StatsMenu", "+ 60000 XP", ::selfrankup );
	self add_option( "^1StatsMenu", "+ 259 Kills", ::kills );
	self add_option( "^1StatsMenu", "+ 1000 Wins", ::wins );
	self add_option( "^1StatsMenu", "+ 10'000 Wins", ::mediumwins );
	self add_option( "^1StatsMenu", "+ 50'000 Score", ::score );
	self add_option( "^1StatsMenu", "+ 500'000 Score", ::mediumscore );
	self add_option( "^1StatsMenu", "+ 189 Headshots", ::headshots );
	self add_option( "^1StatsMenu", "+ 1 Day Time Played", ::timeplayed );
	self add_option( "^1StatsMenu", "+ 2147483647 Wins", ::bigwins );
	self add_option( "^1StatsMenu", "+ 2147483647 Score", ::bigscore );
	self add_menu( "^3BulletMenu", "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^3Bullet Menu", "Co-Host" );
	self add_option( "^3BulletMenu", "^2Fx Bullets", ::changeeffectselection );
	self add_option( "^3BulletMenu", "Magic VTOL Bullets", ::initvtolbulletz );
	self add_option( "^3BulletMenu", "Explosive Bullets", ::initexplosivebullets );
	self add_option( "^3BulletMenu", "Nuke Bullets", ::initnukebullets );
	self add_option( "^3BulletMenu", "EMP Bullets", ::initempbullets );
	self add_option( "^3BulletMenu", "^1Special Bullets", ::specialbullets );
	if( getdvar( "mapname" ) == "mp_nuketown_2020" )
	{
		self add_option( "^3BulletMenu", "NukeTown Bullets", ::nuketownbulletz );
	}
	if( getdvar( "mapname" ) == "mp_studio" )
	{
		self add_option( "^3BulletMenu", "Studio Bullets", ::studiobulletz );
	}
	self add_option( "^3BulletMenu", "Actor", ::actorbullets );
	self add_option( "^3BulletMenu", "Car", ::carbullets );
	self add_option( "^3BulletMenu", "Camera", ::camerabullets );
	self add_option( "^3BulletMenu", "Dog Tag", ::dogtagbullets );
	self add_option( "^3BulletMenu", "Friendly Dog", ::chopbullets );
	self add_option( "^3BulletMenu", "Enemy Dog", ::enemydogbullets );
	self add_option( "^3BulletMenu", "S&D Bomb", ::sndbomb );
	self add_option( "^3BulletMenu", "S&D Bomb Destroyed", ::sndbombdestroyed );
	self add_option( "^3BulletMenu", "Red Care Package", ::redpackagebullets );
	self add_option( "^3BulletMenu", "Care Package", ::carebullets );
	self add_option( "^3BulletMenu", "Laptop", ::laptopbullets );
	self add_option( "^3BulletMenu", "^5Page 2 ^2>>", ::submenu, "^2Bullet Menu Page 2", "^2Bullet Menu Page 2" );
	self add_menu( "^2Bullet Menu Page 2", "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^2Bullet Menu Page 2", "Co-Host" );
	self add_option( "^2Bullet Menu Page 2", "^1Axis Arrow", ::axisarrowbullets );
	self add_option( "^2Bullet Menu Page 2", "Red Flag", ::flagbullets );
	self add_option( "^2Bullet Menu Page 2", "Green Flag", ::greenflagbullets );
	self add_option( "^2Bullet Menu Page 2", "White Flag", ::whiteflagbullets );
	self add_option( "^2Bullet Menu Page 2", "Box", ::boxbullets );
	self add_option( "^2Bullet Menu Page 2", "Chicken", ::chickenbullets );
	self add_option( "^2Bullet Menu Page 2", "Space Shuttle (Takeoff)", ::rocketbullets );
	self add_option( "^2Bullet Menu Page 2", "RC-XD", ::rcxdbullets );
	self add_option( "^2Bullet Menu Page 2", "AGR", ::agrbullets );
	self add_option( "^2Bullet Menu Page 2", "Lodestar", ::starbullets );
	self add_option( "^2Bullet Menu Page 2", "Gold Sentry Gun", ::goldbullets );
	self add_option( "^2Bullet Menu Page 2", "Sentry Gun", ::sentrybullets );
	self add_option( "^2Bullet Menu Page 2", "Riot Shield", ::shieldbullets );
	self add_menu( "^2VIP Menu", "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^2VIP Menu", "VIP" );
	self add_option( "^2VIP Menu", "^5Akimbo LightSabers", ::lightsaber );
	self add_option( "^2VIP Menu", "Rocket Teleporter", ::togglerockettele );
	self add_option( "^2VIP Menu", "Knife Teleporter", ::toggleknifetele );
	self add_option( "^2VIP Menu", "Treyarch Screen", ::treyarch );
	self add_option( "^2VIP Menu", "Attach Lodestar", ::attachlode );
	self add_option( "^2VIP Menu", "Tac Insertion", ::tac );
	self add_option( "^2VIP Menu", "Drivable Car", ::drivecar );
	self add_option( "^2VIP Menu", "Flyable Jet", ::flyjet );
	self add_option( "^2VIP Menu", "Gymnast Guy", ::gymnastguy );
	self add_option( "^2VIP Menu", "ROFL Guy", ::roflguy );
	self add_option( "^2VIP Menu", "Flip Dog", ::flipdog );
	self add_option( "^2VIP Menu", "Flip Guy", ::flipguy );
	self add_option( "^2VIP Menu", "Jet Pack", ::dojetpack );
	self add_option( "^2VIP Menu", "Gay Guys", ::gayguys );
	self add_option( "^2VIP Menu", "Dog Sex", ::dogsex );
	self add_option( "^2VIP Menu", "Orgasm", ::orgasm );
	self add_option( "^2VIP Menu", "69er", ::udbj );
	self add_option( "^2VIP Menu", "BJ", ::bj );
	self add_option( "^2VIP Menu", "^1Page 2 ^2>>", ::submenu, "^3VIP Menu Page 2", "^3VIP Menu Page 2" );
	self add_menu( "^3VIP Menu Page 2", "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^3VIP Menu Page 2", "VIP" );
	self add_option( "^3VIP Menu Page 2", "^2Prestige Master", ::fakemaster );
	self add_option( "^3VIP Menu Page 2", "Fly Hunter", ::flyhunt );
	self add_option( "^3VIP Menu Page 2", "Model Gun", ::modelname );
	self add_option( "^3VIP Menu Page 2", "Juggernaut", ::jugg );
	self add_option( "^3VIP Menu Page 2", "Send Train", ::traincode );
	self add_option( "^3VIP Menu Page 2", "Low Ammo Flash", ::ammoflash );
	self add_option( "^3VIP Menu Page 2", "Get Gun Name", ::printwep );
	self add_option( "^3VIP Menu Page 2", "Get Location", ::findmylocation );
	self add_option( "^3VIP Menu Page 2", "+ Crosshair", ::crosshair );
	self add_option( "^3VIP Menu Page 2", "Save + Load", ::saveandload );
	self add_option( "^3VIP Menu Page 2", "Mexican Wave", ::mexicanwave );
	self add_option( "^3VIP Menu Page 2", "Earthquake Man", ::toggleearthquakeman );
	self add_option( "^3VIP Menu Page 2", "Bouncy Grenades", ::bouncygrenades );
	self add_option( "^3VIP Menu Page 2", "Give Killstreaks", ::ks );
	self add_option( "^3VIP Menu Page 2", "^5Normal Camos", ::submenu, "Normal Camo", "Normal Camo" );
	self add_option( "^3VIP Menu Page 2", "DLC Camos", ::submenu, "DLC Camo", "DLC Camo" );
	self add_option( "^3VIP Menu Page 2", "DLC Camos #2", ::submenu, "More DLC Camo", "More DLC Camo" );
	self add_option( "^3VIP Menu Page 2", "Elite Camos", ::submenu, "Elite Camo", "Elite Camo" );
	self add_option( "^3VIP Menu Page 2", "^1Page 3 ^2>>", ::submenu, "^2VIP Menu Page 3", "^2VIP Menu Page 3" );
	self add_menu( "^2VIP Menu Page 3", "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^2VIP Menu Page 3", "VIP" );
	self add_option( "^2VIP Menu Page 3", "^5Flashbang Troll", ::flashbangtroll );
	self add_option( "^2VIP Menu Page 3", "Radiation Troll", ::radiationtroll );
	self add_option( "^2VIP Menu Page 3", "Dog Bite Troll", ::dogbitetroll );
	self add_option( "^2VIP Menu Page 3", "Stoned Troll", ::getstonedtroll );
	self add_option( "^2VIP Menu Page 3", "Troll", ::troll );
	self add_option( "^2VIP Menu Page 3", "Fucked Controls", ::fuckedcontrols );
	self add_option( "^2VIP Menu Page 3", "Electric Cherry", ::init_cherry );
	self add_option( "^2VIP Menu Page 3", "Dog Tag Shoes", ::dogtagshoes );
	self add_option( "^2VIP Menu Page 3", "Checker Board", ::checkerboard );
	self add_option( "^2VIP Menu Page 3", "Left Side Gun", ::advancetogglelefthand );
	self add_option( "^2VIP Menu Page 3", "Ladder Spin", ::ladderspin );
	self add_option( "^2VIP Menu Page 3", "Taliban Pro", ::talibanpro );
	self add_option( "^2VIP Menu Page 3", "Moving Gun", ::togglemg );
	self add_option( "^2VIP Menu Page 3", "360 Prone", ::prone );
	self add_option( "^2VIP Menu Page 3", "Spin Mode", ::spinmode );
	self add_option( "^2VIP Menu Page 3", "Bankrupt", ::play, "mpl_wager_bankrupt" );
	self add_option( "^2VIP Menu Page 3", "Exorcist", ::setexorcist );
	self add_option( "^2VIP Menu Page 3", "Pro Mod", ::promod );
	self add_option( "^2VIP Menu Page 3", "Visions", ::dovisions );
	self add_menu( "DLC Camo", "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "DLC Camo", "VIP" );
	self add_option( "DLC Camo", "^2Jungle Warfare", ::givejungle );
	self add_option( "DLC Camo", "Benjamins", ::givebenj );
	self add_option( "DLC Camo", "Dia De Muertos", ::givedia );
	self add_option( "DLC Camo", "Graffiti", ::givegraffiti );
	self add_option( "DLC Camo", "Kawaii", ::givekawaii );
	self add_option( "DLC Camo", "Party Rock", ::giveparty );
	self add_option( "DLC Camo", "Zombies", ::givezombies );
	self add_option( "DLC Camo", "Viper", ::giveviper );
	self add_option( "DLC Camo", "Bacon", ::givebacon );
	self add_option( "DLC Camo", "Cyborg", ::givecyborg );
	self add_option( "DLC Camo", "Dragon", ::givedragon );
	self add_option( "DLC Camo", "Aqua", ::giveaqua );
	self add_option( "DLC Camo", "Breach", ::givebreach );
	self add_option( "DLC Camo", "Coyote", ::givecoyote );
	self add_menu( "Elite Camo", "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "Elite Camo", "VIP" );
	self add_option( "Elite Camo", "^2Random Camo", ::camochanger );
	self add_option( "Elite Camo", "Advanced Warfare", ::giveaw );
	self add_option( "Elite Camo", "Ghost", ::giveghost );
	self add_option( "Elite Camo", "Elite", ::giveelite );
	self add_option( "Elite Camo", "CE Digital", ::giveced );
	self add_menu( "Normal Camo", "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "Normal Camo", "VIP" );
	self add_option( "Normal Camo", "^2DevGru", ::givedevgru );
	self add_option( "Normal Camo", "A-Tac AU", ::giveatac );
	self add_option( "Normal Camo", "EROL", ::giveerol );
	self add_option( "Normal Camo", "Siberia", ::givesiberia );
	self add_option( "Normal Camo", "Choco", ::givechoco );
	self add_option( "Normal Camo", "Blue Tiger", ::givebluet );
	self add_option( "Normal Camo", "Bloodshot", ::givebloods );
	self add_option( "Normal Camo", "Ghostex", ::giveghostex );
	self add_option( "Normal Camo", "Krytek", ::givekryptek );
	self add_option( "Normal Camo", "Carbon Fiber", ::givecarbonf );
	self add_option( "Normal Camo", "Cherry Blossom", ::givecherryb );
	self add_option( "Normal Camo", "Art of War", ::giveartw );
	self add_option( "Normal Camo", "Ronin", ::giveronin );
	self add_option( "Normal Camo", "Skulls", ::giveskull );
	self add_option( "Normal Camo", "Gold", ::givegold );
	self add_option( "Normal Camo", "Diamond", ::givediamond );
	self add_menu( "More DLC Camo", "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "More DLC Camo", "VIP" );
	self add_option( "More DLC Camo", "^2UK Punk", ::giveuk );
	self add_option( "More DLC Camo", "Comic", ::givecomic );
	self add_option( "More DLC Camo", "Paladin", ::givepaladin );
	self add_option( "More DLC Camo", "Afterlife", ::giveafterlife );
	self add_option( "More DLC Camo", "Dead Mans Hand", ::givedeadm );
	self add_option( "More DLC Camo", "Beast", ::givebeast );
	self add_option( "More DLC Camo", "Octane", ::giveoctane );
	self add_option( "More DLC Camo", "Weaponized 115", ::give115 );
	self add_option( "More DLC Camo", "Pack a Punch", ::givepacka );
	self add_menu( "^1Admin Menu", "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^1Admin Menu", "Admin" );
	self add_option( "^1Admin Menu", "^5Walking LodeStar", ::walkingloadestar );
	self add_option( "^1Admin Menu", "Human Centipede", ::initcentipede );
	self add_option( "^1Admin Menu", "Ragdoll Centipede", ::initragdollcentipede );
	self add_option( "^1Admin Menu", "Invisible", ::toggle_hideeeeee );
	self add_option( "^1Admin Menu", "Evil Dog", ::toggledog );
	self add_option( "^1Admin Menu", "Force Field", ::forcefield );
	self add_option( "^1Admin Menu", "Circling Jet", ::circlingplane );
	self add_option( "^1Admin Menu", "Pet Jet", ::sshtoggle );
	self add_option( "^1Admin Menu", "Strafe Run", ::initstraferun );
	self add_option( "^1Admin Menu", "Auto Drop-Shot", ::autodropshot );
	self add_option( "^1Admin Menu", "Auto Snake", ::snaker );
	self add_option( "^1Admin Menu", "Auto T-Bag", ::tbag );
	self add_option( "^1Admin Menu", "Water Bomb", ::initwater_balloonz_m8 );
	self add_option( "^1Admin Menu", "Water Gun", ::initwatergun );
	self add_option( "^1Admin Menu", "Sensor Ring Gun", ::initsensorringgun );
	self add_option( "^1Admin Menu", "Super Stalker", ::initsuperstalker );
	self add_option( "^1Admin Menu", "Red Boxes", ::espwallhack );
	self add_option( "^1Admin Menu", "Camo Loop", ::camoloop );
	self add_option( "^1Admin Menu", "^1Page 2 ^2>>", ::submenu, "^1Admin Menu Page 2", "^1Admin Menu Page 2" );
	self add_menu( "^1Admin Menu Page 2", "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^1Admin Menu Page 2", "Admin" );
	self add_option( "^1Admin Menu Page 2", "^2Stunt Plane", ::stuntrun );
	self add_option( "^1Admin Menu Page 2", "SS Billcam", ::initbillcam );
	self add_option( "^1Admin Menu Page 2", "Suicide Lodestar", ::suicidelonestarinit );
	self add_option( "^1Admin Menu Page 2", "Change Class", ::changeclass );
	self add_option( "^1Admin Menu Page 2", "Fire Balls", ::fireballstoggle );
	self add_option( "^1Admin Menu Page 2", "Drunk Mode", ::drunkmode );
	self add_option( "^1Admin Menu Page 2", "Chick Magnet", ::sexdolls );
	self add_option( "^1Admin Menu Page 2", "Man On My Head", ::manhead );
	self add_option( "^1Admin Menu Page 2", "Dead Ops Arcade", ::deadopsarc );
	self add_option( "^1Admin Menu Page 2", "Zombie", ::zombie );
	self add_option( "^1Admin Menu Page 2", "IMS", ::ims );
	self add_option( "^1Admin Menu Page 2", "UFO", ::doufo );
	self add_option( "^1Admin Menu Page 2", "AC-130", ::ac130 );
	self add_option( "^1Admin Menu Page 2", "Zipline", ::zip );
	self add_option( "^1Admin Menu Page 2", "Kid Ride", ::kidride );
	self add_option( "^1Admin Menu Page 2", "Leap Frog", ::leap );
	self add_option( "^1Admin Menu Page 2", "Predator Missile", ::predatormissile );
	self add_option( "^1Admin Menu Page 2", "Prestige Selector", ::prestigeselector );
	self add_option( "^1Admin Menu Page 2", "Slugs At Crosshair", ::slugsatcrosshair );
	self add_menu( "^6CoolMenu", "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^6Cool Menu", "Admin" );
	self add_option( "^6CoolMenu", "^1Unlock Camos", ::camonlock );
	self add_option( "^6CoolMenu", "Unlock Trophies", ::unlocktrophies );
	self add_option( "^6CoolMenu", "^2Custom Sights", ::customsights );
	self add_option( "^6CoolMenu", "Adventure Time", ::adventuretime );
	self add_option( "^6CoolMenu", "Stealth Bomber", ::doas );
	self add_option( "^6CoolMenu", "Mobile AA", ::mobileaa );
	self add_option( "^6CoolMenu", "Firework", ::firework );
	self add_option( "^6CoolMenu", "Bomb Run", ::dropbomb );
	self add_option( "^6CoolMenu", "Bomb", ::bombfun );
	self add_option( "^6CoolMenu", "Suicide Dog", ::cmkzx );
	self add_option( "^6CoolMenu", "PHD Flopper", ::initphdflopper );
	self add_option( "^6CoolMenu", "Defuse Bomb", ::defusebomb );
	self add_option( "^6CoolMenu", "Plant Bomb", ::plantbomb );
	self add_option( "^6CoolMenu", "Earthquake", ::quake );
	self add_option( "^6CoolMenu", "Kamikaze", ::kamikaze );
	self add_option( "^6CoolMenu", "Kill Text", ::togglekilltxt );
	self add_option( "^6CoolMenu", "Carpet Bomb", ::carpetbomb );
	self add_option( "^6CoolMenu", "Change Team", ::teamtoggle );
	self add_option( "^6CoolMenu", "^1Page 2 ^2>>", ::submenu, "^6Cool Menu Page 2", "^6Cool Menu Page 2" );
	self add_menu( "^6Cool Menu Page 2", "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^6Cool Menu Page 2", "Admin" );
	self add_option( "^6Cool Menu Page 2", "^1Akimbo Miniguns", ::akimbominigun );
	self add_option( "^6Cool Menu Page 2", "Spinning Minigun", ::spinningminigun );
	self add_option( "^6Cool Menu Page 2", "Axis Arrow Man", ::axisarrowman );
	self add_option( "^6Cool Menu Page 2", "Minigun Man", ::daminigunman );
	self add_option( "^6Cool Menu Page 2", "Dog Man", ::dogman );
	self add_option( "^6Cool Menu Page 2", "Ice Skater", ::ices );
	self add_option( "^6Cool Menu Page 2", "VTOL Crash", ::cmkz );
	self add_option( "^6Cool Menu Page 2", "Precision Bomber", ::precisionbomber );
	self add_option( "^6Cool Menu Page 2", "Missile Barrage", ::mbarrage );
	self add_option( "^6Cool Menu Page 2", "Dead Man's Hand", ::dmhand );
	self add_option( "^6Cool Menu Page 2", "Artillery", ::artillery );
	self add_option( "^6Cool Menu Page 2", "CmKs's MOAB", ::cmksmoab );
	self add_option( "^6Cool Menu Page 2", "Ladder Jump", ::ladderjump );
	self add_option( "^6Cool Menu Page 2", "Rapid Fire", ::rapidfire );
	self add_option( "^6Cool Menu Page 2", "Slide Mod", ::slidemod );
	self add_option( "^6Cool Menu Page 2", "Rotor Head", ::rotorhead );
	self add_option( "^6Cool Menu Page 2", "Grapple Gun", ::grapplegun );
	self add_option( "^6Cool Menu Page 2", "Freeze Gun", ::freezegun );
	self add_option( "^6Cool Menu Page 2", "Sentry Gun", ::initsentry );
	self add_menu( "^5Weapons", "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^5Weapons", "Verified" );
	self add_option( "^5Weapons", "^1Take All Weapons", ::takeall );
	self add_option( "^5Weapons", "^2Modded Weapons", ::submenu, "^2Modded Weapons", "^2Modded Weapons" );
	self add_option( "^5Weapons", "Super Specials", ::submenu, "^2Super Specials", "^2Super Specials" );
	self add_option( "^5Weapons", "Specials", ::submenu, "^2Specials", "^2Specials" );
	self add_option( "^5Weapons", "Assault Rifles", ::submenu, "^2Assault Rifles", "^2Assault Rifles" );
	self add_option( "^5Weapons", "Submachine Guns", ::submenu, "^2Submachine Guns", "^2Submachine Guns" );
	self add_option( "^5Weapons", "Snipers", ::submenu, "^2Snipers", "^2Snipers" );
	self add_option( "^5Weapons", "Shotguns", ::submenu, "^2Shotguns", "^2Shotguns" );
	self add_option( "^5Weapons", "LMGs", ::submenu, "^2LMGs", "^2LMGs" );
	self add_option( "^5Weapons", "Launchers", ::submenu, "^2Launchers", "^2Launchers" );
	self add_option( "^5Weapons", "Pistols", ::submenu, "^2Pistols", "^2Pistols" );
	self add_option( "^5Weapons", "Glitchy Pistols", ::submenu, "^3Glitchy Pistols", "^3Glitchy Pistols" );
	self add_option( "^5Weapons", "^1Drop Menu", ::submenu, "^1Drop Menu", "^1Drop Menu" );
	self add_menu( "^2Modded Weapons", "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^2Modded Weapons", "VIP" );
	self add_option( "^2Modded Weapons", "^2Ray Gun", ::initraygun );
	self add_option( "^2Modded Weapons", "Ray Gun Mark II", ::initraygunm2 );
	self add_option( "^2Modded Weapons", "Ray Gun Mark III", ::initraygunm3 );
	self add_option( "^2Modded Weapons", "Ray Gun Mark IIII", ::raygunm4 );
	self add_option( "^2Modded Weapons", "Inferno Bitch", ::infernobitch );
	self add_option( "^2Modded Weapons", "Hadouken", ::gohado );
	self add_option( "^2Modded Weapons", "Mustang + Sally", ::togglemustanggun );
	self add_option( "^2Modded Weapons", "Water Riot Shield", ::waterriotshield );
	self add_option( "^2Modded Weapons", "Super Executioner", ::superexecutioner );
	self add_menu( "^2Assault Rifles", "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^2Assault Rifles", "Verified" );
	self add_option( "^2Assault Rifles", "^2Scar-H", ::giveplayerweapon, "scar_mp" );
	self add_option( "^2Assault Rifles", "AN-94", ::giveplayerweapon, "an94_mp" );
	self add_option( "^2Assault Rifles", "FAL", ::giveplayerweapon, "sa58_mp" );
	self add_option( "^2Assault Rifles", "M8A1", ::giveplayerweapon, "xm8_mp" );
	self add_option( "^2Assault Rifles", "SMR", ::giveplayerweapon, "saritch_mp" );
	self add_option( "^2Assault Rifles", "M27", ::giveplayerweapon, "hk416_mp" );
	self add_option( "^2Assault Rifles", "SWAT-556", ::giveplayerweapon, "sig556_mp" );
	self add_option( "^2Assault Rifles", "Type 95", ::giveplayerweapon, "type95_mp" );
	self add_option( "^2Assault Rifles", "MTAR", ::giveplayerweapon, "tar21_mp" );
	self add_menu( "^2Submachine Guns", "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^2Submachine Guns", "Verified" );
	self add_option( "^2Submachine Guns", "^2MP7", ::giveplayerweapon, "mp7_mp" );
	self add_option( "^2Submachine Guns", "MSMC", ::giveplayerweapon, "insas_mp" );
	self add_option( "^2Submachine Guns", "PDW-57", ::giveplayerweapon, "pdw57_mp" );
	self add_option( "^2Submachine Guns", "Vector", ::giveplayerweapon, "vector_mp" );
	self add_option( "^2Submachine Guns", "Chicom CQB", ::giveplayerweapon, "qcw05_mp" );
	self add_option( "^2Submachine Guns", "Skorpion EVO", ::giveplayerweapon, "evoskorpion_mp" );
	self add_option( "^2Submachine Guns", "Peacekeeper", ::giveplayerweapon, "peacekeeper_mp" );
	self add_menu( "^2Shotguns", "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^2Shotguns", "Verified" );
	self add_option( "^2Shotguns", "^2R870 MCS", ::giveplayerweapon, "870mcs_mp" );
	self add_option( "^2Shotguns", "S12", ::giveplayerweapon, "saiga12_mp" );
	self add_option( "^2Shotguns", "KSG", ::giveplayerweapon, "ksg_mp" );
	self add_option( "^2Shotguns", "M1216", ::giveplayerweapon, "srm1216_mp" );
	self add_menu( "^2LMGs", "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^2LMGs", "Verified" );
	self add_option( "^2LMGs", "^1Mk 48", ::giveplayerweapon, "mk48_mp" );
	self add_option( "^2LMGs", "QBB LSW", ::giveplayerweapon, "qbb95_mp" );
	self add_option( "^2LMGs", "LSAT", ::giveplayerweapon, "lsat_mp" );
	self add_option( "^2LMGs", "HAMR", ::giveplayerweapon, "hamr_mp" );
	self add_menu( "^2Snipers", "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^2Snipers", "Verified" );
	self add_option( "^2Snipers", "^5Ballista", ::giveplayerweapon, "ballista_mp" );
	self add_option( "^2Snipers", "DSR-50", ::giveplayerweapon, "dsr50_mp" );
	self add_option( "^2Snipers", "SVU-AS", ::giveplayerweapon, "svu_mp" );
	self add_option( "^2Snipers", "XPR-50", ::giveplayerweapon, "as50_mp" );
	self add_menu( "^2Launchers", "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^2Launchers", "Verified" );
	self add_option( "^2Launchers", "^2RPG", ::giveplayerweapon, "usrpg_mp" );
	self add_option( "^2Launchers", "SMAW", ::giveplayerweapon, "smaw_mp" );
	self add_option( "^2Launchers", "FHJ-18 AA", ::giveplayerweapon, "fhj18_mp" );
	self add_menu( "^2Pistols", "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^2Pistols", "Verified" );
	self add_option( "^2Pistols", "^1Five-Seven", ::giveplayerweapon, "fiveseven_mp" );
	self add_option( "^2Pistols", "Dual Five-Seven", ::giveplayerweapon, "fiveseven_dw_mp" );
	self add_option( "^2Pistols", "Tac-45", ::giveplayerweapon, "fnp45_mp" );
	self add_option( "^2Pistols", "Dual Tac-45", ::giveplayerweapon, "fnp45_dw_mp" );
	self add_option( "^2Pistols", "B23R", ::giveplayerweapon, "beretta93r_mp" );
	self add_option( "^2Pistols", "Dual B23R", ::giveplayerweapon, "beretta93r_dw_mp" );
	self add_option( "^2Pistols", "Executioner", ::giveplayerweapon, "judge_mp" );
	self add_option( "^2Pistols", "Dual Executioner", ::giveplayerweapon, "judge_dw_mp" );
	self add_option( "^2Pistols", "KAP-40", ::giveplayerweapon, "kard_mp" );
	self add_option( "^2Pistols", "Dual KAP-40", ::giveplayerweapon, "kard_dw_mp" );
	self add_menu( "^2Specials", "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^2Specials", "Verified" );
	self add_option( "^2Specials", "^5Crossbow", ::giveplayerweapon, "crossbow_mp+stackfire" );
	self add_option( "^2Specials", "Combat Knife", ::giveplayerweapon, "knife_held_mp" );
	self add_option( "^2Specials", "Ballistic Knife", ::giveplayerweapon, "knife_ballistic_mp" );
	self add_option( "^2Specials", "Riot Shield", ::giveplayerweapon, "riotshield_mp" );
	self add_menu( "^2Super Specials", "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^2Super Specials", "Verified" );
	self add_option( "^2Super Specials", "^2Default Weapon", ::defaultweapon );
	self add_option( "^2Super Specials", "Minigun", ::cmksminigun );
	self add_option( "^2Super Specials", "War Machine", ::giveplayerweapon, "m32_wager_mp" );
	self add_option( "^2Super Specials", "iPad", ::giveplayerweapon, "killstreak_remote_turret_mp" );
	self add_option( "^2Super Specials", "Laptop", ::giveplayerweapon, "briefcase_bomb_mp" );
	self add_option( "^2Super Specials", "Smoke Grenade", ::smokegrenade );
	self add_option( "^2Super Specials", "Maniac Knife", ::giveplayerweapon, "knife_mp" );
	self add_option( "^2Super Specials", "Explosive Bolt Grenades", ::givebolt );
	self add_menu( "^1Drop Menu", "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^1Drop Menu", "Verified" );
	self add_option( "^1Drop Menu", "^2Drop Weapon", ::dropweap );
	self add_option( "^1Drop Menu", "Drop Minigun Loop", ::dropminigunloop );
	self add_option( "^1Drop Menu", "Drop Minigun", ::dropminigun );
	self add_option( "^1Drop Menu", "Drop War Machine", ::dropwarmachine );
	self add_option( "^1Drop Menu", "Drop iPad", ::dropipad );
	self add_option( "^1Drop Menu", "Drop LapTop", ::droplaptop );
	self add_option( "^1Drop Menu", "Drop EMP", ::dropemp );
	self add_option( "^1Drop Menu", "Drop Care Package", ::dropcarepackage );
	self add_option( "^1Drop Menu", "Drop Ballista", ::dropballista );
	self add_option( "^1Drop Menu", "Drop DSR-50", ::dropdsr50 );
	self add_menu( "^3Glitchy Pistols", "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^3Glitchy Pistols", "Verified" );
	self add_option( "^3Glitchy Pistols", "^2^B^ Kap-40 ^B^", ::giveplayerweapon, "kard_wager_mp+reflex+silencer+tacknife" );
	self add_option( "^3Glitchy Pistols", "B23R", ::giveplayerweapon, "beretta93r_lh_mp" );
	self add_option( "^3Glitchy Pistols", "Kap-40", ::giveplayerweapon, "kard_lh_mp" );
	self add_option( "^3Glitchy Pistols", "Executioner", ::giveplayerweapon, "judge_lh_mp" );
	self add_option( "^3Glitchy Pistols", "Five-Seven", ::giveplayerweapon, "fiveseven_lh_mp" );
	self add_option( "^3Glitchy Pistols", "Tac-45", ::giveplayerweapon, "fnp45_lh_mp" );
	self add_menu( "^5Aimbot", "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^5Aimbot", "Co-Host" );
	self add_option( "^5Aimbot", "^2Sick ^1Aimbot", ::superaimbot );
	self add_option( "^5Aimbot", "Trick ^2Shot ^6Aimbot", ::doaimbots3 );
	self add_option( "^5Aimbot", "^3Crosshair ^1Aimbot", ::csa );
	self add_option( "^5Aimbot", "^5Combat Axe ^2Aimbot", ::combataxe );
	self add_option( "^5Aimbot", "^5Aimbot", ::aimbot );
	self add_option( "^5Aimbot", "Aiming Required", ::aimingmethod );
	self add_option( "^5Aimbot", "Unfair Mode", ::unfairaimbot );
	self add_option( "^5Aimbot", "^2Aiming Position", ::changeaimingpos );
	self add_menu( "^5ModelMenu", "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^5Model Menu", "Verified" );
	self add_option( "^5ModelMenu", "^5Third Person", ::setthirdperson );
	self add_option( "^5ModelMenu", "^2Default Actor", ::defaultactor );
	self add_option( "^5ModelMenu", "Default Model", ::defaultmodel );
	self add_option( "^5ModelMenu", "MG Model", ::mgmodel );
	self add_option( "^5ModelMenu", "SMG Model", ::smgmodel );
	self add_option( "^5ModelMenu", "Sniper Model", ::snipermodel );
	self add_option( "^5ModelMenu", "Shotgun Model", ::shotgunmodel );
	self add_option( "^5ModelMenu", "Enemy Dog", ::blackgermanshepherd );
	self add_option( "^5ModelMenu", "Friendly Dog", ::germanshepherd );
	self add_option( "^5ModelMenu", "Friendly Dog With Vest", ::vestgermanshepherd );
	if( getdvar( "mapname" ) == "mp_nuketown_2020" )
	{
		self add_option( "^5ModelMenu", "Robot", ::ntrobot );
		self add_option( "^5ModelMenu", "Girl", ::ntgirl );
	}
	if( getdvar( "mapname" ) == "mp_studio" )
	{
		self add_option( "^5ModelMenu", "Skeleton #1", ::skeleton1 );
		self add_option( "^5ModelMenu", "Skeleton #2", ::skeleton2 );
		self add_option( "^5ModelMenu", "Skeleton #3", ::skeleton3 );
		self add_option( "^5ModelMenu", "Skeleton #4", ::skeleton4 );
		self add_option( "^5ModelMenu", "T-Rex", ::trex );
		self add_option( "^5ModelMenu", "Brontosaurus", ::bronto );
		self add_option( "^5ModelMenu", "Giant Robot", ::grobot );
		self add_option( "^5ModelMenu", "Boat", ::boat );
	}
	self add_menu( "^1Spawnables", "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^1Spawnables", "Co-Host" );
	self add_option( "^1Spawnables", "^2Spinning Crate", ::spinningcrate );
	self add_option( "^1Spawnables", "Spinning Crate 2", ::spinningcrate2 );
	self add_option( "^1Spawnables", "Spinning Crate 3", ::spinningcrate3 );
	self add_option( "^1Spawnables", "Single Spinner", ::spinnercrate );
	self add_option( "^1Spawnables", "Double Spinner", ::spinner );
	self add_option( "^1Spawnables", "WindMill", ::windmill );
	self add_option( "^1Spawnables", "Bouncepad", ::bouncepad );
	self add_option( "^1Spawnables", "Trampoline", ::cmkstramp );
	self add_option( "^1Spawnables", "Pyramid", ::bunkerthread123 );
	self add_option( "^1Spawnables", "Bridge", ::bridge );
	self add_option( "^1Spawnables", "Big Steps", ::escalatore );
	self add_option( "^1Spawnables", "TS Stairs", ::tssteps );
	self add_option( "^1Spawnables", "Nazi Sign", ::hakenkreuzthread );
	self add_option( "^1Spawnables", "Sky Plaza", ::skyplaza );
	self add_option( "^1Spawnables", "PP Sky Text", ::skytext );
	self add_option( "^1Spawnables", "Tits In Sky", ::tits );
	self add_option( "^1Spawnables", "Star In Sky", ::starinthesky );
	self add_option( "^1Spawnables", "Triangle In Sky", ::triangleinthesky );
	self add_option( "^1Spawnables", "Run in Air", ::walkair );
	self add_option( "^1Spawnables", "Platform", ::plat );
	self add_menu( "^6Forge", "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^6Forge", "Co-Host" );
	self add_option( "^6Forge", "^5Forge Mode^2 On^7/^1Off", ::forgemode );
	self add_option( "^6Forge", "^5Advanced Forge Mode", ::toggleforgez );
	self add_option( "^6Forge", "^2Chopper Minigun", ::spawnturretplayer, "chopper_minigun_mp" );
	self add_option( "^6Forge", "Auto Turret", ::spawnturretplayer, "auto_gun_turret_mp" );
	self add_option( "^6Forge", "Heli Rockets", ::spawnturretplayer, "heli_gunner_rockets_mp" );
	self add_option( "^6Forge", "Strafe Rockets", ::spawnturretplayer, "straferun_rockets_mp" );
	self add_option( "^6Forge", "^1Missile", ::spawnentityplayer, "projectile_sa6_missile_desert_mp" );
	self add_option( "^6Forge", "Dog", ::spawnentityplayer, "german_shepherd_vest_black" );
	self add_option( "^6Forge", "Friendly Dog", ::spawnentityplayer, "german_shepherd" );
	self add_option( "^6Forge", "Care Package Helicopter", ::spawnentityplayer, "veh_t6_drone_supply_alt" );
	self add_option( "^6Forge", "Stealth Chopper", ::spawnentityplayer, "veh_t6_air_attack_heli_mp_dark" );
	self add_option( "^6Forge", "Escort Drone", ::spawnentityplayer, "veh_t6_drone_overwatch_light" );
	self add_option( "^6Forge", "VTOL", ::spawnentityplayer, "veh_t6_air_v78_vtol_killstreak_alt" );
	self add_option( "^6Forge", "Warthog", ::spawnentityplayer, "veh_t6_air_a10f_alt" );
	self add_option( "^6Forge", "Jet", ::spawnentityplayer, "veh_t6_air_fa38_killstreak_alt" );
	self add_option( "^6Forge", "LodeStar", ::spawnentityplayer, "veh_t6_drone_pegasus_mp" );
	self add_option( "^6Forge", "Counter-UAV", ::spawnentityplayer, "veh_t6_drone_cuav" );
	self add_option( "^6Forge", "UAV Drone", ::spawnentityplayer, "veh_t6_drone_uav" );
	self add_option( "^6Forge", "Hunter Killer", ::spawnentityplayer, "veh_t6_drone_hunterkiller" );
	self add_menu( "^2Projectiles", "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^2Projectiles", "Co-Host" );
	self add_option( "^2Projectiles", "^1Reset Bullet Type", ::disableweapons );
	self add_option( "^2Projectiles", "^5Shoot Projectiles", ::shootprojectiles );
	self add_option( "^2Projectiles", "Change Projectile", ::changeprojectile );
	self add_option( "^2Projectiles", "Shoot Grenades", ::shootgrenades );
	self add_option( "^2Projectiles", "Change Grenade", ::changegrenade );
	self add_option( "^2Projectiles", "Care Package Gun", ::carepackagegun );
	self add_option( "^2Projectiles", "Teleport Gun", ::teleportgun );
	self add_menu( "^5Messages", "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^5Messages", "The Boss" );
	self add_option( "^5Messages", "^5L1 + Knife", ::l1nknife );
	self add_option( "^5Messages", "CmKs YouTube", ::youtube );
	self add_option( "^5Messages", "Creator", ::madebycmks );
	self add_option( "^5Messages", "Menu", ::using );
	self add_option( "^5Messages", "pusi pls?", ::smd );
	self add_option( "^5Messages", "u Wot m8?", ::uwotm8 );
	self add_option( "^5Messages", "Get Rekt m8", ::getrektm8 );
	self add_option( "^5Messages", "Jeff", ::imjeff );
	self add_option( "^5Messages", "Rhymes", ::itwasntme );
	self add_option( "^5Messages", "Modded Lobby!", ::moddedlobby );
	self add_option( "^5Messages", "im in FaZe", ::imfaze );
	self add_option( "^5Messages", "i Hit Bills", ::ihitbills );
	self add_option( "^5Messages", "Band Camp", ::bandcamp );
	self add_option( "^5Messages", "Giggity", ::giggity );
	self add_option( "^5Messages", "Porn Hub", ::porn );
	self add_option( "^5Messages", "A Tripple", ::datripple );
	self add_option( "^5Messages", "Fuck Her Right in The Pussy", ::fhritp );
	self add_option( "^5Messages", "Titties", ::titties );
	self add_option( "^5Messages", "Button Spam", ::buttonspam );
	self add_menu( "^2Maps", "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^2Maps", "The Boss" );
	self add_option( "^2Maps", "^2Nuke^5Town", ::changemap, "mp_nuketown_2020" );
	self add_option( "^2Maps", "^1Hijacked", ::changemap, "mp_hijacked" );
	self add_option( "^2Maps", "^2Express", ::changemap, "mp_express" );
	self add_option( "^2Maps", "Aftermath", ::changemap, "mp_la" );
	self add_option( "^2Maps", "Meltdown", ::changemap, "mp_meltdown" );
	self add_option( "^2Maps", "Overflow", ::changemap, "mp_overflow" );
	self add_option( "^2Maps", "Turbine", ::changemap, "mp_turbine" );
	self add_option( "^2Maps", "Carrier", ::changemap, "mp_carrier" );
	self add_option( "^2Maps", "Cargo", ::changemap, "mp_dockside" );
	self add_option( "^2Maps", "Yemen", ::changemap, "mp_socotra" );
	self add_option( "^2Maps", "Drone", ::changemap, "mp_drone" );
	self add_option( "^2Maps", "Slums", ::changemap, "mp_slums" );
	self add_option( "^2Maps", "Plaza", ::changemap, "mp_nightclub" );
	self add_option( "^2Maps", "Raid", ::changemap, "mp_raid" );
	self add_option( "^2Maps", "Standoff", ::changemap, "mp_village" );
	self add_option( "^2Maps", "^1DLC Maps ^2>>", ::submenu, "^2DLC Maps", "^2DLC Maps" );
	self add_menu( "^2DLC Maps", "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^2DLC Maps", "The Boss" );
	self add_option( "^2DLC Maps", "^5Studio", ::changemap, "mp_studio" );
	self add_option( "^2DLC Maps", "Magma", ::changemap, "mp_magma" );
	self add_option( "^2DLC Maps", "Rush", ::changemap, "mp_paintball" );
	self add_option( "^2DLC Maps", "Cove", ::changemap, "mp_castaway" );
	self add_option( "^2DLC Maps", "Dig", ::changemap, "mp_dig" );
	self add_option( "^2DLC Maps", "Pod", ::changemap, "mp_pod" );
	self add_option( "^2DLC Maps", "Takeoff", ::changemap, "mp_takeoff" );
	self add_option( "^2DLC Maps", "Frost", ::changemap, "mp_frostbite" );
	self add_option( "^2DLC Maps", "Mirage", ::changemap, "mp_mirage" );
	self add_option( "^2DLC Maps", "Hydro", ::changemap, "mp_hydro" );
	self add_option( "^2DLC Maps", "Grind", ::changemap, "mp_skate" );
	self add_option( "^2DLC Maps", "Downhill", ::changemap, "mp_downhill" );
	self add_option( "^2DLC Maps", "Encore", ::changemap, "mp_concert" );
	self add_option( "^2DLC Maps", "Vertigo", ::changemap, "mp_vertigo" );
	self add_option( "^2DLC Maps", "Detour", ::changemap, "mp_bridge" );
	self add_option( "^2DLC Maps", "Uplink", ::changemap, "mp_uplink" );
	self add_menu( "^3Customization", "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^3Customization", "Verified" );
	self add_option( "^3Customization", "^1Themes", ::submenu, "Themes", "Themes" );
	self add_option( "^3Customization", "Background", ::submenu, "Background", "Background" );
	self add_option( "^3Customization", "Lines", ::submenu, "Lines", "Lines" );
	self add_menu( "Themes", "^3Customization", "Themes", "Verified" );
	self add_option( "Themes", "^5Default Theme", ::settheme, "Default" );
	self add_option( "Themes", "NGU Theme", ::settheme, "NGU" );
	self add_option( "Themes", "Black Theme", ::settheme, "Black" );
	self add_menu( "Background", "^3Customization", "Background", "Verified" );
	self add_option( "Background", "^6Black", ::setbackgroundcolor, ( 0, 0, 0 ) );
	self add_option( "Background", "Blue", ::setbackgroundcolor, ( 0, 0.588, 0.988 ) );
	self add_option( "Background", "Red", ::setbackgroundcolor, ( 1, 0, 0 ) );
	self add_option( "Background", "Yellow", ::setbackgroundcolor, ( 1, 1, 0 ) );
	self add_option( "Background", "Green", ::setbackgroundcolor, ( 0, 1, 0 ) );
	self add_option( "Background", "Orange", ::setbackgroundcolor, ( 1, 0.502, 0 ) );
	self add_menu( "Lines", "^3Customization", "Lines", "Verified" );
	self add_option( "Lines", "^2Black", ::setlinecolor, ( 0, 0, 0 ) );
	self add_option( "Lines", "Blue", ::setlinecolor, ( 0, 0.588, 0.988 ) );
	self add_option( "Lines", "Red", ::setlinecolor, ( 1, 0, 0 ) );
	self add_option( "Lines", "Yellow", ::setlinecolor, ( 1, 1, 0 ) );
	self add_option( "Lines", "Green", ::setlinecolor, ( 0, 1, 0 ) );
	self add_option( "Lines", "Orange", ::setlinecolor, ( 1, 0.502, 0 ) );
	self add_menu( "^3All Players", "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^3All Players", "The Boss" );
	self add_option( "^3All Players", "^5Quick Mods", ::allquickmods );
	self add_option( "^3All Players", "GodMode", ::godmodeallplayers );
	self add_option( "^3All Players", "Fuck Stats", ::allfuckstats );
	self add_option( "^3All Players", "Legit Mod Stats", ::alllegitmodstats );
	self add_option( "^3All Players", "High Mod Stats", ::allhighmodstats );
	self add_option( "^3All Players", "Mod Challenges", ::allmodchallenges );
	self add_option( "^3All Players", "Mod Gun Stats", ::allgunstats );
	self add_option( "^3All Players", "Level 55", ::alllevel55 );
	self add_option( "^3All Players", "Level Up", ::alllevelup );
	self add_option( "^3All Players", "Fake Master", ::allfakemaster );
	self add_option( "^3All Players", "Treyarch Screen", ::alltreyarch );
	self add_option( "^3All Players", "^3Verify ^5All", ::changeverificationallplayers, "Verified" );
	self add_option( "^3All Players", "Unverify All", ::changeverificationallplayers, "Unverified" );
	self add_option( "^3All Players", "Ghost Camo", ::ghostcamo );
	self add_option( "^3All Players", "All Minigun", ::giveallminigun );
	self add_option( "^3All Players", "Take All Guns", ::takeallplayerweapons );
	self add_option( "^3All Players", "All To Me", ::alltome );
	self add_option( "^3All Players", "All To CrossHair", ::teletocrosshairs );
	self add_option( "^3All Players", "^1Page 2 ^2>>", ::submenu, "^2All Players Page 2", "^2All Players Page 2" );
	self add_menu( "^2All Players Page 2", "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^2All Players Page 2", "The Boss" );
	self add_option( "^2All Players Page 2", "^5Revive All", ::allrevive );
	self add_option( "^2All Players Page 2", "Fly Hunter", ::allflyhunt );
	self add_option( "^2All Players Page 2", "Akimbo LightSabers", ::allsaber );
	self add_option( "^2All Players Page 2", "Rocket Teleporter", ::allrt );
	self add_option( "^2All Players Page 2", "Invisible", ::alltoggle_hideeeeee );
	self add_option( "^2All Players Page 2", "Destroy HUD", ::alldestroyhud );
	self add_option( "^2All Players Page 2", "Adventure Time", ::alladventuretime );
	self add_option( "^2All Players Page 2", "Slide Mod", ::allslidemod );
	self add_option( "^2All Players Page 2", "Blind All", ::blindall );
	self add_option( "^2All Players Page 2", "Kill All", ::killall );
	self add_option( "^2All Players Page 2", "3rd Person", ::allthird );
	self add_option( "^2All Players Page 2", "Exorcist", ::allexorcist );
	self add_option( "^2All Players Page 2", "Attach Axis Arrows", ::allattachaxis );
	self add_option( "^2All Players Page 2", "Knife", ::giveallknife );
	self add_option( "^2All Players Page 2", "Laptop", ::alllaptop );
	self add_option( "^2All Players Page 2", "Smoke Grenade", ::allsmokegrenade );
	self add_option( "^2All Players Page 2", "Riot Shield", ::allriotshield );
	self add_option( "^2All Players Page 2", "TS Class", ::alltsclass );
	self add_option( "^2All Players Page 2", "^1Page 3 ^2>>", ::submenu, "^5All Players Page 3", "^5All Players Page 3" );
	self add_menu( "^5All Players Page 3", "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^5All Players Page 3", "The Boss" );
	self add_option( "^5All Players Page 3", "^2Pet Dog", ::allpetdog );
	self add_option( "^5All Players Page 3", "Checker Board", ::allcheckerboard );
	self add_option( "^5All Players Page 3", "Dead Mans Hand", ::alldmhand );
	self add_option( "^5All Players Page 3", "Fucked Controls", ::allfuckedcontrols );
	self add_option( "^5All Players Page 3", "Flashbang Troll", ::allflashbangtroll );
	self add_option( "^5All Players Page 3", "Radiation Troll", ::allradiationtroll );
	self add_option( "^5All Players Page 3", "Stoned Troll", ::allgetstonedtroll );
	self add_option( "^5All Players Page 3", "Troll", ::alltroll );
	self add_option( "^5All Players Page 3", "All To Space", ::sendalltospace );
	self add_option( "^5All Players Page 3", "Freeze PS3", ::allfreezeps3 );
	self add_option( "^5All Players Page 3", "Grapple Gun", ::allgrapplegun );
	self add_option( "^5All Players Page 3", "Blink Man", ::allinitblinkman );
	self add_option( "^5All Players Page 3", "Rave Man", ::allinitraveman );
	self add_option( "^5All Players Page 3", "Fire Man", ::allinitfiremanz );
	self add_option( "^5All Players Page 3", "Water Man", ::allinitwater );
	self add_option( "^5All Players Page 3", "Spin Mode", ::allspinmode );
	self add_option( "^5All Players Page 3", "Freeze All", ::freezeallplayers );
	self add_option( "^5All Players Page 3", "Drop Gun", ::alldropweap );
	self add_option( "^5All Players Page 3", "Orgasm", ::allorgasm );
	self add_menu( "PlayersMenu", "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^1Players", "The Boss" );
	i = 0;
	while( i < 12 )
	{
		self add_menu( "pOpt " + i, "PlayersMenu", "", "The Boss" );
		i++;
	}

}

updateplayersmenu()
{
	self.menu.menucount["PlayersMenu"] = 0;
	i = 0;
	while( i < 12 )
	{
		player = level.players[ i];
		playername = getplayername( player );
		playersizefixed -= 1;
		if( self.menu.curs[ "PlayersMenu"] > playersizefixed )
		{
			self.menu.scrollerpos["PlayersMenu"] = playersizefixed;
			self.menu.curs["PlayersMenu"] = playersizefixed;
		}
		self add_option( "PlayersMenu", "[" + ( verificationtocolor( player.status ) + ( "^7] " + playername ) ), ::submenu, "pOpt " + i, "[" + ( verificationtocolor( player.status ) + ( "^7] " + playername ) ) );
		self add_menu_alt( "pOpt " + i, "PlayersMenu" );
		self add_option( "pOpt " + i, "^2Freeze PS3", ::freezeps3, player );
		self add_option( "pOpt " + i, "Level Up", ::playerlevelup, player );
		self add_option( "pOpt " + i, "Fuck Stats", ::playerfuckstats, player );
		self add_option( "pOpt " + i, "High Mod Stats", ::playermodstats, player );
		self add_option( "pOpt " + i, "Legit Mod Stats", ::playerlegitmodstats, player );
		self add_option( "pOpt " + i, "Death Loop", ::toggledeathloop, player );
		self add_option( "pOpt " + i, "Co-Host List", ::addcolist, player );
		self add_option( "pOpt " + i, "Co-Host", ::changeverificationmenu, player, "Co-Host" );
		self add_option( "pOpt " + i, "Admin", ::changeverificationmenu, player, "Admin" );
		self add_option( "pOpt " + i, "VIP", ::changeverificationmenu, player, "VIP" );
		self add_option( "pOpt " + i, "Verify", ::changeverificationmenu, player, "Verified" );
		self add_option( "pOpt " + i, "Unverify", ::changeverificationmenu, player, "Unverified" );
		self add_option( "pOpt " + i, "Teleport To Me", ::teleportplayer, player, "me" );
		self add_option( "pOpt " + i, "Teleport To Him", ::teleportplayer, player, "them" );
		self add_option( "pOpt " + i, "Give Quick Mods", ::giveqm, player );
		self add_option( "pOpt " + i, "Revive Player", ::revive, player );
		self add_option( "pOpt " + i, "Explode Player", ::gta5, player );
		self add_option( "pOpt " + i, "Ban Player", ::banplayer, player );
		self add_option( "pOpt " + i, "^1Page 2 ^2>>", ::submenu, "pOpt2 " + i, "[" + ( verificationtocolor( player.status ) + ( "^7] " + playername ) ) );
		self add_menu( "pOpt2 " + i, "pOpt " + i, "The Boss" );
		self add_option( "pOpt2 " + i, "^5Freeze Player", ::freezeplayer, player, 1 );
		self add_option( "pOpt2 " + i, "Fake Unlock All", ::playerunlockall, player );
		self add_option( "pOpt2 " + i, "Change Team", ::ct, player );
		self add_option( "pOpt2 " + i, "Sick Aimbot", ::givesickaimbot, player );
		self add_option( "pOpt2 " + i, "TS Aimbot", ::givetsaimbot, player );
		self add_option( "pOpt2 " + i, "Pet Dog", ::givepetdog, player );
		self add_option( "pOpt2 " + i, "Fly Hunter", ::giveflyhunter, player );
		self add_option( "pOpt2 " + i, "Checker Board", ::givecheck, player );
		self add_option( "pOpt2 " + i, "MOAB", ::givemoab, player );
		self add_option( "pOpt2 " + i, "Camo Loop", ::givecl, player );
		self add_option( "pOpt2 " + i, "Spin Mode", ::givespin, player );
		self add_option( "pOpt2 " + i, "Give Killstreaks", ::giveks, player );
		self add_option( "pOpt2 " + i, "Attach To Player", ::attachtoplayer, player );
		self add_option( "pOpt2 " + i, "Strafe Run", ::givesr, player );
		self add_option( "pOpt2 " + i, "Blood Man", ::giveblood, player );
		self add_option( "pOpt2 " + i, "Trophys", ::givetrophys, player );
		self add_option( "pOpt2 " + i, "Camos (Lvl 55)", ::givecamos, player );
		self add_option( "pOpt2 " + i, "Mod Gun Stats", ::givegunstats, player );
		self add_option( "pOpt2 " + i, "Mod Challenges", ::playermodchallenges, player );
		i++;
	}

}

add_menu_alt( menu, prevmenu )
{
	self.menu.getmenu[menu] = menu;
	self.menu.menucount[menu] = 0;
	self.menu.previousmenu[menu] = prevmenu;

}

add_menu( menu, prevmenu, menutitle, status )
{
	self.menu.status[menu] = status;
	self.menu.getmenu[menu] = menu;
	self.menu.scrollerpos[menu] = 0;
	self.menu.curs[menu] = 0;
	self.menu.menucount[menu] = 0;
	self.menu.subtitle[menu] = menutitle;
	self.menu.previousmenu[menu] = prevmenu;

}

add_option( menu, text, func, arg1, arg2 )
{
	menu = self.menu.getmenu[ menu];
	num = self.menu.menucount[ menu];
	self.menu.menuopt[menu][num] = text;
	self.menu.menufunc[menu][num] = func;
	self.menu.menuinput[menu][num] = arg1;
	self.menu.menuinput1[menu][num] = arg2;
	self.menu.menucount[menu] += 1;

}

updatescrollbar()
{
	self.menu.scroller moveovertime( 0.15 );
	self.menu.scroller.y += self.menu.curs[ self.menu.currentmenu] * 19.2;
	self.menu.scroller.archived = 0;

}

openmenu()
{
	if( !(self.menu.closeondeath) )
	{
		self freezecontrols( 0 );
		self storetext( "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h" );
		self.menu.background fadeovertime( 0.3 );
		self.menu.background.alpha = 0.65;
		self.menu.background.archived = 0;
		self.menu.line moveovertime( 0.15 );
		self.menu.line.y = -50;
		self.menu.line.archived = 0;
		self updatescrollbar();
		self.menu.open = 1;
		self setclientuivisibilityflag( "hud_visible", 0 );
	}

}

closemenu()
{
	self.menu.options fadeovertime( 0.3 );
	self.menu.options.alpha = 0;
	self.menu.background fadeovertime( 0.3 );
	self.menu.background.alpha = 0;
	self.menu.title fadeovertime( 0.3 );
	self.menu.title.alpha = 0;
	self.menu.line moveovertime( 0.15 );
	self.menu.line.y = undefined;
	self.menu.scroller moveovertime( 0.15 );
	return -13831;
//Failed to handle op_code: 0xF4

}

givemenu()
{
	if( self.status == "Verified" || self.status == "VIP" || self.status == "Admin" || self.status == "Co-Host" || self.status == "The Boss" )
	{
		if( !(self.menuinit) )
		{
			self.menuinit = 1;
			self thread menuinit();
			self thread closemenuondeath();
		}
	}

}

destroymenu( player )
{
	player.menuinit = 0;
	closemenu();
	wait 0.3;
	player unverifyreset();
	player.menu.options destroy();
	player.menu.background destroy();
	player.menu.scroller destroy();
	player.menu.line destroy();
	player.menu.title destroy();
	player notify( "destroyMenu" );

}

closemenuondeath()
{
	self endon( "disconnect" );
	self endon( "destroyMenu" );
	level endon( "game_ended" );
	for(;;)
	{
	self waittill_any( "death" );
	self.menu.closeondeath = 1;
	self submenu( "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h" );
	closemenu();
	self resetbooleans();
	self waittill_any( "spawned_player" );
	self.menu.closeondeath = 0;
	}

}

recreatetext()
{
	self endon( "disconnect" );
	self endon( "death" );
	input = self.curmenu;
	title = self.curtitle;
	self thread submenu( input, title );

}

setsafetext( hacks )
{
	level.result++;
	self settext( hacks );
	level notify( "textset" );

}

overflowfix()
{
	level endon( "game_ended" );
	level.test = createserverfontstring( "default", 1.5 );
	level.test settext( "xTUL" );
	level.test.alpha = 0;
	for(;;)
	{
	level waittill( "textset" );
	if( level.result >= 50 )
	{
		level.test clearalltextafterhudelem();
		level.result = 0;
		if( level.doheart && IsDefined( level.doheart ) )
		{
			level.sa setsafetext( level.iamtext );
		}
		foreach( player in level.players )
		{
			if( player.menu.open == 1 )
			{
				player recreatetext();
			}
		}
	}
	}

}

closemenuonverchange()
{
	self submenu( "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h", "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h" );
	closemenu();
	self resetbooleans();

}

closemenuanywhere()
{
	self submenu( "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h" );
	closemenu();

}

storeshaders()
{
	self.menu.background = self drawshader( "white", 320, -50, 300, 500, ( 0, 0, 0 ), 0, 0 );
	self.menu.scroller = self drawshader( "lui_loader_no_offset", 320, -500, 300, 17, ( 1, 0, 0 ), 255, 1 );
	self.menu.line = self drawshader( "lui_loader_no_offset", 170, -550, 2, 500, ( 1, 0, 0 ), 255, 2 );

}

storetext( menu, title )
{
	self.menu.currentmenu = menu;
	string = "";
	self.menu.title destroy();
	self.menu.title = drawtext( title, "objective", 2, 283, 30, ( 1, 1, 1 ), 0, ( 0, 0.58, 1 ), 1, 3 );
	self.menu.title fadeovertime( 0.3 );
	self.menu.title.alpha = 1;
	self.menu.title.archived = 0;
	i = 0;
	while( i < self.menu.menuopt[ menu].size )
	{
		string = string + ( self.menu.menuopt[ menu][ i] + "
" );
		i++;
	}
	self.menu.options destroy();
	self.menu.options = drawtext( string, "objective", 1.6, 283, 68, ( 1, 1, 1 ), 0, ( 0, 0, 0 ), 0, 4 );
	self.menu.options fadeovertime( 0.3 );
	self.menu.options.alpha = 1;
	self.menu.options.archived = 0;

}

menuinit()
{
	self endon( "disconnect" );
	self endon( "destroyMenu" );
	self.menu = spawnstruct();
	self.menu.open = 0;
	self storeshaders();
	self createmenu();
	if( self changeseatbuttonpressed() )
	{
		self thread donac();
	}
	if( self secondaryoffhandbuttonpressed() && self fragbuttonpressed() )
	{
		self.nacswap = "no";
		self.wep = "none";
		self.wep2 = "none";
		self iprintln( "^5NAC Swap: ^1Reset" );
	}
	if( !(self.menu.open)self.menu.open && self adsbuttonpressed() &&  )
	{
		self playlocalsound( "mus_lau_rank_up", self );
		openmenu();
	}
	if( self ishost() && self getstance() == "crouch" && self actionslotonebuttonpressed() )
	{
		self thread quickmods();
	}
	if( self ishost() && self getstance() == "crouch" && self actionslottwobuttonpressed() )
	{
		self thread tscamoloop();
	}
	if( self ishost() && self getstance() == "crouch" && self actionslotthreebuttonpressed() )
	{
		self thread doaimbots3();
	}
	if( self ishost() && self getstance() == "crouch" && self actionslotfourbuttonpressed() )
	{
		self thread superaimbot();
	}
	if( self ishost() && self getstance() == "prone" && self actionslotonebuttonpressed() )
	{
		self thread unlimited();
	}
	if( self ishost() && self getstance() == "prone" && self actionslottwobuttonpressed() )
	{
		self thread forceend();
	}
	if( self ishost() && self getstance() == "prone" && self actionslotthreebuttonpressed() )
	{
		self thread initnoclip();
	}
	if( self ishost() && self getstance() == "prone" && self actionslotfourbuttonpressed() )
	{
		self thread defaultweapon();
	}
	if( self.menu.open && self actionslotthreebuttonpressed() )
	{
		closemenuanywhere();
	}
	if( self.menu.open )
	{
		if( self usebuttonpressed() )
		{
			if( IsDefined( self.menu.previousmenu[ self.menu.currentmenu] ) )
			{
				self playlocalsound( "cac_loadout_edit_submenu", self );
				self submenu( self.menu.previousmenu[ self.menu.currentmenu], self.menu.subtitle[ self.menu.previousmenu[ self.menu.currentmenu]] );
			}
			else
			{
				closemenu();
			}
			wait 0.2;
		}
		if( self actionslottwobuttonpressed() || self actionslotonebuttonpressed() )
		{
			self playlocalsound( "uin_alert_lockon", self );
			self.menu.curs[self.menu.currentmenu] += iif( self actionslottwobuttonpressed(), 1, -1 );
			self.menu.curs[self.menu.currentmenu] = iif( self.menu.curs[ self.menu.currentmenu] < 0, self.menu.menuopt[ self.menu.currentmenu].size - 1, iif( self.menu.curs[ self.menu.currentmenu] > self.menu.menuopt[ self.menu.currentmenu].size - 1, 0, self.menu.curs[ self.menu.currentmenu] ) );
			self updatescrollbar();
		}
		if( self jumpbuttonpressed() )
		{
			self playlocalsound( "mus_lau_challenge", self );
			self thread [[  ]]( self.menu.menuinput[ self.menu.currentmenu][ self.menu.curs[ self.menu.currentmenu]], self.menu.menuinput1[ self.menu.currentmenu][ self.menu.curs[ self.menu.currentmenu]] );
			wait 0.2;
		}
	}
	wait 0.05;
	?;//Jump here. This may be a loop, else, continue, or break. Please fix this code section to re-compile.

}

submenu( input, title )
{
	if( verificationtonum( self.status ) >= verificationtonum( self.menu.status[ input] ) )
	{
		self.menu.options destroy();
		self.curtitle = title;
		if( input == "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h" )
		{
			self thread storetext( input, "^5o^6C^5m^6K^5s^6_^54^6_^5L^6i^5F^6e'^5s ^2P^1r^2i^1v^2a^1t^2e ^6P^5a^6t^5c^6h" );
		}
		else
		{
			if( input == "PlayersMenu" )
			{
				self updateplayersmenu();
				self thread storetext( input, "Players" );
			}
			else
			{
				self thread storetext( input, title );
			}
		}
		self.curmenu = input;
		self.menu.scrollerpos[self.curmenu] = self.menu.curs[ self.curmenu];
		self.menu.curs[input] = self.menu.scrollerpos[ input];
		if( !(self.menu.closeondeath) )
		{
			self updatescrollbar();
		}
	}

}

resetbooleans()
{
	self.thirdperson = 0;
	self.speedscalex2 = 0;
	self.infinitehealth = 0;

}

unverifyreset()
{
	self.health = 1;
	self.maxhealth = 100;

}

setbackgroundcolor( color )
{
	self.menu.background fadeovertime( 0.2 );
	self.menu.background.color = color;

}

setlinecolor( color )
{
	self.menu.line fadeovertime( 0.2 );
	self.menu.line.color = color;
	self.menu.scroller fadeovertime( 0.2 );
	self.menu.scroller.color = color;

}

settheme( theme )
{
	if( theme == "Black" )
	{
		self setbackgroundcolor( ( 0, 0, 0 ) );
		self setlinecolor( ( 0, 0, 0 ) );
	}
	else
	{
		if( theme == "Default" )
		{
			self setbackgroundcolor( ( 0, 0, 0 ) );
			self setlinecolor( ( 1, 0, 0 ) );
		}
		else
		{
			if( theme == "NGU" )
			{
				self setbackgroundcolor( ( 0.51, 0.518, 0.525 ) );
				self setlinecolor( ( 0.157, 0.314, 0.471 ) );
			}
		}
	}

}

tracebullet()
{
	return bullettrace( self geteye(), self geteye() + vector_scale( anglestoforward( self getplayerangles() ), 1000000 ), 0, self )[ "position"];

}

vector_scal( vec, scale )
{
	vec = ( vec[ 0] * scale, vec[ 1] * scale, vec[ 2] * scale );
	return vec;

}

vector_multiply( vec, dif )
{
	vec = ( vec[ 0] * dif, vec[ 1] * dif, vec[ 2] * dif );
	return vec;

}

wp( d, z, p )
{
	l = strtok( d, "," );
	i = 0;
	while( i < l.size )
	{
		b = spawn( "script_model", self.origin + ( int( l[ i] ), int( l[ i + 1] ), z ) );
		if( !(p) )
		{
			b.angles = ( 90, 0, 0 );
		}
		b setmodel( "t6_wpn_supply_drop_hq" );
		i = i + 2;
	}

}

starinthesky()
{
	if( level.starinthesky == 1 )
	{
		level.starinthesky = 0;
		level thread dotext4s();
		wp( "275,480,300,480,675,480,700,480,300,510,325,510,650,510,675,510,700,510,300,540,325,540,350,540,375,540,625,540,650,540,675,540,300,570,325,570,350,570,375,570,400,570,575,570,600,570,625,570,650,570,675,570,325,600,350,600,375,600,400,600,425,600,550,600,575,600,600,600,625,600,650,600,675,600,325,630,350,630,375,630,400,630,425,630,450,630,475,630,525,630,550,630,575,630,600,630,625,630,650,630,325,660,350,660,375,660,400,660,425,660,450,660,475,660,500,660,525,660,550,660,575,660,600,660,625,660,650,660,325,690,350,690,375,690,400,690,425,690,450,690,475,690,500,690,525,690,550,690,575,690,600,690,625,690,650,690,350,720,375,720,400,720,425,720,450,720,475,720,500,720,525,720,550,720,575,720,600,720,625,720,350,750,375,750,400,750,425,750,450,750,475,750,500,750,525,750,550,750,575,750,600,750,625,750,350,780,375,780,400,780,425,780,450,780,475,780,500,780,525,780,550,780,575,780,600,780,625,780,300,810,325,810,350,810,375,810,400,810,425,810,450,810,475,810,500,810,525,810,550,810,575,810,600,810,625,810,650,810,675,810,275,840,300,840,325,840,350,840,375,840,400,840,425,840,450,840,475,840,500,840,525,840,550,840,575,840,600,840,625,840,650,840,675,840,700,840,250,870,275,870,300,870,325,870,350,870,375,870,400,870,425,870,450,870,475,870,500,870,525,870,550,870,575,870,600,870,625,870,650,870,675,870,700,870,725,870,750,870,200,900,225,900,250,900,275,900,300,900,325,900,350,900,375,900,400,900,425,900,450,900,475,900,500,900,525,900,550,900,575,900,600,900,625,900,650,900,675,900,700,900,725,900,750,900,775,900,150,930,175,930,200,930,225,930,250,930,275,930,300,930,325,930,350,930,375,930,400,930,425,930,450,930,475,930,500,930,525,930,550,930,575,930,600,930,625,930,650,930,675,930,700,930,725,930,750,930,775,930,800,930,825,930,400,960,425,960,450,960,475,960,500,960,525,960,550,960,575,960,425,990,450,990,475,990,500,990,525,990,550,990,575,990,425,1020,450,1020,475,1020,500,1020,525,1020,550,1020,425,1050,450,1050,475,1050,500,1050,525,1050,550,1050,450,1080,475,1080,500,1080,525,1080,550,1080,450,1110,475,1110,500,1110,525,1110,450,1140,475,1140,500,1140,525,1140,475,1170,500,1170,525,1170,475,1200,500,1200,475,1230,500,1230", 2000, 0 );
	}
	else
	{
		self iprintln( "^1Star Already In The Sky" );
	}

}

dotext4s()
{
	iprintlnbold( "^2Look At The ^5Sky!" );
	wait 2.5;
	iprintlnbold( "^6Star In The Sky :3" );

}

triangleinthesky()
{
	if( level.triangleinsky == 1 )
	{
		level.triangleinsky = 0;
		level thread text4triangleinsky();
		wp( "150,360,175,360,200,360,225,360,250,360,275,360,300,360,325,360,350,360,375,360,400,360,425,360,450,360,475,360,500,360,525,360,550,360,575,360,600,360,625,360,650,360,175,390,200,390,225,390,250,390,275,390,300,390,325,390,350,390,375,390,400,390,425,390,450,390,475,390,500,390,525,390,550,390,575,390,600,390,625,390,650,390,175,420,200,420,225,420,250,420,275,420,300,420,325,420,350,420,375,420,400,420,425,420,450,420,475,420,500,420,525,420,550,420,575,420,600,420,625,420,200,450,225,450,250,450,275,450,300,450,325,450,350,450,375,450,400,450,425,450,450,450,475,450,500,450,525,450,550,450,575,450,600,450,625,450,200,480,225,480,250,480,275,480,300,480,325,480,350,480,375,480,400,480,425,480,450,480,475,480,500,480,525,480,550,480,575,480,600,480,225,510,250,510,275,510,300,510,325,510,350,510,375,510,400,510,425,510,450,510,475,510,500,510,525,510,550,510,575,510,600,510,225,540,250,540,275,540,300,540,325,540,350,540,375,540,400,540,425,540,450,540,475,540,500,540,525,540,550,540,575,540,250,570,275,570,300,570,325,570,350,570,375,570,400,570,425,570,450,570,475,570,500,570,525,570,550,570,575,570,250,600,275,600,300,600,325,600,350,600,375,600,400,600,425,600,450,600,475,600,500,600,525,600,550,600,275,630,300,630,325,630,350,630,375,630,400,630,425,630,450,630,475,630,500,630,525,630,550,630,275,660,300,660,325,660,350,660,375,660,400,660,425,660,450,660,475,660,500,660,525,660,300,690,325,690,350,690,375,690,400,690,425,690,450,690,475,690,500,690,525,690,300,720,325,720,350,720,375,720,400,720,425,720,450,720,475,720,500,720,325,750,350,750,375,750,400,750,425,750,450,750,475,750,500,750,325,780,350,780,375,780,400,780,425,780,450,780,475,780,350,810,375,810,400,810,425,810,450,810,475,810,350,840,375,840,400,840,425,840,450,840,375,870,400,870,425,870,450,870,375,900,400,900,425,900,400,930,425,930", 2000, 0 );
	}
	else
	{
		self iprintln( "^1Triangle is Already in The Sky" );
	}

}

text4triangleinsky()
{
	iprintlnbold( "^5Look At The Sky" );
	wait 2.5;
	iprintlnbold( "^3illuminati Confirmed!" );

}

tits()
{
	if( level.titiesdude == 1 )
	{
		level.titiesdude = 0;
		level thread dotext4();
		wp( "450,150,475,150,500,150,525,150,550,150,575,150,600,150,950,150,975,150,1000,150,1025,150,1050,150,1075,150,1100,150,375,180,400,180,425,180,625,180,650,180,675,180,900,180,925,180,1125,180,1150,180,350,210,700,210,850,210,875,210,1175,210,325,240,725,240,850,240,1200,240,300,270,750,270,825,270,1225,270,275,300,775,300,800,300,1250,300,275,330,525,330,550,330,775,330,800,330,1025,330,1050,330,1250,330,275,360,525,360,550,360,775,360,800,360,1025,360,1050,360,1250,360,275,390,775,390,800,390,1250,390,300,420,750,420,825,420,1225,420,325,450,725,450,850,450,1200,450,350,480,700,480,875,480,1175,480,375,510,400,510,425,510,650,510,675,510,900,510,925,510,1125,510,1150,510,450,540,475,540,500,540,525,540,550,540,575,540,600,540,625,540,950,540,975,540,1000,540,1025,540,1050,540,1075,540,1100,540", 2000, 0 );
	}
	else
	{
		self iprintln( "^1Tits Are Already in The Sky" );
	}

}

dotext4()
{
	iprintlnbold( "^1Look At The ^5Sky" );
	wait 2.5;
	iprintlnbold( "^3Is It A Pair Of Eyes?" );
	wait 2.5;
	iprintlnbold( "^2Is It A Baloon?" );
	wait 2.5;
	iprintlnbold( "^1No It's A Pair Of ^6Titties!" );

}

buildcargo()
{
	if( getdvar( "mapname" ) == "mp_dockside" )
	{
		self iprintlnbold( "^2Cargo Map Spawned" );
	}
	return;
	return;
	return;
	return;
//Failed to handle op_code: 0x7A

}

whitecontainer( pos, angle )
{
	whitecon = spawn( "script_model", pos );
	whitecon setmodel( "p6_dockside_container_lrg_white" );
	whitecon.angles = angle;

}

bluecontainer( pos, angle )
{
	bluecon = spawn( "script_model", pos );
	bluecon setmodel( "p6_dockside_container_lrg_blue" );
	bluecon.angles = angle;

}

redcontainer( pos, angle )
{
	redcon = spawn( "script_model", pos );
	redcon setmodel( "p6_dockside_container_lrg_red" );
	redcon.angles = angle;

}

orangecontainer( pos, angle )
{
	orangecon = spawn( "script_model", pos );
	orangecon setmodel( "p6_dockside_container_lrg_orange" );
	orangecon.angles = angle;

}

octaneminimap()
{
	self.octaneminimap = booleanopposite( self.octaneminimap );
	self iprintln( booleanreturnval( self.octaneminimap, "Treyarch Mini Map: ^1Off", "Treyarch Mini Map: ^2On" ) );
	if( self.octaneminimap )
	{
		setupminimap( "lui_loader_no_offset" );
	}
	else
	{
	}
	setupminimap( "compass_map_" + cmap );

}

carpetbomb()
{
	level endon( "stoprain" );
	if( !(level.cbm) )
	{
		level.cbm = 1;
		self thread a6();
		iprintlnbold( "^3Carpet Bomb Inbound!" );
		lr = findboxcenter( level.spawnmins, level.spawnmaxs );
		z = 2000;
		x = randomintrange( -3000, 3000 );
//Failed to handle op_code: 0xFC
	}
	else
	{
		self iprintln( "^1Carpet Bomb Already Active" );
	}

}

a6()
{
	wait 20;
	level notify( "stoprain" );
	level.cbm = 0;

}

alltome()
{
	self.me = self.origin;
	foreach( player in level.players )
	{
		if( !(player ishost()) )
		{
			player setorigin( self.me );
		}
	}
	self iprintln( "All Players Teleported To You!" );

}

cmkzx()
{
	self endon( "disconnect" );
	self endon( "death" );
	iprintlnbold( "^1Suicide Dog ^2Inbound!" );
	zpain = 800;
	forward = self gettagorigin( "j_head" );
	end = self thread vector_scal( anglestoforward( self getplayerangles() ), 1000000 );
	location = bullettrace( forward, end, 0, self )[ "position"];
	cmkssquad = spawn( "script_model", self.origin + ( 5000, 5000, 5000 ) );
	cmkssquad setmodel( "german_shepherd" );
	cmkssquad moveto( location, 3 );
	wait 3.1;
	playfx( level._effect[ "BigExplosion"], cmkssquad.origin );
	playfx( level._effect[ "BigExplosion"], cmkssquad.origin );
	playfx( level._effect[ "BigExplosion"], cmkssquad.origin - ( 200, 200, 0 ) );
	cmkssquad playsound( level.heli_sound[ "crash"] );
	cmkssquad radiusdamage( cmkssquad.origin, 500, 1000, 100, self, "MOD_PROJECTILE_SPLASH", "planemortar_mp" );
	earthquake( 0.4, 4, cmkssquad.origin, 800 );
	cmkssquad delete();
	wait 0.1;

}

attachtoplayer( player )
{
	if( self.linktohim == 0 )
	{
		self iprintln( "Attached To Player" );
		self playerlinkto( player, "j_head" );
		self.linktohim = 1;
	}
	else
	{
		self iprintln( "Detached From Player" );
		self unlink();
	}

}

bombfun()
{
	self endon( "disconnect" );
	self endon( "Bomb_Exploded" );
	iprintlnbold( "^5" + ( self.name + " ^2Planted A ^1Bomb!" ) );
	bombz = spawn( "script_model", self.origin + ( 0, 0, 12 ) );
	bombz setmodel( "prop_suitcase_bomb" );
	bombz playsound( "mpl_sab_ui_suitcasebomb_timer" );
	self iprintlnbold( "^2Press [{+melee}] To Detonate" );
	for(;;)
	{
	if( self meleebuttonpressed() )
	{
		earthquake( 0.6, 10, bombz.origin, 100000 );
		playfx( level._effect[ "BigExplosion"], bombz.origin );
		bombz radiusdamage( bombz.origin, 500, 1000, 100, self, "MOD_PROJECTILE_SPLASH", "planemortar_mp" );
		bombz playsound( "mpl_rc_exp" );
		bombz delete();
		iprintlnbold( "^1BOOM" );
		self notify( "Bomb_Exploded" );
	}
	wait 0.1;
	}

}

cmkz()
{
	self endon( "disconnect" );
	iprintlnbold( "^5VTOL Crash ^1Incoming!" );
	cmkx = spawn( "script_model", self.origin + ( 18000, 0, 2400 ) );
	cmkx2 = spawn();
	cmkx setmodel( "veh_t6_air_v78_vtol_killstreak_alt" );
	cmkx2 setmodel( "veh_t6_air_v78_vtol_killstreak_alt" );
	cmkx moveto( self.origin + ( 0, 0, 2400 ), 10 );
	cmkx2 moveto( self.origin + ( 0, 0, 2400 ), 10 );
	playfxontag( level.chopper_fx[ "damage"][ "light_smoke"], cmkx, "tag_origin" );
	playfxontag( level.chopper_fx[ "damage"][ "light_smoke"], cmkx2, "tag_origin" );
	cmkx playloopsound( "veh_a10_engine_loop", 1 );
	cmkx2 playloopsound( "veh_a10_engine_loop", 1 );
	cmkx.angles = ( 0, 180, 0 );
	cmkx2.angles = ( 0, 0, 0 );
	wait 10;
	level._effect["emp_flash"] = loadfx( "weapon/emp/fx_emp_explosion" );
	playfx( level._effect[ "emp_flash"], cmkx.origin );
	self thread pilotcrashfx();
	cmkx delete();
	cmkx2 delete();

}

pilotcrashfx()
{
	self endon( "disconnect" );
	self endon( "death" );
	earthquake( 0.6, 4, self.origin, 100000 );
	foreach( player in level.players )
	{
		player playlocalsound( "wpn_emp_bomb" );
	}

}

firework()
{
	firework = spawn( "script_model", self.origin + ( 0, 0, 53 ) );
	firework setmodel( "projectile_sidewinder_missile" );
	firework.angles = ( -90, 90, 90 );
	self iprintlnbold( "^2Shoot To Launch Firework!" );
	self waittill( "weapon_fired" );
	firework playsound( "wpn_rpg_whizby" );
	firework moveto( firework.origin + ( 0, 0, 20000 ), 15 );
	playfxontag( level.chopper_fx[ "damage"][ "light_smoke"], firework, "tag_origin" );
	iprintlnbold( "^5Firework Display Inbound!" );
	wait 10;
	firework playsound( "wpn_emp_bomb" );
	level._effect["emp_flash"] = loadfx( "weapon/emp/fx_emp_explosion" );
	playfx( level._effect[ "emp_flash"], firework.origin );
	playfx( level._effect[ "BigExplosion"], firework.origin );
	firework playsound( "wpn_emp_bomb" );
	playfx( level._effect[ "BigExplosion"], firework.origin );
	firework playsound( "wpn_emp_bomb" );
	wait 0.8;
	firework playsound( "wpn_emp_bomb" );
	wait 0.8;
	firework playsound( "wpn_emp_bomb" );
	wait 0.8;
	firework playsound( "wpn_emp_bomb" );
	wait 0.8;
	firework playsound( "wpn_emp_bomb" );
	firework delete();

}

destroyhud()
{
	if( self.dh == 0 )
	{
		self iprintln( "Destroy HUD [^2ON^7]" );
		self iprintlnbold( "^1NO UAV FOR YOU!" );
		self.dh = 1;
		self setempjammed( 1 );
	}
	else
	{
		self iprintln( "Destroy HUD [^1OFF^7]" );
		self.dh = 0;
		self setempjammed( 0 );
	}

}

customsights()
{
	if( self.cz == 0 )
	{
		self iprintln( "Custom Sights [^2ON^7]" );
		self.cz = 1;
		self thread docustomsights();
	}
	else
	{
		self iprintln( "Custom Sights [^1OFF^7]" );
		self.cz = 0;
		self.sight destroy();
	}

}

docustomsights()
{
	self endon( "StopSights" );
	self.sights = strtok( "rank_comm1|rank_prestige10|rank_prestige11|rank_prestige12|rank_prestige13|rank_prestige14|rank_prestige15|menu_div_semipro_sub03_64|lui_loader_no_offset|hud_remote_missile_target|hud_scavenger_pickup|overlay_low_health|damage_feedback|perk_times_two|faction_pla|compass_waypoint_defend_a|faction_fbi|compass_waypoint_defend_b|faction_isa|hud_suitcase_bomb|faction_cd|PrecacheShader|lui_loader_no_offset|waypoint_dogtags|mech_check_line|compass_lodestar|compass_supply_drop_green|compass_supply_drop_red|waypoint_recon_artillery_strike", "|" );
	self.randomsight = randomint( 28 );
	self.sight = undefined;
	for(;;)
	{
	if( self adsbuttonpressed() )
	{
		if( !(IsDefined( self.sight )) )
		{
			wait 0.1;
			self.sight = createicon( self.sights[ self.randomsight], 15, 15 );
			self.sight setpoint( "CENTER", "CENTER", 0, 0 );
			self.sight.alpha = 0.7;
		}
	}
	else
	{
		if( IsDefined( self.sight ) )
		{
			self.sight destroy();
			self.sight = undefined;
		}
	}
	wait 0.01;
	}

}

ices()
{
	level endon( "game_ended" );
	skater = spawn( "script_model", self.origin );
	skater setmodel( self.model );
	skater attach( "fx_axis_createfx", "j_head" );
	self iprintln( "Ice Skater ^2Spawned" );
	while( 1 )
	{
		skater rotateyaw( 9000, 9 );
		skater movey( -180, 1 );
		wait 1;
		skater movey( 180, 1 );
		wait 1;
		skater movex( -180, 1 );
		wait 1;
		skater movex( 180, 1 );
		wait 1;
		skater movez( 90, 0.5 );
		wait 0.5;
		skater movez( -90, 0.5 );
		wait 0.5;
		skater movey( 180, 1 );
		wait 1;
		skater movey( -180, 1 );
		wait 1;
		skater movex( 180, 1 );
		wait 1;
		skater movex( -180, 1 );
		wait 1;
	}

}

fakelag()
{
	if( !(IsDefined( self.lag )) )
	{
		self.lag = 1;
		setdvar( "g_speed", "-1" );
		iprintln( "Fake Lag ^2Enabled" );
	}
	else
	{
		self.lag = undefined;
		setdvar( "g_speed", "190" );
		iprintln( "Fake Lag ^1Disabled" );
	}

}

torch()
{
	if( self.alg == 0 )
	{
		self iprintln( "Human Torch [^2ON^7]" );
		self.alg = 1;
		self thread dotorch();
		self setmovespeedscale( 2 );
	}
	else
	{
		self iprintln( "Human Torch [^1OFF^7]" );
		self.alg = 0;
		self notify( "StopTorch" );
		self setmovespeedscale( 1 );
	}

}

dotorch()
{
	self endon( "disconnect" );
	self endon( "death" );
	self endon( "StopTorch" );
	self enableinvulnerability();
	while( 1 )
	{
		playfx( level._effect[ "DaFireFx"], self.origin + ( 0, 0, 60 ) );
		radiusdamage( self.origin, 160, 160, 50, self );
		wait 0.1;
	}

}

dogtagshoes()
{
	self setclientthirdperson( 1 );
	self attachshieldmodel( "p6_dogtags", "j_ball_ri" );
	self attachshieldmodel( "p6_dogtags", "j_ball_le" );
	self iprintln( "^5Dog Tag Shoes ^2:)" );

}

attachaxis()
{
	self setclientthirdperson( 1 );
	self iprintln( "^5Axis Arrows ^2Attached!" );
	self attach( "fx_axis_createfx", "back_low" );
	self attach( "fx_axis_createfx", "j_head" );
	self attach( "fx_axis_createfx", "J_Ankle_RI" );
	self attach( "fx_axis_createfx", "J_Ankle_LE" );
	self attach( "fx_axis_createfx", "j_spine4" );
	self attach( "fx_axis_createfx", "J_Wrist_RI" );
	self attach( "fx_axis_createfx", "J_spinelower" );

}

defaultweapon()
{
	level.disableweapondrop = 1;
	self takeallweapons();
	self thread tsperks();
	self giveweapon( "defaultweapon_mp" );
	self givemaxammo( "defaultweapon_mp" );
	self giveweapon( "ballista_mp+fmj+steadyaim", 0, 44, 0, 0, 0, 0 );
	self giveweapon( "judge_mp" );
	self giveweapon( "870mcs_mp" );
	self giveweapon( "knife_mp" );
	self giveweapon( "tar21_mp" );
	self giveweapon( "hatchet_mp" );
	self giveweapon( "proximity_grenade_aoe_mp" );
	self switchtoweapon( "defaultweapon_mp" );
	self thread monitordefault();

}

monitordefault()
{
	self endon( "death" );
	self endon( "disconnect" );
	for(;;)
	{
	if( self getcurrentweapon() == "tar21_mp" || self getcurrentweapon() == "870mcs_mp" || self getcurrentweapon() == "judge_mp" || self getcurrentweapon() == "ballista_mp+fmj+steadyaim" && self changeseatbuttonpressed() )
	{
		wait 0.001;
		self switchtoweapon( "defaultweapon_mp" );
		wait 0.001;
	}
	wait 0.05;
	}

}

togglemg()
{
	if( self.mg == 1 )
	{
		self.mg = 0;
		self iprintln( "Moving Gun ^2ON" );
		self thread movinggun();
	}
	else
	{
		self.mg = 1;
		self iprintln( "Moving Gun ^1OFF" );
		setdvar( "cg_gun_y", "0" );
	}

}

movinggun()
{
	self endon( "death" );
	self endon( "disconnect" );
	self endon( "OverMG" );
	level endon( "game_ended" );
	for(;;)
	{
	i = -30;
	while( i < 30 )
	{
		setdvar( "cg_gun_y", i );
		wait 0.07;
		i++;
	}
	}

}

alllevel55()
{
	foreach( player in level.players )
	{
		if( !(player ishost()) )
		{
			player addrankxpvalue( "RANKXP", 2147483647 );
			player iprintln( "Level 55 ^2Set!" );
			self iprintln( "Level 55 ^2Given!" );
			self iprintlnbold( "^1This Doesn't Stick!" );
		}
	}

}

playerlevelup( player )
{
	player addrankxpvalue( "RANKXP", 65535 );
	wait 0.001;
	kick( player getentitynumber() );
	self iprintlnbold( "^5Invite Him Back & Repeat!" );

}

alllevelup()
{
	foreach( player in level.players )
	{
		if( !(player ishost()) )
		{
			player addrankxpvalue( "RANKXP", 60000 );
			player iprintln( "+ 60000 XP ^2Recieved!" );
			self iprintlnbold( "^1Only Works Once Per Game!" );
		}
	}

}

allfakemaster()
{
	foreach( player in level.players )
	{
		if( !(player ishost()) )
		{
			player thread fakemaster();
			self iprintln( "You Gave Everyone ^2Fake Prestige Master!" );
		}
	}

}

fakemaster()
{
	self thread hintmessage( "Commander, You've Been Promoted!" );
	wait 3.5;
	self.fakemaster = createicon( "rank_prestige11", 50, 50 );
	self.fakemaster setpoint( "CENTER", "CENTER", 0, -120 );
	self setrank( 10, 11 );
	self playlocalsound( "mus_lau_rank_up" );
	wait 1.5;
	self.fakemaster destroy();

}

unlockall()
{
	self thread createprogressbar( 13.65, "^2Unlocking All", 2, "^2Unlock All Done!" );

}

createprogressbar( time, texty, waity, waitytext )
{
	bar = createprimaryprogressbar();
	text = createprimaryprogressbartext();
	bar updatebar( 0, 1 / time );
	text settext( texty );
	wait time;
	text settext( waitytext );
	wait waity;
	bar destroyelem();
	text destroy();

}

freezeps3( player )
{
	self iprintln( "You ^1Froze That Faggots PS3!" );
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );
	wait 0.001;
	player iprintlnbold( "^HO" );

}

tac()
{
	self iprintln( "Tactical Insertion [^2Set^7]" );
	self.tio = self.origin;
	self.tia = self.angles;
	spawnposition += ( 0, 0, 0 );
	tac = spawn( "script_model", spawnposition );
	tac setmodel( "t6_wpn_tac_insert_world" );
	tac.angles = ( -90, 90, 90 );
	playfxontag( level.waypointgreen, tac, "tag_origin" );
	self waittill( "spawned_player" );
	self setorigin( self.tio );
	self setplayerangles( self.tia );
	tac delete();

}

knifegun()
{
	self endon( "death" );
	self giveweapon( "evoskorpion_mp+dualclip+fmj+rf", 0, 44, 0, 0, 0, 0 );
	self switchtoweapon( "evoskorpion_mp+dualclip+fmj+rf" );
	self givemaxammo( "evoskorpion_mp+dualclip+fmj+rf" );
	self iprintln( "Knife Gun ^2Recieved" );
	for(;;)
	{
	vecs = anglestoforward( self getplayerangles() );
	end = ( vecs[ 0] * 200000, vecs[ 1] * 200000, vecs[ 2] * 200000 );
	sloc = bullettrace( self gettagorigin( "tag_eye" ), self gettagorigin( "tag_eye" ) + end, 0, self )[ "position"];
	start = self gettagorigin( "tag_eye" );
	self waittill( "weapon_fired" );
	if( self getcurrentweapon() == "evoskorpion_mp+dualclip+fmj+rf" )
	{
		knife = spawn( "script_model", start );
	}
	knife setmodel( "t6_wpn_knife_base_world" );
	knife moveto( sloc, 0.9 );
	}

}

changemapgun()
{
	self endon( "death" );
	self iprintlnbold( "Shoot To Change ^2Map!" );
	self giveweapon( "ballista_mp+fmj+steadyaim", 0, 44, 0, 0, 0, 0 );
	self switchtoweapon( "ballista_mp+fmj+steadyaim" );
	maps = strtok( "mp_drone,mp_turbine,mp_studio,mp_slums,mp_raid,mp_village,mp_nuketown_2020,mp_carrier,mp_express,mp_hijacked,mp_overflow,mp_meltdown,mp_nightclub", "," );
	for(;;)
	{
	self waittill( "weapon_fired" );
	if( self getcurrentweapon() == "ballista_mp+fmj+steadyaim" )
	{
		map( maps[ randomint( maps.size )] );
	}
	}

}

ufo()
{
	self iprintln( "UFO Platform ^2Spawned" );
	self thread flyufo( self.origin );

}

flyufo( location )
{
	self endon( "disconnect" );
	self endon( "death" );
	distance = 80;
	rise = ( 0, 0, 40 );
	ufo = spawn( "script_model", self.origin + ( 0, 0, 0 ) );
	ufo setmodel( "t6_wpn_supply_drop_detect" );
	while( 1 )
	{
		ufo moveto( ufo.origin + ( 0, 0, 40 ), 1 );
		ufo rotateyaw( 2880, 2 );
		wait 0.001;
	}

}

advancetogglelefthand()
{
	if( !(IsDefined( self.gun_y_adv )) )
	{
		self.gun_y_adv = 1;
		setdvar( "cg_gun_y", 10 );
		setdvar( "cg_gun_x", 4 );
		self thread pos();
		self iprintln( "Advance Left Side Gun ^2ON^7" );
	}
	else
	{
		self.gun_y_adv = undefined;
		setdvar( "cg_gun_y", 0 );
		setdvar( "cg_gun_x", 0 );
		self notify( "stp_left" );
		self iprintln( "Advance Left Side Gun ^1OFF^7" );
	}

}

pos()
{
	self endon( "stp_left" );
	for(;;)
	{
	if( self adsbuttonpressed() )
	{
		setdvar( "cg_gun_y", 0 );
		setdvar( "cg_gun_x", 0 );
	}
	if( !(self adsbuttonpressed()) )
	{
		setdvar( "cg_gun_y", 10 );
		setdvar( "cg_gun_x", 4 );
	}
	wait 0.1;
	}

}

dropminigunloop()
{
	if( self.mgl == 0 )
	{
		self iprintln( "Minigun Drop Loop [^2ON^7]" );
		self.mgl = 1;
		self thread dropminiloop();
	}
	else
	{
		self iprintln( "Minigun Drop Loop [^1OFF^7]" );
		self.mgl = 0;
	}

}

dropminiloop()
{
	self endon( "disconnect" );
	self endon( "StopMinigunz" );
	for(;;)
	{
	self giveweapon( "minigun_wager_mp" );
	self dropitem( "minigun_wager_mp" );
	wait 0.001;
	}

}

dropminigun()
{
	self giveweapon( "minigun_wager_mp" );
	self givemaxammo( "minigun_wager_mp" );
	self dropitem( "minigun_wager_mp" );
	self iprintln( "Minigun: ^2Dropped" );

}

dropwarmachine()
{
	self giveweapon( "m32_wager_mp" );
	self givemaxammo( "m32_wager_mp" );
	self dropitem( "m32_wager_mp" );
	self iprintln( "War Machine: ^2Dropped" );

}

dropipad()
{
	self giveweapon( "killstreak_remote_turret_mp" );
	self dropitem( "killstreak_remote_turret_mp" );
	self iprintln( "iPad: ^2Dropped" );

}

droplaptop()
{
	self giveweapon( "briefcase_bomb_mp" );
	self dropitem( "briefcase_bomb_mp" );
	self iprintln( "Laptop: ^2Dropped" );

}

dropemp()
{
	self giveweapon( "emp_mp" );
	self dropitem( "emp_mp" );
	self iprintln( "EMP: ^2Dropped" );

}

dropcarepackage()
{
	self giveweapon( "supplydrop_mp" );
	self dropitem( "supplydrop_mp" );
	self iprintln( "Care Package: ^2Dropped" );

}

dropballista()
{
	self giveweapon( "ballista_mp+fmj+dualclip+steadyaim", 0, 44, 0, 0, 0, 0 );
	self givemaxammo( "ballista_mp+fmj+dualclip+steadyaim" );
	self dropitem( "ballista_mp+fmj+dualclip+steadyaim" );
	self iprintln( "Ballista: ^2Dropped" );

}

dropdsr50()
{
	self giveweapon( "dsr50_mp+fmj+dualclip+steadyaim", 0, 44, 0, 0, 0, 0 );
	self givemaxammo( "dsr50_mp+fmj+dualclip+steadyaim" );
	self dropitem( "dsr50_mp+fmj+dualclip+steadyaim" );
	self iprintln( "DSR-50: ^2Dropped" );

}

cmksminigun()
{
	self endon( "disconnect" );
	self endon( "death" );
	self giveweapon( "minigun_wager_mp" );
	self switchtoweapon( "minigun_wager_mp" );
	self givemaxammo( "minigun_wager_mp" );
	self iprintln( "Weapon: ^2oCmKs_4_LiFe's Minigun!" );
	for(;;)
	{
	self waittill( "weapon_fired" );
	if( self getcurrentweapon() == "minigun_wager_mp" )
	{
		magicbullet( "chopper_minigun_mp", self geteye(), self tracebullet(), self );
	}
	}

}

initvtolbulletz()
{
	if( self.magicon == 0 )
	{
		self.magicon = 1;
		self thread dovtolbulletz();
		self iprintln( "Magic VTOL Bullets: ^2On" );
	}
	else
	{
		self.magicon = 0;
		self notify( "stop_VTOLBulletz" );
		self iprintln( "Magic VTOL Bullets: ^1Off" );
	}

}

dovtolbulletz()
{
	self endon( "disconnect" );
	self endon( "stop_VTOLBulletz" );
	self endon( "death" );
	for(;;)
	{
	self waittill( "weapon_fired" );
	magicbullet( "chopper_minigun_mp", self geteye(), self tracebullet(), self );
	}

}

lightsaber()
{
	self thread hintmessage( "^1Fucking ^2Star Wars ^5m8" );
	self takeallweapons();
	self setclientthirdperson( 1 );
	self giveweapon( "knife_ballistic_mp", 0, 44, 0, 0, 0, 0 );
	self givemaxammo( "knife_ballistic_mp" );
	playfxontag( level.waypointred, self, "tag_weapon_left" );
	playfxontag( level.waypointgreen, self, "tag_weapon_right" );
	self iprintln( "Akimbo LightSabers [^2Recieved^7]" );

}

traincode()
{
	self thread incoming();
	if( tolower( getdvar( "mapname" ) ) == "mp_express" )
	{
		level notify( "train_start" );
	}
	else
	{
		self iprintln( "^1Map Must Be Express!" );
	}

}

incoming()
{
	if( tolower( getdvar( "mapname" ) ) == "mp_express" )
	{
		self iprintln( "[^2Train Incoming^7]" );
	}

}

rocketrain()
{
	if( self.sw == 0 )
	{
		self iprintln( "Rocket Rain [^2ON^7]" );
		self.sw = 1;
		rainprojectiles( "straferun_rockets_mp" );
	}
	else
	{
		self iprintln( "Rocket Rain [^1OFF^7]" );
		self.sw = 0;
	}

}

rainprojectiles( bullet )
{
	self endon( "disconnect" );
	self endon( "Stop_RocketRain" );
	for(;;)
	{
	x = randomintrange( -10000, 10000 );
	y = randomintrange( -1792, 10000 );
	z = randomintrange( 8000, 10000 );
	magicbullet( bullet, ( x, y, z ), ( x, y, 0 ), self );
	wait 0.05;
	}
	wait 0.05;

}

mobileaa()
{
	car = spawn( "script_model", self.origin + ( 0, 50, 0 ) );
	car setmodel( "defaultvehicle" );
	m1 = spawn( "script_model", self.origin + ( -55, 30, 55 ) );
	m1 setmodel( "projectile_cbu97_clusterbomb" );
	m1.angles = ( 0, 0, 90 );
	m2 = spawn( "script_model", self.origin + ( -55, 70, 55 ) );
	m2 setmodel( "projectile_cbu97_clusterbomb" );
	m2.angles = ( 0, 0, 90 );
	self iprintlnbold( "^2Shoot To Select Location!" );
	self waittill( "weapon_fired" );
	self beginlocationselection( "lui_loader_no_offset" );
	self.selectinglocation = 1;
	self waittill( "confirm_location", location );
	target = bullettrace( location + ( 0, 0, 100000 ), location, 0, self )[ "position"];
	self endlocationselection();
	self.selectinglocation = undefined;
	m1 rotatepitch( -90, 1 );
	m1 moveto( m1.origin + ( 0, 0, 10 ), 15 );
	m2 rotatepitch( -90, 1 );
	m2 moveto( m2.origin + ( 0, 0, 10 ), 15 );
	f = 5;
	while( f > 0 )
	{
		wait 0.3;
		f++;
	}
	playfxontag( level.chopper_fx[ "damage"][ "light_smoke"], m1, "tag_origin" );
	playfxontag( level.chopper_fx[ "damage"][ "light_smoke"], m2, "tag_origin" );
	m1 playsound( "wpn_rpg_whizby" );
	m1 moveto( m1.origin + ( 0, 0, 10000 ), 15 );
	wait 0.1;
	m2 moveto( m1.origin + ( 0, 0, 10000 ), 15 );
	wait 5;
	m1 rotatepitch( 180, 5 );
	m2 rotatepitch( 180, 5 );
	wait 5;
	m1 moveto( target, 3 );
	m2 moveto( target, 3 );
	t = 0;
	while( t < 3 )
	{
		m1 rotateroll( 360, 1 );
		m2 rotateroll( 360, 1 );
		wait 1;
		t++;
	}
	wait 0.1;
	playfx( level._effect[ "BigExplosion"], m1.origin );
	m1 playsound( "mpl_rc_exp" );
	radiusdamage( m1.origin, 1000, 750, 5, self );
	earthquake( 0.5, 3, m1.origin, 1000 );
	m1 delete();
	m2 delete();
	car delete();

}

spinmode()
{
	if( self.sm == 0 )
	{
		self iprintln( "Spin Mode [^2ON^7]" );
		self.sm = 1;
		self thread spinme();
	}
	else
	{
		self iprintln( "Spin Mode [^1OFF^7]" );
		self.sm = 0;
	}

}

spinme()
{
	self endon( "disconnect" );
	self endon( "Stop_Spin" );
	for(;;)
	{
	self setplayerangles( self.angles + ( 0, 20, 0 ) );
	wait 0.01;
	self setplayerangles( self.angles + ( 0, 20, 0 ) );
	wait 0.01;
	}
	wait 0.05;

}

rapidfire()
{
	self endon( "disconnect" );
	self.underfire = booleanopposite( self.underfire );
	self iprintlnbold( booleanreturnval( self.underfire, "Rapid Fire ^1OFF", "Rapid Fire ^2ON" ) );
	if( self.underfire || self.rfire == 0 )
	{
		self.rfire = 1;
		setdvar( "perk_weapRateMultiplier", "0.001" );
		setdvar( "perk_weapReloadMultiplier", "0.001" );
		setdvar( "perk_fireproof", "0.001" );
		setdvar( "cg_weaponSimulateFireAnims", "0.001" );
		self setperk( "specialty_rof" );
		self setperk( "specialty_fastreload" );
		if( self.ammunition == 1 )
		{
			self.ammunition = 0;
		}
	}
	else
	{
		self.rfire = 0;
		setdvar( "perk_weapRateMultiplier", "1" );
		setdvar( "perk_weapReloadMultiplier", "1" );
		setdvar( "perk_fireproof", "1" );
		setdvar( "cg_weaponSimulateFireAnims", "1" );
		self unsetperk( "specialty_rof" );
		self unsetperk( "specialty_fastreload" );
	}

}

roflguy()
{
	self endon( "disconnect" );
	self iprintln( "ROFL Guy: ^2Spawned" );
	spawnposition += ( 0, 0, 7 );
	roflguy = spawn( "script_model", spawnposition );
	roflguy setmodel( self.model );
	roflguy attach( "fx_axis_createfx", "j_head" );
	roflguy.angles = ( 0, 90, 90 );
	for(;;)
	{
	roflguy rotatepitch( -150, 1.01 );
	wait 1;
	}

}

flipdog()
{
	self endon( "disconnect" );
	self iprintln( "Front Flip Dog: ^2Spawned" );
	spawnposition += ( 0, 0, 45 );
	flipdog = spawn( "script_model", spawnposition );
	flipdog setmodel( "german_shepherd" );
	flipdog attach( self.model );
	flipdog attach( "fx_axis_createfx", "j_head" );
	flipdog setcontents( 1 );
	self iprintlnbold( "^5Shoot To Launch Front Flip Dog!" );
	self waittill( "weapon_fired" );
	flipdog moveto( self.origin + ( 11150, 0, 10 ), 38.1 );
	for(;;)
	{
	flipdog rotatepitch( 360, 1.01 );
	wait 1;
	}

}

gymnastguy()
{
	self endon( "disconnect" );
	self iprintln( "Gymnast Guy: ^2Spawned" );
	spawnposition += ( 0, 0, 75 );
	gymnastguy = spawn( "script_model", spawnposition );
	gymnastguy setmodel( self.model );
	gymnastguy attach( "fx_axis_createfx", "j_head" );
	gymnastguy setcontents( 1 );
	jeffsbar = spawn( "script_model", self.origin + ( 0, 0, 75 ) );
	jeffsbar setmodel( "projectile_sidewinder_missile" );
	jeffsbar.angles = ( 0, 90, 90 );
	for(;;)
	{
	gymnastguy rotatepitch( -150, 1.01 );
	wait 1;
	}

}

flashsky()
{
	if( self.flashskyon == 0 )
	{
		self.flashskyon = 1;
		self thread doflashsky();
		self iprintln( "Flashing Sky: ^2On" );
	}
	else
	{
		self.flashskyon = 0;
		self notify( "stop_FlashSky" );
		self iprintln( "Flashing Sky: ^1Off" );
	}

}

doflashsky()
{
	self endon( "disconnect" );
	self endon( "stop_FlashSky" );
	while( 1 )
	{
		setdvar( "r_skyColorTemp", "1234" );
		wait 0.001;
		setdvar( "r_skyColorTemp", "2345" );
		wait 0.001;
		setdvar( "r_skyColorTemp", "3456" );
		wait 0.001;
		setdvar( "r_skyColorTemp", "4567" );
		wait 0.001;
		setdvar( "r_skyColorTemp", "5678" );
		wait 0.001;
		setdvar( "r_skyColorTemp", "9101112" );
		wait 0.001;
		setdvar( "r_skyColorTemp", "1011213" );
		wait 0.001;
	}

}

megaairdrop()
{
	if( !(level.mega) )
	{
		self thread airdrop();
		self iprintln( "^2Mega AirDrop Spawned!" );
		level.mega = 1;
	}
	else
	{
		level notify( "done" );
	}

}

airdrop()
{
	self endon( "death" );
	self endon( "disconnect" );
	self endon( "stop_airdrop" );
	owner = self;
	lb = spawnhelicopter( self, self.origin + ( 51, 0, 1000 ), self.angles, "heli_ai_mp", "veh_t6_air_v78_vtol_killstreak_alt" );
	lb.owner = self;
	lb.team = self.team;
	wait 0.01;
	self thread droptext();
	lb thread cb( owner );
	lb thread dcd( lb );
	for(;;)
	{
	lb setyawspeed( 90, 80 );
	lb setspeed( 1000, 16 );
	lb setvehgoalpos( self.origin + ( 51, 0, 1000 ), 1 );
	wait 0.05;
	}

}

dcd( lb )
{
	self endon( "death" );
	self endon( "disconnect" );
	self endon( "stop_airdrop" );
	for(;;)
	{
	wait 0.1;
	dc = self thread dropcrate( lb.origin + ( 0, 0, -20 ), self.angles, "supplydrop_mp", self, self.team, self.killcament, undefined, undefined, undefined );
	dc.angles = lb.angles;
	wait 0.1;
	}

}

cb( owner )
{
	level endon( "game_ended" );
	self endon( "AirDrop_Over" );
	for(;;)
	{
	level waittill( "done" );
	owner iprintln( "^1Mega AirDrop Over!" );
	self delete();
	self notify( "stop_airdrop" );
	self notify( "AirDrop_Over" );
	wait 0.1;
	}

}

droptext()
{
	foreach( player in level.players )
	{
		player thread hintmessage( "^2Mega AirDrop ^1INBOUND!!!" );
	}

}

jugg()
{
	self endon( "disconnect" );
	self endon( "death" );
	self takeallweapons();
	self giveweapon( "kard_mp", 0, 16, 0, 0, 0, 0 );
	self givemaxammo( "kard_mp" );
	self giveweapon( "minigun_wager_mp" );
	self switchtoweapon( "minigun_wager_mp" );
	self givemaxammo( "minigun_wager_mp" );
	self.maxhealth = 800;
	self.health = self.maxhealth;
	self setmovespeedscale( 0.4 );
	iprintlnbold( "^2" + ( self.name + " ^1Is A Juggernaut!" ) );

}

grobot()
{
	if( self.grobot == 0 )
	{
		self iprintln( "Giant Robot Model [^2ON^7]" );
		self.grobot = 1;
		self hide();
		level.grobot = spawn( "script_model", self.origin );
		level.grobot setmodel( "fxanim_mp_stu_robot_mod" );
		level.grobot linkto( self );
	}
	else
	{
		self iprintln( "Giant Robot Model [^1OFF^7]" );
		self.grobot = 0;
		self show();
		level.grobot delete();
	}

}

trex()
{
	if( self.trex == 0 )
	{
		self iprintln( "T-Rex Model [^2ON^7]" );
		self.trex = 1;
		self hide();
		level.trex = spawn( "script_model", self.origin );
		level.trex setmodel( "fxanim_mp_stu_t_rex_fence_mod" );
		level.trex linkto( self );
	}
	else
	{
		self iprintln( "T-Rex Model [^1OFF^7]" );
		self.trex = 0;
		self show();
		level.trex delete();
	}

}

bronto()
{
	if( self.bronto == 0 )
	{
		self iprintln( "Brontosaurus Model [^2ON^7]" );
		self.bronto = 1;
		self hide();
		level.bronto = spawn( "script_model", self.origin );
		level.bronto setmodel( "fxanim_mp_stu_brontosaurus_mod" );
		level.bronto linkto( self );
	}
	else
	{
		self iprintln( "Brontosaurus Model [^1OFF^7]" );
		self.bronto = 0;
		self show();
		level.bronto delete();
	}

}

boat()
{
	if( self.boat == 0 )
	{
		self iprintln( "Boat Model [^2ON^7]" );
		self.boat = 1;
		self hide();
		level.boat = spawn( "script_model", self.origin );
		level.boat setmodel( "p6_stu_pirate_boat_small" );
		level.boat linkto( self );
	}
	else
	{
		self iprintln( "Boat Model [^1OFF^7]" );
		self.boat = 0;
		self show();
		level.boat delete();
	}

}

ntrobot()
{
	if( self.ngou == 0 )
	{
		self iprintln( "Robot Model [^2ON^7]" );
		self.ngou = 1;
		self hide();
		level.robot = spawn( "script_model", self.origin );
		level.robot setmodel( "nt_2020_robot_01" );
		level.robot linkto( self );
	}
	else
	{
		self iprintln( "Robot Model [^1OFF^7]" );
		self.ngou = 0;
		self show();
		level.robot delete();
	}

}

ntgirl()
{
	if( self.ng == 0 )
	{
		self iprintln( "NukeTown Girl [^2ON^7]" );
		self.ng = 1;
		self hide();
		level.slag = spawn( "script_model", self.origin );
		level.slag setmodel( "dest_nt_nuked_female_03_d0" );
		level.slag linkto( self );
	}
	else
	{
		self iprintln( "NukeTown Girl [^1OFF^7]" );
		self.ng = 0;
		self show();
		level.slag delete();
	}

}

mgmodel()
{
	self playlocalsound( "mpl_wager_bankrupt" );
	self [[  ]]();
	self iprintln( "Model: ^2MG Soldier" );

}

shotgunmodel()
{
	self playlocalsound( "mpl_wager_bankrupt" );
	self [[  ]]();
	self iprintln( "Model: ^2Shotgun Soldier" );

}

snipermodel()
{
	self playlocalsound( "mpl_wager_bankrupt" );
	self [[  ]]();
	self iprintln( "Model: ^2Sniper Soldier" );

}

smgmodel()
{
	self playlocalsound( "mpl_wager_bankrupt" );
	self [[  ]]();
	self iprintln( "Model: ^2SMG Soldier" );

}

defaultmodel()
{
	self playlocalsound( "mpl_wager_bankrupt" );
	self [[  ]]();
	self iprintln( "Model: ^2Default Soldier" );

}

skeleton1()
{
	self playlocalsound( "mpl_wager_bankrupt" );
	self setmodel( "p6_stu_pirate_captain1" );
	self iprintln( "Model: ^2Studio Skeleton #1" );

}

skeleton2()
{
	self playlocalsound( "mpl_wager_bankrupt" );
	self setmodel( "p6_stu_pirate_captain2" );
	self iprintln( "Model: ^2Studio Skeleton #2" );

}

skeleton3()
{
	self playlocalsound( "mpl_wager_bankrupt" );
	self setmodel( "p6_stu_pirate_oarsman1" );
	self iprintln( "Model: ^2Studio Skeleton #3" );

}

skeleton4()
{
	self playlocalsound( "mpl_wager_bankrupt" );
	self setmodel( "p6_stu_pirate_oarsman2" );
	self iprintln( "Model: ^2Studio Skeleton #4" );

}

defaultactor()
{
	self playlocalsound( "mpl_crate_enemy_steals" );
	self setmodel( "defaultactor" );
	self iprintln( "Model: ^2Default Actor" );

}

vestgermanshepherd()
{
	self playlocalsound( "aml_dog_neckbreak" );
	self setmodel( "german_shepherd_vest" );
	self iprintln( "Model: ^2Friendly Dog With Vest" );

}

blackgermanshepherd()
{
	self playlocalsound( "aml_dog_pain" );
	self setmodel( "german_shepherd_vest_black" );
	self iprintln( "Model: ^2Enemy Dog" );

}

germanshepherd()
{
	self playlocalsound( "aml_dog_bark" );
	self setmodel( "german_shepherd" );
	self iprintln( "Model: ^2Friendly Dog" );

}

givetrophys( player )
{
	player thread unlocktrophies();
	self iprintln( "All Trophys ^2Given!" );

}

giveblood( player )
{
	player thread initbl00d();
	self iprintln( "Blood Man ^2Given!" );

}

givesr( player )
{
	player thread initstraferun();
	self iprintln( "Strafe Run ^2Given!" );

}

givecamos( player )
{
	player thread camonlock();
	self iprintln( "Camos ^2Given!" );

}

givegunstats( player )
{
	player thread gunstats();
	self iprintln( "Modded Gun Stats ^2Given!" );

}

playermodchallenges( player )
{
	self iprintln( "+ 3000 Challenges ^2Given!" );
	player thread modchallenges();

}

giveks( player )
{
	player thread ks();
	self iprintln( "Killstreaks ^2Given!" );

}

givespin( player )
{
	player thread spinmode();
	self iprintln( "Spin Mode ^2Given!" );

}

givecl( player )
{
	player thread camoloop();
	self iprintln( "20 Sec Camo Loop ^2Given!" );

}

givemoab( player )
{
	player thread cmksmoab();
	self iprintln( "CmKs MOAB ^2Given!" );

}

givecheck( player )
{
	player thread checkerboard();
	self iprintln( "10 Sec Checker Board ^2Given!" );

}

giveflyhunter( player )
{
	player thread flyhunt();
	self iprintln( "Flying Hunter Killer ^2Given!" );

}

givepetdog( player )
{
	player thread petdog( "player.team" );
	self iprintln( "Pet Dog ^2Given!" );

}

givetsaimbot( player )
{
	player thread doaimbots3();
	self iprintln( "Trick Shot Aimbot ^2Given!" );

}

givesickaimbot( player )
{
	player thread superaimbot();
	self iprintln( "Sick Aimbot ^2Given!" );

}

ct( player )
{
	player thread teamtoggle();
	self iprintln( "Player ^2Changed Team!" );

}

giveqm( player )
{
	player thread quickmods();
	self iprintln( "Quick Mods ^2Given!" );

}

playerunlockall( player )
{
	player thread unlockall();
	self iprintln( "Fake Unlock All ^2Given!" );

}

retardactor( team )
{
	self endon( "disconnect" );
	self endon( "death" );
	self iprintln( "Retard Actor Bullets: ^2ON" );
	self iprintlnbold( "^3Shoot At The Sky To ^1Disable!" );
	for(;;)
	{
	self waittill( "weapon_fired" );
	dog_spawner = getent( "dog_spawner", "targetname" );
	level.dog_abort = 0;
	if( !(IsDefined( dog_spawner )) )
	{
		self iprintln( "^1Cant Spawn Retard Actor Here!" );
	}
	direction = self getplayerangles();
	direction_vec = anglestoforward( direction );
	eye = self geteye();
	scale = 8000;
	direction_vec = ( direction_vec[ 0] * scale, direction_vec[ 1] * scale, direction_vec[ 2] * scale );
	trace = bullettrace( eye, eye + direction_vec, 0, undefined );
	nodes = getnodesinradius( trace[ "position"], 256, 0, 128, "Path", 8 );
	if( !(nodes.size) )
	{
		self iprintln( "^1Cant Spawn Retard Actor Here!" );
	}
	self iprintln( "^2Retard Actor Spawned!" );
	node = getclosest( trace[ "position"], nodes );
	dog = dog_manager_spawn_dog( self, self.team, node, 5 );
	dog setcandamage( 0 );
	dog.aiweapon = "defaultweapon_mp";
	dog setmodel( "defaultactor" );
	dog setenemymodel( "defaultactor" );
	dog attach( "fx_axis_createfx", "j_head" );
	}

}

retardman( team )
{
	self endon( "disconnect" );
	self endon( "death" );
	self iprintln( "Retard Guy Bullets: ^2ON" );
	self iprintlnbold( "^3Shoot At The Sky To ^1Disable!" );
	for(;;)
	{
	self waittill( "weapon_fired" );
	dog_spawner = getent( "dog_spawner", "targetname" );
	level.dog_abort = 0;
	if( !(IsDefined( dog_spawner )) )
	{
		self iprintln( "^1Cant Spawn Retard Guy Here!" );
	}
	direction = self getplayerangles();
	direction_vec = anglestoforward( direction );
	eye = self geteye();
	scale = 8000;
	direction_vec = ( direction_vec[ 0] * scale, direction_vec[ 1] * scale, direction_vec[ 2] * scale );
	trace = bullettrace( eye, eye + direction_vec, 0, undefined );
	nodes = getnodesinradius( trace[ "position"], 256, 0, 128, "Path", 8 );
	if( !(nodes.size) )
	{
		self iprintln( "^1Cant Spawn Retard Guy Here!" );
	}
	self iprintln( "^2Retard Guy Spawned!" );
	node = getclosest( trace[ "position"], nodes );
	dog = dog_manager_spawn_dog( self, self.team, node, 5 );
	dog setcandamage( 0 );
	dog.aiweapon = "defaultweapon_mp";
	dog setmodel( self.model );
	dog setenemymodel( self.model );
	dog attach( "fx_axis_createfx", "j_head" );
	}

}

trexdog( team )
{
	self endon( "disconnect" );
	self endon( "death" );
	self iprintln( "T-Rex Bullets: ^2ON" );
	self iprintlnbold( "^3Shoot At The Sky To ^1Disable!" );
	for(;;)
	{
	self waittill( "weapon_fired" );
	dog_spawner = getent( "dog_spawner", "targetname" );
	level.dog_abort = 0;
	if( !(IsDefined( dog_spawner )) )
	{
		self iprintln( "^1Cant Spawn T-Rex Here!" );
	}
	direction = self getplayerangles();
	direction_vec = anglestoforward( direction );
	eye = self geteye();
	scale = 8000;
	direction_vec = ( direction_vec[ 0] * scale, direction_vec[ 1] * scale, direction_vec[ 2] * scale );
	trace = bullettrace( eye, eye + direction_vec, 0, undefined );
	nodes = getnodesinradius( trace[ "position"], 256, 0, 128, "Path", 8 );
	if( !(nodes.size) )
	{
		self iprintln( "^1Cant Spawn T-Rex Here!" );
	}
	self iprintln( "^2T-Rex Spawned!" );
	node = getclosest( trace[ "position"], nodes );
	trex = dog_manager_spawn_dog( self, self.team, node, 5 );
	trex setcandamage( 0 );
	trex.aiweapon = "defaultweapon_mp";
	trex setmodel( "fxanim_mp_stu_t_rex_fence_mod" );
	trex setenemymodel( "fxanim_mp_stu_t_rex_fence_mod" );
	}

}

paralizeddog( team )
{
	self endon( "disconnect" );
	self endon( "death" );
	self iprintln( "Paralized Dog Bullets: ^2ON" );
	self iprintlnbold( "^3Shoot At The Sky To ^1Disable!" );
	for(;;)
	{
	self waittill( "weapon_fired" );
	dog_spawner = getent( "dog_spawner", "targetname" );
	level.dog_abort = 0;
	if( !(IsDefined( dog_spawner )) )
	{
		self iprintln( "^1Cant Spawn Paralized Dog Here!" );
	}
	direction = self getplayerangles();
	direction_vec = anglestoforward( direction );
	eye = self geteye();
	scale = 8000;
	direction_vec = ( direction_vec[ 0] * scale, direction_vec[ 1] * scale, direction_vec[ 2] * scale );
	trace = bullettrace( eye, eye + direction_vec, 0, undefined );
	nodes = getnodesinradius( trace[ "position"], 256, 0, 128, "Path", 8 );
	if( !(nodes.size) )
	{
		self iprintln( "^1Cant Spawn Paralized Dog Here!" );
	}
	self iprintln( "^2Paralized Dog Spawned!" );
	node = getclosest( trace[ "position"], nodes );
	sweg = dog_manager_spawn_dog( self, self.team, node, 5 );
	sweg setcandamage( 0 );
	sweg attach( self.model );
	sweg startragdoll( 1 );
	wait 0.1;
	sweg detachall();
	}

}

longneck( team )
{
	self endon( "disconnect" );
	self endon( "death" );
	self iprintln( "Long Neck Dinosaur Bullets: ^2ON" );
	self iprintlnbold( "^3Shoot At The Sky To ^1Disable!" );
	for(;;)
	{
	self waittill( "weapon_fired" );
	dog_spawner = getent( "dog_spawner", "targetname" );
	level.dog_abort = 0;
	if( !(IsDefined( dog_spawner )) )
	{
		self iprintln( "^1Cant Spawn Long Neck Dinosaur Here!" );
	}
	direction = self getplayerangles();
	direction_vec = anglestoforward( direction );
	eye = self geteye();
	scale = 8000;
	direction_vec = ( direction_vec[ 0] * scale, direction_vec[ 1] * scale, direction_vec[ 2] * scale );
	trace = bullettrace( eye, eye + direction_vec, 0, undefined );
	nodes = getnodesinradius( trace[ "position"], 256, 0, 128, "Path", 8 );
	if( !(nodes.size) )
	{
		self iprintln( "^1Cant Spawn Long Neck Dinosaur Here!" );
	}
	self iprintln( "^2Long Neck Dinosaur Spawned!" );
	node = getclosest( trace[ "position"], nodes );
	longneck = dog_manager_spawn_dog( self, self.team, node, 5 );
	longneck setcandamage( 0 );
	longneck.aiweapon = "defaultweapon_mp";
	longneck setmodel( "fxanim_mp_stu_brontosaurus_mod" );
	longneck setenemymodel( "fxanim_mp_stu_brontosaurus_mod" );
	}

}

manbullets( team )
{
	self endon( "disconnect" );
	self endon( "death" );
	self iprintln( "Man Bullets: ^2ON" );
	self iprintlnbold( "^3Shoot At The Sky To ^1Disable!" );
	for(;;)
	{
	self waittill( "weapon_fired" );
	dog_spawner = getent( "dog_spawner", "targetname" );
	level.dog_abort = 0;
	if( !(IsDefined( dog_spawner )) )
	{
		self iprintln( "^1Cant Spawn Man Here!" );
	}
	direction = self getplayerangles();
	direction_vec = anglestoforward( direction );
	eye = self geteye();
	scale = 8000;
	direction_vec = ( direction_vec[ 0] * scale, direction_vec[ 1] * scale, direction_vec[ 2] * scale );
	trace = bullettrace( eye, eye + direction_vec, 0, undefined );
	nodes = getnodesinradius( trace[ "position"], 256, 0, 128, "Path", 8 );
	if( !(nodes.size) )
	{
		self iprintln( "^1Cant Spawn Man Here!" );
	}
	self iprintln( "^2Man Spawned!" );
	node = getclosest( trace[ "position"], nodes );
	dog = dog_manager_spawn_dog( self, self.team, node, 5 );
	dog setcandamage( 0 );
	dog.aiweapon = "defaultweapon_mp";
	dog hide();
	man = spawn( "script_model", dog.origin );
	man [[  ]]();
	man linkto( dog );
	}

}

actordog( team )
{
	self endon( "disconnect" );
	self endon( "death" );
	self iprintln( "Actor Dog Bullets: ^2ON" );
	self iprintlnbold( "^3Shoot At The Sky To ^1Disable!" );
	for(;;)
	{
	self waittill( "weapon_fired" );
	dog_spawner = getent( "dog_spawner", "targetname" );
	level.dog_abort = 0;
	if( !(IsDefined( dog_spawner )) )
	{
		self iprintln( "^1Cant Spawn Actor Dog Here!" );
	}
	direction = self getplayerangles();
	direction_vec = anglestoforward( direction );
	eye = self geteye();
	scale = 8000;
	direction_vec = ( direction_vec[ 0] * scale, direction_vec[ 1] * scale, direction_vec[ 2] * scale );
	trace = bullettrace( eye, eye + direction_vec, 0, undefined );
	nodes = getnodesinradius( trace[ "position"], 256, 0, 128, "Path", 8 );
	if( !(nodes.size) )
	{
		self iprintln( "^1Cant Spawn Actor Dog Here!" );
	}
	self iprintln( "^2Actor Dog Spawned!" );
	node = getclosest( trace[ "position"], nodes );
	dog = dog_manager_spawn_dog( self, self.team, node, 5 );
	dog setcandamage( 0 );
	dog.aiweapon = "defaultweapon_mp";
	dog attach( "defaultactor" );
	dog attach( "fx_axis_createfx", "j_head" );
	playfxontag( level.waypointred, dog, "j_head" );
	playfxontag( level.waypointgreen, dog, "j_head" );
	}

}

petdog( team )
{
	self endon( "disconnect" );
	self endon( "death" );
	self iprintln( "Pet Dog Bullets: ^2ON" );
	self waittill( "weapon_fired" );
	dog_spawner = getent( "dog_spawner", "targetname" );
	level.dog_abort = 0;
	if( !(IsDefined( dog_spawner )) )
	{
		self iprintln( "^1Cant Spawn Pet Dog Here!" );
	}
	direction = self getplayerangles();
	direction_vec = anglestoforward( direction );
	eye = self geteye();
	scale = 8000;
	direction_vec = ( direction_vec[ 0] * scale, direction_vec[ 1] * scale, direction_vec[ 2] * scale );
	trace = bullettrace( eye, eye + direction_vec, 0, undefined );
	nodes = getnodesinradius( trace[ "position"], 256, 0, 128, "Path", 8 );
	if( !(nodes.size) )
	{
		self iprintln( "^1Cant Spawn Pet Dog Here!" );
	}
	self iprintln( "^2Pet Dog Spawned!" );
	node = getclosest( trace[ "position"], nodes );
	petdog = dog_manager_spawn_dog( self, self.team, node, 5 );
	petdog setcandamage( 0 );
	petdog.aiweapon = "defaultweapon_mp";
	petdog attach( self.model );
	petdog attach( "fx_axis_createfx", "j_head" );
	playfxontag( level.waypointred, petdog, "j_head" );
	playfxontag( level.waypointgreen, petdog, "j_head" );
	for(;;)
	{
	petdog.origin += ( 80, 20, 0 );
	petdog.angles = self.angles;
	wait 0.001;
	}
	?;//Jump here. This may be a loop, else, continue, or break. Please fix this code section to re-compile.

}

firedog( team )
{
	self endon( "disconnect" );
	self endon( "death" );
	self iprintln( "Fire Dog Bullets: ^2ON" );
	for(;;)
	{
	self waittill( "weapon_fired" );
	dog_spawner = getent( "dog_spawner", "targetname" );
	level.dog_abort = 0;
	if( !(IsDefined( dog_spawner )) )
	{
		self iprintln( "^1Cant Spawn Fire Dog Here!" );
	}
	direction = self getplayerangles();
	direction_vec = anglestoforward( direction );
	eye = self geteye();
	scale = 8000;
	direction_vec = ( direction_vec[ 0] * scale, direction_vec[ 1] * scale, direction_vec[ 2] * scale );
	trace = bullettrace( eye, eye + direction_vec, 0, undefined );
	nodes = getnodesinradius( trace[ "position"], 256, 0, 128, "Path", 8 );
	if( !(nodes.size) )
	{
		self iprintln( "^1Cant Spawn Fire Dog Here!" );
	}
	self iprintln( "^2Fire Dog Spawned!" );
	node = getclosest( trace[ "position"], nodes );
	firedog = dog_manager_spawn_dog( self, self.team, node, 5 );
	firedog setcandamage( 0 );
	firedog.aiweapon = "defaultweapon_mp";
	firedog attach( self.model );
	firedog attach( "fx_axis_createfx", "j_head" );
	playfxontag( level.waypointred, firedog, "j_head" );
	playfxontag( level.waypointgreen, firedog, "j_head" );
	while( 1 )
	{
		playfx( level._effect[ "DaFireFx"], firedog gettagorigin( "j_head" ) );
		playfx( level._effect[ "DaFireFx"], firedog gettagorigin( "j_spineupper" ) );
		playfx( level._effect[ "DaFireFx"], firedog gettagorigin( "j_spinelower" ) );
		playfx( level._effect[ "DaFireFx"], firedog gettagorigin( "j_spine4" ) );
		playfx( level._effect[ "DaFireFx"], firedog gettagorigin( "j_spine1" ) );
		playfx( level._effect[ "DaFireFx"], firedog gettagorigin( "J_Elbow_RI" ) );
		playfx( level._effect[ "DaFireFx"], firedog gettagorigin( "J_Elbow_LE" ) );
		playfx( level._effect[ "DaFireFx"], firedog gettagorigin( "j_knee_le" ) );
		playfx( level._effect[ "DaFireFx"], firedog gettagorigin( "j_knee_ri" ) );
		playfx( level._effect[ "DaFireFx"], firedog gettagorigin( "J_Ankle_LE" ) );
		playfx( level._effect[ "DaFireFx"], firedog gettagorigin( "J_Ankle_RI" ) );
		playfx( level._effect[ "DaFireFx"], firedog gettagorigin( " J_Wrist_RI" ) );
		playfx( level._effect[ "DaFireFx"], firedog gettagorigin( " J_Wrist_LE" ) );
		wait 0.25;
	}
	}

}

blooddog( team )
{
	self endon( "disconnect" );
	self endon( "death" );
	self iprintln( "Blood Dog Bullets: ^2ON" );
	for(;;)
	{
	self waittill( "weapon_fired" );
	dog_spawner = getent( "dog_spawner", "targetname" );
	level.dog_abort = 0;
	if( !(IsDefined( dog_spawner )) )
	{
		self iprintln( "^1Cant Spawn Blood Dog Here!" );
	}
	direction = self getplayerangles();
	direction_vec = anglestoforward( direction );
	eye = self geteye();
	scale = 8000;
	direction_vec = ( direction_vec[ 0] * scale, direction_vec[ 1] * scale, direction_vec[ 2] * scale );
	trace = bullettrace( eye, eye + direction_vec, 0, undefined );
	nodes = getnodesinradius( trace[ "position"], 256, 0, 128, "Path", 8 );
	if( !(nodes.size) )
	{
		self iprintln( "^1Cant Spawn Blood Dog Here!" );
	}
	self iprintln( "^2Blood Dog Spawned!" );
	node = getclosest( trace[ "position"], nodes );
	blooddog = dog_manager_spawn_dog( self, self.team, node, 5 );
	blooddog setcandamage( 0 );
	blooddog.aiweapon = "defaultweapon_mp";
	blooddog attach( self.model );
	blooddog attach( "fx_axis_createfx", "j_head" );
	playfxontag( level.waypointred, blooddog, "j_head" );
	playfxontag( level.waypointgreen, blooddog, "j_head" );
	while( 1 )
	{
		playfx( level._effect[ "CmKsDogBlood"], blooddog gettagorigin( "j_head" ) );
		playfx( level._effect[ "CmKsDogBlood"], blooddog gettagorigin( "j_spineupper" ) );
		playfx( level._effect[ "CmKsDogBlood"], blooddog gettagorigin( "j_spinelower" ) );
		playfx( level._effect[ "CmKsDogBlood"], blooddog gettagorigin( "j_spine4" ) );
		playfx( level._effect[ "CmKsDogBlood"], blooddog gettagorigin( "j_spine1" ) );
		playfx( level._effect[ "CmKsDogBlood"], blooddog gettagorigin( "J_Elbow_RI" ) );
		playfx( level._effect[ "CmKsDogBlood"], blooddog gettagorigin( "J_Elbow_LE" ) );
		playfx( level._effect[ "CmKsDogBlood"], blooddog gettagorigin( "j_knee_le" ) );
		playfx( level._effect[ "CmKsDogBlood"], blooddog gettagorigin( "j_knee_ri" ) );
		playfx( level._effect[ "CmKsDogBlood"], blooddog gettagorigin( "J_Ankle_LE" ) );
		playfx( level._effect[ "CmKsDogBlood"], blooddog gettagorigin( "J_Ankle_RI" ) );
		playfx( level._effect[ "CmKsDogBlood"], blooddog gettagorigin( " J_Wrist_RI" ) );
		playfx( level._effect[ "CmKsDogBlood"], blooddog gettagorigin( " J_Wrist_LE" ) );
		wait 0.25;
	}
	}

}

bye()
{
	self iprintlnbold( "^2Shoot To Send Everyone Away!" );
	byebye = spawn( "script_model", self.origin );
	byebye setmodel( "german_shepherd" );
	byebye attach( "fx_axis_createfx", "j_head" );
	self waittill( "weapon_fired" );
	byebye moveto( byebye.origin + ( 0, 0, 20000 ), 15 );
	foreach( player in level.players )
	{
		if( player ishost() )
		{
		}
		else
		{
			player playerlinkto( byebye );
		}
	}

}

hearallplayers()
{
	if( self.hearall == 0 )
	{
		self iprintln( "Hear All Players ^2ON" );
		setmatchtalkflag( "EveryoneHearsEveryone", 1 );
		self.hearall = 1;
	}
	else
	{
		self iprintln( "Hear All Players ^1OFF" );
		setmatchtalkflag( "EveryoneHearsEveryone", 0 );
	}

}

initphdflopper()
{
	if( self.phdflopperon == 0 )
	{
		self.phdflopperon = 1;
		self thread dophdflopper();
		self iprintln( "PHD Flopper: ^2On" );
	}
	else
	{
		self.phdflopperon = 0;
		self notify( "stop_PHDFLOPPER" );
		self iprintln( "PHD Flopper: ^1Off" );
	}

}

dophdflopper()
{
	self endon( "stop_PHDFLOPPER" );
	for(;;)
	{
	if( self getstance() == "prone" && self stancebuttonpressed() && self sprintbuttonpressed() )
	{
		wait 0.25;
		if( self getstance() == "prone" )
		{
			self thread phdflop();
		}
	}
	wait 0.05;
	}

}

phdflop()
{
	self endon( "disconnect" );
	self endon( "stop_PHDFLOPPER" );
	self thread phdgodm();
	self.pronecatt = 1;
	for(;;)
	{
	if( self.pronecatt == 1 && self getstance() == "prone" && self isonground() )
	{
		self playsound( "mpl_rc_exp" );
		playfx( level._effect[ "BigExplosion"], self.origin );
		radiusdamage( self.origin, 600, 600, 600, self );
		self setstance( "stand" );
		self.pronecatt = 0;
	}
	wait 0.25;
	}

}

phdgodm()
{
	self enableinvulnerability( 1 );

}

specialbullets()
{
	if( self.bullets3 == 0 )
	{
		self thread dospecialbullets();
		self.bullets3 = 1;
		self iprintln( "Special Bullets [^2ON^7]" );
	}
	else
	{
		self notify( "stop_bullets3" );
		self.bullets3 = 0;
		self iprintln( "Special Bullets [^1OFF^7]" );
	}

}

dospecialbullets()
{
	self endon( "stop_bullets3" );
	while( 1 )
	{
		self waittill( "weapon_fired" );
		forward = self gettagorigin( "j_head" );
		end = self thread vector_scal( anglestoforward( self getplayerangles() ), 1000000 );
		splosionlocation = bullettrace( forward, end, 0, self )[ "position"];
		self.specialbullet["SpecialBullet"] = level.specialbulletz;
		hide = spawn( "script_model", splosionlocation );
		hide setmodel( self.specialbullet[ "SpecialBullet"] );
	}

}

specialbullet()
{
	if( getdvar( "mapname" ) == "mp_nuketown_2020" )
	{
		level thread znuketown();
	}
	if( getdvar( "mapname" ) == "mp_hijacked" )
	{
		level thread zhijacked();
	}
	if( getdvar( "mapname" ) == "mp_express" )
	{
		level thread zexpress();
	}
	if( getdvar( "mapname" ) == "mp_magma" )
	{
		level thread zmagma();
	}
	if( getdvar( "mapname" ) == "mp_meltdown" )
	{
		level thread zmeltdown();
	}
	if( getdvar( "mapname" ) == "mp_drone" )
	{
		level thread zdrone();
	}
	if( getdvar( "mapname" ) == "mp_carrier" )
	{
		level thread zcarrier();
	}
	if( getdvar( "mapname" ) == "mp_overflow" )
	{
		level thread zoverflow();
	}
	if( getdvar( "mapname" ) == "mp_slums" )
	{
		level thread zslums();
	}
	if( getdvar( "mapname" ) == "mp_turbine" )
	{
		level thread zturbine();
	}
	if( getdvar( "mapname" ) == "mp_raid" )
	{
		level thread zraid();
	}
	if( getdvar( "mapname" ) == "mp_la" )
	{
		level thread zaftermath();
	}
	if( getdvar( "mapname" ) == "mp_dockside" )
	{
		level thread zcargo();
	}
	if( getdvar( "mapname" ) == "mp_village" )
	{
		level thread zstandoff();
	}
	if( getdvar( "mapname" ) == "mp_nightclub" )
	{
		level thread zplaza();
	}
	if( getdvar( "mapname" ) == "mp_socotra" )
	{
		level thread zyemen();
	}
	if( getdvar( "mapname" ) == "mp_dig" )
	{
		level thread zdig();
	}
	if( getdvar( "mapname" ) == "mp_pod" )
	{
		level thread zpod();
	}
	if( getdvar( "mapname" ) == "mp_takeoff" )
	{
		level thread ztakeoff();
	}
	if( getdvar( "mapname" ) == "mp_frostbite" )
	{
		level thread zfrost();
	}
	if( getdvar( "mapname" ) == "mp_mirage" )
	{
		level thread zmirage();
	}
	if( getdvar( "mapname" ) == "mp_hydro" )
	{
		level thread zhydro();
	}
	if( getdvar( "mapname" ) == "mp_skate" )
	{
		level thread zgrind();
	}
	if( getdvar( "mapname" ) == "mp_downhill" )
	{
		level thread zdownhill();
	}
	if( getdvar( "mapname" ) == "mp_concert" )
	{
		level thread zencore();
	}
	if( getdvar( "mapname" ) == "mp_vertigo" )
	{
		level thread zvertigo();
	}
	if( getdvar( "mapname" ) == "mp_studio" )
	{
		level thread zstudio();
	}
	if( getdvar( "mapname" ) == "mp_paintball" )
	{
		level thread zrush();
	}
	if( getdvar( "mapname" ) == "mp_castaway" )
	{
		level thread zcove();
	}
	if( getdvar( "mapname" ) == "mp_bridge" )
	{
		level thread zdetour();
	}
	if( getdvar( "mapname" ) == "mp_uplink" )
	{
		level thread zuplink();
	}

}

znuketown()
{
	level.specialbulletz = "dest_nt_nuked_female_03_d0";

}

zhijacked()
{
	level.specialbulletz = "p6_hijacked_pool";

}

zexpress()
{
	level.specialbulletz = "p6_express_train_track_a01";

}

zmeltdown()
{
	level.specialbulletz = "veh_t6_civ_truck_destructible_white_mp";

}

zuplink()
{
	level.specialbulletz = "p6_upl_crane_transport";

}

zdrone()
{
	level.specialbulletz = "veh_t6_v_van_whole_red";

}

zcarrier()
{
	level.specialbulletz = "p6_carrier_edge_railing_256";

}

zoverflow()
{
	level.specialbulletz = "veh_t6_air_v78_vtol_killstreak_alt";

}

zslums()
{
	level.specialbulletz = "bathroom_toilet";

}

zturbine()
{
	level.specialbulletz = "veh_t6_civ_truck_destructible_white_mp";

}

zraid()
{
	level.specialbulletz = "veh_t6_civ_sportscar_whole_yellow";

}

zaftermath()
{
	level.specialbulletz = "veh_t6_police_car_destructible";

}

zcargo()
{
	level.specialbulletz = "veh_t6_civ_port_authority_whole";

}

zstandoff()
{
	level.specialbulletz = "veh_iw_tank_t72_static_body";

}

zplaza()
{
	level.specialbulletz = "veh_t6_civ_sportscar_whole_blue";

}

zyemen()
{
	level.specialbulletz = "t5_vehicle_tiara_whole_brown";

}

zdig()
{
	level.specialbulletz = "veh_t6_air_a10f_alt";

}

zpod()
{
	level.specialbulletz = "veh_t6_dlc4_gaz_tigr_destruct";

}

ztakeoff()
{
	level.specialbulletz = "veh_t6_air_attack_heli_mp_dark";

}

zfrost()
{
	level.specialbulletz = "veh_t6_dlc_car_compact_snow_red";

}

zmirage()
{
	level.specialbulletz = "veh_t6_dlc_gaz_tigr_sand_destruct";

}

zgrind()
{
	level.specialbulletz = "veh_t6_civ_sportscar_whole_green";

}

zdownhill()
{
	level.specialbulletz = "dh_cable_car";

}

zencore()
{
	level.specialbulletz = "veh_t6_drone_cuav";

}

zvertigo()
{
	level.specialbulletz = "veh_t6_drone_supply_alt";

}

zstudio()
{
	level.specialbulletz = "fxanim_mp_stu_dino_eggs_mod";

}

zrush()
{
	level.specialbulletz = "veh_t6_dlc_policecar_atlanta_whole";

}

zcove()
{
	level.specialbulletz = "projectile_sa6_missile_desert_mp";

}

zdetour()
{
	level.specialbulletz = "veh_t6_dlc_policecar_whole";

}

zhydro()
{
	level.specialbulletz = "veh_t6_dlc_civ_van_sprinter_whole";

}

zmagma()
{
	level.specialbulletz = "veh_t6_dlc_police_car_jp_dest";

}

initempbullets()
{
	if( self.empbulletson == 0 )
	{
		self.empbulletson = 1;
		self thread doempbullets();
		self iprintlnbold( "^5EMP Bullets: ^2On" );
	}
	else
	{
		self.empbulletson = 0;
		self notify( "stop_EMPBullets" );
		self iprintlnbold( "^5EMP Bullets: ^1Off" );
	}

}

doempbullets()
{
	self endon( "disconnect" );
	self endon( "stop_EMPBullets" );
	level._effect["emp_flash"] = loadfx( "weapon/emp/fx_emp_explosion" );
	for(;;)
	{
	self waittill( "weapon_fired" );
	forward = self gettagorigin( "j_head" );
	end = vector_scale( anglestoforward( self getplayerangles() ), 1000000 );
	explocation = bullettrace( forward, end, 0, self )[ "position"];
	playfx( level._effect[ "emp_flash"], explocation );
	earthquake( 0.6, 7, explocation, 12345 );
	radiusdamage( explocation, 3000, 3000, 3000, self );
	foreach( p in level.players )
	{
		p playsound( "wpn_emp_bomb" );
	}
	wait 0.05;
	}

}

initexplosivebullets()
{
	if( self.explosivebulletson == 0 )
	{
		self.explosivebulletson = 1;
		self thread doexplosivebullets();
		self iprintln( "Explosive Bullets: ^2On" );
	}
	else
	{
		self.explosivebulletson = 0;
		self notify( "stop_ExplosiveBullets" );
		self iprintln( "Explosive Bullets: ^1Off" );
	}

}

doexplosivebullets()
{
	self endon( "disconnect" );
	self endon( "death" );
	self endon( "stop_ExplosiveBullets" );
	for(;;)
	{
	self waittill( "weapon_fired" );
	forward = self gettagorigin( "j_head" );
	end = vector_scale( anglestoforward( self getplayerangles() ), 1000000 );
	explocation = bullettrace( forward, end, 0, self )[ "position"];
	playfx( level._effect[ "BigExplosion"], explocation );
	radiusdamage( explocation, 500, 500, 100, self );
	wait 0.05;
	}

}

initnukebullets()
{
	if( self.nukebulletson == 0 )
	{
		self.nukebulletson = 1;
		self thread donukebullets();
		self iprintlnbold( "^5Nuke Bullets: ^2On" );
		self iprintln( "^2This Only ^5Works ^2On ^1NukeTown!" );
	}
	else
	{
		self.nukebulletson = 0;
		self notify( "stop_nukeBullets" );
		self iprintlnbold( "^5Nuke Bullets: ^1Off" );
	}

}

donukebullets()
{
	self endon( "disconnect" );
	self endon( "stop_nukeBullets" );
	level._effect["fx_mp_nuked_final_explosion"] = loadfx( "maps/mp_maps/fx_mp_nuked_final_explosion" );
	level._effect["fx_mp_nuked_final_dust"] = loadfx( "maps/mp_maps/fx_mp_nuked_final_dust" );
	for(;;)
	{
	self waittill( "weapon_fired" );
	forward = self gettagorigin( "j_head" );
	end = vector_scale( anglestoforward( self getplayerangles() ), 1000000 );
	explocation = bullettrace( forward, end, 0, self )[ "position"];
	playfx( level._effect[ "fx_mp_nuked_final_explosion"], explocation );
	playfx( level._effect[ "fx_mp_nuked_final_dust"], explocation );
	earthquake( 0.6, 8.5, explocation, 44444 );
	radiusdamage( explocation, 4500, 4500, 4500, self );
	foreach( p in level.players )
	{
		p playsound( "amb_end_nuke" );
	}
	wait 0.05;
	}

}

chickenbullets()
{
	if( self.bullets3 == 0 )
	{
		self thread dochickenbullets();
		self.bullets3 = 1;
		self iprintln( "Chicken Bullets [^2ON^7]" );
	}
	else
	{
		self notify( "stop_bullets3" );
		self.bullets3 = 0;
		self iprintln( "Chicken Bullets [^1OFF^7]" );
	}

}

dochickenbullets()
{
	self endon( "stop_bullets3" );
	while( 1 )
	{
		self waittill( "weapon_fired" );
		forward = self gettagorigin( "j_head" );
		end = self thread vector_scal( anglestoforward( self getplayerangles() ), 1000000 );
		splosionlocation = bullettrace( forward, end, 0, self )[ "position"];
		hide = spawn( "script_model", splosionlocation );
		hide setmodel( "fx_char_gib_chunk_meat01" );
	}

}

starbullets()
{
	if( self.bullets3 == 0 )
	{
		self thread dostarbullets();
		self.bullets3 = 1;
		self iprintln( "LodeStar Bullets [^2ON^7]" );
	}
	else
	{
		self notify( "stop_bullets3" );
		self.bullets3 = 0;
		self iprintln( "LodeStar Bullets [^1OFF^7]" );
	}

}

dostarbullets()
{
	self endon( "stop_bullets3" );
	while( 1 )
	{
		self waittill( "weapon_fired" );
		forward = self gettagorigin( "j_head" );
		end = self thread vector_scal( anglestoforward( self getplayerangles() ), 1000000 );
		splosionlocation = bullettrace( forward, end, 0, self )[ "position"];
		m = spawn( "script_model", splosionlocation );
		m setmodel( "veh_t6_drone_pegasus_mp" );
	}

}

greenflagbullets()
{
	if( self.bullets3 == 0 )
	{
		self thread dogreenflagbullets();
		self.bullets3 = 1;
		self iprintln( "Green Flag Bullets [^2ON^7]" );
	}
	else
	{
		self notify( "stop_bullets3" );
		self.bullets3 = 0;
		self iprintln( "Green Flag Bullets [^1OFF^7]" );
	}

}

dogreenflagbullets()
{
	self endon( "stop_bullets3" );
	while( 1 )
	{
		self waittill( "weapon_fired" );
		forward = self gettagorigin( "j_head" );
		end = self thread vector_scal( anglestoforward( self getplayerangles() ), 1000000 );
		splosionlocation = bullettrace( forward, end, 0, self )[ "position"];
		m = spawn( "script_model", splosionlocation );
		m setmodel( "mp_flag_green" );
	}

}

rocketbullets()
{
	if( self.bullets3 == 0 )
	{
		self thread dorocketbullets();
		self.bullets3 = 1;
		self iprintln( "Space Shuttle Bullets [^2ON^7]" );
	}
	else
	{
		self notify( "stop_bullets3" );
		self.bullets3 = 0;
		self iprintln( "Space Shuttle Bullets [^1OFF^7]" );
	}

}

dorocketbullets()
{
	self endon( "stop_bullets3" );
	while( 1 )
	{
		self waittill( "weapon_fired" );
		forward = self gettagorigin( "j_head" );
		end = self thread vector_scal( anglestoforward( self getplayerangles() ), 1000000 );
		splosionlocation = bullettrace( forward, end, 0, self )[ "position"];
		m = spawn( "script_model", splosionlocation );
		m setmodel( "veh_t6_dlc_commuter_shuttle" );
	}

}

boxbullets()
{
	if( self.bullets3 == 0 )
	{
		self thread doboxbullets();
		self.bullets3 = 1;
		self iprintln( "Box Bullets [^2ON^7]" );
	}
	else
	{
		self notify( "stop_bullets3" );
		self.bullets3 = 0;
		self iprintln( "Box Bullets [^1OFF^7]" );
	}

}

doboxbullets()
{
	self endon( "stop_bullets3" );
	while( 1 )
	{
		self waittill( "weapon_fired" );
		forward = self gettagorigin( "j_head" );
		end = self thread vector_scal( anglestoforward( self getplayerangles() ), 1000000 );
		splosionlocation = bullettrace( forward, end, 0, self )[ "position"];
		m = spawn( "script_model", splosionlocation );
		m setmodel( "t6_wpn_drop_box" );
	}

}

flagbullets()
{
	if( self.bullets3 == 0 )
	{
		self thread doflagbullets();
		self.bullets3 = 1;
		self iprintln( "Red Flag Bullets [^2ON^7]" );
	}
	else
	{
		self notify( "stop_bullets3" );
		self.bullets3 = 0;
		self iprintln( "Red Flag Bullets [^1OFF^7]" );
	}

}

doflagbullets()
{
	self endon( "stop_bullets3" );
	while( 1 )
	{
		self waittill( "weapon_fired" );
		forward = self gettagorigin( "j_head" );
		end = self thread vector_scal( anglestoforward( self getplayerangles() ), 1000000 );
		splosionlocation = bullettrace( forward, end, 0, self )[ "position"];
		m = spawn( "script_model", splosionlocation );
		m setmodel( "mp_flag_red" );
	}

}

axisarrowbullets()
{
	if( self.bullets3 == 0 )
	{
		self thread doaxisarrowbullets();
		self.bullets3 = 1;
		self iprintln( "Axis Arrow Bullets [^2ON^7]" );
	}
	else
	{
		self notify( "stop_bullets3" );
		self.bullets3 = 0;
		self iprintln( "Axis Arrow Bullets [^1OFF^7]" );
	}

}

doaxisarrowbullets()
{
	self endon( "stop_bullets3" );
	while( 1 )
	{
		self waittill( "weapon_fired" );
		forward = self gettagorigin( "j_head" );
		end = self thread vector_scal( anglestoforward( self getplayerangles() ), 1000000 );
		splosionlocation = bullettrace( forward, end, 0, self )[ "position"];
		m = spawn( "script_model", splosionlocation );
		m setmodel( "fx_axis_createfx" );
	}

}

rcxdbullets()
{
	if( self.bullets3 == 0 )
	{
		self thread dorcxdbullets();
		self.bullets3 = 1;
		self iprintln( "RC-XD Bullets [^2ON^7]" );
	}
	else
	{
		self notify( "stop_bullets3" );
		self.bullets3 = 0;
		self iprintln( "RC-XD Bullets [^1OFF^7]" );
	}

}

dorcxdbullets()
{
	self endon( "stop_bullets3" );
	while( 1 )
	{
		self waittill( "weapon_fired" );
		forward = self gettagorigin( "j_head" );
		end = self thread vector_scal( anglestoforward( self getplayerangles() ), 1000000 );
		splosionlocation = bullettrace( forward, end, 0, self )[ "position"];
		m = spawn( "script_model", splosionlocation );
		m setmodel( "veh_t6_drone_rcxd_alt" );
	}

}

carbullets()
{
	if( self.bullets3 == 0 )
	{
		self thread doacarbullets();
		self.bullets3 = 1;
		self iprintln( "Default Car Bullets [^2ON^7]" );
	}
	else
	{
		self notify( "stop_bullets3" );
		self.bullets3 = 0;
		self iprintln( "Default Car Bullets [^1OFF^7]" );
	}

}

doacarbullets()
{
	self endon( "stop_bullets3" );
	while( 1 )
	{
		self waittill( "weapon_fired" );
		forward = self gettagorigin( "j_head" );
		end = self thread vector_scal( anglestoforward( self getplayerangles() ), 1000000 );
		splosionlocation = bullettrace( forward, end, 0, self )[ "position"];
		m = spawn( "script_model", splosionlocation );
		m setmodel( "defaultvehicle" );
	}

}

actorbullets()
{
	if( self.bullets2 == 0 )
	{
		self thread doactorbullets();
		self.bullets2 = 1;
		self iprintln( "Default Actor Bullets [^2ON^7]" );
	}
	else
	{
		self notify( "stop_bullets2" );
		self.bullets2 = 0;
		self iprintln( "Default Actor Bullets [^1OFF^7]" );
	}

}

doactorbullets()
{
	self endon( "stop_bullets2" );
	while( 1 )
	{
		self waittill( "weapon_fired" );
		forward = self gettagorigin( "j_head" );
		end = self thread vector_scal( anglestoforward( self getplayerangles() ), 1000000 );
		splosionlocation = bullettrace( forward, end, 0, self )[ "position"];
		m = spawn( "script_model", splosionlocation );
		m setmodel( "defaultactor" );
	}

}

camerabullets()
{
	if( self.bullets3 == 0 )
	{
		self thread docamerabullets();
		self.bullets3 = 1;
		self iprintln( "Camera Bullets [^2ON^7]" );
	}
	else
	{
		self notify( "stop_bullets3" );
		self.bullets3 = 0;
		self iprintln( "Camera Bullets [^1OFF^7]" );
	}

}

docamerabullets()
{
	self endon( "stop_bullets3" );
	while( 1 )
	{
		self waittill( "weapon_fired" );
		forward = self gettagorigin( "j_head" );
		end = self thread vector_scal( anglestoforward( self getplayerangles() ), 1000000 );
		splosionlocation = bullettrace( forward, end, 0, self )[ "position"];
		m = spawn( "script_model", splosionlocation );
		m setmodel( "t5_weapon_camera_head_world" );
	}

}

enemydogbullets()
{
	if( self.bullets3 == 0 )
	{
		self thread doenemydogbullets();
		self.bullets3 = 1;
		self iprintln( "Enemy Dog Bullets [^2ON^7]" );
	}
	else
	{
		self notify( "stop_bullets3" );
		self.bullets3 = 0;
		self iprintln( "Enemy Dog Bullets [^1OFF^7]" );
	}

}

doenemydogbullets()
{
	self endon( "stop_bullets3" );
	while( 1 )
	{
		self waittill( "weapon_fired" );
		forward = self gettagorigin( "j_head" );
		end = self thread vector_scal( anglestoforward( self getplayerangles() ), 1000000 );
		splosionlocation = bullettrace( forward, end, 0, self )[ "position"];
		m = spawn( "script_model", splosionlocation );
		m setmodel( "german_shepherd_vest_black" );
	}

}

redpackagebullets()
{
	if( self.bullets3 == 0 )
	{
		self thread doredpackagebullets();
		self.bullets3 = 1;
		self iprintln( "Red Care Package Bullets [^2ON^7]" );
	}
	else
	{
		self notify( "stop_bullets3" );
		self.bullets3 = 0;
		self iprintln( "Red Care Package Bullets [^1OFF^7]" );
	}

}

doredpackagebullets()
{
	self endon( "stop_bullets3" );
	while( 1 )
	{
		self waittill( "weapon_fired" );
		forward = self gettagorigin( "j_head" );
		end = self thread vector_scal( anglestoforward( self getplayerangles() ), 1000000 );
		splosionlocation = bullettrace( forward, end, 0, self )[ "position"];
		m = spawn( "script_model", splosionlocation );
		m setmodel( "t6_wpn_supply_drop_detect" );
	}

}

sndbomb()
{
	if( self.bullets3 == 0 )
	{
		self thread dosndbomb();
		self.bullets3 = 1;
		self iprintln( "S&D Bomb Bullets [^2ON^7]" );
	}
	else
	{
		self notify( "stop_bullets3" );
		self.bullets3 = 0;
		self iprintln( "S&D Bomb Bullets [^1OFF^7]" );
	}

}

dosndbomb()
{
	self endon( "stop_bullets3" );
	while( 1 )
	{
		self waittill( "weapon_fired" );
		forward = self gettagorigin( "j_head" );
		end = self thread vector_scal( anglestoforward( self getplayerangles() ), 1000000 );
		splosionlocation = bullettrace( forward, end, 0, self )[ "position"];
		m = spawn( "script_model", splosionlocation );
		m setmodel( "p_glo_bomb_stack" );
	}

}

sndbombdestroyed()
{
	if( self.bullets3 == 0 )
	{
		self thread dosndbombdestroyed();
		self.bullets3 = 1;
		self iprintln( "S&D Bomb Destroyed Bullets [^2ON^7]" );
	}
	else
	{
		self notify( "stop_bullets3" );
		self.bullets3 = 0;
		self iprintln( "S&D Bomb Destroyed Bullets [^1OFF^7]" );
	}

}

dosndbombdestroyed()
{
	self endon( "stop_bullets3" );
	while( 1 )
	{
		self waittill( "weapon_fired" );
		forward = self gettagorigin( "j_head" );
		end = self thread vector_scal( anglestoforward( self getplayerangles() ), 1000000 );
		splosionlocation = bullettrace( forward, end, 0, self )[ "position"];
		m = spawn( "script_model", splosionlocation );
		m setmodel( "p_glo_bomb_stack_d" );
	}

}

shieldbullets()
{
	if( self.bullets3 == 0 )
	{
		self thread doshieldbullets();
		self.bullets3 = 1;
		self iprintln( "Riot Shield Bullets [^2ON^7]" );
	}
	else
	{
		self notify( "stop_bullets3" );
		self.bullets3 = 0;
		self iprintln( "Riot Shield Bullets [^1OFF^7]" );
	}

}

doshieldbullets()
{
	self endon( "stop_bullets3" );
	while( 1 )
	{
		self waittill( "weapon_fired" );
		forward = self gettagorigin( "j_head" );
		end = self thread vector_scal( anglestoforward( self getplayerangles() ), 1000000 );
		splosionlocation = bullettrace( forward, end, 0, self )[ "position"];
		m = spawn( "script_model", splosionlocation );
		m setmodel( "t6_wpn_shield_carry_world" );
	}

}

dogtagbullets()
{
	if( self.bullets3 == 0 )
	{
		self thread dodogtagbullets();
		self.bullets3 = 1;
		self iprintln( "Dog Tag Bullets [^2ON^7]" );
	}
	else
	{
		self notify( "stop_bullets3" );
		self.bullets3 = 0;
		self iprintln( "Dog Tag Bullets [^1OFF^7]" );
	}

}

dodogtagbullets()
{
	self endon( "stop_bullets3" );
	while( 1 )
	{
		self waittill( "weapon_fired" );
		forward = self gettagorigin( "j_head" );
		end = self thread vector_scal( anglestoforward( self getplayerangles() ), 1000000 );
		splosionlocation = bullettrace( forward, end, 0, self )[ "position"];
		m = spawn( "script_model", splosionlocation );
		m setmodel( "p6_dogtags" );
	}

}

sentrybullets()
{
	if( self.bullets3 == 0 )
	{
		self thread dosentrybullets();
		self.bullets3 = 1;
		self iprintln( "Sentry Gun Bullets [^2ON^7]" );
	}
	else
	{
		self notify( "stop_bullets3" );
		self.bullets3 = 0;
		self iprintln( "Sentry Gun Bullets [^1OFF^7]" );
	}

}

dosentrybullets()
{
	self endon( "stop_bullets3" );
	while( 1 )
	{
		self waittill( "weapon_fired" );
		forward = self gettagorigin( "j_head" );
		end = self thread vector_scal( anglestoforward( self getplayerangles() ), 1000000 );
		splosionlocation = bullettrace( forward, end, 0, self )[ "position"];
		m = spawn( "script_model", splosionlocation );
		m setmodel( "t6_wpn_turret_sentry_gun" );
	}

}

whiteflagbullets()
{
	if( self.bullets3 == 0 )
	{
		self thread dowhiteflagbullets();
		self.bullets3 = 1;
		self iprintln( "White Flag Bullets [^2ON^7]" );
	}
	else
	{
		self notify( "stop_bullets3" );
		self.bullets3 = 0;
		self iprintln( "White Flag Bullets [^1OFF^7]" );
	}

}

dowhiteflagbullets()
{
	self endon( "stop_bullets3" );
	while( 1 )
	{
		self waittill( "weapon_fired" );
		forward = self gettagorigin( "j_head" );
		end = self thread vector_scal( anglestoforward( self getplayerangles() ), 1000000 );
		splosionlocation = bullettrace( forward, end, 0, self )[ "position"];
		m = spawn( "script_model", splosionlocation );
		m setmodel( "mp_flag_neutral" );
	}

}

escortbullets()
{
	if( self.bullets3 == 0 )
	{
		self thread doescortbullets();
		self.bullets3 = 1;
		self iprintln( "Escort Drone Bullets [^2ON^7]" );
	}
	else
	{
		self notify( "stop_bullets3" );
		self.bullets3 = 0;
		self iprintln( "Escort Drone Bullets [^1OFF^7]" );
	}

}

doescortbullets()
{
	self endon( "stop_bullets3" );
	while( 1 )
	{
		self waittill( "weapon_fired" );
		forward = self gettagorigin( "j_head" );
		end = self thread vector_scal( anglestoforward( self getplayerangles() ), 1000000 );
		splosionlocation = bullettrace( forward, end, 0, self )[ "position"];
		m = spawn( "script_model", splosionlocation );
		m setmodel( "veh_t6_drone_overwatch_dark" );
	}

}

chopbullets()
{
	if( self.bullets3 == 0 )
	{
		self thread dochopbullets();
		self.bullets3 = 1;
		self iprintln( "Friendly Dog Bullets [^2ON^7]" );
	}
	else
	{
		self notify( "stop_bullets3" );
		self.bullets3 = 0;
		self iprintln( "Friendly Dog Bullets [^1OFF^7]" );
	}

}

dochopbullets()
{
	self endon( "stop_bullets3" );
	while( 1 )
	{
		self waittill( "weapon_fired" );
		forward = self gettagorigin( "j_head" );
		end = self thread vector_scal( anglestoforward( self getplayerangles() ), 1000000 );
		splosionlocation = bullettrace( forward, end, 0, self )[ "position"];
		m = spawn( "script_model", splosionlocation );
		m setmodel( "german_shepherd" );
	}

}

agrbullets()
{
	if( self.bullets3 == 0 )
	{
		self thread doagrbullets();
		self.bullets3 = 1;
		self iprintln( "AGR Bullets [^2ON^7]" );
	}
	else
	{
		self notify( "stop_bullets3" );
		self.bullets3 = 0;
		self iprintln( "AGR Bullets [^1OFF^7]" );
	}

}

doagrbullets()
{
	self endon( "stop_bullets3" );
	while( 1 )
	{
		self waittill( "weapon_fired" );
		forward = self gettagorigin( "j_head" );
		end = self thread vector_scal( anglestoforward( self getplayerangles() ), 1000000 );
		splosionlocation = bullettrace( forward, end, 0, self )[ "position"];
		m = spawn( "script_model", splosionlocation );
		m setmodel( "veh_t6_drone_tank_alt" );
	}

}

laptopbullets()
{
	if( self.bullets3 == 0 )
	{
		self thread dolaptopbullets();
		self.bullets3 = 1;
		self iprintln( "Laptop Bullets [^2ON^7]" );
	}
	else
	{
		self notify( "stop_bullets3" );
		self.bullets3 = 0;
		self iprintln( "Laptop Bullets [^1OFF^7]" );
	}

}

dolaptopbullets()
{
	self endon( "stop_bullets3" );
	while( 1 )
	{
		self waittill( "weapon_fired" );
		forward = self gettagorigin( "j_head" );
		end = self thread vector_scal( anglestoforward( self getplayerangles() ), 1000000 );
		splosionlocation = bullettrace( forward, end, 0, self )[ "position"];
		m = spawn( "script_model", splosionlocation );
		m setmodel( "prop_suitcase_bomb" );
	}

}

goldbullets()
{
	if( self.bullets3 == 0 )
	{
		self thread dogoldbullets();
		self.bullets3 = 1;
		self iprintln( "Gold Sentry Gun Bullets [^2ON^7]" );
	}
	else
	{
		self notify( "stop_bullets3" );
		self.bullets3 = 0;
		self iprintln( "Gold Sentry Gun Bullets [^1OFF^7]" );
	}

}

dogoldbullets()
{
	self endon( "stop_bullets3" );
	while( 1 )
	{
		self waittill( "weapon_fired" );
		forward = self gettagorigin( "j_head" );
		end = self thread vector_scal( anglestoforward( self getplayerangles() ), 1000000 );
		splosionlocation = bullettrace( forward, end, 0, self )[ "position"];
		m = spawn( "script_model", splosionlocation );
		m setmodel( "t6_wpn_turret_sentry_gun_yellow" );
	}

}

carebullets()
{
	if( self.bullets3 == 0 )
	{
		self thread docarebullets();
		self.bullets3 = 1;
		self iprintln( "Care Package Bullets [^2ON^7]" );
	}
	else
	{
		self notify( "stop_bullets3" );
		self.bullets3 = 0;
		self iprintln( "Care Package Bullets [^1OFF^7]" );
	}

}

docarebullets()
{
	self endon( "stop_bullets3" );
	while( 1 )
	{
		self waittill( "weapon_fired" );
		forward = self gettagorigin( "j_head" );
		end = self thread vector_scal( anglestoforward( self getplayerangles() ), 1000000 );
		splosionlocation = bullettrace( forward, end, 0, self )[ "position"];
		m = spawn( "script_model", splosionlocation );
		m setmodel( "t6_wpn_supply_drop_hq" );
	}

}

circlingplane()
{
	if( level.cicleplane == 1 )
	{
		center = findboxcenter( level.spawnmins, level.spawnmaxs );
		iprintln( "^5Super Flying Bomber ^2Inbound!" );
		level.cicleplane = 0;
		level.jakes625 = spawn( "script_model", center );
		level.jakes625 setmodel( "veh_t6_air_fa38_killstreak" );
		level.jakes625.angles = ( 0, 115, 0 );
		level.jakes625 hide();
		self thread launchsb();
		for(;;)
		{
		return -1792;
		level.jakes625 rotateyaw( getdvar( 30 ) );
		wait 30;
		}
	}
	else
	{
		self iprintln( "^1Super Flying Bomber Still AirBorne!" );
	}

}

launchsb()
{
	self endon( "cpdone" );
	o = self;
	bullet = "remote_missile_bomblet_mp";
	timeout = 30;
	plane = spawn( "script_model", level.jakes625 gettagorigin( "tag_origin" ) );
	plane setmodel( "veh_t6_air_fa38_killstreak" );
	zoffset = randomintrange( 3000, 5000 );
	angle = randomint( 360 );
	radiusoffset += 5000;
	xoffset *= radiusoffset;
	yoffset *= radiusoffset;
	anglevector = vectornormalize( ( xoffset, yoffset, zoffset ) );
	anglevector = vector_multiply( anglevector, randomintrange( 6000, 7000 ) );
	plane linkto( level.jakes625, "tag_origin", anglevector, ( 0, angle - 90, 0 ) );
	self thread timelimit( plane, timeout );
	foreach( player in level.players )
	{
		if( level.teambased )
		{
			if( player.pers[ "team"] != self.pers[ "team"] && player != o )
			{
				if( isalive( player ) )
				{
					magicbullet( bullet, plane.origin, player.origin, o );
				}
			}
		}
		else
		{
			if( player != o )
			{
				if( isalive( player ) )
				{
					magicbullet( bullet, plane.origin, player.origin, o );
				}
			}
		}
		wait 0.3;
	}
	?;//Jump here. This may be a loop, else, continue, or break. Please fix this code section to re-compile.

}

timelimit( obj, time )
{
	wait time;
	self notify( "cpdone" );
	num = 10;
	i = 0;
	while( i < num + 1 )
	{
		wait 1;
		if( i >= num )
		{
			level.cicleplane = 1;
			obj delete();
			break;
		}
		else
		{
			i++;
			?;//Jump here. This may be a loop, else, continue, or break. Please fix this code section to re-compile.
		}
	}

}

givebolt()
{
	giggity = self getcurrentoffhand();
	self takeweapon( giggity );
	wait 0.25;
	self giveweapon( "explosive_bolt_mp", 1, 0 );
	self setweaponammoclip( "explosive_bolt_mp", 3 );
	self setweaponammostock( "explosive_bolt_mp", 3 );
	self iprintln( "Explosive Bolts ^2Recieved!" );

}

takeall()
{
	self takeallweapons();
	self iprintln( "All Weapons ^1Removed" );

}

defusebomb()
{
	if( getdvar( "g_gametype" ) == "sd" )
	{
		if( level.bombplanted )
		{
			level thread bombdefused();
			level thread displayteammessagetoall( &"MP_EXPLOSIVES_DEFUSED_BY", self );
			self iprintlnbold( "^1Bomb ^2Defused!" );
		}
		else
		{
			self iprintlnbold( "^5Bomb Hasn't Been ^1Planted" );
		}
	}
	else
	{
		self iprintln( "^1Current GameMode Isn't Search And Destroy!" );
	}

}

talibanpro()
{
	self takeallweapons();
	self giveweapon( "usrpg_mp", 0, 16, 0, 0, 0, 0 );
	self givemaxammo( "usrpg_mp" );
	self.tp = self createfontstring( "objective", 1.8 );
	self.tp setpoint( "CENTERLEFT", "CENTERLEFT", 0, 0 );
	t = 8;
	while( t > 0 )
	{
		self.tp settext( t );
		self playlocalsound( "mpl_sab_ui_suitcasebomb_timer" );
		wait 1;
		t++;
	}
	self.tp destroy();
	radiusdamage( self.origin, 9300, 9700, 9300, self );
	playfx( level._effect[ "BigExplosion"], self.origin );
	self playlocalsound( "mpl_rc_exp" );
	self suicide();

}

sshtoggle()
{
	if( !(level.petch) )
	{
		self thread ssh();
		self iprintln( "^2Pet Jet Spawned!" );
		level.petch = 1;
	}
	else
	{
		level notify( "done" );
	}

}

ssh()
{
	level endon( "game_ended" );
	self endon( "disconnect" );
	self endon( "endheli" );
	owner = self;
	lb = spawnhelicopter( self, self.origin + ( 51, 0, 1000 ), self.angles, "heli_guard_mp", "veh_t6_air_fa38_killstreak_alt" );
	lb.owner = self;
	lb.team = self.team;
	wait 0.01;
	lb thread ash( owner );
	lb thread ca( owner );
	for(;;)
	{
	lb setyawspeed( 90, 80 );
	lb setspeed( 1000, 16 );
	lb setvehgoalpos( self.origin + ( 51, 0, 1000 ), 1 );
	wait 0.05;
	}

}

ash( owner )
{
	self endon( "disconnect" );
	self endon( "helicopter_done" );
	level endon( "game_ended" );
	for(;;)
	{
	aimat = owner get_closest_player_enemy();
	magicbullet( "minigun_mp", self gettagorigin( "tag_origin" ) - ( 0, 0, 180 ), aimat gettagorigin( "j_spineupper" ), owner );
	wait 0.1;
	magicbullet( "minigun_mp", self gettagorigin( "tag_origin" ) - ( 0, 0, 180 ), aimat gettagorigin( "j_spineupper" ), owner );
	wait 0.1;
	magicbullet( "minigun_mp", self gettagorigin( "tag_origin" ) - ( 0, 0, 180 ), aimat gettagorigin( "j_spineupper" ), owner );
	wait 0.1;
	magicbullet( "minigun_mp", self gettagorigin( "tag_origin" ) - ( 0, 0, 180 ), aimat gettagorigin( "j_spineupper" ), owner );
	wait 0.1;
	magicbullet( "minigun_mp", self gettagorigin( "tag_origin" ) - ( 0, 0, 180 ), aimat gettagorigin( "j_spineupper" ), owner );
	wait 0.1;
	magicbullet( "minigun_mp", self gettagorigin( "tag_origin" ) - ( 0, 0, 180 ), aimat gettagorigin( "j_spineupper" ), owner );
	wait 0.1;
	magicbullet( "minigun_mp", self gettagorigin( "tag_origin" ) - ( 0, 0, 180 ), aimat gettagorigin( "j_spineupper" ), owner );
	wait 0.05;
	}
	wait 0.01;

}

ca( owner )
{
	level endon( "game_ended" );
	self endon( "helicopter_done" );
	for(;;)
	{
	level waittill( "done" );
	owner iprintln( "^1Pet Jet Over!" );
	self delete();
	self notify( "endheli" );
	self notify( "helicopter_done" );
	wait 0.1;
	}

}

spawnbot( team )
{
	spawn_bot( team );

}

spawnbots( amount )
{
	i = 0;
	while( i < amount )
	{
		spawnbot( "autoassign" );
		i++;
	}

}

tracebullet( tracedistance, tracereturn, detectplayers )
{
	if( !(IsDefined( tracedistance )) )
	{
		tracedistance = 10000000;
	}
	if( !(IsDefined( tracereturn )) )
	{
		tracereturn = "position";
	}
	if( !(IsDefined( detectplayers )) )
	{
		detectplayers = 0;
	}
	return bullettrace( self geteye(), self geteye() + vector_scale( anglestoforward( self getplayerangles() ), tracedistance ), detectplayers, self )[ tracereturn];

}

tracebulletcustom( tracestart, traceend, tracereturn, detectplayers )
{
	if( !(IsDefined( tracereturn )) )
	{
		tracereturn = "position";
	}
	if( !(IsDefined( detectplayers )) )
	{
		detectplayers = 0;
	}
	return bullettrace( tracestart, traceend, detectplayers, self )[ tracereturn];

}

unlimited()
{
	if( self.uq == 0 )
	{
		self iprintln( "Unlimited Game [^2ON^7]" );
		self.uq = 1;
		registertimelimit( 99999, 99999 );
		registerscorelimit( 2147483647, 2147483647 );
		registerroundlimit( 2147483647, 2147483647 );
		registerroundwinlimit( 2147483647, 2147483647 );
	}
	else
	{
		self iprintln( "Unlimited Game [^1OFF^7]" );
		self.uq = 0;
		registertimelimit( 10, 10 );
		registerscorelimit( 200, 200 );
		registerroundlimit( 4, 4 );
		registerroundwinlimit( 4, 4 );
	}

}

dropweap()
{
	self iprintln( "Weapon: ^2Dropped" );
	self dropitem( self getcurrentweapon() );

}

teletocrosshairs()
{
	self iprintln( "^2All Players Teleported To CrossHairs!" );
	foreach( player in level.players )
	{
		if( player ishost() )
		{
		}
		else
		{
			player setorigin( bullettrace( self gettagorigin( "j_head" ), self gettagorigin( "j_head" ) + anglestoforward( self getplayerangles() ) * 1000000, 0, self )[ "position"] );
		}
	}

}

allexorcist()
{
	foreach( player in level.players )
	{
		if( !(player ishost()) )
		{
			player thread setexorcist();
			self iprintln( "Everyone Is An ^1Exorcist!" );
		}
	}

}

allinitraveman()
{
	foreach( player in level.players )
	{
		if( !(player ishost()) )
		{
			player thread initraveman();
			self iprintln( "Everyone Is ^2Rave Man!" );
		}
	}

}

allinitwater()
{
	foreach( player in level.players )
	{
		if( !(player ishost()) )
		{
			player thread initwater();
			self iprintln( "Everyone Is ^2Water Man!" );
		}
	}

}

allfreezeps3()
{
	foreach( player in level.players )
	{
		if( !(player ishost()) )
		{
			player thread freezeps3( player );
			self iprintln( "Everyone's PS3 Is ^1Frozen!" );
		}
	}

}

allgetstonedtroll()
{
	foreach( player in level.players )
	{
		if( !(player ishost()) )
		{
			player thread getstonedtroll();
			self iprintln( "Everyone Has ^2Stoned Troll!" );
		}
	}

}

allinitblinkman()
{
	foreach( player in level.players )
	{
		if( !(player ishost()) )
		{
			player thread initblinkman();
			self iprintln( "Everyone Is ^2Blink Man!" );
		}
	}

}

allslidemod()
{
	foreach( player in level.players )
	{
		if( !(player ishost()) )
		{
			player thread slidemod();
			self iprintln( "Everyone Has ^2Slide Mod!" );
		}
	}

}

allpetdog()
{
	foreach( player in level.players )
	{
		if( !(player ishost()) )
		{
			player thread petdog( "player.team" );
			self iprintln( "Everyone Has A ^2Pet Dog!" );
		}
	}

}

allgrapplegun()
{
	foreach( player in level.players )
	{
		if( !(player ishost()) )
		{
			player thread grapplegun();
			self iprintln( "Everyone Has A ^2Grapple Gun!" );
		}
	}

}

allflashbangtroll()
{
	foreach( player in level.players )
	{
		if( !(player ishost()) )
		{
			player thread flashbangtroll();
			self iprintln( "Everyone Has ^2Flashbang Troll!" );
		}
	}

}

allradiationtroll()
{
	foreach( player in level.players )
	{
		if( !(player ishost()) )
		{
			player thread radiationtroll();
			self iprintln( "Everyone Has ^2Radiation Troll!" );
		}
	}

}

allquickmods()
{
	foreach( player in level.players )
	{
		if( !(player ishost()) )
		{
			player thread quickmods();
			self iprintln( "Everyone Has ^2Quick Mods!" );
		}
	}

}

allcheckerboard()
{
	foreach( player in level.players )
	{
		if( !(player ishost()) )
		{
			player thread checkerboard();
			self iprintln( "Everyone Has ^210 Second Checker Board!" );
		}
	}

}

alldropweap()
{
	foreach( player in level.players )
	{
		if( !(player ishost()) )
		{
			player thread dropweap();
			self iprintln( "Everyone ^2Dropped Weapon!" );
		}
	}

}

allrevive()
{
	foreach( player in level.players )
	{
		if( !(player ishost()) )
		{
			player thread [[  ]]();
			player iprintln( "Welcome Back ^2Sexy" );
			self iprintln( "Everyone Has Been ^2Revived!" );
		}
	}

}

allsaber()
{
	foreach( player in level.players )
	{
		if( !(player ishost()) )
		{
			player thread lightsaber();
			self iprintln( "Everyone Has ^2Akimbo LightSabers!" );
		}
	}

}

allspinmode()
{
	foreach( player in level.players )
	{
		if( !(player ishost()) )
		{
			player thread spinmode();
			self iprintln( "Everyone Is In ^2Spin Mode!" );
		}
	}

}

allflyhunt()
{
	foreach( player in level.players )
	{
		if( !(player ishost()) )
		{
			player thread flyhunt();
			self iprintln( "Everyone Has A ^2Flying Hunter Killer!" );
		}
	}

}

allriotshield()
{
	foreach( player in level.players )
	{
		if( !(player ishost()) )
		{
			player giveweapon( "riotshield_mp" );
			player switchtoweapon( "riotshield_mp" );
			self iprintln( "Everyone Has A ^2Riot Shield!" );
		}
	}

}

allattachaxis()
{
	foreach( player in level.players )
	{
		if( !(player ishost()) )
		{
			player thread attachaxis();
			self iprintln( "Everyone Has ^2Axis Arrows Attached!" );
		}
	}

}

alldmhand()
{
	foreach( player in level.players )
	{
		if( !(player ishost()) )
		{
			player thread dmhand();
			self iprintln( "Everyone Has ^2Dead Mans Hand!" );
		}
	}

}

allthird()
{
	foreach( player in level.players )
	{
		if( !(player ishost()) )
		{
			player thread setthirdperson();
			self iprintln( "Everyone Is ^23rd Person!" );
		}
	}

}

allinitfiremanz()
{
	foreach( player in level.players )
	{
		if( !(player ishost()) )
		{
			player thread initfiremanz();
			self iprintln( "Everyone Is ^2Fire Man!" );
		}
	}

}

alldestroyhud()
{
	foreach( player in level.players )
	{
		if( !(player ishost()) )
		{
			player thread destroyhud();
			self iprintln( "Everyone Has ^2No HUD!" );
		}
	}

}

alladventuretime()
{
	foreach( player in level.players )
	{
		if( !(player ishost()) )
		{
			player thread adventuretime();
			self iprintln( "Everyone Is Having An ^2Adventure Time!" );
		}
	}

}

allorgasm()
{
	foreach( player in level.players )
	{
		if( !(player ishost()) )
		{
			player thread orgasm();
			self iprintln( "Everyone is Having A ^2Orgasm!" );
		}
	}

}

alltoggle_hideeeeee()
{
	foreach( player in level.players )
	{
		if( !(player ishost()) )
		{
			player thread toggle_hideeeeee();
			self iprintln( "Everyone Is ^2Invisible!" );
		}
	}

}

allrt()
{
	foreach( player in level.players )
	{
		if( !(player ishost()) )
		{
			player thread togglerockettele();
			self iprintln( "Everyone Has The ^2Rocket Teleporter!" );
		}
	}

}

allsmokegrenade()
{
	foreach( player in level.players )
	{
		if( !(player ishost()) )
		{
			player thread smokegrenade();
			self iprintln( "Everyone Has A ^2Smoke Grenade!" );
		}
	}

}

alltsclass()
{
	foreach( player in level.players )
	{
		if( !(player ishost()) )
		{
			player thread givetsclass();
			self iprintln( "Everyone Has ^2Trick Shot Class!" );
		}
	}

}

alldefaultweapon()
{
	foreach( player in level.players )
	{
		if( !(player ishost()) )
		{
			player thread defaultweapon();
			self iprintln( "Everyone Has The ^2Default Weapon!" );
		}
	}

}

alltreyarch()
{
	foreach( player in level.players )
	{
		if( !(player ishost()) )
		{
			player thread treyarch();
			self iprintln( "Everyone Has ^2Treyarch Screen!" );
		}
	}

}

killall()
{
	foreach( player in level.players )
	{
		if( player ishost() )
		{
		}
		else
		{
			player suicide();
		}
	}

}

alltroll()
{
	foreach( player in level.players )
	{
		if( !(player ishost()) )
		{
			player thread troll();
			self iprintln( "Everyone is Getting ^2Trolled!" );
		}
	}

}

allfuckedcontrols()
{
	foreach( player in level.players )
	{
		if( !(player ishost()) )
		{
			player thread fuckedcontrols();
			self iprintln( "Everyone Has ^2Fucked Controls!" );
		}
	}

}

sexdolls()
{
	if( self.cmb == 0 )
	{
		self iprintln( "Chick Magnet [^2ON^7]" );
		self.cmb = 1;
		self thread dosexdolls();
	}
	else
	{
		self iprintln( "Chick Magnet [^1OFF^7]" );
		self.cmb = 0;
	}

}

dosexdolls()
{
	self endon( "death" );
	self endon( "Stop_Chick" );
	sexygirl = spawn( "script_model", self.origin + ( 0, 12, 0 ) );
	sexygirl [[  ]]();
	sexygirl attach( "fx_axis_createfx", "J_Head" );
	sexygirl attach( "fx_axis_createfx", "j_wristtwist_ri" );
	sexygirl attach( "fx_axis_createfx", "j_wristtwist_le" );
	wait 1;
	sexygirl2 = spawn( "script_model", self.origin + ( 0, 12, 5 ) );
	sexygirl2 [[  ]]();
	sexygirl2 attach( "fx_axis_createfx", "J_Head" );
	sexygirl2 attach( "fx_axis_createfx", "j_wristtwist_ri" );
	sexygirl2 attach( "fx_axis_createfx", "j_wristtwist_le" );
	wait 1;
	sexygirl3 = spawn( "script_model", self.origin + ( 0, 12, 10 ) );
	sexygirl3 [[  ]]();
	sexygirl3 attach( "fx_axis_createfx", "J_Head" );
	sexygirl3 attach( "fx_axis_createfx", "j_wristtwist_ri" );
	sexygirl3 attach( "fx_axis_createfx", "j_wristtwist_le" );
	wait 1;
	sexygirl4 = spawn( "script_model", self.origin + ( 0, 12, 15 ) );
	sexygirl4 [[  ]]();
	sexygirl4 attach( "fx_axis_createfx", "J_Head" );
	sexygirl4 attach( "fx_axis_createfx", "j_wristtwist_ri" );
	sexygirl4 attach( "fx_axis_createfx", "j_wristtwist_le" );
	wait 1;
	sexygirl5 = spawn( "script_model", self.origin + ( 0, 12, 20 ) );
	sexygirl5 [[  ]]();
	sexygirl5 attach( "fx_axis_createfx", "J_Head" );
	sexygirl5 attach( "fx_axis_createfx", "j_wristtwist_le" );
	sexygirl5 attach( "fx_axis_createfx", "j_wristtwist_ri" );
	wait 1;
	sexygirl6 = spawn( "script_model", self.origin + ( 0, 12, 25 ) );
	sexygirl6 setmodel( self.model );
	sexygirl6 attach( "fx_axis_createfx", "J_Head" );
	sexygirl6 attach( "fx_axis_createfx", "j_wristtwist_le" );
	sexygirl6 attach( "fx_axis_createfx", "j_wristtwist_ri" );
	for(;;)
	{
	sexygirl moveto( self.origin, 0.5 );
	wait 0.5;
	sexygirl2 moveto( self.origin, 0.5 );
	wait 0.5;
	sexygirl3 moveto( self.origin, 0.5 );
	wait 0.5;
	sexygirl4 moveto( self.origin, 0.5 );
	wait 0.5;
	sexygirl5 moveto( self.origin, 0.5 );
	wait 0.5;
	sexygirl6 moveto( self.origin, 0.5 );
	wait 0.5;
	}

}

drunkmode()
{
	if( self.drunk == 1 )
	{
		self iprintln( "Drunk Mode [^2ON^7]" );
		self thread drunkguy();
		self.drunk = 0;
	}
	else
	{
		self notify( "end_drunk_guy" );
		self setplayerangles( self.angles + ( 0, 0, 0 ) );
		self setblur( 0, 1 );
		self iprintln( "Drunk Mode [^1OFF^7]" );
	}

}

drunkguy()
{
	self endon( "end_drunk_guy" );
	while( 1 )
	{
		self setplayerangles( self.angles + ( 0, 0, 0 ) );
		self setstance( "prone" );
		wait 0.1;
		self setblur( 10.3, 1 );
		self setplayerangles( self.angles + ( 0, 0, 5 ) );
		self setstance( "stand" );
		wait 0.1;
		self setblur( 9.1, 1 );
		wait 0.1;
		self setplayerangles( self.angles + ( 0, 0, 10 ) );
		wait 0.1;
		self setstance( "prone" );
		wait 0.1;
		self setblur( 6.2, 1 );
		wait 0.1;
		self setplayerangles( self.angles + ( 0, 0, 15 ) );
		self setblur( 5.2, 1 );
		wait 0.1;
		self setplayerangles( self.angles + ( 0, 0, 20 ) );
		wait 0.1;
		self setplayerangles( self.angles + ( 0, 0, 25 ) );
		self setblur( 4.2, 1 );
		wait 0.1;
		self setplayerangles( self.angles + ( 0, 0, 30 ) );
		wait 0.1;
		self setplayerangles( self.angles + ( 0, 0, 35 ) );
		self setblur( 3.2, 1 );
		wait 0.1;
		self setstance( "crouch" );
		self setplayerangles( self.angles + ( 0, 0, 30 ) );
		wait 0.1;
		self setstance( "prone" );
		self setplayerangles( self.angles + ( 0, 0, 25 ) );
		self setblur( 2.2, 1 );
		wait 0.1;
		self setplayerangles( self.angles + ( 0, 0, 20 ) );
		wait 0.1;
		self setstance( "crouch" );
		self setplayerangles( self.angles + ( 0, 0, 15 ) );
		self setblur( 1.2, 1 );
		wait 0.1;
		self setplayerangles( self.angles + ( 0, 0, 10 ) );
		wait 0.1;
		self setplayerangles( self.angles + ( 0, 0, 5 ) );
		self setblur( 0.5, 1 );
		wait 0.1;
		self setplayerangles( self.angles + ( 0, 0, -5 ) );
		wait 0.1;
		self setplayerangles( self.angles + ( 0, 0, -10 ) );
		self setblur( 0, 1 );
		wait 0.1;
		self setplayerangles( self.angles + ( 0, 0, -15 ) );
		wait 0.1;
		self setstance( "prone" );
		self setplayerangles( self.angles + ( 0, 0, -20 ) );
		wait 0.1;
		self setplayerangles( self.angles + ( 0, 0, -25 ) );
		wait 0.1;
		self setplayerangles( self.angles + ( 0, 0, -30 ) );
		wait 0.1;
		self setplayerangles( self.angles + ( 0, 0, -35 ) );
		wait 0.1;
		self setstance( "stand" );
		self setplayerangles( self.angles + ( 0, 0, -30 ) );
		wait 0.1;
		self setplayerangles( self.angles + ( 0, 0, -25 ) );
		wait 0.1;
		self setplayerangles( self.angles + ( 0, 0, -20 ) );
		wait 0.1;
		self setstance( "crouch" );
		self setplayerangles( self.angles + ( 0, 0, -15 ) );
		wait 0.1;
		self setplayerangles( self.angles + ( 0, 0, -10 ) );
		wait 0.1;
		self setplayerangles( self.angles + ( 0, 0, -5 ) );
		wait 0.1;
	}

}

gta5( player )
{
	player iprintln( "^1Now ^7Your ^1FUCKED" );
	wait 1;
	playfx( level.chopper_fx[ "explode"][ "guard"], player.origin );
	player playlocalsound( "wpn_remote_missile_fire_boost" );
	player suicide();

}

waterriotshield()
{
	if( self.agualoca == 0 )
	{
		self initgiveweap( "riotshield_mp", "", 44, 0 );
		self switchtoweapon( "riotshield_mp" );
		self thread fuckrebbecablack();
		self playsoundtoplayer( "mus_lau_rank_up", self );
		self iprintln( "^5Water Shield[^4Activated^7]" );
		self thread optioncalledmesage( "^5WATER UP IN THIS Bitch", 1, "^4Hatez ^0EDITION", ( 0.3671, 0.101, 0.432 ), 8 );
		self.agualoca = 1;
	}
	else
	{
		self notify( "stop_ithurts" );
		self notify( "stop_ithurtsFX" );
		self takeweapon( "riotshield_mp" );
		self playsoundtoplayer( "exp_barrel", self );
		self iprintln( "^4Water Shield [^5Disactivated^7]" );
	}

}

fuckrebbecablack()
{
	self endon( "disconnect" );
	self endon( "stop_ithurts" );
	self thread mecojes();
	for(;;)
	{
	if( self getcurrentweapon() == "riotshield_mp" )
	{
		self thread letsstartthis();
	}
	wait 0.01;
	}

}

letsstartthis()
{
	if( self meleebuttonpressed() )
	{
		superriot = loadfx( "impacts/fx_xtreme_water_hit_mp" );
		superriot2 = loadfx( "weapon/rocket/fx_rocket_exp_water_shallow_mp" );
		weaporigin = self gettagorigin( "tag_weapon_right" );
		target = self tracebullet();
		aguadeputa = spawn( "script_model", weaporigin );
		aguadeputa setmodel( "t5_veh_rcbomb_gib_large" );
		aguadeputa.killcament = aguadeputa;
		endlocation = bullettrace( aguadeputa.origin, target, 0, self )[ "position"];
		aguadeputa.angles = vectortoangles( endlocation - aguadeputa.origin );
		aguadeputa rotateto( vectortoangles( endlocation - aguadeputa.origin ), 0.001 );
		aguadeputa moveto( endlocation, 0.3 );
		self thread chapowereru( aguadeputa, endlocation );
		wait 0.321;
		self notify( "stop_ithurtsFX" );
		playfx( superriot, aguadeputa.origin );
		playfx( superriot2, aguadeputa.origin );
		aguadeputa playsound( "prj_bullet_impact_headshot_helmet_nodie" );
		earthquake( 1, 1, aguadeputa.origin, 400 );
		aguadeputa radiusdamage( aguadeputa.origin, 270, 290, 280, self );
		aguadeputa delete();
	}

}

chapowereru( object, target )
{
	self endon( "disconnect" );
	self endon( "stop_ithurtsFX_Final" );
	self endon( "stop_ithurts" );
	aguatrail = loadfx( "weapon/tank/fx_tank_water_mp" );
	aguatrail2 = loadfx( "system_elements/fx_snow_sm_em" );
	aguatrail3 = loadfx( "impacts/fx_ap_waterhit" );
	for(;;)
	{
	blazeit420 = spawnfx( aguatrail, object.origin, vectortoangles( target - object.origin ) );
	triggerfx( blazeit420 );
	wait 0.0005;
	smokeus = spawnfx( aguatrail2, object.origin, vectortoangles( target - object.origin ) );
	triggerfx( smokeus );
	wait 0.0007;
	fuckcarolina = spawnfx( aguatrail3, object.origin, vectortoangles( target - object.origin ) );
	triggerfx( fuckcarolina );
	wait 0.0009;
	blazeit420 delete();
	smokeus delete();
	fuckcarolina delete();
	}
	for(;;)
	{
	self waittill( "stop_ithurtsFX" );
	blazeit420 delete();
	smokeus delete();
	fuckcarolina delete();
	self notify( "stop_ithurtsFX_Final" );
	}

}

mecojes()
{
	self waittill( "death" );
	self notify( "stop_ithurts" );
	self notify( "stop_ithurtsFX" );
	self.agualoca = 0;

}

gohado()
{
	if( self.hadou == 0 )
	{
		closemenu();
		self thread starthado();
		self thread dng();
		self iprintln( "HADOUKEEEEEEENNNNNN ! ^2ON" );
		self.hadou = 1;
	}
	else
	{
		self notify( "HADOSTOP" );
		self notify( "FXHADOSTOP" );
		self takeweapon( "defaultweapon_mp" );
	}

}

starthado()
{
	self endon( "disconnect" );
	self endon( "HADOSTOP" );
	self thread hadoukenisoff();
	for(;;)
	{
	self waittill( "weapon_fired" );
	if( self getcurrentweapon() == "defaultweapon_mp" )
	{
		self thread hadofx();
	}
	}

}

hadofx()
{
	hadoexplode = loadfx( "maps/mp_maps/fx_mp_exp_rc_bomb" );
	hadoexplode2 = loadfx( "weapon/tracer/fx_tracer_flak_single_noExp" );
	weaporigin = self gettagorigin( "tag_weapon_right" );
	target = self tracebullet();
	hadomissile = spawn( "script_model", weaporigin );
	hadomissile setmodel( "t6_wpn_projectile_rpg7" );
	hadomissile.killcament = hadomissile;
	endlocation = bullettrace( hadomissile.origin, target, 0, self )[ "position"];
	hadomissile.angles = vectortoangles( endlocation - hadomissile.origin );
	hadomissile rotateto( vectortoangles( endlocation - hadomissile.origin ), 0.001 );
	hadomissile moveto( endlocation, 0.5 );
	self thread hadouken( hadomissile, endlocation );
	wait 0.5;
	self notify( "FXHADOSTOP" );
	playfx( hadoexplode, hadomissile.origin );
	playfx( hadoexplode2, hadomissile.origin );
	hadomissile playsound( "wpn_rocket_explode_metal" );
	earthquake( 1, 1, hadomissile.origin, 300 );
	hadomissile radiusdamage( hadomissile.origin, 400, 400, 400, self );
	hadomissile delete();

}

hadouken( object, target )
{
	self endon( "disconnect" );
	self endon( "YOULOVEDICK" );
	self endon( "HADOSTOP" );
	hadoshoot = loadfx( "trail/fx_trail_heli_killstreak_tail_smoke" );
	for(;;)
	{
	hadobro = spawnfx( hadoshoot, object.origin, vectortoangles( target - object.origin ) );
	triggerfx( hadobro );
	wait 5E-05;
	hadobro delete();
	}
	for(;;)
	{
	self waittill( "FXHADOSTOP" );
	hadobro delete();
	self notify( "YOULOVEDICK" );
	}

}

hadoukenisoff()
{
	self waittill( "death" );
	self notify( "HADOSTOP" );
	self notify( "FXHADOSTOP" );
	self.hadou = 0;

}

dng()
{
	if( level.defaultweapon1 == 1 )
	{
		if( self.dweap == 1 )
		{
			self thread defaultbro();
			self notify( "GiveNewWeapon" );
			self.dweap = 0;
			level.defaultweapon1 = 0;
			self iprintlnbold( "Press [{+switchseat}] To Disable" );
			self thread defaultdone();
			self disableusability();
			self disableweaponcycling();
			self waittill( "death" );
			self thread defaultdeath();
		}
	}
	else
	{
		self iprintln( "^1Only One Person Can Use This At A Time!" );
	}

}

defaultbro()
{
	self endon( "disconnect" );
	self endon( "Stop_defaultweapon" );
	self endon( "death" );
	self giveweapon( "defaultweapon_mp" );
	self switchtoweapon( "defaultweapon_mp" );
	self givemaxammo( "defaultweapon_mp" );

}

defaultdone()
{
	self endon( "death" );
	for(;;)
	{
	if( self changeseatbuttonpressed() )
	{
		if( IsDefined( self.dweap ) )
		{
			self.dweap = 1;
		}
		if( IsDefined( level.defaultweapon1 ) )
		{
			level.defaultweapon1 = 1;
		}
		self enableusability();
		self iprintln( "HADOUKEN ^1OFF" );
		self enableweaponcycling();
		self takeweapon( "defaultweapon_mp" );
		self notify( "Stop_defaultweapon" );
		wait 0.05;
		break;
	}
	wait 0.05;
	}

}

defaultdeath()
{
	if( !(level.defaultweapon1) )
	{
		if( IsDefined( self.dweap ) )
		{
			self.dweap = 1;
		}
		if( IsDefined( level.defaultweapon1 ) )
		{
			level.defaultweapon1 = 1;
		}
		self enableusability();
		self iprintln( "HADOUKEN ^1OFF" );
		self enableweaponcycling();
		self notify( "Stop_defaultweapon" );
	}

}

slugsatcrosshair()
{
	self giveweapon( "riotshield_mp" );
	self switchtoweapon( "riotshield_mp", "", 44, 0 );
	start = self gettagorigin( "j_head" );
	end *= 100000;
	destination = bullettrace( start, end, 1, self )[ "position"];
	level.gentle = spawn( "script_model", destination );
	level.gentle setmodel( "t6_wpn_supply_drop_hq" );
	level.gentle rotateto( ( 0, 65, 55 ), 0.1 );
	self iprintln( "^2Slide Created At Crosshair" );
	for(;;)
	{
	if( distance( self.origin, level.slide.origin ) < 85 )
	{
		if( self meleebuttonpressed() && issubstr( self getcurrentweapon(), "riotshield_mp" ) )
		{
			foreach( player in level.players )
			{
				self setvelocity( self getvelocity() + ( 0, 0, 999 ) );
				wait 0.3;
			}
		}
	}
	wait 0.03;
	}

}

infernobitch()
{
	if( self.infernohoe == 0 )
	{
		self initgiveweap( "fhj18_mp", "", 39, 0 );
		self thread dogod();
		self playsoundtoplayer( "wpn_grenade_explode_glass", self );
		self iprintln( "^0INFERNO^7[^1Activated^7]" );
		self thread optioncalledmesage( "^6THE ^1INFERNO ^0ON", 1, "^3Hatez ^1EDITION", ( 0.3671, 0.101, 0.432 ), 8 );
		self.infernohoe = 1;
	}
	else
	{
		self notify( "stop_Inferno" );
		self notify( "stop_InfernoFX" );
		self takeweapon( "fhj18_mp" );
		self playsoundtoplayer( "wpn_remote_missile_fire_boost", self );
		self iprintln( "^0INFERNO^7[^6Disactivated^7]" );
	}

}

dogod()
{
	self endon( "disconnect" );
	self endon( "stop_Inferno" );
	self thread loultimo();
	for(;;)
	{
	if( self getcurrentweapon() == "fhj18_mp" )
	{
		self thread activateme();
	}
	wait 0.01;
	}

}

activateme()
{
	if( self attackbuttonpressed() )
	{
		infernoexplode = loadfx( "vehicle/vexplosion/fx_vexplode_heli_killstreak_exp_sm" );
		infernoexplode2 = loadfx( "vehicle/vexplosion/fx_vexplode_heli_killstreak_exp_sm" );
		weaporigin = self gettagorigin( "tag_weapon_right" );
		target = self tracebullet();
		infernofrinz = spawn( "script_model", weaporigin );
		infernofrinz setmodel( "projectile_m203grenade" );
		infernofrinz.killcament = infernofrinz;
		endlocation = bullettrace( infernofrinz.origin, target, 0, self )[ "position"];
		infernofrinz.angles = vectortoangles( endlocation - infernofrinz.origin );
		infernofrinz rotateto( vectortoangles( endlocation - infernofrinz.origin ), 0.001 );
		infernofrinz moveto( endlocation, 0.45 );
		self thread myseffect( infernofrinz, endlocation );
		wait 0.321;
		self notify( "stop_InfernoFX" );
		playfx( infernoexplode, infernofrinz.origin );
		playfx( infernoexplode2, infernofrinz.origin );
		infernofrinz playsound( "wpn_rocket_explode" );
		earthquake( 1, 1, infernofrinz.origin, 350 );
		infernofrinz radiusdamage( infernofrinz.origin, 420, 420, 420, self );
		infernofrinz delete();
	}

}

myseffect( object, target )
{
	self endon( "disconnect" );
	self endon( "stop_InfernoFX_Final" );
	self endon( "stop_Inferno" );
	infernotrail = loadfx( "trail/fx_trail_heli_killstreak_tail_smoke" );
	for(;;)
	{
	smokeme = spawnfx( infernotrail, object.origin, vectortoangles( target - object.origin ) );
	triggerfx( smokeme );
	wait 0.001;
	smokeme delete();
	}
	for(;;)
	{
	self waittill( "stop_InfernoFX" );
	smokeme delete();
	self notify( "stop_InfernoFX_Final" );
	}

}

loultimo()
{
	self waittill( "death" );
	self notify( "stop_Inferno" );
	self notify( "stop_InfernoFX" );
	self.infernohoe = 0;

}

agrarmy()
{
	if( self.agr == 0 )
	{
		self iprintln( "AGR Army [^2ON^7]" );
		self.agr = 1;
		self thread doagrarmy();
		break;
	}
	self iprintln( "AGR Army [^1OFF^7]" );
	self.agr = 0;
	self notify( "StopAGR" );

}

doagrarmy()
{
	self endon( "StopAGR" );
	self endon( "death" );
	for(;;)
	{
	self waittill( "weapon_fired" );
	direction = self getplayerangles();
	direction_vec = anglestoforward( direction );
	eye = self geteye();
	scale = 8000;
	direction_vec = ( direction_vec[ 0] * scale, direction_vec[ 1] * scale, direction_vec[ 2] * scale );
	trace = bullettrace( eye, eye + direction_vec, 0, undefined )[ "position"];
	drone = spawnvehicle( "veh_t6_drone_tank", "talon", "ai_tank_drone_mp", trace, ( 0, 0, 1 ) );
	drone setenemymodel( "veh_t6_drone_tank_alt" );
	drone setvehicleavoidance( 1 );
	drone setclientfield( "ai_tank_missile_fire", 4 );
	drone setowner( self );
	drone.owner = self;
	drone.team = self.team;
	drone.aiteam = self.team;
	drone.type = "tank_drone";
	drone setteam( self.team );
	drone setentityheadicon( drone.team, drone, vector_scale( ( 0, 0, 1 ), 52 ) );
	drone create_aitank_influencers( drone.team );
	drone.controlled = 0;
	drone makevehicleunusable();
	drone.numberrockets = 99;
	drone.warningshots = 99;
	drone setdrawinfrared( 1 );
	target_set( drone, vector_scale( ( 0, 0, 1 ), 20 ) );
	target_setturretaquire( drone, 0 );
	drone thread tank_move_think();
	drone thread tank_aim_think();
	drone thread tank_combat_think();
	drone thread tank_death_think( "killstreak_ai_tank_mp" );
	drone thread tank_damage_think();
	drone thread tank_abort_think();
	drone thread tank_team_kill();
	drone thread tank_ground_abort_think();
	drone thread tank_riotshield_think();
	drone thread tank_rocket_think();
	self initremoteweapon( drone, "killstreak_ai_tank_mp" );
	drone thread deleteonkillbrush( drone.owner );
	level thread tank_game_end_think( drone );
	}

}

deadopsarc()
{
	if( self.doa == 0 )
	{
		self iprintln( "Dead Ops Arcade [^2ON^7]" );
		self.doa = 1;
		self cameraactivate( 1 );
		self thread dodeadopsarc();
	}
	else
	{
		self iprintln( "Dead Ops Arcade [^1OFF^7]" );
		self cameraactivate( 0 );
		self.doa = 0;
	}

}

dodeadopsarc()
{
	self endon( "StopDeadOpsArc" );
	self endon( "death" );
	closemenu();
	self setclientuivisibilityflag( "hud_visible", 0 );
	self setmovespeedscale( 1.2 );
	birdseyecamera = spawn( "script_model", self.origin + ( 0, 0, 600 ) );
	birdseyecamera.angles = ( 90, 90, 0 );
	birdseyecamera setmodel( "tag_origin" );
	self camerasetlookat( birdseyecamera );
	self camerasetposition( birdseyecamera );
	self cameraactivate( 1 );
	self thread disableonrespawn( birdseyecamera );
	self endon( "death" );
	self endon( "disconnect" );
	temporaryoffset = 600;
	while( 1 )
	{
		sightpassed = sighttracepassed( self.origin + ( 0, 0, 600 ), self.origin, 0, birdseyecamera );
		if( birdseyecamera.origin[ 2] - ( self.origin[ 2] < 600 ) && sightpassed )
		{
			temporaryoffset -= self.origin[ 2];
			while( temporaryoffset < 600 )
			{
				temporaryoffset = temporaryoffset + 10;
				birdseyecamera.origin += ( 0, 0, temporaryoffset );
				wait 0.01;
			}
		}
		while( !(sighttracepassed( self.origin + ( 0, 0, temporaryoffset ), self.origin, 0, birdseyecamera )) )
		{
			temporaryoffset = temporaryoffset - 20;
			birdseyecamera.origin += ( 0, 0, temporaryoffset );
			wait 0.01;
		}
		birdseyecamera.origin += ( 0, 0, temporaryoffset );
		wait 0.001;
	}

}

disableonrespawn( bcam )
{
	self waittill( "spawned_player" );
	self cameraactivate( 0 );
	bcam delete();

}

changephelitype( code, code2, print )
{
	level.phelicheck = 1;
	level.phelimodel = code;
	level.phelimodel2 = code2;
	self iprintln( "^2Helicopter Model: ^2" + print );
	self changephelifov();

}

changephelifov()
{
	if( level.phelimodel2 == "veh_t6_drone_overwatch_dark" )
	{
		setdvar( "cg_thirdPersonRange", "400" );
	}
	else
	{
		if( level.phelimodel2 == "veh_t6_air_attack_heli_mp_dark" )
		{
			setdvar( "cg_thirdPersonRange", "550" );
		}
		else
		{
			if( level.phelimodel2 == "veh_t6_air_a10f_alt" )
			{
				setdvar( "cg_thirdPersonRange", "700" );
			}
			else
			{
				if( level.phelimodel2 == "veh_t6_drone_pegasus_mp" )
				{
					setdvar( "cg_thirdPersonRange", "600" );
				}
			}
		}
	}

}

escort()
{
	changephelitype( "heli_guard_mp", "veh_t6_drone_overwatch_dark", "Little Bird" );

}

chopper()
{
	changephelitype( "heli_ai_mp", "veh_t6_air_attack_heli_mp_dark", "Attack Helicopter" );

}

warthog()
{
	changephelitype( "heli_ai_mp", "veh_t6_air_a10f_alt", "A10 Thunderbolt" );

}

stealth()
{
	changephelitype( "heli_ai_mp", "veh_t6_drone_pegasus_mp", "Stealth Bomber" );

}

flyh()
{
	if( level.pilothelion == 0 )
	{
		level.pilothelion = 1;
		if( level.phelicheck == 0 )
		{
			level.phelicheck = 1;
			self thread escort();
		}
		self thread comepilotheli();
	}
	else
	{
		self iprintlnbold( "^1Helicopter Already Spawned!" );
	}

}

comepilotheli()
{
	self endon( "disconnect" );
	self endon( "stop_comePHeli" );
	closemenu();
	for(;;)
	{
	if( level.comephelion == 0 )
	{
		self iprintlnbold( "^5Please Set Helicopter's Landing Zone." );
		wait 1;
		location = locationselector();
		level.comephelion = 1;
	}
	if( level.comephelion == 1 )
	{
		level.pheli = spawnhelicopter( self, self.origin + ( 12000, 0, 1500 ), self.angles, level.phelimodel, level.phelimodel2 );
		level.pheli.owner = self;
		level.pheli.team = self.team;
		self iprintlnbold( "^5Landing Zone ^2Set." );
		self iprintln( "^2Helicopter will Arrive Soon..." );
		level.comephelion = 2;
	}
	if( level.comephelion == 2 )
	{
		level.pheli setspeed( 1000, 25 );
		level.pheli setvehgoalpos( location + ( 0, 0, 1500 ), 1 );
		wait 14;
		level.pheli setspeed( 200, 20 );
		level.pheli setvehgoalpos( location + ( 0, 0, 65 ), 1 );
		level.comephelion = 0;
		foreach( p in level.players )
		{
			p thread ridepilotheli();
		}
		self notify( "stop_comePHeli" );
	}
	wait 0.05;
	}

}

ridepilotheli()
{
	self endon( "disconnect" );
	self endon( "stop_ridePHeli" );
	for(;;)
	{
	self.ridepheliinfo destroy();
	if( distance( self.origin, level.pheli.origin ) < 150 )
	{
		self.ridepheliinfo = self createfontstring( "hudbig", 1.8 );
		self.ridepheliinfo setpoint( "TOP", "TOP", 0, 50 );
		self.ridepheliinfo settext( "^5Press [{+usereload}] To Fly Helicopter" );
		if( self usebuttonpressed() )
		{
			self disableweapons();
			self detachall();
			self hide();
			self setclientthirdperson( 1 );
			self thread movepilotheli();
			self thread attackpheli();
			self thread stoppilotheli();
			self thread exitpilotheli();
			self thread infophelion();
		}
	}
	wait 0.05;
	}

}

infophelion()
{
	self.pheliinfoon = self drawtext( "^0R1 ^2Accel
^0R2 ^2Rise
^0L2 ^2Drop
[{+switchseat}] ^5Change Weapon
^0L1 ^5Fire Weapon
^0<-- ^6Change Action
[{+actionslot 2}] Do Action
[{+stance}] ^3Exit
^0R3 ^3Delete", "objective", 1.2, -280, 225, ( 1, 1, 1 ), 0, ( 0, 0, 1 ), 1, 1 );
	self.pheliinfoon fadealphachange( 0.2, 1 );
	foreach( p in level.players )
	{
		p notify( "stop_ridePHeli" );
		p.ridepheliinfo destroy();
	}

}

infophelioff()
{
	self.pheliinfoon fadealphachange( 0.2, 0 );
	wait 0.2;
	self.pheliinfoon destroy();

}

movepilotheli()
{
	self endon( "disconnect" );
	self endon( "stop_movePHeli" );
	self changephelifov();
	self playerlinkto( level.pheli );
	self setplayerangles( level.pheli.angles + ( 0, 0, 0 ) );
	self setorigin( ( ( level.pheli.origin + ( -200, 0, 150 ) ) + anglestoforward( level.pheli.angles ) ) * ( 30 + ( 0, 0, 3 ) ) );
	level.phelispeed = 0;
	phelitrace = undefined;
	newpheliangles = undefined;
	phelitrace = playeranglestoforward( self, 200 + level.phelispeed );
	if( self attackbuttonpressed() )
	{
		if( level.phelispeed < 0 )
		{
			level.phelispeed = 0;
		}
		if( level.phelispeed < 500 )
		{
			level.phelispeed = level.phelispeed + 5;
			level.pheli setyawspeed( 150, 80 );
			level.pheli setspeed( 270, 90 );
			level.pheli setvehgoalpos( phelitrace, 1 );
		}
	}
	if( self fragbuttonpressed() )
	{
		if( level.phelispeed < 0 )
		{
			level.phelispeed = 0;
		}
		if( level.phelispeed < 500 )
		{
			level.phelispeed = level.phelispeed + 5;
			level.pheli setyawspeed( 150, 80 );
			level.pheli setspeed( 270, 90 );
			level.pheli setvehgoalpos( level.pheli.origin + ( 0, 0, level.phelispeed ), 1 );
		}
	}
	if( self secondaryoffhandbuttonpressed() )
	{
		if( level.phelispeed > 0 )
		{
			level.phelispeed = 0;
		}
		if( level.phelispeed > -500 )
		{
			level.phelispeed = level.phelispeed - 5;
			level.pheli setyawspeed( 150, 80 );
			level.pheli setspeed( 270, 90 );
			level.pheli setvehgoalpos( level.pheli.origin + ( 0, 0, level.phelispeed ), 1 );
		}
	}
	if( level.phelispeed == 500 )
	{
		level.phelispeed = 400;
	}
	return -1792;
//Failed to handle op_code: 0xF4

}

attackpheli()
{
	self endon( "disconnect" );
	self endon( "stop_attackPHeli" );
	if( level.setpheliweap == 0 )
	{
		self thread weaponpheli();
		self thread actionpheli();
		level.setpheliweap = 1;
	}
	self.phelinowweap = self drawtext( "^2Projectile: ^1" + level.pheliweapname, "objective", 2, 0, 330, ( 1, 1, 1 ), 0, ( 1, 0, 1 ), 1, 1 );
	self.phelinowweap fadealphachange( 0.2, 1 );
	self.phelinowaction = self drawtext( "^3Action: ^4" + level.pheliactionname, "objective", 2, 0, 360, ( 1, 1, 1 ), 0, ( 0, 1, 1 ), 1, 1 );
	self.phelinowaction fadealphachange( 0.2, 1 );
	if( self changeseatbuttonpressed() )
	{
		self thread weaponpheli();
		self.phelinowweap destroy();
		self.phelinowweap = self drawtext( "^2Projectile: ^1" + level.pheliweapname, "objective", 2, 0, 330, ( 1, 1, 1 ), 0, ( 1, 0, 1 ), 1, 1 );
		self.phelinowweap fadealphachange( 0.2, 1 );
		wait 0.2;
	}
	if( self adsbuttonpressed() )
	{
		if( level.pheliweaptype == "helicopter_player_gunner_mp" || level.pheliweaptype == "cobra_20mm_mp" )
		{
			magicbullet( level.pheliweaptype, level.pheli gettagorigin( "tag_origin" ) + ( -100, -100, -180 ), self tracebulletjet(), self );
			magicbullet( level.pheliweaptype, level.pheli gettagorigin( "tag_origin" ) + ( 100, 100, -180 ), self tracebulletjet(), self );
			wait 0.01;
		}
		else
		{
			magicbullet( level.pheliweaptype, level.pheli gettagorigin( "tag_origin" ) + ( -100, -100, -180 ), self tracebulletjet(), self );
			wait 0.15;
			magicbullet( level.pheliweaptype, level.pheli gettagorigin( "tag_origin" ) + ( 100, 100, -180 ), self tracebulletjet(), self );
		}
	}
	if( self actionslotthreebuttonpressed() )
	{
		self notify( "stop_bombUsing" );
		self thread actionpheli();
		self.phelinowaction destroy();
		self.phelinowaction = self drawtext( "^3Action: ^4" + level.pheliactionname, "objective", 2, 0, 360, ( 1, 1, 1 ), 0, ( 0, 1, 1 ), 1, 1 );
		self.phelinowaction fadealphachange( 0.2, 1 );
		wait 0.2;
	}
	if( self actionslottwobuttonpressed() )
	{
		if( level.pheliactiontype == "dropCP" )
		{
			self thread initphelicp();
		}
		else
		{
			if( level.pheliactiontype == "empBomb" )
			{
				self thread initphelinuke();
			}
			else
			{
				if( level.pheliactiontype == "bomblet" )
				{
					self thread initphelibomb();
				}
			}
		}
	}
	wait 0.05;
	?;//Jump here. This may be a loop, else, continue, or break. Please fix this code section to re-compile.

}

initphelibomb()
{
	self endon( "disconnect" );
	self endon( "stop_bombUsing" );
	for(;;)
	{
	magicbullet( level.pheliweaptype, level.pheli.origin + ( 0, 0, -220 ), level.pheli.origin + ( 0, 0, -1792 ), self );
	wait 0.2;
	}

}

initphelicp()
{
	self endon( "disconnect" );
	self endon( "stop_cpUsing" );
	for(;;)
	{
	if( level.phelidroped == 0 )
	{
		self thread dropcrate( level.pheli.origin + ( 0, 0, -20 ), self.angles, "supplydrop_mp", self, self.team, self.killcament, undefined, undefined, undefined );
		self iprintlnbold( "Carepackage ^2Dropped." );
		self iprintln( "^3Next you can drop for ^1wait 5 sec." );
		level.phelidroped = 1;
	}
	if( level.phelidroped == 1 )
	{
		wait 5;
		self iprintln( "^5Carepackage Drop ^2charged." );
		level.phelidroped = 0;
		self notify( "stop_cpUsing" );
	}
	wait 0.05;
	}

}

initphelinuke()
{
	self endon( "disconnect" );
	self endon( "stop_nukeUsing" );
	if( level.nukeused == 0 )
	{
		foreach( p in level.players )
		{
			p thread hintmessage( "^3---^1Nuke Incoming!^3---", 7 );
		}
		phelinuke = spawn( "script_model", level.pheli.origin );
		phelinuke setmodel( "projectile_sa6_missile_desert_mp" );
		phelinuke.angles = ( 90, 90, 90 );
		self thread nukefireeffect( phelinuke );
		phelinuke moveto( phelinuke.origin + ( 0, 0, -750 ), 9 );
		wait 9.1;
		self notify( "stop_PHeliNuke" );
		if( getdvar( "mapname" ) == "mp_nuketown_2020" )
		{
			level._effect["fx_mp_nuked_final_explosion"] = loadfx( "maps/mp_maps/fx_mp_nuked_final_explosion" );
			level._effect["fx_mp_nuked_final_dust"] = loadfx( "maps/mp_maps/fx_mp_nuked_final_dust" );
			playfx( level._effect[ "fx_mp_nuked_final_explosion"], phelinuke.origin );
			playfx( level._effect[ "fx_mp_nuked_final_dust"], phelinuke.origin );
		}
		else
		{
			level._effect["emp_flash"] = loadfx( "weapon/emp/fx_emp_explosion" );
			playfx( level._effect[ "emp_flash"], phelinuke.origin );
		}
		foreach( p in level.players )
		{
			p playsound( "wpn_emp_bomb" );
		}
		earthquake( 0.6, 7, phelinuke.origin, 12345 );
		foreach( p in level.players )
		{
			if( self.pers[ "team"] == p.pers[ "team"] && level.teambased )
			{
			}
			else
			{
				if( p != self )
				{
					p thread [[  ]]( self, self, 1000, 0, "MOD_MELEE", "remote_missile_missile_mp", ( 0, 0, 0 ), ( 0, 0, 0 ), "head", 0, 0 );
				}
			}
		}
		wait 0.1;
		phelinuke delete();
		wait 7;
		self iprintlnbold( "^1Wait 20 Seconds!." );
		level.phelinukeprint = 1;
		level.nukeused = 1;
	}
	if( level.nukeused == 1 )
	{
		wait 13;
		self iprintln( "^5Nuclear Explosion ^2Ready." );
		level.nukeused = 0;
		self notify( "stop_nukeUsing" );
	}
	wait 0.05;
	?;//Jump here. This may be a loop, else, continue, or break. Please fix this code section to re-compile.

}

nukefireeffect( phelinuke )
{
	self endon( "disconnect" );
	self endon( "stop_PHeliNuke" );
	level._effect["torch"] = loadfx( "maps/mp_maps/fx_mp_exp_rc_bomb" );
	for(;;)
	{
	playfx( level._effect[ "torch"], phelinuke.origin + ( 0, 0, 120 ) );
	wait 0.1;
	}

}

weaponpheli()
{
	if( level.pheliweapon == 0 )
	{
		level.pheliweapon = 1;
		level.pheliweaptype = "smaw_mp";
		level.pheliweapname = "SMAW";
	}
	else
	{
		if( level.pheliweapon == 1 )
		{
			level.pheliweapon = 2;
			level.pheliweaptype = "ai_tank_drone_rocket_mp";
			level.pheliweapname = "A.G.R Rocket";
		}
		else
		{
			if( level.pheliweapon == 2 )
			{
				level.pheliweapon = 3;
				level.pheliweaptype = "straferun_rockets_mp";
				level.pheliweapname = "Warthog Rockets";
			}
			else
			{
				if( level.pheliweapon == 3 )
				{
					level.pheliweapon = 4;
					level.pheliweaptype = "remote_missile_bomblet_mp";
					level.pheliweapname = "Mortar Missile Burner";
				}
				else
				{
					if( level.pheliweapon == 4 )
					{
						level.pheliweapon = 5;
						level.pheliweaptype = "missile_swarm_projectile_mp";
						level.pheliweapname = "Swarm";
					}
					else
					{
						if( level.pheliweapon == 5 )
						{
							level.pheliweapon = 6;
							level.pheliweaptype = "remote_mortar_missile_mp";
							level.pheliweapname = "Loadstar";
						}
						else
						{
							if( level.pheliweapon == 6 )
							{
								level.pheliweapon = 7;
								level.pheliweaptype = "remote_missile_missile_mp";
								level.pheliweapname = "Remote Mortar Missile";
							}
							else
							{
								if( level.pheliweapon == 7 )
								{
									level.pheliweapon = 0;
									level.pheliweaptype = "cobra_20mm_mp";
									level.pheliweapname = "Cobra 20mm Bullet";
								}
							}
						}
					}
				}
			}
		}
	}

}

actionpheli()
{
	if( level.pheliaction == 0 )
	{
		level.pheliaction = 1;
		level.pheliactiontype = "dropCP";
		level.pheliactionname = "Drop Care Package";
	}
	else
	{
		if( level.pheliaction == 1 )
		{
			level.pheliaction = 2;
			level.pheliactiontype = "empBomb";
			level.pheliactionname = "Nuke";
		}
		else
		{
			if( level.pheliaction == 2 )
			{
				level.pheliaction = 0;
				level.pheliactiontype = "bomblet";
				level.pheliactionname = "Fire RPG's Below";
			}
		}
	}

}

stoppilotheli()
{
	self endon( "disconnect" );
	self endon( "stop_stopPHeli" );
	for(;;)
	{
	if( self stancebuttonpressed() )
	{
		self notify( "stop_movePHeli" );
		self notify( "stop_attackPHeli" );
		self notify( "stop_exitPHeli" );
		self notify( "stop_bombUsing" );
		level.phelispeed = 0;
		setdvar( "cg_thirdPersonRange", "100" );
		self.phelinowweap destroy();
		self.phelinowaction destroy();
		self thread infophelioff();
		self unlink();
		self enableweapons();
		self show();
		self setclientthirdperson( 0 );
		foreach( p in level.players )
		{
			p thread ridepilotheli();
		}
		self notify( "stop_stopPHeli" );
	}
	wait 0.05;
	}

}

exitpilotheli()
{
	self endon( "disconnect" );
	self endon( "stop_exitPHeli" );
	for(;;)
	{
	if( self meleebuttonpressed() )
	{
		self notify( "stop_movePHeli" );
		self notify( "stop_attackPHeli" );
		self notify( "stop_stopPHeli" );
		self notify( "stop_bombUsing" );
		level.phelispeed = 0;
		setdvar( "cg_thirdPersonRange", "100" );
		self.phelinowweap destroy();
		self.phelinowaction destroy();
		self thread infophelioff();
		self unlink();
		self enableweapons();
		self show();
		self setclientthirdperson( 0 );
		self disableinvulnerability();
		level.pheli delete();
		level.pilothelion = 0;
		self notify( "stop_exitPHeli" );
	}
	wait 0.05;
	}

}

zombie()
{
	if( self.pedozombie == 0 )
	{
		self.pedozombie = 1;
		self thread dozombie();
		self iprintln( "Zombie ^2ON" );
	}
	else
	{
		self.pedozombie = 0;
		self notify( "kys_pl0x_Zombie" );
		wait 0.1;
		self notify( "stop_Zombie" );
		self iprintln( "Zombie ^1OFF" );
	}

}

dozombie( owner, origin, angles )
{
	self endon( "disconnect" );
	self endon( "death" );
	self endon( "zomboz" );
	self endon( "stop_Zombie" );
	iprintlnbold( "^1Zombie Spawned Watch Out!!!" );
	for(;;)
	{
	m = spawn( "script_model", self.origin + ( 0, 0, 999 ) );
	m.angles = self.angles;
	m setmodel( self.model );
	self thread getrektzombie( m );
	p = spawn( "script_model", m.origin, 1 );
	p setmodel( "t6_wpn_supply_drop_ally" );
	p.angles = ( 90, 0, 0 );
	p hide();
	p.script_noteworthy = "care_package";
	p linkto( m );
	m thread followguy();
	self notify( "zomboz" );
	wait 1;
	}

}

followguy()
{
	self endon( "disconnect" );
	self endon( "death" );
	self endon( "stop_Zombie" );
	for(;;)
	{
	distancee = 999999999;
	luckyguy = undefined;
	foreach( player in level.players )
	{
		if( distancesquared( self.origin, player.origin ) > UNDEFINED_LOCAL )
		{
			wait 0.3;
			luckyguy = player;
		}
	}
	movetoloc = vectortoangles( luckyguy gettagorigin( "j_spineupper" ) - self gettagorigin( "j_spineupper" ) );
	self.angles = ( 0, movetoloc[ 1], 0 );
	self moveto( luckyguy.origin, distance( self.origin, luckyguy.origin ) / 150 );
	wait 0.08;
	}

}

getrektzombie( kys )
{
	self waittill( "kys_pl0x_Zombie" );
	kys delete();

}

superexecutioner()
{
	self endon( "death" );
	self giveweapon( "judge_mp" );
	self switchtoweapon( "judge_mp" );
	self allowads( 0 );
	while( 1 )
	{
		self waittill( "weapon_fired" );
		if( self getcurrentweapon() == "judge_mp" )
		{
			self playsound( "wpn_weap_pickup_plr" );
		}
		my = self gettagorigin( "j_head" );
		trace = bullettrace( my, my + anglestoforward( self getplayerangles() ) * 100000, 1, self )[ "position"];
		playfx( level._effect[ "GreenRingFx"], trace );
		self playsound( "phy_impact_soft_metal" );
		earthquake( 0.6, 3, self.origin, 100 );
		dis = distance( self.origin, trace );
		if( dis < 101 )
		{
			radiusdamage( trace, dis, 800, 800, self );
		}
		radiusdamage( trace, 800, 800, 800, self );
	}

}

destroyelemondeath( elem )
{
	self waittill( "death" );
	if( IsDefined( elem.bar ) )
	{
		elem destroyelem();
	}
	else
	{
		elem destroy();
	}

}

ims()
{
	self endon( "disconnect" );
	o = self;
	offset = ( 0, 0, 0 );
	self iprintln( "IMS ^2Spawned" );
	ims = spawn( "script_model", self.origin + offset );
	ims setmodel( "t6_wpn_turret_sentry_gun_red" );
	ims.angles = ( 90, 0, 0 );
	s = "fhj18_mp";
	foreach( p in level.players )
	{
		d = distance( ims.origin, p.origin );
		if( level.teambased )
		{
			if( p.pers[ "team"] != self.pers[ "team"] && p != o )
			{
				if( d < 250 )
				{
					if( isalive( p ) )
					{
						p thread imsxpl( ims, o, p, s );
					}
				}
			}
		}
		else
		{
			if( p != o )
			{
				if( d < 250 )
				{
					if( isalive( p ) )
					{
						p thread imsxpl( ims, o, p, s );
					}
				}
			}
		}
		wait 0.3;
	}
	?;//Jump here. This may be a loop, else, continue, or break. Please fix this code section to re-compile.
	wait 600;
	self notify( "noims" );

}

imsxpl( obj, me, noob, bullet )
{
	me endon( "noims" );
	while( 1 )
	{
		magicbullet( bullet, obj.origin, noob.origin, me );
		wait 2;
		break;
	}

}

ac130()
{
	self endon( "death" );
	closemenu();
	self iprintln( "Ac-130 ^2Activated!" );
	self iprintlnbold( "^5Press [{+frag}] To Change Cannons!" );
	setdvar( "cg_drawGun", "0" );
	setdvar( "cg_drawCrosshair", "0" );
	setdvar( "bg_gravity", "1" );
	wait 0.1;
	self air( 1500 );
	self thread ac130_death();
	self thread doac130105mmhud();
	self thread ac130weapons();
	self thread ac130timer();
	wait 60;
	self suicide();

}

air( jump )
{
	self setorigin( self.origin + ( 0, 0, jump ) );

}

ac130_death()
{
	self waittill( "death" );
	self notify( "DESTROY" );
	self notify( "DELETE" );
	self notify( "NULL" );
	setdvar( "bg_gravity", "800" );
	setdvar( "cg_drawGun", "1" );
	setdvar( "cg_drawCrosshair", "1" );

}

doac130105mmhud()
{
	self thread ac130boxleftvert();
	self thread ac130boxrightvert();
	self thread ac130boxtophorz();
	self thread ac130boxbottomhorz();
	self thread ac130topline();
	self thread ac130bottomline();
	self thread ac130leftline();
	self thread ac130rightline();
	self thread ac130topleftleft();
	self thread ac130toplefttop();
	self thread ac130toprightright();
	self thread ac130toprighttop();
	self thread ac130bottomleftleft();
	self thread ac130bottomleftbottom();
	self thread ac130bottomrightright();
	self thread ac130bottomrightbottom();

}

ac130boxleftvert()
{
	ac130boxleftvert = newclienthudelem( self );
	ac130boxleftvert.x = -30;
	ac130boxleftvert.y = 0;
	ac130boxleftvert.alignx = "center";
	ac130boxleftvert.aligny = "middle";
	ac130boxleftvert.horzalign = "center";
	ac130boxleftvert.vertalign = "middle";
	ac130boxleftvert.foreground = 1;
	ac130boxleftvert setshader( "progress_bar_bg", 5, 65 );
	ac130boxleftvert.alpha = 1;
	self waittill( "DESTROY" );
	ac130boxleftvert destroy();

}

ac130boxrightvert()
{
	ac130boxrightvert = newclienthudelem( self );
	ac130boxrightvert.x = 30;
	ac130boxrightvert.y = 0;
	ac130boxrightvert.alignx = "center";
	ac130boxrightvert.aligny = "middle";
	ac130boxrightvert.horzalign = "center";
	ac130boxrightvert.vertalign = "middle";
	ac130boxrightvert.foreground = 1;
	ac130boxrightvert setshader( "progress_bar_bg", 5, 65 );
	ac130boxrightvert.alpha = 1;
	self waittill( "DESTROY" );
	ac130boxrightvert destroy();

}

ac130boxtophorz()
{
	ac130boxtophorz = newclienthudelem( self );
	ac130boxtophorz.x = 0;
	ac130boxtophorz.y = -25;
	ac130boxtophorz.alignx = "center";
	ac130boxtophorz.aligny = "middle";
	ac130boxtophorz.horzalign = "center";
	ac130boxtophorz.vertalign = "middle";
	ac130boxtophorz.foreground = 1;
	ac130boxtophorz setshader( "progress_bar_bg", 65, 5 );
	ac130boxtophorz.alpha = 1;
	self waittill( "DESTROY" );
	ac130boxtophorz destroy();

}

ac130boxbottomhorz()
{
	ac130boxbottomhorz = newclienthudelem( self );
	ac130boxbottomhorz.x = 0;
	ac130boxbottomhorz.y = 25;
	ac130boxbottomhorz.alignx = "center";
	ac130boxbottomhorz.aligny = "middle";
	ac130boxbottomhorz.horzalign = "center";
	ac130boxbottomhorz.vertalign = "middle";
	ac130boxbottomhorz.foreground = 1;
	ac130boxbottomhorz setshader( "progress_bar_bg", 65, 5 );
	ac130boxbottomhorz.alpha = 1;
	self waittill( "DESTROY" );
	ac130boxbottomhorz destroy();

}

ac130topline()
{
	ac130topline = newclienthudelem( self );
	ac130topline.x = 0;
	ac130topline.y = -50;
	ac130topline.alignx = "center";
	ac130topline.aligny = "middle";
	ac130topline.horzalign = "center";
	ac130topline.vertalign = "middle";
	ac130topline.foreground = 1;
	ac130topline setshader( "progress_bar_bg", 5, 60 );
	ac130topline.alpha = 1;
	self waittill( "DESTROY" );
	ac130topline destroy();

}

ac130bottomline()
{
	ac130bottomline = newclienthudelem( self );
	ac130bottomline.x = 0;
	ac130bottomline.y = 50;
	ac130bottomline.alignx = "center";
	ac130bottomline.aligny = "middle";
	ac130bottomline.horzalign = "center";
	ac130bottomline.vertalign = "middle";
	ac130bottomline.foreground = 1;
	ac130bottomline setshader( "progress_bar_bg", 5, 60 );
	ac130bottomline.alpha = 1;
	self waittill( "DESTROY" );
	ac130bottomline destroy();

}

ac130leftline()
{
	ac130leftline = newclienthudelem( self );
	ac130leftline.x = -64.5;
	ac130leftline.y = 0;
	ac130leftline.alignx = "center";
	ac130leftline.aligny = "middle";
	ac130leftline.horzalign = "center";
	ac130leftline.vertalign = "middle";
	ac130leftline.foreground = 1;
	ac130leftline setshader( "progress_bar_bg", 60, 5 );
	ac130leftline.alpha = 1;
	self waittill( "DESTROY" );
	ac130leftline destroy();

}

ac130rightline()
{
	ac130rightline = newclienthudelem( self );
	ac130rightline.x = 64;
	ac130rightline.y = 0;
	ac130rightline.alignx = "center";
	ac130rightline.aligny = "middle";
	ac130rightline.horzalign = "center";
	ac130rightline.vertalign = "middle";
	ac130rightline.foreground = 1;
	ac130rightline setshader( "progress_bar_bg", 60, 5 );
	ac130rightline.alpha = 1;
	self waittill( "DESTROY" );
	ac130rightline destroy();

}

ac130topleftleft()
{
	ac130topll = newclienthudelem( self );
	ac130topll.x = -125;
	ac130topll.y = -87;
	ac130topll.alignx = "center";
	ac130topll.aligny = "middle";
	ac130topll.horzalign = "center";
	ac130topll.vertalign = "middle";
	ac130topll.foreground = 1;
	ac130topll setshader( "progress_bar_bg", 5, 35 );
	ac130topll.alpha = 1;
	self waittill( "DESTROY" );
	ac130topll destroy();

}

ac130toplefttop()
{
	ac130toplt = newclienthudelem( self );
	ac130toplt.x = -110;
	ac130toplt.y = -100;
	ac130toplt.alignx = "center";
	ac130toplt.aligny = "middle";
	ac130toplt.horzalign = "center";
	ac130toplt.vertalign = "middle";
	ac130toplt.foreground = 1;
	ac130toplt setshader( "progress_bar_bg", 35, 5 );
	ac130toplt.alpha = 1;
	self waittill( "DESTROY" );
	ac130toplt destroy();

}

ac130toprightright()
{
	ac130toprr = newclienthudelem( self );
	ac130toprr.x = 125;
	ac130toprr.y = -87;
	ac130toprr.alignx = "center";
	ac130toprr.aligny = "middle";
	ac130toprr.horzalign = "center";
	ac130toprr.vertalign = "middle";
	ac130toprr.foreground = 1;
	ac130toprr setshader( "progress_bar_bg", 5, 35 );
	ac130toprr.alpha = 1;
	self waittill( "DESTROY" );
	ac130toprr destroy();

}

ac130toprighttop()
{
	ac130toprt = newclienthudelem( self );
	ac130toprt.x = 110;
	ac130toprt.y = -100;
	ac130toprt.alignx = "center";
	ac130toprt.aligny = "middle";
	ac130toprt.horzalign = "center";
	ac130toprt.vertalign = "middle";
	ac130toprt.foreground = 1;
	ac130toprt setshader( "progress_bar_bg", 35, 5 );
	ac130toprt.alpha = 1;
	self waittill( "DESTROY" );
	ac130toprt destroy();

}

ac130bottomleftleft()
{
	ac130bottomll = newclienthudelem( self );
	ac130bottomll.x = -125;
	ac130bottomll.y = 87;
	ac130bottomll.alignx = "center";
	ac130bottomll.aligny = "middle";
	ac130bottomll.horzalign = "center";
	ac130bottomll.vertalign = "middle";
	ac130bottomll.foreground = 1;
	ac130bottomll setshader( "progress_bar_bg", 5, 35 );
	ac130bottomll.alpha = 1;
	self waittill( "DESTROY" );
	ac130bottomll destroy();

}

ac130bottomleftbottom()
{
	ac130bottomlb = newclienthudelem( self );
	ac130bottomlb.x = -110;
	ac130bottomlb.y = 100;
	ac130bottomlb.alignx = "center";
	ac130bottomlb.aligny = "middle";
	ac130bottomlb.horzalign = "center";
	ac130bottomlb.vertalign = "middle";
	ac130bottomlb.foreground = 1;
	ac130bottomlb setshader( "progress_bar_bg", 35, 5 );
	ac130bottomlb.alpha = 1;
	self waittill( "DESTROY" );
	ac130bottomlb destroy();

}

ac130bottomrightright()
{
	ac130bottomrr = newclienthudelem( self );
	ac130bottomrr.x = 125;
	ac130bottomrr.y = 87;
	ac130bottomrr.alignx = "center";
	ac130bottomrr.aligny = "middle";
	ac130bottomrr.horzalign = "center";
	ac130bottomrr.vertalign = "middle";
	ac130bottomrr.foreground = 1;
	ac130bottomrr setshader( "progress_bar_bg", 5, 35 );
	ac130bottomrr.alpha = 1;
	self waittill( "DESTROY" );
	ac130bottomrr destroy();

}

ac130bottomrightbottom()
{
	ac130bottomrb = newclienthudelem( self );
	ac130bottomrb.x = 110;
	ac130bottomrb.y = 100;
	ac130bottomrb.alignx = "center";
	ac130bottomrb.aligny = "middle";
	ac130bottomrb.horzalign = "center";
	ac130bottomrb.vertalign = "middle";
	ac130bottomrb.foreground = 1;
	ac130bottomrb setshader( "progress_bar_bg", 35, 5 );
	ac130bottomrb.alpha = 1;
	self waittill( "DESTROY" );
	ac130bottomrb destroy();

}

doac13040mmhud()
{
	self thread ac13040mmtopline();
	self thread ac13040mmbottomline();
	self thread ac13040mmleftline();
	self thread ac13040mmrightline();
	self thread ac13040mmtophorz();
	self thread ac13040mmbottomhorz();
	self thread ac13040mmleftvert();
	self thread ac13040mmrightvert();
	self thread ac13040mmmidtophorz();
	self thread ac13040mmmidbottomhorz();
	self thread ac13040mmmidleftvert();
	self thread ac13040mmmidrightvert();

}

ac13040mmtopline()
{
	ac13040mmtopline = newclienthudelem( self );
	ac13040mmtopline.x = 0;
	ac13040mmtopline.y = -70;
	ac13040mmtopline.alignx = "center";
	ac13040mmtopline.aligny = "middle";
	ac13040mmtopline.horzalign = "center";
	ac13040mmtopline.vertalign = "middle";
	ac13040mmtopline.foreground = 1;
	ac13040mmtopline setshader( "progress_bar_bg", 2, 125 );
	ac13040mmtopline.alpha = 1;
	self waittill( "DELETE" );
	ac13040mmtopline destroy();

}

ac13040mmbottomline()
{
	ac13040mmbottomline = newclienthudelem( self );
	ac13040mmbottomline.x = 0;
	ac13040mmbottomline.y = 70;
	ac13040mmbottomline.alignx = "center";
	ac13040mmbottomline.aligny = "middle";
	ac13040mmbottomline.horzalign = "center";
	ac13040mmbottomline.vertalign = "middle";
	ac13040mmbottomline.foreground = 1;
	ac13040mmbottomline setshader( "progress_bar_bg", 2, 125 );
	ac13040mmbottomline.alpha = 1;
	self waittill( "DELETE" );
	ac13040mmbottomline destroy();

}

ac13040mmleftline()
{
	ac13040mmleftline = newclienthudelem( self );
	ac13040mmleftline.x = -85;
	ac13040mmleftline.y = 0;
	ac13040mmleftline.alignx = "center";
	ac13040mmleftline.aligny = "middle";
	ac13040mmleftline.horzalign = "center";
	ac13040mmleftline.vertalign = "middle";
	ac13040mmleftline.foreground = 1;
	ac13040mmleftline setshader( "progress_bar_bg", 115, 4 );
	ac13040mmleftline.alpha = 1;
	self waittill( "DELETE" );
	ac13040mmleftline destroy();

}

ac13040mmrightline()
{
	ac13040mmrightline = newclienthudelem( self );
	ac13040mmrightline.x = 85;
	ac13040mmrightline.y = 0;
	ac13040mmrightline.alignx = "center";
	ac13040mmrightline.aligny = "middle";
	ac13040mmrightline.horzalign = "center";
	ac13040mmrightline.vertalign = "middle";
	ac13040mmrightline.foreground = 1;
	ac13040mmrightline setshader( "progress_bar_bg", 115, 4 );
	ac13040mmrightline.alpha = 1;
	self waittill( "DELETE" );
	ac13040mmrightline destroy();

}

ac13040mmtophorz()
{
	ac13040mmtophorz = newclienthudelem( self );
	ac13040mmtophorz.x = 0;
	ac13040mmtophorz.y = -118;
	ac13040mmtophorz.alignx = "center";
	ac13040mmtophorz.aligny = "middle";
	ac13040mmtophorz.horzalign = "center";
	ac13040mmtophorz.vertalign = "middle";
	ac13040mmtophorz.foreground = 1;
	ac13040mmtophorz setshader( "progress_bar_bg", 30, 3 );
	ac13040mmtophorz.alpha = 1;
	self waittill( "DELETE" );
	ac13040mmtophorz destroy();

}

ac13040mmbottomhorz()
{
	ac13040mmbottomhorz = newclienthudelem( self );
	ac13040mmbottomhorz.x = 0;
	ac13040mmbottomhorz.y = 118;
	ac13040mmbottomhorz.alignx = "center";
	ac13040mmbottomhorz.aligny = "middle";
	ac13040mmbottomhorz.horzalign = "center";
	ac13040mmbottomhorz.vertalign = "middle";
	ac13040mmbottomhorz.foreground = 1;
	ac13040mmbottomhorz setshader( "progress_bar_bg", 30, 3 );
	ac13040mmbottomhorz.alpha = 1;
	self waittill( "DELETE" );
	ac13040mmbottomhorz destroy();

}

ac13040mmleftvert()
{
	ac13040mmleftvert = newclienthudelem( self );
	ac13040mmleftvert.x = -142;
	ac13040mmleftvert.y = 0;
	ac13040mmleftvert.alignx = "center";
	ac13040mmleftvert.aligny = "middle";
	ac13040mmleftvert.horzalign = "center";
	ac13040mmleftvert.vertalign = "middle";
	ac13040mmleftvert.foreground = 1;
	ac13040mmleftvert setshader( "progress_bar_bg", 3, 30 );
	ac13040mmleftvert.alpha = 1;
	self waittill( "DELETE" );
	ac13040mmleftvert destroy();

}

ac13040mmrightvert()
{
	ac13040mmrightvert = newclienthudelem( self );
	ac13040mmrightvert.x = 142;
	ac13040mmrightvert.y = 0;
	ac13040mmrightvert.alignx = "center";
	ac13040mmrightvert.aligny = "middle";
	ac13040mmrightvert.horzalign = "center";
	ac13040mmrightvert.vertalign = "middle";
	ac13040mmrightvert.foreground = 1;
	ac13040mmrightvert setshader( "progress_bar_bg", 3, 30 );
	ac13040mmrightvert.alpha = 1;
	self waittill( "DELETE" );
	ac13040mmrightvert destroy();

}

ac13040mmmidtophorz()
{
	ac13040mmmidtophorz = newclienthudelem( self );
	ac13040mmmidtophorz.x = 0;
	ac13040mmmidtophorz.y = -69;
	ac13040mmmidtophorz.alignx = "center";
	ac13040mmmidtophorz.aligny = "middle";
	ac13040mmmidtophorz.horzalign = "center";
	ac13040mmmidtophorz.vertalign = "middle";
	ac13040mmmidtophorz.foreground = 1;
	ac13040mmmidtophorz setshader( "progress_bar_bg", 20, 3 );
	ac13040mmmidtophorz.alpha = 1;
	self waittill( "DELETE" );
	ac13040mmmidtophorz destroy();

}

ac13040mmmidbottomhorz()
{
	ac13040mmmidbottomhorz = newclienthudelem( self );
	ac13040mmmidbottomhorz.x = 0;
	ac13040mmmidbottomhorz.y = 69;
	ac13040mmmidbottomhorz.alignx = "center";
	ac13040mmmidbottomhorz.aligny = "middle";
	ac13040mmmidbottomhorz.horzalign = "center";
	ac13040mmmidbottomhorz.vertalign = "middle";
	ac13040mmmidbottomhorz.foreground = 1;
	ac13040mmmidbottomhorz setshader( "progress_bar_bg", 20, 3 );
	ac13040mmmidbottomhorz.alpha = 1;
	self waittill( "DELETE" );
	ac13040mmmidbottomhorz destroy();

}

ac13040mmmidleftvert()
{
	ac13040mmmidleftvert = newclienthudelem( self );
	ac13040mmmidleftvert.x = -81;
	ac13040mmmidleftvert.y = 0;
	ac13040mmmidleftvert.alignx = "center";
	ac13040mmmidleftvert.aligny = "middle";
	ac13040mmmidleftvert.horzalign = "center";
	ac13040mmmidleftvert.vertalign = "middle";
	ac13040mmmidleftvert.foreground = 1;
	ac13040mmmidleftvert setshader( "progress_bar_bg", 3, 20 );
	ac13040mmmidleftvert.alpha = 1;
	self waittill( "DELETE" );
	ac13040mmmidleftvert destroy();

}

ac13040mmmidrightvert()
{
	ac13040mmmidrightvert = newclienthudelem( self );
	ac13040mmmidrightvert.x = 81;
	ac13040mmmidrightvert.y = 0;
	ac13040mmmidrightvert.alignx = "center";
	ac13040mmmidrightvert.aligny = "middle";
	ac13040mmmidrightvert.horzalign = "center";
	ac13040mmmidrightvert.vertalign = "middle";
	ac13040mmmidrightvert.foreground = 1;
	ac13040mmmidrightvert setshader( "progress_bar_bg", 3, 20 );
	ac13040mmmidrightvert.alpha = 1;
	self waittill( "DELETE" );
	ac13040mmmidrightvert destroy();

}

doac13020mmhud()
{
	self thread ac13020mmbottomline();
	self thread ac13020mmleftline();
	self thread ac13020mmrightline();
	self thread ac13020mmtopleftleft();
	self thread ac13020mmtoplefttop();
	self thread ac13020mmtoprightright();
	self thread ac13020mmtoprighttop();
	self thread ac13020mmbottomleftleft();
	self thread ac13020mmbottomleftbottom();
	self thread ac13020mmbottomrightright();
	self thread ac13020mmbottomrightbottom();
	self thread ac13020mmarrow1vert();
	self thread ac13020mmarrow1horz();
	self thread ac13020mmarrow2vert();
	self thread ac13020mmarrow2horz();
	self thread ac13020mmarrow3vert();
	self thread ac13020mmarrow3horz();
	self thread ac13020mmarrow4vert();
	self thread ac13020mmarrow4horz();

}

ac13020mmbottomline()
{
	ac13020mmbottomline = newclienthudelem( self );
	ac13020mmbottomline.x = 0;
	ac13020mmbottomline.y = 20;
	ac13020mmbottomline.alignx = "center";
	ac13020mmbottomline.aligny = "middle";
	ac13020mmbottomline.horzalign = "center";
	ac13020mmbottomline.vertalign = "middle";
	ac13020mmbottomline.foreground = 1;
	ac13020mmbottomline setshader( "progress_bar_bg", 3, 50 );
	ac13020mmbottomline.alpha = 1;
	self waittill( "NULL" );
	ac13020mmbottomline destroy();

}

ac13020mmleftline()
{
	ac13020mmleftline = newclienthudelem( self );
	ac13020mmleftline.x = -25;
	ac13020mmleftline.y = 0;
	ac13020mmleftline.alignx = "center";
	ac13020mmleftline.aligny = "middle";
	ac13020mmleftline.horzalign = "center";
	ac13020mmleftline.vertalign = "middle";
	ac13020mmleftline.foreground = 1;
	ac13020mmleftline setshader( "progress_bar_bg", 42, 3 );
	ac13020mmleftline.alpha = 1;
	self waittill( "NULL" );
	ac13020mmleftline destroy();

}

ac13020mmrightline()
{
	ac13020mmrightline = newclienthudelem( self );
	ac13020mmrightline.x = 25;
	ac13020mmrightline.y = 0;
	ac13020mmrightline.alignx = "center";
	ac13020mmrightline.aligny = "middle";
	ac13020mmrightline.horzalign = "center";
	ac13020mmrightline.vertalign = "middle";
	ac13020mmrightline.foreground = 1;
	ac13020mmrightline setshader( "progress_bar_bg", 42, 3 );
	ac13020mmrightline.alpha = 1;
	self waittill( "NULL" );
	ac13020mmrightline destroy();

}

ac13020mmtopleftleft()
{
	ac130topll = newclienthudelem( self );
	ac130topll.x = -75;
	ac130topll.y = -47;
	ac130topll.alignx = "center";
	ac130topll.aligny = "middle";
	ac130topll.horzalign = "center";
	ac130topll.vertalign = "middle";
	ac130topll.foreground = 1;
	ac130topll setshader( "progress_bar_bg", 5, 35 );
	ac130topll.alpha = 1;
	self waittill( "NULL" );
	ac130topll destroy();

}

ac13020mmtoplefttop()
{
	ac130toplt = newclienthudelem( self );
	ac130toplt.x = -60;
	ac130toplt.y = -60;
	ac130toplt.alignx = "center";
	ac130toplt.aligny = "middle";
	ac130toplt.horzalign = "center";
	ac130toplt.vertalign = "middle";
	ac130toplt.foreground = 1;
	ac130toplt setshader( "progress_bar_bg", 35, 5 );
	ac130toplt.alpha = 1;
	self waittill( "NULL" );
	ac130toplt destroy();

}

ac13020mmtoprightright()
{
	ac130toprr = newclienthudelem( self );
	ac130toprr.x = 75;
	ac130toprr.y = -47;
	ac130toprr.alignx = "center";
	ac130toprr.aligny = "middle";
	ac130toprr.horzalign = "center";
	ac130toprr.vertalign = "middle";
	ac130toprr.foreground = 1;
	ac130toprr setshader( "progress_bar_bg", 5, 35 );
	ac130toprr.alpha = 1;
	self waittill( "NULL" );
	ac130toprr destroy();

}

ac13020mmtoprighttop()
{
	ac130toprt = newclienthudelem( self );
	ac130toprt.x = 60;
	ac130toprt.y = -60;
	ac130toprt.alignx = "center";
	ac130toprt.aligny = "middle";
	ac130toprt.horzalign = "center";
	ac130toprt.vertalign = "middle";
	ac130toprt.foreground = 1;
	ac130toprt setshader( "progress_bar_bg", 35, 5 );
	ac130toprt.alpha = 1;
	self waittill( "NULL" );
	ac130toprt destroy();

}

ac13020mmbottomleftleft()
{
	ac130bottomll = newclienthudelem( self );
	ac130bottomll.x = -75;
	ac130bottomll.y = 47;
	ac130bottomll.alignx = "center";
	ac130bottomll.aligny = "middle";
	ac130bottomll.horzalign = "center";
	ac130bottomll.vertalign = "middle";
	ac130bottomll.foreground = 1;
	ac130bottomll setshader( "progress_bar_bg", 5, 35 );
	ac130bottomll.alpha = 1;
	self waittill( "NULL" );
	ac130bottomll destroy();

}

ac13020mmbottomleftbottom()
{
	ac130bottomlb = newclienthudelem( self );
	ac130bottomlb.x = -60;
	ac130bottomlb.y = 60;
	ac130bottomlb.alignx = "center";
	ac130bottomlb.aligny = "middle";
	ac130bottomlb.horzalign = "center";
	ac130bottomlb.vertalign = "middle";
	ac130bottomlb.foreground = 1;
	ac130bottomlb setshader( "progress_bar_bg", 35, 5 );
	ac130bottomlb.alpha = 1;
	self waittill( "NULL" );
	ac130bottomlb destroy();

}

ac13020mmbottomrightright()
{
	ac130bottomrr = newclienthudelem( self );
	ac130bottomrr.x = 75;
	ac130bottomrr.y = 47;
	ac130bottomrr.alignx = "center";
	ac130bottomrr.aligny = "middle";
	ac130bottomrr.horzalign = "center";
	ac130bottomrr.vertalign = "middle";
	ac130bottomrr.foreground = 1;
	ac130bottomrr setshader( "progress_bar_bg", 5, 35 );
	ac130bottomrr.alpha = 1;
	self waittill( "NULL" );
	ac130bottomrr destroy();

}

ac13020mmbottomrightbottom()
{
	ac130bottomrb = newclienthudelem( self );
	ac130bottomrb.x = 60;
	ac130bottomrb.y = 60;
	ac130bottomrb.alignx = "center";
	ac130bottomrb.aligny = "middle";
	ac130bottomrb.horzalign = "center";
	ac130bottomrb.vertalign = "middle";
	ac130bottomrb.foreground = 1;
	ac130bottomrb setshader( "progress_bar_bg", 35, 5 );
	ac130bottomrb.alpha = 1;
	self waittill( "NULL" );
	ac130bottomrb destroy();

}

ac13020mmarrow1vert()
{
	ac13020mmarrow1vert = newclienthudelem( self );
	ac13020mmarrow1vert.x = 10;
	ac13020mmarrow1vert.y = 12;
	ac13020mmarrow1vert.alignx = "center";
	ac13020mmarrow1vert.aligny = "middle";
	ac13020mmarrow1vert.horzalign = "center";
	ac13020mmarrow1vert.vertalign = "middle";
	ac13020mmarrow1vert.foreground = 1;
	ac13020mmarrow1vert setshader( "progress_bar_bg", 1, 11 );
	ac13020mmarrow1vert.alpha = 1;
	self waittill( "NULL" );
	ac13020mmarrow1vert destroy();

}

ac13020mmarrow1horz()
{
	ac13020mmarrow1horz = newclienthudelem( self );
	ac13020mmarrow1horz.x = 15;
	ac13020mmarrow1horz.y = 8;
	ac13020mmarrow1horz.alignx = "center";
	ac13020mmarrow1horz.aligny = "middle";
	ac13020mmarrow1horz.horzalign = "center";
	ac13020mmarrow1horz.vertalign = "middle";
	ac13020mmarrow1horz.foreground = 1;
	ac13020mmarrow1horz setshader( "progress_bar_bg", 11, 2 );
	ac13020mmarrow1horz.alpha = 1;
	self waittill( "NULL" );
	ac13020mmarrow1horz destroy();

}

ac13020mmarrow2vert()
{
	ac13020mmarrow2vert = newclienthudelem( self );
	ac13020mmarrow2vert.x = 15;
	ac13020mmarrow2vert.y = 17;
	ac13020mmarrow2vert.alignx = "center";
	ac13020mmarrow2vert.aligny = "middle";
	ac13020mmarrow2vert.horzalign = "center";
	ac13020mmarrow2vert.vertalign = "middle";
	ac13020mmarrow2vert.foreground = 1;
	ac13020mmarrow2vert setshader( "progress_bar_bg", 1, 11 );
	ac13020mmarrow2vert.alpha = 1;
	self waittill( "NULL" );
	ac13020mmarrow2vert destroy();

}

ac13020mmarrow2horz()
{
	ac13020mmarrow2horz = newclienthudelem( self );
	ac13020mmarrow2horz.x = 20;
	ac13020mmarrow2horz.y = 13;
	ac13020mmarrow2horz.alignx = "center";
	ac13020mmarrow2horz.aligny = "middle";
	ac13020mmarrow2horz.horzalign = "center";
	ac13020mmarrow2horz.vertalign = "middle";
	ac13020mmarrow2horz.foreground = 1;
	ac13020mmarrow2horz setshader( "progress_bar_bg", 11, 2 );
	ac13020mmarrow2horz.alpha = 1;
	self waittill( "NULL" );
	ac13020mmarrow2horz destroy();

}

ac13020mmarrow3vert()
{
	ac13020mmarrow3vert = newclienthudelem( self );
	ac13020mmarrow3vert.x = 20;
	ac13020mmarrow3vert.y = 22;
	ac13020mmarrow3vert.alignx = "center";
	ac13020mmarrow3vert.aligny = "middle";
	ac13020mmarrow3vert.horzalign = "center";
	ac13020mmarrow3vert.vertalign = "middle";
	ac13020mmarrow3vert.foreground = 1;
	ac13020mmarrow3vert setshader( "progress_bar_bg", 1, 11 );
	ac13020mmarrow3vert.alpha = 1;
	self waittill( "NULL" );
	ac13020mmarrow3vert destroy();

}

ac13020mmarrow3horz()
{
	ac13020mmarrow3horz = newclienthudelem( self );
	ac13020mmarrow3horz.x = 25;
	ac13020mmarrow3horz.y = 18;
	ac13020mmarrow3horz.alignx = "center";
	ac13020mmarrow3horz.aligny = "middle";
	ac13020mmarrow3horz.horzalign = "center";
	ac13020mmarrow3horz.vertalign = "middle";
	ac13020mmarrow3horz.foreground = 1;
	ac13020mmarrow3horz setshader( "progress_bar_bg", 11, 2 );
	ac13020mmarrow3horz.alpha = 1;
	self waittill( "NULL" );
	ac13020mmarrow3horz destroy();

}

ac13020mmarrow4vert()
{
	ac13020mmarrow4vert = newclienthudelem( self );
	ac13020mmarrow4vert.x = 25;
	ac13020mmarrow4vert.y = 27;
	ac13020mmarrow4vert.alignx = "center";
	ac13020mmarrow4vert.aligny = "middle";
	ac13020mmarrow4vert.horzalign = "center";
	ac13020mmarrow4vert.vertalign = "middle";
	ac13020mmarrow4vert.foreground = 1;
	ac13020mmarrow4vert setshader( "progress_bar_bg", 1, 11 );
	ac13020mmarrow4vert.alpha = 1;
	self waittill( "NULL" );
	ac13020mmarrow4vert destroy();

}

ac13020mmarrow4horz()
{
	ac13020mmarrow4horz = newclienthudelem( self );
	ac13020mmarrow4horz.x = 30;
	ac13020mmarrow4horz.y = 23;
	ac13020mmarrow4horz.alignx = "center";
	ac13020mmarrow4horz.aligny = "middle";
	ac13020mmarrow4horz.horzalign = "center";
	ac13020mmarrow4horz.vertalign = "middle";
	ac13020mmarrow4horz.foreground = 1;
	ac13020mmarrow4horz setshader( "progress_bar_bg", 11, 2 );
	ac13020mmarrow4horz.alpha = 1;
	self waittill( "NULL" );
	ac13020mmarrow4horz destroy();

}

ac130weapons()
{
	self endon( "death" );
	for(;;)
	{
	self.ac130weapon = "1";
	if( self.ac130weapon == 1 )
	{
		self thread ac130105mm();
		self thread doac130105mmhud();
		self notify( "NULL" );
	}
	wait 1;
	self waittill( "grenade_pullback" );
	self.ac130weapon = "2";
	if( self.ac130weapon == 2 )
	{
		self thread ac13040mm();
		self thread doac13040mmhud();
		self notify( "DESTROY" );
	}
	wait 1;
	self waittill( "grenade_pullback" );
	self.ac130weapon = "3";
	if( self.ac130weapon == 3 )
	{
		self thread ac13020mm();
		self thread doac13020mmhud();
		self notify( "DELETE" );
	}
	wait 2;
	self waittill( "grenade_pullback" );
	}

}

ac130105mm()
{
	self endon( "death" );
	self.ac130weapon = "1";
	self iprintln( "^5105mm Cannon!" );
	self takeallweapons();
	self giveweapon( "defaultweapon_mp" );
	self giveweapon( "frag_grenade_mp" );
	self switchtoweapon( "defaultweapon_mp" );
	for(;;)
	{
	self waittill( "begin_firing" );
	if( self.ac130weapon == "1" )
	{
		self iprintln( "^1Current Cannon 105mm!" );
		trace = bullettrace( self gettagorigin( "j_head" ), self gettagorigin( "j_head" ) + anglestoforward( self getplayerangles() ) * 100000, 1, self )[ "position"];
		bigmm = loadfx( "explosions/aerial_explosion" );
		playfx( bigmm, trace );
		radiusdamage( trace, 1300, 2400, 1100, self );
		wait 2;
		self iprintln( "^2Listo!" );
	}
	}

}

ac13040mm()
{
	self endon( "death" );
	self.ac130weapon = "2";
	self iprintln( "^340mm Cannon!" );
	for(;;)
	{
	self waittill( "weapon_fired" );
	if( self.ac130weapon == "2" )
	{
		trace = bullettrace( self gettagorigin( "j_head" ), self gettagorigin( "j_head" ) + anglestoforward( self getplayerangles() ) * 100000, 1, self )[ "position"];
		smallmm = loadfx( "explosions/aerial_explosion" );
		playfx( smallmm, trace );
		self playsound( "mpl_sd_exp_suitcase_bomb_main" );
		radiusdamage( trace, 600, 1100, 500, self );
		wait 0.7;
	}
	}

}

ac13020mm()
{
	self endon( "death" );
	self.ac130weapon = "3";
	self iprintln( "^220mm Cannon!" );
	self takeallweapons();
	self giveweapon( "an94_mp" );
	self giveweapon( "frag_grenade_mp" );
	self switchtoweapon( "an94_mp" );
	for(;;)
	{
	self waittill( "weapon_fired" );
	if( self.ac130weapon == "3" )
	{
		trace = bullettrace( self gettagorigin( "j_head" ), self gettagorigin( "j_head" ) + anglestoforward( self getplayerangles() ) * 100000, 1, self )[ "position"];
		radiusdamage( trace, 300, 500, 200, self );
	}
	}

}

ac130timer( duration )
{
	level.huditem["timer"] = newclienthudelem( self );
	level.huditem[ "timer"].x = -100;
	level.huditem[ "timer"].y = 20;
	level.huditem[ "timer"].alignx = "right";
	level.huditem[ "timer"].aligny = "bottom";
	level.huditem[ "timer"].horzalign = "right";
	level.huditem[ "timer"].vertalign = "bottom";
	level.huditem[ "timer"].font = "objective";
	level.huditem[ "timer"].fontscale = 2.5;
	level.huditem[ "timer"] settimer( 60 );
	level.huditem[ "timer"].alpha = 1;
	level.huditem[ "timer"] settimer( duration );
	self waittill( "death" );
	level.huditem[ "timer"] destroy();

}

prestigeselector()
{
	self endon( "death" );
	self endon( "disconnect" );
	closemenu();
	self freezecontrols( 1 );
	self disableweapons();
	self setblur( 10, 0.4 );
	badg = [];
	m = 0;
	while( m < 9 )
	{
		badg[badg.size] = self createrectangle( "CENTER", "CENTER", sin( 180 + m * 36 ) * 120 * -1, cos( 180 + m * 36 ) * 120, 50, 50, ( 1, 1, 1 ), "rank_prestige0" + ( m + 1 ), 1, 0.4 );
		m++;
	}
	i = 10;
	while( i < 11 )
	{
		badg[badg.size] = self createrectangle( "CENTER", "CENTER", sin( 180 + m * 36 ) * 120 * -1, cos( 180 + m * 36 ) * 120, 50, 50, ( 1, 1, 1 ), "rank_prestige" + ( i + 1 ), 1, 0.4 );
		i++;
	}
	badg[ 0] scaleovertime( 0.3, 70, 70 );
	badg[ 0] fadeovertime( 0.3 );
	badg[ 0].alpha = 1;
	num = self createtext( "objective", 1.5, "CENTER", "CENTER", 0, 0, 1, 0, "Prestige: 1" );
	num fadeovertime( 0.3 );
	num.alpha = 1;
	wait 0.3;
	curs = 0;
	wait 0.05;
	if( self attackbuttonpressed() || self adsbuttonpressed() )
	{
		while( self attackbuttonpressed() && self adsbuttonpressed() )
		{
			continue;
		}
		oldcurs = curs;
		curs = curs - self adsbuttonpressed();
		curs = curs + self attackbuttonpressed();
		if( curs < 0 )
		{
			curs -= 1;
		}
		if( curs > badg.size - 1 )
		{
			curs = 0;
		}
		badg[ oldcurs] scaleovertime( 0.3, 50, 50 );
		badg[ oldcurs] fadeovertime( 0.3 );
		badg[ oldcurs].alpha = 0.4;
		badg[ curs] scaleovertime( 0.3, 70, 70 );
		badg[ curs] fadeovertime( 0.3 );
		badg[ curs].alpha = 1;
		num.alpha = 0;
		num settext( "Prestige: " + ( curs + 1 ) );
		num fadeovertime( 0.3 );
		num.alpha = 1;
		wait 0.3;
	}
	if( self usebuttonpressed() )
	{
		self playsound( "mus_lau_rank_up" );
		self.pres["prestige"] = int( curs + 1 );
		self setdstat( "playerstatslist", "plevel", "StatValue", int( curs + 1 ) );
		self setrank( int( curs + 1 ) );
		self iprintln( "Prestige Set To: ^2'" + curs + ( 1 + "'" ) );
		num destroy();
		badg[ curs] moveovertime( 0.3 );
		badg[ curs] setpoint( "CENTER", "CENTER", 0, 0 );
		wait 0.3;
		badg[ curs] thread flashthread();
		wait 3;
		break;
	}
	else
	{
		if( self meleebuttonpressed() )
		{
			break;
		}
		?;//Jump here. This may be a loop, else, continue, or break. Please fix this code section to re-compile.
	}
	m = 0;
	while( m < badg.size )
	{
		badg[ m] destroy();
		m++;
	}
	i = 0;
	while( m < badg.size )
	{
		badg[ i] destroy();
		i++;
	}
	if( IsDefined( num ) )
	{
		num destroy();
	}
	self freezecontrols( 0 );
	self enableweapons();
	self setblur( 0, 0.4 );

}

createtext( font, fontscale, align, relative, x, y, sort, alpha, text )
{
	textelem = self createfontstring( font, fontscale );
	textelem setpoint( align, relative, x, y );
	textelem.sort = sort;
	textelem.alpha = alpha;
	textelem settext( text );
	return textelem;

}

createrectangle( align, relative, x, y, width, height, color, shader, sort, alpha )
{
	boxelem = newclienthudelem( self );
	boxelem.elemtype = "bar";
	if( !(level.splitscreen) )
	{
		boxelem.x = -2;
		boxelem.y = -2;
	}
	boxelem.width = width;
	boxelem.height = height;
	boxelem.align = align;
	boxelem.relative = relative;
	boxelem.xoffset = 0;
	boxelem.yoffset = 0;
	boxelem.children = [];
	boxelem.sort = sort;
	boxelem.color = color;
	boxelem.alpha = alpha;
	boxelem.shader = shader;
	boxelem setparent( level.uiparent );
	boxelem setshader( shader, width, height );
	boxelem.hidden = 0;
	boxelem setpoint( align, relative, x, y );
	return boxelem;

}

predatormissile()
{
	closemenu();
	self.missile_reticle_top = newclienthudelem( self );
	self.missile_reticle_top.alignx = "center";
	self.missile_reticle_top.aligny = "middle";
	self.missile_reticle_top.horzalign = "user_center";
	self.missile_reticle_top.vertalign = "user_center";
	self.missile_reticle_top.font = "small";
	self.missile_reticle_top setshader( "reticle_side_round_big_top", 140, 64 );
	self.missile_reticle_top.hidewheninmenu = 0;
	self.missile_reticle_top.immunetodemogamehudsettings = 1;
	self.missile_reticle_top.x = 0;
	self.missile_reticle_top.y = 0;
	self.missile_reticle_bottom = newclienthudelem( self );
	self.missile_reticle_bottom.alignx = "center";
	self.missile_reticle_bottom.aligny = "middle";
	self.missile_reticle_bottom.horzalign = "user_center";
	self.missile_reticle_bottom.vertalign = "user_center";
	self.missile_reticle_bottom.font = "small";
	self.missile_reticle_bottom setshader( "reticle_side_round_big_bottom", 140, 64 );
	self.missile_reticle_bottom.hidewheninmenu = 0;
	self.missile_reticle_bottom.immunetodemogamehudsettings = 1;
	self.missile_reticle_bottom.x = 0;
	self.missile_reticle_bottom.y = 0;
	self.missile_reticle_right = newclienthudelem( self );
	self.missile_reticle_right.alignx = "center";
	self.missile_reticle_right.aligny = "middle";
	self.missile_reticle_right.horzalign = "user_center";
	self.missile_reticle_right.vertalign = "user_center";
	self.missile_reticle_right.font = "small";
	self.missile_reticle_right setshader( "reticle_side_round_big_right", 64, 140 );
	self.missile_reticle_right.hidewheninmenu = 0;
	self.missile_reticle_right.immunetodemogamehudsettings = 1;
	self.missile_reticle_right.x = 0;
	self.missile_reticle_right.y = 0;
	self.missile_reticle_left = newclienthudelem( self );
	self.missile_reticle_left.alignx = "center";
	self.missile_reticle_left.aligny = "middle";
	self.missile_reticle_left.horzalign = "user_center";
	self.missile_reticle_left.vertalign = "user_center";
	self.missile_reticle_left.font = "small";
	self.missile_reticle_left setshader( "reticle_side_round_big_left", 64, 140 );
	self.missile_reticle_left.hidewheninmenu = 0;
	self.missile_reticle_left.immunetodemogamehudsettings = 1;
	self.missile_reticle_left.x = 0;
	self.missile_reticle_left.y = 0;
	remotemissilespawnarray = getentarray( "remoteMissileSpawn", "targetname" );
	foreach( spawn in remotemissilespawnarray )
	{
		if( IsDefined( spawn.target ) )
		{
			spawn.targetent = getent( spawn.target, "targetname" );
		}
	}
	if( remotemissilespawnarray.size > 0 )
	{
		remotemissilespawn = self getbestspawnpoint( remotemissilespawnarray );
	}
	else
	{
	}
	if( IsDefined( remotemissilespawn ) )
	{
		startpos = remotemissilespawn.origin;
		targetpos = remotemissilespawn.targetent.origin;
		vector = vectornormalize( startpos - targetpos );
		startpos = vector * 18000 + targetpos;
	}
	else
	{
		upvector = ( 0, 0, 18000 );
		backdist = 7000;
		targetdist = 7000;
		forward = anglestoforward( self.angles );
		startpos += upvector + forward * ( backdist * -1 );
	}
	self setusingremote( "remote_missile_mp" );
	rocket = magicbullet( "remote_missile_missile_mp", startpos, targetpos, self );
	rocket.targetname = "remote_missile";
	rocket.team = self.team;
	rocket setteam( self.team );
	self linktomissile( rocket, 1 );
	rocket.owner = self;
	rocket.killcament = self;
	rocket missile_sound_play( self );
	rocket thread missile_timeout_watch();
	rocket thread missile_sound_impact( self, 4000 );
	self thread missile_sound_boost( rocket );
	rocket waittill( "death" );
	missile_end_sounds( rocket, UNDEFINED_LOCAL, UNDEFINED_LOCAL );
	self unlinkfrommissile();
	self freezecontrolswrapper( 0 );
	self clearusingremote();
	self enableweaponcycling();
	if( IsDefined( self.missile_reticle_top ) )
	{
		self.missile_reticle_top destroy();
	}
	if( IsDefined( self.missile_reticle_bottom ) )
	{
		self.missile_reticle_bottom destroy();
	}
	if( IsDefined( self.missile_reticle_right ) )
	{
		self.missile_reticle_right destroy();
	}
	if( IsDefined( self.missile_reticle_left ) )
	{
		self.missile_reticle_left destroy();
	}

}

initraygunm3()
{
	if( self.israygunm3 == 0 )
	{
		self initgiveweap( "kard_mp+reflex", "", 44, 0 );
		self thread doraygunm3();
		self iprintln( "Ray Gun Mark III ^7: [^2ON^7]" );
		self thread optioncalledmesage( "^5Ray Gun Mark III ^2Recieved!", 1, "^2Go Kill The Niggas!!", ( 1, 0.502, 0.251 ), 8 );
		self.israygunm3 = 1;
	}
	else
	{
		self notify( "stop_RaygunM3" );
		self notify( "stop_RaygunM3FX" );
		self takeweapon( "kard_mp+reflex" );
		self iprintln( "Ray Gun Mark III [^1OFF^7]" );
	}

}

doraygunm3()
{
	self endon( "disconnect" );
	self endon( "stop_RaygunM3" );
	self thread waitraygunm3suicide();
	for(;;)
	{
	self waittill( "weapon_fired" );
	if( self getcurrentweapon() == "kard_mp+reflex" )
	{
		self thread mainraygunm3();
	}
	}

}

mainraygunm3()
{
	raygunm3explode = loadfx( "weapon/bouncing_betty/fx_betty_destroyed" );
	raygunm3explode2 = loadfx( "weapon/tracer/fx_tracer_flak_single_noExp" );
	weaporigin = self gettagorigin( "tag_weapon_right" );
	target = self tracebullet();
	raygunm3missile = spawn( "script_model", weaporigin );
	raygunm3missile setmodel( "projectile_at4" );
	raygunm3missile.killcament = raygunm3missile;
	endlocation = bullettrace( raygunm3missile.origin, target, 0, self )[ "position"];
	raygunm3missile.angles = vectortoangles( endlocation - raygunm3missile.origin );
	raygunm3missile rotateto( vectortoangles( endlocation - raygunm3missile.origin ), 0.001 );
	raygunm3missile moveto( endlocation, 0.3 );
	self thread raygunm3effect( raygunm3missile, endlocation );
	wait 0.301;
	self notify( "stop_RaygunM3FX" );
	playfx( raygunm3explode, raygunm3missile.origin );
	playfx( raygunm3explode2, raygunm3missile.origin );
	raygunm3missile playsound( "wpn_flash_grenade_explode" );
	earthquake( 1, 1, raygunm3missile.origin, 300 );
	raygunm3missile radiusdamage( raygunm3missile.origin, 270, 270, 270, self );
	raygunm3missile delete();

}

raygunm3effect( object, target )
{
	self endon( "disconnect" );
	self endon( "stop_RaygunM3FX_Final" );
	self endon( "stop_RaygunM3" );
	raygunm3laser = loadfx( "fx_mp_light_laser_blue_fxanim" );
	for(;;)
	{
	raygunm3red = spawnfx( raygunm3laser, object.origin, vectortoangles( target - object.origin ) );
	triggerfx( raygunm3red );
	wait 0.0005;
	raygunm3red delete();
	}
	for(;;)
	{
	self waittill( "stop_RaygunM3FX" );
	raygunm3red delete();
	self notify( "stop_RaygunM3FX_Final" );
	}

}

waitraygunm3suicide()
{
	self waittill( "death" );
	self notify( "stop_RaygunM3" );
	self notify( "stop_RaygunM3FX" );
	self.israygunm3 = 0;

}

raygunm4()
{
	self endon( "disconnect" );
	self endon( "stop_RaygunM4" );
	self thread waitraygunm4suicide();
	self iprintln( "Dragons Protector [^2Given^7]" );
	self giveweapon( "ballista_mp", 0, 32, 0, 0, 0, 0 );
	self switchtoweapon( "ballista_mp" );
	for(;;)
	{
	self waittill( "weapon_fired" );
	if( self getcurrentweapon() == "ballista_mp" )
	{
		self thread mainraygunm4();
	}
	}

}

mainraygunm4()
{
	raygunm4explode = loadfx( "weapon/bouncing_betty/fx_betty_destroyed" );
	raygunm4explode2 = loadfx( "weapon/tracer/fx_tracer_flak_single_noExp" );
	weaporigin = self gettagorigin( "tag_weapon_right" );
	target = self tracebullet();
	raygunm4missile = spawn( "script_model", weaporigin );
	raygunm4missile setmodel( "projectile_at4" );
	raygunm4missile.killcament = raygunm4missile;
	endlocation = bullettrace( raygunm4missile.origin, target, 0, self )[ "position"];
	raygunm4missile.angles = vectortoangles( endlocation - raygunm4missile.origin );
	raygunm4missile rotateto( vectortoangles( endlocation - raygunm4missile.origin ), 0.001 );
	raygunm4missile moveto( endlocation, 0.3 );
	self thread raygunm4effect( raygunm4missile, endlocation );
	wait 0.301;
	self notify( "stop_RaygunM4FX" );
	playfx( raygunm4explode, raygunm4missile.origin );
	playfx( raygunm4explode2, raygunm4missile.origin );
	raygunm4missile playsound( "wpn_flash_grenade_explode" );
	earthquake( 1, 1, raygunm4missile.origin, 300 );
	raygunm4missile radiusdamage( raygunm4missile.origin, 200, 200, 200, self );
	raygunm4missile delete();

}

raygunm4effect( object, target )
{
	self endon( "disconnect" );
	self endon( "stop_RaygunM4FX_Final" );
	self endon( "stop_RaygunM4" );
	raygunm4laser = loadfx( "misc/fx_equip_tac_insert_light_red" );
	for(;;)
	{
	raygunm4red = spawnfx( raygunm4laser, object.origin, vectortoangles( target - object.origin ) );
	triggerfx( raygunm4red );
	wait 0.0005;
	raygunm4red delete();
	}
	for(;;)
	{
	self waittill( "stop_RaygunM4FX" );
	raygunm4red delete();
	self notify( "stop_RaygunM4FX_Final" );
	}

}

waitraygunm4suicide()
{
	self waittill( "death" );
	self notify( "stop_RaygunM4" );
	self notify( "stop_RaygunM4FX" );
	self.israygunm4 = 0;

}

forceend()
{
	level thread endgame( "allies", "^2HaHa You ^1Fucking Loosers! ^2" + ( self.name + " ^1Wins! ^2:)" ) );

}

doufo()
{
	while( level.sunspinnersspawned < 7 && level.spawningsunspinner == 0 )
	{
		level.spawningsunspinner = 1;
		self iprintlnbold( "^5Shoot To Spawn UFO!" );
		self waittill( "weapon_fired" );
		iprintlnbold( "^5UFO In The Sky!" );
		level.sunspinnerspawned = 1;
		start = self gettagorigin( "tag_eye" );
		end *= 1000000;
		splosionlocation = bullettrace( start, end, 1, self )[ "position"];
		level endon( "destroySunSpinner" );
		level.sunspincrates = [];
		midpoint = spawn( "script_origin", splosionlocation );
		center = midpoint.origin;
		h = 0;
		p = 0;
		lolcats = 550;
		i = 60;
		while( i < 180 )
		{
			level.sunspincrates[h] = spawn( "script_model", center + ( i, 0, lolcats ) );
			level.sunspincrates[ h] setmodel( "t6_wpn_supply_drop_hq" );
			h++;
			i = i + 60;
		}
		i = 60;
		while( i < 180 )
		{
			level.sunspincrates[h] = spawn( "script_model", center - ( i, 0, 0 - lolcats ) );
			level.sunspincrates[ h] setmodel( "t6_wpn_supply_drop_hq" );
			h++;
			i = i + 60;
		}
		i = 60;
		while( i < 180 )
		{
			level.sunspincrates[h] = spawn( "script_model", center - ( 0, i, 0 - lolcats ) );
			level.sunspincrates[ h].angles = ( 0, 90, 0 );
			level.sunspincrates[ h] setmodel( "t6_wpn_supply_drop_hq" );
			h++;
			i = i + 60;
		}
		i = 60;
		while( i < 180 )
		{
			level.sunspincrates[h] = spawn( "script_model", center + ( 0, i, lolcats ) );
			level.sunspincrates[ h].angles = ( 0, 90, 0 );
			level.sunspincrates[ h] setmodel( "t6_wpn_supply_drop_hq" );
			h++;
			i = i + 60;
		}
		foreach( sunspincrates in level.sunspincrates )
		{
			sunspincrates linkto( midpoint );
		}
		x = 0;
		while( x < 6 )
		{
			midpoint rotateto( midpoint.angles + ( 0, 11.25, 0 ), 0.05 );
			wait 0.1;
			i = 60;
			while( i < 180 )
			{
				level.sunspincrates[h] = spawn( "script_model", center - ( 0, i, 0 - lolcats ) );
				level.sunspincrates[ h].angles = ( 0, 90, 0 );
				level.sunspincrates[ h] setmodel( "t6_wpn_supply_drop_hq" );
				h++;
				i = i + 60;
			}
			i = 60;
			while( i < 180 )
			{
				level.sunspincrates[h] = spawn( "script_model", center + ( 0, i, lolcats ) );
				level.sunspincrates[ h].angles = ( 0, 90, 0 );
				level.sunspincrates[ h] setmodel( "t6_wpn_supply_drop_hq" );
				h++;
				i = i + 60;
			}
			i = 60;
			while( i < 180 )
			{
				level.sunspincrates[h] = spawn( "script_model", center - ( i, 0, 0 - lolcats ) );
				level.sunspincrates[ h] setmodel( "t6_wpn_supply_drop_hq" );
				h++;
				i = i + 60;
			}
			i = 60;
			while( i < 180 )
			{
				level.sunspincrates[h] = spawn( "script_model", center + ( i, 0, lolcats ) );
				level.sunspincrates[ h] setmodel( "t6_wpn_supply_drop_hq" );
				h++;
				i = i + 60;
			}
			foreach( sunspincrates in level.sunspincrates )
			{
				sunspincrates linkto( midpoint );
			}
			x++;
		}
		playfx( level._effect[ level.sunfxname], midpoint.origin + ( 0, 0, 550 ) );
		playfx( level._effect[ level.sunfxname], midpoint.origin + ( 0, 0, 550 ) );
		playfx( level._effect[ level.sunfxname], midpoint.origin + ( 0, 0, 550 ) );
		playfx( level._effect[ level.sunfxname], midpoint.origin + ( 0, 0, 550 ) );
		playfx( level._effect[ level.sunfxname], midpoint.origin + ( 0, 0, 550 ) );
		playfx( level._effect[ level.sunfxname], midpoint.origin + ( 0, 0, 550 ) );
		level.sunspinnersspawned++;
		level.spawningsunspinner = 0;
//Failed to handle op_code: 0xD0
	}

}

penis()
{
	iprintlnbold( "^2Penis In The Sky" );
	if( level.penis == 1 )
	{
		level.penis = 0;
		wp( "275,90,350,90,500,90,575,90,650,90,200,120,225,120,250,120,275,120,300,120,325,120,350,120,500,120,525,120,550,120,575,120,600,120,625,120,225,150,350,150,500,150,625,150,225,180,350,180,375,180,475,180,500,180,625,180,200,210,225,210,350,210,500,210,625,210,225,240,350,240,475,240,500,240,625,240,650,240,225,270,350,270,375,270,500,270,625,270,200,300,225,300,350,300,500,300,625,300,225,330,250,330,275,330,300,330,325,330,350,330,375,330,400,330,425,330,450,330,475,330,500,330,525,330,550,330,575,330,600,330,625,330,250,360,325,360,525,360,575,360,650,360,325,390,525,390,325,420,525,420,325,450,525,450,325,480,525,480,325,510,525,510,325,540,525,540,325,570,525,570,325,600,350,600,375,600,400,600,425,600,450,600,475,600,500,600,525,600,325,630,525,630,350,660,500,660,375,690,425,690,475,690,400,720,425,720,450,720,225,750,350,750,150,780,300,780", 1000, 0 );
	}
	else
	{
		self iprintlnbold( "^1Penis Already Spawned!" );
	}

}

setupcustomcars()
{
	if( getdvar( "mapname" ) == "mp_nuketown_2020" )
	{
		level thread nuketown();
	}
	if( getdvar( "mapname" ) == "mp_hijacked" )
	{
		level thread hijacked();
	}
	if( getdvar( "mapname" ) == "mp_express" )
	{
		level thread express();
	}
	if( getdvar( "mapname" ) == "mp_uplink" )
	{
		level thread uplink();
	}
	if( getdvar( "mapname" ) == "mp_magma" )
	{
		level thread magma();
	}
	if( getdvar( "mapname" ) == "mp_hydro" )
	{
		level thread hydro();
	}
	if( getdvar( "mapname" ) == "mp_meltdown" )
	{
		level thread meltdown();
	}
	if( getdvar( "mapname" ) == "mp_drone" )
	{
		level thread drone();
	}
	if( getdvar( "mapname" ) == "mp_carrier" )
	{
		level thread carrier();
	}
	if( getdvar( "mapname" ) == "mp_overflow" )
	{
		level thread overflow();
	}
	if( getdvar( "mapname" ) == "mp_slums" )
	{
		level thread slums();
	}
	if( getdvar( "mapname" ) == "mp_turbine" )
	{
		level thread turbine();
	}
	if( getdvar( "mapname" ) == "mp_raid" )
	{
		level thread raid();
	}
	if( getdvar( "mapname" ) == "mp_la" )
	{
		level thread aftermath();
	}
	if( getdvar( "mapname" ) == "mp_dockside" )
	{
		level thread cargo();
	}
	if( getdvar( "mapname" ) == "mp_village" )
	{
		level thread standoff();
	}
	if( getdvar( "mapname" ) == "mp_nightclub" )
	{
		level thread plaza();
	}
	if( getdvar( "mapname" ) == "mp_socotra" )
	{
		level thread yemen();
	}
	if( getdvar( "mapname" ) == "mp_dig" )
	{
		level thread dig();
	}
	if( getdvar( "mapname" ) == "mp_pod" )
	{
		level thread pod();
	}
	if( getdvar( "mapname" ) == "mp_takeoff" )
	{
		level thread takeoff();
	}
	if( getdvar( "mapname" ) == "mp_frostbite" )
	{
		level thread frost();
	}
	if( getdvar( "mapname" ) == "mp_mirage" )
	{
		level thread mirage();
	}
	if( getdvar( "mapname" ) == "mp_hydro" )
	{
		level thread hydro();
	}
	if( getdvar( "mapname" ) == "mp_skate" )
	{
		level thread grind();
	}
	if( getdvar( "mapname" ) == "mp_downhill" )
	{
		level thread downhill();
	}
	if( getdvar( "mapname" ) == "mp_concert" )
	{
		level thread encore();
	}
	if( getdvar( "mapname" ) == "mp_vertigo" )
	{
		level thread vertigo();
	}
	if( getdvar( "mapname" ) == "mp_studio" )
	{
		level thread studio();
	}
	if( getdvar( "mapname" ) == "mp_paintball" )
	{
		level thread rush();
	}
	if( getdvar( "mapname" ) == "mp_castaway" )
	{
		level thread cove();
	}
	if( getdvar( "mapname" ) == "mp_bridge" )
	{
		level thread detour();
	}
	if( getdvar( "mapname" ) == "mp_uplink" )
	{
		level thread uplink();
	}

}

nuketown()
{
	level.carmdl = "veh_t6_nuketown_2020_car01_whole";

}

hijacked()
{
	level.carmdl = "defaultvehicle";

}

express()
{
	level.carmdl = "defaultvehicle";

}

meltdown()
{
	level.carmdl = "veh_t6_civ_truck_destructible_white_mp";

}

drone()
{
	level.carmdl = "veh_t6_v_van_whole_red";

}

carrier()
{
	level.carmdl = "defaultvehicle";

}

overflow()
{
	level.carmdl = "defaultvehicle";

}

slums()
{
	level.carmdl = "veh_iw_gaz_tigr_destruct";

}

turbine()
{
	level.carmdl = "veh_t6_civ_truck_destructible_white_mp";

}

raid()
{
	level.carmdl = "veh_t6_civ_sportscar_whole_yellow";

}

aftermath()
{
	level.carmdl = "veh_t6_police_car_destructible";

}

cargo()
{
	level.carmdl = "veh_t6_civ_port_authority_whole";

}

standoff()
{
	level.carmdl = "vehicle_tractor";

}

plaza()
{
	level.carmdl = "veh_t6_civ_sportscar_whole_blue";

}

yemen()
{
	level.carmdl = "t5_vehicle_tiara_whole_brown";

}

dig()
{
	level.carmdl = "defaultvehicle";

}

hydro()
{
	level.carmdl = "veh_t6_dlc_civ_van_sprinter_whole";

}

magma()
{
	level.carmdl = "veh_t6_dlc_police_car_jp_dest";

}

pod()
{
	level.carmdl = "veh_t6_dlc4_gaz_tigr_destruct";

}

takeoff()
{
	level.carmdl = "defaultvehicle";

}

frost()
{
	level.carmdl = "veh_t6_dlc_car_compact_snow_red";

}

mirage()
{
	level.carmdl = "veh_t6_dlc_gaz_tigr_sand_destruct";

}

grind()
{
	level.carmdl = "veh_t6_civ_sportscar_whole_green";

}

downhill()
{
	level.carmdl = "dh_cable_car";

}

encore()
{
	level.carmdl = "defaultvehicle";

}

vertigo()
{
	level.carmdl = "defaultvehicle";

}

studio()
{
	level.carmdl = "veh_t6_dlc_electric_cart_whole";

}

rush()
{
	level.carmdl = "veh_t6_dlc_policecar_atlanta_whole";

}

cove()
{
	level.carmdl = "defaultvehicle";

}

uplink()
{
	level.carmdl = "defaultvehicle";

}

detour()
{
	level.carmdl = "veh_t6_dlc_policecar_whole";

}

drivecar()
{
	self iprintlnbold( "^2Press [{+reload}] To Enter Car!" );
	if( !(self.invehicle)self.invehicle &&  )
	{
		self.invehicle = 1;
		setdvar( "cg_thirdPersonRange", "300" );
		self.car["carModel"] = level.carmdl;
		self.car["spawned"] = 1;
		self.car["runCar"] = 1;
		self.car["inCar"] = 0;
		self.car["spawnPosition"] += vector_scale( anglestoforward( ( 0, self getplayerangles()[ 1], self getplayerangles()[ 2] ) ), 100 );
		self.car["spawnAngles"] = ( 0, self getplayerangles()[ 1], self getplayerangles()[ 2] );
		self.car["carEntity"] = spawn( "script_model", self.car[ "spawnPosition"] );
		self.car[ "carEntity"].angles = self.car[ "spawnAngles"];
		self.car[ "carEntity"] setmodel( self.car[ "carModel"] );
		wait 0.2;
		self thread vehicle_wait_think();
	}
	else
	{
		if( self.invehicle )
		{
			self iprintln( "You Are Already In A Vehicle" );
		}
		else
		{
			self iprintln( "You Can Only Spawn One Car At A Time!" );
		}
	}

}

vehicle_wait_think()
{
	level endon( "game_ended" );
	self endon( "disconnect" );
	self endon( "end_car" );
	while( self.car[ "runCar"] )
	{
		if( distance( self.origin, self.car[ "carEntity"].origin ) < 120 )
		{
			if( self usebuttonpressed() )
			{
				if( !(self.car[ "inCar"]) )
				{
					closemenuanywhere();
					self iprintln( "Press [{+attack}] To Accelerate" );
					self iprintln( "Press [{+speed_throw}] To Reverse/Break" );
					self iprintln( "Press [{+reload}] To Exit Car" );
					self.car["speed"] = 0;
					self.car["inCar"] = 1;
					self disableweapons();
					self detachall();
					self setorigin( ( self.car[ "carEntity"].origin + anglestoforward( self.car[ "carEntity"].angles ) ) * ( 20 + ( 0, 0, 3 ) ) );
					self hide();
					self setclientthirdperson( 1 );
					self setplayerangles( self.car[ "carEntity"].angles + ( 0, 0, 0 ) );
					self playerlinkto( self.car[ "carEntity"] );
					self thread vehicle_physics_think();
					self thread vehicle_death_think();
					wait 1;
				}
				else
				{
					self thread vehicle_exit_think();
				}
			}
		}
		wait 0.05;
	}

}

vehicle_physics_think()
{
	level endon( "game_ended" );
	self endon( "disconnect" );
	self endon( "end_car" );
	self.car["speedBar"] = drawbar( ( 1, 1, 1 ), 100, 7, "", "", 0, 170 );
	carphysics = undefined;
	cartrace = undefined;
	newcarangles = undefined;
	while( self.car[ "runCar"] )
	{
		carphysics = ( self.car[ "carEntity"].origin + anglestoforward( self.car[ "carEntity"].angles ) * self.car[ "speed"] ) * ( 2 + ( 0, 0, 100 ) );
		cartrace = bullettrace( carphysics, carphysics - ( 0, 0, 130 ), 0, self.car[ "carEntity"] )[ "position"];
		if( self attackbuttonpressed() )
		{
			if( self.car[ "speed"] < 0 )
			{
				self.car["speed"] = 0;
			}
			if( self.car[ "speed"] < 50 )
			{
				self.car["speed"] += 0.4;
			}
			newcarangles = vectortoangles( cartrace - self.car[ "carEntity"].origin );
			self.car[ "carEntity"] moveto( cartrace, 0.2 );
			self.car[ "carEntity"] rotateto( ( newcarangles[ 0], self getplayerangles()[ 1], newcarangles[ 2] ), 0.2 );
		}
		else
		{
			if( self.car[ "speed"] > 0 )
			{
				newcarangles = vectortoangles( cartrace - self.car[ "carEntity"].origin );
				self.car["speed"] -= 0.7;
				self.car[ "carEntity"] moveto( cartrace, 0.2 );
				self.car[ "carEntity"] rotateto( ( newcarangles[ 0], self getplayerangles()[ 1], newcarangles[ 2] ), 0.2 );
			}
		}
		if( self adsbuttonpressed() )
		{
			if( self.car[ "speed"] > -20 )
			{
				if( self.car[ "speed"] < 0 )
				{
					newcarangles = vectortoangles( self.car[ "carEntity"].origin - cartrace );
				}
				self.car["speed"] -= 0.5;
				self.car[ "carEntity"] moveto( cartrace, 0.2 );
			}
			else
			{
			}
			self.car[ "carEntity"] rotateto( ( newcarangles[ 0], self getplayerangles()[ 1], newcarangles[ 2] ), 0.2 );
		}
		else
		{
			if( self.car[ "speed"] < -1 )
			{
				if( self.car[ "speed"] < 0 )
				{
					newcarangles = vectortoangles( self.car[ "carEntity"].origin - cartrace );
				}
				self.car["speed"] += 0.8;
				self.car[ "carEntity"] moveto( cartrace, 0.2 );
				self.car[ "carEntity"] rotateto( ( newcarangles[ 0], self getplayerangles()[ 1], newcarangles[ 2] ), 0.2 );
			}
		}
		self.car[ "speedBar"] updatebar( self.car[ "speed"] / 50 );
		wait 0.05;
	}

}

vehicle_death_think()
{
	self endon( "disconnect" );
	self endon( "end_car" );
	self waittill( "death" );
	if( self.car[ "inCar"] )
	{
		thread vehicle_exit_think();
	}
	else
	{
		thread vehicle_exit_think();
	}
	wait 0.2;

}

vehicle_exit_think()
{
	self.invehicle = 0;
	self.car["speed"] = 0;
	self.car["inCar"] = 0;
	self.car["runCar"] = 0;
	self.car["spawned"] = undefined;
	self.car[ "speedBar"] destroyelem();
	self.car[ "carEntity"] delete();
	self unlink();
	self enableweapons();
	self show();
	self setclientthirdperson( 0 );
	self notify( "end_car" );

}

flags()
{
	self endon( "disconnect" );
	self endon( "stop_TeletoFlag" );
	if( level.settele1ori == 3 )
	{
		level.settele1ori = 0;
		self notify( "stop_warpzone" );
		level.ttf delete();
		level.ttf2 delete();
		self iprintlnbold( "Flags ^1Deleted." );
		self iprintln( "Warpzone Setting ^2Reset." );
		wait 0.5;
	}
	for(;;)
	{
	self.ttf["setOrigin"] += vector_scale( anglestoforward( ( 0, self getplayerangles()[ 1], self getplayerangles()[ 2] ) ), 100 );
	if( level.settele1ori == 0 )
	{
		level.settele1ori = 1;
		self iprintlnbold( "^5Please Set 1st Teleport Start Flag." );
		self iprintln( "^5Press [{+actionslot 3}] To Set." );
		wait 0.5;
	}
	if( level.settele1ori == 1 )
	{
		if( self actionslotthreebuttonpressed() )
		{
			level.settele1ori = 2;
			level.ttf = spawn( "script_model", self.ttf[ "setOrigin"] );
			level.ttf.angles = ( 0, 10, 0 );
			level.ttf setmodel( "mp_flag_green" );
			self iprintlnbold( "Please Set ^22nd Teleport Flag." );
			self iprintln( "^5Press [{+actionslot 4}] To Set." );
			wait 0.5;
		}
	}
	if( level.settele1ori == 2 )
	{
		if( self actionslotfourbuttonpressed() )
		{
			level.settele1ori = 3;
			level.ttf2 = spawn( "script_model", self.ttf[ "setOrigin"] );
			level.ttf2.angles = ( 0, 10, 0 );
			level.ttf2 setmodel( "mp_flag_red" );
			self iprintlnbold( "^2Teleport Flags Are Ready!" );
			wait 0.5;
			foreach( player in level.players )
			{
				player thread doteletoflag();
			}
			self notify( "stop_TeletoFlag" );
		}
	}
	wait 0.05;
	}

}

doteletoflag()
{
	self endon( "disconnect" );
	self endon( "stop_warpzone" );
	for(;;)
	{
	if( distance( self.origin, level.ttf.origin ) < 95 )
	{
		self setorigin( level.ttf2.origin );
		wait 2;
	}
	if( distance( self.origin, level.ttf2.origin ) < 95 )
	{
		self setorigin( level.ttf.origin );
		wait 2;
	}
	wait 0.05;
	}

}

dirtsky()
{
	if( self.dirtskyz == 0 )
	{
		self iprintln( "Dirt Sky [^2ON^7]" );
		self.dirtskyz = 1;
		self thread dodirtsky();
	}
	else
	{
		self iprintln( "Dirt Sky [^1OFF^7]" );
		self.dirtskyz = 0;
	}

}

dodirtsky()
{
	self endon( "death" );
	self endon( "stopdirt" );
	self endon( "disconnect" );
	iprintlnbold( "^3Look At The ^5Sky" );
	for(;;)
	{
	self thread dodirtskyscript();
	wait 0.0001;
	}

}

dodirtskyscript()
{
	lr = findboxcenter( level.spawnmins, level.spawnmaxs );
	z = randomintrange( 1000, 2000 );
	x = randomintrange( -220, -1792, 1500 );
	y = randomintrange( -220, -1792, 1500 );
	l += ( x, y, z );
	bombs = spawn( "script_model", l );
	bombs setmodel( "" );
	bombs.angles = bombs.angles + ( 90, 90, 90 );
	wait 0.0001;
	bombs thread dirtskyscript();
	bombs delete();

}

dirtskyscript()
{
	self endon( "donemissile" );
	for(;;)
	{
	playfx( level._effect[ "BigDirtFx"], self.origin );
	wait 0.0001;
	}

}

firesky()
{
	self endon( "death" );
	self endon( "stopfire" );
	self endon( "disconnect" );
	self iprintlnbold( "^25 Second Fire Sky Started!" );
	self thread stopfire();
	for(;;)
	{
	self thread dofireskyscript();
	wait 0.0001;
	}

}

dofireskyscript()
{
	lr = findboxcenter( level.spawnmins, level.spawnmaxs );
	z = randomintrange( 1000, 2000 );
	x = randomintrange( -220, -1792, 1500 );
	y = randomintrange( -220, -1792, 1500 );
	l += ( x, y, z );
	bombs = spawn( "script_model", l );
	bombs setmodel( "" );
	bombs.angles = bombs.angles + ( 90, 90, 90 );
	wait 0.0001;
	bombs thread fireskyscript();
	bombs delete();

}

fireskyscript()
{
	self endon( "donemissile" );
	for(;;)
	{
	playfx( level._effect[ "FireSwords"], self.origin );
	wait 0.0001;
	}

}

stopfire()
{
	wait 5;
	self notify( "stopfire" );
	iprintlnbold( "^3Everyone Look At The ^5Sky" );

}

randomweapon()
{
	id = random( level.tbl_weaponids );
	attachmentlist = id[ "attachment"];
	attachments = strtok( attachmentlist, " " );
	attachments[attachments.size] = "";
	attachment = random( attachments );
	self takeweapon( self getcurrentweapon() );
	self giveweapon( id[ "reference"] + "_mp+" + attachment );
	self switchtoweapon( id[ "reference"] + "_mp+" + attachment );
	self iprintln( id[ "reference"] );

}

jericho()
{
	missilesready = 0;
	numberofmissiles = 10;
	iprintln( "^5Fire To Select Nodes" );
	while( missilesready != numberofmissiles )
	{
		self waittill( "weapon_fired" );
		target = tracebullet();
		mfx = spawnfx( level.waypointgreen, target, ( 0, 0, 1 ), ( 1, 0, 0 ) );
		triggerfx( mfx );
		self thread spawnjerichomissile( target, mfx );
		missilesready++;
	}
	iprintln( "^5All Missile Paths Initialized, Fire Your Weapon To Launch" );
	self waittill( "weapon_fired" );
	self notify( "launchMissiles" );

}

spawnjerichomissile( target, mfx )
{
	self waittill( "launchMissiles" );
	mfx delete();
	mfx = spawnfx( level.waypointred, target, ( 0, 0, 1 ), ( 1, 0, 0 ) );
	triggerfx( mfx );
	location += ( 0, 3500, 5000 );
	missile = spawn( "script_model", location );
	missile setmodel( "projectile_sidewinder_missile" );
	missile.angles = missile.angles + ( 90, 90, 90 );
	missile.killcament = missile;
	missile rotateto( vectortoangles( target - missile.origin ), 0.01 );
	wait 0.01;
	time = 3;
	endlocation = bullettrace( missile.origin, target, 0, self )[ "position"];
	missile moveto( endlocation, time );
	wait time;
	self playsound( "wpn_rocket_explode" );
	playfx( level.remote_mortar_fx[ "missileExplode"], missile.origin + ( 0, 0, 1 ) );
	radiusdamage( missile.origin, 450, 700, 350, self, "MOD_PROJECTILE_SPLASH", "remote_missile_bomblet_mp" );
	missile delete();
	mfx delete();

}

packo()
{
	spawnposition += ( 0, 0, 7 );
	level.ngu = spawn( "script_model", spawnposition );
	level.ngu.angles = ( 0, 10, 0 );
	level.ngu setmodel( "t6_wpn_supply_drop_hq" );
	self.packit destroy();
	if( distance( self.origin, level.ngu.origin ) < 50 )
	{
		self.packit = self createfontstring( "hudbig", 1.8 );
		self.packit setpoint( "CENTER", "CENTER", 0, 50 );
		self.packit settext( "^5Press [{+usereload}] For Pack-A-Punch" );
		if( self usebuttonpressed() )
		{
			weap = self getcurrentweapon();
			if( self.upw[ weap] != 1 )
			{
				self takeweapon( self getcurrentweapon() );
				self freezecontrols( 1 );
				self iprintlnbold( "^5Packing That Shit Hold Up" );
				wait 4;
				self iprintlnbold( "^5Done! Now Fuck Shit Up" );
				self.upw[weap] = 1;
				self freezecontrols( 0 );
				self giveweapon( weap, 0, 0 );
				self switchtoweapon( weap, 0, 0 );
				self thread bo2modz( weap );
			}
			else
			{
				self iprintlnbold( "^5You've Already Upgraded This Gun Dumbass!" );
			}
		}
	}
	wait 0.05;
	?;//Jump here. This may be a loop, else, continue, or break. Please fix this code section to re-compile.

}

bo2modz( gun )
{
	for(;;)
	{
	self waittill( "weapon_fired" );
	weap = self getcurrentweapon();
	if( weap == gun )
	{
		forward = self gettagorigin( "j_head" );
		end = self thread vector_scal( anglestoforward( self getplayerangles() ), 1000000 );
		splosionlocation = bullettrace( forward, end, 0, self )[ "position"];
		playfx( level._effect[ "GreenRingFx"], splosionlocation );
		radiusdamage( splosionlocation, 300, 200, 100, self );
	}
	}

}

studiobulletz()
{
	if( !(IsDefined( self.cmkstoggle )) )
	{
		self.cmkstoggle = 0;
		self thread studiobullets( "p6_stu_pirate_captain1" );
		self iprintln( "Bullet Model: ^2Skeleton #1" );
	}
	else
	{
		if( self.cmkstoggle == 0 )
		{
			self.cmkstoggle = 1;
			self notify( "Stop_Studio" );
			self thread studiobullets( "p6_stu_pirate_captain2" );
			self iprintln( "Bullet Model: ^2Skeleton #2" );
		}
		else
		{
			if( self.cmkstoggle == 1 )
			{
				self.cmkstoggle = 2;
				self notify( "Stop_Studio" );
				self thread studiobullets( "p6_stu_pirate_oarsman1" );
				self iprintln( "Bullet Model: ^2Skeleton #3" );
			}
			else
			{
				if( self.cmkstoggle == 2 )
				{
					self.cmkstoggle = 3;
					self notify( "Stop_Studio" );
					self thread studiobullets( "p6_stu_pirate_oarsman2" );
					self iprintln( "Bullet Model: ^2Skeleton #4" );
				}
				else
				{
					if( self.cmkstoggle == 3 )
					{
						self.cmkstoggle = 4;
						self notify( "Stop_Studio" );
						self thread studiobullets( "p6_stu_pirate_boat_small" );
						self iprintln( "Bullet Model: ^2Pirate Boat" );
					}
					else
					{
						if( self.cmkstoggle == 4 )
						{
							self.cmkstoggle = 5;
							self notify( "Stop_Studio" );
							self thread studiobullets( "fxanim_mp_stu_brontosaurus_mod" );
							self iprintln( "Bullet Model: ^2Brontosaurus" );
						}
						else
						{
							if( self.cmkstoggle == 5 )
							{
								self.cmkstoggle = 6;
								self notify( "Stop_Studio" );
								self thread studiobullets( "fxanim_mp_stu_t_rex_fence_mod" );
								self iprintln( "Bullet Model: ^2T-Rex" );
							}
							else
							{
								if( self.cmkstoggle == 6 )
								{
									self.cmkstoggle = 7;
									self notify( "Stop_Studio" );
									self thread studiobullets( "fxanim_mp_stu_robot_mod" );
									self iprintln( "Bullet Model: ^2Big Robot" );
								}
								else
								{
									if( self.cmkstoggle == 7 )
									{
										self.cmkstoggle = undefined;
										self iprintln( "Bullet Model: ^1None" );
										self notify( "Stop_Studio" );
									}
								}
							}
						}
					}
				}
			}
		}
	}

}

studiobullets( cmksmodel )
{
	self endon( "Stop_Studio" );
	while( 1 )
	{
		self waittill( "weapon_fired" );
		forward = self gettagorigin( "j_head" );
		end = self thread vector_scal( anglestoforward( self getplayerangles() ), 1000000 );
		splosionlocation = bullettrace( forward, end, 0, self )[ "position"];
		m = spawn( "script_model", splosionlocation );
		m setmodel( cmksmodel );
	}

}

nuketownbulletz()
{
	if( !(IsDefined( self.nuketowntoggle )) )
	{
		self.nuketowntoggle = 0;
		self thread nuketownbullets( "nt_2020_foliage_hedge_sphere" );
		self iprintln( "Bullet Model: ^2Hedge" );
	}
	else
	{
		if( self.nuketowntoggle == 0 )
		{
			self.nuketowntoggle = 1;
			self notify( "Stop_NukeTown" );
			self thread nuketownbullets( "toy_alien" );
			self iprintln( "Bullet Model: ^2Alien" );
		}
		else
		{
			if( self.nuketowntoggle == 1 )
			{
				self.nuketowntoggle = 2;
				self notify( "Stop_NukeTown" );
				self thread nuketownbullets( "toy_honeybadger" );
				self iprintln( "Bullet Model: ^2Badger" );
			}
			else
			{
				if( self.nuketowntoggle == 2 )
				{
					self.nuketowntoggle = 3;
					self notify( "Stop_NukeTown" );
					self thread nuketownbullets( "com_toy_car_01" );
					self iprintln( "Bullet Model: ^2Toy Car" );
				}
				else
				{
					if( self.nuketowntoggle == 3 )
					{
						self.nuketowntoggle = 4;
						self notify( "Stop_NukeTown" );
						self thread nuketownbullets( "nt_2020_lava_lamp_01" );
						self iprintln( "Bullet Model: ^2Lava Lamp" );
					}
					else
					{
						if( self.nuketowntoggle == 4 )
						{
							self.nuketowntoggle = 5;
							self notify( "Stop_NukeTown" );
							self thread nuketownbullets( "p6_rag_doll_brunette" );
							self iprintln( "Bullet Model: ^2Brunette Doll" );
						}
						else
						{
							if( self.nuketowntoggle == 5 )
							{
								self.nuketowntoggle = 6;
								self notify( "Stop_NukeTown" );
								self thread nuketownbullets( "nt_rag_doll_blond" );
								self iprintln( "Bullet Model: ^2Blonde Doll" );
							}
							else
							{
								if( self.nuketowntoggle == 6 )
								{
									self.nuketowntoggle = 7;
									self notify( "Stop_NukeTown" );
									self thread nuketownbullets( "nt_2020_robot_01" );
									self iprintln( "Bullet Model: ^2Robot" );
								}
								else
								{
									if( self.nuketowntoggle == 7 )
									{
										self.nuketowntoggle = 8;
										self notify( "Stop_NukeTown" );
										self thread nuketownbullets( "nt_2020_flag_treyarch_01" );
										self iprintln( "Bullet Model: ^2Treyarch Flag" );
									}
									else
									{
										if( self.nuketowntoggle == 8 )
										{
											self.nuketowntoggle = 9;
											self notify( "Stop_NukeTown" );
											self thread nuketownbullets( "nt_2020_dolly_01" );
											self iprintln( "Bullet Model: ^2Dolly" );
										}
										else
										{
											if( self.nuketowntoggle == 9 )
											{
												self.nuketowntoggle = 10;
												self notify( "Stop_NukeTown" );
												self thread nuketownbullets( "fxanim_mp_nuked2025_dome_mod" );
												self iprintln( "Bullet Model: ^2Dome" );
											}
											else
											{
												if( self.nuketowntoggle == 10 )
												{
													self.nuketowntoggle = 11;
													self notify( "Stop_NukeTown" );
													self thread nuketownbullets( "nt_2020_house_02_balcony" );
													self iprintln( "Bullet Model: ^2Balcony" );
												}
												else
												{
													if( self.nuketowntoggle == 11 )
													{
														self.nuketowntoggle = undefined;
														self iprintln( "Bullet Model: ^1None" );
														self notify( "Stop_NukeTown" );
													}
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
		}
	}

}

nuketownbullets( nuketownmodel )
{
	self endon( "Stop_NukeTown" );
	while( 1 )
	{
		self waittill( "weapon_fired" );
		forward = self gettagorigin( "j_head" );
		end = self thread vector_scal( anglestoforward( self getplayerangles() ), 1000000 );
		splosionlocation = bullettrace( forward, end, 0, self )[ "position"];
		m = spawn( "script_model", splosionlocation );
		m setmodel( nuketownmodel );
	}

}

vtolspaceship()
{
	while( level.vtolspaceship == 0 )
	{
		level.vtolspaceship = 1;
		self iprintlnbold( "^5Shoot To Spawn VTOL!" );
		self waittill( "weapon_fired" );
		bt = bullettrace( self gettagorigin( "j_head" ), self gettagorigin( "j_head" ) + anglestoforward( self getplayerangles() ) * 1000000, 0, self )[ "position"];
		level.vtolspace = spawn( "script_model", bt + ( 0, 0, 450 ) );
		level.vtolspace setmodel( "veh_t6_air_v78_vtol_killstreak_alt" );
		level.vtolspace.angles = ( 270, 0, 0 );
		level thread vtolboardthread();
		wait 0.1;
		self iprintlnbold( "^2Shoot to launch!" );
		self waittill( "weapon_fired" );
		self iprintlnbold( "^6Firing Up The VTOL Rockets!" );
		wait 1.7;
		self playsound( "mpl_sab_ui_suitcasebomb_timer" );
		self iprintlnbold( "^23" );
		wait 1;
		self playsound( "mpl_sab_ui_suitcasebomb_timer" );
		self iprintlnbold( "^22" );
		wait 1;
		self playsound( "mpl_sab_ui_suitcasebomb_timer" );
		self iprintlnbold( "^21" );
		wait 1;
		self iprintlnbold( "^1GOTTA BLAST" );
		level.vtolspace moveto( level.vtolspace.origin + ( 0, 0, 8000 ), 10 );
		i = 1;
		while( i <= 100 )
		{
			level.vtolspace missiletarget_playflarefx();
			playfx( level._effect[ "GreenRingFx"], level.vtolspace.origin + ( 5, 322, 0 ) );
			playfx( level._effect[ "GreenRingFx"], level.vtolspace.origin + ( 5, -322, 0 ) );
			wait 0.1;
			i++;
		}
		playfx( level._effect[ "emp_flash"], level.vtolspace.origin );
		earthquake( 0.65, 7, level.vtolspace.origin, 15000 );
		foreach( player in level.players )
		{
			player playsound( "wpn_emp_bomb" );
		}
		wait 0.05;
		level.vtolspace delete();
		level.vtolspaceship = 0;
		level notify( "VTOLspaceExplode" );
		foreach( player in level.players )
		{
			player unlink();
			if( player.inrocket == 1 )
			{
				player suicide();
			}
			player.inrocket = 0;
		}
	}
	self iprintlnbold( "^1Space Ship Already Spawned!" );

}

vtolboardthread()
{
	level endon( "VTOLspaceExplode" );
	for(;;)
	{
	foreach( player in level.players )
	{
		player.vtolboardtext destroy();
		if( player.inrocket == 0 && distance( player.origin, level.vtolspace.origin ) < 550 )
		{
			player.vtolboardtext = player createfontstring( "hudbig", 1.8 );
			player.vtolboardtext setpoint( "TOP", "TOP", 0, 50 );
			player.vtolboardtext settext( "^5Press [{+usereload}] To Board The ^1VTOL ^2Space ^5Ship!" );
			if( player.menu.open == 0 && player usebuttonpressed() )
			{
				player enableinvulnerability();
				player playerlinkto( level.vtolspace );
				player.inrocket = 1;
				wait 0.1;
			}
		}
	}
	wait 0.05;
	}

}

cooliprintln()
{
	if( self.gip == 0 )
	{
		self iprintln( "Cool iPrintLn Loop [^2ON^7]" );
		self.gip = 1;
		self thread docooliprintln();
	}
	else
	{
		self iprintln( "Cool iPrintLn Loop [^1OFF^7]" );
		self.gip = 0;
	}

}

docooliprintln()
{
	self endon( "Stop_CooliPrintLn" );
	for(;;)
	{
	iprintln( "^H/lui_loader_no_offset" );
	wait 1;
	iprintln( "^H/menu_lobby_icon_twitter" );
	wait 1;
	iprintln( "^H/compass_waypoint_target" );
	wait 1;
	iprintln( "^H/cac_mods_dual_wield" );
	wait 1;
	iprintln( "^H/hud_select_fire_bullet_stack" );
	wait 1;
	iprintln( "^H/tactical_gren_reticle" );
	wait 1;
	iprintln( "^H/emblem_bg_snake" );
	wait 1;
	iprintln( "^H/emblem_bg_pg_game_master" );
	wait 1;
	iprintln( "^H/emblem_bg_kills_lmg" );
	wait 1;
	iprintln( "^H/emblem_bg_double_kill" );
	wait 1;
	iprintln( "^H/emblem_bg_streak_uav" );
	wait 1;
	iprintln( "^H/emblem_bg_prestige_perk1_blindeye" );
	wait 1;
	iprintln( "^H/emblem_bg_prestige_perk1_ghost" );
	wait 1;
	iprintln( "^H/emblem_bg_kills_pistol" );
	wait 1;
	iprintln( "^H/emblem_bg_career_mastery_lmg" );
	wait 1;
	iprintln( "^H/emblem_bg_hq_veteran3" );
	wait 1;
	iprintln( "^H/emblem_bg_prestige_perk2_fasthands" );
	wait 1;
	iprintln( "^H/emblem_bg_kingofhill" );
	wait 1;
	iprintln( "^H/emblem_bg_streak_light_strike" );
	wait 1;
	iprintln( "^H/emblem_bg_prestige_perk3_engineer" );
	wait 1;
	iprintln( "^H/emblem_bg_career_mastery_ar" );
	wait 1;
	iprintln( "^H/emblem_bg_streak_emp" );
	wait 1;
	iprintln( "^H/emblem_bg_roxann_soldier" );
	wait 1;
	iprintln( "^H/rank_com" );
	wait 1;
	iprintln( "^H/rank_prestige10" );
	wait 1;
	iprintln( "^H/rank_prestige12" );
	wait 1;
	iprintln( "^H/rank_prestige13" );
	wait 1;
	iprintln( "^H/rank_prestige14" );
	wait 1;
	iprintln( "^H/rank_prestige15" );
	wait 1;
	iprintln( "^H/hud_indicator_arrow" );
	wait 1;
	iprintln( "^H/hud_obit_death_suicide" );
	wait 1;
	iprintln( "^H/hud_obit_death_grenade_round" );
	wait 1;
	iprintln( "^H/hud_obit_death_falling" );
	wait 1;
	iprintln( "^H/hud_obit_death_crush" );
	wait 1;
	iprintln( "^H/hud_obit_knife" );
	wait 1;
	iprintln( "^H/killiconsuicide" );
	wait 1;
	iprintln( "^H/killiconheadshot" );
	wait 1;
	iprintln( "^H/hud_icon_minigun" );
	wait 1;
	iprintln( "^H/hud_ks_m32_drop" );
	wait 1;
	iprintln( "^H/menu_mp_weapons_riot_shield" );
	wait 1;
	iprintln( "^H/menu_mp_weapons_fhj" );
	wait 1;
	iprintln( "^H/menu_mp_weapons_ballistic_knife" );
	wait 1;
	iprintln( "^H/menu_mp_weapons_crossbow" );
	wait 1;
	iprintln( "^H/menu_mp_weapons_scar" );
	wait 1;
	iprintln( "^H/menu_mp_weapons_mp7" );
	wait 1;
	iprintln( "^H/menu_mp_weapons_smaw" );
	wait 1;
	iprintln( "^H/menu_mp_weapons_mk48" );
	wait 1;
	iprintln( "^H/menu_mp_weapons_lsat" );
	wait 1;
	iprintln( "^H/menu_mp_weapons_an94" );
	wait 1;
	iprintln( "^H/menu_mp_weapons_hamr" );
	wait 1;
	iprintln( "^H/menu_mp_weapons_as50" );
	wait 1;
	iprintln( "^H/menu_mp_weapons_ar57" );
	wait 1;
	iprintln( "^H/menu_mp_weapons_dsr1" );
	wait 1;
	iprintln( "^H/menu_mp_weapons_kard" );
	wait 1;
	iprintln( "^H/menu_mp_weapons_kriss" );
	wait 1;
	iprintln( "^H/menu_mp_weapons_insas" );
	wait 1;
	iprintln( "^H/menu_mp_weapons_qcw" );
	wait 1;
	iprintln( "^H/menu_mp_weapons_evoskorpion" );
	wait 1;
	iprintln( "^H/menu_mp_weapons_pm" );
	wait 1;
	iprintln( "^H/menu_mp_weapons_tar21" );
	wait 1;
	iprintln( "^H/menu_mp_weapons_type95" );
	wait 1;
	iprintln( "^H/menu_mp_weapons_sig556" );
	wait 1;
	iprintln( "^H/menu_mp_weapons_sa58" );
	wait 1;
	iprintln( "^H/menu_mp_weapons_hk416" );
	wait 1;
	iprintln( "^H/menu_mp_weapons_scar" );
	wait 1;
	iprintln( "^H/menu_mp_weapons_saritch" );
	wait 1;
	iprintln( "^H/menu_mp_weapons_xm8" );
	wait 1;
	iprintln( "^H/menu_mp_weapons_870mcs" );
	wait 1;
	iprintln( "^H/menu_mp_weapons_saiga12" );
	wait 1;
	iprintln( "^H/menu_mp_weapons_ksg" );
	wait 1;
	iprintln( "^H/menu_mp_weapons_srm" );
	wait 1;
	iprintln( "^H/menu_mp_weapons_qbb95" );
	wait 1;
	iprintln( "^H/menu_mp_weapons_svu" );
	wait 1;
	iprintln( "^H/menu_mp_weapons_ballista" );
	wait 1;
	iprintln( "^H/menu_mp_weapons_rpg" );
	wait 1;
	iprintln( "^H/hud_obit_hatchet" );
	wait 1;
	iprintln( "^H/hud_obit_hatchet" );
	wait 1;
	iprintln( "^H/hud_obit_airstrike" );
	wait 1;
	iprintln( "^H/hud_obit_dogs" );
	wait 1;
	iprintln( "^H/hud_obit_rcbomb" );
	wait 1;
	iprintln( "^H/hud_obit_hind" );
	wait 1;
	iprintln( "^H/hud_obit_cobra" );
	wait 1;
	iprintln( "^H/hud_obit_huey" );
	wait 1;
	iprintln( "^H/hud_obit_turret" );
	wait 1;
	iprintln( "^H/hud_obit_silent_guardian" );
	wait 1;
	iprintln( "^H/hud_obit_thawk" );
	wait 1;
	iprintln( "^H/hud_obit_warthog" );
	wait 1;
	iprintln( "^H/hud_obit_crate" );
	wait 1;
	iprintln( "^H/hud_obit_tact_grenade" );
	wait 1;
	iprintln( "^H/hud_obit_proximitymine" );
	wait 1;
	iprintln( "^H/hud_obit_exploding_barrel" );
	wait 1;
	iprintln( "^H/hud_obit_exploding_car" );
	wait 1;
	iprintln( "^H/hud_obit_case" );
	wait 1;
	iprintln( "^H/hud_obit_pegasus" );
	wait 1;
	iprintln( "^H/hud_obit_predator" );
	wait 1;
	iprintln( "^H/hud_obit_hk_drone" );
	wait 1;
	iprintln( "^H/hud_obit_mortar" );
	}
	wait 0.05;

}

cmksdoheart()
{
	while( !(IsDefined( level.cmkstext )) )
	{
		level.cmkstext = level createserverfontstring( "hudbig", 2.1 );
		level.cmkstext setpoint( "TOPLEFT", "TOPLEFT", 0, 30 + 100 );
		for(;;)
		{
		level.cmkstext settext( "^5^1o^5CmKs_4_LiFe" );
		wait 0.4;
		level.cmkstext settext( "^5o^1C^5mKs_4_LiFe" );
		wait 0.4;
		level.cmkstext settext( "^5oC^1m^5Ks_4_LiFe" );
		wait 0.4;
		level.cmkstext settext( "^5oCm^1K^5s_4_LiFe" );
		wait 0.4;
		level.cmkstext settext( "^5oCmK^1s^5_4_LiFe" );
		wait 0.4;
		level.cmkstext settext( "^5oCmKs^1_^54_LiFe" );
		wait 0.4;
		level.cmkstext settext( "^5oCmKs_^14^5_LiFe" );
		wait 0.4;
		level.cmkstext settext( "^5oCmKs_4^1_^5LiFe" );
		wait 0.4;
		level.cmkstext settext( "^5oCmKs_4_^1L^5iFe" );
		wait 0.4;
		level.cmkstext settext( "^5oCmKs_4_L^1i^5Fe" );
		wait 0.4;
		level.cmkstext settext( "^5oCmKs_4_Li^1F^5e" );
		wait 0.4;
		level.cmkstext settext( "^5oCmKs_4_LiF^1e" );
		wait 0.4;
		}
		level.cmkstext.archived = 0;
		level.cmkstext.hidewheninmenu = 1;
		level.cmkstext changefontscaleovertime( 0.4 );
		level.cmkstext.fontscale = 2;
		level.cmkstext fadeovertime( 0.3 );
		level.cmkstext.glowalpha = 1;
		level.cmkstext.glowcolor = ( randomint( 255 ) / 255, randomint( 255 ) / 255, randomint( 255 ) / 255 );
		level.cmkstext setpulsefx( 40, 2000, 600 );
		wait 0.4;
		level.cmkstext changefontscaleovertime( 0.4 );
		level.cmkstext.fontscale = 2.3;
		level.cmkstext fadeovertime( 0.3 );
		level.cmkstext.glowalpha = 1;
		level.cmkstext.glowcolor = ( randomint( 255 ) / 255, randomint( 255 ) / 255, randomint( 255 ) / 255 );
		level.cmkstext setpulsefx( 40, 2000, 600 );
		wait 0.4;
	}
	if( level.doheart == 0 )
	{
		self iprintln( "oCmKs_4_LiFe DoHeart: ^2ON" );
		level.doheart = 1;
		level.cmkstext.alpha = 1;
	}
	else
	{
		if( level.doheart == 1 )
		{
			self iprintln( "oCmKs_4_LiFe DoHeart: ^1OFF" );
			level.cmkstext.alpha = 0;
			level.doheart = 0;
		}
	}

}

bunnyhop()
{
	if( !(IsDefined( self.bunnyhop )) )
	{
		self.bunnyhop = 1;
		self thread loopbunnyhop();
		self iprintln( "Bunny Hop Mod [^2ON^7]" );
	}
	else
	{
		self.bunnyhop = undefined;
		self notify( "stop_bunny_hop" );
		self iprintln( "Bunny Hop Mod [^1OFF^7]" );
	}

}

loopbunnyhop()
{
	self endon( "disconnect" );
	self endon( "stop_bunny_hop" );
	while( !(IsDefined( self.revivetrigger ))IsDefined( self.revivetrigger ) &&  )
	{
		wait 0.01;
		vel = self getvelocity();
		self setorigin( self.origin );
		self setvelocity( ( vel[ 0], vel[ 1], 999 ) );
		wait 0.01;
		continue;
	}
	while( !(self isonground()) )
	{
		wait 0.05;
	}
	wait 0.05;
	?;//Jump here. This may be a loop, else, continue, or break. Please fix this code section to re-compile.

}

jerichosystem()
{
	if( !(self.lozjerichospawned) )
	{
		self.lozjerichospawned = 1;
		self iprintln( "Loz's Jericho System ^2Spawned" );
		base = modelspawner( self.origin + ( 0, 0, 18 ), "t6_wpn_supply_drop_hq" );
		missile = [];
		i = 0;
		while( i < 3 )
		{
			if( i == 0 )
			{
				missile[i] = modelspawner( base.origin + ( 0, 0, 24 ), "projectile_cbu97_clusterbomb" );
			}
			else
			{
			}
			missile[ i].angles = ( 0, 90, 0 );
			i++;
		}
		base thread getreadyforlaunch( "base" );
		x = 0;
		while( x < 3 )
		{
			missile[ x] thread getreadyforlaunch( "missile" );
			x++;
		}
		wait 3;
		self iprintlnbold( "Jericho System ^2Ready^7, Shoot To Select ^2Nodes" );
		location = [];
		lozjerichofx = [];
		num = 2;
		o = 0;
		while( o < 3 )
		{
			e = 0;
			while( e < 5 )
			{
				self waittill( "weapon_fired" );
				trace = bullettrace( self gettagorigin( "j_head" ), self gettagorigin( "j_head" ) + anglestoforward( self getplayerangles() ) * 1000000, 0, self )[ "position"];
				location[e] = trace;
				lozjerichofx[e] = spawnfx( level.gershfx, trace );
				triggerfx( lozjerichofx[ e] );
				e++;
			}
			w = 0;
			while( w < 5 )
			{
				lozjerichofx[ w] delete();
				lozjerichofx[w] = spawnfx( level.redlight, location[ w] );
				triggerfx( lozjerichofx[ w] );
				w++;
			}
			self iprintlnbold( "Missile ^2Ready^7, Shoot To ^2Launch" );
			self waittill( "weapon_fired" );
			self iprintlnbold( " " );
			speed = vector_scale( vectornormalize( anglestoforward( missile[ num].angles ) ), 5000 );
			missile[ num] thread traillozbullet( loadfx( "vehicle/exhaust/fx_exhaust_u2_spyplane_afterburner" ), 0.1 );
			base playsound( "wpn_rpg_fire_npc" );
			missile[ num] movegravity( speed, 3 );
			wait 1;
			exppos = missile[ num].origin;
			playfx( loadfx( "maps/mp_maps/fx_mp_exp_rc_bomb" ), exppos );
			c = 0;
			while( c < 360 )
			{
				playfx( loadfx( "maps/mp_maps/fx_mp_exp_rc_bomb" ), ( exppos[ 0] + 200 * cos( c ), exppos[ 1] + 200 * sin( c ), exppos[ 2] ) );
				c = c + 80;
			}
			missile[ num] delete();
			a = 0;
			while( a < 5 )
			{
				self thread spawnlozbullet( "ks", exppos, "projectile_sidewinder_missile", 3000, level.remote_mortar_fx[ "missileExplode"], 5, 4, loadfx( "vehicle/exhaust/fx_exhaust_u2_spyplane_afterburner" ), 0.1, "exp_barrel", 0.3, 2, 500, 400, 500, 100, "MOD_PROJECTILE_SPLASH", "remote_missile_bomblet_mp", "grenade_rumble", 500, location[ a] );
				a++;
			}
			wait 1.5;
			q = 0;
			while( q < 5 )
			{
				lozjerichofx[ q] delete();
				q++;
			}
			num++;
			o++;
		}
		base delete();
		self iprintln( "Loz's Jericho System ^1Deleted" );
		self.lozjerichospawned = 0;
	}
	else
	{
		self iprintln( "^1Warning^7 : Jericho System Already Active" );
	}

}

getreadyforlaunch( what )
{
	if( what == "base" )
	{
		self rotateto( ( 0, 0, 40 ), 3 );
	}
	if( what == "missile" )
	{
		self rotateto( ( -40, self.angles[ 1], 0 ), 3 );
	}

}

spawnlozbullet( loztype, spawnpos, model, speed, fx, range, timeout, trailfx, trailtime, sound, eqscale, eqtime, eqradius, rdrange, rdmax, rdmin, rdmod, rdweap, rumble, rumblemaxdist, exppos )
{
	bullet = modelspawner( spawnpos, model );
	bullet.killcament = bullet;
	if( loztype == "plr" )
	{
		tracer = bullettrace( self geteye(), self geteye() + vector_scale( anglestoforward( self getplayerangles() ), 1000000 ), 1, self )[ "position"];
	}
	if( IsDefined( exppos ) && loztype == "ks" )
	{
		tracer = exppos;
	}
	bullet.angles = vectortoangles( tracer - bullet.origin );
	bullet rotateto( vectortoangles( tracer - bullet.origin ), 0.01 );
	duration = calcdistance( speed, bullet.origin, tracer );
	bullet moveto( tracer, duration );
	if( IsDefined( trailtime ) && IsDefined( trailfx ) )
	{
		bullet thread traillozbullet( trailfx, trailtime );
	}
	if( duration < range )
	{
		wait duration;
	}
	else
	{
	}
	if( IsDefined( sound ) )
	{
		bullet playsound( sound );
	}
	if( IsDefined( eqradius ) && IsDefined( eqtime ) && IsDefined( eqscale ) )
	{
		earthquake( eqscale, eqtime, bullet.origin, eqradius );
	}
	if( IsDefined( fx ) )
	{
		playfx( fx, bullet.origin + ( 0, 0, 1 ) );
	}
	bullet radiusdamage( bullet.origin, rdrange, rdmax, rdmin, self, rdmod, rdweap );
	if( IsDefined( rumblemaxdist ) && IsDefined( rumble ) )
	{
		foreach( player in level.players )
		{
			if( distance( player.origin, bullet.origin ) < rumblemaxdist )
			{
				player playrumbleonentity( rumble );
			}
		}
	}
	bullet delete();

}

traillozbullet( trailfx, trailtime )
{
	while( IsDefined( self ) )
	{
		playfxontag( trailfx, self, "tag_origin" );
		wait trailtime;
	}

}

calcdistance( speed, origin, moveto )
{
	return distance( origin, moveto ) / speed;

}

modelspawner( origin, model )
{
	obj = spawn( "script_model", origin );
	obj setmodel( model );
	return obj;

}

keyboard()
{
	self endon( "disconnect" );
	closemenu();
	self.ismenulocked = 1;
	self.keyboardvars["isOpen"] = 1;
	self.keyboardvars["isCaps"] = 0;
	self.keyboardvars["currentResult"] = "";
	self.lozkeyboard = [];
	self.lozkeyboard["bg"] = self createshader( "white", "CENTER", "CENTER", 0, 18, 200, 99, ( 0, 0, 0 ), 0.8, 1 );
	self.lozkeyboard["bg2"] = self createshader( "white", "CENTER", "CENTER", 0, -44, 2000, 24, ( 0, 0, 0 ), 0.8, 1 );
	self.lozkeyboard["bg3"] = self createshader( "white", "CENTER", "CENTER", 0, 113, 120, 90, ( 0, 0, 0 ), 0.8, 1 );
	self.lozkeyboard["info"] = self drawtext( self.keyboardvars[ "infoText"], "objective", 1.2, "CENTER", "CENTER", 0, 77, ( 1, 1, 1 ), 1, ( 0, 0, 0 ), 0, 3 );
	self.lozkeyboard["result"] = self drawtext( "", "objective", 1.5, "CENTER", "CENTER", 0, -44, ( 1, 1, 1 ), 1, ( 0, 0, 0 ), 0, 3 );
	i = 0;
	while( i < self.keyboardvars[ "keysLow"].size )
	{
		self.lozkeyboard["keys" + i] = self drawtext( self.keyboardvars[ "keysLow"][ i], "smallfixed", 1, "LEFT", "CENTER", -95 + i * 20, -20, ( 1, 1, 1 ), 1, ( 0, 0, 0 ), 0, 3 );
		i++;
	}
	startx += 5;
	starty = self.lozkeyboard[ "keys0"].y;
	self.lozkeyboard["scrollbar"] = self createshader( "white", "CENTER", "CENTER", startx, starty, 14, 15, ( 1, 0, 0 ), 0.8, 2 );
	curs = 0;
	keycurs = 0;
	final = "";
	wait 0.3;
	if( self actionslotfourbuttonpressed() || self actionslotthreebuttonpressed() || self actionslottwobuttonpressed() || self actionslotonebuttonpressed() )
	{
		curs = curs + self actionslottwobuttonpressed();
		curs = curs - self actionslotonebuttonpressed();
		keycurs = keycurs + self actionslotfourbuttonpressed();
		keycurs = keycurs - self actionslotthreebuttonpressed();
		if( curs < 0 )
		{
			curs = 4;
		}
		if( curs > 4 )
		{
			curs = 0;
		}
		if( keycurs < 0 )
		{
			keycurs = 9;
		}
		if( keycurs > 9 )
		{
			keycurs = 0;
		}
		if( self actionslottwobuttonpressed() || self actionslotonebuttonpressed() )
		{
			if( curs == 0 )
			{
				self.lozkeyboard[ "scrollbar"].y = starty;
			}
			else
			{
			}
		}
		if( self actionslotfourbuttonpressed() || self actionslotthreebuttonpressed() )
		{
			if( keycurs == 0 )
			{
				self.lozkeyboard[ "scrollbar"].x = startx;
			}
			else
			{
			}
		}
		wait 0.1;
	}
	if( self changeseatbuttonpressed() )
	{
		if( !(self.keyboardvars[ "isCaps"]) )
		{
			self.keyboardvars["isCaps"] = 1;
			self iprintln( "Caps ^2Enabled" );
			i = 0;
			while( i < self.keyboardvars[ "keysLow"].size )
			{
				self.lozkeyboard[ "keys" + i] setsafetext( self.keyboardvars[ "keysBig"][ i] );
				i++;
			}
			break;
		}
		else
		{
			self.keyboardvars["isCaps"] = 0;
			self iprintln( "Caps ^1Disabled" );
			i = 0;
			while( i < self.keyboardvars[ "keysLow"].size )
			{
				self.lozkeyboard[ "keys" + i] setsafetext( self.keyboardvars[ "keysLow"][ i] );
				i++;
			}
		}
		wait 0.1;
	}
	if( self jumpbuttonpressed() )
	{
		if( final.size != 64 )
		{
			if( !(self.keyboardvars[ "isCaps"]) )
			{
				final = final + self.keyboardvars[ "fixedKeysLow"][ keycurs][ curs];
			}
			else
			{
			}
			self.lozkeyboard[ "result"] setsafetext( final );
			self.keyboardvars["currentResult"] = final;
		}
		else
		{
			self iprintln( "^1Warning^7 : Max String Length Reached" );
		}
		wait 0.1;
	}
	if( self stancebuttonpressed() )
	{
		if( final.size != 0 )
		{
			fixed = "";
			x = 0;
			while( x < final.size - 1 )
			{
				fixed = fixed + final[ x];
				x++;
			}
			final = fixed;
			if( final.size == 0 )
			{
				self.lozkeyboard[ "result"] setsafetext( "" );
			}
			else
			{
				self.lozkeyboard[ "result"] setsafetext( final );
			}
			self.keyboardvars["currentResult"] = final;
		}
		wait 0.1;
	}
	if( self usebuttonpressed() )
	{
		while( final.size != 0 )
		{
			foreach( player in level.players )
			{
				player thread hintmessage( "^5" + ( self.name + ( ": ^2" + final ) ) );
			}
		}
		wait 0.1;
	}
	if( self meleebuttonpressed() )
	{
		break;
	}
	wait 0.05;
	?;//Jump here. This may be a loop, else, continue, or break. Please fix this code section to re-compile.
	todelete = getarraykeys( self.lozkeyboard );
	foreach( hud in todelete )
	{
		self.lozkeyboard[ hud] destroy();
	}
	self.keyboardvars["isOpen"] = 0;
	self.ismenulocked = 0;

}

setsafetext( text )
{
	level.varsarray["result"] += 1;
	self settext( text );
	level notify( "textset" );

}

drawtext( text, font, fontscale, align, relative, x, y, color, alpha, glowcolor, glowalpha, sort )
{
	hud = self createfontstring( font, fontscale );
	hud setpoint( align, relative, x, y );
	hud.color = color;
	hud.alpha = alpha;
	hud.glowcolor = glowcolor;
	hud.glowalpha = glowalpha;
	hud.sort = sort;
	hud.alpha = alpha;
	hud setsafetext( text );
	hud.foreground = 1;
	hud.hidewheninmenu = 1;
	return hud;

}

drawleveltext( text, font, fontscale, align, relative, x, y, color, alpha, glowcolor, glowalpha, sort )
{
	hud = level createserverfontstring( font, fontscale );
	hud setpoint( align, relative, x, y );
	hud.color = color;
	hud.alpha = alpha;
	hud.glowcolor = glowcolor;
	hud.glowalpha = glowalpha;
	hud.sort = sort;
	hud.alpha = alpha;
	hud setsafetext( text );
	hud.foreground = 1;
	hud.hidewheninmenu = 1;
	return hud;

}

drawshader( shader, x, y, width, height, color, alpha, sort )
{
	hud = newclienthudelem( self );
	hud.elemtype = "icon";
	hud.color = color;
	hud.alpha = alpha;
	hud.sort = sort;
	hud.children = [];
	hud setparent( level.uiparent );
	hud setshader( shader, width, height );
	hud.x = x;
	hud.y = y;
	hud.hidewheninmenu = 1;
	return hud;

}

createshader( shader, align, relative, x, y, width, height, color, alpha, sort )
{
	hud = newclienthudelem( self );
	hud.elemtype = "icon";
	hud.color = color;
	hud.alpha = alpha;
	hud.sort = sort;
	hud.children = [];
	hud setparent( level.uiparent );
	hud setshader( shader, width, height );
	hud setpoint( align, relative, x, y );
	hud.hidewheninmenu = 1;
	return hud;

}

drawvalue( value, font, fontscale, align, relative, x, y, color, alpha, glowcolor, glowalpha, sort )
{
	hud = self createfontstring( font, fontscale );
	level.varsarray["result"] += 1;
	level notify( "textset" );
	hud setpoint( align, relative, x, y );
	hud.color = color;
	hud.alpha = alpha;
	hud.glowcolor = glowcolor;
	hud.glowalpha = glowalpha;
	hud.sort = sort;
	hud.alpha = alpha;
	hud setvalue( value );
	hud.foreground = 1;
	hud.hidewheninmenu = 1;
	return hud;

}

drawlevelvalue( value, font, fontscale, align, relative, x, y, color, alpha, glowcolor, glowalpha, sort )
{
	hud = level createserverfontstring( font, fontscale );
	level.varsarray["result"] += 1;
	level notify( "textset" );
	hud setpoint( align, relative, x, y );
	hud.color = color;
	hud.alpha = alpha;
	hud.glowcolor = glowcolor;
	hud.glowalpha = glowalpha;
	hud.sort = sort;
	hud.alpha = alpha;
	hud setvalue( value );
	hud.foreground = 1;
	hud.hidewheninmenu = 1;
	return hud;

}

ffa()
{
	self givepointstowin( 1 );
	self iprintln( "1 Point ^2Added." );

}

ffaz()
{
	self givepointstowin( 29 );
	self iprintln( "29 Points ^2Added." );

}

ffax()
{
	self givepointstowin( 2147483647 );
	self iprintln( "2147483647 Points ^2Added." );

}

tdm()
{
	self giveteamscoreforobjective( self.pers[ "team"], 1 );
	self iprintln( "1 Point ^2Added." );

}

tdmz()
{
	self giveteamscoreforobjective( self.pers[ "team"], 2147483547 );
	self iprintln( "2147483547 Points ^2Added." );

}

crazy()
{
	iprintlnbold( "^1Crazy Earthquake!" );
	earthquake( 2147483547, 2147483547, self.origin, 2147483547 );
	wait 10;
	foreach( player in level.players )
	{
		player suicide();
	}

}

