//=============================================================================
// ���������� ������. �������� Ded'�� ��� ���� 2027
// MiniCrossbow Dart. Copyright (C) 2003 Ded
//=============================================================================
class P_Dart extends DeusExProjectile;

function PlayRicochet(vector HitNormal)
{
	bRotateToDesired = False;
	bFixedRotationDir = True;
	RotationRate.Pitch = (32768 - Rand(65536)) * 2.0;
	RotationRate.Yaw = (32768 - Rand(65536)) * 8.0;
	RotationRate.Roll = (32768 - Rand(65536)) * 2.0;

	Acceleration = Region.Zone.ZoneGravity;
	
	PlaySound(Sound'DeusExSounds.Generic.MetalHit1', SLOT_None, TransientSoundVolume,, 356);
	
	AISendEvent('LoudNoise', EAITYPE_Audio, TransientSoundVolume, 356);
}

defaultproperties
{
     bMeleeDamage=True
     bBlood=True
     bStickToWall=True
     DamageType=Shot
     spawnAmmoClass=Class'DeusEx.RAmmoDart'
     bIgnoresNanoDefense=True
     speed=2000.000000
     MaxSpeed=3000.000000
     Damage=50
     MomentumTransfer=1000
     ImpactSound=Sound'DeusExSounds.Generic.BulletHitFlesh'
     Mesh=LodMesh'DeusExItems.Dart'
     CollisionRadius=3.000000
     CollisionHeight=0.500000
}