//===========================================================
// Продвинутое освещение. Сделанно Lode Vandevenne'ом
// Advanced lighting. Copyright (C) Lode Vandevenne
//===========================================================
class ScriptedLight expands Light;

enum ETriggerAction
{
	TA_IgnoreTrigger, //Игнорировать тригер
	TA_TriggerTurnsOn, //Свет включается от тригера
	TA_TriggerTurnsOff, //Свет выключается от тригера
	TA_TriggerToggle, //Свет включается или выключается от тригера
	TA_TriggerControlOn, //Свет включен, когда вы стоите на тригере
	TA_TriggerControlOff, //Свет выключен, когда вы стоите на тригере
	TA_TriggerRandom, //Когда вы стоите на тригере, свет включается random'ом
};

var(SLWave) float A; //Variables for waveformulas.
var(SLWave) float B; //The use of these variables depends on the wavetype.
var(SLWave) float C;
var(SLWave) float D;
var(SLWave) float E;
var(SLWave) float F;
var(SLWave) float G;
var(SLWave) float H;
var(SLWave) byte SquareOffValue; //The values the wave has when the SquareWave, RandomWave 
var(SLWave) byte SquareOnValue; //and SimpleSquareWave get in their "Off" or "On" position
var(SLWave) float FlickerTime; //The time FX_TriggerFlickersOn keeps flickering
var(SLWave) float ScriptedLightPeriod; //This is the length of one TimeCycle

var(SLWave) int VolumeBrightnessOn;
var(SLWave) int VolumeBrightnessOff;

var byte CurrentBrightness;

var(SLUse) bool bUseBrightness; //If True, the waves and keys...
var(SLUse) bool bUseHue; //...are used on the chosen lightsettings...
var(SLUse) bool bUseSaturation; //...If False, the settings in Lighting...
var(SLUse) bool bUseRadius; //...and LightColor are kept
var(SLUse) bool bUseVolumeBrightness;
var(SLUse) bool bUseVolumeFog;
var(SLUse) bool bUseVolumeRadius;
var(SLUse) bool bUseDrawScale;
var(SLUse) bool bUseBrightness2; //These are used for the DoubleSinusWave
var(SLUse) bool bUseHue2;
var(SLUse) bool bUseSaturation2;
var(SLUse) bool bUseRadius2;
var(SLUse) bool bUseVolumeBrightness2;
var(SLUse) bool bUseVolumeFog2;
var(SLUse) bool bUseVolumeRadius2;
var(SLUse) bool bUseDrawScale2;
var(SLUse) byte HueStartPoint; //LightHue to start with (you'll rarely need this, if ever)
var(SLUse) bool bUseCorona; //These 3 are only used for "digital" waves such as...
var(SLUse) bool bUseLightEffect; //...SquareWave and RandomWave...
var(SLUse) bool bUseLightType; //...but also for Keys
var(SLUse) float DrawScaleStartPoint;

var(SLTrigger) ETriggerAction TriggerAction; //How a trigger affects the light
var(SLTrigger) bool bInitiallyOff; //If True, the light will be off before triggered.
var(SLTrigger) byte TriggerOffValue; //The values used on Light settings when it's...
var(SLTrigger) byte TriggerOnValue; //...triggered "Off" or "On"
var(SLTrigger) bool bTriggerCoronaToo; //If True, corona is only there when the light is on.
var(SLTrigger) bool bUseEvent;

var(SLKeys) byte KeyBrightness[4]; //These are the settings that you can set for...
var(SLKeys) byte KeyHue[4]; //...Key0, Key1, Key2 and Key3...
var(SLKeys) byte KeySaturation[4]; //...Only if the appropriate bUse___ bool is True...
var(SLKeys) byte KeyRadius[4]; //...These settings are used
var(SLKeys) byte KeyVolumeBrightness[4];
var(SLKeys) byte KeyVolumeFog[4];
var(SLKeys) byte KeyVolumeRadius[4];
var(SLKeys) byte KeyDrawScale[4];
var(SLKeys) float KeyTime[4]; //The time the key remains constant
var(SLKeys) float TransTime[4]; //The time the key needs to smoothly change to the next key
var(SLKeys) int StartKey; //Only for KEY_Trigger: the key the light starts at
var(SLKeys) int NumKeys; //Only for KEY_Trigger: the number of keys (2,3 or 4)
var(SLKeys) ELightType KeyLightType[4]; //These work for the constant parts of the keytransition and...
var(SLKeys) ELightEffect KeyLightEffect[4]; //...are kept constant during smooth transitions
var(SLKeys) byte bKeyCorona[4]; //This is a byte because bools don't support arrays. 1 means True
var(SLKeys) bool bSwapDirection; //Doesn't work (yet) :)

