//=============================================================================
// Switch1.
//=============================================================================
class RingBell extends DeusExDecoration;

var() bool bEmitFutz;
var() bool bHasFirstTime;
var bool bFirstTime;

function Frob(Actor Frobber, Inventory frobWith)
{
	Super.Frob(Frobber, frobWith);

   if (bHasFirstTime)
   {
	if (bFirstTime)
	{
		PlaySound(sound'GameMedia.Misc.RingBell');
//		PlayAnim('Ring');
	}
	else
	{
		PlaySound(sound'GameMedia.Misc.RingBell');
	        AISendEvent('Futz', EAITYPE_Audio, , 256);
//		PlayAnim('Ring');
	}

	bFirstTime = !bFirstTime;
   }
   else
   {
	   PlaySound(sound'GameMedia.Misc.RingBell');
	   AISendEvent('Futz', EAITYPE_Audio, , 256);
//	   PlayAnim('Ring');
   }
}

defaultproperties
{
     bInvincible=True
     bPushable=False
     Physics=PHYS_None
     Mesh=LodMesh'GameMedia.RingBell'
     CollisionRadius=3.300000
     CollisionHeight=1.400000
     Mass=10.000000
     Buoyancy=12.000000
}
