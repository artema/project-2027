//=============================================================================
// CD. ������� Ded'�� ��� ���� 2027
// CD. Copyright (C) 2003 Ded
// ����� ������/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class CD extends DeusExDecoration;

enum ESkin
{
	ES_Blue,
        ES_Green,
        ES_Red
};

var() ESkin SkinType;

function BeginPlay()
{
	Super.BeginPlay();

	switch (SkinType)
	{
		case ES_Blue:
                  MultiSkins[1] = Texture'GameMedia.Skins.CDTex0';
                                                            break;

		case ES_Green:
                  MultiSkins[1] = Texture'GameMedia.Skins.CDTex1';
                                                            break;

		case ES_Red:
                  MultiSkins[1] = Texture'GameMedia.Skins.CDTex2';
                                                            break;
	}
}

defaultproperties
{
     FragType=Class'DeusEx.PlasticFragment'
     HitPoints=20
     ScaleGlow=0.750000
     Mesh=LodMesh'GameMedia.CD'
     CollisionRadius=4.500000
     CollisionHeight=0.100000
     Mass=7.000000
     Buoyancy=40.000000
}