var float SLTicker;
var float TimerControl;
var int ArrayValue;
var float TurnOnTimer;
var int FlickerStatus;
var float RandomValue;
var float SLWave;
var bool bSLWave;
var float SLWave2;

var float SilenceTimer;

var DeusExPlayer Player;

var bool bInWorld;
var vector WorldPosition;

////////////////////////////////
function PostBeginPlay()
{
	TurnOnTimer = 0;
	FlickerStatus = 0;
	ScriptedLightperiod = 1/ScriptedLightPeriod;
	if (bInitiallyOff == True) 
	{
		LightBrightness = TriggerOffValue;
		if (bTriggerCoronaToo) bCorona = False;
		
		VolumeBrightness = VolumeBrightnessOff;

		if(VolumeBrightnessOn > 0)
			LeaveWorld();
	}
	else{
		if(VolumeBrightnessOn > 0)
			VolumeBrightness = VolumeBrightnessOn;
	}

	CurrentBrightness = LightBrightness;
		

	Player = DeusExPlayer(GetPlayerPawn());
}

////////////////////////////////
function TriggerActions()
{
	Switch(TriggerAction)
	{
		case TA_IgnoreTrigger:
			break;
		case TA_TriggerTurnsOff:
			LightBrightness = TriggerOffValue;
			if (bTriggerCoronaToo) bCorona = False;
			bInitiallyOff = True;
			break;
		case TA_TriggerTurnsOn:
			LightBrightness = TriggerOnValue;
			if (bTriggerCoronaToo) bCorona = True;
			bInitiallyOff = False;
			break;
		case TA_TriggerToggle:
			Switch ( bInitiallyOff )
			{
				case True:
					if(FlickerTime == 0) LightBrightness = TriggerOnValue;
					if (bTriggerCoronaToo) bCorona = True;
					bInitiallyOff = False;
					break;
				case False:
					if(FlickerTime == 0) LightBrightness = TriggerOffValue;
					if (bTriggerCoronaToo) bCorona = False;
					bInitiallyOff = True;
					break;				
			}
			break;
		case TA_TriggerControlOn:
			LightBrightness = TriggerOnValue;
			if (bTriggerCoronaToo) bCorona = True;
			bInitiallyOff = False;
			break;
		case TA_TriggerControlOff:
			LightBrightness = TriggerOffValue;
			if (bTriggerCoronaToo) bCorona = False;
			bInitiallyOff = True;
			break;
		case TA_TriggerRandom:
			RandomValue = FRand();
			if (RandomValue < 0.5)
			{
				LightBrightness = TriggerOnValue;
				if (bTriggerCoronaToo) bCorona = True;
				bInitiallyOff = False;
			}
			else
			{
				LightBrightness = TriggerOffValue;
				if (bTriggerCoronaToo) bCorona = False;
				bInitiallyOff = True;
				DoEvent();
			}
			break;
	}
}

////////////////////////////////
function UnTriggerActions()
{
Switch( TriggerAction )
	{
		case TA_TriggerControlOn:
			LightBrightness = TriggerOffValue;
			if (bTriggerCoronaToo) bCorona = False;
			bInitiallyOff = True;
			break;
		case TA_TriggerControlOff:
			LightBrightness = TriggerOnValue;
			if (bTriggerCoronaToo) bCorona = True;
			bInitiallyOff = False;
			break;
		default:
			break;
	}
}

////////////////////////////////
function DoEvent()
{
	local actor A;
	if (bUseEvent)
	{
		foreach AllActors( class 'Actor', A, Event ) { if (a!=None) a.Trigger(self, None); }
	}
}

