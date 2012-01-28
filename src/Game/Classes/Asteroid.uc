//=============================================================================
// Астероид. Сделанно Ded'ом для мода 2027
// Asteroid. Copyright (C) 2003 Ded
// Автор модели/Model created by: Ded
// Deus Ex: 2027 (C)
//=============================================================================
class Asteroid expands OutdoorThings;

defaultproperties
{
     bStatic=False
     Physics=PHYS_Rotating
     Mesh=LodMesh'GameMedia.Asteroid'
     DrawScale=1.000000
     CollisionRadius=8.000000
     CollisionHeight=8.000000
     bCollideActors=False
     bCollideWorld=False
     bFixedRotationDir=True
     Mass=10.000000
     Buoyancy=5.000000
     RotationRate=(Yaw=-128)
}
