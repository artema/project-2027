//=============================================================================
// ��������. �������� Ded'�� ��� ���� 2027
// Cigarettes. Copyright (C) 2003 Ded
// ����� ������/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class CigarettesOld extends Cigarettes;

simulated function Tick(float deltaTime)
{    
	local Cigarettes cigs;
	
	Super.Tick(deltaTime);
	
	cigs = spawn(class'Cigarettes', None,, Location, Rotation);
	cigs.SetPhysics(Physics);
	cigs.SetCollisionSize(CollisionRadius, CollisionHeight);	
	cigs.Velocity = Velocity;
	cigs.bFixedRotationDir = bFixedRotationDir;
	cigs.RotationRate = RotationRate;
	
	switch (SkinType)
	{
		case ECigSkin.ES_Camel:
			cigs.bCamelSkin = True;
			break;
			
		default:
			cigs.bCamelSkin = False;
			break;
	}
	
	Destroy();
}

defaultproperties
{
		PlayerViewMesh=LodMesh'GameMedia.CigarettesOld';
     	PickupViewMesh=LodMesh'GameMedia.CigarettesOld';
     	ThirdPersonMesh=LodMesh'GameMedia.CigarettesOld';
     	Mesh=LodMesh'GameMedia.CigarettesOld';
}