////////////////////////////////
function ApplySettings(float SLApply, bool bApply)
{
		If (bUseBrightness && bInitiallyOff == False) LightBrightness = SLApply;
		If (bUseHue) LightHue = SLApply + HueStartPoint;
		If (bUseSaturation) LightSaturation = SLApply;
		If (bUseRadius) LightRadius = SLApply;
		//If (bUseVolumeBrightness) VolumeBrightness = SLApply;
		If (bUseVolumeFog) VolumeFog = SLApply;
		If (bUseVolumeRadius) VolumeRadius = SLApply;
		If (bUseDrawScale) DrawScale = DrawScaleStartPoint*SLApply/255;
		If (bUseCorona && bInitiallyOff == False) bCorona = bApply;
}

////////////////////////////////
function ModifyKeySingle(int Array1)
{
	If (bUseBrightness && bInitiallyOff == False) LightBrightness = KeyBrightness[Array1];
	If (bUseHue) LightHue = KeyHue[Array1] + HueStartPoint;
	If (bUseSaturation) LightSaturation = KeySaturation[Array1];
	If (bUseRadius) LightRadius = KeyRadius[Array1];
	If (bUseVolumeBrightness) VolumeBrightness = KeyVolumeBrightness[Array1];
	If (bUseVolumeFog) VolumeFog = KeyVolumeFog[Array1];
	If (bUseVolumeRadius) VolumeRadius = KeyVolumeRadius[Array1];
	If (bUseDrawScale) DrawScale = KeyDrawScale[Array1]/64;
	If (bUseCorona && bKeyCorona[Array1] == 0) bCorona = False;
	If (bUseCorona && bKeyCorona[Array1] == 1) bCorona = True;
	If (bUseLightType) LightType = KeyLightType[Array1];
	If (bUseLightEffect) LightEffect = KeyLightEffect[Array1];
}

////////////////////////////////
state() WAVE_Sinus
{
	function tick(float DeltaTime)
	{
		SLWave = 255*(D+A*Sin(B*ScriptedLightPeriod*Level.TimeSeconds*2*pi));
		ApplySettings(SLWave, bCorona);
	}

	function Trigger(actor Other, pawn EventInstigator) 
	{
		TriggerActions();
	}

	function UnTrigger(actor Other, pawn EventInstigator)
	{
		UnTriggerActions();
	}

}

////////////////////////////////
state() WAVE_SawTooth
{
	function tick(float deltatime)
	{
		SLTicker = ScriptedLightPeriod*Level.TimeSeconds - TimerControl;
		if (ScriptedLightPeriod*Level.TimeSeconds - TimerControl > 1) 
		{
			TimerControl = ScriptedLightPeriod*Level.TimeSeconds;
		}		
		SLWave = A*SLTicker+B;
		ApplySettings(SLWave, bCorona);
	}

	function Trigger(actor Other, pawn EventInstigator) 
	{
		TriggerActions();
	}

	function UnTrigger(actor Other, pawn EventInstigator)
	{
		UnTriggerActions();
	}
}


/////////////////////////////
state() WAVE_AdvancedSquare
{
	function tick(float DeltaTime)
	{
		SLTicker = ScriptedLightPeriod*Level.TimeSeconds - TimerControl;
		if (ScriptedLightPeriod*Level.TimeSeconds - TimerControl > 1) 
		{
			TimerControl = ScriptedLightPeriod*Level.TimeSeconds;
		}
		If (SLTicker < H) {SLWave = SquareOffValue; bSLWave = False;}
		If (SLTicker < G) {SLWave = SquareOnValue; bSLWave = True;}
		If (SLTicker < F) {SLWave = SquareOffValue; bSLWave = False;}
		If (SLTicker < E) {SLWave = SquareOnValue; bSLWave = True;}
		If (SLTicker < D) {SLWave = SquareOffValue; bSLWave = False;}
		If (SLTicker < C) {SLWave = SquareOnValue; bSLWave = True;}
		If (SLTicker < B) {SLWave = SquareOffValue; bSLWave = False;}
		If (SLTicker < A) {SLWave = SquareOnValue; bSLWave = True;}
		ApplySettings(SLWave, bSLWave);
	}

	function Trigger(actor Other, pawn EventInstigator) 
	{
		TriggerActions();
	}

	function UnTrigger(actor Other, pawn EventInstigator)
	{
		UnTriggerActions();
	}

}

