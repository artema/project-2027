//=============================================================================
// ������� ������. �������� Ded'�� ��� ���� 2027
// Weather system. Copyright (C) 2005 Smoke39 - bomberman49@hotmail.com
// (Modified by Ded (C) 2005)
//=============================================================================
class WeatherDrop extends Effects
     abstract;

var() int FallingSpeed;

function PostBeginPlay()
{
	local int Amp;
	local vector vel;
	
	if (WeatherZone(Region.Zone) == None)
		Recycle();
		
	Amp = Weather(Owner).PrecipAmp;
	Velocity.X += (FRand() - 0.50) * Amp;
	Velocity.Y += (FRand() - 0.50) * Amp;

	Super.PostBeginPlay();
	
	Randomize();
	SetRotation( Rotator(Velocity) );
}

simulated function Timer()
{
	local int Amp;
	
	Amp = Weather(Owner).PrecipAmp;
	
	if(Amp > 0)
	{

		Velocity.X += (FRand() - 0.50) * Amp;
		Velocity.Y += (FRand() - 0.50) * Amp;
		SetTimer(0.3,False);
	}
}

function Randomize()
{
	Velocity.Z = -FallingSpeed - FRand()*800;
	DrawScale = Default.DrawScale * (1 + FRand()*4);
	ScaleGlow = 0.3 + FRand()*0.6;
}

function Landed(Vector HitNormal)
{
	Impact(Location - CollisionHeight*vect(0,0,1));
	Recycle();
}

function HitWall(Vector HitNormal, Actor HitWall)
{
	Impact( Location - CollisionHeight*vect(0,0,1));
	Recycle();
}

event ZoneChange(ZoneInfo NewZone)
{
	Super.ZoneChange(NewZone);
	
	if (!NewZone.IsA('WeatherZone') || NewZone.bWaterZone)
	{
		if (NewZone.bWaterZone && Weather(Owner) != None && LastRendered() < 0.1)
			Weather(Owner).WaterImpact(Location);

		Recycle();
	}
}

function Impact(Vector SplashLoc)
{
	if (Weather(Owner) != None && LastRendered() < 0.1)
		Weather(Owner).Impact(SplashLoc);
}

function Recycle()
{
	Destroy();
}

defaultproperties
{
	FallingSpeed=1100
    bUnlit=True
    Physics=PHYS_Projectile
    LifeSpan=3.00
    DrawType=DT_Mesh
    Style=3
    Skin=Texture'Game.Skins.WeatherRainDrop'
    Mesh=LodMesh'DeusExItems.Tracer'
    DrawScale=0.25
    CollisionHeight=20.00
    bCollideActors=True
    bCollideWorld=True
}
