//=============================================================================
// Система погоды. Сделанно Ded'ом для мода 2027
// Weather system. Copyright (C) 2005 Smoke39 - bomberman49@hotmail.com
// (Modified by Ded (C) 2005)
//=============================================================================
class WeatherZoneSnow extends WeatherZone;

defaultproperties
{
    PrecipRad=800.00
    PrecipFreq=0.01
    PrecipDensity=7
    PrecipAmp=135
    PrecipClass=Class'WeatherDropSnow'
    bSlanty=false
    bHasSplash=false
    WaterImpactClass=None
    GroundImpactClass=None
    WaterImpactSpawnProb=1.00
    GroundImpactSpawnProb=0.6
    Texture=Texture'Game.Icons.SnowMaker_Icon'
}