/////////////////////////////
state() WAVE_Square
{
	function tick(float DeltaTime)
	{
		SLTicker = ScriptedLightPeriod*Level.TimeSeconds - TimerControl;
		if (ScriptedLightPeriod*Level.TimeSeconds - TimerControl > 1) 
		{
			TimerControl = ScriptedLightPeriod*Level.TimeSeconds;
		}
		
		If (SLTicker < 0.5)  ApplySettings(SquareOffValue, False);
		If (SLTicker >= 0.5) ApplySettings(SquareOnValue, True);
	}

	function Trigger(actor Other, pawn EventInstigator) 
	{
		TriggerActions();
	}

	function UnTrigger(actor Other, pawn EventInstigator)
	{
		UnTriggerActions();
	}
}

////////////////////////////////
state() WAVE_Random
{
	function tick(float DeltaTime)
	{
		SLTicker = ScriptedLightPeriod*Level.TimeSeconds - TimerControl;
		if (ScriptedLightPeriod*Level.TimeSeconds - TimerControl > 1) 
		{
			TimerControl = ScriptedLightPeriod*Level.TimeSeconds;
			DoRandom();
		}		
	}

	function DoRandom()
	{
		RandomValue = FRand();		
		If (RandomValue < A) ApplySettings(SquareOffValue, False);
		If (RandomValue >= A) ApplySettings(SquareOnValue, True);
	}

	function Trigger(actor Other, pawn EventInstigator) 
	{
		TriggerActions();
	}

	function UnTrigger(actor Other, pawn EventInstigator)
	{
		UnTriggerActions();
	}
}

////////////////////////////////
state() WAVE_DoubleSinus
{
	function tick(float deltatime)
	{
		SLWave = 255*(D+A*Sin(B*ScriptedLightPeriod*Level.TimeSeconds*2*pi + C));
		SLWave2 = 255*(H+E*Sin(F*ScriptedLightPeriod*Level.TimeSeconds*2*pi + G));
	
		If (bUseHue && !bUseHue2) LightHue = SLWave + HueStartPoint;
		If (bUseSaturation && !bUseSaturation2) LightSaturation = SLWave;
		If (bUseRadius && !bUseRadius2) LightRadius = SLWave;
		If (bUseVolumeBrightness && !bUseVolumeBrightness2) VolumeBrightness = SLWave;
		If (bUseVolumeFog && !bUseVolumeFog2) VolumeFog = SLWave;
		If (bUseVolumeRadius && !bUseVolumeRadius2) VolumeRadius = SLWave;
		If (bUseDrawScale && !bUseDrawScale2) DrawScale = DrawScaleStartPoint*SLWave/255;
		If (bUseBrightness && !bUseBrightness2 && bInitiallyOff == False) LightBrightness =  SLWave;


		If (!bUseHue && bUseHue2) LightHue = SLWave2 + HueStartPoint;
		If (!bUseSaturation && bUseSaturation2) LightSaturation = SLWave2;
		If (!bUseRadius && bUseRadius2) LightRadius = SLWave2;
		If (!bUseVolumeBrightness && bUseVolumeBrightness2) VolumeBrightness = SLWave2;
		If (!bUseVolumeFog && bUseVolumeFog2) VolumeFog = SLWave2;
		If (!bUseVolumeRadius && bUseVolumeRadius2) VolumeRadius = SLWave2;
		If (!bUseDrawScale && bUseDrawScale2) DrawScale = DrawScaleStartPoint*SLWave2/255;
		If (!bUseBrightness && bUseBrightness2 && bInitiallyOff == False) LightBrightness =  SLWave2;

		If (bUseHue && bUseHue2) LightHue = (SLWave+SLWave2) + HueStartPoint;
		If (bUseSaturation && bUseSaturation2) LightSaturation = (SLWave+SLWave2);
		If (bUseRadius && bUseRadius2) LightRadius = (SLWave+SLWave2);
		If (bUseVolumeBrightness && bUseVolumeBrightness2) VolumeBrightness =  (SLWave+SLWave2);
		If (bUseVolumeFog && bUseVolumeFog2) VolumeFog = (SLWave+SLWave2);
		If (bUseVolumeRadius && bUseVolumeRadius2) VolumeRadius = (SLWave+SLWave2);
		If (bUseDrawScale && bUseDrawScale2) DrawScale =  DrawScaleStartPoint*(SLWave+SLWave2)/255;
		If (bUseBrightness && bUseBrightness2 && bInitiallyOff == False) LightBrightness =  (SLWave+SLWave2);

	}

	function trigger(actor Other, pawn EventInstigator) 
	{
		TriggerActions();
	}

	function UnTrigger( actor Other, pawn EventInstigator )
	{
		UnTriggerActions();
	}

}

