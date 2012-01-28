//=============================================================================
// Дерево. Сделанно Ded'ом для мода 2027
// Tree.  Copyright (C) 2004 Ded
// Автор модели/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class ParkTree1 extends Tree;

enum ESkin
{
	ES_Normal,
        ES_Green,
        ES_Yellow
};

var() ESkin SkinType;

function BeginPlay()
{
	Super.BeginPlay();

	switch (SkinType)
	{
		case ES_Normal:
                  MultiSkins[1] = Texture'GameMedia.Skins.ParkTreeTex0';
                                                                  break;

		case ES_Green:
                  MultiSkins[1] = Texture'GameMedia.Skins.ParkTreeTex1';
                                                                  break;

		case ES_Yellow:
                  MultiSkins[1] = Texture'GameMedia.Skins.ParkTreeTex2';
                                                                  break;
	}
}

defaultproperties
{
     Mesh=LodMesh'GameMedia.ParkTree1'
     ScaleGlow=0.25000
     CollisionRadius=40.000000
     CollisionHeight=230.00000
}
