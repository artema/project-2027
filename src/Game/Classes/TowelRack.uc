//=============================================================================
// ���������. ������� Ded'�� ��� ���� 2027
// Towel rack. Copyright (C) 2005 Ded
// Deus Ex: 2027
//=============================================================================
class TowelRack extends DeusExDecoration;

enum ESkin1
{
	ES_Blue,
	ES_Red,
	ES_Green,
	ES_NoSkin
};

enum ESkin2
{
	ES_Blue,
	ES_Red,
	ES_Green,
	ES_NoSkin
};

var() ESkin1 SkinType1;
var() ESkin2 SkinType2;

function BeginPlay()
{
	Super.BeginPlay();

	switch (SkinType1)
	{
		case ES_Blue:
                    MultiSkins[2] = Texture'GameMedia.Skins.TowelRackTex1';
                                                                     break;

		case ES_Red:
                    MultiSkins[2] = Texture'GameMedia.Skins.TowelRackTex2';
                                                                     break;

		case ES_Green:
                    MultiSkins[2] = Texture'GameMedia.Skins.TowelRackTex3';
                                                                     break;

		case ES_NoSkin:
                    MultiSkins[2] = Texture'PinkMaskTex';
                                                                     break;

	}

	switch (SkinType2)
	{
		case ES_Blue:
                    MultiSkins[3] = Texture'GameMedia.Skins.TowelRackTex1';
                                                                     break;

		case ES_Red:
                    MultiSkins[3] = Texture'GameMedia.Skins.TowelRackTex2';
                                                                     break;

		case ES_Green:
                    MultiSkins[3] = Texture'GameMedia.Skins.TowelRackTex3';
                                                                     break;

		case ES_NoSkin:
                    MultiSkins[3] = Texture'PinkMaskTex';
                                                                     break;

	}
}

defaultproperties
{
     bCanBeBase=False
     bPushable=False
     Mesh=LodMesh'GameMedia.TowelRack'
     FragType=Class'DeusEx.PlasticFragment'
     Physics=PHYS_None
     HitPoints=10
     bInvincible=True
     ScaleGlow=0.750000
     bBlockActors=True
     bBlockPlayers=True
     bCollideActors=True
     bCollideWorld=False
     CollisionRadius=15.000000
     CollisionHeight=3.000000
     Mass=5.000000
     Buoyancy=15.000000
}
