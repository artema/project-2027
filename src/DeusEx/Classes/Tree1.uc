//=============================================================================
// Tree1.
//=============================================================================
class Tree1 extends Tree;

enum ESkinColor
{
	SC_Tree1,
	SC_Tree2,
	SC_Tree3
};

var() ESkinColor SkinColor;

function BeginPlay()
{
	Super.BeginPlay();

	switch (SkinColor)
	{
		case SC_Tree1:
                            if (bSnow)
	                           Skin = Texture'GameMedia.Skins.Tree2Tex1Snow';
                            else
	                           Skin = Texture'Tree2Tex1'; break;

		case SC_Tree2:
                            if (bSnow)
	                           Skin = Texture'GameMedia.Skins.Tree2Tex2Snow';
                            else
	                           Skin = Texture'Tree2Tex2'; break;
		case SC_Tree3:
                            if (bSnow)
	                           Skin = Texture'GameMedia.Skins.Tree2Tex3Snow';
                            else
	                           Skin = Texture'Tree2Tex3'; break;
	}
}

defaultproperties
{
     Mesh=LodMesh'DeusExDeco.Tree1'
     CollisionRadius=10.000000
     CollisionHeight=125.000000
}
