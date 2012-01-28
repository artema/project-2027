//=============================================================================
// Шар. Сделанно Ded'ом для мода 2027
// Ball. Copyright (C) 2003 Ded
// Автор модели/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class Poolball extends DeusExDecoration;

enum ESkinColor
{
	SC_1,
	SC_2,
	SC_3,
	SC_4,
	SC_5,
	SC_6,
	SC_7,
	SC_8,
	SC_9,
	SC_10,
	SC_11,
	SC_12,
	SC_13,
	SC_14,
	SC_15,
	SC_Cue
};

var() ESkinColor SkinColor;
var bool bJustHit;

function BeginPlay()
{
	Super.BeginPlay();

	switch (SkinColor)
	{
		case SC_1:		MultiSkins[1] = Texture'GameMedia.Skins.MyPoolballTex1'; break;
		case SC_2:		MultiSkins[1] = Texture'GameMedia.Skins.MyPoolballTex2'; break;
		case SC_3:		MultiSkins[1] = Texture'GameMedia.Skins.MyPoolballTex3'; break;
		case SC_4:		MultiSkins[1] = Texture'GameMedia.Skins.MyPoolballTex4'; break;
		case SC_5:		MultiSkins[1] = Texture'GameMedia.Skins.MyPoolballTex5'; break;
		case SC_6:		MultiSkins[1] = Texture'GameMedia.Skins.MyPoolballTex6'; break;
		case SC_7:		MultiSkins[1] = Texture'GameMedia.Skins.MyPoolballTex7'; break;
		case SC_8:		MultiSkins[1] = Texture'GameMedia.Skins.MyPoolballTex8'; break;
		case SC_9:		MultiSkins[1] = Texture'GameMedia.Skins.MyPoolballTex9'; break;
		case SC_10:		MultiSkins[1] = Texture'GameMedia.Skins.MyPoolballTex10'; break;
		case SC_11:		MultiSkins[1] = Texture'GameMedia.Skins.MyPoolballTex11'; break;
		case SC_12:		MultiSkins[1] = Texture'GameMedia.Skins.MyPoolballTex12'; break;
		case SC_13:		MultiSkins[1] = Texture'GameMedia.Skins.MyPoolballTex13'; break;
		case SC_14:		MultiSkins[1] = Texture'GameMedia.Skins.MyPoolballTex14'; break;
		case SC_15:		MultiSkins[1] = Texture'GameMedia.Skins.MyPoolballTex15'; break;
		case SC_Cue:	        MultiSkins[1] = Texture'GameMedia.Skins.MyPoolballTex0'; break;
	}
}

function Tick(float deltaTime)
{
	local float speed;

	speed = VSize(Velocity);

	if ((speed >= 0) && (speed < 5))
	{
		bFixedRotationDir = False;
		Velocity = vect(0,0,0);
	}
	else if (speed >= 5)
	{
		bFixedRotationDir = True;
		SetRotation(Rotator(Velocity));
		RotationRate.Pitch = speed * 60000;
	}
}

event HitWall(vector HitNormal, actor HitWall)
{
	local Vector newloc;

	if (HitNormal.Z == 1.0)
	{
		SetPhysics(PHYS_Rolling, HitWall);
		if (Physics == PHYS_Rolling)
		{
			bFixedRotationDir = False;
			Velocity = vect(0,0,0);
			return;
		}
	}

	Velocity = 0.9*((Velocity dot HitNormal) * HitNormal * (-2.0) + Velocity);
	Velocity.Z = 0;
	newloc = Location + HitNormal;	// move it out from the wall a bit
	SetLocation(newloc);
}

function Timer()
{
	bJustHit = False;
}

function Bump(actor Other)
{
	local Vector HitNormal;

	if (Other.IsA('Poolball'))
	{
		if (!Poolball(Other).bJustHit)
		{
			PlaySound(sound'PoolballClack', SLOT_None);
			HitNormal = Normal(Location - Other.Location);
			Velocity = HitNormal * VSize(Other.Velocity);
			Velocity.Z = 0;
			bJustHit = True;
			Poolball(Other).bJustHit = True;
			SetTimer(0.02, False);
			Poolball(Other).SetTimer(0.02, False);
		}
	}
}

function Frob(Actor Frobber, Inventory frobWith)
{
	Velocity = Normal(Location - Frobber.Location) * 400;
	Velocity.Z = 0;
}

defaultproperties
{
     bInvincible=True
     ItemName="Шар"
     bPushable=False
     Physics=PHYS_Rolling
     Mesh=LodMesh'GameMedia.BallPool'
     CollisionRadius=1.700000
     CollisionHeight=1.700000
     bBounce=True
     Mass=5.000000
     Buoyancy=2.000000
}
