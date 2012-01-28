//=============================================================================
// ����. �������� Ded'�� ��� ���� 2027
// Tank. Copyright (C) 2003 Ded
// ����� ������/Model created by: Kelkos
// Deus Ex: 2027
//=============================================================================
class BattleTank extends Vehicles;

enum ESkin
{
	ES_Green,
	ES_Desert
};

var() ESkin SkinType;

function BeginPlay()
{
	Super.BeginPlay();

	switch (SkinType)
	{
		case ES_Green:
                  MultiSkins[1] = Texture'GameMedia.Skins.TankTex0';
                                                             break;

		case ES_Desert:
                  MultiSkins[1] = Texture'GameMedia.Skins.TankTex1';
                                                             break;
	}
}

defaultproperties
{
     Mesh=LodMesh'GameMedia.Tank'
     CollisionRadius=250.000000
     CollisionHeight=95.000000
     ScaleGlow=0.250000
     Mass=10000.000000
     Buoyancy=2000.000000
}
