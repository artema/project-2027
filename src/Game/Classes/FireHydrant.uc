//===================================================================================
// �������� �������. �������� Ded'�� ��� ���� 2027
// Hydrant.  Copyright (C) 2003 Ded
//===================================================================================
class FireHydrant expands DeusExDecoration;

enum ESkinColor
{
	SC_Red,
	SC_Orange,
	SC_Blue,
	SC_Gray
};

var() ESkinColor SkinColor;

function BeginPlay()
{
	Super.BeginPlay();

	switch (SkinColor)
	{
		case SC_Red:	Skin = Texture'FirePlugTex1'; break;
		case SC_Orange:	Skin = Texture'FirePlugTex2'; break;
		case SC_Blue:	Skin = Texture'FirePlugTex3'; break;
		case SC_Gray:	Skin = Texture'FirePlugTex4'; break;
	}
}


function PostPostBeginPlay()
{
	Super.PostPostBeginPlay();

		TakeDamage(1, None, Location, vect(0,0,0), 'shot');
}

	
function Destroyed()
{
local ParticleGenerator gen;


		gen = Spawn(class'ParticleGenerator', Self,, Location, rot(16384,0,0));
		 if (gen != None)
		       {
			gen.LifeSpan = 10;
			gen.bRandomEject = True;
			gen.ejectSpeed = 180;
			gen.bGravity = True;
                        gen.riseRate = 50;
			gen.checkTime = 0.1;
			gen.particleLifeSpan = 2.0;
			gen.particleDrawScale = 1.0;
			gen.particleTexture = Texture'Effects.Smoke.SmokePuff1';
                        gen.bAmbientSound = True;
		        gen.SpawnSound = Sound'Ambient.Ambient.SteamVent';
                       }
}

defaultproperties
{
     HitPoints=25
     bHighlight=False
     bPushable=False
     bBlockSight=True
     Physics=PHYS_None
     Mesh=LodMesh'DeusExDeco.FirePlug'
     CollisionRadius=8.000000
     CollisionHeight=16.500000
     Mass=50.000000
     Buoyancy=30.000000
     BindName="FirePlug"
}
