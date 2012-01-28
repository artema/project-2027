//=============================================================================
// AugLight.
//=============================================================================
class AugLight extends Augmentation;

var Beam b1, b2;
var Beam2 b21, b22;

function PreTravel()
{
	if (b1 != None)
		b1.Destroy();
	if (b2 != None)
		b2.Destroy();
	b1 = None;
	b2 = None;

	if (b21 != None)
		b21.Destroy();
	if (b22 != None)
		b22.Destroy();
	b21 = None;
	b22 = None;
}

function SetBeamLocation()
{
	local float dist, size, radius, brightness;
	local Vector HitNormal, HitLocation, StartTrace, EndTrace;

	if (b1 != None)
	{
		StartTrace = Player.Location;
		StartTrace.Z += Player.BaseEyeHeight;
		EndTrace = StartTrace + LevelValues[CurrentLevel] * Vector(Player.ViewRotation);

		Trace(HitLocation, HitNormal, EndTrace, StartTrace, True);
		if (HitLocation == vect(0,0,0))
			HitLocation = EndTrace;

		dist       = VSize(HitLocation - StartTrace);
		size       = fclamp(dist/LevelValues[CurrentLevel], 0, 1);
		radius     = size*5.12 + 4.0;
		brightness = fclamp(size-0.5, 0, 1)*2*-192 + 192;
		b1.SetLocation(HitLocation-vector(Player.ViewRotation)*64);
		b1.LightRadius     = byte(radius);
		b1.LightType       = LT_Steady;
	}

	if (b21 != None)
	{
		StartTrace = Player.Location;
		StartTrace.Z += Player.BaseEyeHeight;
		EndTrace = StartTrace + LevelValues[CurrentLevel] * Vector(Player.ViewRotation);

		Trace(HitLocation, HitNormal, EndTrace, StartTrace, True);
		if (HitLocation == vect(0,0,0))
			HitLocation = EndTrace;

		dist       = VSize(HitLocation - StartTrace);
		size       = fclamp(dist/LevelValues[CurrentLevel], 0, 1);
		radius     = size*5.12 + 5.0;
		brightness = fclamp(size-0.5, 0, 1)*2*-192 + 192;
		b21.SetLocation(HitLocation-vector(Player.ViewRotation)*64);
		b21.LightRadius     = byte(radius);
		b21.LightType       = LT_Steady;
	}
}

function vector SetGlowLocation()
{
	local vector pos;

	if (b2 != None)
	{
		pos = Player.Location + vect(0,0,1)*Player.BaseEyeHeight +
		      vect(1,1,0)*vector(Player.Rotation)*Player.CollisionRadius*1.5;
		b2.SetLocation(pos);
	}

	if (b22 != None)
	{
		pos = Player.Location + vect(0,0,1)*Player.BaseEyeHeight +
		      vect(1,1,0)*vector(Player.Rotation)*Player.CollisionRadius*1.5;
		b22.SetLocation(pos);
	}
}

state Active
{
	function Tick (float deltaTime)
	{
		SetBeamLocation();
		SetGlowLocation();
	}
	
	function BeginState()
	{
		Super.BeginState();


          if (CurrentLevel == 0)
          {
		b1 = Spawn(class'Beam', Player, '', Player.Location);
		if (b1 != None)
		{
			AIStartEvent('Beam', EAITYPE_Visual);
			b1.LightHue = 150;
			b1.LightRadius = 4;
			b1.LightSaturation = 100;
			b1.LightBrightness = 135;
			SetBeamLocation();
		}
		b2 = Spawn(class'Beam', Player, '', Player.Location);
		if (b2 != None)
		{
			b2.LightHue = 150;
			b2.LightRadius = 4;
			b2.LightSaturation = 100;
			b2.LightBrightness = 165;
			SetGlowLocation();
		}
          }
          else
          {
		b21 = Spawn(class'Beam2', Player, '', Player.Location);
		if (b21 != None)
		{
			b21.LightHue = 0;
			b21.LightRadius = 24;
			b21.LightSaturation = 50;
			b21.LightBrightness = 165;
			SetBeamLocation();
		}
		b22 = Spawn(class'Beam2', Player, '', Player.Location);
		if (b22 != None)
		{
			b22.LightHue = 0;
			b22.LightRadius = 24;
			b22.LightSaturation = 50;
			b22.LightBrightness = 195;
			SetGlowLocation();
		}
          }
	}

Begin:
}

function Deactivate()
{
	Super.Deactivate();

	if (b1 != None)
		b1.Destroy();
	if (b2 != None)
		b2.Destroy();
	b1 = None;
	b2 = None;

	if (b21 != None)
		b21.Destroy();
	if (b22 != None)
		b22.Destroy();
	b21 = None;
	b22 = None;
}

defaultproperties
{
     EnergyRate=5.000000
     MaxLevel=1
     Icon=Texture'DeusExUI.UserInterface.AugIconLight'
     smallIcon=Texture'DeusExUI.UserInterface.AugIconLight_Small'
     LevelValues(0)=1024.000000
     LevelValues(1)=1024.000000
     AugmentationLocation=LOC_Default
     MPConflictSlot=10
}