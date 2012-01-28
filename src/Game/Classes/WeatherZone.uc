//=============================================================================
// Система погоды. Сделанно Ded'ом для мода 2027
// Weather system. Copyright (C) 2005 Smoke39 - bomberman49@hotmail.com
// (Modified by Ded (C) 2005)
//=============================================================================
class WeatherZone extends ZoneInfo
     abstract;

var(Weather) float	PrecipRad;			// Радиус дождя
var(Weather) float	PrecipFreq;			// Задержка (в секундах) между спавнами частиц
var(Weather) byte		PrecipDensity;		// Кол-во частиц за один спавн
var(Weather) int		PrecipAmp;			// Амплитуда падения частицы
var(Weather) bool		bSlanty;			// Наклонять ли частицы в противоположную игроку сторону? (ну и говнище %D)
var(Weather) bool		bHasSplash;			// Нужно ли спавнить эффект от удара о землю?
var(Weather) float	WaterImpactSpawnProb;	// Шанс появления кругов при ударе о воду
var(Weather) float	GroundImpactSpawnProb;	// Шанс появления частиц при ударе о землю
								// 0 = никогда, 1 = всегда

var Class<Actor>	WaterImpactClass; 		// Класс частицы при ударе о воду
var Class<Actor>	GroundImpactClass;		// Класс частицы при ударе о землю
var Class<WeatherDrop>	PrecipClass;		// Класс частицы

var Weather PrecipGen;					// Наш генератор частиц

event ActorEntered(Actor Other)
{
	Super.ActorEntered(Other);

	if (Other.IsA('PlayerPawn'))
	{
		if (PrecipGen == None)
		{
			PrecipGen = Spawn(class'Weather');

			PrecipGen.PrecipRad				= PrecipRad;
			PrecipGen.PrecipFreq				= PrecipFreq;
			PrecipGen.PrecipDensity				= PrecipDensity;
			PrecipGen.PrecipAmp				= PrecipAmp;
			PrecipGen.PrecipClass				= PrecipClass;
			PrecipGen.bSlanty					= bSlanty;
			PrecipGen.bHasSplash				= bHasSplash;

			if (WaterImpactClass != None && WaterImpactSpawnProb > 0)
			{
				PrecipGen.WaterImpactClass		= WaterImpactClass;
				PrecipGen.WaterImpactSpawnProb	= WaterImpactSpawnProb;
			}

			if (GroundImpactClass != None && GroundImpactSpawnProb > 0)
			{
				PrecipGen.GroundImpactClass		= GroundImpactClass;
				PrecipGen.GroundImpactSpawnProb	= GroundImpactSpawnProb;
			}
		}

		PrecipGen.TurnOn(Other);
	}
}

event ActorLeaving(Actor Other)
{
	Super.ActorLeaving(Other);

	if (PrecipGen != None && PrecipGen.Target == Other)
	{
		PrecipGen.TurnOff();
		PrecipGen = None;
	}
}

defaultproperties
{
    bHidden=True
    PrecipRad=650.00
    PrecipFreq=0.01
    PrecipDensity=7
    PrecipAmp=135
    PrecipClass=Class'WeatherDrop'
    bSlanty=false
    bHasSplash=true
    WaterImpactClass=Class'WeatherDropRing'
    GroundImpactClass=Class'WeatherRainSplash'
    WaterImpactSpawnProb=1.00
    GroundImpactSpawnProb=0.6
    Texture=Texture'Game.Icons.RainMaker_Icon'
}
