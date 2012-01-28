//=============================================================================
// Doberman.
//=============================================================================
class Doberman extends Dog;

function PlayDogBark()
{
	if (FRand() < 0.5)
		PlaySound(sound'DogLargeBark2', SLOT_None);
	else
		PlaySound(sound'DogLargeBark3', SLOT_None);
}

function Bump(actor Other)
{
	local DeusExWeapon dxWeapon;
	local DeusExPlayer dxPlayer;
	local float        damage;

	Super.Bump(Other);

	if (IsInState('Attacking') && (Other != None) && (Other == Enemy))
	{
		if (VSize(Velocity) > 100)
		{
			dxWeapon = DeusExWeapon(Weapon);
			if ((dxWeapon != None) && dxWeapon.IsA('WeaponKarkianBump') && (FireTimer <= 0))
			{
				FireTimer = DeusExWeapon(Weapon).AIFireDelay;
				damage = VSize(Velocity) / 10;
				Other.TakeDamage(damage, Self, Other.Location+vect(1,1,-1), 100*Velocity, 'Shot');
				Other.TakeDamage(damage, Self, Other.Location+vect(-1,-1,-1), 100*Velocity, 'Shot');
				dxPlayer = DeusExPlayer(Other);
				if (dxPlayer != None)
					dxPlayer.ShakeView(0.15 + 0.002*damage*2, damage*30*2, 0.3*damage*2);
			}
		}
	}
}

defaultproperties
{
     CarcassType=Class'DeusEx.DobermanCarcass'
     WalkingSpeed=0.200000
     GroundSpeed=250.000000
     WaterSpeed=50.000000
     AirSpeed=144.000000
     AccelRate=500.000000
     Health=20
     UnderWaterTime=20.000000
     AttitudeToPlayer=ATTITUDE_Ignore
     HitSound1=Sound'DeusExSounds.Animal.DogLargeGrowl'
     HitSound2=Sound'DeusExSounds.Animal.DogLargeBark1'
     Die=Sound'DeusExSounds.Animal.DogLargeDie'
     DrawType=DT_Mesh
     Mesh=LodMesh'DeusExCharacters.Doberman'
     CollisionRadius=30.000000
     CollisionHeight=28.000000
     Mass=25.000000
     BindName="Doberman"
     FamiliarName="Доберман"
     UnfamiliarName="Доберман"
}
