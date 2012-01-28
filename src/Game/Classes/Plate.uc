//=============================================================================
// �������. ������� Ded'�� ��� ���� 2027
// Plate. Copyright (C) 2003 Ded
// ����� ������/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class Plate extends DeusExDecoration;

enum ESkin
{
	ES_China,
	ES_White,
	ES_Peacock,
	ES_WhiteBlue,
        ES_Russian,
        ES_House
};

enum EMesh
{
	EM_Empty,
	EM_Rice,
	EM_Meat,
	EM_Fish
};

var() ESkin SkinType;
var() EMesh MeshType;

function BeginPlay()
{
	Super.BeginPlay();

	switch (MeshType)
	{
		case EM_Empty:
                         Mesh = LodMesh'GameMedia.Plate';
                                                   break;

		case EM_Rice:
                    Mesh = LodMesh'GameMedia.PlateFood1';
                                                   break;

		case EM_Meat:
                    Mesh = LodMesh'GameMedia.PlateFood2';
                                                   break;

		case EM_Fish:
                    Mesh = LodMesh'GameMedia.PlateFood3';
                                                   break;

	}

	switch (SkinType)
	{
		case ES_China:
                    MultiSkins[1] = Texture'GameMedia.Skins.PlateTex0';
                                                                 break;

		case ES_White:
                    MultiSkins[1] = Texture'GameMedia.Skins.PlateTex1';
                                                                 break;

		case ES_Peacock:
                    MultiSkins[1] = Texture'GameMedia.Skins.PlateTex2';
                                                                 break;

		case ES_WhiteBlue:
                    MultiSkins[1] = Texture'GameMedia.Skins.PlateTex3';
                                                                 break;

		case ES_Russian:
                    MultiSkins[1] = Texture'GameMedia.Skins.PlateTex4';
                                                                 break;

		case ES_House:
                    MultiSkins[1] = Texture'GameMedia.Skins.PlateTex5';
                                                                 break;

	}
}

defaultproperties
{
     bCanBeBase=True
     Mesh=LodMesh'GameMedia.Plate'
     FragType=Class'DeusEx.GlassFragment'
     HitPoints=10
     CollisionRadius=8.500000
     CollisionHeight=0.600000
     Mass=5.000000
     Buoyancy=15.000000
}
