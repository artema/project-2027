//=============================================================================
// Тень. Сделано Ded'ом для мода 2027
// Shadow.  Copyright (C) 2003 Ded
//=============================================================================
class DummyShadow extends Decal;

var vector lastLocation;
var bool   bHasDecal;

function Tick(float deltaTime)
{
	local vector EndTrace, HitLocation, HitNormal;
	local Actor hit;
	local float dist;
	local ShadowCaster pawnOwner;
	local bool recentlyDrewShadow, recentlyDrewOwner;
	local bool doDraw;
	
	Super.Tick(deltaTime);

	if (Owner == None)
	{
		Destroy();
		return;
	}

/*
	if (Owner.InStasis() || (VSize(Owner.Location - lastLocation) < 0.1))
		if (bHasDecal)
			return;

	recentlyDrewShadow = (lastRendered()<1.0);
        recentlyDrewOwner  = (Owner.lastRendered()<1.0);
	doDraw             = recentlyDrewShadow || recentlyDrewOwner;
*/

	if (bHasDecal)
	{
		DetachDecal();
		bHasDecal=False;
	}

	if (Owner.IsA('ShadowCaster'))
		doDraw = True;

	if (!doDraw)
		return;

	lastLocation = Owner.Location;

	EndTrace = Owner.Location - vect(0,0,480);
	hit = Trace(HitLocation, HitNormal, EndTrace, Owner.Location, True);

	if (hit != None)
	{
		dist = VSize(HitLocation - Owner.Location);
	
		pawnOwner = ShadowCaster(Owner);
		if (pawnOwner != None)
                {
			DrawScale = pawnOwner.ScaleShadow;
                        Texture = pawnOwner.ShadowTexture;
                        RotationRate = pawnOwner.ShadowSpeed;
                }

		if (DrawScale < 0)
			DrawScale = 0;

		SetLocation(HitLocation);
		SetRotation(Rotator(HitNormal));

		AttachDecal(32,vect(0.1,40,0));
		bHasDecal=True;
	}
}

// ----------------------------------------------------------------------
// PostPostBeginPlay()
// ----------------------------------------------------------------------

function PostPostBeginPlay()
{
	Super.PostPostBeginPlay();

//		AttachDecal(32,vect(0.1,0.1,0));
}

defaultproperties
{
     Physics=PHYS_Rotating
     bHasDecal=True
     Texture=Texture'DeusExItems.Skins.FlatFXTex40'
}