//=============================================================================
// Куст. Сделанно Ded'ом для мода 2027
// Bush. Copyright (C) 2004 Ded 
// Автор модели/Model created by: Exodus
// Deus Ex: 2027
//=============================================================================
class ExBush2 expands Tree;

enum ESkin
{
	ES_Green,
        ES_Red
};

var() ESkin SkinType;

function BeginPlay()
{
	Super.BeginPlay();

	switch (SkinType)
	{
		case ES_Green:
                  MultiSkins[0] = Texture'GameMedia.Skins.ExBushTex0';
                                                                break;

		case ES_Red:
                  MultiSkins[0] = Texture'GameMedia.Skins.ExBushTex1';
                                                                break;
	}
}

Auto State Animcontrol
{
	event Bump( Actor Other )
	{
	PlaySound(sound'GameMedia.Misc.Grass', SLOT_Misc,255,False, 512,);
	}
}

defaultproperties
{
    bCanBeBase=True
    bStatic=False
    bAnimLoop=True
    AnimSequence=Wind3
    AnimRate=0.02
    DrawType=2
    Skin=Texture'GameMedia.Skins.ExBushTex0'
    Mesh=LodMesh'GameMedia.ExBush2'
    CollisionRadius=30.00
    CollisionHeight=4.00
    bCollideActors=True
    bBlockPlayers=False
    Mass=1.000000
}
