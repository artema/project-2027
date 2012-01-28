//=============================================================================
// BoxSmall.
//=============================================================================
class BoxSmall extends Containers;

function PostBeginPlay()
{
	Super.BeginPlay();

     MultiSkins[0]=Texture'DeusExDeco.Skins.BoxMediumTex1';
}

defaultproperties
{
     MultiSkins(0)=Texture'DeusExDeco.Skins.BoxMediumTex1'
     HitPoints=10
     FragType=Class'DeusEx.PaperFragment'
     ItemName="Картонная коробка"
     bBlockSight=True
     Mesh=LodMesh'DeusExDeco.BoxSmall'
     CollisionRadius=10.000000
     CollisionHeight=3.700000
     Mass=20.000000
     Buoyancy=30.000000
}
