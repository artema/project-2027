//=============================================================================
// Tree3.
//=============================================================================
class Tree3 extends Tree;

function BeginPlay()
{
	Super.BeginPlay();

                            if (bSnow)
	                           Skin = Texture'GameMedia.Skins.Tree3Tex1Snow';
                            else
	                           Skin = Texture'Tree3Tex1';
}

defaultproperties
{
     Mesh=LodMesh'DeusExDeco.Tree3'
     CollisionRadius=30.000000
     CollisionHeight=124.339996
}