///////////////////////////
state() WAVE_Constant
{
	function trigger(actor Other, pawn EventInstigator) 
	{
		TriggerActions();
	}

	function UnTrigger( actor Other, pawn EventInstigator )
	{
		UnTriggerActions();
	}

}

///////////////////////////////
state() KEY_Timed
{
	function tick(float DeltaTime)
	{
	//	local bool bSLWave;
		local int tmpvolume;

		if (FlickerStatus != 0)	
		{
			SilenceTimer += DeltaTime;

			if(SilenceTimer < FlickerTime)
			{	
				if(VolumeBrightnessOn > 0)
				{
					if(FlickerStatus == 1)
						tmpvolume =  VolumeBrightnessOff + int(float(VolumeBrightnessOn - VolumeBrightnessOff) / (FlickerTime - SilenceTimer));
					else if(FlickerStatus == 2)
						tmpvolume =  VolumeBrightnessOn - int(float(VolumeBrightnessOn - VolumeBrightnessOff) / (FlickerTime - SilenceTimer));
				}
				else
				{
					if(FlickerStatus == 1)
						tmpvolume =  CurrentBrightness + int(float(TriggerOnValue - CurrentBrightness) / (FlickerTime - SilenceTimer));
					else if(FlickerStatus == 2)
						tmpvolume =  CurrentBrightness - int(float(CurrentBrightness - TriggerOffValue) / (FlickerTime - SilenceTimer));

				}

				if(tmpvolume < 0)
					tmpvolume = 0;

				if(FlickerStatus == 1)
				{
					if(VolumeBrightnessOn > 0)
					{
						if(tmpvolume > VolumeBrightnessOn)
							tmpvolume = VolumeBrightnessOn;
					}
					else
					{
						if(tmpvolume > TriggerOnValue)
							tmpvolume = TriggerOnValue;
					}
				}

				if(FlickerStatus == 2)
				{
					if(VolumeBrightnessOn > 0)
					{
						if(tmpvolume < VolumeBrightnessOff)
							tmpvolume = VolumeBrightnessOff;
					}
					else
					{
						if(tmpvolume < TriggerOffValue)
							tmpvolume = TriggerOffValue;
					}
				}

				if(VolumeBrightnessOn > 0)					
					VolumeBrightness = tmpvolume;
				else
					LightBrightness = tmpvolume;
			}
			else{
				if(VolumeBrightnessOn > 0)
				{
					if(FlickerStatus == 1)
						VolumeBrightness = VolumeBrightnessOn;
					else if(FlickerStatus == 2)
					{
						VolumeBrightness = VolumeBrightnessOff;

						if(VolumeBrightnessOn > 0)
							LeaveWorld();
					}
				}
				else
				{
					if(FlickerStatus == 1)
						LightBrightness = TriggerOnValue;
					else if(FlickerStatus == 2)
						LightBrightness = TriggerOffValue;
				}

				FlickerStatus = 0;
			}
		}

		SLTicker = ScriptedLightPeriod*Level.TimeSeconds - TimerControl;

		if (ScriptedLightPeriod*Level.TimeSeconds - TimerControl > 1) 
			TimerControl = ScriptedLightPeriod*Level.TimeSeconds;

		If (SLTicker > KeyTime[0] && SLTicker <= TransTime[0]) ModifyKeySingle(0);
		If (SLTicker > TransTime[0] && SLTicker <= KeyTime[1])  ModifyKeyDouble(0,1,KeyTime[1],SLTicker);
		If (SLTicker > KeyTime[1] && SLTicker <= TransTime[1]) ModifyKeySingle(1);
		If (SLTicker > TransTime[1] && SLTicker <= KeyTime[2])  ModifyKeyDouble(1,2,KeyTime[2],SLTicker);
		If (SLTicker > KeyTime[2] && SLTicker <= TransTime[2]) ModifyKeySingle(2);
		If (SLTicker > TransTime[2] && SLTicker <= KeyTime[3])  ModifyKeyDouble(2,3,KeyTime[3],SLTicker);
		If (SLTicker > KeyTime[3] && SLTicker <= TransTime[3]) ModifyKeySingle(3);
		If (SLTicker > TransTime[3] && SLTicker <= 1-KeyTime[0])  ModifyKeyDouble(3,0,1-KeyTime[0],SLTicker);
	}

	function ModifyKeyDouble(int Array1, int Array2, float Time2, float Ticker)
	{
		local float Mult1, Mult2, Mult3;
		Mult1 = (Ticker - TransTime[Array1])/(Time2-TransTime[Array1]);
		Mult2 = (Time2 - Ticker)/(Time2-TransTime[Array1]);
		If (bUseHue) LightHue = Mult2*KeyHue[Array1] + Mult1*KeyHue[Array2] + HueStartPoint; 
		If (bUseSaturation) LightSaturation = Mult2*KeySaturation[Array1] +  Mult1*KeySaturation[Array2];
		If (bUseRadius) LightRadius = Mult2*KeyRadius[Array1] + Mult1*KeyRadius[Array2];
		If (bUseVolumeFog) VolumeFog = Mult2*KeyVolumeFog[Array1] +  Mult1*KeyVolumeFog[Array2];
		If (bUseVolumeRadius) VolumeRadius = Mult2*KeyVolumeRadius[Array1] +  Mult1*KeyVolumeRadius[Array2];
		If (bUseDrawScale) DrawScale = (Mult2*KeyDrawScale[Array1] +  Mult1*KeyDrawScale[Array2])/64;
		If (bUseCorona && bKeyCorona[Array1] == 0) bCorona = False;
		If (bUseCorona && bKeyCorona[Array1] == 1) bCorona = True;
		If (bUseLightType) LightType = KeyLightType[Array1];
		If (bUseLightEffect) LightEffect = KeyLightEffect[Array1];
		If (bUseBrightness && bInitiallyOff == False) LightBrightness =  Mult2*KeyBrightness[Array1] + Mult1*KeyBrightness[Array2];
		If (bUseVolumeBrightness) VolumeBrightness = Mult2*KeyVolumeBrightness[Array1] +  Mult1*KeyVolumeBrightness[Array2];
	}

	function Trigger(actor Other, pawn EventInstigator) 
	{
		SilenceTimer = 0;

		if(VolumeBrightnessOn == 0)
			CurrentBrightness = LightBrightness;

		Switch (bInitiallyOff)
		{
			case False:
				If(FlickerTime > 0)
				{
					FlickerStatus=2;

					if(VolumeBrightnessOn > 0)
						VolumeBrightness=VolumeBrightnessOn;
				}
				break;
			case True:
				If(FlickerTime > 0)
				{
					FlickerStatus=1;

					if(VolumeBrightnessOn > 0)
						VolumeBrightness=VolumeBrightnessOff;

					if(VolumeBrightnessOn > 0)
						EnterWorld();
				}
				break;
			default:
				break;
		}

		TriggerActions();
	}

	function UnTrigger(actor Other, pawn EventInstigator)
	{
		UnTriggerActions();
	}
}

