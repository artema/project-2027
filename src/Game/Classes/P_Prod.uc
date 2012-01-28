class P_Prod extends DeusExProjectile;

function PlayRicochet(vector HitNormal)
{
	Destroy();
}

defaultproperties
{
	 DamageType=Stunned
     bMeleeDamage=True
     bBlood=False
     DamageType=Shot
     spawnAmmoClass=None
     bIgnoresNanoDefense=True
     speed=100.000000
     MaxSpeed=100.000000
     Damage=14.0
     MomentumTransfer=1000
     ImpactSound=None
     Mesh=None
     CollisionRadius=0.1
     CollisionHeight=0.1
     bHidden=True
}