//=============================================================================
// Earth.
//=============================================================================
class Earth expands OutdoorThings;

enum ESkin
{
	ES_Original,
        ES_Dark
};

var() ESkin SkinType;

function BeginPlay()
{
	Super.BeginPlay();

	switch (SkinType)
	{
		case ES_Original:
                                                                break;

		case ES_Dark:
                  MultiSkins[0] = Texture'GameMedia.Skins.Earth2Tex0';
                  MultiSkins[1] = Texture'GameMedia.Skins.Earth2Tex1';
                                                                break;
	}
}


defaultproperties
{
     bStatic=False
     Physics=PHYS_Rotating
     Mesh=LodMesh'DeusExDeco.Earth'
     CollisionRadius=48.000000
     CollisionHeight=48.000000
     bCollideActors=False
     bCollideWorld=False
     bFixedRotationDir=True
     Mass=10.000000
     Buoyancy=5.000000
     RotationRate=(Yaw=-128)
}
