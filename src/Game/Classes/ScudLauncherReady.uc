//=============================================================================
// �������� ��������. �������� Ded'�� ��� ���� 2027
// Scud Launcher. Copyright (C) 2003 Ded
// ����� ������/Model created by: Kelkos
// Deus Ex: 2027
//=============================================================================
class ScudLauncherReady extends Vehicles;

enum ESkin
{
	ES_Russian,
	ES_Arab,
	ES_Black
};

var() ESkin SkinType;

function BeginPlay()
{
	Super.BeginPlay();

	switch (SkinType)
	{
		case ES_Russian:
                  MultiSkins[1] = Texture'GameMedia.Skins.ScudTex0';
                                                              break;

		case ES_Arab:
                  MultiSkins[1] = Texture'GameMedia.Skins.ScudTex1';
                                                              break;

		case ES_Black:
                  MultiSkins[1] = Texture'GameMedia.Skins.ScudTex2';
                                                              break;
	}
}

defaultproperties
{
     Mesh=LodMesh'GameMedia.ScudReady'
     CollisionRadius=375.000000
     CollisionHeight=501.000000
     ScaleGlow=0.250000
     Mass=10000.000000
     Buoyancy=2000.000000
}
