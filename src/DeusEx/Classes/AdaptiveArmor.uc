//=============================================================================
// AdaptiveArmor.
//=============================================================================
class AdaptiveArmor extends ChargedPickup;

function ChargedPickupBegin(DeusExPlayer Player)
{
	super.ChargedPickupBegin(Player);
	
	Player.ShowCloakOnEffect();
}

function ChargedPickupEnd(DeusExPlayer Player)
{
	super.ChargedPickupEnd(Player);
	
	Player.ShowCloakOffEffect();
}

defaultproperties
{
     LoopSound=Sound'DeusExSounds.Pickup.SuitLoop'
     ChargedIcon=Texture'DeusExUI.Icons.ChargedIconArmorAdaptive'
     PlayerViewOffset=(X=30.000000,Z=-12.000000)
     PlayerViewMesh=LodMesh'DeusExItems.AdaptiveArmor'
     PickupViewMesh=LodMesh'DeusExItems.AdaptiveArmor'
     ThirdPersonMesh=LodMesh'DeusExItems.AdaptiveArmor'
     Charge=900
     LandSound=Sound'DeusExSounds.Generic.PaperHit2'
     Icon=Texture'DeusExUI.Icons.BeltIconArmorAdaptive'
     largeIcon=Texture'DeusExUI.Icons.LargeIconArmorAdaptive'
     largeIconWidth=35
     largeIconHeight=49
     Mesh=LodMesh'DeusExItems.AdaptiveArmor'
     CollisionRadius=11.500000
     CollisionHeight=13.810000
     Mass=30.000000
     Buoyancy=20.000000
}
