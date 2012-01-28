//=============================================================================
// Пальма. Сделанно Ded'ом для мода 2027
// Palm. Copyright (C) 2004 Ded 
// Автор модели/Model created by: Exodus
// Deus Ex: 2027
//=============================================================================
class ExPalm2 expands Tree;

defaultproperties
{
    bStatic=False
    bAnimLoop=True
    AnimSequence=Wind
    AnimRate=0.10
    DrawType=2
    Skin=Texture'GameMedia.Skins.ExPalmTex0'
    Mesh=LodMesh'GameMedia.ExPalm2'
    CollisionRadius=50.00
    CollisionHeight=160.00
    bCollideActors=True
    bBlockPlayers=True
}
