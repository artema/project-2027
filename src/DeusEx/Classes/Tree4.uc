//=============================================================================
// Tree4.
//=============================================================================
class Tree4 extends Tree;

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
     Mesh=LodMesh'DeusExDeco.Tree4'
     CollisionRadius=40.000000
     CollisionHeight=188.600006
}
