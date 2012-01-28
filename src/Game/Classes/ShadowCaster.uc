//=============================================================================
// CeilingFan.
//=============================================================================
class ShadowCaster extends DeusExDecoration;

var() texture ShadowTexture;
var() float ScaleShadow;
var() rotator ShadowSpeed;

// ----------------------------------------------------------------------
// PostPostBeginPlay()
// ----------------------------------------------------------------------

function PostPostBeginPlay()
{
	Super.PostPostBeginPlay();

              CastShadow();
}

// ----------------------------------------------------------------------
// CastShadow
// ----------------------------------------------------------------------
simulated function CastShadow()
{
     local DummyShadow Shadow;
     local ShadowCaster SC;

   if (Shadow == None)
   {
      Shadow = Spawn(class'DummyShadow', Self,, Location-vect(0,0,1)*CollisionHeight, rot(0,0,0));

      if (Shadow != None)
      {
         Shadow.RemoteRole = ROLE_None;
      }
   }
}

defaultproperties
{
     bHidden=True
     ScaleShadow=1.000000
     ShadowSpeed=(Yaw=4)
//     RotationRate=(Yaw=100)
     bHighlight=True
     bCanBeBase=True
     bPushable=True
//     Physics=PHYS_Rotating
     CollisionRadius=5.000000
     CollisionHeight=5.000000
     bCollideWorld=True
     DrawType=DT_Sprite
     Texture=Texture'Engine.S_Actor'
     Mass=1.000000
     Buoyancy=1.000000
}
