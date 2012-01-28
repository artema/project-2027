//=============================================================================
// ��������. ������� Ded'�� ��� ���� 2027
// Screwdriver.  Copyright (C) 2003 Ded
// ����� ������/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class Screwdriver extends DeusExDecoration;

enum ESkin
{
        ES_Random,
	ES_Red,
	ES_Blue,
	ES_Green
};

var() ESkin SkinType;
var bool bRandomSkin;

function BeginPlay()
{
	Super.BeginPlay();

	switch (SkinType)
	{
		case ES_Random:	                      bRandomSkin=True;
                                                                 break;

		case ES_Red:	                     bRandomSkin=False;
              MultiSkins[1] = Texture'GameMedia.Skins.InstrumentsTex0';
                                                                 break;

		case ES_Blue:	                     bRandomSkin=False;
              MultiSkins[1] = Texture'GameMedia.Skins.InstrumentsTex1';
                                                                 break;

		case ES_Green:	                     bRandomSkin=False;
              MultiSkins[1] = Texture'GameMedia.Skins.InstrumentsTex2';
                                                                 break;

	}
}

function PostBeginPlay()
{
	Super.PostBeginPlay();

if (bRandomSkin)
{
	if ((FRand() > 0.0) && (FRand() < 0.3))
	   MultiSkins[1] = Texture'GameMedia.Skins.InstrumentsTex0';
	else if ((FRand() > 0.3) && (FRand() < 0.6))
	   MultiSkins[1] = Texture'GameMedia.Skins.InstrumentsTex1';
	else
	   MultiSkins[1] = Texture'GameMedia.Skins.InstrumentsTex2';
}
}

defaultproperties
{
     bInvincible=True
     FragType=Class'DeusEx.MetalFragment'
     HitPoints=25
     Mesh=LodMesh'GameMedia.Screwdriver'
     CollisionRadius=4.000000
     CollisionHeight=0.500000
     Mass=7.000000
     Buoyancy=40.000000
}
