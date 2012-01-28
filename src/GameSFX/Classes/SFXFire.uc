class SFXFire extends Effects;

var ParticleGenerator smokeGen;
var ParticleGenerator fireGen;
var Actor origBase;
var vector BaseOffset; //Where we are relative to Base, so that we can stay synced in mp.
var Actor PrevBase;

#exec OBJ LOAD FILE=Ambient
#exec OBJ LOAD FILE=GameEffects

simulated function Tick(float deltaTime)
{
	Super.Tick(deltaTime);

   if ((Base != PrevBase) && (Base != None))
      SetOffset();

   if ((Role == ROLE_SimulatedProxy) && (Base != None))
      CorrectLocation();

	// if our owner or base is destroyed, destroy us
	if (Owner == None)
		Destroy();

	if(Region.Zone.bWaterZone)
		Destroy();
}

simulated function BaseChange()
{
	Super.BaseChange();

	if (Base == None)
		SetBase(origBase);
}

simulated function Destroyed()
{
	if (smokeGen != None)
		smokeGen.DelayedDestroy();

	if (fireGen != None)
		fireGen.DelayedDestroy();

	Super.Destroyed();
}

simulated function PostBeginPlay()
{
     local DeusExPlayer player;

	Super.PostBeginPlay();

     if (player.bNoResurrection)
         LightEffect = LE_None;
     else
         LightEffect = LE_FireWaver;

	SetBase(Owner);
	origBase = Owner;

   PrevBase = Base;
   if (Base != None)   
      SetOffset();

   if (Role == ROLE_Authority)
      SpawnSmokeEffects();


}

simulated function PostNetBeginPlay()
{
   Super.PostNetBeginPlay();

   SetBase(Owner);
   origBase = Owner;

   PrevBase = Base;
   if (Base != None)   
      SetOffset();

   if (Role < ROLE_Authority)
      SpawnSmokeEffects();
}

simulated function SetOffset()
{
   BaseOffset = Location - Base.Location;
}

simulated function CorrectLocation()
{
   local float SizeDiff;
   local float DotDiff;

   SizeDiff = VSize(Location - Base.Location) - VSize(BaseOffset);
   if (SizeDiff < 0)
      SizeDiff = -1 * SizeDiff;

   DotDiff = Normal(Location - Base.Location) Dot Normal(BaseOffset);

   if ((DotDiff < 0.9) || (SizeDiff > 20))
   {
      SetLocation(Base.Location + BaseOffset);
   }
}

//DEUS_EX AMSD SpawnSmokeEffects should only be called client side.
simulated function SpawnSmokeEffects()
{
	smokeGen = Spawn(class'ParticleGenerator', Self,, Location, rot(16384,0,0));
	if (smokeGen != None)
	{
		smokeGen.particleDrawScale = 0.22;
		smokeGen.particleLifeSpan = 2.0;
		smokeGen.checkTime = 0.15;
		smokeGen.frequency = 0.9;
		smokeGen.riseRate = 90.0;
		smokeGen.ejectSpeed = 40.0;
		smokeGen.bRandomEject = True;
		smokeGen.SetBase(Self);
                smokeGen.RemoteRole = ROLE_None;
           	smokeGen.particleTexture = Texture'GameMedia.Effects.ef_ExpSmoke011';
	}
}

//DEUS_EX AMSD Unfortunately, this needs to be called from the serverside.
simulated function AddFire(optional float fireLifeSpan)
{
     local DeusExPlayer player;

     player = DeusExPlayer(GetPlayerPawn());

	if (fireLifeSpan == 0.0)
		fireLifeSpan = 0.5;

	if (fireGen == None)
	{
		fireGen = Spawn(class'ParticleGenerator', Self,, Location, rot(16384,0,0));
		if (fireGen != None)
		{
			fireGen.particleLifeSpan = fireLifeSpan;
			fireGen.checkTime = 0.075;
			fireGen.frequency = 0.9;
			fireGen.riseRate = 30.0;
			fireGen.ejectSpeed = 20.0;
			fireGen.bScale = False;
			fireGen.bRandomEject = True;
       			fireGen.bTranslucent = True;
       			fireGen.particleDrawScale = 0.175;
        		fireGen.particleTexture = Texture'GameEffects.Fire.ef_TallFire_001';
			fireGen.SetBase(Self);
                }
	}
}

defaultproperties
{
     DrawScale=0.250000
     DrawType=DT_Sprite
     Style=STY_Translucent
     Texture=Texture'GameEffects.CoolFire.CFire_A000'
     bUnlit=True
     SoundVolume=192
     AmbientSound=Sound'Ambient.Ambient.FireSmall1'
     LightType=LT_Steady
     LightEffect=LE_FireWaver
     LightBrightness=255
     LightHue=16
     LightSaturation=64
     LightRadius=4
}
