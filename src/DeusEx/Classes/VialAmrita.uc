//=============================================================================
// VialAmbrosia.
//=============================================================================
class VialAmrita extends DeusExPickup;

simulated function Tick(float deltaTime)
{
      Super.Tick(deltaTime);

     MultiSkins[1]=FireTexture'Effects.Electricity.Nano_SFX_A';
}

defaultproperties
{
     bCanHaveMultipleCopies=False
     bActivatable=False
     PlayerViewOffset=(X=30.000000,Z=-12.000000)
     PlayerViewMesh=LodMesh'DeusExItems.VialAmbrosia'
     PickupViewMesh=LodMesh'DeusExItems.VialAmbrosia'
     ThirdPersonMesh=LodMesh'DeusExItems.VialAmbrosia'
     LandSound=Sound'DeusExSounds.Generic.GlassHit1'
     Icon=Texture'GameMedia.Icons.BeltIconVialAmrita'
     largeIcon=Texture'GameMedia.Icons.LargeIconVialAmrita'
     MultiSkins(1)=FireTexture'Effects.Electricity.Nano_SFX_A'
     largeIconWidth=18
     largeIconHeight=44
     Mesh=LodMesh'DeusExItems.VialAmbrosia'
     CollisionRadius=2.200000
     CollisionHeight=4.890000
     Mass=2.000000
     Buoyancy=3.000000
}