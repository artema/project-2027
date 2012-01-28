//=============================================================================
// Cushion.
//=============================================================================
class Cushion extends Furniture;


enum ESkin
{
	ES_White,
        ES_Birds
};

var() ESkin SkinType;

function BeginPlay()
{
	Super.BeginPlay();

	switch (SkinType)
	{
		case ES_White:
                  MultiSkins[1] = Texture'GameMedia.Skins.BigPillowTex0';
                                                                   break;

		case ES_Birds:
                  MultiSkins[1] = Texture'GameMedia.Skins.BigPillowTex1';
                                                                   break;

	}
}


defaultproperties
{
     MultiSkins(0)=Texture'GameMedia.Skins.BigPillowTex0'
     FragType=Class'DeusEx.PaperFragment'
     bCanBeBase=True
     ItemName="Большая подушка"
     Mesh=LodMesh'DeusExDeco.Cushion'
     CollisionRadius=27.000000
     CollisionHeight=3.190000
     Mass=20.000000
     Buoyancy=25.000000
}
