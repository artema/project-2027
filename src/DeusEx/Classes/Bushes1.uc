//=============================================================================
// Bushes1.
//=============================================================================
class Bushes1 extends OutdoorThings;

var() bool bSnow;

function BeginPlay()
{
	Super.BeginPlay();

                            if (bSnow)
	                           Skin = Texture'GameMedia.Skins.Bushes1Tex1Snow';
                            else
	                           Skin = Texture'Bushes1Tex1';
}

defaultproperties
{
     bCanBeBase=True
     Mesh=LodMesh'DeusExDeco.Bushes1'
     CollisionRadius=20.000000
     CollisionHeight=43.790001
     Mass=100.000000
     Buoyancy=110.000000
}
