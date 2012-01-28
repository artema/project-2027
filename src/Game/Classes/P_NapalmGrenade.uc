//=============================================================================
// ����������� �������. �������� Ded'�� ��� ���� 2027
// Napalm grenade. Copyright (C) 2003 Ded
//=============================================================================
class P_NapalmGrenade extends GrenadeProjectile;

#exec OBJ LOAD FILE=GameEffects

simulated function SpawnEffects(Vector HitLocation, Vector HitNormal, Actor Other)
{
	local int i;
	local SFXExplosionLight light;
	local ParticleGenerator PhosGen;
	local ParticleGenerator FireGen;
    local ParticleGenerator SmokeGen;
    local float dist;
    local vector loc;
	local rotator rot;
    local DeusExPlayer player;
    local SFXExplosionSmallPuff puff;
    
    Super.SpawnEffects(HitLocation, HitNormal, Other);
    
    player = DeusExPlayer(GetPlayerPawn());
	dist = Abs(VSize(player.Location - Location));
	
	if (dist ~= 0)
		dist = 10.0;

	if(dist < blastRadius * 2)
		player.ClientFlash(FClamp(blastRadius/dist, 0.0, 4.0), vect(1000,1000,900));

	light = Spawn(class'SFXExplosionLight',,, HitLocation);
	
	if (light != None)
		light.size = 12;
		
	puff = Spawn(class'SFXExplosionSmallPuff',,, HitLocation);

	if(puff != None)
		puff.ScaleFactor = 1.75;

	spawn(class'SFXSmokeAfterExplosion',,, loc);

	/*for (i=0; i<blastRadius/32; i++)
	{
		if (FRand() < 0.9)
		{
			loc = Location;
			loc.X += FRand() * blastRadius - blastRadius * 0.5;
			loc.Y += FRand() * blastRadius - blastRadius * 0.5;

			spawn(class'SFXSmokeAfterExplosion',,, loc);
		}
	}*/

	PhosGen = Spawn(class'ParticleGenerator',,, HitLocation, Rotator(HitNormal));
	if (PhosGen != None)
	{
		PhosGen.particleDrawScale = 0.35;
		PhosGen.checkTime = 0.05;
		PhosGen.frequency = 2.0;
		PhosGen.ejectSpeed = 200.0;
		PhosGen.bGravity = True;
		PhosGen.bRandomEject = True;
		PhosGen.particleTexture = Texture'GameEffects.Fire.CFire_A000';//GameEffects.Fire.FireballWhite
		PhosGen.LifeSpan = 2.0;
	}

	FireGen = Spawn(class'ParticleGenerator',,, HitLocation, Rotator(HitNormal));
	if (FireGen != None)
	{
		FireGen.particleDrawScale = 0.6;
		FireGen.checkTime = 0.02;
		FireGen.frequency = 4.0;
		FireGen.ejectSpeed = 200.0;
		FireGen.bGravity = True;
		FireGen.bRandomEject = True;
		FireGen.particleTexture = Texture'GameEffects.Fire.ef_TallFire_001';//GameEffects.Fire.Fireball1
		FireGen.LifeSpan = 1.5;
	}
	
	PlaySound(Sound'GameMedia.Weapons.NapalmExplode', SLOT_None, 2.0,, blastRadius*15);
	AISendEvent('LoudNoise', EAITYPE_Audio, 2.0, blastRadius*15);
	
	if(bEmitWeaponShot)
		AISendEvent('WeaponFire', EAITYPE_Audio, 2.0, blastRadius*10);
}

simulated function Tick(float deltaTime)
{
      Super.Tick(deltaTime);

     MultiSkins[0]=Texture'GameMedia.Skins.NapalmGrenadeTex0';
}

defaultproperties
{
     MultiSkins(0)=Texture'GameMedia.Skins.NapalmGrenadeTex0'
     blastRadius=700.0
     DamageType=Flamed
     spawnWeaponClass=Class'Game.WeaponNapalmGrenade'
     Damage=95.0
     ExplosionDecal=Class'DeusEx.ScorchMark'
     Mesh=LodMesh'DeusExItems.GasGrenadePickup'
     CollisionRadius=4.3
     CollisionHeight=1.4
}
