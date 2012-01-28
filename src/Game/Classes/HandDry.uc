//=============================================================================
// ���������. ������� Ded'�� ��� ���� 2027
// Hand dry. Copyright (C) 2005 Ded
// ����� ������/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class HandDry extends DeusExDecoration;

enum ESkin
{
	ES_Red,
	ES_Blue,
	ES_Green,
	ES_NoSkin
};

var() ESkin SkinType;

function BeginPlay()
{
	Super.BeginPlay();

	switch (SkinType)
	{
		case ES_Red:
                    MultiSkins[2] = Texture'GameMedia.Skins.HandDryTex1';
                                                                   break;

		case ES_Blue:
                    MultiSkins[2] = Texture'GameMedia.Skins.HandDryTex2';
                                                                   break;

		case ES_Green:
                    MultiSkins[2] = Texture'GameMedia.Skins.HandDryTex3';
                                                                   break;

		case ES_NoSkin:
                    MultiSkins[2] = Texture'PinkMaskTex';
                                                                     break;

	}
}

defaultproperties
{
     bCanBeBase=False
     bPushable=False
     Mesh=LodMesh'GameMedia.HandDry'
     FragType=Class'DeusEx.MetalFragment'
     Physics=PHYS_None
     bInvincible=True
     ScaleGlow=0.750000
     bBlockActors=True
     bBlockPlayers=True
     bCollideActors=True
     bCollideWorld=False
     CollisionRadius=15.000000
     CollisionHeight=10.000000
     Mass=5.000000
     Buoyancy=15.000000
}