/////////////////////////////////
state() KEY_Triggered
{
	function tick(float DeltaTime)
	{
	if (StartKey < 4) ModifyKeySingle(StartKey);
	}

	function trigger(actor Other, pawn EventInstigator) 
	{
		Switch (NumKeys)
		{
			case 2:
				Switch( StartKey )
				{
					case 0:
						StartKey = 1;
						ModifyKeySingle(1);
						break;
					case 1:
						StartKey = 0;
						ModifyKeySingle(0);
						break;
					default:
						StartKey = 0;
						ModifyKeySingle(0);
						break;
				}
				break;
			case 3:
				Switch( StartKey )
				{
					case 0:
						StartKey = 1;
						ModifyKeySingle(1);
						break;
					case 1:
						StartKey = 2;
						ModifyKeySingle(2);
						break;
					case 2:
						StartKey = 0;
						ModifyKeySingle(0);
						break;
					default:
						StartKey = 0;
						ModifyKeySingle(0);
						break;
				}
				break;
			case 4:
				Switch( StartKey )
				{
					case 0:
						StartKey = 1;
						ModifyKeySingle(1);
						break;
					case 1:
						StartKey = 2;
						ModifyKeySingle(2);
						break;
					case 2:
						StartKey = 3;
						ModifyKeySingle(3);
						break;
					case 3:
						StartKey = 0;
						ModifyKeySingle(0);
						break;
					default:
						StartKey = 0;
						ModifyKeySingle(0);
						break;
				}
				break;
			default:
				break;
		}		
	}
}

