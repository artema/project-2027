//=============================================================================
// ������. ������� Ded'�� ��� ���� 2027
// Thumb.  Copyright (C) 2003 Ded
// ����� ������/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class Thumb extends DeusExDecoration;

var bool bRandom;

enum ESkin
{
	ES_Red,
        ES_Orange,
        ES_Yellow,
        ES_Pink,
        ES_Blue,
        ES_Random
};

var() ESkin SkinType;

function BeginPlay()
{
	Super.BeginPlay();

	switch (SkinType)
	{
		case ES_Red:
                  MultiSkins[1] = Texture'GameMedia.Skins.ThumbTex0';
                                                               break;

		case ES_Orange:
                  MultiSkins[1] = Texture'GameMedia.Skins.ThumbTex1';
                                                               break;

		case ES_Yellow:
                  MultiSkins[1] = Texture'GameMedia.Skins.ThumbTex2';
                                                               break;

		case ES_Pink:
                  MultiSkins[1] = Texture'GameMedia.Skins.ThumbTex3';
                                                               break;

		case ES_Blue:
                  MultiSkins[1] = Texture'GameMedia.Skins.ThumbTex4';
                                                               break;

		case ES_Random:
                                                        bRandom=True;
                                                               break;
	}
}

function PostBeginPlay()
{
	Super.PostBeginPlay();

if (bRandom)
{
	if ((FRand() > 0.0) && (FRand() < 0.2))
	   MultiSkins[1] = Texture'GameMedia.Skins.ThumbTex0';
	else if ((FRand() > 0.2) && (FRand() < 0.4))
	   MultiSkins[1] = Texture'GameMedia.Skins.ThumbTex1';
	else if ((FRand() > 0.4) && (FRand() < 0.6))
	   MultiSkins[1] = Texture'GameMedia.Skins.ThumbTex2';
	else if ((FRand() > 0.6) && (FRand() < 0.8))
	   MultiSkins[1] = Texture'GameMedia.Skins.ThumbTex3';
        else
	   MultiSkins[1] = Texture'GameMedia.Skins.ThumbTex4';
}

}

defaultproperties
{
     bInvincible=True
     FragType=Class'DeusEx.MetalFragment'
     HitPoints=1
     bPushable=False
     Physics=PHYS_None
     Mesh=LodMesh'GameMedia.Thumb'
     bBlockActors=False
     bBlockPlayers=False
     bCollideActors=True
     bCollideWorld=False
     CollisionRadius=0.500000
     CollisionHeight=0.400000
     Mass=0.100000
     Buoyancy=40.000000
}
