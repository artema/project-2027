//=============================================================================
// Система погоды. Сделанно Ded'ом для мода 2027
// Weather system. Copyright (C) 2005 Smoke39 - bomberman49@hotmail.com
// (Modified by Ded (C) 2005)
//=============================================================================
class WeatherNode extends Weather;

var(Weather) bool bNullNode;
var(Weather) WeatherNode NextNode;


function Initialize( WeatherShelter zi )
{
	// create our proxy particle
	// particle generators crash the game without one, so make one even if we won't use it...
	if ( proxy == None )
	{
		proxy = Spawn( class'ParticleProxy' );
		proxy.bHidden = true;
	}

	PrecipClass = zi.PrecipClass;

	if ( NextNode != None )
	{
		if ( !bNullNode )
		{
			WaterImpactClass	= zi.WaterImpactClass;
			WaterImpactSpawnProb	= zi.WaterImpactSpawnProb;
			GroundImpactClass	= zi.GroundImpactClass;
			GroundImpactSpawnProb	= zi.GroundImpactSpawnProb;
		}

		NextNode.Initialize( zi );
	}
	else
	{
		bSlanty = zi.bSlanty;
		bNullNode = true;
	}
}

function TurnOn( Actor newTarget )
{
	Target = newTarget;
	bOn = true;
	if ( !bNullNode )
		SetTimer( PrecipFreq, false );

	if ( NextNode != None )
		NextNode.TurnOn( newTarget );
}

function TurnOff()
{
	bOn = false;

	if ( NextNode != None )
		NextNode.TurnOff();
}

function vector RandomSpawn()
{
	local vector dir, v;

	dir = NextNode.Location - Location;

	v.X = FRand() * VSize(dir);
	v.Y = ( FRand() - 0.5 ) * PrecipRad * 2;

	return location + (v >> rotator(dir)) + (FRand()-0.5)*150 * vect(0,0,1);
}

simulated function Tick( float dt )
{
	local vector vel;
	local float speed;
	local rotator r;
	local Actor p;

	if ( bNullNode )
	{
		// last node handles slantiness
		if ( NextNode == None && bSlanty )
		{
			vel = Target.Velocity;
			vel.Z = 0;
			speed = VSize(vel) / 300;
			if ( speed >= 1 )
				r = rotator(-vel) - rot(16384,0,0) / speed;
			else
				r = rot(-16384,0,0);

			foreach AllActors( PrecipClass, p )
				p.SetRotation( r );
		}

		return;
	}

	if ( bHasSplash && ParticleIterator(RenderInterface) != None )
		ParticleIterator(RenderInterface).Update( dt );
}

// become invisible in-game, spawn proxy in Initialize() instead of here
function PostBeginPlay()
{
	Super(Effects).PostBeginPlay();

	DrawType = DT_None;
}


defaultproperties
{
    PrecipRad=325.00
    PrecipFreq=0.01
    PrecipDensity=5
    PrecipAmp=135
    bHasSplash=True
    DrawType=1
    Texture=Texture'Game.Icons.RainMaker_Icon'
}