//////////////////////////////////
state() FX_TriggerFlickersOn
{
	function trigger(actor Other, pawn EventInstigator) 
	{
		Switch(TriggerAction)
		{
			case TA_IgnoreTrigger:
				break;
			case TA_TriggerTurnsOff:
				LightBrightness = TriggerOffValue;
				if (bTriggerCoronaToo) bCorona = False;
				FlickerStatus = 2;
				break;
			case TA_TriggerTurnsOn:
				If (FlickerStatus != 2) {FlickerStatus = 1; bInitiallyOff = False; TurnOnTimer = Level.TimeSeconds;}
				break;
			case TA_TriggerToggle:
				Switch (bInitiallyOff)
				{
					case False:
						LightBrightness = TriggerOffValue;
						if (bTriggerCoronaToo) bCorona = False;
						FlickerStatus = 0;
						bInitiallyOff = True;
						break;
					case True:
						If (FlickerStatus == 0) {FlickerStatus = 1; bInitiallyOff = False; TurnOnTimer = Level.TimeSeconds;}
						break;
					default:
						break;
				}
				break;
		}
	}

	function tick(float deltatime)
	{
		if (FlickerStatus == 1)	
		{
			if (ScriptedLightPeriod*Level.TimeSeconds - TimerControl > 1) 
			{
				TimerControl = ScriptedLightPeriod*Level.TimeSeconds; 
				DoRandom();
			}
		
			if (Level.TimeSeconds - TurnOnTimer > FlickerTime) 
			{
				FlickerStatus = 2;
				If (bUseBrightness) LightBrightness = SquareOnValue;
				If (bUseCorona) bCorona = True;
				DoEvent();
			}
		}
	}

	function DoRandom()
	{
		RandomValue = FRand();		
		If (RandomValue < A) {SLWave = SquareOffValue; bSLWave = False;}
		If (RandomValue >= A) {SLWave = SquareOnValue; bSLWave = True;}	
		If (bUseBrightness) LightBrightness = SLWave;
		If (bUseCorona) bCorona = bSLWave;
	}
}

// ----------------------------------------------------------------------
// EnterWorld()
// ----------------------------------------------------------------------

function EnterWorld()
{
	PutInWorld(true);
}


// ----------------------------------------------------------------------
// LeaveWorld()
// ----------------------------------------------------------------------

function LeaveWorld()
{
	PutInWorld(false);
}


// ----------------------------------------------------------------------
// PutInWorld()
// ----------------------------------------------------------------------

function PutInWorld(bool bEnter)
{
	if (bInWorld && !bEnter)
	{
		bInWorld = false;
		bHidden       = true;
		bDetectable   = false;
		WorldPosition = Location;
		SetCollision(false, false, false);
		bCollideWorld = false;
		SetPhysics(PHYS_None);
		SetLocation(Location+vect(0,0,20000));  // move it out of the way
	}
	else if (!bInWorld && bEnter)
	{
		bInWorld    = true;
		bHidden     = Default.bHidden;
		bDetectable = Default.bDetectable;
		SetLocation(WorldPosition);
		SetCollision(Default.bCollideActors, Default.bBlockActors, Default.bBlockPlayers);
		bCollideWorld = Default.bCollideWorld;
		SetPhysics(Default.Physics);
	}
}

defaultproperties
{
     bInWorld=True
     Texture=Texture'Game.Icons.SLight_Icon'
     bStatic=False
     bMovable=True
     InitialState=WAVE_Sinus
     Style=STY_Translucent
}
