class SFXCamoOnLight extends Light;

var int size;

function Timer()
{
	local int step;
	
	if (size > 0)
	{
		LightRadius = Clamp(size, 1, 100);
		size = -1;
	}

	step = 1;	
	if(size > 16) step = size / 16;
	LightRadius -= step;
	
	if (LightRadius < 1)
		Destroy();
}

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

	SetTimer(0.1, True);
}

defaultproperties
{
     size=3
     bStatic=False
     bNoDelete=False
     bMovable=True
     RemoteRole=ROLE_SimulatedProxy
     LightEffect=LE_Shell
     LightBrightness=255
     LightHue=150
     LightSaturation=128
     LightRadius=1
     bVisionImportant=True
}