//=============================================================================
// ��������. ������� Ded'�� ��� ���� 2027
// Plants. Copyright (C) 2003 Ded
// ����� ������/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class PlantsBox extends DeusExDecoration;

enum ESkin
{
	ES_BigPlants,
	ES_SmallPlants
};

var() ESkin SkinType;

function BeginPlay()
{
	Super.BeginPlay();

	switch (SkinType)
	{
		case ES_BigPlants:
                  MultiSkins[2] = Texture'GameMedia.Skins.PlantsBoxTex0';
                                                                   break;

		case ES_SmallPlants:
                  MultiSkins[2] = Texture'GameMedia.Skins.PlantsBoxTex1';
                                                                   break;
	}
}

defaultproperties
{
     FragType=Class'DeusEx.WoodFragment'
     HitPoints=40
     Mesh=LodMesh'GameMedia.PlantsBox'
     CollisionRadius=17.000000
     CollisionHeight=5.700000
     Mass=30.000000
     Buoyancy=15.000000
}
