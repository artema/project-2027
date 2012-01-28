//=============================================================================
// Tracer.
//=============================================================================
class Tracer extends DeusExProjectile;

var() float rand;

function ZoneChange(ZoneInfo NewZone)
{
	Super.ZoneChange(NewZone);

	if (NewZone.bWaterZone){
		Spawn(class'TracerHitsWater',,,Location,);
		SetTimer(FRand()*rand,False);
	}
}

simulated function Timer()
{
	local int num;
	local int i;

	if(Region.Zone.bWaterZone){
		num = FRand()*2;

		for (i=0; i<num; i++)
			Spawn(class'AirBubble',,,Location,);

		SetTimer(FRand()*rand,False);
	}
}

defaultproperties
{
     rand=0.05
     AccurateRange=16000
     maxRange=16000
     bIgnoresNanoDefense=True
     speed=4000.000000
     MaxSpeed=4000.000000
     Mesh=LodMesh'DeusExItems.Tracer'
     ScaleGlow=2.000000
     bUnlit=True
     LifeSpan=1.25
}
