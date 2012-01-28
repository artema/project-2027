//=============================================================================
// �������. ������� Ded'�� ��� ���� 2027
// Ruler. Copyright (C) 2003 Ded
// ����� ������/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class Ruler extends DeusExDecoration;

enum ESkin
{
	ES_Blue,
	ES_Brown
};

var() ESkin SkinType;

function BeginPlay()
{
	Super.BeginPlay();

	switch (SkinType)
	{
		case ES_Blue:
                  MultiSkins[1] = Texture'GameMedia.Skins.RulerTex0';
                                                              break;

		case ES_Brown:
                  MultiSkins[1] = Texture'GameMedia.Skins.RulerTex1';
                                                              break;
	}
}

defaultproperties
{
     HitPoints=20
     FragType=Class'DeusEx.PlasticFragment'
     Mesh=LodMesh'GameMedia.Ruler'
     CollisionRadius=6.000000
     CollisionHeight=0.100000
     Mass=0.100000
     Buoyancy=40.000000
}
