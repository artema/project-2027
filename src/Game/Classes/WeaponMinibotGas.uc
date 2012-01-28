//=======================================================
// ������ - ������� �������. �������� Ded'�� ��� ���� 2027
// Weapon - Gas grenade. Copyright (C) 2003 Ded
//=======================================================
class WeaponMinibotGas extends WeaponNPCMelee;

var() float blastRadius;

function name WeaponDamageType()
{
	return 'TearGas';
}

function Fire(float Value)
{
	SpawnTearGas();
	
	Super.Fire(Value);
}

function SpawnTearGas()
{
	local Vector loc;
	local TearGas gas;
	local int i;
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

	light = Spawn(class'ExplosionLight',,, Location);

	if (light != None)
	{
		light.size = 8;
		light.LightHue = 80;
		light.LightSaturation = 96;
		light.LightEffect = LE_Shell;
	}

	for (i=0; i<blastRadius/30; i++)
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
	 blastRadius=400
	 
	 HitDamage=1
	
     ShotTime=1.0
     reloadTime=5.0

     maxRange=256
     AccurateRange=256
     AIMaxRange=256

	 FireSound=Sound'DeusExSounds.Weapons.LAWFire'

     AmmoName=Class'DeusEx.RAmmoRiotGrenade'

     ReloadCount=1
     PickupAmmoCount=4
     
     bHandToHand=True
     bInstantHit=True
     //bFallbackWeapon=True

     //AITimeLimit=2.5
     AIFireDelay=10.0
}