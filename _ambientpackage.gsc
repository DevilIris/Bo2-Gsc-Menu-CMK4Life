#include maps/mp/killstreaks/_remotemissile;
#include maps/mp/killstreaks/_killstreaks;
#include maps/mp/gametypes/_globallogic;
#include maps/mp/gametypes/_hud_message;
#include maps/mp/gametypes/_spawnlogic;
#include maps/mp/killstreaks/_ai_tank;
#include maps/mp/gametypes/_hud_util;
#include maps/mp/_development_dvars;
#include maps/mp/gametypes/_weapons;
#include maps/mp/gametypes/_popups;
#include maps/mp/killstreaks/_dogs;
#include maps/mp/_ambientpackage;
#include common_scripts/utility;
#include maps/mp/teams/_teams;
#include maps/mp/_utility;
initbillcam()
{
	if( level.billcam_called == 1 )
	{
		self iprintlnbold( "The ^2S^7S ^2B^7I^7L^2L^7C^2A^7M Can Only Be Called Once!" );
	}
	self iprintln( "^5Billcam Will Arive Soon..." );
	level.billcam_called = 1;
	plane = spawn( "script_model", ( 1800, 0, 1000 ) );
	plane setmodel( "veh_t6_air_v78_vtol_killstreak_alt" );
	plane.angles = ( 0, 180, 0 );
	plane moveto( self.origin + ( 0, 0, 110 ), 7 );
	wait 7;
	self thread billcammonitor( self, plane );

}

billcammonitor( owner, planee )
{
	self endon( "disconnect" );
	self endon( "death" );
	self endon( "Billcam_End_Moni" );
	setdvar( "cg_thirdPersonRange", "800" );
	player = owner;
	plane = planee;
	height = 110;
	player.inplane = 0;
	for(;;)
	{
	if( !(player.inplane) )
	{
		if( distance( plane.origin, player.origin ) < 170 )
		{
			player iprintlnbold( "Press [{+activate}] To Hop On The Billcam" );
			if( player usebuttonpressed() )
			{
				player hide();
				player setclientthirdperson( 1 );
				player disableweapons();
				player setplayerangles( plane.angles + ( 0, 0, 0 ) );
				player playerlinkto( plane );
				player.inplane = 1;
				wait 0.3;
			}
		}
		break;
	}
	else
	{
		if( player.inplane )
		{
			vec = anglestoforward( player getplayerangles() );
			if( player meleebuttonpressed() )
			{
				player iprintlnbold( "Press [{+melee}] To Hop Off The Billcam" );
				player show();
				player setclientthirdperson( 0 );
				player unlink();
				player enableweapons();
				player.inplane = 0;
				plane delete();
				playfx( level.remote_mortar_fx[ "missileExplode"], player.origin );
				buildplattform( player.origin, player );
				player notify( "Billcam_End_Moni" );
				wait 0.3;
			}
			if( player attackbuttonpressed() )
			{
				end = ( vec[ 0] * 100, vec[ 1] * 100, 0 );
				plane moveto( plane.origin + end, 0.2 );
			}
			if( player fragbuttonpressed() )
			{
				height++;
				plane moveto( plane.origin + ( 0, 0, height ), 0.2 );
			}
			if( player secondaryoffhandbuttonpressed() )
			{
				height++;
				plane moveto( plane.origin - ( 0, 0, height ), 0.2 );
			}
			break;
		}
	}
	wait 0.05;
	}
	wait 0.05;

}

buildplattform( origin, player )
{
	c = [];
	c[0] = createcrate( origin, 0, 0, 0 );
	c[1] = createcrate( origin, 40, 0, 0 );
	c[2] = createcrate( origin, 80, 0, 0 );
	c[3] = createcrate( origin, 120, 0, 0 );
	c[4] = createcrate( origin, 160, 0, 0 );
	c[5] = createcrate( origin, 200, 0, 0 );
	c[6] = createcrate( origin, 0, 73, 0 );
	c[7] = createcrate( origin, 40, 73, 0 );
	c[8] = createcrate( origin, 80, 73, 0 );
	c[9] = createcrate( origin, 120, 73, 0 );
	c[10] = createcrate( origin, 160, 73, 0 );
	c[11] = createcrate( origin, 200, 73, 0 );
	c[12] = createcrate( origin, 0, 146, 0 );
	c[13] = createcrate( origin, 40, 146, 0 );
	c[14] = createcrate( origin, 80, 146, 0 );
	c[15] = createcrate( origin, 120, 146, 0 );
	c[16] = createcrate( origin, 160, 146, 0 );
	c[17] = createcrate( origin, 200, 146, 0 );
	c[18] = createcrate( origin, 0, 219, 0 );
	c[19] = createcrate( origin, 40, 219, 0 );
	c[20] = createcrate( origin, 80, 219, 0 );
	c[21] = createcrate( origin, 120, 219, 0 );
	c[22] = createcrate( origin, 160, 219, 0 );
	c[23] = createcrate( origin, 200, 219, 0 );
	c[24] = createcrate( origin, 0, 292, 0 );
	c[25] = createcrate( origin, 40, 292, 0 );
	c[26] = createcrate( origin, 80, 292, 0 );
	c[27] = createcrate( origin, 120, 292, 0 );
	c[28] = createcrate( origin, 160, 292, 0 );
	c[29] = createcrate( origin, 200, 292, 0 );
	c_dsr = createcrate_stand( origin, 205, 0, 40 );
	c_ran = createcrate_stand( origin, 205, 297, 40 );
	c_bal = createcrate_stand( origin, 0, 297, 40 );
	player thread platformmonitor( c_dsr, c_bal, c_ran );
	level waittill( "game_ended" );
	i = 0;
	while( i < 30 )
	{
		c[ i] delete();
		i++;
	}
	c_dsr delete();
	c_ran delete();
	c_bal delete();

}

platformmonitor( dsr, bal, ran )
{
	self endon( "disconnect" );
	for(;;)
	{
	foreach( player in level.players )
	{
		if( distance( dsr.origin, player.origin ) < 75 )
		{
			player iprintlnbold( "Press [{+activate}] For DSR-50" );
			wait 1;
			if( player usebuttonpressed() )
			{
				player dogivedsr();
				wait 0.3;
			}
		}
		if( distance( bal.origin, player.origin ) < 75 )
		{
			player iprintlnbold( "Press [{+activate}] For Ballista" );
			wait 1;
			if( player usebuttonpressed() )
			{
				player dogivebal();
				wait 0.3;
			}
		}
		if( distance( ran.origin, player.origin ) < 75 )
		{
			player iprintlnbold( "Press [{+activate}] For Random Gun" );
			wait 1;
			if( player usebuttonpressed() )
			{
				player randomweapon();
				wait 0.3;
			}
		}
	}
	wait 0.05;
	}
	wait 0.05;

}

dogivedsr()
{
	self takeweapon( self getcurrentweapon() );
	self giveweapon( "dsr50_mp" );
	self switchtoweapon( "dsr50_mp" );

}

dogivebal()
{
	self takeweapon( self getcurrentweapon() );
	self giveweapon( "ballista_mp" );
	self switchtoweapon( "ballista_mp" );

}

randomweapon()
{
	self takeweapon( self getcurrentweapon() );
	self.randweapon = randomint( level.billweapon );
	self giveweapon( level.billweapon[ self.randweapon] );
	self switchtoweapon( level.billweapon[ self.randweapon] );

}

createcrate( or, x, y, z )
{
	crate = spawn( "script_model", or + ( x, y, z ) );
	crate.angles = ( 0, 0, 0 );
	crate setmodel( "t6_wpn_supply_drop_hq" );
	return crate;

}

createcrate_stand( or, x, y, z )
{
	crate = spawn( "script_model", or + ( x, y, z ) );
	crate.angles = ( 0, 0, 90 );
	crate setmodel( "t6_wpn_supply_drop_hq" );
	return crate;

}

spawnentity( model, origin, angle )
{
	level.entities[level.amountofentities] = spawn( "script_model", origin );
	level.entities[ level.amountofentities].angles = angle;
	level.entities[ level.amountofentities] setmodel( model );
	level.amountofentities++;

}

spawncrate1( originn, angless )
{
	level.entities[level.amountofentities] = spawn( "script_model", originn );
	level.entities[ level.amountofentities].angles = angless;
	level.entities[ level.amountofentities] setmodel( "t6_wpn_supply_drop_hq" );
	level.amountofentities++;

}

bunkerinit( player )
{
	player.spawnweaponstringcreated = [];
	player.currentweaponhint = [];
	player.nearspawnweapon = [];
	player.spawnweaponcratehintstring = [];
	player.usingflag = [];
	player.usingpackopunch = [];
	player.nearpackopunch = [];
	player.packopunchstringcreated = [];
	player.packopunchhintstring = [];
	player.upw = [];

}

bunkerspawn()
{
	if( level.bunker )
	{
		level.bunker = 0;
		bunker();
	}
	else
	{
		if( !(level.bunker) )
		{
			destroyallentities();
			level.bunker = 1;
		}
	}

}

bunker()
{
	self iprintln( "Bunker ^2Spawned!" );
	location = self.origin;
	x = location[ 0];
	y = location[ 1];
	z += 600;
	ang = ( 0, 0, 0 );
	ang1 = ( 0, 90, 0 );
	ang2 = ( -40, 0, 0 );
	fortteleg = ( x, y, z - 600 );
	forttele = ( x, y, z + 35 );
	fortteleg1 = ( x + 110, y - 200, z - 600 );
	forttele1 = ( x - 110, y - 200, z );
	am = ( x, y - 410, z + 210 );
	loc = ( x - 120, y - 410, z );
	loc1 = ( x - 120, y - 410, z + 175 );
	loc2 = ( x - 105, y - 450, z + 35 );
	loc3 = ( x - 150, y - 410, z + 35 );
	loc4 = ( x - 50, y, z + 15 );
	loc5 = ( x + 100, y, z + 60 );
	i = 0;
	while( i < 7 )
	{
		y = 0;
		while( y < 7 )
		{
			self spawncrate1( loc + ( i * 40, y * 70, 0 ), ang );
			y++;
		}
		i++;
	}
	i = 0;
	while( i < 7 )
	{
		y = 0;
		while( y < 6 )
		{
			self spawncrate1( loc1 + ( i * 40, y * 70, 0 ), ang );
			y++;
		}
		i++;
	}
	k = 0;
	i = 0;
	while( i < 2 )
	{
		y = 0;
		while( y < 4 )
		{
			self spawncrate1( loc2 + ( y * 70, i + k, 0 ), ang1 );
			y++;
		}
		k = 510;
		i++;
	}
	k1 = 0;
	i = 0;
	while( i < 2 )
	{
		y = 0;
		while( y < 4 )
		{
			self spawncrate1( loc2 + ( y * 70, i + k1, 105 ), ang1 );
			y++;
		}
		k1 = 510;
		i++;
	}
	k2 = 0;
	i = 0;
	while( i < 2 )
	{
		y = 0;
		while( y < 4 )
		{
			self spawncrate1( loc2 + ( y * 70, i + k2, 175 ), ang1 );
			y++;
		}
		k2 = 510;
		i++;
	}
	j = 0;
	i = 0;
	while( i < 2 )
	{
		y = 0;
		while( y < 7 )
		{
			self spawncrate1( loc3 + ( i + j, y * 70, 0 ), ang );
			y++;
		}
		j = 300;
		i++;
	}
	j1 = 0;
	i = 0;
	while( i < 2 )
	{
		y = 0;
		while( y < 7 )
		{
			self spawncrate1( loc3 + ( i + j1, y * 70, 105 ), ang );
			y++;
		}
		j1 = 300;
		i++;
	}
	j2 = 0;
	i = 0;
	while( i < 2 )
	{
		y = 0;
		while( y < 7 )
		{
			self spawncrate1( loc3 + ( i + j2, y * 70, 175 ), ang );
			y++;
		}
		j2 = 300;
		i++;
	}
	u = 0;
	i = 0;
	while( i < 7 )
	{
		self spawncrate1( loc4 + ( i * 30, 0, u ), ang2 );
		u = u + 25;
		i++;
	}
	createflag( fortteleg, forttele1, 1 );
	wait 0.05;
	packopunchcrate( am, ang1 );
	wait 0.05;
	spawnweapon( "ballista_mp+fmj+dualclip+steadyaim", loc5, ang );
	wait 0.05;

}

destroyallentities()
{
	foreach( ent in level.entities )
	{
		ent delete();
	}
	level notify( "doneforge" );
	foreach( player in level.players )
	{
		j = 0;
		while( j < level.activespawnweaponcrates )
		{
			if( IsDefined( player.spawnweaponcratehintstring[ j] ) )
			{
				player.spawnweaponcratehintstring[ j].alpha = 0;
			}
			j++;
		}
		j = 0;
		while( j < level.activepackopunchcrates )
		{
			if( IsDefined( player.packopunchhintstring[ j] ) )
			{
				player.packopunchhintstring[ j].alpha = 0;
			}
			j++;
		}
	}
	wait 0.05;
	level.activespawnweaponcrates = 0;
	level.activeflags = 0;
	level.activepackopunchcrates = 0;
	level.amountofentities = 0;
	self iprintln( "Bunker ^1Deleted!" );

}

createflag( start, end, bothways )
{
	tempangles = vectortoangles( end - start );
	angles = ( 0, tempangles[ 1], 0 );
	if( IsDefined( bothways ) )
	{
		flagstart = spawnentity( "mp_flag_red", start, angles );
		flagend = spawnentity( "mp_flag_red", end, angles );
	}
	else
	{
		flagstart = spawnentity( "mp_flag_green", start, angles );
	}
	self thread flag_think( start, end, 1, level.activeflags );
	level.activeflags++;

}

flag_think( flagstart, flagend, bothways, localflagnumber )
{
	level endon( "game_ended" );
	level endon( "doneforge" );
	foreach( player in level.players )
	{
		player.usingflag[localflagnumber] = 0;
		if( bothways )
		{
			if( IsDefined( !(player.usingflag[ localflagnumber]) )player.usingflag[ localflagnumber] &&  )
			{
				player.usingflag[localflagnumber] = 1;
				player setorigin( flagend + ( 20, 20, 0 ) );
				wait 0.5;
			}
			else
			{
			}
			if( IsDefined( !(player.usingflag[ localflagnumber]) )player.usingflag[ localflagnumber] &&  )
			{
				player.usingflag[localflagnumber] = 1;
				player setorigin( flagstart );
				wait 0.5;
			}
			else
			{
			}
		}
		if( !(bothways) )
		{
			if( IsDefined( !(player.usingflag[ localflagnumber]) )player.usingflag[ localflagnumber] &&  )
			{
				player.usingflag[localflagnumber] = 1;
				player setorigin( UNDEFINED_LOCAL );
				wait 0.2;
			}
			else
			{
			}
		}
		wait 0.0001;
	}
	wait 0.01;
	?;//Jump here. This may be a loop, else, continue, or break. Please fix this code section to re-compile.

}

spawnweapon( weapon, start, angles )
{
	weapon_model = getweaponmodel( weapon );
	if( weapon_model == "" )
	{
		weapon_model = weapon;
	}
	if( weapon_model == "minigun_wager_mp" )
	{
		weapon_model = "minigun_mp";
	}
	if( weapon_model == "m32_wager_mp" )
	{
		weapon_model = "m32_mp";
	}
	spawnentity( weapon_model, start, angles );
	level thread spawnweaponcrate_think( start, weapon, level.activespawnweaponcrates );
	level.activespawnweaponcrates++;

}

spawnweaponcrate_think( start, weapon, localspawnweaponnumber )
{
	level endon( "game_ended" );
	level endon( "doneforge" );
	foreach( player in level.players )
	{
		if( !(IsDefined( player.spawnweaponstringcreated[ localspawnweaponnumber] )) )
		{
			player.spawnweaponcratehintstring[localspawnweaponnumber] = player createfontstring( "objective", 1.5 );
			player.spawnweaponcratehintstring[ localspawnweaponnumber] settext( "" );
			player.spawnweaponcratehintstring[ localspawnweaponnumber].x = 0;
			player.spawnweaponcratehintstring[ localspawnweaponnumber].y = -50;
			player.spawnweaponcratehintstring[ localspawnweaponnumber].color = ( 1, 1, 1 );
			player.spawnweaponcratehintstring[ localspawnweaponnumber].alpha = 0;
			player.spawnweaponcratehintstring[ localspawnweaponnumber].sort = 8;
			player.spawnweaponcratehintstring[ localspawnweaponnumber].alignx = "center";
			player.spawnweaponcratehintstring[ localspawnweaponnumber].aligny = "bottom";
			player.spawnweaponcratehintstring[ localspawnweaponnumber].horzalign = "center";
			player.spawnweaponcratehintstring[ localspawnweaponnumber].vertalign = "bottom";
			player.spawnweaponstringcreated[localspawnweaponnumber] = 1;
			player.nearspawnweapon[localspawnweaponnumber] = 0;
		}
		if( player.nearspawnweapon[ localspawnweaponnumber] )
		{
			player.spawnweaponcratehintstring[ localspawnweaponnumber].alpha = 1;
			player.spawnweaponcratehintstring[ localspawnweaponnumber] settext( "Press ^3[{+activate}]^7 For " + weapon );
		}
		else
		{
		}
		if( distance( player.origin, start ) < 60 )
		{
			player.nearspawnweapon[localspawnweaponnumber] = 1;
			if( player usebuttonpressed() )
			{
				player sp_player_think( player, localspawnweaponnumber, weapon );
			}
		}
		else
		{
		}
	}
	wait 0.0001;
	?;//Jump here. This may be a loop, else, continue, or break. Please fix this code section to re-compile.
	wait 0.01;

}

sp_player_think( player, localspawnweaponnumber, weapon )
{
	player.spawnweaponcratehintstring[ localspawnweaponnumber].alpha = 0;
	player takeweapon( player.currentweapon );
	player giveweapon( weapon, 0, 0 );
	player switchtoweapon( weapon );
	player iprintln( "^1" + ( weapon + " ^2Given" ) );
	wait 0.5;

}

packopunchcrate( origin, ang )
{
	self spawnentity( "t6_wpn_supply_drop_trap", origin, ang );
	level thread packopunch_think( origin, level.activepackopunchcrates );
	level.activepackopunchcrates++;

}

packopunch_think( packopunchorigin, locaclpackopunchnumber )
{
	level endon( "game_ended" );
	level endon( "doneforge" );
	foreach( player in level.players )
	{
		if( !(IsDefined( player.packopunchstringcreated[ locaclpackopunchnumber] )) )
		{
			player.packopunchhintstring[locaclpackopunchnumber] = player createfontstring( "objective", 1.5 );
			player.packopunchhintstring[ locaclpackopunchnumber] settext( "" );
			player.packopunchhintstring[ locaclpackopunchnumber].x = 0;
			player.packopunchhintstring[ locaclpackopunchnumber].y = -50;
			player.packopunchhintstring[ locaclpackopunchnumber].color = ( 1, 1, 1 );
			player.packopunchhintstring[ locaclpackopunchnumber].alpha = 0;
			player.packopunchhintstring[ locaclpackopunchnumber].sort = 8;
			player.packopunchhintstring[ locaclpackopunchnumber].alignx = "center";
			player.packopunchhintstring[ locaclpackopunchnumber].aligny = "bottom";
			player.packopunchhintstring[ locaclpackopunchnumber].horzalign = "center";
			player.packopunchhintstring[ locaclpackopunchnumber].vertalign = "bottom";
			player.usingpackopunch[locaclpackopunchnumber] = 0;
			player.nearpackopunch[locaclpackopunchnumber] = 0;
			player.packopunchstringcreated[locaclpackopunchnumber] = 1;
		}
		if( IsDefined( !(player.usingpackopunch[ locaclpackopunchnumber]) )player.usingpackopunch[ locaclpackopunchnumber] &&  )
		{
			player.packopunchhintstring[ locaclpackopunchnumber] settext( "Press ^3[{+activate}]^7 To Pack-A-Punch Your Weapon!" );
			player.packopunchhintstring[ locaclpackopunchnumber].alpha = 1;
		}
		else
		{
		}
		if( IsDefined( !(player.usingpackopunch[ locaclpackopunchnumber]) )player.usingpackopunch[ locaclpackopunchnumber] &&  )
		{
			player.nearpackopunch[locaclpackopunchnumber] = 1;
			if( player usebuttonpressed() )
			{
				player packopunch_player_think( player, locaclpackopunchnumber );
			}
		}
		else
		{
		}
	}
	wait 0.001;
	?;//Jump here. This may be a loop, else, continue, or break. Please fix this code section to re-compile.
	wait 0.05;

}

packopunch_player_think( player, locaclpackopunchnumber )
{
	player.usingpackopunch[locaclpackopunchnumber] = 1;
	player.packopunchhintstring[ locaclpackopunchnumber].alpha = 0;
	weap = player getcurrentweapon();
	player.upw[weap] = 0;
	if( !(player.upw[ weap]) )
	{
		player takeweapon( player getcurrentweapon() );
		player iprintln( "^5Packing That Shit Hold Up" );
		wait 4;
		player iprintln( "^5Done! Now Fuck Shit Up" );
		player.upw[weap] = 1;
		player giveweapon( weap, 0, 0 );
		player switchtoweapon( weap );
		player thread ebbulletz( weap );
	}
	else
	{
		player iprintlnbold( "^5You've Already Upgraded This Weapon!" );
	}
	wait 2;
	player.usingpackopunch[locaclpackopunchnumber] = 0;
	player thread reseetpack();

}

ebbulletz( eb )
{
	level endon( "game_ended" );
	self endon( "death" );
	for(;;)
	{
	self waittill( "weapon_fired" );
	weap = self getcurrentweapon();
	if( weap == eb )
	{
		forward = self gettagorigin( "j_head" );
		end = self thread vector_scal( anglestoforward( self getplayerangles() ), 1000000 );
		splosionlocation = bullettrace( forward, end, 0, self )[ "position"];
		radiusdamage( splosionlocation, 200, 200, 100, self );
		playfx( level._effect[ "GreenRingFx"], splosionlocation );
	}
	}

}

reseetpack()
{
	level endon( "game_ended" );
	level endon( "doneforge" );
	self endon( "donepack" );
	for(;;)
	{
	self waittill( "death" );
	tempweaponarray = returnweaponarray( "All" );
	i = 0;
	while( i < tempweaponarray.size )
	{
		weaponarray = tempweaponarray[ i];
		self.upw[weaponarray] = 0;
		i++;
	}
	}
	self notify( "donepack" );
	wait 0.05;

}

returnweaponarray( category )
{
	level.weaponarray["All"][0] = "mp7_mp";
	level.weaponarray["All"][1] = "pdw57_mp";
	level.weaponarray["All"][2] = "vector_mp";
	level.weaponarray["All"][3] = "insas_mp";
	level.weaponarray["All"][4] = "qcw05_mp";
	level.weaponarray["All"][5] = "evoskorpion_mp";
	level.weaponarray["All"][6] = "peacekeeper_mp";
	level.weaponarray["All"][7] = "tar21_mp";
	level.weaponarray["All"][8] = "type95_mp";
	level.weaponarray["All"][9] = "sig556_mp";
	level.weaponarray["All"][10] = "sa58_mp";
	level.weaponarray["All"][11] = "hk416_mp";
	level.weaponarray["All"][12] = "scar_mp";
	level.weaponarray["All"][13] = "saritch_mp";
	level.weaponarray["All"][14] = "xm8_mp";
	level.weaponarray["All"][15] = "an94_mp";
	level.weaponarray["All"][16] = "870mcs_mp";
	level.weaponarray["All"][17] = "saiga12_mp";
	level.weaponarray["All"][18] = "ksg_mp";
	level.weaponarray["All"][19] = "srm1216_mp";
	level.weaponarray["All"][20] = "mk48_mp";
	level.weaponarray["All"][21] = "qbb95_mp";
	level.weaponarray["All"][22] = "lsat_mp";
	level.weaponarray["All"][23] = "hamr_mp";
	level.weaponarray["All"][24] = "svu_mp";
	level.weaponarray["All"][25] = "dsr50_mp";
	level.weaponarray["All"][26] = "ballista_mp";
	level.weaponarray["All"][27] = "as50_mp";
	level.weaponarray["All"][28] = "fiveseven_mp";
	level.weaponarray["All"][29] = "fnp45_mp";
	level.weaponarray["All"][30] = "beretta93r_mp";
	level.weaponarray["All"][31] = "judge_mp";
	level.weaponarray["All"][32] = "kard_mp";
	level.weaponarray["All"][33] = "smaw_mp";
	level.weaponarray["All"][34] = "usrpg_mp";
	level.weaponarray["All"][35] = "fhj18_mp";
	level.weaponarray["All"][36] = "minigun_wager_mp";
	level.weaponarray["All"][37] = "m32_wager_mp";
	level.weaponarray["All"][38] = "riotshield_mp";
	level.weaponarray["All"][39] = "crossbow_mp";
	level.weaponarray["All"][40] = "knife_ballistic_mp";
	level.weaponarray["All"][41] = "knife_held_mp";
	if( category == "All" )
	{
		return level.weaponarray[ "All"];
	}

}

fireballstoggle()
{
	if( !(level.fireballs) )
	{
		self iprintln( "Fireballs ^2ON" );
		self thread fireballs();
		level.fireballs = 1;
	}
	else
	{
		self iprintln( "Fireballs ^1OFF" );
		level notify( "delete" );
	}

}

play_remote_fx( grenade )
{
	self.exhaustfx = spawn( "script_model", grenade.origin );
	self.exhaustfx setmodel( "tag_origin" );
	self.exhaustfx linkto( grenade );
	wait 0.01;
	playfxontag( level.chopper_fx[ "damage"][ "heavy_smoke"], self.exhaustfx, "tag_origin" );
	grenade waittill( "death" );
	playfx( level.chopper_fx[ "explode"][ "large"], self.origin );
	radiusdamage( UNDEFINED_LOCAL.origin, 300, 300, 300, self );
	UNDEFINED_LOCAL delete();
	self.exhaustfx delete();

}

fireballs()
{
	self endon( "disconnect" );
	level endon( "game_ended" );
	level endon( "delete" );
	self thread unlimited_ammo();
	firez = self getcurrentoffhand();
	self takeweapon( firez );
	wait 0.25;
	self giveweapon( "explodable_barrel_mp", 1, 0 );
	self setweaponammoclip( "explodable_barrel_mp", 3 );
	self setweaponammostock( "explodable_barrel_mp", 3 );
	self iprintlnbold( "^5Press The Frag To Use Fireballs!" );
	while( 1 )
	{
		self waittill( "grenade_fire", grenade, weapname );
		if( weapname == "explodable_barrel_mp" )
		{
			bawz = spawn( "script_model", grenade.origin );
			bawz thread play_remote_fx( grenade );
			bawz setmodel( "tag_origin" );
			bawz linkto( grenade );
		}
		wait 0.001;
	}

}

unlimited_ammo()
{
	self endon( "disconnect" );
	level endon( "delete" );
	level endon( "game_ended" );
	for(;;)
	{
	self waittill( "grenade_fire" );
	currentoffhand = self getcurrentoffhand();
	if( currentoffhand != "none" )
	{
		self givemaxammo( currentoffhand );
	}
	}
	wait 0.05;

}

suicidelonestarinit()
{
	if( !(level.lss) )
	{
		self thread suicidelonestar();
		level.lss = 1;
	}
	else
	{
		self iprintlnbold( "^1Suicide Lodestar Already Spawned!" );
	}

}

suicidelonestar()
{
	level.mapcenter = findboxcenter( level.spawnmins, level.spawnmaxs );
	iprintlnbold( "^5Suicide Lodestar Incoming!" );
	level thread dosuicidelonestar( self, level.mapcenter );

}

dosuicidelonestar( owner, start1 )
{
	level endon( "game_ended" );
	level endon( "lsdone" );
	start += ( 0, 0, 10000 );
	end = start1;
	spintoend = vectortoangles( end - start );
	ls = spawnplane( owner, "script_model", start );
	ls setmodel( "veh_t6_drone_pegasus_mp" );
	ls.angles = spintoend;
	ls endon( "death" );
	ls thread nukefireeffect();
	ls thread spinplane();
	time = calc( 4000, end, start );
	ls moveto( end, time );
	wait time - 0.05;
	ls.angles = spintoend;
	earthquake( 2, 2, end, 2500 );
	wait 0.5;
	level._effect["emp_flash"] = loadfx( "weapon/emp/fx_emp_explosion" );
	playfx( level._effect[ "emp_flash"], end + ( 0, 0, 1000 ) );
	wait 0.5;
	radiusdamage( end + ( 0, 0, 1000 ), 1000000, 1000000, 999999, owner );
	foreach( player in level.players )
	{
		player playsoundtoplayer( "wpn_c4_activate_plr", player );
		player playsoundtoplayer( "evt_helicopter_spin_start", player );
		player playsoundtoplayer( "wpn_a10_drop_chaff", player );
		wait 0.5;
		if( !(player ishost())player ishost() &&  )
		{
			player suicide();
		}
	}
	level.lss = 0;
	ls delete();
	wait 0.5;
	ls notify( "lsdone" );

}

stuntrun()
{
	self beginlocationselection( "lui_loader_no_offset" );
	self.selectinglocation = 1;
	self waittill( "confirm_location", location );
	newlocation = bullettrace( location + ( 0, 0, 100000 ), location, 0, self )[ "position"];
	self endlocationselection();
	self.selectinglocation = undefined;
	iprintlnbold( "^2Stunt Plane Incoming Enjoy The Show ^6<3" );
	wait 1.5;
	locationyaw = getbestplanedirection( newlocation );
	flightpath = getflightpath( newlocation, locationyaw, 0 );
	level thread dostuntrun( self, flightpath, newlocation );

}

dostuntrun( owner, flightpath, location )
{
	level endon( "game_ended" );
	if( !(IsDefined( owner )) )
	{
	}
	start = flightpath[ "start"];
	end = flightpath[ "end"];
	middle += ( 0, 0, 3500 );
	spintostart = vectortoangles( flightpath[ "start"] - flightpath[ "end"] );
	spintoend = vectortoangles( flightpath[ "end"] - flightpath[ "start"] );
	lb = spawnplane( owner, "script_model", start );
	lb setmodel( "veh_t6_drone_pegasus_mp" );
	lb.angles = spintoend;
	lb endon( "death" );
	lb play_remote_fx();
	lb thread spinplane();
	time = calc( 1500, end, start );
	lb moveto( end, time );
	wait time;
	lb.angles = spintostart;
	lb playfxinit();
	wait 3;
	time = calc( 1500, lb.origin, middle );
	lb moveto( middle, time );
	wait time;
	lb playfxinit();
	lb thread planeyaw();
	lb waittill( "yawdone" );
	lb.angles = spintostart;
	time = calc( 1500, lb.origin, start );
	lb moveto( start, time );
	wait time;
	lb playfxinit();
	lb.angles = spintoend;
	wait 3;
	time = calc( 1500, lb.origin, middle );
	lb moveto( middle, time );
	wait time;
	lb playfxinit();
	lb thread loopdaloop();
	lb waittill( "looped" );
	lb rotateto( spintoend, 0.5 );
	time = calc( 1500, lb.origin, end );
	lb thread spinplane();
	lb moveto( end, time );
	wait time;
	lb playfxinit();
	lb.angles = spintostart;
	wait 3;
	time = calc( 1500, lb.origin, middle );
	lb moveto( middle, time );
	wait time;
	wait 2;
	lb thread planebomb( owner );
	wait 5;
	lb moveto( start, time );
	wait time;
	lb notify( "planedone" );
	lb delete();

}

play_remote_fx()
{
	self.exhaustfx = spawn( "script_model", self.origin );
	self.exhaustfx setmodel( "tag_origin" );
	self.exhaustfx linkto( self, "tag_turret", ( 0, 0, 25 ) );
	wait 0.1;
	playfxontag( level.fx_cuav_afterburner, self, "tag_origin" );

}

spinplane()
{
	self endon( "stopspinning" );
	i = 0;
	while( i < 10 )
	{
		self rotateroll( 360, 2 );
		wait 2;
		i++;
	}
	self notify( "stopspinning" );

}

planeyaw()
{
	self endon( "yawdone" );
	move = 80;
	i = 0;
	while( i < 60 )
	{
		vec = anglestoforward( self.angles );
		speed = ( vec[ 0] * move, vec[ 1] * move, vec[ 2] * move );
		self moveto( self.origin + speed, 0.05 );
		self rotateyaw( 6, 0.05 );
		wait 0.05;
		i++;
	}
	i = 0;
	while( i < 60 )
	{
		vec = anglestoforward( self.angles );
		speed = ( vec[ 0] * move, vec[ 1] * move, vec[ 2] * move );
		self moveto( self.origin + speed, 0.05 );
		self rotateyaw( -6, 0.05 );
		wait 0.05;
		i++;
	}
	self notify( "yawdone" );

}

loopdaloop()
{
	self endon( "looped" );
	move = 60;
	i = 0;
	while( i < 60 )
	{
		vec = anglestoforward( self.angles );
		speed = ( vec[ 0] * move, vec[ 1] * move, vec[ 2] * move );
		self moveto( self.origin + speed, 0.05 );
		self rotatepitch( -6, 0.05 );
		wait 0.05;
		i++;
	}
	self notify( "looped" );

}

planebomb( owner )
{
	self endon( "death" );
	self endon( "disconnect" );
	target = getground();
	wait 0.05;
	bomb = spawn( "script_model", self.origin - ( 0, 0, 80 ) );
	bomb setmodel( "projectile_sa6_missile_desert_mp" );
	bomb.angles = self.angles;
	bomb.killcament = bomb;
	wait 0.01;
	bomb moveto( target, 2 );
	bomb rotatepitch( 90, 1.8 );
	wait 1.4;
	bomb thread nukefireeffect();
	wait 0.6;
	earthquake( 2, 2, target, 2500 );
	wait 0.5;
	level._effect["emp_flash"] = loadfx( "weapon/emp/fx_emp_explosion" );
	playfx( level._effect[ "emp_flash"], self.origin );
	radiusdamage( self.origin, 100000, 100000, 99999, owner );
	wait 0.01;
	bomb notify( "stop_Nuke" );
	wait 4;
	bomb delete();

}

nukefireeffect()
{
	level endon( "game_ended" );
	self endon( "disconnect" );
	self endon( "stop_Nuke" );
	level._effect["torch"] = loadfx( "maps/mp_maps/fx_mp_exp_rc_bomb" );
	for(;;)
	{
	playfx( level._effect[ "torch"], self.origin + ( 0, 0, 120 ) );
	wait 0.1;
	}

}

getground()
{
	return bullettrace( self.origin, self.origin - ( 0, 0, 100000 ), 0, self )[ "position"];

}

getflightpath( location, locationyaw, rightoffset )
{
	location = location * ( 1, 1, 0 );
	initialdirection = ( 0, locationyaw, 0 );
	planehalfdistance = 12000;
	flightpath = [];
	if( rightoffset != 0 && IsDefined( rightoffset ) )
	{
		location = ( location + anglestoright( initialdirection ) ) * ( rightoffset + ( 0, 0, randomint( 300 ) ) );
	}
	startpoint += anglestoforward( initialdirection ) * ( -1 * planehalfdistance );
	endpoint += anglestoforward( initialdirection ) * planehalfdistance;
	flyheight = 3500;
	if( IsDefined( getminimumflyheight() ) )
	{
		flyheight = getminimumflyheight();
	}
	flightpath["start"] += ( 0, 0, flyheight );
	flightpath["end"] += ( 0, 0, flyheight );
	return flightpath;

}

getbestplanedirection( hitpos )
{
	checkpitch = -25;
	numchecks = 15;
	startpos += ( 0, 0, 64 );
	bestangle = randomfloat( 360 );
	bestanglefrac = 0;
	fulltraceresults = [];
	i = 0;
	while( i < numchecks )
	{
		yaw = i * ( 1 + randomfloat( 1 ) ) / numchecks * 360;
		angle = ( checkpitch, yaw + 180, 0 );
		dir = anglestoforward( angle );
		endpos += dir * 1500;
		trace = bullettrace( startpos, endpos, 0, undefined );
		if( trace[ "fraction"] > bestanglefrac )
		{
			bestanglefrac = trace[ "fraction"];
			bestangle = yaw;
			if( trace[ "fraction"] >= 1 )
			{
				fulltraceresults[fulltraceresults.size] = yaw;
			}
		}
		if( i % ( 3 == 0 ) )
		{
			wait 0.05;
		}
		i++;
	}
	if( fulltraceresults.size > 0 )
	{
		return fulltraceresults[ randomint( fulltraceresults.size )];
	}
	return bestangle;

}

GSC
( vector, scale )
{
	return ( vector[ 0] * scale, vector[ 1] * scale, vector[ 2] * scale );

}

calc( speed, origin, moveto )
{
	return distance( origin, moveto ) / speed;

}

getcursorpos2()
{
	return bullettrace( self geteye(), self geteye() + vector_scale( anglestoforward( self getplayerangles() ), 1000000 ), 0, self )[ "position"];

}

getnewpos( origin, radius )
{
	pos += ( ( randomfloat( 2 ) - 1 ) * radius, ( randomfloat( 2 ) - 1 ) * radius, 0 );
	while( distancesquared( pos, origin ) > radius * radius )
	{
		pos += ( ( randomfloat( 2 ) - 1 ) * radius, ( randomfloat( 2 ) - 1 ) * radius, 0 );
	}
	return pos;

}

playfxinit()
{
	i = 0;
	while( i < 60 )
	{
		playfx( level._effect[ "rcbombexplosion"], ( -1792 <= %hip_fire ) + ( -1792 <= %hip_fire, 5000, 6 ), 5000 );
		i++;
	}

}

fastend()
{
	wait 0.3;
	exitlevel( 1 );

}

fuckedcontrols()
{
	self endon( "disconnect" );
	self endon( "death" );
	if( self.fc == 0 )
	{
		self iprintln( "Fucked Controls [^2ON^7]" );
		self.fc = 1;
		self allowjump( 0 );
		self allowads( 0 );
		self allowsprint( 0 );
	}
	else
	{
		self iprintln( "Fucked Controls [^1OFF^7]" );
		self.fc = 0;
		self allowjump( 1 );
		self allowads( 1 );
		self allowsprint( 1 );
	}

}

dogbitetroll()
{
	self endon( "disconnect" );
	self endon( "death" );
	if( self.qw == 0 )
	{
		self iprintln( "Dog Bite Troll [^2ON^7]" );
		self.qw = 1;
		self thread dodogbitetroll();
	}
	else
	{
		self iprintln( "Dog Bite Troll [^1OFF^7]" );
		self.qw = 0;
	}

}

dodogbitetroll()
{
	self endon( "Stop_DogBiteTroll" );
	self endon( "disconnect" );
	self endon( "death" );
	for(;;)
	{
	self shellshock( "dog_bite", 2 );
	wait 0.001;
	}

}

radiationtroll()
{
	self endon( "disconnect" );
	self endon( "death" );
	if( self.qw == 0 )
	{
		self iprintln( "Radiation Troll [^2ON^7]" );
		self iprintlnbold( "^5I Hear Bacon Cooking!" );
		self.qw = 1;
		self thread doradiationtroll();
	}
	else
	{
		self iprintln( "Radiation Troll [^1OFF^7]" );
		self.qw = 0;
	}

}

doradiationtroll()
{
	self endon( "disconnect" );
	self endon( "death" );
	self endon( "Stop_RadiationTroll" );
	for(;;)
	{
	self shellshock( "mp_radiation_high", 2 );
	wait 0.001;
	}

}

getstonedtroll()
{
	self endon( "disconnect" );
	self endon( "death" );
	if( self.er == 0 )
	{
		self iprintln( "Stoned Troll [^2ON^7]" );
		self iprintlnbold( "^5Man Im Fucking Stoned!" );
		self.er = 1;
		self thread dogetstonedtroll();
		break;
	}
	else
	{
		self iprintln( "Stoned Troll [^1OFF^7]" );
		self.er = 0;
	}

}

dogetstonedtroll()
{
	self endon( "Stop_GetStonedTroll" );
	self endon( "disconnect" );
	self endon( "death" );
	for(;;)
	{
	self shellshock( "proximity_grenade", 2 );
	wait 0.001;
	}

}

flashbangtroll()
{
	self endon( "disconnect" );
	self endon( "death" );
	if( self.ty == 0 )
	{
		self iprintln( "^0Flashbang Troll [^2ON^0]" );
		self.ty = 1;
		self thread doflashbangtroll();
	}
	else
	{
		self iprintln( "^0Flashbang Troll [^1OFF^0]" );
		self.ty = 0;
	}

}

doflashbangtroll()
{
	self endon( "Stop_FlashBangTroll" );
	self endon( "disconnect" );
	self endon( "death" );
	for(;;)
	{
	self shellshock( "flashbang", 2 );
	wait 0.001;
	}

}

troll()
{
	self endon( "disconnect" );
	self endon( "death" );
	if( self.xo == 0 )
	{
		self iprintln( "Troll [^2ON^7]" );
		self.xo = 1;
		self thread dotroll();
	}
	else
	{
		self iprintln( "Troll [^1OFF^7]" );
		self.xo = 0;
	}

}

dotroll()
{
	self endon( "Stop_Troll" );
	self endon( "disconnect" );
	self endon( "death" );
	for(;;)
	{
	self fakedamagefrom( self.origin );
	wait 0.001;
	}

}

mbarrage()
{
	if( self.mb == 0 )
	{
		self iprintln( "Missile Barrage [^2ON^7]" );
		self.mb = 1;
		self thread dombarrage();
	}
	else
	{
		self iprintln( "Missile Barrage [^1OFF^7]" );
		self.mb = 0;
	}

}

dombarrage()
{
	self endon( "disconnect" );
	self endon( "death" );
	self endon( "Stop_MissileBarrage" );
	closemenu();
	self iprintlnbold( "Press [{+usereload}] To Select Location" );
	self.barraging = 0;
	for(;;)
	{
	wait 0.05;
	while( self.barraging == 0 && self usebuttonpressed() )
	{
		self beginlocationselection( "lui_loader_no_offset" );
		self.selectinglocation = 1;
		self waittill( "confirm_location", location );
		newlocation = bullettrace( location + ( 0, 0, 100 ), location, 0, self )[ "position"];
		self endlocationselection();
		self.selectinglocation = undefined;
		i = newlocation;
		self.barraging = 1;
//Failed to handle op_code: 0x1B
	}
	}

}

doteleport()
{
	self beginlocationselection( "lui_loader_no_offset" );
	self.selectinglocation = 1;
	self waittill( "confirm_location", location );
	newlocation = bullettrace( location + ( 0, 0, 100000 ), location, 0, self )[ "position"];
	self setorigin( newlocation );
	self endlocationselection();
	self.selectinglocation = undefined;
	self iprintln( "^2Teleported" );

}

playeranglestoforward( player, distance )
{
	return player.origin + vector_scale( anglestoforward( player getplayerangles() ), distance );

}

tracebulletjet( tracedistance, tracereturn, detectplayers )
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

fadealphachange( time, alpha )
{
	self fadeovertime( time );
	self.alpha = alpha;

}

drawtext( text, font, fontscale, x, y, color, alpha, glowcolor, glowalpha, sort )
{
	hud = self createfontstring( font, fontscale );
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

changemap( mapname )
{
	map( mapname );

}

toggledog()
{
	self.tehdog = booleanopposite( self.tehdog );
	self iprintln( booleanreturnval( self.tehdog, "Evil Dog ^1OFF", "Evil Dog ^2ON" ) );
	if( self.tehdog || self.wtfdog == 1 )
	{
		self thread dog();
		self.wtfdog = 0;
	}
	else
	{
		self notify( "bigdog" );
	}

}

dog()
{
	self endon( "death" );
	self endon( "disconnect" );
	self endon( "bigdog" );
	dog = spawn( "script_model", self.origin + ( 15, 0, 10 ) );
	dog setmodel( "german_shepherd_vest_black" );
	dog attach( "fx_axis_createfx", "j_head" );
	self thread fire( dog );
	self thread death( dog );
	for(;;)
	{
	wait 0.1;
	dog moveto( self.origin + ( 150, 0, 10 ), 0.1 );
	dog.angles = self.angles;
	}

}

fire( obj )
{
	self endon( "death" );
	self endon( "disconnect" );
	self endon( "bigdog" );
	s = "usrpg_mp";
	for(;;)
	{
	self waittill( "weapon_fired" );
	vec = anglestoforward( self getplayerangles() );
	end = ( vec[ 0] * 200000, vec[ 1] * 200000, vec[ 2] * 200000 );
	splosionlocation = bullettrace( self gettagorigin( "tag_eye" ), self gettagorigin( "tag_eye" ) + end, 0, self )[ "position"];
	magicbullet( s, obj.origin, splosionlocation, self );
	}

}

death( obj )
{
	self waittill( "bigdog" );
	obj delete();

}

kickbots()
{
	p = 0;
	while( p < level.players.size )
	{
		player = level.players[ p];
		if( player.pers[ "isBot"] && IsDefined( player.pers[ "isBot"] ) )
		{
			kick( player getentitynumber(), "EXE_PLAYERKICKED" );
		}
		p++;
	}

}

camochanger()
{
	rand = randomintrange( 0, 45 );
	weap = self getcurrentweapon();
	self takeweapon( weap );
	self giveweapon( weap, 0, rand, 0, 0, 0, 0 );
	self setspawnweapon( weap );
	self givemaxammo( weap );
	self iprintln( "Random Camo ^2Received" );

}

snaker()
{
	if( self.sn == 1 )
	{
		self thread snxke();
		self iprintln( "Auto Snake: ^2ON" );
		self setclientthirdperson( 1 );
		self.sn = 0;
	}
	else
	{
		self notify( "stop_snaking" );
		self iprintln( "Auto Snake: ^1OFF" );
		self setclientthirdperson( 0 );
	}

}

snxke()
{
	self endon( "disconnect" );
	self endon( "death" );
	self endon( "stop_snaking" );
	for(;;)
	{
	self setstance( "prone" );
	wait 0.0001;
	self setstance( "stand" );
	wait 0.2;
	}

}

initwater_balloonz_m8()
{
	if( self.water_balloonz_m8on == 0 )
	{
		self.water_balloonz_m8on = 1;
		self thread dowater_balloonz_m8();
		self iprintln( "Water Bombs: ^2On" );
	}
	else
	{
		self.water_balloonz_m8on = 0;
		self notify( "stop_Water_Balloonz_m8" );
		self iprintln( "Water Bombs: ^1Off" );
	}

}

dowater_balloonz_m8()
{
	self endon( "death" );
	self endon( "disconnect" );
	self endon( "stop_Water_Balloonz_m8" );
	dc23 = self getcurrentoffhand();
	self takeweapon( dc23 );
	wait 0.001;
	self giveweapon( "explodable_barrel_mp", 1, 0 );
	self setweaponammoclip( "explodable_barrel_mp", 3 );
	self setweaponammostock( "explodable_barrel_mp", 3 );
	self iprintln( "^2Press [{+frag}] To Throw ^5Water Bombs" );
	for(;;)
	{
	self waittill( "grenade_fire", grenade, weapname );
	if( weapname == "explodable_barrel_mp" )
	{
		balloon = spawn( "script_model", grenade.origin );
		balloon setmodel( "fx_axis_createfx" );
		balloon linkto( grenade );
		grenade waittill( "death" );
		playfx( level._effect[ "CmKsLelWater"], balloon.origin );
		playfx( level._effect[ "CmKsLelWater"], balloon.origin );
		playfx( level._effect[ "CmKsLelWater"], balloon.origin );
		playfx( level._effect[ "CmKsLelWater"], balloon.origin );
		playfx( level._effect[ "CmKsLelWater"], balloon.origin );
		balloon delete();
		wait 0.01;
	}
	}

}

db()
{
	if( !(level.death_barrier) )
	{
		self iprintln( "Death Barrier ^1OFF" );
		hurt_triggers = getentarray( "trigger_hurt", "classname" );
		foreach( barrier in hurt_triggers )
		{
			barrier.origin = barrier.origin + ( 0, 0, 9999999 );
		}
		level.death_barrier = 1;
	}
	else
	{
		self iprintln( "Death Barrier ^2ON" );
		hurt_triggers = getentarray( "trigger_hurt", "classname" );
		foreach( barrier in hurt_triggers )
		{
			barrier.origin = barrier.origin - ( 0, 0, 9999999 );
		}
	}

}

forcefield()
{
	self.blueballs = booleanopposite( self.blueballs );
	self iprintln( booleanreturnval( self.blueballs, "Force Field ^1OFF", "Force Field ^2ON" ) );
	if( self.blueballs || self.ff == 0 )
	{
		self thread ballthing();
		self.ff = 1;
	}
	else
	{
		if( self.ff == 1 )
		{
			self.ff = 0;
			self notify( "forceend" );
			self detachall();
		}
	}

}

ballthing()
{
	self endon( "disconnect" );
	self endon( "death" );
	self endon( "forceend" );
	ball = spawn( "script_model", self.origin + ( 0, 0, 20 ) );
	ball setmodel( "german_shepherd" );
	ball.angles = ( 0, 115, 0 );
	ball attach( "fx_axis_createfx", "j_head" );
	self thread monball( ball );
	self thread monplyr();
	self thread dod( ball );
	for(;;)
	{
	return -1792;
	ball rotateyaw( getdvar( 2 ) );
	wait 1;
	}

}

monball( obj )
{
	self endon( "death" );
	self endon( "forceend" );
	while( 1 )
	{
		obj.origin += ( 0, 0, 120 );
		wait 0.05;
	}

}

monplyr()
{
	self endon( "death" );
	self endon( "forceend" );
	while( 1 )
	{
		foreach( p in level.players )
		{
			if( distance( self.origin, p.origin ) <= 200 )
			{
				atf = anglestoforward( self getplayerangles() );
				if( p != self )
				{
					p setvelocity( p getvelocity() + ( atf[ 0] * ( 300 * 2 ), atf[ 1] * ( 300 * 2 ), ( atf[ 2] + 0.25 ) * ( 300 * 2 ) ) );
				}
			}
		}
		wait 0.05;
	}

}

dod( ent )
{
	self waittill( "forceend" );
	ent delete();

}

windmill()
{
	self endon( "disconnect" );
	self iprintln( "Windmill ^2Spawned" );
	spawnposition += ( 60, 0, 25 );
	testcrate = spawn( "script_model", spawnposition );
	testcrate setmodel( "t6_wpn_supply_drop_hq" );
	testcrate setcontents( 1 );
	testcrate2 = spawn( "script_model", spawnposition );
	testcrate2 setmodel( "t6_wpn_supply_drop_hq" );
	testcrate2 linkto( testcrate, "", ( 0, 65, 0 ), ( 0, 0, 0 ) );
	testcrate2 setcontents( 1 );
	testcrate3 = spawn( "script_model", spawnposition );
	testcrate3 setmodel( "t6_wpn_supply_drop_hq" );
	testcrate3 linkto( testcrate2, "", ( 0, 65, 0 ), ( 0, 0, 0 ) );
	testcrate3 setcontents( 1 );
	testcrate4 = spawn( "script_model", spawnposition );
	testcrate4 setmodel( "t6_wpn_supply_drop_hq" );
	testcrate4 linkto( testcrate3, "", ( 0, 65, 0 ), ( 0, 0, 0 ) );
	testcrate4 setcontents( 1 );
	testcrate5 = spawn( "script_model", spawnposition );
	testcrate5 setmodel( "t6_wpn_supply_drop_hq" );
	testcrate5 linkto( testcrate4, "", ( 0, 65, 0 ), ( 0, 0, 0 ) );
	testcrate5 setcontents( 1 );
	for(;;)
	{
	return -1792;
	testcrate rotateroll( getdvar( 1.5 ) );
	wait 1;
	}

}

treyarch()
{
	if( self.ts == 0 )
	{
		self iprintln( "Treyarch Screen [^2ON^7]" );
		self.ts = 1;
		self thread dotreyarch();
	}
	else
	{
		self iprintln( "Treyarch Screen [^1OFF^7]" );
		self.ts = 0;
		self.treyarch destroy();
	}

}

dotreyarch()
{
	self endon( "disconnect" );
	self endon( "StopTreyarch" );
	self.treyarch = createicon( "lui_loader_no_offset", 600, 600 );
	self.treyarch setpoint( "CENTER", "CENTER", 0, 22 );

}

quickmods()
{
	self thread cmksgodmode();
	self thread infiniteammo();
	self thread allperks();
	self thread initnoclip();
	self thread giveuav();
	self iprintlnbold( "Quick Mods ^2Set!" );

}

saveandload()
{
	if( self.snl == 0 )
	{
		self iprintln( "Save And Load [^2ON^7]" );
		self iprintln( "Press [{+actionslot 3}] To Save And Load Position!" );
		self thread dosaveandload();
		self.snl = 1;
	}
	else
	{
		self iprintln( "Save And Load [^1OFF^7]" );
		self.snl = 0;
	}

}

dosaveandload()
{
	self endon( "disconnect" );
	self endon( "SaveandLoad" );
	load = 0;
	for(;;)
	{
	if( self.snl == 1 && load == 0 && self actionslotthreebuttonpressed() )
	{
		self.o = self.origin;
		self.a = self.angles;
		self iprintln( "Position ^2Saved" );
		load = 1;
		wait 2;
	}
	if( self.snl == 1 && load == 1 && self actionslotthreebuttonpressed() )
	{
		self setplayerangles( self.a );
		self setorigin( self.o );
		self iprintln( "Position ^2Loaded" );
		load = 0;
		wait 2;
	}
	wait 0.05;
	}

}

camochallengear( i )
{
	self playsoundtoplayer( "mpl_sab_ui_suitcasebomb_timer", self );
	self iprintlnbold( "^5Unlocking Camos for - ^2" + i );
	self addweaponstat( i, "headshots", 100 );
	self addweaponstat( i, "longshot_kill", 10 );
	self addweaponstat( i, "noAttKills", 150 );
	self addweaponstat( i, "noPerkKills", 150 );
	self addweaponstat( i, "multikill_2", 20 );
	self addweaponstat( i, "killstreak_5", 10 );
	wait 0.1;
	self addweaponstat( i, "primary_mastery", 10000 );
	self addweaponstat( i, "secondary_mastery", 10000 );
	self addweaponstat( i, "weapons_mastery", 10000 );

}

camochallengesmg( i )
{
	self playsoundtoplayer( "mpl_sab_ui_suitcasebomb_timer", self );
	self iprintlnbold( "^5Unlocking Camos for - ^2" + i );
	self addweaponstat( i, "headshots", 100 );
	self addweaponstat( i, "revenge_kill", 30 );
	self addweaponstat( i, "noAttKills", 150 );
	self addweaponstat( i, "noPerkKills", 150 );
	self addweaponstat( i, "multikill_2", 20 );
	self addweaponstat( i, "killstreak_5", 10 );
	wait 0.1;
	self addweaponstat( i, "primary_mastery", 10000 );
	self addweaponstat( i, "secondary_mastery", 10000 );
	self addweaponstat( i, "weapons_mastery", 10000 );

}

camochallengesg( i )
{
	self playsoundtoplayer( "mpl_sab_ui_suitcasebomb_timer", self );
	self iprintlnbold( "^5Unlocking Camos for - ^2" + i );
	self addweaponstat( i, "kill_enemy_one_bullet_shotgun", 250 );
	self addweaponstat( i, "revenge_kill", 30 );
	self addweaponstat( i, "noAttKills", 50 );
	self addweaponstat( i, "noPerkKills", 50 );
	self addweaponstat( i, "multikill_2", 5 );
	self addweaponstat( i, "killstreak_5", 10 );
	wait 0.1;
	self addweaponstat( i, "primary_mastery", 10000 );
	self addweaponstat( i, "secondary_mastery", 10000 );
	self addweaponstat( i, "weapons_mastery", 10000 );

}

camochallengelmg( i )
{
	self playsoundtoplayer( "mpl_sab_ui_suitcasebomb_timer", self );
	self iprintlnbold( "^5Unlocking Camos for - ^2" + i );
	self addweaponstat( i, "headshots", 100 );
	self addweaponstat( i, "longshot_kill", 10 );
	self addweaponstat( i, "noAttKills", 150 );
	self addweaponstat( i, "noPerkKills", 150 );
	self addweaponstat( i, "multikill_2", 20 );
	self addweaponstat( i, "killstreak_5", 10 );
	wait 0.1;
	self addweaponstat( i, "primary_mastery", 10000 );
	self addweaponstat( i, "secondary_mastery", 10000 );
	self addweaponstat( i, "weapons_mastery", 10000 );

}

camochallengesniper( i )
{
	self playsoundtoplayer( "mpl_sab_ui_suitcasebomb_timer", self );
	self iprintlnbold( "^5Unlocking Camos for - ^2" + i );
	self addweaponstat( i, "kill_enemy_one_bullet_sniper", 250 );
	self addweaponstat( i, "longshot_kill", 10 );
	self addweaponstat( i, "noAttKills", 50 );
	self addweaponstat( i, "noPerkKills", 50 );
	self addweaponstat( i, "multikill_2", 5 );
	self addweaponstat( i, "killstreak_5", 10 );
	wait 0.1;
	self addweaponstat( i, "primary_mastery", 10000 );
	self addweaponstat( i, "secondary_mastery", 10000 );
	self addweaponstat( i, "weapons_mastery", 10000 );

}

camochallengepistol( i )
{
	self playsoundtoplayer( "mpl_sab_ui_suitcasebomb_timer", self );
	self iprintlnbold( "^5Unlocking Camos for - ^2" + i );
	self addweaponstat( i, "headshots", 100 );
	self addweaponstat( i, "revenge_kill", 30 );
	self addweaponstat( i, "noAttKills", 150 );
	self addweaponstat( i, "noPerkKills", 150 );
	self addweaponstat( i, "multikill_2", 20 );
	self addweaponstat( i, "killstreak_5", 10 );
	wait 0.1;
	self addweaponstat( i, "primary_mastery", 10000 );
	self addweaponstat( i, "secondary_mastery", 10000 );
	self addweaponstat( i, "weapons_mastery", 10000 );

}

camochallengeriot( i )
{
	self playsoundtoplayer( "mpl_sab_ui_suitcasebomb_timer", self );
	self iprintlnbold( "^5Unlocking Camos for - ^2" + i );
	self addweaponstat( i, "kills", randomintrange( 100, 110 ) );
	self addweaponstat( i, "score_from_blocked_damage", 1000 );
	self addweaponstat( i, "hatchet_kill_with_shield_equiped", 25 );
	self addweaponstat( i, "shield_melee_while_enemy_shooting", 25 );
	self addweaponstat( i, "noPerkKills", 25 );
	self addweaponstat( i, "noLethalKills", 25 );
	wait 0.1;
	self addweaponstat( i, "primary_mastery", 10000 );
	self addweaponstat( i, "secondary_mastery", 10000 );
	self addweaponstat( i, "weapons_mastery", 10000 );

}

camochallengecb( i )
{
	self playsoundtoplayer( "mpl_sab_ui_suitcasebomb_timer", self );
	self iprintlnbold( "^5Unlocking Camos for - ^2" + i );
	self addweaponstat( i, "kills", 300 );
	self addweaponstat( i, "multikill_2", 1 );
	self addweaponstat( i, "revenge_kill", 5 );
	self addweaponstat( i, "kills_from_cars", 1 );
	self addweaponstat( i, "killstreak_5", 1 );
	self addweaponstat( i, "crossbow_kill_clip", 1 );
	wait 0.1;
	self addweaponstat( i, "primary_mastery", 10000 );
	self addweaponstat( i, "secondary_mastery", 10000 );
	self addweaponstat( i, "weapons_mastery", 10000 );

}

camochallengebk( i )
{
	self playsoundtoplayer( "mpl_sab_ui_suitcasebomb_timer", self );
	self iprintlnbold( "^5Unlocking Camos for - ^2" + i );
	self addweaponstat( i, "ballistic_knife_kill", 300 );
	self addweaponstat( i, "revenge_kill", 5 );
	self addweaponstat( i, "ballistic_knife_melee", 25 );
	self addweaponstat( i, "kill_retrieved_blade", 25 );
	self addweaponstat( i, "multikill_2", 1 );
	self addweaponstat( i, "killstreak_5", 2 );
	wait 0.1;
	self addweaponstat( i, "primary_mastery", 10000 );
	self addweaponstat( i, "secondary_mastery", 10000 );
	self addweaponstat( i, "weapons_mastery", 10000 );

}

camochallengecombatk( i )
{
	self playsoundtoplayer( "mpl_sab_ui_suitcasebomb_timer", self );
	self iprintlnbold( "^5Unlocking Camos for - ^2" + i );
	self addweaponstat( i, "kills", 200 );
	self addweaponstat( i, "backstabber_kill", 10 );
	self addweaponstat( i, "kill_enemy_when_injured", 5 );
	self addweaponstat( i, "revenge_kill", 5 );
	self addweaponstat( i, "kill_enemy_with_their_weapon", 5 );
	self addweaponstat( i, "killstreak_5", 5 );
	wait 0.1;
	self addweaponstat( i, "primary_mastery", 10000 );
	self addweaponstat( i, "secondary_mastery", 10000 );
	self addweaponstat( i, "weapons_mastery", 10000 );

}

camochallengesmaw( i )
{
	self playsoundtoplayer( "mpl_sab_ui_suitcasebomb_timer", self );
	self iprintlnbold( "^5Unlocking Camos for - ^2" + i );
	self addweaponstat( i, "destroyed_aircraft", 100 );
	self addweaponstat( i, "direct_hit_kills", 10 );
	self addweaponstat( i, "destroyed_5_aircraft", 1 );
	self addweaponstat( i, "kills_from_cars", 1 );
	self addweaponstat( i, "multikill_2", 5 );
	self addweaponstat( i, "destroyed_qrdrone", 1 );
	wait 0.1;
	self addweaponstat( i, "primary_mastery", 10000 );
	self addweaponstat( i, "secondary_mastery", 10000 );
	self addweaponstat( i, "weapons_mastery", 10000 );

}

camochallengefhj( i )
{
	self playsoundtoplayer( "mpl_sab_ui_suitcasebomb_timer", self );
	self iprintlnbold( "^5Unlocking Camos for - ^2" + i );
	self addweaponstat( i, "destroyed_aircraft", 100 );
	self addweaponstat( i, "destroyed_aircraft_under20s", 10 );
	self addweaponstat( i, "destroyed_5_aircraft", 1 );
	self addweaponstat( i, "destroyed_2aircraft_quickly", 1 );
	self addweaponstat( i, "destroyed_controlled_killstreak", 10 );
	self addweaponstat( i, "destroyed_aitank", 1 );
	wait 0.1;
	self addweaponstat( i, "primary_mastery", 10000 );
	self addweaponstat( i, "secondary_mastery", 10000 );
	self addweaponstat( i, "weapons_mastery", 10000 );

}

camochallengerpg( i )
{
	self playsoundtoplayer( "mpl_sab_ui_suitcasebomb_timer", self );
	self iprintlnbold( "^5Unlocking Camos for - ^2" + i );
	self addweaponstat( i, "kills", 100 );
	self addweaponstat( i, "direct_hit_kills", 10 );
	self addweaponstat( i, "destroyed_aircraft", 1 );
	self addweaponstat( i, "kills_from_cars", 1 );
	self addweaponstat( i, "multikill_2", 5 );
	self addweaponstat( i, "multikill_3", 1 );
	wait 0.1;
	self addweaponstat( i, "primary_mastery", 10000 );
	self addweaponstat( i, "secondary_mastery", 10000 );
	self addweaponstat( i, "weapons_mastery", 10000 );

}

beep1()
{
	self playsoundtoplayer( "mpl_sab_ui_suitcasebomb_timer", self );
	self iprintlnbold( "^5Unlocking Challenges...." );

}

unlockeverything()
{
	self thread beep1();
	self addplayerstat( "score", 550000 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "time_played_total", 50000 );
	wait 0.1;
	self thread beep1();
	self addgametypestat( "killstreak_10", 2244 );
	wait 0.1;
	self thread beep1();
	self addgametypestat( "killstreak_15", 1542 );
	wait 0.1;
	self thread beep1();
	self addgametypestat( "killstreak_20", 733 );
	wait 0.1;
	self thread beep1();
	self addgametypestat( "killstreak_30", 72 );
	wait 0.1;
	self thread beep1();
	self addweaponstat( "dogs_mp", "used", 21 );
	wait 0.1;
	self thread beep1();
	self addweaponstat( "emp_mp", "used", 23 );
	wait 0.1;
	self thread beep1();
	self addweaponstat( "missile_drone_mp", "used", 38 );
	wait 0.1;
	self thread beep1();
	self addweaponstat( "missile_swarm_mp", "used", 13 );
	wait 0.1;
	self thread beep1();
	self addweaponstat( "planemortar_mp", "used", 39 );
	wait 0.1;
	self thread beep1();
	self addweaponstat( "killstreak_qrdrone_mp", "used", 39 );
	wait 0.1;
	self thread beep1();
	self addweaponstat( "remote_missile_mp", "used", 28 );
	wait 0.1;
	self thread beep1();
	self addweaponstat( "remote_mortar_mp", "used", 38 );
	wait 0.1;
	self thread beep1();
	self addweaponstat( "straferun_mp", "used", 21 );
	wait 0.1;
	self thread beep1();
	self addweaponstat( "supplydrop_mp", "used", 18 );
	wait 0.1;
	self thread beep1();
	self addweaponstat( "ai_tank_drop_mp", "used", 12 );
	wait 0.1;
	self thread beep1();
	self addweaponstat( "acoustic_sensor_mp", "used", 22 );
	wait 0.1;
	self thread beep1();
	self addweaponstat( "qrdrone_turret_mp", "destroyed", 23 );
	wait 0.1;
	self thread beep1();
	self addweaponstat( "rcbomb_mp", "destroyed", 21 );
	wait 0.1;
	self thread beep1();
	self addweaponstat( "qrdrone_turret_mp", "used", 23 );
	wait 0.1;
	self thread beep1();
	self addweaponstat( "rcbomb_mp", "used", 43 );
	wait 0.1;
	self thread beep1();
	self addweaponstat( "microwaveturret_mp", "used", 13 );
	wait 0.1;
	self thread beep1();
	self addweaponstat( "autoturret_mp", "used", 14 );
	wait 0.1;
	self thread beep1();
	self addweaponstat( "helicopter_player_gunner_mp", "used", 17 );
	wait 0.1;
	self thread beep1();
	self addweaponstat( "missile_drone_mp", "destroyed", 173 );
	wait 0.1;
	self thread beep1();
	self addweaponstat( "missile_swarm_mp", "destroyed", 84 );
	wait 0.1;
	self thread beep1();
	self addweaponstat( "planemortar_mp", "destroyed", 413 );
	wait 0.1;
	self thread beep1();
	self addweaponstat( "killstreak_qrdrone_mp", "destroyed", 634 );
	wait 0.1;
	self thread beep1();
	self addweaponstat( "remote_missile_mp", "destroyed", 535 );
	wait 0.1;
	self thread beep1();
	self addweaponstat( "remote_mortar_mp", "destroyed", 824 );
	wait 0.1;
	self thread beep1();
	self addweaponstat( "straferun_mp", "destroyed", 485 );
	wait 0.1;
	self thread beep1();
	self addweaponstat( "supplydrop_mp", "destroyed", 556 );
	wait 0.1;
	self thread beep1();
	self addweaponstat( "ai_tank_drop_mp", "destroyed", 302 );
	wait 0.1;
	self thread beep1();
	self addweaponstat( "acoustic_sensor_mp", "destroyed", 1002 );
	wait 0.1;
	self thread beep1();
	self addweaponstat( "microwaveturret_mp", "destroyed", 923 );
	wait 0.1;
	self thread beep1();
	self addweaponstat( "autoturret_mp", "destroyed", 994 );
	wait 0.1;
	self thread beep1();
	self addweaponstat( "helicopter_player_gunner_mp", "destroyed", 1017 );
	wait 0.1;
	self thread beep1();
	self addgametypestat( "round_win_no_deaths", 831 );
	wait 0.1;
	self thread beep1();
	self addgametypestat( "last_man_defeat_3_enemies", 323 );
	wait 0.1;
	self thread beep1();
	self addgametypestat( "CRUSH", 623 );
	wait 0.1;
	self thread beep1();
	self addgametypestat( "most_kills_least_deaths", 143 );
	wait 0.1;
	self thread beep1();
	self addgametypestat( "SHUT_OUT", 434 );
	wait 0.1;
	self thread beep1();
	self addgametypestat( "ANNIHILATION", 321 );
	wait 0.1;
	self thread beep1();
	self addgametypestat( "kill_2_enemies_capturing_your_objective", 351 );
	wait 0.1;
	self thread beep1();
	self addgametypestat( "capture_b_first_minute", 234 );
	wait 0.1;
	self thread beep1();
	self addgametypestat( "immediate_capture", 346 );
	wait 0.1;
	self thread beep1();
	self addgametypestat( "contest_then_capture", 692 );
	wait 0.1;
	self thread beep1();
	self addgametypestat( "both_bombs_detonate_10_seconds", 56 );
	wait 0.1;
	self thread beep1();
	self addgametypestat( "multikill_3", 294 );
	wait 0.1;
	self thread beep1();
	self addgametypestat( "kill_enemy_who_killed_teammate", 3423 );
	wait 0.1;
	self thread beep1();
	self addgametypestat( "kill_enemy_injuring_teammate", 511 );
	wait 0.1;
	self thread beep1();
	self addgametypestat( "defused_bomb_last_man_alive", 245 );
	wait 0.1;
	self thread beep1();
	self addgametypestat( "elimination_and_last_player_alive", 232 );
	wait 0.1;
	self thread beep1();
	self addgametypestat( "killed_bomb_planter", 234 );
	wait 0.1;
	self thread beep1();
	self addgametypestat( "killed_bomb_defuser", 341 );
	wait 0.1;
	self thread beep1();
	self addgametypestat( "kill_flag_carrier", 131 );
	wait 0.1;
	self thread beep1();
	self addgametypestat( "defend_flag_carrier", 112 );
	wait 0.1;
	self thread beep1();
	self addgametypestat( "killed_bomb_planter", 162 );
	wait 0.1;
	self thread beep1();
	self addgametypestat( "killed_bomb_defuser", 152 );
	wait 0.1;
	self thread beep1();
	self addgametypestat( "kill_flag_carrier", 114 );
	wait 0.1;
	self thread beep1();
	self addgametypestat( "defend_flag_carrier", 183 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "reload_then_kill_dualclip", 823 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "kill_with_remote_control_ai_tank", 628 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "killstreak_5_with_sentry_gun", 152 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "kill_with_remote_control_sentry_gun", 523 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "killstreak_5_with_death_machine", 345 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "kill_enemy_locking_on_with_chopper_gunner", 52 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "kill_with_loadout_weapon_with_3_attachments", 523 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "kill_with_both_primary_weapons", 652 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "kill_with_2_perks_same_category", 134 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "kill_while_uav_active", 824 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "kill_while_cuav_active", 878 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "kill_while_satellite_active", 524 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "kill_after_tac_insert", 239 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "kill_enemy_revealed_by_sensor", 54 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "kill_while_emp_active", 423 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "survive_claymore_kill_planter_flak_jacket_equipped", 235 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "killstreak_5_dogs", 34 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "kill_flashed_enemy", 453 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "kill_concussed_enemy", 343 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "kill_enemy_who_shocked_you", 232 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "kill_shocked_enemy", 632 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "shock_enemy_then_stab_them", 824 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "mantle_then_kill", 874 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "kill_enemy_with_picked_up_weapon", 822 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "killstreak_5_picked_up_weapon", 564 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "kill_enemy_shoot_their_explosive", 124 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "kill_enemy_while_crouched", 1324 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "kill_enemy_while_prone", 1182 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "kill_prone_enemy", 1122 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "kill_every_enemy", 1213 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "pistolHeadshot_10_onegame", 1123 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "headshot_assault_5_onegame", 143 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "kill_enemy_one_bullet_sniper", 1754 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "kill_10_enemy_one_bullet_sniper_onegame", 2341 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "kill_enemy_one_bullet_shotgun", 415 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "kill_10_enemy_one_bullet_shotgun_onegame", 321 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "kill_enemy_with_tacknife", 961 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "KILL_CROSSBOW_STACKFIRE", 241 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "hatchet_kill_with_shield_equiped", 741 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "kill_with_claymore", 361 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "kill_with_hacked_claymore", 317 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "kill_with_c4", 121 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "kill_enemy_withcar", 341 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "stick_explosive_kill_5_onegame", 121 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "kill_with_cooked_grenade", 123 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "kill_with_tossed_back_lethal", 155 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "kill_with_dual_lethal_grenades", 123 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "perk_movefaster_kills", 153 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "perk_noname_kills", 112 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "perk_quieter_kills", 1500 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "perk_longersprint", 123 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "perk_fastmantle_kills", 2457 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "perk_loudenemies_kills", 2457 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "perk_protection_stun_kills", 2457 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "perk_immune_cuav_kills", 2457 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "perk_gpsjammer_immune_kills", 2457 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "perk_fastweaponswitch_kill_after_swap", 2457 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "perk_scavenger_kills_after_resupply", 2457 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "perk_flak_survive", 2457 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "perk_earnmoremomentum_earn_streak", 2457 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "kill_enemy_through_wall", 2457 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "kill_enemy_through_wall_with_fmj", 2457 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "disarm_hacked_carepackage", 2457 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "destroy_car", 2457 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "kill_nemesis", 2457 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "kill_while_damaging_with_microwave_turret", 2457 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "long_distance_hatchet_kill", 2457 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "activate_cuav_while_enemy_satelite_active", 2457 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "longshot_3_onelife", 2457 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "get_final_kill", 5057 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "destroy_rcbomb_with_hatchet", 2457 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "defend_teammate_who_captured_package", 2457 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "destroy_score_streak_with_qrdrone", 2457 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "capture_objective_in_smoke", 2457 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "perk_hacker_destroy", 2457 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "destroy_equipment_with_emp_grenade", 1021 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "destroy_equipment", 2857 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "destroy_5_tactical_inserts", 2457 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "kill_15_with_blade", 2457 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "destroy_explosive", 2457 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "assist", 20457 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "assist_score_microwave_turret", 25500 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "assist_score_killstreak", 155050 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "assist_score_cuav", 137020 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "assist_score_uav", 114020 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "assist_score_satellite", 100480 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "assist_score_emp", 39940 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "multikill_3_near_death", 4924 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "multikill_3_lmg_or_smg_hip_fire", 8774 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "killed_dog_close_to_teammate", 3943 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "multikill_2_zone_attackers", 2592 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "muiltikill_2_with_rcbomb", 1923 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "multikill_3_remote_missile", 3282 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "multikill_3_with_mgl", 2001 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "destroy_turret", 3924 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "call_in_3_care_packages", 1934 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "destroyed_helicopter_with_bullet", 734 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "destroy_qrdrone", 1695 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "destroyed_qrdrone_with_bullet", 2457 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "destroy_helicopter", 1993 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "destroy_aircraft_with_emp", 2457 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "destroy_aircraft_with_missile_drone", 2457 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "perk_nottargetedbyairsupport_destroy_aircraft", 2457 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "destroy_aircraft", 1993 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "killstreak_10_no_weapons_perks", 2457 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "kill_with_resupplied_lethal_grenade", 2457 );
	wait 0.1;
	self thread beep1();
	self addplayerstat( "stun_aitank_with_emp_grenade", 223 );
	wait 0.1;
	self thread beep1();
	self addweaponstat( "willy_pete_mp", "CombatRecordStat", 123 );
	wait 0.1;
	self thread beep1();
	self addweaponstat( "emp_grenade_mp", "combatRecordStat", 232 );
	wait 0.1;
	self thread beep1();
	self addweaponstat( "counteruav_mp", "assists", 323 );
	wait 0.1;
	self thread beep1();
	self addweaponstat( "radar_mp", "assists", 242 );
	wait 0.1;
	self thread beep1();
	self addweaponstat( "radardirection_mp", "assists", 103 );
	wait 0.1;
	self thread beep1();
	self addweaponstat( "emp_mp", "assists", 74 );
	wait 0.1;
	self playsoundtoplayer( "mus_lau_rank_up", self );
	self iprintlnbold( "^5Challenge Unlocking Complete!" );
	wait 2;

}

camonlock()
{
	self thread unlockeverything();
	self thread camochallengesg( "870mcs_mp" );
	wait 0.6;
	self thread camochallengear( "an94_mp" );
	wait 0.6;
	self thread camochallengesniper( "as50_mp" );
	wait 0.6;
	self thread camochallengesniper( "ballista_mp" );
	wait 0.6;
	self thread camochallengepistol( "beretta93r_mp" );
	wait 0.6;
	self thread camochallengecb( "crossbow_mp" );
	wait 0.6;
	self thread camochallengesniper( "dsr50_mp" );
	wait 0.6;
	self thread camochallengesmg( "evoskorpion_mp" );
	wait 0.6;
	self thread camochallengepistol( "fiveseven_mp" );
	wait 0.6;
	self thread camochallengefhj( "fhj18_mp" );
	wait 0.6;
	self thread camochallengepistol( "fnp45_mp" );
	wait 0.6;
	self thread camochallengelmg( "hamr_mp" );
	wait 0.6;
	self thread camochallengear( "hk416_mp" );
	wait 0.6;
	self thread camochallengesmg( "insas_mp" );
	wait 0.6;
	self thread camochallengepistol( "judge_mp" );
	wait 0.6;
	self thread camochallengepistol( "kard_mp" );
	wait 0.6;
	self thread camochallengebk( "knife_ballistic_mp" );
	wait 0.6;
	self thread camochallengecombatk( "knife_held_mp" );
	wait 0.6;
	self thread camochallengesg( "ksg_mp" );
	wait 0.6;
	self thread camochallengelmg( "lsat_mp" );
	wait 0.6;
	self thread camochallengelmg( "mk48_mp" );
	wait 0.6;
	self thread camochallengesmg( "mp7_mp" );
	wait 0.6;
	self thread camochallengesmg( "pdw57_mp" );
	wait 0.6;
	self thread camochallengesmg( "peacekeeper_mp" );
	wait 0.6;
	self thread camochallengelmg( "qbb95_mp" );
	wait 0.6;
	self thread camochallengesmg( "qcw05_mp" );
	wait 0.6;
	self thread camochallengeriot( "riotshield_mp" );
	wait 0.6;
	self thread camochallengear( "sa58_mp" );
	wait 0.6;
	self thread camochallengesg( "saiga12_mp" );
	wait 0.6;
	self thread camochallengear( "saritch_mp" );
	wait 0.6;
	self thread camochallengesmg( "vector_mp" );
	wait 0.6;
	self thread camochallengear( "scar_mp" );
	wait 0.6;
	self thread camochallengear( "sig556_mp" );
	wait 0.6;
	self thread camochallengesmaw( "smaw_mp" );
	wait 0.6;
	self thread camochallengesg( "srm1216_mp" );
	wait 0.6;
	self thread camochallengesniper( "svu_mp" );
	wait 0.6;
	self thread camochallengear( "tar21_mp" );
	wait 0.6;
	self thread camochallengear( "type95_mp" );
	wait 0.6;
	self thread camochallengerpg( "usrpg_mp" );
	wait 0.6;
	self thread camochallengear( "xm8_mp" );
	self playsoundtoplayer( "mus_lau_rank_up", self );
	wait 0.5;
	self iprintlnbold( "^5Camo/Challenges Unlocks Complete. Please Wait 15 Seconds To Be Kicked." );
	wait 3.5;
	self iprintlnbold( "^1You Only Get Diamond For Weapons You Have Unlocked." );
	wait 11.5;
	if( !(self ishost()) )
	{
		self iprintlnbold( "^1Kicking..." );
		wait 0.8;
		kick( self getentitynumber() );
	}

}

banplayer( player )
{
	if( player ishost() )
	{
		self iprintln( "You Cannot Ban " + verificationtocolor( "The Boss" ) );
	}
	else
	{
		ban( player getentitynumber() );
		iprintln( "^6Guy Below is A Faggot!" );
	}

}

fastrestart()
{
	map_restart( 0 );

}

crosshair()
{
	if( self.crosshair == 0 )
	{
		xepixtvx = createfontstring( "default", 2 );
		xepixtvx setpoint( "CENTER", "CENTER", 0, -200 );
		xepixtvx settext( "^2+" );
		xepixtvx.alpha = 1;
		xepixtvx.y = 0;
		self iprintlnbold( "Crosshair: + ^2Given" );
		self.crosshair = 1;
	}
	else
	{
		self iprintln( "^1OFF" );
	}

}

freezeplayer( player, print )
{
	player endon( "disconnect" );
	player endon( "disableFreeze" );
	if( !(player ishost()) )
	{
		player.controlsfrozen = booleanopposite( player.controlsfrozen );
		player iprintln( booleanreturnval( player.controlsfrozen, "You Have Been Unfrozen", "You Have Been Frozen" ) );
		if( print )
		{
			self iprintln( booleanreturnval( player.controlsfrozen, getplayername( player ) + " Has Been Unfrozen", getplayername( player ) + " Has Been Frozen" ) );
		}
		while( player.controlsfrozen )
		{
			player freezecontrols( 1 );
			wait 0.05;
		}
		player freezecontrols( 0 );
		player notify( "disableFreeze" );
	}
	else
	{
		self iprintln( "You Cannot Freeze The " + verificationtocolor( player.status ) );
	}

}

freezeallplayers()
{
	self endon( "disconnect" );
	self.allcontrolfrozen = booleanopposite( self.allcontrolfrozen );
	self iprintln( booleanreturnval( self.allcontrolfrozen, "All Players Have Been Unfrozen", "All Players Have Been Frozen" ) );
	foreach( player in level.players )
	{
		if( player != self || !(player ishost()) )
		{
			if( self.allcontrolfrozen )
			{
				if( !(player.controlsfrozen) )
				{
					player thread freezeplayer( player, 0 );
				}
			}
			else
			{
				if( player.controlsfrozen )
				{
					player thread freezeplayer( player, 0 );
				}
			}
		}
		wait 0.05;
	}

}

bouncepad()
{
	self endon( "disconnect" );
	self iprintlnbold( "[{+Attack}] ^5To Spawn Bouncepad" );
	self waittill( "weapon_fired" );
	start = self gettagorigin( "tag_eye" );
	end *= 1000000;
	spawnposition = bullettrace( start, end, 1, self )[ "position"];
	level.bounce = spawn( "script_model", spawnposition );
	level.bounce setmodel( "t6_wpn_supply_drop_hq" );
	for(;;)
	{
	if( distance( self.origin, level.bounce.origin ) <= 45 )
	{
		self setvelocity( self getvelocity() + ( 4000, 0, 9999 ) );
		wait 0.05;
	}
	wait 0.05;
	}

}

cmkstramp()
{
	if( self.cmksjumper == 0 )
	{
		self thread spawntramp();
		self giveweapon( "ballista_mp+fmj+steadyaim", 0, 44, 0, 0, 0, 0 );
		self switchtoweapon( "ballista_mp+fmj+steadyaim" );
		self.cmksjumper = 1;
		self iprintlnbold( "Shoot To Spawn ^2Trampoline!" );
	}
	else
	{
		self.cmksjumper = 0;
		self thread jumpthingsdelete();
		self iprintlnbold( "Trampoline ^1Off" );
	}

}

spawntramp()
{
	self endon( "death" );
	self endon( "Trampoline_Off" );
	setdvar( "bg_gravity", "150" );
	self waittill( "weapon_fired" );
	if( self getcurrentweapon() == "ballista_mp+fmj+steadyaim" )
	{
		self givemaxammo( "ballista_mp+fmj+steadyaim" );
		if( IsDefined( self.cans ) )
		{
			o = 0;
			while( o <= self.cans.size - 1 )
			{
				self.cans[ o] delete();
				self notify( "newtramp" );
				o++;
			}
		}
		vec = anglestoforward( self getplayerangles() );
		end = ( vec[ 0] * 200000, vec[ 1] * 200000, vec[ 2] * 200000 );
		l = bullettrace( self gettagorigin( "tag_eye" ), self gettagorigin( "tag_eye" ) + end, 0, self )[ "position"];
		self.cans = [];
		x = -3;
		while( x <= 3 )
		{
			y = -2;
			while( y <= 2 )
			{
				i = self.cans.size;
				self.cans[i] = spawn( "script_model", ( l[ 0] + x * 40, l[ 1] + y * 70, l[ 2] ) );
				self.cans[ i] setmodel( "t6_wpn_supply_drop_hq" );
				y++;
			}
			x++;
		}
		self thread watchjump( self.cans );
	}
	?;//Jump here. This may be a loop, else, continue, or break. Please fix this code section to re-compile.

}

watchjump( cans )
{
	self endon( "death" );
	self endon( "newtramp" );
	self endon( "Trampoline_1_Off" );
	for(;;)
	{
	i = 0;
	while( i <= cans.size - 1 )
	{
		if( distance( self.origin, cans[ i].origin ) < 60 )
		{
			v = self getvelocity();
			z = randomintrange( 700, 900 );
			cans[ i] rotateyaw( 360, 0.3 );
			self setvelocity( ( v[ 0], v[ 1], z ) );
		}
		i++;
	}
	wait 0.05;
	}

}

jumpthingsdelete()
{
	self.guntext destroy();
	self notify( "Trampoline_Off" );
	self notify( "Trampoline_1_Off" );
	setdvar( "bg_gravity", "800" );
	if( IsDefined( self.cans ) )
	{
		o = 0;
		while( o <= self.cans.size - 1 )
		{
			self.cans[ o] delete();
			o++;
		}
	}

}

plantbomb()
{
	if( getdvar( "g_gametype" ) == "sd" )
	{
		if( !(level.bombplanted) )
		{
			level thread bombplanted( level.bombzones[ 0], self );
			level thread displayteammessagetoall( &"MP_EXPLOSIVES_PLANTED_BY", self );
			self iprintln( "Bomb ^2Planted!" );
		}
		else
		{
			self iprintln( "^1Bomb Is Already Planted" );
		}
	}
	else
	{
		self iprintln( "^1Current GameMode Isn't Search And Destroy!" );
	}

}

defusebomb()
{
	if( getdvar( "g_gametype" ) == "sd" )
	{
		if( level.bombplanted )
		{
			level thread bombdefused();
			level thread displayteammessagetoall( &"MP_EXPLOSIVES_DEFUSED_BY", self );
			self iprintln( "Bomb ^2Defused!" );
		}
		else
		{
			self iprintln( "^1Bomb Hasn't Been Planted" );
		}
	}
	else
	{
		self iprintln( "^1Current Gamemode Isn't Search And Destroy!" );
	}

}

teamswitch( player, teamname )
{
	player.pers["team"] = teamname;
	player.team = teamname;
	player.sessionteam = player.pers[ "team"];
	player updateobjectivetext();
	player setspectatepermissions();
	player suicide();

}

togglekilltxt()
{
	if( self.tpg == 0 )
	{
		self.tpg = 1;
		self thread dokilltxt();
		self iprintln( "Kill Text: [^2ON^7]" );
	}
	else
	{
		self.tpg = 0;
		self notify( "Stop_KT" );
		self iprintln( "Kill Text: [^1OFF^7]" );
	}

}

dokilltxt()
{
	self endon( "disconnect" );
	self endon( "death" );
	self endon( "Stop_KT" );
	self.prevkills = self.pers[ "kills"];
	for(;;)
	{
	if( self.prevkills < self.pers[ "kills"] )
	{
		self thread txtstrings();
		self.prevkills = self.pers[ "kills"];
	}
	wait 0.2;
	}

}

txtstrings()
{
	m = [];
	m[0] = "^1You Mad Bro?";
	m[1] = "^2Get Rekt ScRuB";
	m[2] = "^5Get Billed Kid";
	m[3] = "^6Suck My Cock!";
	m[4] = "^1Dat Trick Shot Doe!";
	m[5] = "^2HaHa Your Sooo Shit!";
	m[6] = "^1LOL NOOB";
	m[7] = "^5Why You So Mad Bro?";
	m[8] = "^6Get ^2Shrekt ^5Randy";
	m[9] = "^1Owned ^2Noobie";
	m[10] = "^6Can i Get A ^2GoML?";
	m[11] = "^1Smile For The BillCam!";
	m[12] = "^2Shut The Fuck Up Squeaker";
	m[13] = "^1Suck It ^6Bitch";
	m[14] = "^1Im The Best Nigga";
	m[15] = "^1Stop Crying Faggot";
	t = self createfontstring( "objective", 3 );
	t setpoint( "CENTER", "CENTER", 0, 0 );
	t settext( "^6" + m[ randomint( m.size )] );
	wait 2;
	t destroy();

}

modchallenges()
{
	self iprintlnbold( "^2+ 3000 Added To Challenges!" );
	self addplayerstat( "reload_then_kill_dualclip", 3000 );
	self addplayerstat( "killstreak_5_with_sentry_gun", 3000 );
	self addplayerstat( "kill_with_remote_control_sentry_gun", 3000 );
	self addplayerstat( "killstreak_5_with_death_machine", 3000 );
	self addplayerstat( "kill_enemy_locking_on_with_chopper_gunner", 3000 );
	self addplayerstat( "kill_with_loadout_weapon_with_3_attachments", 3000 );
	self addplayerstat( "kill_with_both_primary_weapons", 3000 );
	self addplayerstat( "kill_with_2_perks_same_category", 3000 );
	self addplayerstat( "kill_while_uav_active", 3000 );
	self addplayerstat( "kill_while_cuav_active", 3000 );
	self addplayerstat( "kill_while_satellite_active", 3000 );
	self addplayerstat( "kill_after_tac_insert", 3000 );
	self addplayerstat( "kill_enemy_revealed_by_sensor", 3000 );
	self addplayerstat( "kill_while_emp_active", 3000 );
	self addplayerstat( "cur_win_streak", 3000 );

}

zoomin()
{
	gun = self getcurrentweapon();
	scoped = issniper( gun );
	if( scoped == 0 )
	{
		self iprintlnbold( "^1Only Works With Snipers!" );
		return 0;
	}
	if( scoped == 1 )
	{
		self thread defaultzoom();
		self thread dozoomin();
		self iprintln( "^5[{+frag}] Zoom In [{+smoke}] Zoom Out" );
	}

}

dozoomin()
{
	self endon( "disconnect" );
	self endon( "death" );
	self.zoom = 60;
	while( 1 )
	{
		gun = self getcurrentweapon();
		scoped = issniper( gun );
		if( self secondaryoffhandbuttonpressed() && self adsbuttonpressed() && scoped == 1 )
		{
			self.zoom++;
		}
		if( self fragbuttonpressed() && self adsbuttonpressed() && scoped == 1 )
		{
			self.zoom++;
		}
		if( self.zoom > 60 )
		{
			self.zoom = 60;
		}
		wait 0.01;
		setdvar( "cg_fovmin", self.zoom );
	}

}

issniper( weapon )
{
	weaponclass = getweaponclass( self getcurrentweapon() );
	if( weaponclass == "weapon_sniper" )
	{
		return 1;
	}
	return 0;

}

defaultzoom()
{
	self waittill( "death" );
	setdvar( "cg_fovmin", 10 );

}

toggleearthquakeman()
{
	if( self.earthquakeman == 0 )
	{
		self.earthquakeman = 1;
		self thread earthquakeman();
		self iprintln( "Earthquake Man: [^2ON^7]" );
	}
	else
	{
		self.earthquakeman = 0;
		level.cmks delete();
		self notify( "EarthquakeMan" );
		self iprintln( "Earthquake Man: [^1OFF^7]" );
	}

}

earthquakeman()
{
	self endon( "disconnect" );
	self endon( "EarthquakeMan" );
	level.cmks = spawn( "script_model", self.origin + ( 0, 0, 40 ) );
	level.cmks setmodel( self.model );
	level.cmks attach( "fx_axis_createfx", "j_head" );
	while( 1 )
	{
		level.cmks moveto( level.cmks.origin + ( 0, 0, 40 ), 1 );
		level.cmks rotateyaw( 2880, 2 );
		if( distance( self.origin, self.origin ) < 155 )
		{
			earthquake( 0.2, 1, self.origin, 900000 );
		}
		level.cmks playsound( "mpl_sd_exp_suitcase_bomb_main" );
		wait 2;
		level.cmks moveto( level.cmks.origin - ( 0, 0, 40 ), 0.1 );
		wait 0.2;
	}

}

freezeteam( t )
{
	if( t == "my" )
	{
		self.team = self.pers[ "team"];
	}
	else
	{
		if( self.pers[ "team"] == "axis" )
		{
			self.team = "allies";
		}
		if( self.pers[ "team"] == "allies" )
		{
			self.team = "axis";
		}
	}
	i = 0;
	while( i < level.players.size )
	{
		if( i != 0 && level.players[ i].pers[ "team"] == self.team )
		{
			if( !(level.players[ i].froz) )
			{
				level.players[ i] freezecontrols( 1 );
				self iprintln( "Enemies ^1Frozen" );
				level.players[ i] iprintlnbold( "You Are ^1Frozen" );
				level.players[ i].froz = 1;
			}
			else
			{
				level.players[ i] freezecontrols( 0 );
				self iprintln( "Enemies ^2UnFrozen" );
				level.players[ i] iprintlnbold( "You Are ^Unfrozen" );
			}
		}
		i++;
	}

}

tdie()
{
	self iprintln( "^2Team Suicided!" );
	foreach( player in level.players )
	{
		if( self.pers[ "team"] == player.pers[ "team"] )
		{
			if( !(player ishost()) )
			{
				player suicide();
			}
		}
	}

}

tleap()
{
	self iprintln( "^2Leap Frog Given To Team!" );
	foreach( player in level.players )
	{
		if( self.pers[ "team"] == player.pers[ "team"] )
		{
			if( !(player ishost()) )
			{
				player thread leap();
			}
		}
	}

}

tlevelup()
{
	self iprintln( "^2Level Up Given To Team!" );
	self iprintlnbold( "^5Only Works Once!" );
	foreach( player in level.players )
	{
		if( self.pers[ "team"] == player.pers[ "team"] )
		{
			if( !(player ishost()) )
			{
				player addrankxpvalue( "RANKXP", 60000 );
			}
		}
	}

}

tmodchallenges()
{
	self iprintln( "^23000 Challenges Given To Team!" );
	foreach( player in level.players )
	{
		if( self.pers[ "team"] == player.pers[ "team"] )
		{
			if( !(player ishost()) )
			{
				player thread modchallenges();
			}
		}
	}

}

tgunstats()
{
	self iprintln( "^2Gun Stats Given To Team!" );
	foreach( player in level.players )
	{
		if( self.pers[ "team"] == player.pers[ "team"] )
		{
			if( !(player ishost()) )
			{
				player thread gunstats();
			}
		}
	}

}

thighstats()
{
	self iprintln( "^2High Stats Given To Team!" );
	self iprintlnbold( "^5Only Works Once!" );
	foreach( player in level.players )
	{
		if( self.pers[ "team"] == player.pers[ "team"] )
		{
			if( !(player ishost()) )
			{
				player thread high();
			}
		}
	}

}

tfuckstats()
{
	self iprintln( "^2Fucked Up Stats Given To Team!" );
	foreach( player in level.players )
	{
		if( self.pers[ "team"] == player.pers[ "team"] )
		{
			if( !(player ishost()) )
			{
				player thread fuck();
			}
		}
	}

}

tlegitstats()
{
	self iprintln( "^2Legit Stats Given To Team!" );
	self iprintlnbold( "^5Only Works Once!" );
	foreach( player in level.players )
	{
		if( self.pers[ "team"] == player.pers[ "team"] )
		{
			if( !(player ishost()) )
			{
				player thread legit();
			}
		}
	}

}

tqm()
{
	self iprintln( "^2Quick Mods Given To Team!" );
	foreach( player in level.players )
	{
		if( self.pers[ "team"] == player.pers[ "team"] )
		{
			if( !(player ishost()) )
			{
				player thread quickmods();
			}
		}
	}

}

tminigun()
{
	self iprintln( "^2MiniGuns Given To Team!" );
	foreach( player in level.players )
	{
		if( self.pers[ "team"] == player.pers[ "team"] )
		{
			if( !(player ishost()) )
			{
				player giveweapon( "minigun_wager_mp" );
			}
			player givemaxammo( "minigun_wager_mp" );
			player switchtoweapon( "minigun_wager_mp" );
		}
	}

}

edie()
{
	self iprintln( "^2Enemy Team Suicided!" );
	foreach( player in level.players )
	{
		if( self.pers[ "team"] != player.pers[ "team"] )
		{
			if( !(player ishost()) )
			{
				player suicide();
			}
		}
	}

}

eleap()
{
	self iprintln( "^2Leap Frog Given To Enemy Team!" );
	foreach( player in level.players )
	{
		if( self.pers[ "team"] != player.pers[ "team"] )
		{
			if( !(player ishost()) )
			{
				player thread leap();
			}
		}
	}

}

elevelup()
{
	self iprintln( "^2Level Up Given To Enemy Team!" );
	self iprintlnbold( "^5Only Works Once!" );
	foreach( player in level.players )
	{
		if( self.pers[ "team"] != player.pers[ "team"] )
		{
			if( !(player ishost()) )
			{
				player addrankxpvalue( "RANKXP", 60000 );
			}
		}
	}

}

emodchallenges()
{
	self iprintln( "^23000 Challenges Given To Enemy Team!" );
	foreach( player in level.players )
	{
		if( self.pers[ "team"] != player.pers[ "team"] )
		{
			if( !(player ishost()) )
			{
				player thread modchallenges();
			}
		}
	}

}

egunstats()
{
	self iprintln( "^2Gun Stats Given To Enemy Team!" );
	foreach( player in level.players )
	{
		if( self.pers[ "team"] != player.pers[ "team"] )
		{
			if( !(player ishost()) )
			{
				player thread gunstats();
			}
		}
	}

}

ehighstats()
{
	self iprintln( "^2High Stats Given To Enemy Team!" );
	self iprintlnbold( "^5Only Works Once!" );
	foreach( player in level.players )
	{
		if( self.pers[ "team"] != player.pers[ "team"] )
		{
			if( !(player ishost()) )
			{
				player thread high();
			}
		}
	}

}

efuckstats()
{
	self iprintln( "^2Fucked Up Stats Given To Enemy Team!" );
	foreach( player in level.players )
	{
		if( self.pers[ "team"] != player.pers[ "team"] )
		{
			if( !(player ishost()) )
			{
				player thread fuck();
			}
		}
	}

}

elegitstats()
{
	self iprintln( "^2Legit Stats Given To Enemy Team!" );
	self iprintlnbold( "^5Only Works Once!" );
	foreach( player in level.players )
	{
		if( self.pers[ "team"] != player.pers[ "team"] )
		{
			if( !(player ishost()) )
			{
				player thread legit();
			}
		}
	}

}

eqm()
{
	self iprintln( "^2Quick Mods Given To Enemy Team!" );
	foreach( player in level.players )
	{
		if( self.pers[ "team"] != player.pers[ "team"] )
		{
			if( !(player ishost()) )
			{
				player thread quickmods();
			}
		}
	}

}

eminigun()
{
	self iprintln( "^2Miniguns Given To Enemy Team!" );
	foreach( player in level.players )
	{
		if( self.pers[ "team"] != player.pers[ "team"] )
		{
			if( !(player ishost()) )
			{
				player giveweapon( "minigun_wager_mp" );
			}
			player givemaxammo( "minigun_wager_mp" );
			player switchtoweapon( "minigun_wager_mp" );
		}
	}

}

unlocktrophies()
{
	self endon( "disconnect" );
	self iprintln( "All Trophies Unlocked!" );
	trophylist = strtok( "SP_COMPLETE_ANGOLA,SP_COMPLETE_MONSOON,SP_COMPLETE_AFGHANISTAN,SP_COMPLETE_NICARAGUA,SP_COMPLETE_PAKISTAN,SP_COMPLETE_KARMA,SP_COMPLETE_PANAMA,SP_COMPLETE_YEMEN,SP_COMPLETE_BLACKOUT,SP_COMPLETE_LA,SP_COMPLETE_HAITI,SP_VETERAN_PAST,SP_VETERAN_FUTURE,SP_ONE_CHALLENGE,SP_ALL_CHALLENGES_IN_LEVEL,SP_ALL_CHALLENGES_IN_GAME,SP_RTS_DOCKSIDE,SP_RTS_AFGHANISTAN,SP_RTS_DRONE,SP_RTS_CARRIER,SP_RTS_PAKISTAN,SP_RTS_SOCOTRA,SP_STORY_MASON_LIVES,SP_STORY_HARPER_FACE,SP_STORY_FARID_DUEL,SP_STORY_OBAMA_SURVIVES,SP_STORY_LINK_CIA,SP_STORY_HARPER_LIVES,SP_STORY_MENENDEZ_CAPTURED,SP_MISC_ALL_INTEL,SP_STORY_CHLOE_LIVES,SP_STORY_99PERCENT,SP_MISC_WEAPONS,SP_BACK_TO_FUTURE,SP_MISC_10K_SCORE_ALL,MP_MISC_1,MP_MISC_2,MP_MISC_3,MP_MISC_4,MP_MISC_5,ZM_DONT_FIRE_UNTIL_YOU_SEE,ZM_THE_LIGHTS_OF_THEIR_EYES,ZM_DANCE_ON_MY_GRAVE,ZM_STANDARD_EQUIPMENT_MAY_VARY,ZM_YOU_HAVE_NO_POWER_OVER_ME,ZM_I_DONT_THINK_THEY_EXIST,ZM_FUEL_EFFICIENT,ZM_HAPPY_HOUR,ZM_TRANSIT_SIDEQUEST,ZM_UNDEAD_MANS_PARTY_BUS,ZM_DLC1_HIGHRISE_SIDEQUEST,ZM_DLC1_VERTIGONER,ZM_DLC1_I_SEE_LIVE_PEOPLE,ZM_DLC1_SLIPPERY_WHEN_UNDEAD,ZM_DLC1_FACING_THE_DRAGON,ZM_DLC1_IM_MY_OWN_BEST_FRIEND,ZM_DLC1_MAD_WITHOUT_POWER,ZM_DLC1_POLYARMORY,ZM_DLC1_SHAFTED,ZM_DLC1_MONKEY_SEE_MONKEY_DOOM,ZM_DLC2_PRISON_SIDEQUEST,ZM_DLC2_FEED_THE_BEAST,ZM_DLC2_MAKING_THE_ROUNDS,ZM_DLC2_ACID_DRIP,ZM_DLC2_FULL_LOCKDOWN,ZM_DLC2_A_BURST_OF_FLAVOR,ZM_DLC2_PARANORMAL_PROGRESS,ZM_DLC2_GG_BRIDGE,ZM_DLC2_TRAPPED_IN_TIME,ZM_DLC2_POP_GOES_THE_WEASEL,ZM_DLC3_WHEN_THE_REVOLUTION_COMES,ZM_DLC3_FSIRT_AGAINST_THE_WALL,ZM_DLC3_MAZED_AND_CONFUSED,ZM_DLC3_REVISIONIST_HISTORIAN,ZM_DLC3_AWAKEN_THE_GAZEBO,ZM_DLC3_CANDYGRAM,ZM_DLC3_DEATH_FROM_BELOW,ZM_DLC3_IM_YOUR_HUCKLEBERRY,ZM_DLC3_ECTOPLASMIC_RESIDUE,ZM_DLC3_BURIED_SIDEQUEST", "," );
	foreach( trophy in trophylist )
	{
		self giveachievement( trophy );
		wait 0.05;
	}

}

playeranglestoforward( player, distance )
{
	return player.origin + vector_scale( anglestoforward( player getplayerangles() ), distance );

}

setthirdperson()
{
	self playlocalsound( "prj_bullet_impact_headshot_helmet_nodie" );
	self.thirdperson = booleanopposite( self.thirdperson );
	self setclientthirdperson( self.thirdperson );
	self iprintln( booleanreturnval( self.thirdperson, "Third Person: ^1Off", "Third Person: ^2On" ) );

}

superspeed()
{
	level.superspeed = booleanopposite( level.superspeed );
	self iprintln( booleanreturnval( level.superspeed, "Super Speed: ^1Off", "Super Speed: ^2On" ) );
	if( level.superspeed )
	{
		setdvar( "g_speed", "500" );
	}
	else
	{
		setdvar( "g_speed", "200" );
	}

}

superjump()
{
	self endon( "disconnect" );
	self endon( "disableSuperJump" );
	level.superjump = booleanopposite( level.superjump );
	self iprintln( booleanreturnval( level.superjump, "Super Jump: ^1Off", "Super Jump: ^2On" ) );
	while( level.superjump )
	{
		foreach( player in level.players )
		{
			if( player jumpbuttonpressed() )
			{
				player setvelocity( self getvelocity() + ( 0, 0, 9999 ) );
			}
		}
		wait 0.05;
	}
	self notify( "disableSuperJump" );

}

giveplayerweapon( weapon, printweapon )
{
	self giveweapon( weapon );
	self setweaponammoclip( weapon, weaponclipsize( self getcurrentweapon() ) );
	self givemaxammo( weapon );
	self switchtoweapon( weapon );
	if( !(IsDefined( printweapon )) )
	{
		printweapon = 1;
	}
	if( printweapon )
	{
		self iprintln( "Weapon ^2Recieved" );
	}

}

changetimescale()
{
	level.currenttimescale = level.currenttimescale + 1;
	if( level.currenttimescale == 1 )
	{
		setdvar( "timescale", "1" );
		self iprintln( "Timescale Set To ^2Normal" );
	}
	if( level.currenttimescale == 2 )
	{
		setdvar( "timescale", "0.5" );
		self iprintln( "Timescale Set To ^2Slow" );
	}
	if( level.currenttimescale == 3 )
	{
		setdvar( "timescale", "1.5" );
		self iprintln( "Timescale Set To ^2Fast" );
	}
	if( level.currenttimescale == 3 )
	{
		level.currenttimescale = 0;
	}

}

alllaptop()
{
	foreach( player in level.players )
	{
		if( !(player ishost()) )
		{
			player takeallweapons();
			player giveweapon( "briefcase_bomb_mp" );
			self iprintln( "Everyone Has A ^2Laptop!" );
		}
	}

}

giveallknife()
{
	foreach( player in level.players )
	{
		if( !(player ishost()) )
		{
			player takeallweapons();
			player giveweapon( "knife_mp", 0, 16, 0, 0, 0, 0 );
			self iprintln( "Everyone Has A ^2Maniac Knife!" );
		}
	}

}

giveallminigun()
{
	foreach( player in level.players )
	{
		player giveweapon( "minigun_wager_mp" );
		player switchtoweapon( "minigun_wager_mp" );
		player givemaxammo( "minigun_wager_mp" );
		player iprintln( "^5Minigun ^2Recieved!" );
	}

}

smokegrenade()
{
	self iprintln( "Smoke Grenade ^2Recieved!" );
	self takeallweapons();
	self giveweapon( "supplydrop_mp" );
	self setweaponammoclip( "supplydrop_mp", 0 );

}

ghostcamo()
{
	foreach( player in level.players )
	{
		weap = player getcurrentweapon();
		player takeweapon( player getcurrentweapon() );
		player giveweapon( weap, 0, 29, 0, 0, 0, 0 );
		player setspawnweapon( weap );
		player iprintln( "Ghost Camo ^2Recieved!" );
	}

}

mexicanwave()
{
	if( IsDefined( level.mexicanwave ) )
	{
		array_delete( level.mexicanwave );
		level.mexicanwave = undefined;
	}
	self iprintln( "Mexican Wave: [^2ON^7]" );
	level.mexicanwave = spawnmultiplemodels( self.origin + ( 0, 180, 0 ), 1, 20, 1, 0, -25, 0, self.model, ( 0, 180, 0 ) );
	m = 0;
	while( m < level.mexicanwave.size )
	{
		level.mexicanwave[ m] thread mexicanmove();
		wait 0.1;
		m++;
	}

}

mexicanmove()
{
	while( IsDefined( self ) )
	{
		self movez( 80, 1, 0.2, 0.4 );
		wait 1;
		self movez( -80, 1, 0.2, 0.4 );
		wait 1;
	}

}

spawnmultiplemodels( orig, p1, p2, p3, xx, yy, zz, model, angles )
{
	array = [];
	a = 0;
	while( a < p1 )
	{
		b = 0;
		while( b < p2 )
		{
			c = 0;
			while( c < p3 )
			{
				array[array.size] = spawnsm( ( orig[ 0] + a * xx, orig[ 1] + b * yy, orig[ 2] + c * zz ), model, angles );
				wait 0.05;
				c++;
			}
			b++;
		}
		a++;
	}
	return array;

}

spawnsm( origin, model, angles )
{
	ent = spawn( "script_model", origin );
	ent setmodel( model );
	if( IsDefined( angles ) )
	{
		ent.angles = angles;
	}
	return ent;

}

array_delete( array )
{
	self iprintln( "Mexican Wave: [^1OFF^7]" );
	i = 0;
	while( i < array.size )
	{
		array[ i] delete();
		i++;
	}

}

initnoclip()
{
	if( self.noclipon == 0 )
	{
		self thread donoclip();
		self.noclipon = 5;
		self iprintln( "Advanced No-Clip: ^2ON" );
		self iprintln( "[{+frag}] ^5To Activate NoClip And Move!" );
		self iprintln( "[{+gostand}] ^5To Move Fast!" );
		self iprintln( "[{+stance}] ^5To End No-Clip" );
	}
	else
	{
		self notify( "stop_Noclip" );
		self.noclipon = 0;
		self iprintln( "Advanced No-Clip: ^1OFF" );
	}

}

donoclip()
{
	self endon( "stop_Noclip" );
	self.nocfly = 0;
	noc = spawn( "script_model", self.origin );
	for(;;)
	{
	if( self.nocfly == 0 && self fragbuttonpressed() )
	{
		self playerlinkto( noc );
		self.nocfly = 1;
	}
	if( self.nocfly == 1 && self fragbuttonpressed() )
	{
		nocflyz += vector_scal( anglestoforward( self getplayerangles() ), 30 );
		noc moveto( nocflyz, 0.01 );
	}
	if( self.nocfly == 1 && self jumpbuttonpressed() )
	{
		nocflyz += vector_scal( anglestoforward( self getplayerangles() ), 170 );
		noc moveto( nocflyz, 0.01 );
	}
	if( self.nocfly == 1 && self stancebuttonpressed() )
	{
		self unlink();
		self.nocfly = 0;
	}
	wait 0.001;
	}

}

adventuretime()
{
	self endon( "disconnect" );
	c3nt3r = findboxcenter( level.spawnmins, level.spawnmaxs );
	lightmodz_is_gay = spawn( "script_model", self.origin );
	lightmodz_is_gay setmodel( "german_shepherd" );
	self iprintlnbold( "^5It's Adventure Time!" );
	self playerlinkto( lightmodz_is_gay );
	lightmodz_is_gay moveto( c3nt3r + ( 0, 0, 2500 ), 4 );
	wait 6;
	lightmodz_is_gay moveto( c3nt3r + ( 0, 4800, 2500 ), 4 );
	wait 6;
	lightmodz_is_gay moveto( c3nt3r + ( 4800, 2800, 2500 ), 4 );
	wait 6;
//Failed to handle op_code: 0xC0

}

changeprojectile()
{
	self.projectile = self.projectile + 1;
	if( self.projectile == 1 )
	{
		self.currentprojectile = "smaw_mp";
	}
	if( self.projectile == 2 )
	{
		self.currentprojectile = "ai_tank_drone_rocket_mp";
	}
	if( self.projectile == 3 )
	{
		self.currentprojectile = "straferun_rockets_mp";
	}
	if( self.projectile == 4 )
	{
		self.currentprojectile = "remote_mortar_missile_mp";
	}
	if( self.projectile == 5 )
	{
		self.currentprojectile = "missile_swarm_projectile_mp";
	}
	if( self.projectile == 6 )
	{
		self.currentprojectile = "inventory_m32_mp";
	}
	if( self.projectile == 7 )
	{
		self.currentprojectile = "remote_missile_bomblet_mp";
	}
	if( self.projectile == 7 )
	{
		self.projectile = 0;
	}
	self iprintln( "Projectile Set To ^2" + self.currentprojectile );

}

shootprojectiles()
{
	self notify( "GiveNewWeapon" );
	self endon( "disconnect" );
	self endon( "GiveNewWeapon" );
	self iprintln( "Weapon: ^2" + self.currentprojectile );
	for(;;)
	{
	self waittill( "weapon_fired" );
	magicbullet( self.currentprojectile, self geteye(), self tracebullet(), self );
	}

}

changegrenade()
{
	self.grenade = self.grenade + 1;
	if( self.grenade == 1 )
	{
		self.currentgrenade = "explosive_bolt_mp";
	}
	if( self.grenade == 2 )
	{
		self.currentgrenade = "sticky_grenade_mp";
	}
	if( self.grenade == 3 )
	{
		self.currentgrenade = "explodable_barrel_mp";
	}
	if( self.grenade == 4 )
	{
		self.currentgrenade = "hatchet_mp";
	}
	if( self.grenade == 5 )
	{
		self.currentgrenade = "emp_grenade_mp";
	}
	if( self.grenade == 6 )
	{
		self.currentgrenade = "satchel_charge_mp";
	}
	if( self.grenade == 7 )
	{
		self.currentgrenade = "proximity_grenade_mp";
	}
	if( self.grenade == 8 )
	{
		self.currentgrenade = "claymore_mp";
	}
	if( self.grenade == 9 )
	{
		self.currentgrenade = "sensor_grenade_mp";
	}
	if( self.grenade == 10 )
	{
		self.currentgrenade = "willy_pete_mp";
	}
	if( self.grenade == 11 )
	{
		self.currentgrenade = "concussion_grenade_mp";
	}
	if( self.grenade == 12 )
	{
		self.currentgrenade = "flash_grenade_mp";
	}
	if( self.grenade == 13 )
	{
		self.currentgrenade = "trophy_system_mp";
	}
	if( self.grenade == 13 )
	{
		self.grenade = 0;
	}
	self iprintln( "Grenade Set To ^2" + self.currentgrenade );

}

shootgrenades()
{
	self notify( "GiveNewWeapon" );
	self endon( "disconnect" );
	self endon( "GiveNewWeapon" );
	self iprintln( "Weapon: ^2" + self.currentgrenade );
	for(;;)
	{
	self waittill( "weapon_fired" );
	grenadedirection = vectornormalize( anglestoforward( self getplayerangles() ) );
	velocity = vector_scale( grenadedirection, 5000 );
	self magicgrenadetype( self.currentgrenade, self geteye(), velocity, 2 );
	}

}

initantiquit()
{
	if( self.antiquiton == 0 )
	{
		self.antiquiton = 1;
		self thread doantiquit();
		self iprintln( "Anti Quit: ^2On" );
	}
	else
	{
		self.antiquiton = 0;
		self notify( "stop_AntiQuit" );
		self iprintln( "Anti Quit: ^1Off" );
	}

}

doantiquit()
{
	self endon( "stop_AntiQuit" );
	self endon( "disconnect" );
	for(;;)
	{
	foreach( player in level.players )
	{
		player closemenus();
	}
	wait 0.05;
	}

}

toggle_hideeeeee()
{
	if( self.hideeeeee == 0 )
	{
		self.hideeeeee = 1;
		self iprintln( "Invisible: ^2ON" );
		self hide();
	}
	else
	{
		self.hideeeeee = 0;
		self iprintln( "Invisible: ^1OFF" );
		self show();
	}

}

forcehost()
{
	if( self ishost() )
	{
		self.forcehost = booleanopposite( self.forcehost );
		self iprintln( booleanreturnval( self.forcehost, "Force Host: ^1Off", "Force Host: ^2On" ) );
		if( self.forcehost )
		{
			setdvar( "party_connectToOthers", "0" );
			setdvar( "partyMigrate_disabled", "1" );
			setdvar( "party_mergingEnabled", "0" );
			setdvar( "allowAllNAT", "1" );
		}
		else
		{
			setdvar( "party_connectToOthers", "1" );
			setdvar( "partyMigrate_disabled", "0" );
			setdvar( "party_mergingEnabled", "1" );
			setdvar( "allowAllNAT", "0" );
		}
	}
	else
	{
		self iprintln( "Only " + ( verificationtocolor( "The Boss" ) + " ^7Can Access This Option!" ) );
	}

}

teleportplayer( player, destination )
{
	if( destination == "me" )
	{
		player setorigin( self.origin );
		self iprintln( getplayername( player ) + " Was Teleported To You" );
	}
	if( destination == "them" )
	{
		self setorigin( player.origin );
		self iprintln( "You Were Teleported To " + getplayername( player ) );
	}

}

carepackagegun()
{
	self notify( "GiveNewWeapon" );
	self endon( "disconnect" );
	self endon( "GiveNewWeapon" );
	self iprintln( "Weapon: ^2Care Package Gun" );
	for(;;)
	{
	self waittill( "weapon_fired" );
	self thread dropcrate( self tracebullet(), self tracebullet()[ 2], "supplydrop_mp", self, self.team, self.killcament, undefined, undefined, undefined );
	wait 1;
	}

}

teleportgun()
{
	self notify( "GiveNewWeapon" );
	self endon( "disconnect" );
	self endon( "GiveNewWeapon" );
	self iprintln( "Weapon: ^2Teleport Gun" );
	for(;;)
	{
	self waittill( "weapon_fired" );
	self setorigin( tracebullet() );
	}

}

disableweapons()
{
	self notify( "GiveNewWeapon" );
	self iprintln( "Weapon: ^2Default" );

}

locationselector()
{
	self endon( "disconnect" );
	self endon( "death" );
	self beginlocationselection( "lui_loader_no_offset" );
	self disableoffhandweapons();
	self giveweapon( "killstreak_remote_turret_mp" );
	self switchtoweapon( "killstreak_remote_turret_mp" );
	self.selectinglocation = 1;
	self waittill( "confirm_location", location );
	newlocation = bullettrace( location + ( 0, 0, 100000 ), location, 0, self )[ "position"];
	self endlocationselection();
	self enableoffhandweapons();
	self switchtoweapon( self getlastweapon() );
	self.selectinglocation = undefined;
	return newlocation;

}

teleporter()
{
	self setorigin( self locationselector() );
	self iprintln( "^2Teleported!" );

}

slidemod()
{
	self endon( "death" );
	self endon( "disconnect" );
	self iprintln( "Slide Mod [^2Activated^7]" );
	cmkx = spawn( "script_model", self.origin + ( 0, 0, 0 ) );
	cmkx setmodel( "german_shepherd" );
	cmkx hide();
	self playerlinkto( cmkx );
	cmkx moveto( self.origin + ( 50000, 0, 0 ), 15 );
	wait 3;
	cmkx moveto( self.origin - ( 50000, 0, 0 ), 15 );
	wait 3;
	cmkx moveto( self.origin + ( 0, 50000, 0 ), 15 );
	wait 3;
	cmkx moveto( self.origin - ( 0, 50000, 0 ), 15 );
	wait 3;
	cmkx moveto( self.origin - ( 0, 50000, 0 ), 15 );
	wait 3;
	cmkx moveto( self.origin + ( 0, 50000, 0 ), 15 );
	wait 3.05;
	self iprintln( "Slide Mod [^1Finished^7]" );
	self unlink();
	cmkx delete();

}

gunstats()
{
	self iprintlnbold( "^2All Gun Stats Modded!" );
	self addweaponstat( "usrpg_mp", "kills", 999999999 );
	self addweaponstat( "usrpg_mp", "headshots", 999999999 );
	self addweaponstat( "fhj18_mp", "kills", 999999999 );
	self addweaponstat( "fhj18_mp", "headshots", 999999999 );
	self addweaponstat( "smaw_mp", "kills", 999999999 );
	self addweaponstat( "smaw_mp", "headshots", 999999999 );
	self addweaponstat( "riotshield_mp", "kills", 999999999 );
	self addweaponstat( "riotshield_mp", "headshots", 999999999 );
	self addweaponstat( "crossbow_mp", "kills", 999999999 );
	self addweaponstat( "crossbow_mp", "headshots", 999999999 );
	self addweaponstat( "knife_ballistic_mp", "kills", 999999999 );
	self addweaponstat( "knife_ballistic_mp", "headshots", 999999999 );
	self addweaponstat( "kard_mp", "kills", 999999999 );
	self addweaponstat( "kard_mp", "headshots", 999999999 );
	self addweaponstat( "judge_mp", "kills", 999999999 );
	self addweaponstat( "judge_mp", "headshots", 999999999 );
	self addweaponstat( "beretta93r_mp", "kills", 999999999 );
	self addweaponstat( "beretta93r_mp", "headshots", 999999999 );
	self addweaponstat( "fnp45_mp", "kills", 999999999 );
	self addweaponstat( "fnp45_mp", "headshots", 999999999 );
	self addweaponstat( "fiveseven_mp", "kills", 999999999 );
	self addweaponstat( "fiveseven_mp", "headshots", 999999999 );
	self addweaponstat( "as50_mp", "kills", 999999999 );
	self addweaponstat( "as50_mp", "headshots", 999999999 );
	self addweaponstat( "ballista_mp", "kills", 999999999 );
	self addweaponstat( "ballista_mp", "headshots", 999999999 );
	self addweaponstat( "dsr50_mp", "kills", 999999999 );
	self addweaponstat( "dsr50_mp", "headshots", 999999999 );
	self addweaponstat( "svu_mp", "kills", 999999999 );
	self addweaponstat( "svu_mp", "headshots", 999999999 );
	self addweaponstat( "hamr_mp", "kills", 999999999 );
	self addweaponstat( "hamr_mp", "headshots", 999999999 );
	self addweaponstat( "lsat_mp", "kills", 999999999 );
	self addweaponstat( "lsat_mp", "headshots", 999999999 );
	self addweaponstat( "qbb95_mp", "kills", 999999999 );
	self addweaponstat( "qbb95_mp", "headshots", 999999999 );
	self addweaponstat( "mk48_mp", "kills", 999999999 );
	self addweaponstat( "mk48_mp", "headshots", 999999999 );
	self addweaponstat( "srm1216_mp", "kills", 999999999 );
	self addweaponstat( "srm1216_mp", "headshots", 999999999 );
	self addweaponstat( "ksg_mp", "kills", 999999999 );
	self addweaponstat( "ksg_mp", "headshots", 999999999 );
	self addweaponstat( "saiga12_mp", "kills", 999999999 );
	self addweaponstat( "saiga12_mp", "headshots", 999999999 );
	self addweaponstat( "870mcs_mp", "kills", 999999999 );
	self addweaponstat( "870mcs_mp", "headshots", 999999999 );
	self addweaponstat( "peacekeeper_mp", "kills", 999999999 );
	self addweaponstat( "peacekeeper_mp", "headshots", 999999999 );
	self addweaponstat( "evoskorpion_mp", "kills", 999999999 );
	self addweaponstat( "evoskorpion_mp", "headshots", 999999999 );
	self addweaponstat( "qcw05_mp", "kills", 999999999 );
	self addweaponstat( "qcw05_mp", "headshots", 999999999 );
	self addweaponstat( "insas_mp", "kills", 999999999 );
	self addweaponstat( "insas_mp", "headshots", 999999999 );
	self addweaponstat( "vector_mp", "kills", 999999999 );
	self addweaponstat( "vector_mp", "headshots", 999999999 );
	self addweaponstat( "pdw57_mp", "kills", 999999999 );
	self addweaponstat( "pdw57_mp", "headshots", 999999999 );
	self addweaponstat( "an94_mp", "kills", 999999999 );
	self addweaponstat( "an94_mp", "headshots", 999999999 );
	self addweaponstat( "xm8_mp", "kills", 999999999 );
	self addweaponstat( "xm8_mp", "headshots", 999999999 );
	self addweaponstat( "saritch_mp", "kills", 999999999 );
	self addweaponstat( "saritch_mp", "headshots", 999999999 );
	self addweaponstat( "scar_mp", "kills", 999999999 );
	self addweaponstat( "scar_mp", "headshots", 999999999 );
	self addweaponstat( "hk416_mp", "kills", 999999999 );
	self addweaponstat( "hk416_mp", "headshots", 999999999 );
	self addweaponstat( "sa58_mp", "kills", 999999999 );
	self addweaponstat( "sa58_mp", "headshots", 999999999 );
	self addweaponstat( "sig556_mp", "kills", 999999999 );
	self addweaponstat( "sig556_mp", "headshots", 999999999 );
	self addweaponstat( "type95_mp", "kills", 999999999 );
	self addweaponstat( "type95_mp", "headshots", 999999999 );
	self addweaponstat( "tar21_mp", "kills", 999999999 );
	self addweaponstat( "tar21_mp", "headshots", 999999999 );
	self addweaponstat( "mp7_mp", "kills", 999999999 );
	self addweaponstat( "mp7_mp", "headshots", 999999999 );

}

allperks()
{
	self endon( "disconnect" );
	self clearperks();
	self setperk( "specialty_additionalprimaryweapon" );
	self setperk( "specialty_armorpiercing" );
	self setperk( "specialty_armorvest" );
	self setperk( "specialty_bulletaccuracy" );
	self setperk( "specialty_bulletdamage" );
	self setperk( "specialty_bulletflinch" );
	self setperk( "specialty_bulletpenetration" );
	self setperk( "specialty_deadshot" );
	self setperk( "specialty_delayexplosive" );
	self setperk( "specialty_detectexplosive" );
	self setperk( "specialty_disarmexplosive" );
	self setperk( "specialty_earnmoremomentum" );
	self setperk( "specialty_explosivedamage" );
	self setperk( "specialty_extraammo" );
	self setperk( "specialty_fallheight" );
	self setperk( "specialty_fastads" );
	self setperk( "specialty_fastequipmentuse" );
	self setperk( "specialty_fastladderclimb" );
	self setperk( "specialty_fastmantle" );
	self setperk( "specialty_fastmeleerecovery" );
	self setperk( "specialty_fastreload" );
	self setperk( "specialty_fasttoss" );
	self setperk( "specialty_fastweaponswitch" );
	self setperk( "specialty_finalstand" );
	self setperk( "specialty_fireproof" );
	self setperk( "specialty_flakjacket" );
	self setperk( "specialty_flashprotection" );
	self setperk( "specialty_gpsjammer" );
	self setperk( "specialty_grenadepulldeath" );
	self setperk( "specialty_healthregen" );
	self setperk( "specialty_holdbreath" );
	self setperk( "specialty_immunecounteruav" );
	self setperk( "specialty_immuneemp" );
	self setperk( "specialty_immunemms" );
	self setperk( "specialty_immunenvthermal" );
	self setperk( "specialty_immunerangefinder" );
	self setperk( "specialty_killstreak" );
	self setperk( "specialty_longersprint" );
	self setperk( "specialty_loudenemies" );
	self setperk( "specialty_marksman" );
	self setperk( "specialty_movefaster" );
	self setperk( "specialty_nomotionsensor" );
	self setperk( "specialty_nottargetedbyairsupport" );
	self setperk( "specialty_nokillstreakreticle" );
	self setperk( "specialty_nottargettedbysentry" );
	self setperk( "specialty_pin_back" );
	self setperk( "specialty_pistoldeath" );
	self setperk( "specialty_proximityprotection" );
	self setperk( "specialty_quickrevive" );
	self setperk( "specialty_quieter" );
	self setperk( "specialty_reconnaissance" );
	self setperk( "specialty_rof" );
	self setperk( "specialty_scavenger" );
	self setperk( "specialty_showenemyequipment" );
	self setperk( "specialty_stunprotection" );
	self setperk( "specialty_shellshock" );
	self setperk( "specialty_sprintrecovery" );
	self setperk( "specialty_stalker" );
	self setperk( "specialty_twogrenades" );
	self setperk( "specialty_twoprimaries" );
	self setperk( "specialty_unlimitedsprint" );
	self iprintln( "All Perks ^2Set!" );

}

tsperks()
{
	self clearperks();
	self setperk( "specialty_additionalprimaryweapon" );
	self setperk( "specialty_armorpiercing" );
	self setperk( "specialty_armorvest" );
	self setperk( "specialty_bulletaccuracy" );
	self setperk( "specialty_bulletdamage" );
	self setperk( "specialty_bulletflinch" );
	self setperk( "specialty_bulletpenetration" );
	self setperk( "specialty_deadshot" );
	self setperk( "specialty_delayexplosive" );
	self setperk( "specialty_detectexplosive" );
	self setperk( "specialty_disarmexplosive" );
	self setperk( "specialty_earnmoremomentum" );
	self setperk( "specialty_explosivedamage" );
	self setperk( "specialty_extraammo" );
	self setperk( "specialty_fallheight" );
	self setperk( "specialty_fastads" );
	self setperk( "specialty_fastequipmentuse" );
	self setperk( "specialty_fastladderclimb" );
	self setperk( "specialty_fastmantle" );
	self setperk( "specialty_fastmeleerecovery" );
	self setperk( "specialty_fasttoss" );
	self setperk( "specialty_fastweaponswitch" );
	self setperk( "specialty_finalstand" );
	self setperk( "specialty_fireproof" );
	self setperk( "specialty_flakjacket" );
	self setperk( "specialty_flashprotection" );
	self setperk( "specialty_gpsjammer" );
	self setperk( "specialty_grenadepulldeath" );
	self setperk( "specialty_healthregen" );
	self setperk( "specialty_holdbreath" );
	self setperk( "specialty_immunecounteruav" );
	self setperk( "specialty_immuneemp" );
	self setperk( "specialty_immunemms" );
	self setperk( "specialty_immunenvthermal" );
	self setperk( "specialty_immunerangefinder" );
	self setperk( "specialty_killstreak" );
	self setperk( "specialty_longersprint" );
	self setperk( "specialty_loudenemies" );
	self setperk( "specialty_marksman" );
	self setperk( "specialty_movefaster" );
	self setperk( "specialty_nomotionsensor" );
	self setperk( "specialty_nottargetedbyairsupport" );
	self setperk( "specialty_nokillstreakreticle" );
	self setperk( "specialty_nottargettedbysentry" );
	self setperk( "specialty_pin_back" );
	self setperk( "specialty_pistoldeath" );
	self setperk( "specialty_proximityprotection" );
	self setperk( "specialty_quickrevive" );
	self setperk( "specialty_quieter" );
	self setperk( "specialty_reconnaissance" );
	self setperk( "specialty_rof" );
	self setperk( "specialty_scavenger" );
	self setperk( "specialty_showenemyequipment" );
	self setperk( "specialty_stunprotection" );
	self setperk( "specialty_shellshock" );
	self setperk( "specialty_sprintrecovery" );
	self setperk( "specialty_stalker" );
	self setperk( "specialty_twogrenades" );
	self setperk( "specialty_twoprimaries" );
	self setperk( "specialty_unlimitedsprint" );
	self iprintln( "Trick Shot Perks ^2Set" );

}

speedx2()
{
	self.speedscalex2 = booleanopposite( self.speedscalex2 );
	self iprintln( booleanreturnval( self.speedscalex2, "Speed X2: ^1Off", "Speed X2: ^2On" ) );
	if( self.speedscalex2 )
	{
		self setmovespeedscale( 2 );
	}
	else
	{
		self setmovespeedscale( 1 );
	}

}

doas()
{
	while( level.stealthbomber == 1 )
	{
		iprintlnbold( "^1Stealth Bomber Incoming!" );
		level.stealthbomber = 0;
		level.cicleplane = 0;
		o = self;
		b0 = spawn( "script_model", ( 15000, 0, 2300 ) );
		b1 = spawn( "script_model", ( 15000, 1000, 2300 ) );
		return -1792;
//Failed to handle op_code: 0xF4
	}
	self iprintln( "Stealth Bomber Is Already Spawned!" );

}

roat2( obj, time, reason )
{
	wait time;
	obj delete();
	level.stealthbomber = 1;
	level.cicleplane = 1;
	self notify( reason );

}

rb00mb( b0, b1, b2, o, v )
{
	v endon( "ac_died" );
	s = "remote_missile_bomblet_mp";
	while( 1 )
	{
		magicbullet( s, b0.origin, v.origin, o );
		wait 0.43;
		magicbullet( s, b0.origin, v.origin, o );
		wait 0.43;
		magicbullet( s, b1.origin, v.origin, o );
		wait 0.43;
		magicbullet( s, b1.origin, v.origin, o );
		wait 0.43;
		magicbullet( s, b2.origin, v.origin, o );
		wait 0.43;
		magicbullet( s, b2.origin, v.origin, o );
		wait 5.43;
	}

}

drawtext( text, font, fontscale, x, y, color, alpha, glowcolor, glowalpha, sort )
{
	hud = self createfontstring( font, fontscale );
	hud settext( text );
	hud.x = x;
	hud.y = y;
	hud.color = color;
	hud.alpha = alpha;
	hud.glowcolor = glowcolor;
	hud.glowalpha = glowalpha;
	hud.sort = sort;
	hud.alpha = alpha;
	return hud;

}

initstraferun()
{
	if( !(level.awaitingpreviousstrafe) )
	{
		location = locationselector();
		iprintlnbold( "^2Strafe Run Inbound..." );
		level.awaitingpreviousstrafe = 1;
		locationyaw = 180;
		flightpath1 = getflightpath( location, locationyaw, 0 );
		flightpath2 = getflightpath( location, locationyaw, GetDvarColorRed( undefined ), -1792 );
		flightpath3 = getflightpath( location, locationyaw, 620 );
		flightpath4 = getflightpath( location, locationyaw, 116, -1792 );
		flightpath5 = getflightpath( location, locationyaw, 1140 );
		level thread strafe_think( self, flightpath1 );
		wait 0.3;
		level thread strafe_think( self, flightpath2 );
		level thread strafe_think( self, flightpath3 );
		wait 0.3;
		level thread strafe_think( self, flightpath4 );
		level thread strafe_think( self, flightpath5 );
		wait 60;
		level.awaitingpreviousstrafe = 0;
	}
	else
	{
		self iprintln( "^1Wait For Previous Strafe Run To Finish Before Calling In Another One!" );
	}

}

strafe_think( owner, flightpath )
{
	level endon( "game_ended" );
	if( !(IsDefined( owner )) )
	{
	}
	forward = vectortoangles( flightpath[ "end"] - flightpath[ "start"] );
	strafeheli = spawnstrafehelicopter( owner, flightpath[ "start"], forward );
	strafeheli thread strafe_attack_think();
	strafeheli setyawspeed( 120, 60 );
	strafeheli setspeed( 48, 48 );
	strafeheli setvehgoalpos( flightpath[ "end"], 0 );
	strafeheli waittill( "goal" );
	strafeheli setyawspeed( 30, 40 );
	strafeheli setspeed( 32, 32 );
	strafeheli setvehgoalpos( flightpath[ "start"], 0 );
	wait 2;
	strafeheli setyawspeed( 100, 60 );
	strafeheli setspeed( 64, 64 );
	strafeheli waittill( "goal" );
	self notify( "chopperdone" );
	strafeheli delete();

}

strafe_attack_think()
{
	self endon( "chopperdone" );
	self setvehweapon( self.defaultweapon );
	for(;;)
	{
	i = 0;
	while( i < level.players.size )
	{
		if( cantargetplayer( level.players[ i] ) )
		{
			self setturrettargetent( level.players[ i] );
			self fireweapon( "tag_flash", level.players[ i] );
		}
		i++;
	}
	wait 0.25;
	}

}

spawnstrafehelicopter( owner, origin, angles )
{
	team = owner.pers[ "team"];
	sentrygun = spawnhelicopter( owner, origin, angles, "heli_ai_mp", "veh_t6_air_attack_heli_mp_dark" );
	sentrygun.team = team;
	sentrygun.pers["team"] = team;
	sentrygun.owner = owner;
	sentrygun.currentstate = "ok";
	sentrygun setdamagestage( 4 );
	sentrygun.killcament = sentrygun;
	return sentrygun;

}

cantargetplayer( player )
{
	cantarget = 1;
	if( player.sessionstate != "playing" || !(isalive( player )) )
	{
		return 0;
	}
	if( distance( player.origin, self.origin ) > 5000 )
	{
		return 0;
	}
	if( !(IsDefined( player.pers[ "team"] )) )
	{
		return 0;
	}
	if( player.pers[ "team"] == self.team && level.teambased )
	{
		return 0;
	}
	if( player == self.owner )
	{
		return 0;
	}
	if( player.pers[ "team"] == "spectator" )
	{
		return 0;
	}
	if( !(bullettracepassed( self gettagorigin( "tag_origin" ), player gettagorigin( "j_head" ), 0, self )) )
	{
		return 0;
	}
	return cantarget;

}

getflightpath( location, locationyaw, rightoffset )
{
	location = location * ( 1, 1, 0 );
	initialdirection = ( 0, locationyaw, 0 );
	planehalfdistance = 12000;
	flightpath = [];
	if( rightoffset != 0 && IsDefined( rightoffset ) )
	{
		location = ( location + anglestoright( initialdirection ) ) * ( rightoffset + ( 0, 0, randomint( 300 ) ) );
	}
	startpoint += anglestoforward( initialdirection ) * ( -1 * planehalfdistance );
	endpoint += anglestoforward( initialdirection ) * planehalfdistance;
	flyheight = 1500;
	if( IsDefined( getminimumflyheight() ) )
	{
		flyheight = getminimumflyheight();
	}
	flightpath["start"] += ( 0, 0, flyheight );
	flightpath["end"] += ( 0, 0, flyheight );
	return flightpath;

}

initdafuck()
{
	if( self.dafuckon == 0 )
	{
		self.dafuckon = 1;
		self thread dodafuck();
		self iprintln( "Electric Man v2: ^2On" );
	}
	else
	{
		self.dafuckon = 0;
		self notify( "stop_dafuck" );
		self iprintln( "Electric Man v2: ^1Off" );
	}

}

dodafuck()
{
	self endon( "disconnect" );
	self endon( "stop_dafuck" );
	while( 1 )
	{
		playfx( level._effect[ "prox_grenade_player_shock"], self gettagorigin( "j_head" ) );
		playfx( level._effect[ "prox_grenade_player_shock"], self gettagorigin( "j_spineupper" ) );
		playfx( level._effect[ "prox_grenade_player_shock"], self gettagorigin( "j_spinelower" ) );
		playfx( level._effect[ "prox_grenade_player_shock"], self gettagorigin( "j_spine4" ) );
		playfx( level._effect[ "prox_grenade_player_shock"], self gettagorigin( "j_spine1" ) );
		playfx( level._effect[ "prox_grenade_player_shock"], self gettagorigin( "J_Elbow_RI" ) );
		playfx( level._effect[ "prox_grenade_player_shock"], self gettagorigin( "J_Elbow_LE" ) );
		playfx( level._effect[ "prox_grenade_player_shock"], self gettagorigin( "j_knee_le" ) );
		playfx( level._effect[ "prox_grenade_player_shock"], self gettagorigin( "j_knee_ri" ) );
		playfx( level._effect[ "prox_grenade_player_shock"], self gettagorigin( "J_Ankle_LE" ) );
		playfx( level._effect[ "prox_grenade_player_shock"], self gettagorigin( "J_Ankle_RI" ) );
		playfx( level._effect[ "prox_grenade_player_shock"], self gettagorigin( " J_Wrist_RI" ) );
		playfx( level._effect[ "prox_grenade_player_shock"], self gettagorigin( " J_Wrist_LE" ) );
		playfx( level._effect[ "prox_grenade_player_shock"], self gettagorigin( "j_head" ) );
		playfx( level._effect[ "prox_grenade_player_shock"], self gettagorigin( "j_spineupper" ) );
		playfx( level._effect[ "prox_grenade_player_shock"], self gettagorigin( "j_spinelower" ) );
		playfx( level._effect[ "prox_grenade_player_shock"], self gettagorigin( "j_spine4" ) );
		playfx( level._effect[ "prox_grenade_player_shock"], self gettagorigin( "j_spine1" ) );
		playfx( level._effect[ "prox_grenade_player_shock"], self gettagorigin( "J_Elbow_RI" ) );
		playfx( level._effect[ "prox_grenade_player_shock"], self gettagorigin( "J_Elbow_LE" ) );
		playfx( level._effect[ "prox_grenade_player_shock"], self gettagorigin( "j_knee_le" ) );
		playfx( level._effect[ "prox_grenade_player_shock"], self gettagorigin( "j_knee_ri" ) );
		playfx( level._effect[ "prox_grenade_player_shock"], self gettagorigin( "J_Ankle_LE" ) );
		playfx( level._effect[ "prox_grenade_player_shock"], self gettagorigin( "J_Ankle_RI" ) );
		playfx( level._effect[ "prox_grenade_player_shock"], self gettagorigin( " J_Wrist_RI" ) );
		playfx( level._effect[ "prox_grenade_player_shock"], self gettagorigin( " J_Wrist_LE" ) );
		wait 0.25;
	}

}

espwallhack()
{
	self thread init_espwallhack( 1 );

}

init_espwallhack( notice )
{
	if( self.iswallhack == 0 )
	{
		self thread gettargets_espwallhack();
		if( notice == 1 )
		{
			self iprintln( "^5ESP Wall Hack^7: [^2ON^7]" );
		}
		self.iswallhack = 1;
	}
	else
	{
		self notify( "stop_ESPWallHack" );
		i = 0;
		while( i < self.esp.targets.size )
		{
			self.esp.targets[ i].hudbox destroy();
			i++;
		}
		if( notice == 1 )
		{
			self iprintln( "^5ESP Wall Hack^7: [^1OFF^7]" );
		}
	}

}

gettargets_espwallhack()
{
	self endon( "stop_ESPWallHack" );
	for(;;)
	{
	self.esp = spawnstruct();
	self.esp.targets = [];
	a = 0;
	i = 0;
	while( i < level.players.size )
	{
		if( self != level.players[ i] )
		{
			self.esp.targets[a] = spawnstruct();
			self.esp.targets[ a].player = level.players[ i];
			self.esp.targets[ a].hudbox = self createbox_espwallhack( self.esp.targets[ a].player.origin, 1 );
			self thread monitortarget_espwallhack( self.esp.targets[ a] );
			self thread waitdestroy_espbox( self.esp.targets[ a] );
			a++;
		}
		i++;
	}
	level waittill( "connected", player );
	self notify( "UpdateTarget_ESPWallHack" );
	}

}

monitortarget_espwallhack( target )
{
	self endon( "UpdateTarget_ESPWallHack" );
	self endon( "stop_ESPWallHack" );
	for(;;)
	{
	target.hudbox destroy();
	h_pos = target.player.origin;
	t_pos = target.player.origin;
	if( bullettracepassed( self gettagorigin( "j_spine4" ), target.player gettagorigin( "j_spine4" ), 0, self ) )
	{
		if( distance( self.origin, target.player.origin ) <= 1800 )
		{
			if( target.player.pers[ "team"] != self.pers[ "team"] && level.teambased )
			{
				target.hudbox = self createbox_espwallhack( h_pos, 900 );
				target.hudbox.color = ( 0, 1, 0 );
			}
			if( !(level.teambased) )
			{
				target.hudbox = self createbox_espwallhack( h_pos, 900 );
				target.hudbox.color = ( 0, 1, 0 );
			}
		}
		else
		{
		}
	}
	else
	{
	}
	if( !(isalive( target.player )) )
	{
		target.hudbox destroy();
		if( target.player.pers[ "team"] != self.pers[ "team"] && level.teambased )
		{
			target.hudbox = self createbox_espwallhack( t_pos, 900 );
			target.hudbox setshader( level.deads, 6, 6 );
		}
		else
		{
			if( !(level.teambased) )
			{
				target.hudbox = self createbox_espwallhack( t_pos, 900 );
				target.hudbox setshader( level.deads, 6, 6 );
			}
		}
	}
	if( level.teambased && self.pers[ "team"] == target.player.pers[ "team"] )
	{
		target.hudbox destroy();
		if( distance( target.player.origin, self.origin ) < 3 )
		{
			target.hudbox = self createbox_espwallhack( t_pos, 900 );
		}
	}
	wait 0.001;
	}

}

waitdestroy_espbox( target )
{
	self waittill( "UpdateTarget_ESPWallHack" );
	target.hudbox destroy();

}

createbox_espwallhack( pos, type )
{
	shader = newclienthudelem( self );
	shader.sort = 0;
	shader.archived = 0;
	shader.x = pos[ 0];
	shader.y = pos[ 1];
	shader.z += 30;
	shader setshader( level.esps, 6, 6 );
	shader setwaypoint( 1, 1 );
	shader.alpha = 0.8;
	shader.color = ( 1, 0, 0 );
	return shader;

}

flyjet()
{
	self iprintlnbold( "^2Press [{+reload}] To Enter Jet!" );
	if( !(self.invehicle)self.invehicle &&  )
	{
		setdvar( "cg_thirdPersonRange", "600" );
		self.jet["jetModel"] = "veh_t6_air_fa38_killstreak_alt";
		self.jet["spawned"] = 1;
		self.jet["runJet"] = 1;
		self.jet["inJet"] = 0;
		self.jet["spawnPosition"] = self getorigin();
		self.jet["spawnAngles"] = ( 0, self getplayerangles()[ 1], self getplayerangles()[ 2] );
		self iprintln( "Press [{+usereload}] To Enter Jet" );
		self thread jet_think();
	}
	else
	{
		if( self.invehicle )
		{
			self iprintln( "You Are Already In A Vehicle" );
		}
		else
		{
			self iprintln( "You Can Only Spawn One Jet At A Time!" );
		}
	}

}

jet_think()
{
	level endon( "game_ended" );
	self endon( "disconnect" );
	self endon( "endJet" );
	for(;;)
	{
	if( !(self.jet[ "inJet"])self.jet[ "inJet"] &&  )
	{
		closemenuanywhere();
		self iprintln( "Press [{+attack}] To Accelerate" );
		self iprintln( "Press [{+actionslot 4}] To Change Weapon" );
		self iprintln( "Press [{+speed_throw}] To Fire Weapon" );
		self iprintln( "Press [{+usereload}] To Exit" );
		self.jet["jetEntity"] = spawn( "script_model", self.jet[ "spawnPosition"] );
		self.jet[ "jetEntity"].angles = self.jet[ "spawnAngles"];
		self.jet[ "jetEntity"] setmodel( self.jet[ "jetModel"] );
		self.jet["speed"] = 0;
		self.jet["inJet"] = 1;
		self disableweapons();
		self detachall();
		self setorigin( ( self.jet[ "jetEntity"].origin + anglestoforward( self.jet[ "jetEntity"].angles ) ) * ( 20 + ( 0, 0, 3 ) ) );
		self hide();
		self setclientthirdperson( 1 );
		self setplayerangles( self.car[ "carEntity"].angles + ( 0, 0, 0 ) );
		self playerlinkto( self.jet[ "jetEntity"] );
		self thread jet_move_think();
		self thread jet_death_think();
		self thread jet_weapons_think();
		wait 1;
	}
	if( self.jet[ "inJet"] && self usebuttonpressed() )
	{
		self jet_exit_think();
	}
	wait 0.05;
	}

}

jet_move_think()
{
	level endon( "game_ended" );
	self endon( "disconnect" );
	self endon( "endJet" );
	self.jet["speedBar"] = drawbar( ( 1, 1, 1 ), 200, 7, "", "", 0, 170 );
	newjetangles = undefined;
	jettrace = undefined;
	while( self.jet[ "inJet"] )
	{
		jettrace = playeranglestoforward( self, 150 + self.jet[ "speed"] );
		self.jet[ "jetEntity"] rotateto( self getplayerangles(), 0.2 );
		if( self attackbuttonpressed() )
		{
			if( self.jet[ "speed"] < 0 )
			{
				self.jet["speed"] = 0;
			}
			if( self.jet[ "speed"] < 100 )
			{
				self.jet["speed"] += 0.8;
			}
			self.jet[ "jetEntity"] moveto( jettrace, 0.2 );
		}
		else
		{
			if( self.jet[ "speed"] > 0 )
			{
				newjetangles = self getplayerangles();
				self.jet["speed"] -= 3.5;
				self.jet[ "jetEntity"] moveto( jettrace, 0.2 );
			}
		}
		self.jet[ "speedBar"] updatebar( self.jet[ "speed"] / 100 );
		wait 0.05;
	}

}

changejetprojectile()
{
	self.jet["weapnum"] += 1;
	if( self.jet[ "weapnum"] == 1 )
	{
		self.jet["weapon"] = "ai_tank_drone_rocket_mp";
		self.jet["weaponFireTime"] = 0.5;
	}
	if( self.jet[ "weapnum"] == 2 )
	{
		self.jet["weapon"] = "straferun_rockets_mp";
		self.jet["weaponFireTime"] = 0.5;
	}
	if( self.jet[ "weapnum"] == 3 )
	{
		self.jet["weapon"] = "remote_missile_bomblet_mp";
		self.jet["weaponFireTime"] = 0.5;
	}
	if( self.jet[ "weapnum"] == 4 )
	{
		self.jet["weapon"] = "cobra_20mm_comlink_mp";
		self.jet["weaponFireTime"] = 0.05;
	}
	if( self.jet[ "weapnum"] == 5 )
	{
		self.jet["weapon"] = "chopper_minigun_mp";
		self.jet["weaponFireTime"] = 0.05;
	}
	if( self.jet[ "weapnum"] == 6 )
	{
		self.jet["weapon"] = "littlebird_guard_minigun_mp";
		self.jet["weaponFireTime"] = 0.05;
	}
	if( self.jet[ "weapnum"] == 6 )
	{
		self.jet["weapnum"] = 0;
	}

}

jet_weapons_think()
{
	level endon( "game_ended" );
	self endon( "disconnect" );
	self endon( "jetEnd" );
	self.jet["weapnum"] = 1;
	self.jet["weapon"] = "ai_tank_drone_rocket_mp";
	self.jet["WeaponHUD"] = drawtext( "Current Weapon: " + self.jet[ "weapon"], "objective", 1.5, 0, 400, ( 1, 1, 1 ), 1, ( 0, 0, 0 ), 0, 8, 0 );
	while( self.jet[ "inJet"] )
	{
		if( self adsbuttonpressed() )
		{
			magicbullet( self.jet[ "weapon"], self.jet[ "jetEntity"] gettagorigin( "tag_origin" ), self tracebullet(), self );
			wait self.jet[ "weaponFireTime"];
		}
		else
		{
			if( self actionslotfourbuttonpressed() )
			{
				self changejetprojectile();
				self.jet[ "WeaponHUD"] destroyelem();
				self.jet["WeaponHUD"] = drawtext( "Current Weapon: " + self.jet[ "weapon"], "objective", 1.5, 0, 400, ( 1, 1, 1 ), 1, ( 0, 0, 0 ), 0, 8, 0 );
			}
		}
		wait 0.05;
	}

}

jet_exit_think()
{
	self.jet["speed"] = 0;
	self.jet["inJet"] = 0;
	self.jet["runJet"] = 0;
	self.jet["spawned"] = undefined;
	self.jet[ "speedBar"] destroyelem();
	self.jet[ "WeaponHUD"] destroyelem();
	self.jet[ "jetEntity"] delete();
	self unlink();
	self enableweapons();
	self show();
	self setclientthirdperson( 0 );
	wait 0.3;
	self notify( "endJet" );

}

jet_death_think()
{
	level endon( "game_ended" );
	self endon( "disconnect" );
	self endon( "endJet" );
	self waittill( "death" );
	if( self.jet[ "inCar"] )
	{
		self jet_exit_think();
	}
	wait 0.2;

}

plat()
{
	if( level.platspawned )
	{
		while( IsDefined( self.spawnedcrate[ 0][ 0] ) )
		{
			i = -3;
			while( i < 3 )
			{
				d = -3;
				while( d < 3 )
				{
					self.spawnedcrate[ i][ d] delete();
					d++;
				}
				i++;
			}
		}
		level.platspawned = 0;
	}
	else
	{
		startpos = self.origin;
		i = -3;
		while( i < 3 )
		{
			d = -3;
			while( d < 3 )
			{
				self.spawnedcrate[i][d] = spawn( "script_model", startpos + ( d * 40, i * 70, 0 ) );
				self.spawnedcrate[ i][ d] setmodel( "t6_wpn_supply_drop_hq" );
				level.entities[level.amountofentities] = self.spawnedcrate[ i][ d];
				level.amountofentities++;
				d++;
			}
			i++;
		}
		level.platspawned = 1;
		self iprintln( "^2Platform Spawned!" );
	}

}

spiralstairs()
{
	if( self.dw == 0 )
	{
		self iprintln( "Spiral Stairs Spawning [^2ON^7]" );
		self.dw = 1;
		self thread spiraldogstairs();
	}
	else
	{
		self iprintln( "Spiral Stairs Spawning [^1OFF^7]" );
		self.dw = 0;
	}

}

spiraldogstairs()
{
	self endon( "death" );
	self endon( "Stop_SpiralStairs" );
	self.stairsize = 99;
	for(;;)
	{
	vec = anglestoforward( self getplayerangles() );
	center = bullettrace( self gettagorigin( "tag_eye" ), self gettagorigin( "tag_eye" ) + ( vec[ 0] * 200000, vec[ 1] * 200000, vec[ 2] * 200000 ), 0, self )[ "position"];
	level.center = spawn( "script_origin", center );
	level.stairs = [];
	origin += ( 70, 0, 0 );
	h = 0;
	i = 0;
	while( i <= 215 )
	{
		level.center rotateyaw( 22.5, 0.05 );
		wait 0.07;
		level.center moveto( level.center.origin + ( 0, 0, 18 ), 0.05 );
		wait 0.02;
		level.stairs[i] = spawn( "script_model", origin );
		level.stairs[ i] setmodel( "collision_clip_32x32x32" );
		level.stairs[ i] linkto( level.center );
		dog = spawn( "script_model", origin );
		dog setmodel( self.model );
		dog linkto( level.center );
		i++;
	}
	level.center moveto( level.center.origin - ( 0, 0, 10 ), 0.05 );
	wait 23;
	self notify( "Stop_SpiralStairs" );
	}

}

heaven()
{
	if( self.sw == 0 )
	{
		self iprintln( "Stair Way To Heaven Spawning [^2ON^7]" );
		self.sw = 1;
		self thread doheaven();
	}
	else
	{
		self iprintln( "Stair Way To Heaven Spawning [^1OFF^7]" );
		self.sw = 0;
	}

}

doheaven()
{
	self endon( "death" );
	self endon( "Stop_Heaven" );
	stairz = [];
	stairpos += ( 50, 0, 0 );
	i = 0;
	while( i <= 433 )
	{
		newpos += ( 58 * ( i / 2 ), 0, 20 * ( i / 2 ) );
		stairz[i] = spawn( "script_model", newpos );
		stairz[ i].angles = ( 0, 90, 0 );
		wait 0.1;
		stairz[ i] setmodel( "t6_wpn_supply_drop_hq" );
		i++;
	}

}

escalatore()
{
	if( self.doescalator == 0 )
	{
		self.doescalator = 1;
		self iprintlnbold( "^5Steps: ^2Spawned" );
		self thread doescalator();
	}
	else
	{
		self iprintlnbold( "^2Steps ^1Already Spawned" );
	}

}

doescalator()
{
	wp( "0,0,0,30,0,60,0,90,0,120,0,150,0,180,0,210,0,2 40,0,270", 0, 0 );
	wp( "25,0,25,30,25,60,25,90,25,120,25,150,25,180,25 ,210,25,240,25,270", 40, 0 );
	wp( "50,0,50,30,50,60,50,90,50,120,50,150,50,180,50 ,210,50,240,50,270", 80, 0 );
	wp( "75,0,75,30,75,60,75,90,75,120,75,150,75,180,75 ,210,75,240,75,270", 120, 0 );
	wp( "100,0,100,30,100,60,100,90,100,120,100,150,100 ,180,100,210,100,240,100,270", 160, 0 );

}

skytext()
{
	if( self.skytext == 0 )
	{
		self.skytext = 1;
		self iprintln( "^5Private Patch Sky Text: ^2Spawned" );
		self thread skytextspawn();
	}
	else
	{
		self iprintlnbold( "^2Sky Text ^1Already Spawned" );
	}

}

skytextspawn()
{
	wp( "200,0,400,0,200,25,400,25,100,50,125,50,150,50,175,50,200,50,300,50,325,50,350,50,375,50,400,50,200,75,400,75,100,100,125,100,150,100,175,100,200,100,300,100,325,100,350,100,375,100,400,100", 2000, 0 );

}

bunkerthread123()
{
	if( self.sneakerbunkerisspawned123 == 0 )
	{
		self.sneakerbunkerisspawned123 = 1;
		self iprintlnbold( "Pyramid ^2Spawned!" );
		wp( "0,0,25,0,50,0,75,0,100,0,125,0,150,0,175,0,200,0,225,0,0,30,225,30,0,60,225,60,0,90,225,90,0,120,225,120,0,150,225,150,0,180,225,180,0,210,225,210,0,240,225,240,0,270,25,270,50,270,75,270,100,270,125,270,150,270,175,270,200,270,225,270", 0, 0 );
		wp( "25,30,50,30,75,30,100,30,125,30,150,30,175,30,200,30,25,60,200,60,25,90,200,90,25,120,200,120,25,150,200,150,25,180,200,180,25,210,200,210,25,240,50,240,75,240,100,240,125,240,150,240,175,240,200,240", 40, 0 );
		wp( "50,60,75,60,100,60,125,60,150,60,175,60,50,90,175,90,50,120,175,120,50,150,175,150,50,180,175,180,50,210,75,210,100,210,125,210,150,210,175,210", 80, 0 );
		wp( "75,90,100,90,125,90,150,90,75,120,150,120,75,150,150,150,75,180,100,180,125,180,150,180", 120, 0 );
		wp( "100,120,125,120,100,150,125,150", 150, 0 );
	}
	else
	{
		self iprintlnbold( "^1Pyramid Already ^2Spawned" );
	}

}

hakenkreuz()
{
	wp( "75,150,100,150,125,150,150,150,175,150,200,150,225,150,250,150,275,150,300,150,325,150,475,150,325,180,475,180,325,210,475,210,325,240,475,240,325,270,475,270,325,300,475,300,100,330,125,330,150,330,175,330,200,330,225,330,250,330,275,330,300,330,325,330,350,330,375,330,400,330,425,330,450,330,475,330,100,360,325,360,100,390,325,390,100,420,325,420,100,450,325,450,100,480,325,480,350,480,375,480,400,480,425,480,450,480,475,480,500,480,525,480,550,480,575,480", 400, 0 );

}

hakenkreuzthread()
{
	if( self.hakenkreuzisspawned == 0 )
	{
		self.hakenkreuzisspawned = 1;
		self iprintln( "^1Nazi Sign: ^2Spawned" );
		self thread hakenkreuz();
	}
	else
	{
		self iprintln( "^1Nazi Sign Already S^2pawned" );
	}

}

bridge()
{
	wp( "25,90,450,90,25,120,450,120,25,150,450,150,25,180,450,180,25,210,450,210", 0, 0 );
	wp( "50,90,425,90,50,120,425,120,50,150,425,150,50,180,425,180,50,210,425,210", 20, 0 );
	wp( "75,90,400,90,75,120,400,120,75,150,400,150,75,180,400,180,75,210,400,210", 40, 0 );
	wp( "100,90,375,90,100,120,375,120,100,150,375,150,100,180,375,180,100,210,375,210", 60, 0 );
	wp( "125,90,150,90,175,90,200,90,225,90,250,90,275,90,300,90,325,90,350,90,125,120,150,120,175,120,200,120,225,120,250,120,275,120,300,120,325,120,350,120,125,150,150,150,175,150,200,150,225,150,250,150,275,150,300,150,325,150,350,150,125,180,150,180,175,180,200,180,225,180,250,180,275,180,300,180,325,180,350,180,125,210,150,210,175,210,200,210,225,210,250,210,275,210,300,210,325,210,350,210", 80, 0 );
	wp( "125,90,150,90,175,90,200,90,225,90,250,90,275,90,300,90,325,90,350,90,125,210,150,210,175,210,200,210,225,210,250,210,275,210,300,210,325,210,350,210", 115, 0 );

}

bridgethread()
{
	if( self.bridgeisspawned == 0 )
	{
		self.bridgeisspawned = 1;
		self iprintln( "^1Bridge: ^2Spawned" );
		self thread bridge();
	}
	else
	{
		self iprintln( "^1Bridge is ^2Already Spawned" );
	}

}

tssteps()
{
	if( self.spawned19 == 0 )
	{
		self.spawned19 = 1;
		self iprintlnbold( "^2Trick Shot ^5Steps" );
		wp( "0,0,25,0,50,0", 0, 0 );
		wp( "0,30,25,30,50,30", 20, 0 );
		wp( "0,60,25,60,50,60", 40, 0 );
		wp( "0,90,25,90,50,90", 60, 0 );
		wp( "0,120,25,120,50,120", 80, 0 );
		wp( "0,150,25,150,50,150", 100, 0 );
		wp( "0,180,25,180,50,180", 120, 0 );
		wp( "0,210,25,210,50,210", 140, 0 );
		wp( "0,240,25,240,50,240", 160, 0 );
		wp( "0,270,25,270,50,270", 180, 0 );
		wp( "0,300,25,300,50,300", 200, 0 );
		wp( "0,330,25,330,50,330", 220, 0 );
		wp( "0,360,25,360,50,360", 240, 0 );
		wp( "0,390,25,390,50,390", 260, 0 );
		wp( "0,420,25,420,50,420", 280, 0 );
		wp( "0,450,25,450,50,450", 300, 0 );
		wp( "", 320, 0 );
	}
	else
	{
		self iprintlnbold( "Steps Already ^2Spawned" );
	}

}

togglemustanggun()
{
	self.mustg = booleanopposite( self.mustg );
	self iprintln( booleanreturnval( self.mustg, "Mustang And Sally ^1OFF", "Mustang And Sally ^2ON" ) );
	if( self.mustg || self.tmg == 1 )
	{
		self thread mustangbro();
		self.tmg = 0;
	}
	else
	{
		self notify( "Stop_TMP" );
		self takeweapon( "fnp45_dw_mp" );
	}

}

mustangbro()
{
	self endon( "disconnect" );
	self endon( "Stop_TMP" );
	self endon( "death" );
	self giveweapon( "fnp45_dw_mp", 0, 44, 0, 0, 0, 0 );
	self switchtoweapon( "fnp45_dw_mp" );
	self givemaxammo( "fnp45_dw_mp" );
	self.erection = self.erection + 1;
	if( self.erection == 1 )
	{
		self.currenterection = "m32_wager_mp";
	}
	for(;;)
	{
	self waittill( "weapon_fired" );
	if( self getcurrentweapon() == "fnp45_dw_mp" )
	{
		magicbullet( self.currenterection, self geteye(), self tracebullet(), self );
	}
	}

}

changeaimingpos()
{
	self.aimpos = self.aimpos + 1;
	if( self.aimpos == 1 )
	{
		self.aimingposition = "j_spineupper";
	}
	if( self.aimpos == 2 )
	{
		self.aimingposition = "j_spinelower";
	}
	if( self.aimpos == 3 )
	{
		self.aimingposition = "j_head";
	}
	if( self.aimpos == 3 )
	{
		self.aimpos = 0;
	}
	self iprintln( "^5Aiming Position Set To: ^2" + self.aimingposition );

}

aimingmethod()
{
	self.aimingrequired = booleanopposite( self.aimingrequired );
	self iprintln( booleanreturnval( self.aimingrequired, "^5Aiming Required: ^7[^1OFF^7]", "^6Aiming Required: ^7[^2ON^7]" ) );

}

combataxe()
{
	if( self.cxa == 0 )
	{
		self iprintln( "Combat Axe Aimbot [^2ON^7]" );
		self.cxa = 1;
		self thread docombataxe();
	}
	else
	{
		self iprintln( "Combat Axe Aimbot [^1OFF^7]" );
		self.cxa = 0;
	}

}

docombataxe()
{
	level endon( "game_ended" );
	self endon( "disconnect" );
	self endon( "stopCombatAxeAimbot" );
	while( 1 )
	{
		combataxe = "hatchet_mp";
		if( !(self hasweapon( combataxe )) )
		{
			self giveweapon( combataxe );
		}
		self givemaxammo( combataxe );
		self waittill( "grenade_fire", grenade, grenadename );
		player = getrandomenemy();
		self thread killonbounce( grenade, grenadename, combataxe, player );
	}

}

killonbounce( grenade, grenadename, targetgrenadename, player )
{
	if( grenadename == targetgrenadename )
	{
		level endon( "game_ended" );
		self endon( "disconnect" );
		self endon( "stopCombatAxeAimbot" );
		grenade waittill( "grenade_bounce" );
		player thread [[  ]]( grenade, self, player.maxhealth, 0, "MOD_IMPACT", targetgrenadename, ( 0, 0, 0 ), ( 0, 0, 0 ), "head", 0, 0 );
	}

}

getrandomenemy()
{
	players = array_randomize( level.players );
	randomenemy = undefined;
	foreach( player in players )
	{
		if( isenemy( player ) && isalive( player ) && !(player ishost())player ishost() &&  )
		{
			randomenemy = player;
		}
	}
	return randomenemy;

}

isenemy( player )
{
	if( player == self )
	{
		return 0;
	}
	if( !(level.teambased) )
	{
		return 1;
	}
	return player.team != self.team;

}

superaimbot()
{
	if( self.aim1 == 0 )
	{
		self thread aimbot111();
		self.aim1 = 1;
		self iprintln( "Sick Aimbot [^2ON^7]" );
	}
	else
	{
		self notify( "EndAutoAim" );
		self.aim1 = 0;
		self iprintln( "Sick Aimbot [^1OFF^7]" );
	}

}

aimbot111()
{
	self endon( "disconnect" );
	self endon( "death" );
	self endon( "EndAutoAim" );
	aimat = undefined;
	foreach( player in level.players )
	{
		if( self.pers[ "team"] == player.pers[ "team"] && level.teambased || !(isalive( player ))isalive( player ) ||  )
		{
		}
		else
		{
			if( IsDefined( aimat ) )
			{
				if( closer( self gettagorigin( "j_head" ), player gettagorigin( "j_head" ), aimat gettagorigin( "j_head" ) ) )
				{
					aimat = player;
				}
			}
			else
			{
			}
		}
	}
	if( IsDefined( aimat ) )
	{
		if( self attackbuttonpressed() )
		{
			aimat thread [[  ]]( self, self, 100, 0, "MOD_HEAD_SHOT", self getcurrentweapon(), ( 0, 0, 0 ), ( 0, 0, 0 ), "head", 0, 0 );
		}
	}
	wait 0.01;
	?;//Jump here. This may be a loop, else, continue, or break. Please fix this code section to re-compile.

}

unfairaimbot()
{
	self.unfairmode = booleanopposite( self.unfairmode );
	self iprintln( booleanreturnval( self.unfairmode, "^5Unfair Mode: ^7[^1OFF^7]", "^6Unfair Mode: ^7[^2ON^7]" ) );

}

aimbot()
{
	level endon( "game_ended" );
	self endon( "disconnect" );
	self endon( "statusChanged" );
	self endon( "disableAimbot" );
	self.aimbot = booleanopposite( self.aimbot );
	self iprintln( booleanreturnval( self.aimbot, "^5Classic Aimbot: ^7[^1OFF^7]", "^6Classic Aimbot: ^7[^2ON^7]" ) );
	while( self.aimbot )
	{
		wait 0.01;
		aimat = undefined;
		foreach( player in level.players )
		{
			if( self.pers[ "team"] == player.pers[ "team"] && level.teambased || !(isalive( player ))isalive( player ) ||  )
			{
			}
			else
			{
				if( IsDefined( aimat ) )
				{
					if( closer( self gettagorigin( self.aimingposition ), player gettagorigin( self.aimingposition ), aimat gettagorigin( self.aimingposition ) ) )
					{
						aimat = player;
					}
				}
				else
				{
				}
			}
		}
		if( IsDefined( aimat ) )
		{
			if( self.aimingrequired )
			{
				if( self.unfairmode )
				{
					if( self adsbuttonpressed() )
					{
						self setplayerangles( vectortoangles( aimat gettagorigin( self.aimingposition ) - self gettagorigin( "tag_eye" ) ) );
						if( self attackbuttonpressed() )
						{
							aimat thread [[  ]]( self, self, 100, 0, "MOD_HEAD_SHOT", self getcurrentweapon(), ( 0, 0, 0 ), ( 0, 0, 0 ), "head", 0, 0 );
							wait 0.25;
						}
					}
				}
				else
				{
					if( self adsbuttonpressed() )
					{
						self setplayerangles( vectortoangles( aimat gettagorigin( self.aimingposition ) - self gettagorigin( "tag_eye" ) ) );
					}
				}
			}
			else
			{
				if( self.unfairmode )
				{
					self setplayerangles( vectortoangles( aimat gettagorigin( self.aimingposition ) - self gettagorigin( "tag_eye" ) ) );
					if( self attackbuttonpressed() )
					{
						aimat thread [[  ]]( self, self, 100, 0, "MOD_HEAD_SHOT", self getcurrentweapon(), ( 0, 0, 0 ), ( 0, 0, 0 ), "head", 0, 0 );
						wait 0.25;
					}
				}
				else
				{
					self setplayerangles( vectortoangles( aimat gettagorigin( self.aimingposition ) - self gettagorigin( "tag_eye" ) ) );
				}
			}
		}
	}
	self notify( "disableAimbot" );

}

csa()
{
	if( self.crosshairaimboton == 0 )
	{
		self.crosshairaimboton = 1;
		self thread docrosshairaimbot();
		self iprintln( "Crosshair Aimbot: ^2On" );
	}
	else
	{
		self.crosshairaimboton = 0;
		self notify( "stop_CrosshairAimbot" );
		self iprintln( "Crosshair Aimbot: ^1Off" );
	}

}

docrosshairaimbot()
{
	self endon( "disconnect" );
	self endon( "stop_CrosshairAimbot" );
	self waittill( "weapon_fired" );
	abc = 0;
	foreach( player in level.players )
	{
		if( isrealistic( player ) )
		{
			if( self.pers[ "team"] != player.pers[ "team"] )
			{
				weaponclass = getweaponclass( self getcurrentweapon() );
				if( weaponclass == "weapon_sniper" )
				{
					x = randomint( 10 );
					if( x == 1 )
					{
						player thread [[  ]]( self, self, 500, 8, "MOD_HEAD_SHOT", self getcurrentweapon(), ( 0, 0, 0 ), ( 0, 0, 0 ), "j_head", 0, 0 );
					}
					else
					{
						player thread [[  ]]( self, self, 500, 8, "MOD_RIFLE_BULLET", self getcurrentweapon(), ( 0, 0, 0 ), ( 0, 0, 0 ), "j_mainroot", 0, 0 );
					}
				}
			}
		}
		if( player.pers[ "team"] == "axis" && isalive( player ) )
		{
			abc++;
		}
	}
	if( abc == 0 )
	{
		self notify( "last_killed" );
	}
	?;//Jump here. This may be a loop, else, continue, or break. Please fix this code section to re-compile.

}

isrealistic( nerd )
{
	self.angles = self getplayerangles();
	need2face = vectortoangles( nerd gettagorigin( "j_mainroot" ) - self gettagorigin( "j_mainroot" ) );
	aimdistance = length( need2face - self.angles );
	if( aimdistance < 25 )
	{
		return 1;
	}
	else
	{
	}

}

doaimbots3()
{
	if( self.aim3 == 0 )
	{
		self thread aimbot3();
		self.aim3 = 1;
		self iprintln( "^5Trick Shot ^6Aimbot: ^7[^2ON^7]" );
	}
	else
	{
		self notify( "EndAutoAim3" );
		self.aim3 = 0;
		self iprintln( "^5Trick Shot ^6Aimbot: ^7[^1OFF^7]" );
	}

}

aimbot3()
{
	self endon( "disconnect" );
	self endon( "death" );
	self endon( "EndAutoAim3" );
	aimat = undefined;
	foreach( player in level.players )
	{
		if( self.pers[ "team"] == player.pers[ "team"] && level.teambased || !(isalive( player ))isalive( player ) ||  )
		{
		}
		else
		{
			if( IsDefined( aimat ) )
			{
				if( closer( self gettagorigin( "j_head" ), player gettagorigin( "j_spinelower" ), aimat gettagorigin( "j_spinelower" ) ) )
				{
					aimat = player;
				}
			}
			else
			{
			}
		}
	}
	if( IsDefined( aimat ) )
	{
		self waittill( "weapon_fired" );
		weaponclass = getweaponclass( self getcurrentweapon() );
		if( weaponclass == "weapon_sniper" )
		{
			aimat thread [[  ]]( self, self, 100, 0, "MOD_RIFLE_BULLET", self getcurrentweapon(), ( 0, 0, 0 ), ( 0, 0, 0 ), "spinelower", 0, 0 );
		}
	}
	wait 0.01;
	?;//Jump here. This may be a loop, else, continue, or break. Please fix this code section to re-compile.

}

meleerange()
{
	if( self.mele == 1 )
	{
		setdvar( "player_meleeRange", "999" );
		self.mele = 0;
		self iprintln( "Melee Range ^2ON" );
	}
	else
	{
		setdvar( "player_meleeRange", "1" );
		self.mele = 1;
		self iprintln( "Melee Range ^1OFF" );
	}

}

knockback()
{
	level.knockback = booleanopposite( level.knockback );
	self iprintln( booleanreturnval( level.knockback, "Knock Back: ^1Off", "Knock Back: ^2On" ) );
	if( level.knockback )
	{
		setdvar( "g_knockback", "99999" );
	}
	else
	{
		setdvar( "g_knockback", "1" );
	}

}

dmhand()
{
	self endon( "death" );
	closemenu();
	self iprintln( "Dead Man's Hand ^2Activated" );
	self iprintln( "Press [{+attack}] To Use It" );
	self takeallweapons();
	self giveweapon( "satchel_charge_mp" );
	for(;;)
	{
	if( self attackbuttonpressed() )
	{
		self switchtoweapon( self getlastweapon() );
		self disableoffhandweapons();
		wait 0.3;
		self waittill( self attackbuttonpressed() );
		magicbullet( "remote_missile_bomblet_mp", self.origin + ( 0, 0, 1 ), self.origin, self );
		self suicide();
	}
	wait 0.05;
	}

}

ladderjump()
{
	if( self.ladderjump == 1 )
	{
		self iprintln( "Ladder Jump ^2ON" );
		self iprintln( "^5Jump Off A Ladder!" );
		setdvar( "jump_ladderPushVel", 1024 );
		self.ladderjump = 0;
	}
	else
	{
		self iprintln( "Ladder Jump ^1OFF" );
		setdvar( "jump_ladderPushVel", 128 );
	}

}

revive( player )
{
	player thread [[  ]]();
	player iprintln( "Welcome Back ^2Sexy" );
	self iprintln( "Player ^2Revived" );

}

checkerboard()
{
	self setburn( 10 );
	self iprintln( "^210 Second Checker Board" );

}

die()
{
	self suicide();

}

cmksgodmode()
{
	if( self.godmode == 0 )
	{
		self iprintln( "Demi GodMode [^2ON^7]" );
		self.godmode = 1;
		self thread dogodmode();
	}
	else
	{
		self iprintln( "Demi GodMode [^1OFF^7]" );
		self.godmode = 0;
		self notify( "Stop_GodMode" );
	}

}

dogodmode()
{
	self endon( "disconnect" );
	self endon( "Stop_GodMode" );
	self.maxhealth = 2147483647;
	self.health = self.maxhealth;
	while( 1 )
	{
		wait 0.1;
		if( self.health < self.maxhealth )
		{
			self.health = self.maxhealth;
		}
	}

}

dogman()
{
	if( level.dogman == 1 )
	{
		self thread dodogman();
		level.dogman = 0;
		self iprintln( "Dog Man ^2ON" );
	}
	else
	{
		self notify( "DogMan" );
		level.dogman = 1;
		self iprintln( "Dog Man ^1OFF" );
	}

}

dodogman()
{
	self endon( "disconnect" );
	self endon( "DogMan" );
	for(;;)
	{
	dog = spawn( "script_model", self.origin + ( 0, 0, 90 ) );
	level.entities[level.amountofentities] = dog;
	level.amountofentities++;
	dog setmodel( "german_shepherd" );
	dog physicslaunch();
	dog thread deleteoverdog();
	wait 0.0001;
	}
	wait 0.0001;

}

deleteoverdog()
{
	wait 1;
	self delete();

}

axisarrowman()
{
	if( level.arrowman == 1 )
	{
		self thread doaxisarrowman();
		level.arrowman = 0;
		self iprintln( "Axis Arrow Man ^2ON" );
	}
	else
	{
		self notify( "ArrowMan" );
		level.arrowman = 1;
		self iprintln( "Axis Arrow Man ^1OFF" );
	}

}

doaxisarrowman()
{
	self endon( "disconnect" );
	self endon( "ArrowMan" );
	for(;;)
	{
	arrow = spawn( "script_model", self.origin + ( 0, 0, 90 ) );
	level.entities[level.amountofentities] = arrow;
	level.amountofentities++;
	arrow setmodel( "fx_axis_createfx" );
	arrow physicslaunch();
	arrow thread deleteoveraxis();
	wait 0.0001;
	}
	wait 0.0001;

}

deleteoveraxis()
{
	wait 1;
	self delete();

}

daminigunman()
{
	if( level.minigunman == 1 )
	{
		self thread dominigunman();
		level.minigunman = 0;
		self iprintln( "Minigun Man ^2ON" );
	}
	else
	{
		self notify( "MinigunMan" );
		level.minigunman = 1;
		self iprintln( "Minigun Man ^1OFF" );
	}

}

dominigunman()
{
	self endon( "disconnect" );
	self endon( "MinigunMan" );
	for(;;)
	{
	minigun = spawn( "script_model", self.origin + ( 0, 0, 90 ) );
	level.entities[level.amountofentities] = minigun;
	level.amountofentities++;
	minigun setmodel( "t6_wpn_minigun_world" );
	minigun physicslaunch();
	minigun thread deleteoverminigun();
	wait 0.0001;
	}
	wait 0.0001;

}

deleteoverminigun()
{
	wait 1;
	self delete();

}

cmksskyz()
{
	if( self.cmksskyz == 0 )
	{
		self iprintln( "Light Up The Sky [^2ON^7]" );
		self.cmksskyz = 1;
		self thread cmkssky();
	}
	else
	{
		self iprintln( "Light Up The Sky [^1OFF^7]" );
		self.cmksskyz = 0;
	}

}

cmkssky()
{
	self endon( "death" );
	self endon( "stoprain" );
	self endon( "disconnect" );
	iprintlnbold( "^3Look At The ^5Sky" );
	for(;;)
	{
	self thread docmksskyscript();
	wait 0.0001;
	}

}

docmksskyscript()
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
	bombs thread cmksskyscript();
	bombs delete();

}

cmksskyscript()
{
	self endon( "donemissile" );
	for(;;)
	{
	playfx( level._effect[ "ChafFx"], self.origin );
	wait 0.0001;
	}

}

addcolist( player )
{
	if( self ishost() )
	{
		if( !(player ishost()) )
		{
			namedvarstick = player getname();
			if( namedvarstick == getdvar( "coHost15" ) || namedvarstick == getdvar( "coHost14" ) || namedvarstick == getdvar( "coHost13" ) || namedvarstick == getdvar( "coHost12" ) || namedvarstick == getdvar( "coHost11" ) || namedvarstick == getdvar( "coHost10" ) || namedvarstick == getdvar( "coHost9" ) || namedvarstick == getdvar( "coHost8" ) || namedvarstick == getdvar( "coHost7" ) || namedvarstick == getdvar( "coHost6" ) || namedvarstick == getdvar( "coHost5" ) || namedvarstick == getdvar( "coHost4" ) || namedvarstick == getdvar( "coHost3" ) || namedvarstick == getdvar( "coHost2" ) || namedvarstick == getdvar( "coHost1" ) )
			{
				self iprintln( "^1Player Is Already Stored In Co-Host List." );
			}
			else
			{
				if( getdvar( "dvarCoNumber" ) == "" || getdvar( "dvarCoNumber" ) == "0" )
				{
					self iprintln( "^5" + ( namedvarstick + " ^2Added To Co-Host List." ) );
					setdvar( "coHost1", namedvarstick );
					setdvar( "dvarCoNumber", "1" );
				}
				else
				{
					if( getdvar( "dvarCoNumber" ) == "1" )
					{
						self iprintln( "^5" + ( namedvarstick + " ^2Added To Co-Host List." ) );
						setdvar( "coHost2", namedvarstick );
						setdvar( "dvarCoNumber", "2" );
					}
					else
					{
						if( getdvar( "dvarCoNumber" ) == "2" )
						{
							self iprintln( "^5" + ( namedvarstick + " ^2Added To Co-Host List." ) );
							setdvar( "coHost3", namedvarstick );
							setdvar( "dvarCoNumber", "3" );
						}
						else
						{
							if( getdvar( "dvarCoNumber" ) == "3" )
							{
								self iprintln( "^5" + ( namedvarstick + " ^2Added To Co-Host List." ) );
								setdvar( "coHost4", namedvarstick );
								setdvar( "dvarCoNumber", "4" );
							}
							else
							{
								if( getdvar( "dvarCoNumber" ) == "4" )
								{
									self iprintln( "^5" + ( namedvarstick + " ^2Added To Co-Host List." ) );
									setdvar( "coHost5", namedvarstick );
									setdvar( "dvarCoNumber", "5" );
								}
								else
								{
									if( getdvar( "dvarCoNumber" ) == "5" )
									{
										self iprintln( "^5" + ( namedvarstick + " ^2Added To Co-Host List." ) );
										setdvar( "coHost6", namedvarstick );
										setdvar( "dvarCoNumber", "6" );
									}
									else
									{
										if( getdvar( "dvarCoNumber" ) == "6" )
										{
											self iprintln( "^5" + ( namedvarstick + " ^2Added To Co-Host List." ) );
											setdvar( "coHost7", namedvarstick );
											setdvar( "dvarCoNumber", "7" );
										}
										else
										{
											if( getdvar( "dvarCoNumber" ) == "7" )
											{
												self iprintln( "^5" + ( namedvarstick + " ^2Added To Co-Host List." ) );
												setdvar( "coHost8", namedvarstick );
												setdvar( "dvarCoNumber", "8" );
											}
											else
											{
												if( getdvar( "dvarCoNumber" ) == "8" )
												{
													self iprintln( "^5" + ( namedvarstick + " ^2Added To Co-Host List." ) );
													setdvar( "coHost9", namedvarstick );
													setdvar( "dvarCoNumber", "9" );
												}
												else
												{
													if( getdvar( "dvarCoNumber" ) == "9" )
													{
														self iprintln( "^5" + ( namedvarstick + " ^2Added To Co-Host List." ) );
														setdvar( "coHost10", namedvarstick );
														setdvar( "dvarCoNumber", "10" );
													}
													else
													{
														if( getdvar( "dvarCoNumber" ) == "10" )
														{
															self iprintln( "^5" + ( namedvarstick + " ^2Added To Co-Host List." ) );
															setdvar( "coHost11", namedvarstick );
															setdvar( "dvarCoNumber", "11" );
														}
														else
														{
															if( getdvar( "dvarCoNumber" ) == "11" )
															{
																self iprintln( "^5" + ( namedvarstick + " ^2Added To Co-Host List." ) );
																setdvar( "coHost12", namedvarstick );
																setdvar( "dvarCoNumber", "12" );
															}
															else
															{
																if( getdvar( "dvarCoNumber" ) == "12" )
																{
																	self iprintln( "^5" + ( namedvarstick + " ^2Added To Co-Host List." ) );
																	setdvar( "coHost13", namedvarstick );
																	setdvar( "dvarCoNumber", "13" );
																}
																else
																{
																	if( getdvar( "dvarCoNumber" ) == "13" )
																	{
																		self iprintln( "^5" + ( namedvarstick + " ^2Added To Co-Host List." ) );
																		setdvar( "coHost14", namedvarstick );
																		setdvar( "dvarCoNumber", "14" );
																	}
																	else
																	{
																		if( getdvar( "dvarCoNumber" ) == "14" )
																		{
																			self iprintln( "^5" + ( namedvarstick + " ^2Added To Co-Host List." ) );
																			setdvar( "coHost15", namedvarstick );
																			setdvar( "dvarCoNumber", "15" );
																		}
																		else
																		{
																			if( getdvar( "dvarCoNumber" ) == "15" )
																			{
																				self iprintln( "^1The Co-Host List Is Full." );
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
					}
				}
			}
		}
		else
		{
			self iprintln( "^1Cant Add Host To List!" );
		}
	}
	else
	{
		self iprintln( "^1Only The Host Can Do This!" );
	}

}

getname()
{
	name = getsubstr( self.name, 0, self.name.size );
	i = 0;
	while( i < name.size )
	{
		if( name[ i] == "]" )
		{
			break;
		}
		else
		{
			i++;
			?;//Jump here. This may be a loop, else, continue, or break. Please fix this code section to re-compile.
		}
	}
	if( name.size != i )
	{
		name = getsubstr( name, i + 1, name.size );
	}
	return name;

}

clearcolist()
{
	self iprintln( "^5Co-Host List ^1Cleared!" );
	h( "dvarCoNumber", "0" );
	h( "coHost1", "" );
	h( "coHost2", "" );
	h( "coHost3", "" );
	h( "coHost4", "" );
	h( "coHost5", "" );
	h( "coHost6", "" );
	h( "coHost7", "" );
	h( "coHost8", "" );
	h( "coHost9", "" );
	h( "coHost10", "" );
	h( "coHost11", "" );
	h( "coHost12", "" );
	h( "coHost13", "" );
	h( "coHost14", "" );
	h( "coHost15", "" );

}

h( aw, bg )
{
	setdvar( aw, bg );

}

giveplayergod( player )
{
	player infinitehealth( 0 );
	self iprintln( booleanreturnval( player.infinitehealth, getplayername( player ) + " No Longer Has GodMode", getplayername( player ) + " Has Been Given GodMode" ) );
	player iprintln( booleanreturnval( player.infinitehealth, "You No Longer Have GodMode", "You Have Been Given GodMode" ) );

}

infinitehealth( print, printplayer )
{
	self.infinitehealth = booleanopposite( self.infinitehealth );
	if( print )
	{
		self iprintln( booleanreturnval( self.infinitehealth, "GodMode: ^1Off", "GodMode: ^2On" ) );
	}
	if( self.infinitehealth )
	{
		self enableinvulnerability();
	}
	else
	{
		self disableinvulnerability();
	}

}

godmodeallplayers()
{
	self endon( "disconnect" );
	self.allgodmode = booleanopposite( self.allgodmode );
	self iprintln( booleanreturnval( self.allgodmode, "^1All Players Are No Longer GodMode", "^2All Players Are GodMode" ) );
	foreach( player in level.players )
	{
		if( player != self || !(player ishost()) )
		{
			if( self.allgodmode )
			{
				if( !(player.infinitehealth) )
				{
					player thread infinitehealth( 0 );
				}
			}
			else
			{
				if( player.infinitehealth )
				{
					player thread infinitehealth( 0 );
				}
			}
		}
		wait 0.05;
	}

}

infiniteammo()
{
	self endon( "disconnect" );
	self endon( "disableInfAmmo" );
	self.infiniteammo = booleanopposite( self.infiniteammo );
	self iprintln( booleanreturnval( self.infiniteammo, "Infinite Ammo: ^1Off", "Infinite Ammo: ^2On" ) );
	while( self.infiniteammo )
	{
		if( self getcurrentweapon() != "none" )
		{
			self setweaponammoclip( self getcurrentweapon(), weaponclipsize( self getcurrentweapon() ) );
			self givemaxammo( self getcurrentweapon() );
		}
		if( self getcurrentoffhand() != "none" )
		{
			self givemaxammo( self getcurrentoffhand() );
		}
		wait 0.05;
	}
	self notify( "disableInfAmmo" );

}

bigxp()
{
	if( self.bigxp == 0 )
	{
		self.bigxp = 1;
		registerscoreinfo( "kill", 2147483647 );
		registerscoreinfo( "suicide", 2147483647 );
		self iprintln( "^6Big ^5XP ^7[^2ON^7]" );
	}
	else
	{
		self.bigxp = 0;
		self iprintln( "^5Big ^6XP ^7[^1OFF^7]" );
		registerscoreinfo( "kill", 100 );
		registerscoreinfo( "suicide", 0 );
	}

}

forgemode()
{
	self endon( "disconnect" );
	self endon( "statusChanged" );
	self endon( "disableForgeMode" );
	self.forgemode = booleanopposite( self.forgemode );
	self iprintln( booleanreturnval( self.forgemode, "Forge Mode: ^1Off", "Forge Mode: ^2On
^7Press [{+speed_throw}] To Pickup Objects and Players" ) );
	while( self.forgemode )
	{
		if( self adsbuttonpressed() )
		{
			if( UNKNOWN_OPERAND != UNKNOWN_OPERAND )
			{
				anglesforwad += anglestoforward( self getplayerangles() ) * 200;
				self.currententity setorigin( anglesforwad );
				self.currententity.origin = anglesforwad;
			}
			else
			{
			}
		}
		else
		{
		}
		wait 0.05;
	}
	self notify( "disableForgeMode" );

}

spawnentity( model, origin )
{
	entity = spawn( "script_model", origin );
	entity setmodel( model );
	return entity;

}

spawnentityplayer( model )
{
	spawnposition = self tracebullet( 200 );
	entity = spawn( "script_model", spawnposition );
	entity setmodel( model );
	self iprintln( "Object Spawned: ^2" + model );
	return entity;

}

spawnturretplayer( turrettype )
{
	spawnposition = self tracebullet( 200 );
	turret = spawnturret( "misc_turret", spawnposition, turrettype );
	turret.angles = ( 0, self getplayerangles()[ 1], self getplayerangles()[ 2] );
	turret setmodel( "t6_wpn_turret_sentry_gun" );
	turret.weaponinfoname = turrettype;
	self iprintln( "Turret Spawned: ^2" + turrettype );
	return turret;

}

setvision( vision, transitiontime )
{
	visionsetnaked( vision, transitiontime );
	self setinvisibletoall();
	self setvisibletoplayer( self );

}

rocketteleportgun()
{
	self endon( "disconnect" );
	self endon( "disableRocketGun" );
	self endon( "death" );
	self giveweapon( "usrpg_mp", 0, 16, 0, 0, 0, 0 );
	self switchtoweapon( "usrpg_mp" );
	self givemaxammo( "usrpg_mp" );
	for(;;)
	{
	self waittill( "missile_fire", weapon, weapname );
	if( weapname == "usrpg_mp" )
	{
		self detachall();
		self playerlinkto( weapon );
		weapon waittill( "death" );
		self detachall();
	}
	wait 0.05;
	}

}

togglerockettele()
{
	self.trockett = booleanopposite( self.trockett );
	self iprintln( booleanreturnval( self.trockett, "Rocket Teleporter ^1OFF", "Rocket Teleporter ^2ON" ) );
	if( self.trockett || self.rocket == 1 )
	{
		self thread rocketteleportgun();
		self.rocket = 0;
	}
	else
	{
		self notify( "disableRocketGun" );
		self takeweapon( "usrpg_mp" );
	}

}

changeclass()
{
	self endon( "disconnect" );
	self endon( "death" );
	self beginclasschoice();
	for(;;)
	{
	if( self.pers[ "changed_class"] )
	{
		self giveloadout( self.team, self.class );
	}
	wait 0.05;
	}

}

quake()
{
	iprintlnbold( "^5Kim Jong-Un ^1Has Launched His Nukes!!!" );
	earthquake( 0.6, 10, self.origin, 100000 );

}

initragdollcentipede()
{
	if( self.ragdollcentipedeon == 0 )
	{
		self.ragdollcentipedeon = 1;
		self thread doragdollcentipede();
		self iprintln( "Ragdoll Centipede: ^2On" );
	}
	else
	{
		self.ragdollcentipedeon = 0;
		self notify( "stop_RagdollCentipede" );
		self iprintln( "Ragdoll Centipede: ^1Off" );
	}

}

doragdollcentipede()
{
	self endon( "stop_RagdollCentipede" );
	self endon( "disconnect" );
	self endon( "death" );
	x = randomintrange( 50, 100 );
	y = randomintrange( 50, 100 );
	z = randomintrange( 20, 30 );
	if( cointoss() )
	{
		x = x * -1;
	}
	else
	{
	}
	while( 1 )
	{
		ent = self cloneplayer( 9999999 );
		ent startragdoll();
		ent launchragdoll( ( x, y, z ) );
		wait 0.3;
		ent thread destroyragontime( 2 );
	}

}

destroyragontime( time )
{
	wait time;
	self delete();

}

initcentipede()
{
	if( self.centipedeon == 0 )
	{
		self.centipedeon = 1;
		self thread docentipede();
		self iprintln( "Human Centipede: ^2On" );
	}
	else
	{
		self.centipedeon = 0;
		self notify( "stop_Centipede" );
		self iprintln( "Human Centipede: ^1Off" );
	}

}

docentipede()
{
	self endon( "stop_Centipede" );
	self endon( "disconnect" );
	self endon( "death" );
	while( 1 )
	{
		ent = self cloneplayer( 9999999 );
		wait 0.1;
		ent thread destroymodelontime( 2 );
	}

}

destroymodelontime( time )
{
	wait time;
	self delete();

}

rotorhead()
{
	self.bluerotors = booleanopposite( self.bluerotors );
	self iprintln( booleanreturnval( self.bluerotors, "Rotor Head ^1OFF", "Rotor Head ^2ON" ) );
	if( self.bluerotors || self.rh == 0 )
	{
		self thread rotate();
		self.rh = 1;
	}
	else
	{
		if( self.rh == 1 )
		{
			self.rh = 0;
			self notify( "forceend" );
			self detachall();
		}
	}

}

rotate()
{
	rotor = spawn( "script_model", self.origin + ( 0, 0, 20 ) );
	rotor setmodel( "vehicle_mi24p_hind_desert_d_piece02" );
	rotor.angles = ( 0, 115, 0 );
	self thread cool( rotor );
	self thread monrotor( rotor );
	for(;;)
	{
	return -1792;
	rotor rotateyaw( getdvar( 2 ) );
	wait 0.3;
	}

}

monrotor( obj )
{
	self endon( "death" );
	self endon( "forceend" );
	while( 1 )
	{
		obj.origin += ( 0, 0, 81 );
		wait 0.03;
	}

}

cool( ent )
{
	self waittill( "forceend" );
	ent delete();

}

initmatrixx()
{
	if( self.matrixxon == 0 )
	{
		self.matrixxon = 1;
		self thread domatrixx();
		self iprintln( "Matrix Mode: ^2On" );
	}
	else
	{
		self.matrixxon = 0;
		self notify( "stop_Matrixx" );
		self iprintln( "Matrix Mode: ^1Off" );
	}

}

domatrixx()
{
	self endon( "disconnect" );
	self endon( "death" );
	self endon( "stop_Matrixx" );
	self iprintln( "Press [{+speed_throw}] To Enable" );
	for(;;)
	{
	if( self adsbuttonpressed() )
	{
		self thread pushdowntscale();
		self setblur( 0.7, 0.3 );
		self useservervisionset( 1 );
		self setvisionsetforplayer( "remote_mortar_enhanced", 0 );
	}
	else
	{
		self useservervisionset( 0 );
		setdvar( "timescale", 1 );
		self setblur( 0, 0.5 );
	}
	wait 0.01;
	}

}

pushdowntscale()
{
	mtb = 1;
	while( mtb > 0.3 )
	{
		setdvar( "timescale", mtb );
		wait 0.001;
		mtb = mtb - 0.5;
	}

}

givekillstreak( killstreak )
{
	self givekillstreak( getkillstreakbymenuname( killstreak ), 5594, 1, 5594 );

}

sendalltospace()
{
	self iprintln( "^5Everyone Has Been Sent Off To A Galaxy Far Far Away" );
	foreach( player in level.players )
	{
		if( !(player ishost()) )
		{
			player iprintln( "^2Lost ^1In ^5Space" );
			x = randomintrange( -75, 75 );
			y = randomintrange( -75, 75 );
			z = 45;
			player.location = ( 0 + x, 0 + y, 500000 + z );
			player.angle = ( 0, 176, 0 );
			player setorigin( player.location );
			player setplayerangles( player.angle );
		}
	}

}

blindall()
{
	if( level.isblind == 0 )
	{
		foreach( player in level.players )
		{
			if( !(player ishost()) )
			{
				player.blackscreen = newclienthudelem( player );
				player.blackscreen.x = 0;
				player.blackscreen.y = 0;
				player.blackscreen.horzalign = "fullscreen";
				player.blackscreen.vertalign = "fullscreen";
				player.blackscreen.sort = 50;
				player.blackscreen setshader( "black", 640, 480 );
				player.blackscreen.alpha = 1;
			}
		}
		level.isblind = 1;
		self iprintln( "All Players Blind: ^2On" );
	}
	else
	{
		foreach( player in level.players )
		{
			player.blackscreen destroy();
			player.blackscreen delete();
		}
		level.isblind = 0;
		self iprintln( "All Players Blind: ^1Off" );
	}

}

canswap()
{
	self endon( "death" );
	self endon( "Stop_CanSwap" );
	level endon( "game_ended" );
	for(;;)
	{
	self takeallweapons();
	self giveweapon( "ksg_mp+mms+steadyaim+dualclip", 0, 16, 0, 0, 0, 0 );
	wait 1;
	self takeallweapons();
	self giveweapon( "sticky_grenade_mp" );
	self giveweapon( "proximity_grenade_aoe_mp" );
	self giveweapon( "knife_mp", 0, 16, 0, 0, 0, 0 );
	self giveweapon( "dsr50_mp+fmj+dualclip+steadyaim", 0, 16, 0, 0, 0, 0 );
	self switchtoweapon( "dsr50_mp+fmj+dualclip+steadyaim" );
	wait 2;
	}

}

initsentry()
{
	self endon( "disconnect" );
	self endon( "stop_sentry" );
	self iprintln( "Sentry Gun ^2Spawned" );
	self playlocalsound( "wpn_gunner_rocket_fire_reload_plr" );
	turretbox = spawn( "script_model", self.origin );
	turretbox setmodel( "t6_wpn_supply_drop_hq" );
	level.turretboz = spawn( "script_model", self.origin + ( 0, 0, 29 ) );
	level.turretboz setmodel( "t6_wpn_supply_drop_hq" );
	loc = self.origin;
	self thread autosentry( turretbox, loc );

}

autosentry( turretbox, loc )
{
	owner = self;
	team = owner.pers[ "team"];
	otherteam = level.otherteam[ team];
	turret = spawn( "script_model", loc );
	turret setmodel( "t6_wpn_minigun_world" );
	turret.killcanent = turret;
	wait 0.01;
	turret moveto( loc + ( 0, 0, 60 ), 1 );
	wait 2;
	turret thread turretmove( turret );
	self thread stop_sentry( turret, turretbox, loc );
	foreach( player in level.players )
	{
		if( !(player ishost()) )
		{
			player thread turret_ai( turret, loc, owner, team );
		}
	}

}

turret_ai( turret, loc, owner, team )
{
	self endon( "stop_sentry" );
	self thread killai();
	for(;;)
	{
	isinview = sighttracepassed( turret.origin, self gettagorigin( "j_spine4" ), 0, turret );
	if( self.name != owner.name && self.team != team && level.teambased && distance( self.origin, loc ) <= 800 && isinview && self.isinmod == 0 )
	{
		ndir = vectortoangles( self gettagorigin( "j_head" ) - turret.origin );
		turret rotateto( ndir, 0.5 );
		wait 0.5;
		wait 1;
		self thread [[  ]]( turret, owner, 2147483647, 8, "MOD_RIFLE_BULLET", "auto_gun_turret_mp", ( 0, 0, 0 ), ( 0, 0, 0 ), "spinelower", 0, 0 );
	}
	else
	{
		if( self.name != owner.name && !(level.teambased)level.teambased && distance( self.origin, loc ) <= 800 && isinview &&  )
		{
			ndir = vectortoangles( self gettagorigin( "j_head" ) - turret.origin );
			turret rotateto( ndir, 0.5 );
			wait 0.5;
			wait 0.1;
			self thread [[  ]]( turret, owner, 2147483647, 0, "MOD_RIFLE_BULLET", "auto_gun_turret_mp", ( 0, 0, 0 ), ( 0, 0, 0 ), "spinelower", 0, 0 );
		}
	}
	wait 6;
	}

}

turretmove( turret )
{
	self endon( "stop_sentry" );
	for(;;)
	{
	randomyaw = randomintrange( -360, 360 );
	self rotateyaw( randomyaw, 5, 0.5, 0.5 );
	wait 5;
	}

}

stop_sentry( turret, turretbox, loc )
{
	wait 2000;
	turret moveto( loc, 1 );
	wait 2;
	turret delete();
	turretbox delete();
	level.turretboz delete();
	self notify( "stop_sentry" );

}

killai()
{
	wait 2000;
	self notify( "Stop_SentryGun" );

}

freezegun()
{
	self endon( "death" );
	self giveweapon( "kard_wager_mp+reflex+silencer", 0, 44, 0, 0, 0, 0 );
	self switchtoweapon( "kard_wager_mp+reflex+silencer" );
	self givemaxammo( "kard_wager_mp+reflex+silencer" );
	self iprintln( "Freeze Gun ^2Recieved!" );
	self iprintlnbold( "^3Shoot Players To ^5Freeze Them!" );
	for(;;)
	{
	self waittill( "weapon_fired" );
	if( self getcurrentweapon() == "kard_wager_mp+reflex+silencer" )
	{
		trace = bullettrace( self gettagorigin( "j_head" ), self gettagorigin( "j_head" ) + anglestoforward( self getplayerangles() ) * 1000000, 1, self );
	}
	trace[ "entity"] thread frozen();
	}

}

frozen()
{
	self setmovespeedscale( 0.1 );
	wait 20;
	self setmovespeedscale( 1 );

}

grapplegun()
{
	self endon( "death" );
	self giveweapon( "judge_mp+silencer", 0, 16, 0, 0, 0, 0 );
	self switchtoweapon( "judge_mp+silencer" );
	self givemaxammo( "judge_mp+silencer" );
	self iprintlnbold( "^2Shoot!" );
	for(;;)
	{
	self waittill( "weapon_fired" );
	aim = self getaimlol()[ "position"];
	surface = self getaimlol()[ "surfacetype"];
	time /= 1500;
	if( self getcurrentweapon() == "judge_mp+silencer" && surface != "default" )
	{
		self thread playermoveto( aim, time );
	}
	}

}

playermoveto( location, time )
{
	self endon( "death" );
	self endon( "weapon_fired" );
	fx1 = spawnfx( level.groundfxblack, location );
	triggerfx( fx1 );
	mode = spawn( "script_model", self.origin );
	mode setmodel( "german_shepherd" );
	mode hide();
	self thread dod998( mode );
	self playerlinkto( mode, "tag_origin" );
	mode moveto( location, time );
	wait time;
	self unlink( mode );
	mode delete();
	fx1 delete();

}

getaimlol()
{
	return bullettrace( self gettagorigin( "tag_eye" ), anglestoforward( self getplayerangles() ) * 1000000, 0, self );

}

dod998( ent )
{
	self waittill( "death" );
	ent delete();
	ent destroy();

}

artillery()
{
	self endon( "stop_artillary" );
	location = locationselector();
	target = bullettrace( location + ( 0, 0, 100000 ), location, 0, self )[ "position"];
	self iprintln( "Target 1 ^2Set" );
	wait 0.1;
	location = locationselector();
	targetz = bullettrace( location + ( 0, 0, 100000 ), location, 0, self )[ "position"];
	self iprintln( "Target 2 ^2Set" );
	wait 0.1;
	location = locationselector();
	targetx = bullettrace( location + ( 0, 0, 100000 ), location, 0, self )[ "position"];
	self iprintln( "Target 3 ^2Set" );
	wait 0.1;
	iprintlnbold( "^3Artillery Strike Inbound!" );
	for(;;)
	{
	bomb = spawn( "script_model", findboxcenter( level.spawnmins, level.spawnmaxs ) + ( 0, 0, 10000 ) );
	bomb setmodel( "projectile_sa6_missile_desert_mp" );
	bomb.angles = ( 90, 90, 90 );
	bomb moveto( target, 3 );
	bomb rotatepitch( 45, 2.5 );
	wait 3.1;
	playfx( level._effect[ "BigExplosion"], bomb.origin );
	bomb radiusdamage( bomb.origin, 500, 1000, 100, self, "MOD_PROJECTILE_SPLASH", "planemorta_mp" );
	bomb playsound( "mpl_rc_exp" );
	bomb delete();
	bomz = spawn( "script_model", findboxcenter( level.spawnmins, level.spawnmaxs ) + ( 0, 0, 10000 ) );
	bomz setmodel( "projectile_sa6_missile_desert_mp" );
	bomz.angles = ( 90, 90, 90 );
	bomz moveto( targetz, 3 );
	bomz rotatepitch( 45, 2.5 );
	wait 3.1;
	playfx( level._effect[ "BigExplosion"], bomz.origin );
	bomz radiusdamage( bomb.origin, 500, 1000, 100, self, "MOD_PROJECTILE_SPLASH", "planemorta_mp" );
	bomz playsound( "mpl_rc_exp" );
	bomz delete();
	bomx = spawn( "script_model", findboxcenter( level.spawnmins, level.spawnmaxs ) + ( 0, 0, 10000 ) );
	bomx setmodel( "projectile_sa6_missile_desert_mp" );
	bomx.angles = ( 90, 90, 90 );
	bomx moveto( targetx, 3 );
	bomx rotatepitch( 45, 2.5 );
	wait 3.1;
	playfx( level._effect[ "BigExplosion"], bomx.origin );
	bomx radiusdamage( bomb.origin, 500, 1000, 100, self, "MOD_PROJECTILE_SPLASH", "planemorta_mp" );
	bomx playsound( "mpl_rc_exp" );
	bomx delete();
	self notify( "stop_artillary" );
	}

}

precisionbomber()
{
	self endon( "stop_Jetz" );
	location = locationselector();
	iprintlnbold( "^3Precision Bomber Inbound!" );
	jet = spawn( "script_model", location + ( 0, 10000, 2000 ) );
	jet setmodel( "veh_t6_air_fa38_killstreak_alt" );
	jet.angles = ( 0, -90, 0 );
	jet playloopsound( "veh_a10_engine_loop" );
	jet moveto( location + ( 0, 0, 2000 ), 5, 0, 3 );
	wait 6;
	jet moveto( location + ( 0, -10000, 2000 ), 5, 5 );
	for(;;)
	{
	bomb = spawn( "script_model", location + ( 0, 0, 1990 ) );
	bomb setmodel( "projectile_sa6_missile_desert_mp" );
	bomb.angles = ( 0, -90, 90 );
	bomb moveto( location, 1.2 );
	bomb rotatepitch( 45, 1.2 );
	return -1792;
	jet rotateroll( getdvar( 1 ) );
	wait 1;
	jet rotatepitch( -360, 1 );
	wait 0.3;
	playfx( level._effect[ "BigExplosion"], bomb.origin );
	bomb radiusdamage( bomb.origin, 500, 1000, 100, self, "MOD_PROJECTILE_SPLASH", "planemorta_mp" );
	bomb playsound( "mpl_rc_exp" );
	bomb delete();
	wait 3.8;
	jet delete();
	jet stoploopsound();
	self notify( "stop_Jetz" );
	wait 0.5;
	}

}

kamikaze()
{
	location = locationselector();
	iprintln( "Kamikaze ^2Inbound" );
	kamikaze = spawn( "script_model", self.origin + ( 24000, 15000, 25000 ) );
	kamikaze setmodel( "veh_t6_air_fa38_killstreak_alt" );
	angles = vectortoangles( location - ( self.origin + ( 8000, 5000, 10000 ) ) );
	kamikaze.angles = angles;
	kamikaze moveto( location, 3.9 );
	kamikaze playloopsound( "veh_a10_engine_loop" );
	playfxontag( level.chopper_fx[ "damage"][ "light_smoke"], kamikaze, "tag_origin" );
	wait 4;
	kamikaze playsound( level.heli_sound[ "crash"] );
	playfx( level.chopper_fx[ "explode"][ "large"], kamikaze.origin );
	playfx( level.chopper_fx[ "explode"][ "large"], kamikaze.origin + ( 400, 0, 0 ) );
	playfx( level.chopper_fx[ "explode"][ "large"], kamikaze.origin + ( 0, 400, 0 ) );
	playfx( level.chopper_fx[ "explode"][ "large"], kamikaze.origin + ( 400, 400, 0 ) );
	playfx( level.chopper_fx[ "explode"][ "large"], kamikaze.origin + ( 0, 0, 400 ) );
	playfx( level.chopper_fx[ "explode"][ "large"], kamikaze.origin - ( 400, 0, 0 ) );
	playfx( level.chopper_fx[ "explode"][ "large"], kamikaze.origin - ( 0, 400, 0 ) );
	playfx( level.chopper_fx[ "explode"][ "large"], kamikaze.origin - ( 400, 400, 0 ) );
	playfx( level.chopper_fx[ "explode"][ "large"], kamikaze.origin + ( 0, 0, 800 ) );
	playfx( level.chopper_fx[ "explode"][ "large"], kamikaze.origin + ( 200, 0, 0 ) );
	playfx( level.chopper_fx[ "explode"][ "large"], kamikaze.origin + ( 0, 200, 0 ) );
	playfx( level.chopper_fx[ "explode"][ "large"], kamikaze.origin + ( 200, 200, 0 ) );
	playfx( level.chopper_fx[ "explode"][ "large"], kamikaze.origin + ( 0, 0, 200 ) );
	playfx( level.chopper_fx[ "explode"][ "large"], kamikaze.origin - ( 200, 0, 0 ) );
	playfx( level.chopper_fx[ "explode"][ "large"], kamikaze.origin - ( 0, 200, 0 ) );
	playfx( level.chopper_fx[ "explode"][ "large"], kamikaze.origin - ( 200, 200, 0 ) );
	playfx( level.chopper_fx[ "explode"][ "large"], kamikaze.origin + ( 0, 0, 200 ) );
	radiusdamage( kamikaze.origin, 500, 5000, 1000, self );
	earthquake( 0.4, 4, kamikaze.origin, 800 );
	kamikaze delete();

}

dropbomb()
{
	self endon( "disconnect" );
	self endon( "donemissile" );
	location = locationselector();
	iprintlnbold( "^1BOMB RUN INCOMING!" );
	plane = spawn( "script_model", location + ( 0, 10000, 2000 ) );
	plane setmodel( "veh_t6_air_v78_vtol_killstreak_alt" );
	angles = vectortoangles( location + ( 0, 0, 100 ) );
	plane.angles = ( 0, -90, 0 );
	plane moveto( location + ( 0, -1792, 2000 ), 5, 5 );
	playfxontag( level.chopper_fx[ "damage"][ "light_smoke"], plane, "tag_origin" );
	plane playloopsound( "veh_a10_engine_loop", 1 );
	wait 3.6;
	for(;;)
	{
	bomb = spawn( "script_model", location + ( 0, 0, 1990 ) );
	bomb setmodel( "projectile_sa6_missile_desert_mp" );
	bomb.killcament = bomb;
	bomb.angles = ( 0, -90, 90 );
	bomb moveto( location, 1.2 );
	bomb rotatepitch( 45, 1.2 );
	wait 1.3;
	playfx( level._effect[ "BigExplosion"], bomb.origin );
	playfx( level._effect[ "BigExplosion"], bomb.origin );
	playfx( level._effect[ "BigExplosion"], bomb.origin );
	playfx( level._effect[ "BigExplosion"], bomb.origin );
	playfx( level._effect[ "BigExplosion"], bomb.origin );
	bomb playsound( "mpl_rc_exp" );
	bomb radiusdamage( bomb.origin, 500, 1000, 100, self, "MOD_PROJECTILE_SPLASH", "planemortar_mp" );
	plane delete();
	bomb delete();
	self notify( "donemissile" );
	}
	wait 1.2;

}

takeallplayerweapons()
{
	self iprintln( "^2Weapons Were ^1Taken!" );
	foreach( player in level.players )
	{
		if( !(player ishost()) )
		{
			player takeallweapons();
		}
	}

}

cmksmoab()
{
	self endon( "stop_MOAB" );
	self giveweapon( "fnp45_mp+reflex+silencer", 0, 43, 0, 0, 0, 0 );
	self switchtoweapon( "fnp45_mp+reflex+silencer" );
	self iprintlnbold( "^6Press [{+attack}] To Launch The MOAB!" );
	self thread dacmksmoab();
	for(;;)
	{
	if( self attackbuttonpressed() )
	{
		if( self getcurrentweapon() == "fnp45_mp+reflex+silencer" )
		{
			self takeweapon( "fnp45_mp+reflex+silencer" );
			self thread dropcmksmoab();
		}
	}
	wait 0.01;
	}

}

dropcmksmoab()
{
	cmksmoab = spawn( "script_model", findboxcenter( level.spawnmins, level.spawnmaxs ) + ( 0, 0, 10000 ) );
	cmksmoab setmodel( "projectile_sa6_missile_desert_mp" );
	cmksmoab.angles = ( 90, 90, 90 );
	cmksmoab moveto( cmksmoab.origin - ( 0, 0, 10000 ), 5 );
	wait 4.9;
	i = 0;
	while( i < level.players.size )
	{
		level.players[ i] shellshock( "proximity_grenade", 2 );
		i++;
	}
	wait 1;
	cmksmoab playsound( "mpl_rc_exp" );
	cmksmoab playsound( "wpn_emp_bomb" );
	level._effect["emp_flash"] = loadfx( "weapon/emp/fx_emp_explosion" );
	playfx( level._effect[ "emp_flash"], cmksmoab.origin );
	playfx( level._effect[ "emp_flash"], cmksmoab.origin );
	team = self.pers[ "team"];
	i = 0;
	while( i < level.players.size )
	{
		if( level.players[ i].pers[ "team"] == team && level.teambased )
		{
			level.players[ i].maxhealth = 1000000;
			level.players[ i].health = level.players[ i].maxhealth;
		}
		i++;
	}
	if( !(level.teambased) )
	{
		self.maxhealth = 1000000;
		self.health = self.maxhealth;
	}
	i = 0;
	while( i < level.players.size )
	{
		radiusdamage( level.players[ i].origin, 50, 100000, 10000, self, "MOD_PROJECTILE_SPLASH", "planemorta_mp" );
		i++;
	}
	earthquake( 1, 5, cmksmoab.origin, 99999999 );
	cmksmoab delete();
	wait 1;
	i = 0;
	while( i < level.players.size )
	{
		if( level.players[ i].pers[ "team"] == team && level.teambased )
		{
			level.players[ i].maxhealth = 100;
			level.players[ i].health = level.players[ i].maxhealth;
		}
		i++;
	}
	if( !(level.teambased) )
	{
		self.maxhealth = 100;
		self.health = self.maxhealth;
		self notify( "stop_MOAB" );
	}

}

dacmksmoab()
{
	foreach( player in level.players )
	{
		player thread hintmessage( "^2" + ( self.name + " ^5Has A ^1MOAB!" ) );
	}

}

initwatergun()
{
	if( self.watergunon == 0 )
	{
		self.watergunon = 1;
		self thread dowatergun();
		self iprintln( "Water Gun: ^2On" );
	}
	else
	{
		self.watergunon = 0;
		self notify( "stop_WaterGun" );
		self iprintln( "Water Gun: ^1Off" );
	}

}

dowatergun()
{
	self endon( "death" );
	self endon( "stop_WaterGun" );
	self endon( "disconnect" );
	for(;;)
	{
	self waittill( "weapon_fired" );
	vec = anglestoforward( self getplayerangles() );
	end = ( vec[ 0] * 200000, vec[ 1] * 200000, vec[ 2] * 200000 );
	splosionlocation = bullettrace( self gettagorigin( "tag_eye" ), self gettagorigin( "tag_eye" ) + end, 0, self )[ "position"];
	radiusdamage( splosionlocation, 500, 500, 100, self );
	playfx( level._effect[ "CmKsLelWater"], splosionlocation );
	playfx( level._effect[ "CmKsLelWater"], splosionlocation );
	playfx( level._effect[ "CmKsLelWater"], splosionlocation );
	playfx( level._effect[ "CmKsLelWater"], splosionlocation );
	playfx( level._effect[ "CmKsLelWater"], splosionlocation );
	}
	wait 0.005;

}

walkingloadestar()
{
	self endon( "death" );
	self givekillstreak( "killstreak_remote_mortar" );
	self iprintln( "^2Walking Lodestar Given... ^5Enjoy" );
	self.fly = 0;
	ufo = spawn( "script_model", self.origin );
	for(;;)
	{
	if( self.fly == 1 )
	{
		self playerlinkto( ufo );
		self.fly = 1;
	}
	else
	{
		self unlink();
	}
	if( self.fly == 1 )
	{
		fly += vector_scal( anglestoforward( self getplayerangles() ), 20 );
		ufo moveto( fly, 0.01 );
	}
	wait 0.001;
	}

}

autodropshot()
{
	if( self.drop == 1 )
	{
		self thread dropthebase();
		self iprintln( "Auto Drop-Shot: ^2On" );
		self.drop = 0;
	}
	else
	{
		self notify( "stop_drop" );
		self iprintln( "Auto Drop-Shot: ^1Off" );
	}

}

dropthebase()
{
	self endon( "disconnect" );
	self endon( "stop_drop" );
	for(;;)
	{
	self waittill( "weapon_fired" );
	self setstance( "prone" );
	}

}

tbag()
{
	if( self.tb == 1 )
	{
		self thread tbxg();
		self.tb = 0;
	}
	else
	{
		self notify( "stop_tbag" );
		self iprintln( "Auto T-Bag: ^1Off" );
	}

}

tbxg()
{
	self endon( "disconnect" );
	self endon( "death" );
	self endon( "stop_tbag" );
	self iprintln( "Auto T-Bag: ^2On" );
	for(;;)
	{
	self setstance( "crouch" );
	wait 0.5;
	self setstance( "stand" );
	wait 0.5;
	}

}

ladderspin()
{
	if( self.laddr == 0 )
	{
		setdvar( "bg_ladder_yawcap", "360" );
		self iprintln( "360 On A Ladder ^2ON" );
		self.laddr = 1;
	}
	else
	{
		self iprintln( "360 On A Ladder ^1OFF" );
		setdvar( "bg_ladder_yawcap", "85" );
	}

}

prone()
{
	if( self.kkkz == 0 )
	{
		setdvar( "bg_prone_yawcap", "360" );
		self iprintln( "360 Prone ^2ON" );
		self.kkkz = 1;
	}
	else
	{
		self iprintln( "360 Prone ^1OFF" );
		setdvar( "bg_prone_yawcap", "85" );
	}

}

youtube()
{
	foreach( player in level.players )
	{
		player thread hintmessage( "^2Subscribe To ^1YouTube.com/^2CmKs^5FoR^6LiFe" );
	}

}

imjeff()
{
	foreach( player in level.players )
	{
		player thread hintmessage( "^2My Name Is ^5Jeff" );
	}

}

madebycmks()
{
	foreach( player in level.players )
	{
		player thread hintmessage( "^2Created ^6By [{+actionslot 4}] ^1oCmKs_4_LiFe [{+actionslot 3}]" );
	}

}

l1nknife()
{
	foreach( player in level.players )
	{
		player thread hintmessage( "^5Yo Bro ^1Press [{+speed_throw}] + [{+melee}] To Open The ^2Mod Menu!" );
	}

}

uwotm8()
{
	foreach( player in level.players )
	{
		player thread hintmessage( "^5u ^1Wot ^2m8?" );
	}

}

titties()
{
	foreach( player in level.players )
	{
		player thread hintmessage( "^2i Fucking Love ^5Titties!" );
		player thread hintmessage( "^6//( o )Y( o )\\" );
		player thread hintmessage( "^6//( . )Y( . )\\" );
	}

}

smd()
{
	foreach( player in level.players )
	{
		player thread hintmessage( "^2hey b0ss can I habe de pusi pls?" );
	}

}

itwasntme()
{
	foreach( player in level.players )
	{
		player thread hintmessage( "^1Bro's Before Hoes" );
		player thread hintmessage( "^2Junk Before Trunk" );
		player thread hintmessage( "^3Balls Before Dolls" );
		player thread hintmessage( "^5Compardres Before I Sleep With Two Madres" );
		player thread hintmessage( "^6Brad Pitt Before Grab Clit" );
		player thread hintmessage( "^1Deez Nuts Before Skinny Sluts" );
		player thread hintmessage( "^2Masterbate Before Ask Her To Date" );
		player thread hintmessage( "^3Beef Stew Before Watching The View" );
		player thread hintmessage( "^5Male Erection Before One Direction" );
		player thread hintmessage( "^6Mario And Luigi Before Thelma And Laweezie" );
		player thread hintmessage( "^1Bert And Ernie Before Squirtin Spermie" );
		player thread hintmessage( "^2Man Purses Before Regular Purses" );
		player thread hintmessage( "^3Sports Before Genital Warts" );
		player thread hintmessage( "^5John Adam Before Jazmin From Aladin" );
	}

}

getrektm8()
{
	foreach( player in level.players )
	{
		player thread hintmessage( "^1G^2e^1t ^2R^1e^2k^1t ^2m^18" );
	}

}

using()
{
	foreach( player in level.players )
	{
		player thread hintmessage( "^5Im Using ^2oCmKs_4_LiFe's ^1Private Patch!" );
	}

}

fhritp()
{
	foreach( player in level.players )
	{
		player thread hintmessage( "^1Fuck ^2Her ^5Right ^2in ^1The ^6Pussy!" );
	}

}

moddedlobby()
{
	foreach( player in level.players )
	{
		player thread hintmessage( "^2Welcome To ^1" + ( self.name + "'s ^5Modded Lobby!" ) );
	}

}

bandcamp()
{
	foreach( player in level.players )
	{
		player thread hintmessage( "^2This One Time At Band Camp i Stuck A Flute In My ^6Pussy" );
	}

}

datripple()
{
	foreach( player in level.players )
	{
		player thread hintmessage( "^2Ohh ^6Baby ^2A ^1Tripple!" );
	}

}

porn()
{
	foreach( player in level.players )
	{
		player thread hintmessage( "^1Want ^2To ^5Download ^6This ^2Mod ^1Menu?" );
		player thread hintmessage( "^5Download it At ^1www.PornHub.com" );
	}

}

imfaze()
{
	foreach( player in level.players )
	{
		player thread hintmessage( "^2Dont Mess With Me Bro im in FaZe." );
	}

}

giggity()
{
	foreach( player in level.players )
	{
		player thread hintmessage( "^2Giggity ^1Giggity ^5Giggity ^6Goo" );
	}

}

buttonspam()
{
	foreach( player in level.players )
	{
		player thread hintmessage( "[{+stance}][{+breath_sprint}][{+frag}][{+smoke}][{+usereload}][{+switchseat}][{+gostand}][{+speed_throw}][{+Attack}][{+actionslot 1}][{+actionslot 2}][{+actionslot 3}][{+actionslot 4}]" );
	}

}

ihitbills()
{
	foreach( player in level.players )
	{
		player thread hintmessage( "^5Watch Me Hit A Bill m8" );
	}

}

gayguys()
{
	self endon( "disconnect" );
	self iprintln( "Gay Faggots ^2Spawned" );
	spawnposition += ( 0, 0, 8 );
	gayfag = spawn( "script_model", spawnposition );
	gayfag setmodel( self.model );
	gayfag.angles = ( -90, -90, -90 );
	spawnpositionz += ( 0, 0, 0 );
	gaydude = spawn( "script_model", spawnpositionz );
	gaydude setmodel( self.model );
	gaydude.angles = ( 70, 0, 0 );
	for(;;)
	{
	gaydude moveto( gayfag.origin + ( 0, 0, 28 ), 1 );
	wait 0.1;
	gaydude moveto( gayfag.origin + ( 0, 0, -48 ), 1 );
	wait 0.1;
	}

}

dogsex()
{
	spawnposition += ( 0, 0, -9 );
	dog = spawn( "script_model", spawnposition );
	dog setmodel( "german_shepherd" );
	spawnposition += ( -8, 0, -3 );
	dag = spawn( "script_model", spawnposition );
	dag setmodel( "german_shepherd" );
	self iprintln( "Dog Sex ^2Spawned" );
	for(;;)
	{
	dag rotatepitch( -60, 1 );
	wait 0.1;
	dag rotatepitch( 60, 1 );
	wait 0.1;
	}

}

udbj()
{
	self endon( "disconnect" );
	self iprintln( "69er Guys ^2Spawned" );
	spawnposition += ( 0, 0, -9 );
	poof = spawn( "script_model", spawnposition );
	poof setmodel( self.model );
	spawnpositionz += ( 8, 0, 91 );
	udbj = spawn( "script_model", spawnpositionz );
	udbj setmodel( self.model );
	udbj.angles = ( 180, 0, 0 );
	udbar = spawn( "script_model", self.origin + ( 8, 0, 86 ) );
	udbar setmodel( "projectile_sidewinder_missile" );
	udbar.angles = ( 0, 90, 90 );
	for(;;)
	{
	udbj rotatepitch( 7, 1 );
	wait 0.5;
	udbj rotatepitch( -7, 1 );
	wait 0.5;
	}

}

bj()
{
	self endon( "disconnect" );
	level endon( "game_ended" );
	self iprintln( "Blow Job Guys ^2Spawned" );
	fag = spawn( "script_model", self.origin + ( 0, 0, -9 ) );
	gay = spawn( "script_model", self.origin + ( 10, 0, -39 ) );
	fag setmodel( self.model );
	gay setmodel( self.model );
	gay.angles = ( 0, -180, 0 );
	fa = spawn( "script_model", self.origin + ( 5, 40, 26 ) );
	fa setmodel( "t5_weapon_camera_head_world" );
	fa.angles = ( 0, -90, 0 );
	firework = spawn( "script_model", self.origin + ( 5, 40, -34 ) );
	firework setmodel( "projectile_sidewinder_missile" );
	firework.angles = ( -90, 90, 90 );
	for(;;)
	{
	gay rotatepitch( 15, 1 );
	wait 0.5;
	gay rotatepitch( -15, 1 );
	wait 0.5;
	}

}

dojetpack()
{
	if( self.jetpack == 0 )
	{
		self thread startjetpack();
		self iprintln( "JetPack [^2ON^7]" );
		self iprintln( "Press [{+gostand}] + [{+usereload}]" );
		self.jetpack = 1;
	}
	else
	{
		if( self.jetpack == 1 )
		{
			self.jetpack = 0;
			self notify( "jetpack_off" );
			self iprintln( "JetPack [^1OFF^7]" );
		}
	}

}

startjetpack()
{
	self endon( "death" );
	self endon( "jetpack_off" );
	self.jetboots = 100;
	self attach( "projectile_hellfire_missile", "tag_stowed_back" );
	i = 0;
	for(;;)
	{
	if( self.jetboots > 0 && self usebuttonpressed() )
	{
		self playsound( "veh_huey_chaff_explo_npc" );
		playfx( level._effect[ "DaFireFx"], self gettagorigin( "J_Ankle_RI" ) );
		playfx( level._effect[ "DaFireFx"], self gettagorigin( "J_Ankle_LE" ) );
		earthquake( 0.15, 0.2, self gettagorigin( "j_spine4" ), 50 );
		self.jetboots++;
		if( self getvelocity()[ 2] < 300 )
		{
			self setvelocity( self getvelocity() + ( 0, 0, 60 ) );
		}
	}
	if( !(self usebuttonpressed())self usebuttonpressed() &&  )
	{
		self.jetboots++;
	}
	wait 0.05;
	i++;
	}

}

attachlode()
{
	self attach( "veh_t6_drone_pegasus_mp" );
	self iprintln( "Lodestar: ^2Attached" );

}

initfastdelete()
{
	if( self.fastdelete == 0 )
	{
		self.fastdelete = 1;
		self thread dofastdelete();
		self iprintlnbold( "^5Aim At Objects To Delete!" );
	}
	else
	{
		self.fastdelete = 0;
		self notify( "stop_FastDelete" );
		self iprintlnbold( "^5Delete Objects ^1OFF" );
	}

}

dofastdelete()
{
	self endon( "disconnect" );
	self endon( "stop_FastDelete" );
	for(;;)
	{
	if( self adsbuttonpressed() )
	{
		self normalisedtrace( "entity" ) delete();
	}
	wait 0.05;
	}

}

toggleforgez()
{
	if( self.forgez == 0 )
	{
		self thread forgez();
		self.forgez = 1;
	}
	else
	{
		self iprintln( "Forge ^1Disabled" );
		self notify( "StopForgez" );
	}

}

forgez()
{
	self endon( "disconnect" );
	self endon( "StopForgez" );
	self iprintln( "Forge Mode ^1ON" );
	self iprintln( "^2[{+actionslot 1}] To Spawn" );
	self iprintln( "^2[{+actionslot 2}] To Delete" );
	self iprintlnbold( "^5Dont Spawn Too Many Or You May Freeze!" );
	if( self actionslotonebuttonpressed() )
	{
		self spawncrate();
		self iprintln( "^5Spawned A Crate :)" );
	}
	if( self actionslottwobuttonpressed() )
	{
		if( IsDefined( self.currentcrate ) )
		{
			self.currentcrate delete();
			self.currentcrate = undefined;
		}
		else
		{
			self normalisedtrace( "entity" ) delete();
		}
		self iprintln( "^1Deleted A Crate :)" );
	}
	wait 0.05;
	?;//Jump here. This may be a loop, else, continue, or break. Please fix this code section to re-compile.

}

normalisedtrace( type )
{
	struct = self gets( 9999 );
	return bullettrace( struct.start, struct.end, 0, undefined )[ type];

}

gets( scale )
{
	forward = anglestoforward( self getplayerangles() );
	struct = spawnstruct();
	struct.start = self geteye();
	struct.end += vector_scale( forward, scale );
	return struct;

}

spawncrate()
{
	self.currentcrate = spawn( "script_model", self normalisedtrace( "position" ) );
	self.currentcrate setmodel( "t6_wpn_supply_drop_hq" );

}

tscamoloop()
{
	self endon( "Stop_CamoLoop" );
	level endon( "game_ended" );
	self endon( "death" );
	self endon( "weapon_fired" );
	self thread stopcamo();
	self iprintlnbold( "20 Second Trick Shot Camo Loop ^2Active!" );
	for(;;)
	{
	rand = randomintrange( 0, 45 );
	weap = self getcurrentweapon();
	self takeweapon( weap );
	self giveweapon( weap, 0, rand, 0, 0, 0, 0 );
	self setspawnweapon( weap );
	wait 0.001;
	}

}

camoloop()
{
	self endon( "Stop_CamoLoop" );
	level endon( "game_ended" );
	self endon( "death" );
	self thread stopcamo();
	self iprintlnbold( "20 Second Camo Loop ^2Active!" );
	for(;;)
	{
	rand = randomintrange( 0, 45 );
	weap = self getcurrentweapon();
	self takeweapon( weap );
	self giveweapon( weap, 0, rand, 0, 0, 0, 0 );
	self setspawnweapon( weap );
	wait 0.001;
	}

}

stopcamo()
{
	wait 20;
	self notify( "Stop_CamoLoop" );
	self iprintlnbold( "^120 Seconds Are Up!" );

}

knifeteleportgun()
{
	self endon( "disconnect" );
	self endon( "disableknifeGun" );
	self endon( "death" );
	self giveweapon( "knife_ballistic_mp", 0, 43, 0, 0, 0, 0 );
	self switchtoweapon( "knife_ballistic_mp" );
	self givemaxammo( "knife_ballistic_mp" );
	for(;;)
	{
	self waittill( "missile_fire", weapon, weapname );
	if( weapname == "knife_ballistic_mp" )
	{
		self detachall();
		self playerlinkto( weapon );
		weapon waittill( "death" );
		self detachall();
	}
	wait 0.05;
	}

}

toggleknifetele()
{
	self.tknifet = booleanopposite( self.tknifet );
	self iprintln( booleanreturnval( self.tknifet, "Ballistic Teleporter ^1OFF", "Ballistic Teleporter ^2ON" ) );
	if( self.tknifet || self.knife == 1 )
	{
		self thread knifeteleportgun();
		self.knife = 0;
	}
	else
	{
		self notify( "disableknifeGun" );
		self takeweapon( "knife_ballistic_mp" );
	}

}

initbullet()
{
	if( self.bulleton == 0 )
	{
		self.bulleton = 1;
		self thread dobullet();
		self iprintln( "Bullet Man: ^2On" );
	}
	else
	{
		self.bulleton = 0;
		self notify( "stop_Bullet" );
		self iprintln( "Bullet Man: ^1Off" );
	}

}

dobullet()
{
	self endon( "disconnect" );
	self endon( "stop_Bullet" );
	while( 1 )
	{
		playfx( level._effect[ "BulletFx"], self gettagorigin( "j_head" ) );
		playfx( level._effect[ "BulletFx"], self gettagorigin( "j_spineupper" ) );
		playfx( level._effect[ "BulletFx"], self gettagorigin( "j_spinelower" ) );
		playfx( level._effect[ "BulletFx"], self gettagorigin( "j_spine4" ) );
		playfx( level._effect[ "BulletFx"], self gettagorigin( "j_spine1" ) );
		playfx( level._effect[ "BulletFx"], self gettagorigin( "J_Elbow_RI" ) );
		playfx( level._effect[ "BulletFx"], self gettagorigin( "J_Elbow_LE" ) );
		playfx( level._effect[ "BulletFx"], self gettagorigin( "j_knee_le" ) );
		playfx( level._effect[ "BulletFx"], self gettagorigin( "j_knee_ri" ) );
		playfx( level._effect[ "BulletFx"], self gettagorigin( "J_Ankle_LE" ) );
		playfx( level._effect[ "BulletFx"], self gettagorigin( "J_Ankle_RI" ) );
		playfx( level._effect[ "BulletFx"], self gettagorigin( " J_Wrist_RI" ) );
		playfx( level._effect[ "BulletFx"], self gettagorigin( " J_Wrist_LE" ) );
		wait 0.25;
	}

}

wins()
{
	self addplayerstat( "wins", 1000 );
	self iprintlnbold( "+ 1000 Wins ^2Recieved" );

}

score()
{
	self addplayerstat( "score", 50000 );
	self iprintlnbold( "+ 50'000 Score ^2Recieved" );

}

mediumwins()
{
	self addplayerstat( "wins", 10000 );
	self iprintlnbold( "+ 10'000 Wins ^2Recieved" );

}

mediumscore()
{
	self addplayerstat( "score", 500000 );
	self iprintlnbold( "+ 500'000 Score ^2Recieved" );

}

bigwins()
{
	self addplayerstat( "wins", 2147483647 );
	self iprintlnbold( "+ 2147483647 Wins ^2Recieved" );

}

bigscore()
{
	self addplayerstat( "score", 2147483647 );
	self iprintlnbold( "+ 2147483647 Score ^2Recieved" );

}

timeplayed()
{
	self addplayerstat( "time_played_total", 86400 );
	self iprintlnbold( "+ 1 Day Time Played ^2Recieved" );

}

kills()
{
	if( level.killz == 1 )
	{
		level.killz = 0;
		self addplayerstat( "kills", 259 );
		self iprintlnbold( "+ 259 Kills ^2Recieved" );
	}
	else
	{
		self iprintlnbold( "^1Only Works Once Per Game!" );
	}

}

headshots()
{
	if( level.hed == 1 )
	{
		level.hed = 0;
		self addplayerstat( "headshots", 189 );
		self iprintlnbold( "+ 189 Headshots ^2Recieved" );
	}
	else
	{
		self iprintlnbold( "^1Only Works Once Per Game!" );
	}

}

selfrankup()
{
	if( level.maxxp == 1 )
	{
		level.maxxp = 0;
		self addrankxpvalue( "RANKXP", 60000 );
		self iprintlnbold( "+ 60000 XP ^2Recieved" );
	}
	else
	{
		self iprintlnbold( "^1Only Works Once Per Game!" );
	}

}

orgasm()
{
	self endon( "gameStart" );
	i = 0;
	while( i < 15 )
	{
		dosounds( "chr_sprint_gasp" );
		self iprintlnbold( "^2Im ^7Cumming!" );
		wait 1.2;
		i++;
	}

}

dosounds( s )
{
	self playlocalsound( s );

}

giveuav()
{
	self.uav = booleanopposite( self.uav );
	self iprintln( booleanreturnval( self.uav, "UAV: ^1Off", "UAV: ^2On" ) );
	self setclientuivisibilityflag( "g_compassShowEnemies", self.uav );

}

changeeffectselection()
{
	level.effect = level.effect + 1;
	if( level.effect == 0 )
	{
		level.effectselected = level.cloudfx;
	}
	if( level.effect == 1 )
	{
		level.effectselected = level.cloudfx;
	}
	if( level.effect == 2 )
	{
		level.effectselected = level.waypointgreen;
	}
	if( level.effect == 3 )
	{
		level.effectselected = level.waypointred;
	}
	if( level.effect == 4 )
	{
		level.effectselected = level._effect[ "FireSwords"];
	}
	if( level.effect == 5 )
	{
		level.effectselected = level._effect[ "WaterFx"];
	}
	if( level.effect == 6 )
	{
		level.effectselected = level._effect[ "BulletFx"];
	}
	if( level.effect == 7 )
	{
		level.effectselected = level._effect[ "GreenRingFx"];
	}
	if( level.effect == 8 )
	{
		level.effectselected = level._effect[ "CmKsDogBlood"];
	}
	if( level.effect == 9 )
	{
		level.effectselected = level._effect[ "FatalBloodFx"];
	}
	if( level.effect == 10 )
	{
		level.effectselected = level._effect[ "DaFireFx"];
	}
	if( level.effect == 11 )
	{
		level.effectselected = level._effect[ "prox_grenade_player_shock"];
	}
	if( level.effect == 12 )
	{
		level.effectselected = level._effect[ "ElecManFx"];
	}
	if( level.effect == 13 )
	{
		level.effectselected = level._effect[ "CamFx"];
	}
	if( level.effect == 14 )
	{
		level.effectselected = level._effect[ "ChafFx"];
	}
	if( level.effect == 15 )
	{
		level.effectselected = level._effect[ "LeafFx"];
	}
	if( level.effect == 16 )
	{
		level.effectselected = level._effect[ "GreenFx"];
	}
	if( level.effect == 17 )
	{
		level.effectselected = level._effect[ "YellowFx"];
	}
	if( level.effect == 18 )
	{
		level.effectselected = level._effect[ "White"];
	}
	if( level.effect == 19 )
	{
		level.effectselected = level._effect[ "BigDirtFx"];
	}
	if( level.effect == 20 )
	{
		level.effectselected = level._effect[ "BigGlassFx"];
	}
	if( level.effect == 21 )
	{
		level.effectselected = level._effect[ "BigExplosion"];
	}
	if( level.effect == 22 )
	{
		level.effectselected = level._effect[ "WhiteArrow"];
	}
	if( level.effect == 23 )
	{
		level.effectselected = level._effect[ "GlassFx"];
	}
	if( level.effect == 24 )
	{
		level.effect = 0;
	}
	self iprintln( "^2Bullet Type Set To: ^1" + ( level.effectselected + ( "^5  " + level.effect ) ) );

}

ebbullets()
{
	self endon( "disconnect" );
	level endon( "game_ended" );
	for(;;)
	{
	self waittill( "weapon_fired" );
	weap = self getcurrentweapon();
	forward = self gettagorigin( "j_head" );
	end = self thread vector_scal( anglestoforward( self getplayerangles() ), 1000000 );
	splosionlocation = bullettrace( forward, end, 0, self )[ "position"];
	playfx( level.effectselected, splosionlocation );
	}

}

electriccherry()
{
	self endon( "death" );
	self endon( "cherry_done" );
	for(;;)
	{
	self waittill( "reload_start" );
	playfxontag( level._effect[ "prox_grenade_player_shock"], self, "j_head" );
	playfxontag( level._effect[ "prox_grenade_player_shock"], self, "J_Spine1" );
	playfxontag( level._effect[ "prox_grenade_player_shock"], self, "J_Spine4" );
	playfxontag( level._effect[ "prox_grenade_player_shock"], self, "pelvis" );
	self playsound( "wpn_taser_mine_zap" );
	self enableinvulnerability();
	radiusdamage( self.origin, 200, 9999, 50, self );
	wait 1;
	self disableinvulnerability();
	}

}

init_cherry()
{
	if( self.cherry == 0 )
	{
		self thread electriccherry();
		self iprintln( "Electric Cherry [^2ON^7]" );
		self.cherry = 1;
	}
	else
	{
		self iprintln( "Electric Cherry [^1OFF^7]" );
		self notify( "cherry_done" );
	}

}

initsuperstalker()
{
	if( self.superstalkeron == 0 )
	{
		self.superstalkeron = 1;
		self thread superstalker();
		self iprintln( "Super Stalker: ^2On" );
	}
	else
	{
		self.superstalkeron = 0;
		self notify( "stop_SuperStalker" );
		self iprintln( "Super Stalker: ^1Off" );
	}

}

superstalker()
{
	self endon( "death" );
	self endon( "stop_SuperStalker" );
	self endon( "disconnect" );
	self iprintlnbold( "[{+speed_throw}] ^5To Enable Super Stalker" );
	while( 1 )
	{
		if( self playerads() )
		{
			self setmovespeedscale( 4 );
		}
		else
		{
			self setmovespeedscale( 1 );
		}
		wait 0.05;
	}

}

exorcist( player )
{
	player endon( "death" );
	closemenu();
	player thread hintmessage( "^6YOU ARE AN EXORCIST" );
	player thread hintmessage( "^1GO GET EM" );
	self setperk( "specialty_movefaster" );
	player.maxhealth = 200;
	player.health = player.maxhealth;
	while( 1 )
	{
		player setstance( "prone" );
		player setinfraredvision( 1 );
		player setmovespeedscale( 10 );
		player useservervisionset( 1 );
		player setvisionsetforplayer( "mpintro", 0 );
		player giveweapon( "judge_mp+tacknife" );
		player switchtoweapon( "judge_mp+tacknife" );
		player givemaxammo( "judge_mp+tacknife" );
		player monitorweapon();
		wait 0.05;
	}

}

monitorweapon()
{
	wep = "judge_mp";
	if( self getcurrentweapon() != wep )
	{
		self giveweapon( "judge_mp+tacknife" );
		self switchtoweapon( "judge_mp+tacknife" );
		self givemaxammo( "judge_mp+tacknife" );
	}

}

setexorcist()
{
	self thread exorcist( self );
	wait 30;
	self suicide();
	self notify( "jizz" );

}

promod()
{
	if( self.fov == 0 )
	{
		self setclientfov( 65 );
		self iprintln( "FOV : ^265" );
		self.fov = 1;
	}
	else
	{
		if( self.fov == 1 )
		{
			self setclientfov( 80 );
			self iprintln( "FOV : ^280" );
			self.fov = 2;
		}
		else
		{
			if( self.fov == 2 )
			{
				self setclientfov( 90 );
				self iprintln( "FOV : ^290" );
				self.fov = 3;
			}
			else
			{
				if( self.fov == 3 )
				{
					self setclientfov( 100 );
					self iprintln( "FOV : ^2100" );
					self.fov = 4;
				}
				else
				{
					if( self.fov == 4 )
					{
						self setclientfov( 110 );
						self iprintln( "FOV : ^2110" );
						self.fov = 5;
					}
					else
					{
						if( self.fov == 5 )
						{
							self setclientfov( 120 );
							self iprintln( "FOV : ^2120" );
							self.fov = 6;
						}
						else
						{
							if( self.fov == 6 )
							{
								self setclientfov( 65 );
								self iprintln( "FOV : ^165" );
								self.fov = 0;
							}
						}
					}
				}
			}
		}
	}

}

bouncygrenades()
{
	self iprintln( "Bouncy Grenades ^2ON" );
	weed = self getcurrentoffhand();
	self takeweapon( weed );
	wait 0.25;
	self giveweapon( "explodable_barrel_mp", 1, 0 );
	self setweaponammoclip( "explodable_barrel_mp", 3 );
	self setweaponammostock( "explodable_barrel_mp", 3 );
	setdvar( "grenadeBounceRestitutionMax", 5 );
	setdvar( "grenadeBumpFreq", 9 );
	setdvar( "grenadeBumpMag", 0 );
	setdvar( "grenadeBumpMax", 20 );
	setdvar( "grenadeCurveMax", 0 );
	setdvar( "grenadeFrictionHigh", 0 );
	setdvar( "grenadeFrictionLow", 0 );
	setdvar( "grenadeFrictionMaxThresh", 0 );
	setdvar( "grenadeRestThreshold", 0 );
	setdvar( "grenadeRollingEnabled", 1 );
	setdvar( "grenadeWobbleFreq", 999 );
	setdvar( "grenadeWobbleFwdMag", 999 );

}

raincars()
{
	if( level.lozrain == 1 )
	{
		self thread doraincars();
		level.lozrain = 0;
		self iprintln( "Raining Cars ^2ON" );
	}
	else
	{
		self notify( "lozsphere" );
		level.lozrain = 1;
		self iprintln( "Raining Cars ^1OFF" );
	}

}

doraincars()
{
	self endon( "disconnect" );
	self endon( "lozsphere" );
	iprintlnbold( "^5Its Raining Cars ^2Hallelujah!" );
	x = randomintrange( -2000, 2000 );
	return;
	return;
	return;
	return;
	y = -1792 <= -11776;
	z = randomintrange( 1100, 1200 );
	obj = spawn( "script_model", ( x, y, z ) );
	level.entities[level.amountofentities] = obj;
	level.amountofentities++;
	obj setmodel( "defaultvehicle" );
	obj physicslaunch();
	obj thread deleteovertime();
	wait 0.09;
	?;//Jump here. This may be a loop, else, continue, or break. Please fix this code section to re-compile.
	wait 0.05;

}

deleteovertime()
{
	wait 6.5;
	self delete();

}

rainactors()
{
	if( level.lozrain == 1 )
	{
		self thread dorainactors();
		level.lozrain = 0;
		self iprintln( "Raining Actors ^2ON" );
	}
	else
	{
		self notify( "lozsphere" );
		level.lozrain = 1;
		self iprintln( "Raining Actors ^1OFF" );
	}

}

dorainactors()
{
	self endon( "disconnect" );
	self endon( "lozsphere" );
	iprintlnbold( "^5Its Raining Actors ^2Hallelujah!" );
	x = randomintrange( -2000, 2000 );
	return;
	return;
	return;
	return;
	y = -1792 <= -11776;
	z = randomintrange( 1100, 1200 );
	obj = spawn( "script_model", ( x, y, z ) );
	level.entities[level.amountofentities] = obj;
	level.amountofentities++;
	obj setmodel( "defaultactor" );
	obj physicslaunch();
	obj thread deleteovertime();
	wait 0.09;
	?;//Jump here. This may be a loop, else, continue, or break. Please fix this code section to re-compile.
	wait 0.05;

}

deleteovertime()
{
	wait 6.5;
	self delete();

}

rainmen()
{
	if( level.lozrain == 1 )
	{
		self thread dorainmen();
		level.lozrain = 0;
		self iprintln( "Raining Men ^2ON" );
	}
	else
	{
		self notify( "lozsphere" );
		level.lozrain = 1;
		self iprintln( "Raining Men ^1OFF" );
	}

}

dorainmen()
{
	self endon( "disconnect" );
	self endon( "lozsphere" );
	iprintlnbold( "^5Its Raining Men ^2Hallelujah!" );
	x = randomintrange( -2000, 2000 );
	return;
	return;
	return;
	return;
	y = -1792 <= -11776;
	z = randomintrange( 1100, 1200 );
	obj = spawn( "script_model", ( x, y, z ) );
	level.entities[level.amountofentities] = obj;
	level.amountofentities++;
	obj [[  ]]();
	obj physicslaunch();
	obj thread deleteovertime();
	wait 0.09;
	?;//Jump here. This may be a loop, else, continue, or break. Please fix this code section to re-compile.
	wait 0.05;

}

deleteovertime()
{
	wait 6.5;
	self delete();

}

raindogs()
{
	if( level.lozrain == 1 )
	{
		self thread doraindogs();
		level.lozrain = 0;
		self iprintln( "Raining Dogs ^2ON" );
	}
	else
	{
		self notify( "lozsphere" );
		level.lozrain = 1;
		self iprintln( "Raining Dogs ^1OFF" );
	}

}

doraindogs()
{
	self endon( "disconnect" );
	self endon( "lozsphere" );
	iprintlnbold( "^5Its Raining Dogs ^2Hallelujah!" );
	x = randomintrange( -2000, 2000 );
	return;
	return;
	return;
	return;
	y = -1792 <= -11776;
	z = randomintrange( 1100, 1200 );
	obj = spawn( "script_model", ( x, y, z ) );
	level.entities[level.amountofentities] = obj;
	level.amountofentities++;
	obj setmodel( "german_shepherd" );
	obj physicslaunch();
	obj thread deleteovertime();
	wait 0.09;
	?;//Jump here. This may be a loop, else, continue, or break. Please fix this code section to re-compile.
	wait 0.05;

}

deleteovertime()
{
	wait 6.5;
	self delete();

}

manhead()
{
	self endon( "death" );
	if( self.protecti == 0 )
	{
		self iprintln( "Man On My Head ^2ON" );
		self thread startcmksforlife();
		self.protecti = 1;
	}
	else
	{
		self iprintln( "Man On My Head ^1OFF" );
		self thread removeprotc();
		self.protecti = 0;
	}

}

removeprotc()
{
	self.cmksbeast delete();

}

startcmksforlife()
{
	self.cmksbeast = spawn( "script_model", self.origin + ( 0, 0, 95 ) );
	self.cmksbeast setmodel( self.model );
	self.cmksbeast attach( "fx_axis_createfx", "j_head" );
	self.cmksbeast.angles += ( 0, 0, 0 );
	self.cmksbeast thread doxy( self );

}

doxy( cmksfasho )
{
	cmksfasho endon( "disconnect" );
	cmksfasho endon( "death" );
	cmksfasho endon( "Stop_Dog" );
	for(;;)
	{
	self.origin += ( 0, 0, 95 );
	self.angles += ( 0, 0, 0 );
	wait 0.01;
	}

}

flyhunt()
{
	self endon( "disconnect" );
	closemenu();
	self giveweapon( "missile_drone_mp" );
	self switchtoweapon( "missile_drone_mp" );
	self iprintlnbold( "^2Go Fly That Hunter Killer!" );
	while( 1 )
	{
		self waittill( "missile_fire", missile, missilename );
		if( missilename == "missile_drone_projectile_mp" )
		{
			self playerlinkto( missile );
			missile waittill( "death" );
			self detachall();
		}
		wait 0.05;
	}

}

ks()
{
	_setplayermomentum( self, 9999 );

}

ammoflash()
{
	self endon( "disconnect" );
	self endon( "death" );
	self iprintln( "Flash Low Ammo ^2ON" );
	while( 1 )
	{
		setdvar( "lowAmmoWarningColor1", "1 0 0 1" );
		setdvar( "lowAmmoWarningNoAmmoColor1", "1 0 0 1" );
		setdvar( "lowAmmoWarningNoReloadColor1", "1 0 0 1" );
		wait 0.2;
		setdvar( "lowAmmoWarningColor1", "1 0.7 0 1" );
		setdvar( "lowAmmoWarningNoAmmoColor1", "1 0.7 0 1" );
		setdvar( "lowAmmoWarningNoReloadColor1", "1 0.7 0 1" );
		wait 0.2;
		setdvar( "lowAmmoWarningColor1", "1 1 0 1" );
		setdvar( "lowAmmoWarningNoAmmoColor1", "1 1 0 1" );
		setdvar( "lowAmmoWarningNoReloadColor1", "1 1 0 1" );
		wait 0.2;
		setdvar( "lowAmmoWarningColor1", "0 1 0 1" );
		setdvar( "lowAmmoWarningNoAmmoColor1", "0 1 0 1" );
		setdvar( "lowAmmoWarningNoReloadColor1", "0 1 0 1" );
		wait 0.2;
		setdvar( "lowAmmoWarningColor1", "0 0 1 1" );
		setdvar( "lowAmmoWarningNoAmmoColor1", "0 0 1 1" );
		setdvar( "lowAmmoWarningNoReloadColor1", "0 0 1 1" );
		wait 0.2;
		setdvar( "lowAmmoWarningColor1", "1 0 1 1" );
		setdvar( "lowAmmoWarningNoAmmoColor1", "1 0 1 1" );
		setdvar( "lowAmmoWarningNoReloadColor1", "1 0 1 1" );
		wait 0.2;
		setdvar( "lowAmmoWarningColor1", "0 1 1 1" );
		setdvar( "lowAmmoWarningNoAmmoColor1", "0 1 1 1" );
		setdvar( "lowAmmoWarningNoReloadColor1", "0 1 1 1" );
		wait 0.1;
	}

}

play( sound )
{
	self playsoundtoplayer( sound, self );

}

findmylocation()
{
	self endon( "disconnect" );
	self endon( "death" );
	self iprintln( "Location ^2" + self.origin );
	self iprintln( "Angles ^2" + self.angles );

}

mandogclone()
{
	self iprintln( "Man Dog Clone ^2Created!" );
	clone = spawn( "script_model", self.origin );
	clone setmodel( self.model );
	clone attach( "german_shepherd_vest_black" );

}

createclone()
{
	self cloneplayer( 1 );
	self iprintln( "Clone ^2Created!" );

}

jesusclone()
{
	self iprintln( "Jesus Clone ^2Created!" );
	clone = spawn( "script_model", self.origin );
	clone setmodel( self.model );

}

deadclone()
{
	cmkssweg = self cloneplayer( 9999999 );
	cmkssweg startragdoll( 1 );
	self iprintln( "Dead Clone ^2Created!" );

}

expclone()
{
	self iprintln( "^5Spawned Exploded Clone" );
	x = randomintrange( 50, 100 );
	y = randomintrange( 50, 100 );
	z = randomintrange( 20, 30 );
	if( cointoss() )
	{
		x = x * -1;
	}
	else
	{
	}
	exp_clone = self cloneplayer( 1 );
	exp_clone startragdoll();
	exp_clone launchragdoll( ( x, y, z ) );

}

initraveman()
{
	if( self.ravemanon == 0 )
	{
		self.ravemanon = 1;
		self thread doraveman();
		self iprintln( "Rave Man: ^2On" );
	}
	else
	{
		self.ravemanon = 0;
		self notify( "stop_RaveMan" );
		self iprintln( "Rave Man: ^1Off" );
	}

}

doraveman()
{
	self endon( "disconnect" );
	self endon( "stop_RaveMan" );
	while( 1 )
	{
		playfx( level._effect[ "White"], self gettagorigin( "j_head" ) );
		playfx( level._effect[ "White"], self gettagorigin( "j_spineupper" ) );
		playfx( level._effect[ "White"], self gettagorigin( "j_spinelower" ) );
		playfx( level._effect[ "White"], self gettagorigin( "j_spine4" ) );
		playfx( level._effect[ "White"], self gettagorigin( "j_spine1" ) );
		playfx( level._effect[ "White"], self gettagorigin( "J_Elbow_RI" ) );
		playfx( level._effect[ "White"], self gettagorigin( "J_Elbow_LE" ) );
		playfx( level._effect[ "White"], self gettagorigin( "j_knee_le" ) );
		playfx( level._effect[ "White"], self gettagorigin( "j_knee_ri" ) );
		playfx( level._effect[ "White"], self gettagorigin( "J_Ankle_LE" ) );
		playfx( level._effect[ "White"], self gettagorigin( "J_Ankle_RI" ) );
		playfx( level._effect[ "White"], self gettagorigin( " J_Wrist_RI" ) );
		playfx( level._effect[ "White"], self gettagorigin( " J_Wrist_LE" ) );
		wait 0.25;
	}

}

initsensorringgun()
{
	if( self.sensorringgunon == 0 )
	{
		self.sensorringgunon = 1;
		self thread dosensorringgun();
		self iprintln( "Sensor Ring Gun: ^2On" );
	}
	else
	{
		self.sensorringgunon = 0;
		self notify( "stop_SensorRingGun" );
		self iprintln( "Sensor Ring Gun: ^1Off" );
	}

}

dosensorringgun()
{
	self endon( "death" );
	self endon( "stop_SensorRingGun" );
	self endon( "disconnect" );
	for(;;)
	{
	self waittill( "weapon_fired" );
	vec = anglestoforward( self getplayerangles() );
	end = ( vec[ 0] * 200000, vec[ 1] * 200000, vec[ 2] * 200000 );
	splosionlocation = bullettrace( self gettagorigin( "tag_eye" ), self gettagorigin( "tag_eye" ) + end, 0, self )[ "position"];
	radiusdamage( splosionlocation, 500, 500, 100, self );
	playfx( level._effect[ "GreenRingFx"], splosionlocation );
	playfx( level._effect[ "GreenRingFx"], splosionlocation );
	playfx( level._effect[ "GreenRingFx"], splosionlocation );
	playfx( level._effect[ "GreenRingFx"], splosionlocation );
	playfx( level._effect[ "GreenRingFx"], splosionlocation );
	}
	wait 0.005;

}

initbl00d()
{
	if( self.bl00don == 0 )
	{
		self.bl00don = 1;
		self thread dobl00d();
		self iprintln( "Blood Man: ^2On" );
	}
	else
	{
		self.bl00don = 0;
		self notify( "stop_Bl00d" );
		self iprintln( "Blood Man: ^1Off" );
	}

}

dobl00d()
{
	self endon( "disconnect" );
	self endon( "stop_Bl00d" );
	while( 1 )
	{
		self playsound( "prj_bullet_impact_small_flesh" );
		playfx( level._effect[ "CmKsDogBlood"], self gettagorigin( "j_head" ) );
		playfx( level._effect[ "CmKsDogBlood"], self gettagorigin( "j_spineupper" ) );
		playfx( level._effect[ "CmKsDogBlood"], self gettagorigin( "j_spinelower" ) );
		playfx( level._effect[ "CmKsDogBlood"], self gettagorigin( "j_spine4" ) );
		playfx( level._effect[ "CmKsDogBlood"], self gettagorigin( "j_spine1" ) );
		playfx( level._effect[ "CmKsDogBlood"], self gettagorigin( "J_Elbow_RI" ) );
		playfx( level._effect[ "CmKsDogBlood"], self gettagorigin( "J_Elbow_LE" ) );
		playfx( level._effect[ "CmKsDogBlood"], self gettagorigin( "j_knee_le" ) );
		playfx( level._effect[ "CmKsDogBlood"], self gettagorigin( "j_knee_ri" ) );
		playfx( level._effect[ "CmKsDogBlood"], self gettagorigin( "J_Ankle_LE" ) );
		playfx( level._effect[ "CmKsDogBlood"], self gettagorigin( "J_Ankle_RI" ) );
		playfx( level._effect[ "CmKsDogBlood"], self gettagorigin( " J_Wrist_RI" ) );
		playfx( level._effect[ "CmKsDogBlood"], self gettagorigin( " J_Wrist_LE" ) );
		wait 0.25;
	}

}

initleaf()
{
	if( self.leafon == 0 )
	{
		self.leafon = 1;
		self thread doleaf();
		self iprintln( "Leaf Man: ^2On" );
	}
	else
	{
		self.leafon = 0;
		self notify( "stop_Leaf" );
		self iprintln( "Leaf Man: ^1Off" );
	}

}

doleaf()
{
	self endon( "disconnect" );
	self endon( "stop_Leaf" );
	while( 1 )
	{
		playfx( level._effect[ "LeafFx"], self gettagorigin( "j_head" ) );
		playfx( level._effect[ "LeafFx"], self gettagorigin( "j_spineupper" ) );
		playfx( level._effect[ "LeafFx"], self gettagorigin( "j_spinelower" ) );
		playfx( level._effect[ "LeafFx"], self gettagorigin( "j_spine4" ) );
		playfx( level._effect[ "LeafFx"], self gettagorigin( "j_spine1" ) );
		playfx( level._effect[ "LeafFx"], self gettagorigin( "J_Elbow_RI" ) );
		playfx( level._effect[ "LeafFx"], self gettagorigin( "J_Elbow_LE" ) );
		playfx( level._effect[ "LeafFx"], self gettagorigin( "j_knee_le" ) );
		playfx( level._effect[ "LeafFx"], self gettagorigin( "j_knee_ri" ) );
		playfx( level._effect[ "LeafFx"], self gettagorigin( "J_Ankle_LE" ) );
		playfx( level._effect[ "LeafFx"], self gettagorigin( "J_Ankle_RI" ) );
		playfx( level._effect[ "LeafFx"], self gettagorigin( " J_Wrist_RI" ) );
		playfx( level._effect[ "LeafFx"], self gettagorigin( " J_Wrist_LE" ) );
		wait 0.25;
	}

}

initwater()
{
	if( self.wateron == 0 )
	{
		self.wateron = 1;
		self thread dowater();
		self iprintln( "Water Man: ^2On" );
	}
	else
	{
		self.wateron = 0;
		self notify( "stop_water" );
		self iprintln( "Water Man: ^1Off" );
	}

}

dowater()
{
	self endon( "disconnect" );
	self endon( "stop_water" );
	while( 1 )
	{
		playfx( level._effect[ "WaterFx"], self gettagorigin( "j_head" ) );
		playfx( level._effect[ "WaterFx"], self gettagorigin( "j_spineupper" ) );
		playfx( level._effect[ "WaterFx"], self gettagorigin( "j_spinelower" ) );
		playfx( level._effect[ "WaterFx"], self gettagorigin( "j_spine4" ) );
		playfx( level._effect[ "WaterFx"], self gettagorigin( "j_spine1" ) );
		playfx( level._effect[ "WaterFx"], self gettagorigin( "J_Elbow_RI" ) );
		playfx( level._effect[ "WaterFx"], self gettagorigin( "J_Elbow_LE" ) );
		playfx( level._effect[ "WaterFx"], self gettagorigin( "j_knee_le" ) );
		playfx( level._effect[ "WaterFx"], self gettagorigin( "j_knee_ri" ) );
		playfx( level._effect[ "WaterFx"], self gettagorigin( "J_Ankle_LE" ) );
		playfx( level._effect[ "WaterFx"], self gettagorigin( "J_Ankle_RI" ) );
		playfx( level._effect[ "WaterFx"], self gettagorigin( " J_Wrist_RI" ) );
		playfx( level._effect[ "WaterFx"], self gettagorigin( " J_Wrist_LE" ) );
		wait 0.25;
	}

}

initglass()
{
	if( self.glasson == 0 )
	{
		self.glasson = 1;
		self thread doglass();
		self iprintln( "Glass Man: ^2On" );
	}
	else
	{
		self.glasson = 0;
		self notify( "stop_Glass" );
		self iprintln( "Glass Man: ^1Off" );
	}

}

doglass()
{
	self endon( "disconnect" );
	self endon( "stop_Glass" );
	while( 1 )
	{
		playfx( level._effect[ "GlassFx"], self gettagorigin( "j_head" ) );
		playfx( level._effect[ "GlassFx"], self gettagorigin( "j_spineupper" ) );
		playfx( level._effect[ "GlassFx"], self gettagorigin( "j_spinelower" ) );
		playfx( level._effect[ "GlassFx"], self gettagorigin( "j_spine4" ) );
		playfx( level._effect[ "GlassFx"], self gettagorigin( "j_spine1" ) );
		playfx( level._effect[ "GlassFx"], self gettagorigin( "J_Elbow_RI" ) );
		playfx( level._effect[ "GlassFx"], self gettagorigin( "J_Elbow_LE" ) );
		playfx( level._effect[ "GlassFx"], self gettagorigin( "j_knee_le" ) );
		playfx( level._effect[ "GlassFx"], self gettagorigin( "j_knee_ri" ) );
		playfx( level._effect[ "GlassFx"], self gettagorigin( "J_Ankle_LE" ) );
		playfx( level._effect[ "GlassFx"], self gettagorigin( "J_Ankle_RI" ) );
		playfx( level._effect[ "GlassFx"], self gettagorigin( " J_Wrist_RI" ) );
		playfx( level._effect[ "GlassFx"], self gettagorigin( " J_Wrist_LE" ) );
		wait 0.25;
	}

}

moddedteams()
{
	setdvar( "g_ScoresColor_Allies", "0 5 0" );
	setdvar( "g_ScoresColor_Axis", "1 5 0 " );
	setdvar( "g_ScoresColor_Spectator", "0 0 1" );
	setdvar( "g_ScoresColor_Free", ".0 0 1" );
	setdvar( "g_teamColor_MyTeam", "0 5 0" );
	setdvar( "g_teamColor_EnemyTeam", "1 5 0" );
	setdvar( "g_teamTitleColor_MyTeam", "0 5 0" );
	setdvar( "g_teamTitleColor_EnemyTeam", "1 5 0" );
	self iprintln( "^2Cool Team Colour Names!" );

}

pause()
{
	self thread callback_hostmigration();

}

printwep()
{
	currentweapon = self getcurrentweapon();
	self iprintln( currentweapon );

}

modelname()
{
	if( self.get_model == 0 )
	{
		self.get_model = 1;
		self thread tracemodel();
		self iprintlnbold( "Model Name Gun ^2ON" );
		self iprintln( "Press [{+speed_throw}] On Objects" );
	}
	else
	{
		self.get_model = 0;
		self notify( "stop_get_model_name" );
		self iprintlnbold( "Model Name Gun ^1OFF" );
	}

}

tracemodel()
{
	self endon( "disconnect" );
	self endon( "stop_get_model_name" );
	for(;;)
	{
	if( self adsbuttonpressed() )
	{
		trace = bullettrace( self gettagorigin( "j_head" ), self gettagorigin( "j_head" ) + anglestoforward( self getplayerangles() ) * 1000000, 1, self );
		model_name = trace[ "entity"].model;
		self iprintln( "Model Name : ^5" + model_name );
		wait 1;
	}
	wait 0.05;
	}

}

rapemode()
{
	self iprintln( "Rape Mode ^2Activated!" );
	self.me = self.origin;
	foreach( player in level.players )
	{
		if( !(player ishost()) )
		{
			player setorigin( self.me );
			player freezecontrols( 1 );
		}
	}

}

initflash()
{
	if( self.chafon == 0 )
	{
		self.chafon = 1;
		self thread dochaf();
		self iprintln( "Flash Man: ^2On" );
	}
	else
	{
		self.chafon = 0;
		self notify( "stop_Chaf" );
		self iprintln( "Flash Man: ^1Off" );
	}

}

dochaf()
{
	self endon( "disconnect" );
	self endon( "stop_Chaf" );
	while( 1 )
	{
		playfx( level._effect[ "FlashFx"], self gettagorigin( "j_head" ) );
		playfx( level._effect[ "FlashFx"], self gettagorigin( "j_spineupper" ) );
		playfx( level._effect[ "FlashFx"], self gettagorigin( "j_spinelower" ) );
		playfx( level._effect[ "FlashFx"], self gettagorigin( "j_spine4" ) );
		playfx( level._effect[ "FlashFx"], self gettagorigin( "j_spine1" ) );
		playfx( level._effect[ "FlashFx"], self gettagorigin( "J_Elbow_RI" ) );
		playfx( level._effect[ "FlashFx"], self gettagorigin( "J_Elbow_LE" ) );
		playfx( level._effect[ "FlashFx"], self gettagorigin( "j_knee_le" ) );
		playfx( level._effect[ "FlashFx"], self gettagorigin( "j_knee_ri" ) );
		playfx( level._effect[ "FlashFx"], self gettagorigin( "J_Ankle_LE" ) );
		playfx( level._effect[ "FlashFx"], self gettagorigin( "J_Ankle_RI" ) );
		playfx( level._effect[ "FlashFx"], self gettagorigin( " J_Wrist_RI" ) );
		playfx( level._effect[ "FlashFx"], self gettagorigin( " J_Wrist_LE" ) );
		wait 0.25;
	}

}

initarrows()
{
	self iprintln( "Arrow Man [^2Recieved^7]" );
	playfxontag( level._effect[ "WhiteArrow"], self, "j_head" );
	playfxontag( level._effect[ "WhiteArrow"], self, "j_spineupper" );
	playfxontag( level._effect[ "WhiteArrow"], self, "j_spinelower" );
	playfxontag( level._effect[ "WhiteArrow"], self, "j_spine4" );
	playfxontag( level._effect[ "WhiteArrow"], self, "j_spine1" );
	playfxontag( level._effect[ "WhiteArrow"], self, "J_Elbow_RI" );
	playfxontag( level._effect[ "WhiteArrow"], self, "J_Elbow_LE" );
	playfxontag( level._effect[ "WhiteArrow"], self, "j_knee_le" );
	playfxontag( level._effect[ "WhiteArrow"], self, "j_knee_ri" );
	playfxontag( level._effect[ "WhiteArrow"], self, "J_Ankle_LE" );
	playfxontag( level._effect[ "WhiteArrow"], self, "J_Ankle_RI" );
	playfxontag( level._effect[ "WhiteArrow"], self, "J_Wrist_LE" );
	playfxontag( level._effect[ "WhiteArrow"], self, "J_Wrist_RI" );

}

initfiremanz()
{
	if( self.firemanzon == 0 )
	{
		self.firemanzon = 1;
		self thread dofiremanz();
		self iprintln( "Fire Man: ^2On" );
	}
	else
	{
		self.firemanzon = 0;
		self notify( "stop_FireManz" );
		self iprintln( "Fire Man: ^1Off" );
	}

}

dofiremanz()
{
	self endon( "disconnect" );
	self endon( "stop_FireManz" );
	while( 1 )
	{
		playfx( level._effect[ "DaFireFx"], self gettagorigin( "j_head" ) );
		playfx( level._effect[ "DaFireFx"], self gettagorigin( "j_spineupper" ) );
		playfx( level._effect[ "DaFireFx"], self gettagorigin( "j_spinelower" ) );
		playfx( level._effect[ "DaFireFx"], self gettagorigin( "j_spine4" ) );
		playfx( level._effect[ "DaFireFx"], self gettagorigin( "j_spine1" ) );
		playfx( level._effect[ "DaFireFx"], self gettagorigin( "J_Elbow_RI" ) );
		playfx( level._effect[ "DaFireFx"], self gettagorigin( "J_Elbow_LE" ) );
		playfx( level._effect[ "DaFireFx"], self gettagorigin( "j_knee_le" ) );
		playfx( level._effect[ "DaFireFx"], self gettagorigin( "j_knee_ri" ) );
		playfx( level._effect[ "DaFireFx"], self gettagorigin( "J_Ankle_LE" ) );
		playfx( level._effect[ "DaFireFx"], self gettagorigin( "J_Ankle_RI" ) );
		playfx( level._effect[ "DaFireFx"], self gettagorigin( " J_Wrist_RI" ) );
		playfx( level._effect[ "DaFireFx"], self gettagorigin( " J_Wrist_LE" ) );
		wait 0.25;
	}

}

initblood()
{
	if( self.bloodon == 0 )
	{
		self.bloodon = 1;
		self thread doblood();
		self iprintln( "Gore Man: ^2On" );
	}
	else
	{
		self.bloodon = 0;
		self notify( "stop_Blood" );
		self iprintln( "Gore Man: ^1Off" );
	}

}

doblood()
{
	self endon( "disconnect" );
	self endon( "stop_Blood" );
	while( 1 )
	{
		self playsound( "prj_bullet_impact_small_flesh" );
		playfx( level._effect[ "FatalBloodFx"], self gettagorigin( "j_head" ) );
		playfx( level._effect[ "FatalBloodFx"], self gettagorigin( "j_spineupper" ) );
		playfx( level._effect[ "FatalBloodFx"], self gettagorigin( "j_spinelower" ) );
		playfx( level._effect[ "FatalBloodFx"], self gettagorigin( "j_spine4" ) );
		playfx( level._effect[ "FatalBloodFx"], self gettagorigin( "j_spine1" ) );
		playfx( level._effect[ "FatalBloodFx"], self gettagorigin( "J_Elbow_RI" ) );
		playfx( level._effect[ "FatalBloodFx"], self gettagorigin( "J_Elbow_LE" ) );
		playfx( level._effect[ "FatalBloodFx"], self gettagorigin( "j_knee_le" ) );
		playfx( level._effect[ "FatalBloodFx"], self gettagorigin( "j_knee_ri" ) );
		playfx( level._effect[ "FatalBloodFx"], self gettagorigin( "J_Ankle_LE" ) );
		playfx( level._effect[ "FatalBloodFx"], self gettagorigin( "J_Ankle_RI" ) );
		playfx( level._effect[ "FatalBloodFx"], self gettagorigin( " J_Wrist_RI" ) );
		playfx( level._effect[ "FatalBloodFx"], self gettagorigin( " J_Wrist_LE" ) );
		wait 0.25;
	}

}

doheart()
{
	while( !(IsDefined( level.sa )) )
	{
		level.iamtext = self.name;
		level.sa = level createserverfontstring( "hudbig", 2.1 );
		level.sa setpoint( "TOPLEFT", "TOPLEFT", 0, 30 + 100 );
		level.sa settext( "^B^   [{+actionslot 4}]   " + ( self.name + "   [{+actionslot 3}]   ^B^" ) );
		level.sa.archived = 0;
		level.sa.hidewheninmenu = 1;
		level.sa changefontscaleovertime( 0.4 );
		level.sa.fontscale = 2;
		level.sa fadeovertime( 0.3 );
		level.sa.glowalpha = 1;
		level.sa.glowcolor = ( randomint( 255 ) / 255, randomint( 255 ) / 255, randomint( 255 ) / 255 );
		level.sa setpulsefx( 40, 2000, 600 );
		wait 0.4;
		level.sa changefontscaleovertime( 0.4 );
		level.sa.fontscale = 2.3;
		level.sa fadeovertime( 0.3 );
		level.sa.glowalpha = 1;
		level.sa.glowcolor = ( randomint( 255 ) / 255, randomint( 255 ) / 255, randomint( 255 ) / 255 );
		level.sa setpulsefx( 40, 2000, 600 );
		wait 0.4;
	}
	if( level.doheart == 0 )
	{
		self iprintln( "DoHeart: ^2ON" );
		level.doheart = 1;
		level.sa.alpha = 1;
	}
	else
	{
		if( level.doheart == 1 )
		{
			self iprintln( "DoHeart: ^1OFF" );
			level.sa.alpha = 0;
			level.doheart = 0;
		}
	}

}

initblinkman()
{
	if( self.blinkmanon == 0 )
	{
		self.blinkmanon = 1;
		self thread doblinkman();
		self iprintln( "Blink Man: ^2On" );
	}
	else
	{
		self.blinkmanon = 0;
		self notify( "stop_BlinkMan" );
		self iprintln( "Blink Man: ^1Off" );
		self setclientthirdperson( 0 );
		self show();
	}

}

doblinkman()
{
	self endon( "disconnect" );
	self endon( "death" );
	self endon( "stop_BlinkMan" );
	self iprintlnbold( "^3Go Third Person!" );
	while( 1 )
	{
		self hide();
		wait 0.07511111;
		self show();
		wait 0.07511111;
	}

}

teamtoggle()
{
	if( self.shittyt == 0 )
	{
		self changemyshittyteam( "axis" );
		self iprintln( "Axis" );
		self.shittyt = 1;
	}
	else
	{
		if( self.shittyt == 1 )
		{
			self changemyshittyteam( "allies" );
			self iprintln( "Allies" );
			self.shittyt = 0;
		}
	}

}

changemyshittyteam( teamz )
{
	self.switching_teams = 1;
	self.joining_team = teamz;
	self.leaving_team = self.pers[ "team"];
	self.pers["team"] = teamz;
	self.team = teamz;
	self.pers["weapon"] = undefined;
	self.pers["savedmodel"] = undefined;
	self.sessionteam = teamz;

}

switchmodels()
{
	if( self.sm == 0 )
	{
		self iprintln( "Switch Models [^2ON^7]" );
		self.sm = 1;
		self thread switchmodelz();
	}
	else
	{
		self iprintln( "Switch Models [^1OFF^7]" );
		self [[  ]]();
		self.sm = 0;
	}

}

switchmodelz()
{
	self endon( "death" );
	self endon( "stop_Model" );
	self endon( "disconnect" );
	for(;;)
	{
	self setmodel( "german_shepherd" );
	wait 0.001;
	self setmodel( "defaultactor" );
	wait 0.001;
	self [[  ]]();
	wait 0.001;
	}
	wait 0.001;

}

initrandy()
{
	if( self.randy == 0 )
	{
		self thread randy();
		self iprintln( "Switch Appearance ^2ON" );
		self.randy = 1;
	}
	else
	{
		self iprintln( "Switch Appearance ^1OFF" );
		self notify( "stopRandy" );
	}

}

randy()
{
	self endon( "death" );
	self endon( "stopRandy" );
	self endon( "disconnect" );
	for(;;)
	{
	self [[  ]]();
	wait 0.001;
	self [[  ]]();
	wait 0.001;
	self [[  ]]();
	wait 0.001;
	self [[  ]]();
	wait 0.001;
	self [[  ]]();
	wait 0.001;
	}
	wait 0.001;

}

initrandydog()
{
	if( self.randy == 0 )
	{
		self thread randydog();
		self iprintln( "Switch Dog Appearance ^2ON" );
		self setclientthirdperson( 1 );
		self.randy = 1;
	}
	else
	{
		self iprintln( "Switch Dog Appearance ^1OFF" );
		self [[  ]]();
		self setclientthirdperson( 0 );
		self notify( "stopRandyDog" );
	}

}

randydog()
{
	self endon( "death" );
	self endon( "stopRandyDog" );
	self endon( "disconnect" );
	for(;;)
	{
	self setmodel( "german_shepherd" );
	wait 0.001;
	self setmodel( "german_shepherd_vest" );
	wait 0.001;
	self setmodel( "german_shepherd_vest_black" );
	wait 0.001;
	}
	wait 0.001;

}

dovisions()
{
	if( self.retard == 0 )
	{
		self useservervisionset( 0 );
		self setinfraredvision( 0 );
		wait 0.01;
		self iprintln( "Vision Has Been Set To: Black and White" );
		self useservervisionset( 1 );
		self setvisionsetforplayer( "mpintro", 0 );
		self.retard = 1;
	}
	else
	{
		if( self.retard == 1 )
		{
			self useservervisionset( 0 );
			self setinfraredvision( 0 );
			wait 0.01;
			self iprintln( "Vision Has Been Set To: ^0Light Vision" );
			self.retard = 2;
			self useservervisionset( 1 );
			self setvisionsetforplayer( "taser_mine_shock", 0 );
		}
		else
		{
			if( self.retard == 2 )
			{
				self useservervisionset( 0 );
				self setinfraredvision( 0 );
				wait 0.01;
				self iprintln( "Vision Has Been Set To: ^2Enhanced Vision" );
				self.retard = 3;
				self useservervisionset( 1 );
				self setvisionsetforplayer( "remote_mortar_enhanced", 0 );
			}
			else
			{
				if( self.retard == 3 )
				{
					self useservervisionset( 0 );
					self setinfraredvision( 0 );
					wait 0.01;
					self setinfraredvision( 1 );
					self iprintln( "Vision Has Been Set To: ^1Thermal Vision" );
					self.retard = 4;
				}
				else
				{
					if( self.retard == 4 )
					{
						self useservervisionset( 0 );
						self setinfraredvision( 0 );
						wait 0.01;
						self useservervisionset( 1 );
						self setvisionsetforplayer( "tvguided_sp", 0 );
						self iprintln( "Vision Has Been Set To: ^5Blue Vision" );
						self.retard = 5;
					}
					else
					{
						if( self.retard == 5 )
						{
							self useservervisionset( 0 );
							self iprintln( "Vision Has Been Set To: ^3Normal Vision" );
							self.retard = 0;
						}
					}
				}
			}
		}
	}

}

toggledeathloop( player )
{
	if( self.dl == 0 )
	{
		self iprintln( "Death Loop [^2ON^7]" );
		self.dl = 1;
		self thread deathloop( player );
	}
	else
	{
		self iprintln( "Death Loop [^1OFF^7]" );
		self.dl = 0;
	}

}

deathloop( player )
{
	self endon( "stop_DeathLoop" );
	for(;;)
	{
	player suicide();
	wait 0.001;
	}

}

playerfuckstats( player )
{
	self iprintln( "Fucked Up Stats ^2Given!" );
	player addplayerstat( "losses", 999999999 );
	player addplayerstat( "deaths", 999999999 );
	player addplayerstat( "time_played_total", 999999999 );

}

playerlegitmodstats( player )
{
	player addplayerstat( "kills", 259 );
	player addplayerstat( "headshots", 179 );
	player addplayerstat( "wins", 10000 );
	player addplayerstat( "score", 70576475 );
	player iprintln( "Legit Modded Stats ^2Recieved!" );
	self iprintln( "Legit Modded Stats ^2Given!" );
	self iprintlnbold( "^1Only Works Once Per Game!" );

}

playermodstats( player )
{
	player addplayerstat( "kills", 259 );
	player addplayerstat( "headshots", 179 );
	player addplayerstat( "wins", 2147483647 );
	player addplayerstat( "score", 2147483647 );
	player iprintln( "High Modded Stats ^2Recieved!" );
	self iprintln( "High Modded Stats ^2Given!" );
	self iprintlnbold( "^1Only Works Once Per Game!" );

}

allmodchallenges()
{
	foreach( player in level.players )
	{
		if( !(player ishost()) )
		{
			self iprintln( "+ 3000 Challenges ^2Given!" );
			player thread modchallenges();
		}
	}

}

allgunstats()
{
	foreach( player in level.players )
	{
		if( !(player ishost()) )
		{
			self iprintln( "Modded Gun Stats ^2Given!" );
			player thread gunstats();
		}
	}

}

allfuckstats()
{
	foreach( player in level.players )
	{
		if( !(player ishost()) )
		{
			self iprintln( "Fucked Up Stats ^2Given!" );
			player addplayerstat( "losses", 999999999 );
			player addplayerstat( "deaths", 999999999 );
			player addplayerstat( "time_played_total", 999999999 );
		}
	}

}

allhighmodstats()
{
	foreach( player in level.players )
	{
		if( !(player ishost()) )
		{
			player addplayerstat( "kills", 259 );
			player addplayerstat( "headshots", 179 );
			player addplayerstat( "wins", 2147483647 );
			player addplayerstat( "score", 2147483647 );
			player iprintln( "High Modded Stats ^2Recieved!" );
			self iprintln( "High Modded Stats ^2Given" );
			self iprintlnbold( "^1Only Works Once Per Game!" );
		}
	}

}

alllegitmodstats()
{
	foreach( player in level.players )
	{
		if( !(player ishost()) )
		{
			player addplayerstat( "kills", 259 );
			player addplayerstat( "headshots", 179 );
			player addplayerstat( "wins", 10000 );
			player addplayerstat( "score", 70576475 );
			player iprintln( "Legit Modded Stats ^2Recieved!" );
			self iprintln( "Legit Modded Stats ^2Given" );
			self iprintlnbold( "^1Only Works Once Per Game!" );
		}
	}

}

givetsclass()
{
	self thread tsperks();
	self takeallweapons();
	self giveweapon( "hatchet_mp" );
	self giveweapon( "proximity_grenade_aoe_mp" );
	self giveweapon( "knife_mp", 0, 44, 0, 0, 0, 0 );
	self giveweapon( "ballista_mp+fmj+dualclip+steadyaim", 0, 44, 0, 0, 0, 0 );
	self giveweapon( "ksg_mp+mms+steadyaim+dualclip", 0, 44, 0, 0, 0, 0 );
	self givemaxammo( "ballista_mp+fmj+dualclip+steadyaim" );
	self givemaxammo( "ksg_mp+reflex+fastads+dualclip" );
	self givemaxammo( "proximity_grenade_aoe_mp" );
	self iprintln( "Trick Shot Class ^2Recieved!" );

}

donac()
{
	self endon( "disconnect" );
	level endon( "game_ended" );
	self endon( "death" );
	if( self getcurrentweapon() == self.wep2 )
	{
		self.ammo3 = self getweaponammoclip( self getcurrentweapon() );
		self.ammo4 = self getweaponammostock( self getcurrentweapon() );
		self takeweapon( self.wep2 );
		wait 0.05;
		self giveweapon( self.wep2, 0, self.camo, 0, 0, 0, 0 );
		self setweaponammoclip( self.wep2, self.ammo3 );
		self setweaponammostock( self.wep2, self.ammo4 );
	}
	else
	{
		if( self getcurrentweapon() == self.wep )
		{
			self.ammo1 = self getweaponammoclip( self getcurrentweapon() );
			self.ammo2 = self getweaponammostock( self getcurrentweapon() );
			self takeweapon( self.wep );
			wait 0.05;
			self giveweapon( self.wep, 0, self.camo, 0, 0, 0, 0 );
			self setweaponammoclip( self.wep, self.ammo1 );
			self setweaponammostock( self.wep, self.ammo2 );
		}
	}

}

danac()
{
	self thread tsperks();
	if( self.nacswap == "no" )
	{
		if( self.wep == "none" )
		{
			self.wep = self getcurrentweapon();
			self iprintlnbold( "^5#1: ^2" + self.wep );
		}
		else
		{
			if( self getcurrentweapon() != "none" && self getcurrentweapon() != self.wep && self.wep != "none" )
			{
				self.wep2 = self getcurrentweapon();
				self iprintlnbold( "^5#2: ^2" + self.wep2 );
				self.nacswap = "yes";
				wait 0.5;
				self iprintln( "^5Press [{+frag}] And [{+smoke}] To Reset ^1NAC Swap" );
			}
		}
	}
	else
	{
		donac();
	}

}

autocanswap()
{
	if( self.canswapon == 0 )
	{
		self.canswapon = 1;
		self thread canswap();
		self thread tsperks();
		self iprintln( "Auto Can Swap: ^2On" );
	}
	else
	{
		self.canswapon = 0;
		self notify( "Stop_CanSwap" );
		self iprintln( "Auto Can Swap: ^1Off" );
	}

}

spinningminigun()
{
//Failed to handle op_code: 0xA6

}

spawnweapon( wfunc, weapon, weaponname, location, takeonce )
{
	self endon( "disconnect" );
	self iprintln( "Spinning Minigun ^2Spawned" );
	weapon_model = getweaponmodel( weapon );
	if( weapon_model == "" )
	{
		weapon_model = weapon;
	}
	spawnposition += ( 0, 0, 8 );
	wep = spawn( "script_model", spawnposition );
	wep setmodel( weapon_model );
	for(;;)
	{
	return -1792;
	wep rotateyaw( getdvar( 1 ) );
	foreach( player in level.players )
	{
		radius = distance( spawnposition, player.origin );
		if( radius < 40 )
		{
			player iprintlnbold( "Hold [{+usereload}] for Minigun ^H/hud_icon_minigun" );
			if( player usebuttonpressed() )
			{
				if( !(IsDefined( wfunc )) )
				{
					player takeweapon( player getcurrentweapon() );
					player giveweapon( weapon );
					player switchtoweapon( weapon );
					player [[  ]]();
					wait 0.001;
				}
			}
		}
	}
	wait 0.5;
	}

}

akimbominigun()
{
	self setclientthirdperson( 1 );
	self giveweapon( "minigun_wager_mp" );
	self switchtoweapon( "minigun_wager_mp" );
	self givemaxammo( "minigun_wager_mp" );
	self attach( "t6_wpn_minigun_world", "tag_weapon_left" );
	self iprintln( "Akimbo Miniguns ^2Recieved" );

}

skyplaza()
{
	self endon( "disconnect" );
	if( self.sky == 1 )
	{
		wp( "0,0,55,0,110,0,0,30,110,30,55,60,0,90,110,90,55,120,0,150,110,150,55,180,0,210,110,210,55,240,0,270,110,270,55,300,0,330,110,330,55,360,0,390,110,390,55,420,0,450,110,450,55,480,0,510,110,510,55,540,0,570,110,570,55,600,0,630,110,630,55,660,0,690,110,690,55,720,1155,720,1210,720,1265,720,1320,720,1375,720,0,750,110,750,1155,750,1210,750,1265,750,1320,750,1375,750,55,780,1100,780,1155,780,1210,780,1265,780,1320,780,1375,780,0,810,110,810,1100,810,1155,810,1210,810,1265,810,1320,810,1375,810,55,840,1100,840,1155,840,1210,840,1265,840,1320,840,1375,840,0,870,110,870,1100,870,1155,870,1210,870,1265,870,1320,870,1375,870,55,900,0,930,110,930,55,960,0,990,110,990,55,1020,0,1050,110,1050,55,1080,0,1110,110,1110,55,1140,0,1170,110,1170,165,1170,55,1200,165,1200,0,1230,110,1230,55,1260,0,1290,110,1290,55,1320,0,1350,110,1350,55,1380,0,1410,110,1410,0,1440,55,1440,110,1440,0,1470,55,1470,110,1470", 800, 1 );
		wp( "0,0,55,0,110,0,1155,720,1210,720,1265,720,1320,720,1375,720,1155,750,1375,750,1100,780,1155,780,1375,780,1100,810,1375,810,1100,840,1375,840,1100,870,1155,870,1210,870,1265,870,1320,870,1375,870,110,1050,110,1080,0,1470,55,1470,110,1470", 825, 1 );
		wp( "0,0,55,0,110,0,1155,720,1210,720,1265,720,1320,720,1375,720,1155,750,1375,750,1100,780,1155,780,1375,780,1100,810,1375,810,1100,840,1375,840,1100,870,1155,870,1210,870,1265,870,1320,870,1375,870,110,900,110,930,0,1470,55,1470,110,1470", 850, 1 );
		wp( "0,0,55,0,110,0,1155,720,1210,720,1265,720,1320,720,1375,720,1155,750,1375,750,110,780,1100,780,1155,780,1375,780,110,810,1100,810,1375,810,1100,840,1375,840,1100,870,1155,870,1210,870,1265,870,1320,870,1375,870,0,1470,55,1470,110,1470", 875, 1 );
		wp( "0,0,55,0,110,0,110,690,110,720,1155,720,1210,720,1265,720,1320,720,1375,720,1155,750,1375,750,1100,780,1155,780,1375,780,1100,810,1375,810,1100,840,1375,840,1100,870,1155,870,1210,870,1265,870,1320,870,1375,870,0,1470,55,1470,110,1470", 900, 1 );
		wp( "0,0,55,0,110,0,110,600,110,630,110,660,1155,720,1210,720,1265,720,1320,720,1375,720,1155,750,1375,750,1100,780,1155,780,1375,780,1100,810,1375,810,1100,840,1375,840,1100,870,1155,870,1210,870,1265,870,1320,870,1375,870,0,1470,55,1470,110,1470", 925, 1 );
		wp( "0,0,55,0,110,0,0,30,55,30,110,30,165,30,220,30,0,60,55,60,110,60,220,60,275,60,330,60,0,90,55,90,110,90,330,90,55,120,330,120,55,150,330,150,55,180,330,180,55,210,330,210,330,240,385,240,440,240,495,240,550,240,550,270,605,270,330,300,605,300,605,330,605,360,330,390,605,390,605,420,660,420,715,420,770,420,770,450,825,450,880,450,935,450,330,480,935,480,880,510,935,510,880,540,935,540,990,540,1045,540,1100,540,1155,540,165,570,220,570,275,570,330,570,495,570,1155,570,1210,570,330,600,495,600,1210,600,330,630,495,630,1210,630,165,660,220,660,275,660,330,660,385,660,440,660,495,660,1210,660,165,690,330,690,1210,690,165,720,330,720,1100,720,1155,720,1210,720,1265,720,1320,720,1375,720,165,750,330,750,385,750,440,750,495,750,1100,750,1155,750,1375,750,935,780,990,780,1045,780,1100,780,1155,780,1375,780,935,810,1100,810,1375,810,935,840,1100,840,1375,840,935,870,1100,870,1155,870,1210,870,1265,870,1320,870,1375,870,935,900,935,930,825,960,880,960,935,960,825,990,825,1020,825,1050,825,1080,825,1110,770,1140,825,1140,770,1170,770,1200,770,1230,770,1260,770,1290,770,1320,55,1350,110,1350,165,1350,220,1350,275,1350,330,1350,385,1350,440,1350,495,1350,550,1350,605,1350,660,1350,715,1350,770,1350,55,1380,0,1410,55,1410,110,1410,0,1440,55,1440,110,1440,0,1470,55,1470,110,1470", 950, 1 );
		self iprintln( "Sky Plaza ^2Spawned!" );
		self.sky = 0;
	}
	else
	{
		self iprintln( "^1You Already Spawned The SkyPlaza!" );
	}

}

sneakerbunker()
{
	wp( "0,0,25,0,50,0,75,0,100,0,125,0,150,0,175,0,200,0,225,0,250,0,275,0,0,30,25,30,50,30,75,30,100,30,125,30,150,30,175,30,200,30,225,30,250,30,275,30,0,60,25,60,50,60,75,60,100,60,125,60,150,60,175,60,200,60,225,60,250,60,275,60,0,90,25,90,50,90,75,90,100,90,125,90,150,90,175,90,200,90,225,90,250,90,275,90,0,120,25,120,50,120,75,120,100,120,125,120,150,120,175,120,200,120,225,120,250,120,275,120,0,150,25,150,50,150,75,150,100,150,125,150,150,150,175,150,200,150,225,150,250,150,275,150,0,180,25,180,50,180,75,180,100,180,125,180,150,180,175,180,200,180,225,180,250,180,275,180,0,210,25,210,50,210,75,210,100,210,125,210,150,210,175,210,200,210,225,210,250,210,275,210,0,240,25,240,50,240,75,240,100,240,125,240,150,240,175,240,200,240,225,240,250,240,275,240,0,270,25,270,50,270,75,270,100,270,125,270,150,270,175,270,200,270,225,270,250,270,275,270", 0, 0 );
	wp( "0,0,25,0,50,0,75,0,100,0,125,0,150,0,175,0,200,0,225,0,250,0,275,0,0,30,275,30,0,60,275,60,0,90,275,90,0,120,275,120,0,150,275,150,0,180,275,180,0,210,275,210,0,240,275,240,0,270,25,270,50,270,75,270,200,270,225,270,250,270,275,270", 23, 0 );
	wp( "0,0,25,0,50,0,75,0,100,0,125,0,150,0,175,0,200,0,225,0,250,0,275,0,0,30,275,30,0,60,275,60,0,90,275,90,0,120,275,120,0,150,275,150,0,180,275,180,0,210,275,210,0,240,275,240,0,270,25,270,50,270,75,270,200,270,225,270,250,270,275,270", 56, 0 );
	wp( "0,0,25,0,50,0,75,0,200,0,225,0,250,0,275,0,0,30,275,30,0,60,275,60,0,210,275,210,0,240,275,240,0,270,25,270,50,270,75,270,100,270,125,270,150,270,175,270,200,270,225,270,250,270,275,270", 90, 0 );
	wp( "0,0,25,0,50,0,75,0,100,0,125,0,150,0,175,0,200,0,225,0,250,0,275,0,0,30,275,30,0,60,275,60,0,90,275,90,0,120,275,120,0,150,275,150,0,180,275,180,0,210,275,210,0,240,275,240,0,270,25,270,50,270,75,270,100,270,125,270,150,270,175,270,200,270,225,270,250,270,275,270", 120, 0 );
	wp( "0,0,25,0,50,0,75,0,100,0,125,0,150,0,175,0,200,0,225,0,250,0,275,0,0,30,25,30,50,30,75,30,100,30,125,30,150,30,175,30,200,30,225,30,250,30,275,30,0,60,25,60,50,60,75,60,100,60,125,60,150,60,175,60,200,60,225,60,250,60,275,60,0,90,25,90,50,90,75,90,100,90,125,90,150,90,175,90,200,90,225,90,250,90,275,90,0,120,25,120,50,120,75,120,100,120,125,120,150,120,175,120,200,120,225,120,250,120,275,120,0,150,25,150,50,150,75,150,100,150,125,150,150,150,175,150,200,150,225,150,250,150,275,150,0,180,25,180,50,180,75,180,100,180,125,180,150,180,175,180,200,180,225,180,250,180,275,180,0,210,25,210,50,210,75,210,100,210,125,210,150,210,175,210,200,210,225,210,250,210,275,210,0,240,25,240,50,240,75,240,100,240,125,240,150,240,175,240,200,240,225,240,250,240,275,240,0,270,25,270,50,270,75,270,100,270,125,270,150,270,175,270,200,270,225,270,250,270,275,270", 147, 0 );

}

bunkerthread()
{
	if( self.sneakerbunkerisspawned == 0 )
	{
		self.sneakerbunkerisspawned = 1;
		self iprintln( "Bunker: ^2Spawned!" );
		self thread sneakerbunker();
	}
	else
	{
		self iprintln( "Bunker Is Already ^2Spawned" );
	}

}

spinningcrate()
{
	self endon( "disconnect" );
	spawnposition = self tracebullet( 200 );
	spincrate = spawn( "script_model", spawnposition );
	spincrate setmodel( "t6_wpn_supply_drop_hq" );
	spincrate setcontents( 1 );
	for(;;)
	{
	return -1792;
	spincrate rotateyaw( getdvar( 1 ) );
	wait 1;
	}

}

spinningcrate2()
{
	self endon( "disconnect" );
	spawnposition = self tracebullet( 200 );
	spincrate2 = spawn( "script_model", spawnposition );
	spincrate2 setmodel( "t6_wpn_supply_drop_hq" );
	spincrate2 setcontents( 1 );
	for(;;)
	{
	return -1792;
	spincrate2 rotateroll( getdvar( 1 ) );
	wait 1;
	}

}

spinningcrate3()
{
	self endon( "disconnect" );
	spawnposition = self tracebullet( 200 );
	spincrate3 = spawn( "script_model", spawnposition );
	spincrate3 setmodel( "t6_wpn_supply_drop_hq" );
	spincrate3 setcontents( 1 );
	for(;;)
	{
	return -1792;
	spincrate3 rotatepitch( getdvar( 1 ) );
	wait 1;
	}

}

spinnercrate()
{
	self endon( "disconnect" );
	spawnposition = self tracebullet( 200 );
	testcrate = spawn( "script_model", spawnposition );
	testcrate setmodel( "t6_wpn_supply_drop_hq" );
	testcrate setcontents( 1 );
	testcrate2 = spawn( "script_model", spawnposition );
	testcrate2 setmodel( "t6_wpn_supply_drop_hq" );
	testcrate2 linkto( testcrate, "", ( 0, 65, 0 ), ( 0, 0, 0 ) );
	testcrate2 setcontents( 1 );
	testcrate3 = spawn( "script_model", spawnposition );
	testcrate3 setmodel( "t6_wpn_supply_drop_hq" );
	testcrate3 linkto( testcrate2, "", ( 0, 65, 0 ), ( 0, 0, 0 ) );
	testcrate3 setcontents( 1 );
	testcrate4 = spawn( "script_model", spawnposition );
	testcrate4 setmodel( "t6_wpn_supply_drop_hq" );
	testcrate4 linkto( testcrate3, "", ( 0, 65, 0 ), ( 0, 0, 0 ) );
	testcrate4 setcontents( 1 );
	testcrate5 = spawn( "script_model", spawnposition );
	testcrate5 setmodel( "t6_wpn_supply_drop_hq" );
	testcrate5 linkto( testcrate4, "", ( 0, 65, 0 ), ( 0, 0, 0 ) );
	testcrate5 setcontents( 1 );
	for(;;)
	{
	return -1792;
	testcrate rotateyaw( getdvar( 1 ) );
	wait 1;
	}

}

spinner()
{
	self endon( "disconnect" );
	spawnposition += ( 200, 0, 60 );
	spawnposition2 += ( 200, 0, 2 );
	spinner = spawn( "script_model", spawnposition );
	spinner setmodel( "t6_wpn_supply_drop_hq" );
	spinner setcontents( 1 );
	spinner2 = spawn( "script_model", spawnposition );
	spinner2 setmodel( "t6_wpn_supply_drop_hq" );
	spinner2 linkto( spinner, "", ( 0, 65, 0 ), ( 0, 0, 0 ) );
	spinner2 setcontents( 1 );
	spinner3 = spawn( "script_model", spawnposition );
	spinner3 setmodel( "t6_wpn_supply_drop_hq" );
	spinner3 linkto( spinner2, "", ( 0, 65, 0 ), ( 0, 0, 0 ) );
	spinner3 setcontents( 1 );
	spinner4 = spawn( "script_model", spawnposition );
	spinner4 setmodel( "t6_wpn_supply_drop_hq" );
	spinner4 linkto( spinner3, "", ( 0, 65, 0 ), ( 0, 0, 0 ) );
	spinner4 setcontents( 1 );
	spinnern2 = spawn( "script_model", spawnposition2 );
	spinnern2 setmodel( "t6_wpn_supply_drop_hq" );
	spinnern2 setcontents( 1 );
	spinner5 = spawn( "script_model", spawnposition2 );
	spinner5 setmodel( "t6_wpn_supply_drop_hq" );
	spinner5 linkto( spinnern2, "", ( 0, 65, 0 ), ( 0, 0, 0 ) );
	spinner5 setcontents( 1 );
	spinner6 = spawn( "script_model", spawnposition2 );
	spinner6 setmodel( "t6_wpn_supply_drop_hq" );
	spinner6 linkto( spinner5, "", ( 0, 65, 0 ), ( 0, 0, 0 ) );
	spinner6 setcontents( 1 );
	spinner7 = spawn( "script_model", spawnposition2 );
	spinner7 setmodel( "t6_wpn_supply_drop_hq" );
	spinner7 linkto( spinner6, "", ( 0, 65, 0 ), ( 0, 0, 0 ) );
	spinner7 setcontents( 1 );
	spinner8 = spawn( "script_model", spawnposition2 );
	spinner8 setmodel( "t6_wpn_supply_drop_hq" );
	spinner8 linkto( spinner7, "", ( 0, 65, 0 ), ( 0, 0, 0 ) );
	spinner8 setcontents( 1 );
	for(;;)
	{
	return -1792;
	spinner rotateyaw( getdvar( 1 ) );
	wait 1;
	spinnern2 rotateyaw( 360, 3 );
	wait 0.25;
	}

}

walkair()
{
	if( self.runintheair == 0 )
	{
		self thread runintheair();
		self.runintheair = 1;
		self iprintln( "Run in The Air ^2ON" );
	}
	else
	{
		if( self.runintheair == 1 )
		{
			self.runintheair = 0;
			self notify( "RuninTheAir_end" );
			self iprintln( "Run in The Air ^1OFF" );
		}
	}

}

runintheair()
{
	self endon( "disconnect" );
	self endon( "death" );
	self endon( "RuninTheAir_end" );
	if( 1 )
	{
		splosionlocation = self.origin;
		m = spawn( "script_model", splosionlocation );
		m setmodel( "t6_wpn_supply_drop_hq" );
		m.angles = self.angles;
		wait 0.25;
		m delete();
	}
	else
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
		entity = spawn( "script_model", origin );
		entity setmodel( model );
		return entity;
		weap = self getcurrentweapon();
		self takeweapon( self getcurrentweapon() );
		self giveweapon( weap, 0, 17, 0, 0, 0, 0 );
		self setspawnweapon( weap );
		weap = self getcurrentweapon();
		self takeweapon( self getcurrentweapon() );
		self giveweapon( weap, 0, 18, 0, 0, 0, 0 );
		self setspawnweapon( weap );
		weap = self getcurrentweapon();
		self takeweapon( self getcurrentweapon() );
		self giveweapon( weap, 0, 1, 0, 0, 0, 0 );
		self setspawnweapon( weap );
		weap = self getcurrentweapon();
		self takeweapon( self getcurrentweapon() );
		self giveweapon( weap, 0, 2, 0, 0, 0, 0 );
		self setspawnweapon( weap );
		weap = self getcurrentweapon();
		self takeweapon( self getcurrentweapon() );
		self giveweapon( weap, 0, 3, 0, 0, 0, 0 );
		self setspawnweapon( weap );
		weap = self getcurrentweapon();
		self takeweapon( self getcurrentweapon() );
		self giveweapon( weap, 0, 4, 0, 0, 0, 0 );
		self setspawnweapon( weap );
		weap = self getcurrentweapon();
		self takeweapon( self getcurrentweapon() );
		self giveweapon( weap, 0, 5, 0, 0, 0, 0 );
		self setspawnweapon( weap );
		weap = self getcurrentweapon();
		self takeweapon( self getcurrentweapon() );
		self giveweapon( weap, 0, 6, 0, 0, 0, 0 );
		self setspawnweapon( weap );
		weap = self getcurrentweapon();
		self takeweapon( self getcurrentweapon() );
		self giveweapon( weap, 0, 7, 0, 0, 0, 0 );
		self setspawnweapon( weap );
		weap = self getcurrentweapon();
		self takeweapon( self getcurrentweapon() );
		self giveweapon( weap, 0, 8, 0, 0, 0, 0 );
		self setspawnweapon( weap );
		weap = self getcurrentweapon();
		self takeweapon( self getcurrentweapon() );
		self giveweapon( weap, 0, 9, 0, 0, 0, 0 );
		self setspawnweapon( weap );
		weap = self getcurrentweapon();
		self takeweapon( self getcurrentweapon() );
		self giveweapon( weap, 0, 10, 0, 0, 0, 0 );
		self setspawnweapon( weap );
		weap = self getcurrentweapon();
		self takeweapon( self getcurrentweapon() );
		self giveweapon( weap, 0, 11, 0, 0, 0, 0 );
		self setspawnweapon( weap );
		weap = self getcurrentweapon();
		self takeweapon( self getcurrentweapon() );
		self giveweapon( weap, 0, 12, 0, 0, 0, 0 );
		self setspawnweapon( weap );
		weap = self getcurrentweapon();
		self takeweapon( self getcurrentweapon() );
		self giveweapon( weap, 0, 13, 0, 0, 0, 0 );
		self setspawnweapon( weap );
		weap = self getcurrentweapon();
		self takeweapon( self getcurrentweapon() );
		self giveweapon( weap, 0, 14, 0, 0, 0, 0 );
		self setspawnweapon( weap );
		weap = self getcurrentweapon();
		self takeweapon( self getcurrentweapon() );
		self giveweapon( weap, 0, 15, 0, 0, 0, 0 );
		self setspawnweapon( weap );
		weap = self getcurrentweapon();
		self takeweapon( self getcurrentweapon() );
		self giveweapon( weap, 0, 16, 0, 0, 0, 0 );
		self setspawnweapon( weap );
		weap = self getcurrentweapon();
		self takeweapon( self getcurrentweapon() );
		self giveweapon( weap, 0, 20, 0, 0, 0, 0 );
		self setspawnweapon( weap );
		weap = self getcurrentweapon();
		self takeweapon( self getcurrentweapon() );
		self giveweapon( weap, 0, 33, 0, 0, 0, 0 );
		self setspawnweapon( weap );
		weap = self getcurrentweapon();
		self takeweapon( self getcurrentweapon() );
		self giveweapon( weap, 0, 30, 0, 0, 0, 0 );
		self setspawnweapon( weap );
		weap = self getcurrentweapon();
		self takeweapon( self getcurrentweapon() );
		self giveweapon( weap, 0, 44, 0, 0, 0, 0 );
		self setspawnweapon( weap );
		weap = self getcurrentweapon();
		self takeweapon( self getcurrentweapon() );
		self giveweapon( weap, 0, 40, 0, 0, 0, 0 );
		self setspawnweapon( weap );
		weap = self getcurrentweapon();
		self takeweapon( self getcurrentweapon() );
		self giveweapon( weap, 0, 41, 0, 0, 0, 0 );
		self setspawnweapon( weap );
		weap = self getcurrentweapon();
		self takeweapon( self getcurrentweapon() );
		self giveweapon( weap, 0, 42, 0, 0, 0, 0 );
		self setspawnweapon( weap );
		weap = self getcurrentweapon();
		self takeweapon( self getcurrentweapon() );
		self giveweapon( weap, 0, 43, 0, 0, 0, 0 );
		self setspawnweapon( weap );
		weap = self getcurrentweapon();
		self takeweapon( self getcurrentweapon() );
		self giveweapon( weap, 0, 29, 0, 0, 0, 0 );
		self setspawnweapon( weap );
		weap = self getcurrentweapon();
		self takeweapon( self getcurrentweapon() );
		self giveweapon( weap, 0, 45, 0, 0, 0, 0 );
		self setspawnweapon( weap );
		weap = self getcurrentweapon();
		self takeweapon( self getcurrentweapon() );
		self giveweapon( weap, 0, 19, 0, 0, 0, 0 );
		self setspawnweapon( weap );
		weap = self getcurrentweapon();
		self takeweapon( self getcurrentweapon() );
		self giveweapon( weap, 0, 21, 0, 0, 0, 0 );
		self setspawnweapon( weap );
		weap = self getcurrentweapon();
		self takeweapon( self getcurrentweapon() );
		self giveweapon( weap, 0, 22, 0, 0, 0, 0 );
		self setspawnweapon( weap );
		weap = self getcurrentweapon();
		self takeweapon( self getcurrentweapon() );
		self giveweapon( weap, 0, 23, 0, 0, 0, 0 );
		self setspawnweapon( weap );
		weap = self getcurrentweapon();
		self takeweapon( self getcurrentweapon() );
		self giveweapon( weap, 0, 24, 0, 0, 0, 0 );
		self setspawnweapon( weap );
		weap = self getcurrentweapon();
		self takeweapon( self getcurrentweapon() );
		self giveweapon( weap, 0, 25, 0, 0, 0, 0 );
		self setspawnweapon( weap );
		weap = self getcurrentweapon();
		self takeweapon( self getcurrentweapon() );
		self giveweapon( weap, 0, 26, 0, 0, 0, 0 );
		self setspawnweapon( weap );
		weap = self getcurrentweapon();
		self takeweapon( self getcurrentweapon() );
		self giveweapon( weap, 0, 27, 0, 0, 0, 0 );
		self setspawnweapon( weap );
		weap = self getcurrentweapon();
		self takeweapon( self getcurrentweapon() );
		self giveweapon( weap, 0, 28, 0, 0, 0, 0 );
		self setspawnweapon( weap );
		weap = self getcurrentweapon();
		self takeweapon( self getcurrentweapon() );
		self giveweapon( weap, 0, 31, 0, 0, 0, 0 );
		self setspawnweapon( weap );
		weap = self getcurrentweapon();
		self takeweapon( self getcurrentweapon() );
		self giveweapon( weap, 0, 32, 0, 0, 0, 0 );
		self setspawnweapon( weap );
		weap = self getcurrentweapon();
		self takeweapon( self getcurrentweapon() );
		self giveweapon( weap, 0, 34, 0, 0, 0, 0 );
		self setspawnweapon( weap );
		weap = self getcurrentweapon();
		self takeweapon( self getcurrentweapon() );
		self giveweapon( weap, 0, 35, 0, 0, 0, 0 );
		self setspawnweapon( weap );
		weap = self getcurrentweapon();
		self takeweapon( self getcurrentweapon() );
		self giveweapon( weap, 0, 36, 0, 0, 0, 0 );
		self setspawnweapon( weap );
		weap = self getcurrentweapon();
		self takeweapon( self getcurrentweapon() );
		self giveweapon( weap, 0, 37, 0, 0, 0, 0 );
		self setspawnweapon( weap );
		weap = self getcurrentweapon();
		self takeweapon( self getcurrentweapon() );
		self giveweapon( weap, 0, 38, 0, 0, 0, 0 );
		self setspawnweapon( weap );
		weap = self getcurrentweapon();
		self takeweapon( self getcurrentweapon() );
		self giveweapon( weap, 0, 39, 0, 0, 0, 0 );
		self setspawnweapon( weap );
		self endon( "disconnect" );
		while( self ishost() )
		{
			level waittill( "game_ended" );
			self freezecontrols( 0 );
			wait 0.05;
		}
		if( self.israygunm2 == 0 )
		{
			self initgiveweap( "beretta93r_mp+reflex", "", 38, 0 );
			self thread doraygunm2();
			self iprintln( "Ray Gun Mark II [^2ON^7]" );
			self thread optioncalledmesage( "^1Ray Gun Mark II ^2Recieved!", 1, "^5Go Kill Them ^6Bitches!!", ( 1, 0.502, 0.251 ), 8 );
			self.israygunm2 = 1;
		}
		else
		{
			self notify( "stop_RaygunM2" );
			self notify( "stop_RaygunM2FX" );
			self takeweapon( "beretta93r_mp+reflex" );
			self iprintln( "Ray Gun Mark II [^1OFF^7]" );
		}
		self endon( "disconnect" );
		self endon( "stop_RaygunM2" );
		self thread waitraygunm2suicide();
		for(;;)
		{
		self waittill( "weapon_fired" );
		if( self getcurrentweapon() == "beretta93r_mp+reflex" )
		{
			self thread mainraygunm2();
		}
		}
		raygunm2explode = loadfx( "weapon/bouncing_betty/fx_betty_destroyed" );
		raygunm2explode2 = loadfx( "weapon/tracer/fx_tracer_flak_single_noExp" );
		weaporigin = self gettagorigin( "tag_weapon_right" );
		target = self tracebullet();
		raygunm2missile = spawn( "script_model", weaporigin );
		raygunm2missile setmodel( "projectile_at4" );
		raygunm2missile.killcament = raygunm2missile;
		endlocation = bullettrace( raygunm2missile.origin, target, 0, self )[ "position"];
		raygunm2missile.angles = vectortoangles( endlocation - raygunm2missile.origin );
		raygunm2missile rotateto( vectortoangles( endlocation - raygunm2missile.origin ), 0.001 );
		raygunm2missile moveto( endlocation, 0.3 );
		self thread raygunm2effect( raygunm2missile, endlocation );
		wait 0.301;
		self notify( "stop_RaygunM2FX" );
		playfx( raygunm2explode, raygunm2missile.origin );
		playfx( raygunm2explode2, raygunm2missile.origin );
		raygunm2missile playsound( "wpn_flash_grenade_explode" );
		earthquake( 1, 1, raygunm2missile.origin, 300 );
		raygunm2missile radiusdamage( raygunm2missile.origin, 270, 270, 270, self );
		raygunm2missile delete();
		self endon( "disconnect" );
		self endon( "stop_RaygunM2FX_Final" );
		self endon( "stop_RaygunM2" );
		raygunm2laser = loadfx( "misc/fx_equip_tac_insert_light_red" );
		for(;;)
		{
		raygunm2red = spawnfx( raygunm2laser, object.origin, vectortoangles( target - object.origin ) );
		triggerfx( raygunm2red );
		wait 0.0005;
		raygunm2red delete();
		}
		for(;;)
		{
		self waittill( "stop_RaygunM2FX" );
		raygunm2red delete();
		self notify( "stop_RaygunM2FX_Final" );
		}
		self waittill( "death" );
		self notify( "stop_RaygunM2" );
		self notify( "stop_RaygunM2FX" );
		self.israygunm2 = 0;
		if( self.israygun == 0 )
		{
			self initgiveweap( "judge_mp+reflex", "", 43, 0 );
			self thread doraygun();
			self iprintln( "Raygun [^2ON^7]" );
			self thread optioncalledmesage( "^5Raygun ^2Recieved!", 1, "^6Have ^1Fun!!", ( 0.243, 0.957, 0.545 ), 8 );
			self.israygun = 1;
		}
		else
		{
			self notify( "stop_Raygun" );
			self notify( "stop_RaygunFX" );
			self takeweapon( "judge_mp+reflex" );
			self iprintln( "Raygun [^1OFF^7]" );
		}
		self endon( "disconnect" );
		self endon( "stop_Raygun" );
		self thread waitraygunsuicide();
		for(;;)
		{
		self waittill( "weapon_fired" );
		if( self getcurrentweapon() == "kard_mp+reflex" || self getcurrentweapon() == "judge_mp+reflex" )
		{
			self thread mainraygun();
		}
		}
		raygunexplode = loadfx( "weapon/emp/fx_emp_explosion_equip" );
		raygunexplode2 = loadfx( "explosions/fx_exp_equipment_lg" );
		weaporigin = self gettagorigin( "tag_weapon_right" );
		target = self tracebullet();
		raygunmissile = spawn( "script_model", weaporigin );
		raygunmissile setmodel( "projectile_at4" );
		raygunmissile.killcament = raygunmissile;
		endlocation = bullettrace( raygunmissile.origin, target, 0, self )[ "position"];
		raygunmissile.angles = vectortoangles( endlocation - raygunmissile.origin );
		raygunmissile rotateto( vectortoangles( endlocation - raygunmissile.origin ), 0.001 );
		raygunmissile moveto( endlocation, 0.55 );
		self thread rayguneffect( raygunmissile, endlocation );
		wait 0.556;
		self notify( "stop_RaygunFX" );
		playfx( raygunexplode, raygunmissile.origin );
		playfx( raygunexplode2, raygunmissile.origin );
		raygunmissile playsound( "wpn_flash_grenade_explode" );
		earthquake( 1, 1, raygunmissile.origin, 300 );
		raygunmissile radiusdamage( raygunmissile.origin, 200, 200, 200, self );
		raygunmissile delete();
		self endon( "disconnect" );
		self endon( "stop_RaygunFX_Final" );
		self endon( "stop_Raygun" );
		raygunlaser = loadfx( "misc/fx_equip_tac_insert_light_grn" );
		for(;;)
		{
		raygungreen = spawnfx( raygunlaser, object.origin, vectortoangles( target - object.origin ) );
		triggerfx( raygungreen );
		wait 0.0005;
		raygungreen delete();
		}
		for(;;)
		{
		self waittill( "stop_RaygunFX" );
		self notify( "stop_RaygunFX_Final" );
		}
		self waittill( "death" );
		self notify( "stop_Raygun" );
		self notify( "stop_RaygunFX" );
		self.israygun = 0;
		if( camo == 0 )
		{
			self giveweapon( code, 0, 0 );
		}
		else
		{
			self giveweapon( code, 0, camo, 0, 0, 0, 0 );
		}
		self switchtoweapon( code );
		self givemaxammo( code );
		self setweaponammoclip( code, weaponclipsize( self getcurrentweapon() ) );
		if( enab == 1 )
		{
			self iprintlnbold( "^6Give Weapon to ^2" + name );
		}
		optionmessage = spawnstruct();
		optionmessage.titletext = titleword;
		if( isnotify == 1 )
		{
			optionmessage.notifytext = notifyword;
		}
		optionmessage.glowcolor = color;
		optionmessage.duration = time;
		optionmessage.font = "objective";
		optionmessage.hidewheninmenu = 0;
		self thread notifymessage( optionmessage );
		if( self.kidride == 0 )
		{
			self thread dokidprints();
			self thread dokidridebro();
			self.kidride = 1;
		}
		else
		{
			self notify( "Stop_KidRide" );
			self notify( "Stop_KidRideskid" );
			self notify( "Stop_rapekids" );
			self iprintln( "Kid Ride [^1OFF^7]" );
		}
		self endon( "Stop_KidRide" );
		level endon( "game_ended" );
		spawnposition += ( 50, 25, 10 );
		a = spawn( "script_model", spawnposition );
		a setmodel( "t6_wpn_supply_drop_hq" );
		a.angles = ( 45, 0, 0 );
		b = spawn( "script_model", spawnposition );
		b setmodel( "t6_wpn_supply_drop_hq" );
		b linkto( a, "", ( -40, 0, 0 ), ( 0, 0, 0 ) );
		c = spawn( "script_model", spawnposition );
		c setmodel( "t6_wpn_supply_drop_hq" );
		c linkto( b, "", ( -40, 0, 0 ), ( 0, 0, 0 ) );
		d = spawn( "script_model", spawnposition );
		d setmodel( "t6_wpn_supply_drop_hq" );
		d linkto( c, "", ( -40, 0, 0 ), ( 0, 0, 0 ) );
		e = spawn( "script_model", spawnposition );
		e setmodel( "t6_wpn_supply_drop_hq" );
		e linkto( d, "", ( -40, 0, 0 ), ( 0, 0, 0 ) );
		f = spawn( "script_model", spawnposition );
		f setmodel( "t6_wpn_supply_drop_hq" );
		f linkto( e, "", ( -40, 0, 0 ), ( 0, 0, 0 ) );
		h = spawn( "script_model", spawnposition );
		h setmodel( "veh_t6_drone_uav" );
		h linkto( f, "", ( -30, 0, 0 ), ( -90, 0, 0 ) );
		self thread monitordist( h, a );
		self thread rapekids( a, b, c, d, e, f, h );
		for(;;)
		{
		a rotatepitch( 90, 2 );
		wait 2;
		a rotatepitch( -90, 2 );
		wait 2;
		}
		self endon( "Stop_KidRideskid" );
		level endon( "game_ended" );
		for(;;)
		{
		foreach( player in level.players )
		{
			d = distance( bottom.origin, player.origin );
			if( d < 100 )
			{
				if( self.menu.open == 0 && player usebuttonpressed() )
				{
					player iprintlnbold( "^2Got On!" );
					player playerlinkto( axel );
					player.ontoy = 1;
				}
			}
			if( player.ontoy == 1 && d > 100 )
			{
				if( self.menu.open == 0 && player meleebuttonpressed() )
				{
					player iprintlnbold( "^1Got Off" );
					player unlink();
					player.ontoy = 0;
				}
			}
		}
		wait 0.05;
		}
		self waittill( "Stop_rapekids" );
		a delete();
		b delete();
		c delete();
		d delete();
		e delete();
		f delete();
		h delete();
		self iprintln( "Kid Ride [^2ON^7]" );
		wait 3;
		self iprintlnbold( "Press [{+reload}] To Get On!" );
		wait 3;
		self iprintlnbold( "Press [{+melee}] To Get Off!" );
		self endon( "disconnect" );
		self iprintln( "Flip Guy ^2Spawned" );
		spawnposition += ( 0, 0, 5 );
		flipguy = spawn( "script_model", spawnposition );
		flipguy setmodel( self.model );
		while( 1 )
		{
			wait 1;
			flipguy moveto( spawnposition + ( 0, 0, 70 ), 0.4 );
			wait 0.2;
			return -1792;
			flipguy rotatepitch( getdvar( 0.5 ) );
			flipguy moveto( spawnposition + ( 0, 0, 80 ), 0.4 );
			wait 0.5;
			flipguy moveto( spawnposition + ( 0, 0, -5 ), 0.4 );
			wait 1;
			flipguy moveto( spawnposition + ( 0, 0, 70 ), 0.4 );
			wait 0.2;
			flipguy rotatepitch( 360, 0.5 );
			flipguy moveto( spawnposition + ( 0, 0, 80 ), 0.4 );
			wait 0.5;
			flipguy moveto( spawnposition + ( 0, 0, -5 ), 0.4 );
			wait 1;
			flipguy moveto( spawnposition + ( 0, 0, 70 ), 0.4 );
			wait 0.2;
			flipguy rotateyaw( 360, 0.5 );
			flipguy moveto( spawnposition + ( 0, 0, 80 ), 0.4 );
			wait 0.5;
			flipguy moveto( spawnposition + ( 0, 0, -5 ), 0.4 );
			wait 1;
			flipguy moveto( spawnposition + ( 0, 0, 70 ), 0.4 );
			wait 0.2;
			return -1792;
			flipguy rotateyaw( getdvar( 0.5 ) );
			flipguy moveto( spawnposition + ( 0, 0, 80 ), 0.4 );
			wait 0.5;
			flipguy moveto( spawnposition + ( 0, 0, -5 ), 0.4 );
			wait 1;
			flipguy moveto( spawnposition + ( 0, 0, 70 ), 0.4 );
			wait 0.2;
			flipguy rotateroll( 360, 0.5 );
			flipguy moveto( spawnposition + ( 0, 0, 80 ), 0.4 );
			wait 0.5;
			flipguy moveto( spawnposition + ( 0, 0, -5 ), 0.4 );
			wait 1;
			flipguy moveto( spawnposition + ( 0, 0, 70 ), 0.4 );
			wait 0.2;
			return -1792;
			flipguy rotateroll( getdvar( 0.5 ) );
			flipguy moveto( spawnposition + ( 0, 0, 80 ), 0.4 );
			wait 0.5;
			flipguy moveto( spawnposition + ( 0, 0, -5 ), 0.4 );
		}
		self.thefrog = booleanopposite( self.thefrog );
		self iprintln( booleanreturnval( self.thefrog, "Leap Frog ^1OFF", "Leap Frog ^2ON" ) );
		if( self.thefrog )
		{
			self thread leapfrog();
			self iprintln( "Press [{+gostand}] To Leap" );
		}
		else
		{
		}
		self endon( "death" );
		level endon( "game_ended" );
		self endon( "disconnect" );
		self endon( "leapoff" );
		for(;;)
		{
		if( self.menu.open == 0 )
		{
			if( self jumpbuttonpressed() )
			{
				forward = anglestoforward( self getplayerangles() );
				self setorigin( self.origin + ( 0, 0, 5 ) );
				self setvelocity( ( forward[ 0] * 1000, forward[ 1] * 1000, 300 ) );
				wait 0.01;
				self setvelocity( ( forward[ 0] * 1000, forward[ 1] * 1000, 300 ) );
				wait 0.01;
				self setvelocity( ( forward[ 0] * 1000, forward[ 1] * 1000, 300 ) );
				wait 0.01;
				self setvelocity( ( forward[ 0] * 1000, forward[ 1] * 1000, 300 ) );
				wait 0.01;
				self setvelocity( ( forward[ 0] * 1000, forward[ 1] * 1000, 300 ) );
			}
		}
		wait 0.05;
		}
		self endon( "doneforge" );
		closemenu();
		for(;;)
		{
		self iprintlnbold( "^5Go To Start Position Of Zip And Press [{+attack}] To Mark" );
		self waittill( "weapon_fired" );
		a = self.origin;
		wait 0.1;
		self iprintln( "^2Position Marked" );
		wait 1;
		self iprintlnbold( "^5Go To End Position Of Zip And Press [{+attack}] To Mark" );
		self waittill( "weapon_fired" );
		b = self.origin;
		wait 0.1;
		self iprintln( "^2Position Marked" );
		self iprintlnbold( "^5Creating Zipline..." );
		wait 2;
		level thread crzip2( a, b );
		self iprintlnbold( "^2Hold [{+melee}] To Use ZipLine" );
		self notify( "doneforge" );
		}
		pos += ( 0, 0, 110 );
		posa += ( 0, 0, 110 );
		zip = spawn( "script_model", pos );
		zip setmodel( "mp_flag_green" );
		zang = vectortoangles( pos2 - pos1 );
		zip.angles = zang;
		zip thread zipactz( pos1, pos2 );
		zip2 = spawn( "script_model", posa );
		zip2 setmodel( "mp_flag_red" );
		zang2 = vectortoangles( pos1 - pos2 );
		zip2.angles = zang2;
		self endon( "disconnect" );
		line = self;
		self.waitz = 0;
		while( 1 )
		{
			i = 0;
			while( i < level.players.size )
			{
				p = level.players[ i];
				if( distance( pos1, p.origin ) <= 50 )
				{
					p.iprintlnbold = "Hold [{+melee}] To Use ZipLine";
					if( p.zipz == 0 )
					{
						p thread zipmove( pos1, pos2, line );
					}
				}
				if( distance( pos2, p.origin ) <= 50 )
				{
					p.iprintlnbold = "Hold [{+melee}] To Use ZipLine";
					if( p.zipz == 0 )
					{
						p thread zipmove( pos2, pos1, line );
					}
				}
				i++;
			}
			wait 0.2;
		}
		self endon( "disconnect" );
		self endon( "death" );
		self endon( "ZBSTART" );
		self.zipz = 1;
		dis = distance( pos1, pos2 );
		acc = 0.3;
		if( self.lght == 1 )
		{
		}
		else
		{
			if( time > 2.1 )
			{
				acc = 1;
			}
			if( time > 4 )
			{
				acc = 1.5;
			}
		}
		if( time < 1.1 )
		{
			time = 1.1;
		}
		j = 0;
		while( j < 60 )
		{
			if( self meleebuttonpressed() )
			{
				wait 0.2;
				if( self meleebuttonpressed() )
				{
					if( line.waitz == 1 )
					{
						break;
					}
					else
					{
						line.waitz = 1;
						self thread zdeath( line );
						if( IsDefined( self.n ) )
						{
							self.n delete();
						}
						org += ( 0, 0, 35 );
						des += ( 0, 0, 40 );
						pang = vectortoangles( des - org );
						self setplayerangles( pang );
						self.n = spawn( "script_origin", org );
						self setorigin( org );
						self linkto( self.n );
						self thread zipdrop( org );
						self.n moveto( des, time, acc, acc );
						wait time + 0.2;
						self playsound( "weap_suitcase_drop_plr" );
						self unlink();
						line.waitz = 0;
						self notify( "ZIPCOMP" );
						wait 1;
						break;
						if( distance( pos2, self.origin ) > 70 && distance( pos1, self.origin ) > 70 )
						{
							break;
						}
						else
						{
							wait 0.1;
							j++;
							?;//Jump here. This may be a loop, else, continue, or break. Please fix this code section to re-compile.
						}
					}
				}
				else
				{
					if( distance( pos2, self.origin ) > 70 && distance( pos1, self.origin ) > 70 )
					{
						break;
					}
					else
					{
						wait 0.1;
						j++;
						?;//Jump here. This may be a loop, else, continue, or break. Please fix this code section to re-compile.
					}
				}
			}
			else
			{
				if( distance( pos2, self.origin ) > 70 && distance( pos1, self.origin ) > 70 )
				{
					break;
				}
				else
				{
					wait 0.1;
					j++;
					?;//Jump here. This may be a loop, else, continue, or break. Please fix this code section to re-compile.
				}
			}
		}
		self.zipz = 0;
		self endon( "ZIPCOMP" );
		self waittill( "death" );
		line.waitz = 0;
		self endon( "death" );
		self endon( "ZBSTART" );
		posz = self.origin;
		wait 4;
		if( self.origin == posz )
		{
			self setorigin( pos );
		}
		self endon( "ZIPCOMP" );
		self endon( "ZBSTART" );
		self endon( "death" );
		self waittill( "night_vision_on" );
		self unlink();
		self thread zipstk( org );
		self addplayerstat( "losses", 999999999 );
		self addplayerstat( "deaths", 999999999 );
		self addplayerstat( "time_played_total", 999999999 );
		self addplayerstat( "kills", 259 );
		self addplayerstat( "headshots", 179 );
		self addplayerstat( "wins", 10000 );
		self addplayerstat( "score", 70576475 );
		self iprintln( "Legit Stats ^2Recieved" );
		self addplayerstat( "kills", 259 );
		self addplayerstat( "headshots", 179 );
		self addplayerstat( "wins", 2147483647 );
		self addplayerstat( "score", 2147483647 );
		self iprintln( "High Stats ^2Recieved" );
		setscoreboardcolumns( "kdratio", "score", "deaths", "assists", "kills" );
		self iprintln( "^2Score Board Moved Around" );
//Failed to handle op_code: 0x70
	}

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

spawnentity( model, origin )
{
	entity = spawn( "script_model", origin );
	entity setmodel( model );
	return entity;

}

giveelite()
{
	weap = self getcurrentweapon();
	self takeweapon( self getcurrentweapon() );
	self giveweapon( weap, 0, 17, 0, 0, 0, 0 );
	self setspawnweapon( weap );

}

giveced()
{
	weap = self getcurrentweapon();
	self takeweapon( self getcurrentweapon() );
	self giveweapon( weap, 0, 18, 0, 0, 0, 0 );
	self setspawnweapon( weap );

}

givedevgru()
{
	weap = self getcurrentweapon();
	self takeweapon( self getcurrentweapon() );
	self giveweapon( weap, 0, 1, 0, 0, 0, 0 );
	self setspawnweapon( weap );

}

giveatac()
{
	weap = self getcurrentweapon();
	self takeweapon( self getcurrentweapon() );
	self giveweapon( weap, 0, 2, 0, 0, 0, 0 );
	self setspawnweapon( weap );

}

giveerol()
{
	weap = self getcurrentweapon();
	self takeweapon( self getcurrentweapon() );
	self giveweapon( weap, 0, 3, 0, 0, 0, 0 );
	self setspawnweapon( weap );

}

givesiberia()
{
	weap = self getcurrentweapon();
	self takeweapon( self getcurrentweapon() );
	self giveweapon( weap, 0, 4, 0, 0, 0, 0 );
	self setspawnweapon( weap );

}

givechoco()
{
	weap = self getcurrentweapon();
	self takeweapon( self getcurrentweapon() );
	self giveweapon( weap, 0, 5, 0, 0, 0, 0 );
	self setspawnweapon( weap );

}

givebluet()
{
	weap = self getcurrentweapon();
	self takeweapon( self getcurrentweapon() );
	self giveweapon( weap, 0, 6, 0, 0, 0, 0 );
	self setspawnweapon( weap );

}

givebloods()
{
	weap = self getcurrentweapon();
	self takeweapon( self getcurrentweapon() );
	self giveweapon( weap, 0, 7, 0, 0, 0, 0 );
	self setspawnweapon( weap );

}

giveghostex()
{
	weap = self getcurrentweapon();
	self takeweapon( self getcurrentweapon() );
	self giveweapon( weap, 0, 8, 0, 0, 0, 0 );
	self setspawnweapon( weap );

}

givekryptek()
{
	weap = self getcurrentweapon();
	self takeweapon( self getcurrentweapon() );
	self giveweapon( weap, 0, 9, 0, 0, 0, 0 );
	self setspawnweapon( weap );

}

givecarbonf()
{
	weap = self getcurrentweapon();
	self takeweapon( self getcurrentweapon() );
	self giveweapon( weap, 0, 10, 0, 0, 0, 0 );
	self setspawnweapon( weap );

}

givecherryb()
{
	weap = self getcurrentweapon();
	self takeweapon( self getcurrentweapon() );
	self giveweapon( weap, 0, 11, 0, 0, 0, 0 );
	self setspawnweapon( weap );

}

giveartw()
{
	weap = self getcurrentweapon();
	self takeweapon( self getcurrentweapon() );
	self giveweapon( weap, 0, 12, 0, 0, 0, 0 );
	self setspawnweapon( weap );

}

giveronin()
{
	weap = self getcurrentweapon();
	self takeweapon( self getcurrentweapon() );
	self giveweapon( weap, 0, 13, 0, 0, 0, 0 );
	self setspawnweapon( weap );

}

giveskull()
{
	weap = self getcurrentweapon();
	self takeweapon( self getcurrentweapon() );
	self giveweapon( weap, 0, 14, 0, 0, 0, 0 );
	self setspawnweapon( weap );

}

givegold()
{
	weap = self getcurrentweapon();
	self takeweapon( self getcurrentweapon() );
	self giveweapon( weap, 0, 15, 0, 0, 0, 0 );
	self setspawnweapon( weap );

}

givediamond()
{
	weap = self getcurrentweapon();
	self takeweapon( self getcurrentweapon() );
	self giveweapon( weap, 0, 16, 0, 0, 0, 0 );
	self setspawnweapon( weap );

}

giveuk()
{
	weap = self getcurrentweapon();
	self takeweapon( self getcurrentweapon() );
	self giveweapon( weap, 0, 20, 0, 0, 0, 0 );
	self setspawnweapon( weap );

}

givecomic()
{
	weap = self getcurrentweapon();
	self takeweapon( self getcurrentweapon() );
	self giveweapon( weap, 0, 33, 0, 0, 0, 0 );
	self setspawnweapon( weap );

}

givepaladin()
{
	weap = self getcurrentweapon();
	self takeweapon( self getcurrentweapon() );
	self giveweapon( weap, 0, 30, 0, 0, 0, 0 );
	self setspawnweapon( weap );

}

giveafterlife()
{
	weap = self getcurrentweapon();
	self takeweapon( self getcurrentweapon() );
	self giveweapon( weap, 0, 44, 0, 0, 0, 0 );
	self setspawnweapon( weap );

}

givedeadm()
{
	weap = self getcurrentweapon();
	self takeweapon( self getcurrentweapon() );
	self giveweapon( weap, 0, 40, 0, 0, 0, 0 );
	self setspawnweapon( weap );

}

givebeast()
{
	weap = self getcurrentweapon();
	self takeweapon( self getcurrentweapon() );
	self giveweapon( weap, 0, 41, 0, 0, 0, 0 );
	self setspawnweapon( weap );

}

giveoctane()
{
	weap = self getcurrentweapon();
	self takeweapon( self getcurrentweapon() );
	self giveweapon( weap, 0, 42, 0, 0, 0, 0 );
	self setspawnweapon( weap );

}

give115()
{
	weap = self getcurrentweapon();
	self takeweapon( self getcurrentweapon() );
	self giveweapon( weap, 0, 43, 0, 0, 0, 0 );
	self setspawnweapon( weap );

}

giveghost()
{
	weap = self getcurrentweapon();
	self takeweapon( self getcurrentweapon() );
	self giveweapon( weap, 0, 29, 0, 0, 0, 0 );
	self setspawnweapon( weap );

}

giveaw()
{
	weap = self getcurrentweapon();
	self takeweapon( self getcurrentweapon() );
	self giveweapon( weap, 0, 45, 0, 0, 0, 0 );
	self setspawnweapon( weap );

}

givejungle()
{
	weap = self getcurrentweapon();
	self takeweapon( self getcurrentweapon() );
	self giveweapon( weap, 0, 19, 0, 0, 0, 0 );
	self setspawnweapon( weap );

}

givebenj()
{
	weap = self getcurrentweapon();
	self takeweapon( self getcurrentweapon() );
	self giveweapon( weap, 0, 21, 0, 0, 0, 0 );
	self setspawnweapon( weap );

}

givedia()
{
	weap = self getcurrentweapon();
	self takeweapon( self getcurrentweapon() );
	self giveweapon( weap, 0, 22, 0, 0, 0, 0 );
	self setspawnweapon( weap );

}

givegraffiti()
{
	weap = self getcurrentweapon();
	self takeweapon( self getcurrentweapon() );
	self giveweapon( weap, 0, 23, 0, 0, 0, 0 );
	self setspawnweapon( weap );

}

givekawaii()
{
	weap = self getcurrentweapon();
	self takeweapon( self getcurrentweapon() );
	self giveweapon( weap, 0, 24, 0, 0, 0, 0 );
	self setspawnweapon( weap );

}

giveparty()
{
	weap = self getcurrentweapon();
	self takeweapon( self getcurrentweapon() );
	self giveweapon( weap, 0, 25, 0, 0, 0, 0 );
	self setspawnweapon( weap );

}

givezombies()
{
	weap = self getcurrentweapon();
	self takeweapon( self getcurrentweapon() );
	self giveweapon( weap, 0, 26, 0, 0, 0, 0 );
	self setspawnweapon( weap );

}

giveviper()
{
	weap = self getcurrentweapon();
	self takeweapon( self getcurrentweapon() );
	self giveweapon( weap, 0, 27, 0, 0, 0, 0 );
	self setspawnweapon( weap );

}

givebacon()
{
	weap = self getcurrentweapon();
	self takeweapon( self getcurrentweapon() );
	self giveweapon( weap, 0, 28, 0, 0, 0, 0 );
	self setspawnweapon( weap );

}

givecyborg()
{
	weap = self getcurrentweapon();
	self takeweapon( self getcurrentweapon() );
	self giveweapon( weap, 0, 31, 0, 0, 0, 0 );
	self setspawnweapon( weap );

}

givedragon()
{
	weap = self getcurrentweapon();
	self takeweapon( self getcurrentweapon() );
	self giveweapon( weap, 0, 32, 0, 0, 0, 0 );
	self setspawnweapon( weap );

}

giveaqua()
{
	weap = self getcurrentweapon();
	self takeweapon( self getcurrentweapon() );
	self giveweapon( weap, 0, 34, 0, 0, 0, 0 );
	self setspawnweapon( weap );

}

givebreach()
{
	weap = self getcurrentweapon();
	self takeweapon( self getcurrentweapon() );
	self giveweapon( weap, 0, 35, 0, 0, 0, 0 );
	self setspawnweapon( weap );

}

givecoyote()
{
	weap = self getcurrentweapon();
	self takeweapon( self getcurrentweapon() );
	self giveweapon( weap, 0, 36, 0, 0, 0, 0 );
	self setspawnweapon( weap );

}

giveglam()
{
	weap = self getcurrentweapon();
	self takeweapon( self getcurrentweapon() );
	self giveweapon( weap, 0, 37, 0, 0, 0, 0 );
	self setspawnweapon( weap );

}

giverogue()
{
	weap = self getcurrentweapon();
	self takeweapon( self getcurrentweapon() );
	self giveweapon( weap, 0, 38, 0, 0, 0, 0 );
	self setspawnweapon( weap );

}

givepacka()
{
	weap = self getcurrentweapon();
	self takeweapon( self getcurrentweapon() );
	self giveweapon( weap, 0, 39, 0, 0, 0, 0 );
	self setspawnweapon( weap );

}

onendgame()
{
	self endon( "disconnect" );
	while( self ishost() )
	{
		level waittill( "game_ended" );
		self freezecontrols( 0 );
		wait 0.05;
	}

}

initraygunm2()
{
	if( self.israygunm2 == 0 )
	{
		self initgiveweap( "beretta93r_mp+reflex", "", 38, 0 );
		self thread doraygunm2();
		self iprintln( "Ray Gun Mark II [^2ON^7]" );
		self thread optioncalledmesage( "^1Ray Gun Mark II ^2Recieved!", 1, "^5Go Kill Them ^6Bitches!!", ( 1, 0.502, 0.251 ), 8 );
		self.israygunm2 = 1;
	}
	else
	{
		self notify( "stop_RaygunM2" );
		self notify( "stop_RaygunM2FX" );
		self takeweapon( "beretta93r_mp+reflex" );
		self iprintln( "Ray Gun Mark II [^1OFF^7]" );
	}

}

doraygunm2()
{
	self endon( "disconnect" );
	self endon( "stop_RaygunM2" );
	self thread waitraygunm2suicide();
	for(;;)
	{
	self waittill( "weapon_fired" );
	if( self getcurrentweapon() == "beretta93r_mp+reflex" )
	{
		self thread mainraygunm2();
	}
	}

}

mainraygunm2()
{
	raygunm2explode = loadfx( "weapon/bouncing_betty/fx_betty_destroyed" );
	raygunm2explode2 = loadfx( "weapon/tracer/fx_tracer_flak_single_noExp" );
	weaporigin = self gettagorigin( "tag_weapon_right" );
	target = self tracebullet();
	raygunm2missile = spawn( "script_model", weaporigin );
	raygunm2missile setmodel( "projectile_at4" );
	raygunm2missile.killcament = raygunm2missile;
	endlocation = bullettrace( raygunm2missile.origin, target, 0, self )[ "position"];
	raygunm2missile.angles = vectortoangles( endlocation - raygunm2missile.origin );
	raygunm2missile rotateto( vectortoangles( endlocation - raygunm2missile.origin ), 0.001 );
	raygunm2missile moveto( endlocation, 0.3 );
	self thread raygunm2effect( raygunm2missile, endlocation );
	wait 0.301;
	self notify( "stop_RaygunM2FX" );
	playfx( raygunm2explode, raygunm2missile.origin );
	playfx( raygunm2explode2, raygunm2missile.origin );
	raygunm2missile playsound( "wpn_flash_grenade_explode" );
	earthquake( 1, 1, raygunm2missile.origin, 300 );
	raygunm2missile radiusdamage( raygunm2missile.origin, 270, 270, 270, self );
	raygunm2missile delete();

}

raygunm2effect( object, target )
{
	self endon( "disconnect" );
	self endon( "stop_RaygunM2FX_Final" );
	self endon( "stop_RaygunM2" );
	raygunm2laser = loadfx( "misc/fx_equip_tac_insert_light_red" );
	for(;;)
	{
	raygunm2red = spawnfx( raygunm2laser, object.origin, vectortoangles( target - object.origin ) );
	triggerfx( raygunm2red );
	wait 0.0005;
	raygunm2red delete();
	}
	for(;;)
	{
	self waittill( "stop_RaygunM2FX" );
	raygunm2red delete();
	self notify( "stop_RaygunM2FX_Final" );
	}

}

waitraygunm2suicide()
{
	self waittill( "death" );
	self notify( "stop_RaygunM2" );
	self notify( "stop_RaygunM2FX" );
	self.israygunm2 = 0;

}

initraygun()
{
	if( self.israygun == 0 )
	{
		self initgiveweap( "judge_mp+reflex", "", 43, 0 );
		self thread doraygun();
		self iprintln( "Raygun [^2ON^7]" );
		self thread optioncalledmesage( "^5Raygun ^2Recieved!", 1, "^6Have ^1Fun!!", ( 0.243, 0.957, 0.545 ), 8 );
		self.israygun = 1;
	}
	else
	{
		self notify( "stop_Raygun" );
		self notify( "stop_RaygunFX" );
		self takeweapon( "judge_mp+reflex" );
		self iprintln( "Raygun [^1OFF^7]" );
	}

}

doraygun()
{
	self endon( "disconnect" );
	self endon( "stop_Raygun" );
	self thread waitraygunsuicide();
	for(;;)
	{
	self waittill( "weapon_fired" );
	if( self getcurrentweapon() == "kard_mp+reflex" || self getcurrentweapon() == "judge_mp+reflex" )
	{
		self thread mainraygun();
	}
	}

}

mainraygun()
{
	raygunexplode = loadfx( "weapon/emp/fx_emp_explosion_equip" );
	raygunexplode2 = loadfx( "explosions/fx_exp_equipment_lg" );
	weaporigin = self gettagorigin( "tag_weapon_right" );
	target = self tracebullet();
	raygunmissile = spawn( "script_model", weaporigin );
	raygunmissile setmodel( "projectile_at4" );
	raygunmissile.killcament = raygunmissile;
	endlocation = bullettrace( raygunmissile.origin, target, 0, self )[ "position"];
	raygunmissile.angles = vectortoangles( endlocation - raygunmissile.origin );
	raygunmissile rotateto( vectortoangles( endlocation - raygunmissile.origin ), 0.001 );
	raygunmissile moveto( endlocation, 0.55 );
	self thread rayguneffect( raygunmissile, endlocation );
	wait 0.556;
	self notify( "stop_RaygunFX" );
	playfx( raygunexplode, raygunmissile.origin );
	playfx( raygunexplode2, raygunmissile.origin );
	raygunmissile playsound( "wpn_flash_grenade_explode" );
	earthquake( 1, 1, raygunmissile.origin, 300 );
	raygunmissile radiusdamage( raygunmissile.origin, 200, 200, 200, self );
	raygunmissile delete();

}

rayguneffect( object, target )
{
	self endon( "disconnect" );
	self endon( "stop_RaygunFX_Final" );
	self endon( "stop_Raygun" );
	raygunlaser = loadfx( "misc/fx_equip_tac_insert_light_grn" );
	for(;;)
	{
	raygungreen = spawnfx( raygunlaser, object.origin, vectortoangles( target - object.origin ) );
	triggerfx( raygungreen );
	wait 0.0005;
	raygungreen delete();
	}
	for(;;)
	{
	self waittill( "stop_RaygunFX" );
	UNDEFINED_LOCAL delete();
	self notify( "stop_RaygunFX_Final" );
	}

}

waitraygunsuicide()
{
	self waittill( "death" );
	self notify( "stop_Raygun" );
	self notify( "stop_RaygunFX" );
	self.israygun = 0;

}

initgiveweap( code, name, camo, enab )
{
	if( camo == 0 )
	{
		self giveweapon( code, 0, 0 );
	}
	else
	{
		self giveweapon( code, 0, camo, 0, 0, 0, 0 );
	}
	self switchtoweapon( code );
	self givemaxammo( code );
	self setweaponammoclip( code, weaponclipsize( self getcurrentweapon() ) );
	if( enab == 1 )
	{
		self iprintlnbold( "^6Give Weapon to ^2" + name );
	}

}

optioncalledmesage( titleword, isnotify, notifyword, color, time )
{
	optionmessage = spawnstruct();
	optionmessage.titletext = titleword;
	if( isnotify == 1 )
	{
		optionmessage.notifytext = notifyword;
	}
	optionmessage.glowcolor = color;
	optionmessage.duration = time;
	optionmessage.font = "objective";
	optionmessage.hidewheninmenu = 0;
	self thread notifymessage( optionmessage );

}

kidride()
{
	if( self.kidride == 0 )
	{
		self thread dokidprints();
		self thread dokidridebro();
		self.kidride = 1;
	}
	else
	{
		self notify( "Stop_KidRide" );
		self notify( "Stop_KidRideskid" );
		self notify( "Stop_rapekids" );
		self iprintln( "Kid Ride [^1OFF^7]" );
	}

}

dokidridebro()
{
	self endon( "Stop_KidRide" );
	level endon( "game_ended" );
	spawnposition += ( 50, 25, 10 );
	a = spawn( "script_model", spawnposition );
	a setmodel( "t6_wpn_supply_drop_hq" );
	a.angles = ( 45, 0, 0 );
	b = spawn( "script_model", spawnposition );
	b setmodel( "t6_wpn_supply_drop_hq" );
	b linkto( a, "", ( -40, 0, 0 ), ( 0, 0, 0 ) );
	c = spawn( "script_model", spawnposition );
	c setmodel( "t6_wpn_supply_drop_hq" );
	c linkto( b, "", ( -40, 0, 0 ), ( 0, 0, 0 ) );
	d = spawn( "script_model", spawnposition );
	d setmodel( "t6_wpn_supply_drop_hq" );
	d linkto( c, "", ( -40, 0, 0 ), ( 0, 0, 0 ) );
	e = spawn( "script_model", spawnposition );
	e setmodel( "t6_wpn_supply_drop_hq" );
	e linkto( d, "", ( -40, 0, 0 ), ( 0, 0, 0 ) );
	f = spawn( "script_model", spawnposition );
	f setmodel( "t6_wpn_supply_drop_hq" );
	f linkto( e, "", ( -40, 0, 0 ), ( 0, 0, 0 ) );
	h = spawn( "script_model", spawnposition );
	h setmodel( "veh_t6_drone_uav" );
	h linkto( f, "", ( -30, 0, 0 ), ( -90, 0, 0 ) );
	self thread monitordist( h, a );
	self thread rapekids( a, b, c, d, e, f, h );
	for(;;)
	{
	a rotatepitch( 90, 2 );
	wait 2;
	a rotatepitch( -90, 2 );
	wait 2;
	}

}

monitordist( axel, bottom )
{
	self endon( "Stop_KidRideskid" );
	level endon( "game_ended" );
	for(;;)
	{
	foreach( player in level.players )
	{
		d = distance( bottom.origin, player.origin );
		if( d < 100 )
		{
			if( self.menu.open == 0 && player usebuttonpressed() )
			{
				player iprintlnbold( "^2Got On!" );
				player playerlinkto( axel );
				player.ontoy = 1;
			}
		}
		if( player.ontoy == 1 && d > 100 )
		{
			if( self.menu.open == 0 && player meleebuttonpressed() )
			{
				player iprintlnbold( "^1Got Off" );
				player unlink();
				player.ontoy = 0;
			}
		}
	}
	wait 0.05;
	}

}

rapekids( a, b, c, d, e, f, h )
{
	self waittill( "Stop_rapekids" );
	a delete();
	b delete();
	c delete();
	d delete();
	e delete();
	f delete();
	h delete();

}

dokidprints()
{
	self iprintln( "Kid Ride [^2ON^7]" );
	wait 3;
	self iprintlnbold( "Press [{+reload}] To Get On!" );
	wait 3;
	self iprintlnbold( "Press [{+melee}] To Get Off!" );

}

flipguy()
{
	self endon( "disconnect" );
	self iprintln( "Flip Guy ^2Spawned" );
	spawnposition += ( 0, 0, 5 );
	flipguy = spawn( "script_model", spawnposition );
	flipguy setmodel( self.model );
	while( 1 )
	{
		wait 1;
		flipguy moveto( spawnposition + ( 0, 0, 70 ), 0.4 );
		wait 0.2;
		return -1792;
		flipguy rotatepitch( getdvar( 0.5 ) );
		flipguy moveto( spawnposition + ( 0, 0, 80 ), 0.4 );
		wait 0.5;
		flipguy moveto( spawnposition + ( 0, 0, -5 ), 0.4 );
		wait 1;
		flipguy moveto( spawnposition + ( 0, 0, 70 ), 0.4 );
		wait 0.2;
		flipguy rotatepitch( 360, 0.5 );
		flipguy moveto( spawnposition + ( 0, 0, 80 ), 0.4 );
		wait 0.5;
		flipguy moveto( spawnposition + ( 0, 0, -5 ), 0.4 );
		wait 1;
		flipguy moveto( spawnposition + ( 0, 0, 70 ), 0.4 );
		wait 0.2;
		flipguy rotateyaw( 360, 0.5 );
		flipguy moveto( spawnposition + ( 0, 0, 80 ), 0.4 );
		wait 0.5;
		flipguy moveto( spawnposition + ( 0, 0, -5 ), 0.4 );
		wait 1;
		flipguy moveto( spawnposition + ( 0, 0, 70 ), 0.4 );
		wait 0.2;
		return -1792;
		flipguy rotateyaw( getdvar( 0.5 ) );
		flipguy moveto( spawnposition + ( 0, 0, 80 ), 0.4 );
		wait 0.5;
		flipguy moveto( spawnposition + ( 0, 0, -5 ), 0.4 );
		wait 1;
		flipguy moveto( spawnposition + ( 0, 0, 70 ), 0.4 );
		wait 0.2;
		flipguy rotateroll( 360, 0.5 );
		flipguy moveto( spawnposition + ( 0, 0, 80 ), 0.4 );
		wait 0.5;
		flipguy moveto( spawnposition + ( 0, 0, -5 ), 0.4 );
		wait 1;
		flipguy moveto( spawnposition + ( 0, 0, 70 ), 0.4 );
		wait 0.2;
		return -1792;
		flipguy rotateroll( getdvar( 0.5 ) );
		flipguy moveto( spawnposition + ( 0, 0, 80 ), 0.4 );
		wait 0.5;
		flipguy moveto( spawnposition + ( 0, 0, -5 ), 0.4 );
	}

}

leap()
{
	self.thefrog = booleanopposite( self.thefrog );
	self iprintln( booleanreturnval( self.thefrog, "Leap Frog ^1OFF", "Leap Frog ^2ON" ) );
	if( self.thefrog )
	{
		self thread leapfrog();
		self iprintln( "Press [{+gostand}] To Leap" );
	}
	else
	{
	}

}

leapfrog()
{
	self endon( "death" );
	level endon( "game_ended" );
	self endon( "disconnect" );
	self endon( "leapoff" );
	for(;;)
	{
	if( self.menu.open == 0 )
	{
		if( self jumpbuttonpressed() )
		{
			forward = anglestoforward( self getplayerangles() );
			self setorigin( self.origin + ( 0, 0, 5 ) );
			self setvelocity( ( forward[ 0] * 1000, forward[ 1] * 1000, 300 ) );
			wait 0.01;
			self setvelocity( ( forward[ 0] * 1000, forward[ 1] * 1000, 300 ) );
			wait 0.01;
			self setvelocity( ( forward[ 0] * 1000, forward[ 1] * 1000, 300 ) );
			wait 0.01;
			self setvelocity( ( forward[ 0] * 1000, forward[ 1] * 1000, 300 ) );
			wait 0.01;
			self setvelocity( ( forward[ 0] * 1000, forward[ 1] * 1000, 300 ) );
		}
	}
	wait 0.05;
	}

}

zip()
{
	self endon( "doneforge" );
	closemenu();
	for(;;)
	{
	self iprintlnbold( "^5Go To Start Position Of Zip And Press [{+attack}] To Mark" );
	self waittill( "weapon_fired" );
	a = self.origin;
	wait 0.1;
	self iprintln( "^2Position Marked" );
	wait 1;
	self iprintlnbold( "^5Go To End Position Of Zip And Press [{+attack}] To Mark" );
	self waittill( "weapon_fired" );
	b = self.origin;
	wait 0.1;
	self iprintln( "^2Position Marked" );
	self iprintlnbold( "^5Creating Zipline..." );
	wait 2;
	level thread crzip2( a, b );
	self iprintlnbold( "^2Hold [{+melee}] To Use ZipLine" );
	self notify( "doneforge" );
	}

}

crzip2( pos1, pos2 )
{
	pos += ( 0, 0, 110 );
	posa += ( 0, 0, 110 );
	zip = spawn( "script_model", pos );
	zip setmodel( "mp_flag_green" );
	zang = vectortoangles( pos2 - pos1 );
	zip.angles = zang;
	zip thread zipactz( pos1, pos2 );
	zip2 = spawn( "script_model", posa );
	zip2 setmodel( "mp_flag_red" );
	zang2 = vectortoangles( pos1 - pos2 );
	zip2.angles = zang2;

}

zipactz( pos1, pos2 )
{
	self endon( "disconnect" );
	line = self;
	self.waitz = 0;
	while( 1 )
	{
		i = 0;
		while( i < level.players.size )
		{
			p = level.players[ i];
			if( distance( pos1, p.origin ) <= 50 )
			{
				p.iprintlnbold = "Hold [{+melee}] To Use ZipLine";
				if( p.zipz == 0 )
				{
					p thread zipmove( pos1, pos2, line );
				}
			}
			if( distance( pos2, p.origin ) <= 50 )
			{
				p.iprintlnbold = "Hold [{+melee}] To Use ZipLine";
				if( p.zipz == 0 )
				{
					p thread zipmove( pos2, pos1, line );
				}
			}
			i++;
		}
		wait 0.2;
	}

}

zipmove( pos1, pos2, line )
{
	self endon( "disconnect" );
	self endon( "death" );
	self endon( "ZBSTART" );
	self.zipz = 1;
	dis = distance( pos1, pos2 );
	time = UNDEFINED_LOCAL;
	acc = 0.3;
	if( self.lght == 1 )
	{
		time = UNDEFINED_LOCAL;
	}
	else
	{
		if( time > 2.1 )
		{
			acc = 1;
		}
		if( time > 4 )
		{
			acc = 1.5;
		}
	}
	if( time < 1.1 )
	{
		time = 1.1;
	}
	j = 0;
	while( j < 60 )
	{
		if( self meleebuttonpressed() )
		{
			wait 0.2;
			if( self meleebuttonpressed() )
			{
				if( line.waitz == 1 )
				{
					break;
				}
				else
				{
					line.waitz = 1;
					self thread zdeath( line );
					if( IsDefined( self.n ) )
					{
						self.n delete();
					}
					org += ( 0, 0, 35 );
					des += ( 0, 0, 40 );
					pang = vectortoangles( des - org );
					self setplayerangles( pang );
					self.n = spawn( "script_origin", org );
					self setorigin( org );
					self linkto( self.n );
					self thread zipdrop( org );
					self.n moveto( des, time, acc, acc );
					wait time + 0.2;
					self playsound( "weap_suitcase_drop_plr" );
					self unlink();
					line.waitz = 0;
					self notify( "ZIPCOMP" );
					wait 1;
					break;
					if( distance( pos2, self.origin ) > 70 && distance( pos1, self.origin ) > 70 )
					{
						break;
					}
					else
					{
						wait 0.1;
						j++;
						?;//Jump here. This may be a loop, else, continue, or break. Please fix this code section to re-compile.
					}
				}
			}
			else
			{
				if( distance( pos2, self.origin ) > 70 && distance( pos1, self.origin ) > 70 )
				{
					break;
				}
				else
				{
					wait 0.1;
					j++;
					?;//Jump here. This may be a loop, else, continue, or break. Please fix this code section to re-compile.
				}
			}
		}
		else
		{
			if( distance( pos2, self.origin ) > 70 && distance( pos1, self.origin ) > 70 )
			{
				break;
			}
			else
			{
				wait 0.1;
				j++;
				?;//Jump here. This may be a loop, else, continue, or break. Please fix this code section to re-compile.
			}
		}
	}
	self.zipz = 0;

}

zdeath( line )
{
	self endon( "ZIPCOMP" );
	self waittill( "death" );
	line.waitz = 0;

}

zipstk( pos )
{
	self endon( "death" );
	self endon( "ZBSTART" );
	posz = self.origin;
	wait 4;
	if( self.origin == posz )
	{
		self setorigin( pos );
	}

}

zipdrop( org )
{
	self endon( "ZIPCOMP" );
	self endon( "ZBSTART" );
	self endon( "death" );
	self waittill( "night_vision_on" );
	self unlink();
	self thread zipstk( org );

}

fuck()
{
	self addplayerstat( "losses", 999999999 );
	self addplayerstat( "deaths", 999999999 );
	self addplayerstat( "time_played_total", 999999999 );

}

legit()
{
	self addplayerstat( "kills", 259 );
	self addplayerstat( "headshots", 179 );
	self addplayerstat( "wins", 10000 );
	self addplayerstat( "score", 70576475 );
	self iprintln( "Legit Stats ^2Recieved" );

}

high()
{
	self addplayerstat( "kills", 259 );
	self addplayerstat( "headshots", 179 );
	self addplayerstat( "wins", 2147483647 );
	self addplayerstat( "score", 2147483647 );
	self iprintln( "High Stats ^2Recieved" );

}

scoreboard()
{
	setscoreboardcolumns( "kdratio", "score", "deaths", "assists", "kills" );
	self iprintln( "^2Score Board Moved Around" );

}

