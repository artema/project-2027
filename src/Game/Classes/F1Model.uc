//=============================================================================
// F1. �������� Ded'�� ��� ���� 2027
// F1. Copyright (C) 2003 Ded
//=============================================================================
class F1Model extends Decorative;

enum ESkin
{
	ES_Yellow,
	ES_Red
};

var() ESkin SkinType;

function BeginPlay()
{
	Super.BeginPlay();

	switch (SkinType)
	{
		case ES_Yellow:
                  MultiSkins[1] = Texture'GameMedia.Skins.F1Tex0';
                                                            break;

		case ES_Red:
                  MultiSkins[1] = Texture'GameMedia.Skins.F1Tex1';
                                                            break;
	}
}

defaultproperties
{
     DrawScale=0.050000
     Mesh=LodMesh'GameMedia.F1'
     CollisionRadius=6.000000
     CollisionHeight=1.900000
     Mass=25.000000
     Buoyancy=5.000000
}
