//=============================================================================
// �������. �������� Ded'�� ��� ���� 2027
// Candybar. Copyright (C) 2003 Ded
//=============================================================================
class CandybarDark extends Candybar;

simulated function Tick(float deltaTime)
{    
	local Candybar candy;
	
	Super.Tick(deltaTime);
	
	candy = spawn(class'Candybar', None,, Location, Rotation);
	candy.SetPhysics(Physics);
	candy.SetCollisionSize(CollisionRadius, CollisionHeight);	
	candy.Velocity = Velocity;
	candy.bFixedRotationDir = bFixedRotationDir;
	candy.RotationRate = RotationRate;
	candy.SkinType = ES_Dark;
	Destroy();
}

defaultproperties
{
     ItemName="Candybar"
     beltDescription="Candybar"
     PickupViewMesh=LodMesh'DeusExItems.TestBox'
	 Mesh=LodMesh'DeusExItems.TestBox'
}