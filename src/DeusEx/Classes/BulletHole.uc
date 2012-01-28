//=============================================================================
// BulletHole.
//=============================================================================
class BulletHole extends DeusExDecal;

// overridden to NOT rotate decal
simulated event BeginPlay()
{
	if(!AttachDecal(32, vect(0.1,0.1,0)))
		Destroy();

	if ((FRand() > 0.0) && (FRand() < 0.25))
	   Texture = Texture'GameMedia.Misc.BulletHit_1';
	else if ((FRand() >= 0.25) && (FRand() < 0.5))
	   Texture = Texture'GameMedia.Misc.BulletHit_2';
	else if ((FRand() >= 0.5) && (FRand() < 0.75))
	   Texture = Texture'GameMedia.Misc.BulletHit_3';
	else
	   Texture = Texture'GameMedia.Misc.BulletHit_4';
}

defaultproperties
{
     DrawScale=0.200000
}
