//=============================================================================
// F-22. ������� Ded'�� ��� ���� 2027
// F-22.  Copyright (C) 2003 Ded 
// ����� ������/Model created by: Kelkos
// Deus Ex: 2027
//=============================================================================
class F22 extends Vehicles;

enum ESkin
{
	ES_Original,
	ES_Russian
};

var() ESkin SkinType;

function BeginPlay()
{
	Super.BeginPlay();

	switch (SkinType)
	{
		case ES_Original:
                  MultiSkins[1] = Texture'GameMedia.Skins.F22Tex0';
                                                             break;

		case ES_Russian:
                  MultiSkins[1] = Texture'GameMedia.Skins.F22Tex1';
                                                             break;
	}
}

defaultproperties
{
     Mesh=LodMesh'GameMedia.F22'
     ScaleGlow=0.600000
     CollisionRadius=145.000000
     CollisionHeight=66.470001
     Mass=4000.000000
     Buoyancy=2000.000000
}
