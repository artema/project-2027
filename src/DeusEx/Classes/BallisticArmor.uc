//=============================================================================
// BallisticArmor.
//=============================================================================
class BallisticArmor extends ChargedPickup;

//
// Reduces ballistic damage
//

defaultproperties
{
     LoopSound=Sound'DeusExSounds.Pickup.SuitLoop'
     ChargedIcon=Texture'DeusExUI.Icons.ChargedIconArmorBallistic'
     PlayerViewOffset=(X=30.000000,Z=-12.000000)
     PlayerViewMesh=LodMesh'DeusExItems.BallisticArmor'
     PickupViewMesh=LodMesh'DeusExItems.BallisticArmor'
     ThirdPersonMesh=LodMesh'DeusExItems.BallisticArmor'
     Charge=3000
     LandSound=Sound'DeusExSounds.Generic.PaperHit2'
     Icon=Texture'DeusExUI.Icons.BeltIconArmorBallistic'
     largeIcon=Texture'DeusExUI.Icons.LargeIconArmorBallistic'
     largeIconWidth=34
     largeIconHeight=49
     Mesh=LodMesh'DeusExItems.BallisticArmor'
     CollisionRadius=11.500000
     CollisionHeight=13.810000
     Mass=40.000000
     Buoyancy=30.000000
}
