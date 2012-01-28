//=============================================================================
// Система погоды. Сделанно Ded'ом для мода 2027
// Weather system. Copyright (C) 2005 Smoke39 - bomberman49@hotmail.com
// (Modified by Ded (C) 2005)
//=============================================================================
class WeatherShelter extends ZoneInfo;


var(Weather) bool		bSlanty;			// Наклонять ли частицы в противоположную игроку сторону? (ну и говнище %D)

var(Weather) Class<Effects>	WaterImpactClass; 	// Класс частицы при ударе о воду
var(Weather) Class<Effects>	GroundImpactClass;	// Класс частицы при ударе о землю
var(Weather) float	WaterImpactSpawnProb;	// Шанс появления кругов при ударе о воду
var(Weather) float	GroundImpactSpawnProb;	// Шанс появления частиц при ударе о землю
var(Weather) Class<WeatherDrop>	PrecipClass;		// Класс частицы

var(Weather) WeatherNode FirstNode;			// Первая точка в цепи



function BeginPlay()
{
	Super.BeginPlay();

	if ( FirstNode != None )
		FirstNode.Initialize( self );
}

event ActorEntered( Actor Other )
{
	Super.ActorEntered( Other );

	if ( Other.IsA('PlayerPawn') && FirstNode != None && !FirstNode.bOn )
		FirstNode.TurnOn( Other );
}

event ActorLeaving( Actor Other )
{
	Super.ActorLeaving( Other );

	if ( FirstNode != None && FirstNode.Target == Other && FirstNode.bOn )
		FirstNode.TurnOff();
}

defaultproperties
{
    PrecipClass=Class'WeatherDropRain'
    bSlanty=false
    WaterImpactClass=Class'WeatherDropRing'
    GroundImpactClass=Class'WeatherRainSplash'
    WaterImpactSpawnProb=1.00
    GroundImpactSpawnProb=0.6
}
