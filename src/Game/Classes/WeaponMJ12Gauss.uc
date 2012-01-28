//=============================================================================
// WeaponMJ12Rocket.
//=============================================================================
class WeaponMJ12Gauss extends WeaponBotFire;

function Fire(float Value)
{
	PlayerViewOffset.Y = -PlayerViewOffset.Y;
	Super.Fire(Value);
}

defaultproperties
{
     AIMaxRange=500.0

     PlayerViewOffset=(Y=-24.000000,Z=-12.000000)
}
