//=============================================================================
// ������� �������. �������� Ded'�� ��� ���� 2027
// Riot grenade. Copyright (C) 2003 Ded
//=============================================================================
class P_RiotGrenade extends GasGrenade;

simulated function Tick(float deltaTime)
{
      Super.Tick(deltaTime);

     MultiSkins[0]=Texture'DeusExItems.Skins.GasGrenadeTex1';
}

simulated function SpawnEffects(Vector HitLocation, Vector HitNormal, Actor Other)
{
	local ExplosionLight light;
    local SFXExplosionFragmented expeffect;
    local float dist;
    local DeusExPlayer player;

	player = DeusExPlayer(GetPlayerPawn());
	dist = Abs(VSize(player.Location - Location));
	
	if (dist ~= 0)
		dist = 10.0;

	if(dist < blastRadius * 2)
		player.ClientFlash(FClamp(blastRadius/dist, 0.0, 4.0), vect(0,1000,100));

	PlaySound(Sound'DeusExSounds.Weapons.GasGrenadeExplode', SLOT_None, 2.0,, blastRadius*16);
	AISendEvent('LoudNoise', EAITYPE_Audio, 2.0, blastRadius*16);
	
	if(bEmitWeaponShot)
		AISendEvent('WeaponFire', EAITYPE_Audio, 2.0, blastRadius*5);

	SpawnTearGas();

	expeffect = Spawn(class'SFXExplosionFragmented',,, HitLocation);
	
	if(expeffect != None)
		expeffect.ScaleFactor = 0.6;

	light = Spawn(class'ExplosionLight',,, HitLocation);

	if (light != None)
	{
		if (!bDamaged)
			light.RemoteRole = ROLE_None;

		light.size = 8;
		light.LightHue = 80;
		light.LightSaturation = 96;
		light.LightEffect = LE_Shell;
	}
}

function SpawnTearGas()
{
	local Vector loc;
	local TearGas gas;
	local int i;

	if ( Role < ROLE_Authority )
		return;

	for (i=0; i<blastRadius/36; i++)
	{
		if (FRand() < 0.9)
		{
			loc = Location;
			loc.X += FRand() * blastRadius - blastRadius * 0.5;
			loc.Y += FRand() * blastRadius - blastRadius * 0.5;
			loc.Z += 32;
			gas = spawn(class'TearGas', None,, loc);
			if (gas != None)
			{
				gas.Velocity = vect(0,0,0);
				gas.Acceleration = vect(0,0,0);
				gas.DrawScale = FRand() * 0.5 + 2.0;
				gas.LifeSpan = FRand() * 10 + 30;
				if ( Level.NetMode != NM_Standalone )
					gas.bFloating = False;
				else
					gas.bFloating = True;
				gas.Instigator = Instigator;
			}
		}
	}
}

defaultproperties
{
     MultiSkins(0)=Texture'DeusExItems.Skins.GasGrenadeTex1'
     bBlood=False
     bDebris=False
     DamageType=TearGas
     spawnWeaponClass=Class'Game.WeaponRiotGrenade'
     Damage=10.0
     Mesh=LodMesh'DeusExItems.GasGrenadePickup'
     CollisionRadius=4.3
     CollisionHeight=1.4
}