//=============================================================================
// ����������. ������� Ded'�� ��� ���� 2027
// Outforcer. Copyright (C) 2004 Ded 
// ����� ������/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class Outforcer extends StaticMeshes;

var HighLight light;
var() sound beepSound;
var() int PauseFactor;
var bool bOn;

function PostBeginPlay()
{
	Super.BeginPlay();

        MultiSkins[2] = Texture'BlackMaskTex';
	SetTimer(1,False);
	bOn = True;
}

simulated function Timer()
{
	bOn = !bOn;

	if (light == None)
	{
		light = Spawn(class'HighLight', Self,, Location+vect(0,0,32));
		light.LightType = LT_None;
		light.LightBrightness = 128;
		light.LightHue = 0;
		light.LightSaturation = 16;
	}

	if (bOn)
	{
		PlaySound(beepSound, SLOT_Misc,,, 128);
		if (light != None)
			light.LightType = LT_Steady;

                MultiSkins[2] = Texture'GameMedia.Skins.OutforcerTex1';
		SetTimer(PauseFactor+FRand()*5,False);
	}
	else
	{
		if (light != None)
			light.LightType = LT_None;

                MultiSkins[2] = Texture'BlackMaskTex';
		SetTimer(1+FRand()*0.5,False);
	}
}

defaultproperties
{
     beepSound=Sound'DeusExSounds.Generic.Beep5'
     PauseFactor=1
     bStatic=False
     bCanBeBase=True
     ScaleGlow=1.300000
     bInvincible=True
     bHighlight=False
     FragType=Class'DeusEx.PlasticFragment'
     Mesh=LodMesh'GameMedia.Outforcer'
     Physics=PHYS_None
     CollisionRadius=14.000000
     CollisionHeight=3.900000
     bCollideActors=True
     bBlockActors=True
     bBlockPlayers=True
     bCollideWorld=True
     Mass=7.000000
     Buoyancy=40.000000
}
