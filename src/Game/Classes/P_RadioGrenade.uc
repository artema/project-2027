//=============================================================================
// ����� �������. �������� Ded'�� ��� ���� 2027
// Radio grenade. Copyright (C) 2003 Ded
//=============================================================================
class P_RadioGrenade extends NanoVirusGrenade;

simulated function SpawnEffects(Vector HitLocation, Vector HitNormal, Actor Other)
{
	local SFXExplosionLight light;
	local int i;
	local Rotator rot;
	local SFXSphereEffect sphere;
    local ExplosionSmall expeffect;
    local float dist;
    local DeusExPlayer player;

	player = DeusExPlayer(GetPlayerPawn());
	dist = Abs(VSize(player.Location - Location));
	
	if (dist ~= 0)
		dist = 10.0;

	if(dist < blastRadius * 2)
		player.ClientFlash(FClamp(blastRadius/dist, 0.0, 4.0), vect(0,200,1000));

	light = Spawn(class'SFXExplosionLight',,, HitLocation);
	
	if (light != None)
	{
		light.size = 8;
		light.LightHue = 128;
		light.LightSaturation = 96;
		light.LightEffect = LE_Shell;
	}

	//expeffect = Spawn(class'ExplosionSmall',,, HitLocation);

	sphere = Spawn(class'SFXSphereEffect',,, HitLocation);
	
	if (sphere != None)
		sphere.size = blastRadius / 32.0;
		
	PlaySound(Sound'DeusExSounds.Weapons.NanoVirusGrenadeExplode', SLOT_None, 2.0,, blastRadius*5);
	AISendEvent('LoudNoise', EAITYPE_Audio, 2.0, blastRadius*5);
}

simulated function Tick(float deltaTime)
{
      Super.Tick(deltaTime);

     MultiSkins[0]=Texture'DeusExItems.Skins.NanoVirusGrenadeTex1';
}

defaultproperties
{
     MultiSkins(0)=Texture'DeusExItems.Skins.NanoVirusGrenadeTex1'
     AISoundLevel=0.100000
     bBlood=False
     bDebris=False
     DamageType=NanoVirus
     spawnWeaponClass=Class'Game.WeaponRadioGrenade'
     Mesh=LodMesh'DeusExItems.NanoVirusGrenadePickup'
     CollisionRadius=2.630000
     CollisionHeight=4.410000
}