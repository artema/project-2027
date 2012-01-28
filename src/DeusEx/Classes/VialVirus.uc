//=============================================================================
// VialAmbrosia.
//=============================================================================
class VialVirus extends DeusExPickup;

simulated function Tick(float deltaTime)
{
      Super.Tick(deltaTime);

     MultiSkins[1]=Texture'Effects.liquid.Virus_SFX';
}

defaultproperties
{
     maxCopies=1
     bCanHaveMultipleCopies=False
     bActivatable=False
     PlayerViewOffset=(X=30.000000,Z=-12.000000)
     PlayerViewMesh=LodMesh'DeusExItems.VialAmbrosia'
     PickupViewMesh=LodMesh'DeusExItems.VialAmbrosia'
     ThirdPersonMesh=LodMesh'DeusExItems.VialAmbrosia'
     LandSound=Sound'DeusExSounds.Generic.GlassHit1'
     Icon=Texture'DeusExUI.Icons.BeltIconVialAmbrosia'
     largeIcon=Texture'DeusExUI.Icons.LargeIconVialAmbrosia'
     largeIconWidth=18
     largeIconHeight=44
     Mesh=LodMesh'DeusExItems.VialAmbrosia'
     MultiSkins(1)=Texture'Effects.liquid.Virus_SFX'
     CollisionRadius=2.200000
     CollisionHeight=4.890000
     Mass=2.000000
     Buoyancy=3.000000
}
