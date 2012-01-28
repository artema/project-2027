//=============================================================================
// Flowers.
//=============================================================================
class Flowers extends DeusExDecoration;

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
                  MultiSkins[0] = Texture'GameMedia.Skins.FlowersPotTex0';
                                                                    break;

		case ES_Red:
                  MultiSkins[0] = Texture'GameMedia.Skins.FlowersPotTex1';
                                                                    break;
	}
}


defaultproperties
{
     FragType=Class'DeusEx.PlasticFragment'
     ItemName="÷веты"
     Mesh=LodMesh'DeusExDeco.Flowers'
     CollisionRadius=11.880000
     CollisionHeight=9.630000
     Mass=20.000000
     Buoyancy=10.000000
}
