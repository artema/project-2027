//=============================================================================
// Flare.
//=============================================================================
class P_Flare extends DeusExDecoration;

var ParticleGenerator gen;

function LightFlare()
{
	local Vector X, Y, Z, dropVect;
	local Pawn P;

	if (gen == None)
	{	
		AmbientSound = Sound'Flare';
		LightType = LT_Steady;

		gen = Spawn(class'ParticleGenerator', Self,, Location, rot(16384,0,0));
		
		if (gen != None)
		{
			gen.attachTag = Name;
			gen.SetBase(Self);
			gen.LifeSpan = LifeSpan;
			gen.bRandomEject = True;
			gen.ejectSpeed = 20;
			gen.riseRate = 20;
			gen.checkTime = 0.3;
			gen.particleLifeSpan = 4;
			gen.particleDrawScale = 0.22;
			gen.particleTexture = Texture'GameMedia.Effects.ef_ExpSmoke010';
		}
	}
}

function PostBeginPlay()
{
	Super.PostBeginPlay();

	LightFlare();
}

defaultproperties
{
	 LightEffect=LE_TorchWaver
     LightBrightness=255
     LightHue=16
     LightSaturation=96
     LightRadius=12
	 LifeSpan=70
	 bHighlight=False
     bInvincible=True
     bPushable=False
     MultiSkins(0)=Texture'GameMedia.Skins.SignalFlareTex0'
     Mesh=LodMesh'DeusExItems.Flare'
     SoundRadius=16
     SoundVolume=96
     CollisionRadius=6.200000
     CollisionHeight=1.200000
     Mass=2.000000
     Buoyancy=1.000000
}