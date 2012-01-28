//=============================================================================
// �����. �������� Ded'�� ��� ���� 2027
// Chips. Copyright (C) 2003 Ded
//=============================================================================
class Chips extends SoyFood;

simulated function Tick(float deltaTime)
{    
	local SoyFood candy;
	
	Super.Tick(deltaTime);
	
	candy = spawn(class'SoyFood', None,, Location, Rotation);
	candy.SetPhysics(Physics);
	candy.SetCollisionSize(CollisionRadius, CollisionHeight);	
	candy.Velocity = Velocity;
	candy.bFixedRotationDir = bFixedRotationDir;
	candy.RotationRate = RotationRate;
	candy.SkinType = ES_Chips;
	Destroy();
}

defaultproperties
{
     ItemName="Chips"
     beltDescription="Chips"
	 PickupViewMesh=LodMesh'DeusExItems.TestBox'
	 Mesh=LodMesh'DeusExItems.TestBox'
}