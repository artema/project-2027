//=============================================================================
// �������. ������� Ded'�� ��� ���� 2027
// Cart. Copyright (C) 2003 Ded
// ����� ������/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class UtilityCart extends DeusExDecoration;

var float rollTimer;
var float pushTimer;
var vector pushVel;
var bool bJustPushed;

function StartRolling(vector vel)
{
	SetPhysics(PHYS_Rolling);
	pushVel = vel;
	pushVel.Z = 0;
	Velocity = pushVel;
	rollTimer = 2;
	bJustPushed = True;
	pushTimer = 0.5;
	AmbientSound = Sound'UtilityCart';
}

function Bump(actor Other)
{
	if (bJustPushed)
		return;

	if ((Other != None) && (Physics != PHYS_Falling))
		if (abs(Location.Z-Other.Location.Z) < (CollisionHeight+Other.CollisionHeight-1))
			StartRolling(0.25*Other.Velocity*Other.Mass/Mass);
}

function Tick(float deltaTime)
{
	Super.Tick(deltaTime);

	if ((Physics == PHYS_Rolling) && (rollTimer > 0))
	{
		rollTimer -= deltaTime;
		Velocity = pushVel;

		if (pushTimer > 0)
			pushTimer -= deltaTime;
		else
			bJustPushed = False;
	}

	if (VSize(Velocity) > 1)
	{
		SoundPitch = Clamp(2*VSize(Velocity), 32, 64);
	}
	else
	{
		AmbientSound = None;
		SoundPitch = Default.SoundPitch;
	}
}

defaultproperties
{
     ScaleGlow=0.400000
     bCanBeBase=True
     Mesh=LodMesh'GameMedia.UtilityCart'
     SoundRadius=16
     CollisionRadius=28.000000
     CollisionHeight=26.780001
     Mass=40.000000
     Buoyancy=45.000000
}
