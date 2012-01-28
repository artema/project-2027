//=============================================================================
// ������ ���������. ������� Ded'�� ��� ���� 2027
// Truck wheel. Copyright (C) 2004 Ded
// ����� ������/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class TruckWheel extends DeusExDecoration;

var bool bFirstHit;

function Attach( Actor Other )
{
	Velocity.X = 0;
	Velocity.Y = 0;
	Velocity.Z = FMin(0, Velocity.Z);
}

function Timer()
{
	SetCollision(true,true,true);
}

function Bump( actor Other )
{
	if( Other.Mass >= 50 )
	{
		bBobbing = false;
		Velocity += 1.1 * VSize(Other.Velocity) * Normal(Location - Other.Location);
		if ( Physics == PHYS_None ) 
			Velocity.Z = FMax(Velocity.Z,150);
		SetPhysics(PHYS_Falling);
		SetTimer(0.3,False);
		Instigator = Pawn(Other);
	}
}

Auto State Animate
{
	function HitWall (vector HitNormal, actor Wall)
	{
		local float speed;

		Velocity = 0.9*(( Velocity dot HitNormal ) * HitNormal * (-2.0) + Velocity);
		speed = VSize(Velocity);
		if (bFirstHit && speed<400) 
			bFirstHit=False;

		If (speed < 50) 
			bBounce = False;
	}	

	function TakeDamage( int NDamage, Pawn instigatedBy, Vector hitlocation, 
						Vector momentum, name damageType)
	{
		if ( StandingCount > 0 )
			return;
		SetPhysics(PHYS_Falling);
		bBounce = False;
		Velocity += Momentum/(Mass*1.3);
		Velocity.Z = FMax(Momentum.Z, 100);
	}
}

defaultproperties
{
     bCanBeBase=True
     bHighlight=True
     HitPoints=60
     bInvincible=True
     bPushable=True
     bStatic=False
     bNetTemporary=True
     RemoteRole=0
     bNet=False
     Physics=PHYS_None
     FragType=Class'DeusEx.PlasticFragment'
     Mesh=Mesh'GameMedia.TruckWheel'
     CollisionRadius=26.000000
     CollisionHeight=12.000000
     bCollideActors=True
     bCollideWorld=True
     bBlockActors=True
     bBlockPlayers=True
     bProjTarget=True
     Mass=40.000000
     Buoyancy=40.000000
}