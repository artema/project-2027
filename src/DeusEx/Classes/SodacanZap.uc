//=============================================================================
// ���������. ������� Ded'�� ��� ���� 2027
// Soda can. Copyright (C) 2003 Ded
// ����� ������/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class SodacanZap extends Sodacan;

simulated function Tick(float deltaTime)
{    
	local Sodacan soda;
	
	Super.Tick(deltaTime);
	
	soda = spawn(class'Sodacan', None,, Location, Rotation);
	soda.SetPhysics(Physics);
	soda.SetCollisionSize(CollisionRadius, CollisionHeight);	
	soda.Velocity = Velocity;
	soda.bFixedRotationDir = bFixedRotationDir;
	soda.RotationRate = RotationRate;
	soda.SkinType = ES_Zap;
	Destroy();
}

defaultproperties
{
	ItemName="Soda"
	PickupViewMesh=LodMesh'DeusExItems.TestBox'
	Mesh=LodMesh'DeusExItems.TestBox'
}