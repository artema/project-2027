//=============================================================================
// ��������� ������. ������� Ded'�� ��� ���� 2027
// China Lanter. Copyright (C) 2003 Ded
// ����� ������/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class ChinaLanter extends DeusExDecoration;

enum ESkin
{
	ES_Red,
	ES_Blue,
	ES_Yellow
};

var() ESkin SkinType;

function BeginPlay()
{
	Super.BeginPlay();

	switch (SkinType)
	{
		case ES_Red:     MultiSkins[1] = Texture'GameMedia.Skins.ChinaLanterTex0';
                                                                                    break;

		case ES_Blue:    MultiSkins[1] = Texture'GameMedia.Skins.ChinaLanterTex1';
                                                                                    break;

		case ES_Yellow:  MultiSkins[1] = Texture'GameMedia.Skins.ChinaLanterTex2';
                                                                                    break;
	}
}

defaultproperties
{
     FragType=Class'DeusEx.PaperFragment'
     bHighlight=False
     bInvincible=False
     HitPoints=30
     bPushable=False
     bMovable=False
     Physics=PHYS_None
     Mesh=LodMesh'GameMedia.ChinaLanter'
     ScaleGlow=1.000000
     bUnlit=True
     CollisionRadius=16.000000
     CollisionHeight=20.000000
     Mass=3.000000
     Buoyancy=2.000000
}
