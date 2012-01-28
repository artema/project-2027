//=============================================================================
// LAM.
//=============================================================================
class LAM extends GrenadeProjectile;

simulated function Tick(float deltaTime)
{
	local float blinkRate;

	Super.Tick(deltaTime);

	if (bDisabled)
	{
		Skin = Texture'BlackMaskTex';
		return;
	}

	// flash faster as the time expires
	if (fuseLength - time <= 0.75)
		blinkRate = 0.1;
	else if (fuseLength - time <= fuseLength * 0.5)
		blinkRate = 0.3;
	else
		blinkRate = 0.5;

   if ((Level.NetMode == NM_Standalone) || (Role < ROLE_Authority) || (Level.NetMode == NM_ListenServer))
   {
      if (Abs((fuseLength - time)) % blinkRate > blinkRate * 0.5)
         Skin = Texture'BlackMaskTex';
      else
         Skin = Texture'LAM3rdTex1';
   }
}

defaultproperties
{
     spawnWeaponClass=Class'DeusEx.WeaponLAM'
     ItemName="Lightweight Attack Munition (LAM)"
     speed=1000.000000
     MaxSpeed=1000.000000
     Damage=500.000000
     MomentumTransfer=50000
     ImpactSound=Sound'DeusExSounds.Weapons.LAMExplode'
     ExplosionDecal=Class'DeusEx.ScorchMark'
     LifeSpan=0.000000
     Mesh=LodMesh'DeusExItems.LAMPickup'
     CollisionRadius=4.300000
     CollisionHeight=3.800000
     Mass=5.000000
     Buoyancy=2.000000
}