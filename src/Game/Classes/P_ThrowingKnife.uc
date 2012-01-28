//=============================================================================
// ����������� ���. �������� Ded'�� ��� ���� 2027
// Shuriken. Copyright (C) 2003 Ded
//=============================================================================
class P_ThrowingKnife extends DeusExProjectile;

var bool bLanded;

simulated function Tick(float deltaTime)
{
	local Rotator rot;

	if (bStuck || bRicocheted)
		return;

	Super.Tick(deltaTime);

	if (Level.Netmode != NM_DedicatedServer)
	{
		rot = Rotation;
		rot.Roll += 16384;
		rot.Pitch -= 16384;
		SetRotation(rot);
	}
}

function PlayRicochet(vector HitNormal)
{
	bRotateToDesired = False;
	bFixedRotationDir = True;
	RotationRate.Pitch = (32768 - Rand(65536)) * 8.0;
	RotationRate.Yaw = (32768 - Rand(65536)) * 8.0;
	RotationRate.Roll = (32768 - Rand(65536)) * 8.0;

	Acceleration = Region.Zone.ZoneGravity;
	
	PlaySound(Sound'DeusExSounds.Generic.MetalHit1', SLOT_None, TransientSoundVolume,, 356);
	
	AISendEvent('LoudNoise', EAITYPE_Audio, TransientSoundVolume, 356);
}

defaultproperties
{
     bBlood=True
     bStickToWall=True
     bMeleeDamage=True
     DamageType='Shot'
     Damage=30
     AccurateRange=640
     maxRange=1280
     bIgnoresNanoDefense=True
     spawnWeaponClass=Class'Game.WeaponThrowingKnife'
     speed=750.000000
     MaxSpeed=750.000000
     MomentumTransfer=1000
     ImpactSound=Sound'DeusExSounds.Generic.BulletHitFlesh'
     Mesh=LodMesh'DeusExItems.ShurikenPickup'
     CollisionRadius=5.000000
     CollisionHeight=0.300000
}
