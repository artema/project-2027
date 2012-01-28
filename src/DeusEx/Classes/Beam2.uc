//=============================================================================
// Beam
//=============================================================================
class Beam2 expands Light;

function BeginPlay()
{
	DrawType = DT_None;
}

defaultproperties
{
     bStatic=False
     bHidden=False
     bNoDelete=False
     bMovable=True
     LightEffect=LE_NonIncidence
     LightBrightness=250
     LightHue=32
     LightSaturation=142
     LightRadius=7
     LightPeriod=0
}
