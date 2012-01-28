//=============================================================================
// Триггер времени. Сделанно Ded'ом для мода 2027
// Time trigger. Copyright (C) 2003 Ded
//=============================================================================
class GameSpeedTrigger extends Trigger;

var() int TimeParam;
var bool bIsTimed;
var float normalspeed;

function Trigger(Actor Other, Pawn Instigator)
{
   if(!bIsTimed)
   {
       Level.Game.Level.TimeDilation = TimeParam;
       bIsTimed = True;
   }
   else if(bIsTimed)
   {
       normalspeed = Level.Default.Timedilation;
       Level.Game.Level.TimeDilation = normalspeed;
       bIsTimed = False;
   }

}

defaultproperties
{
     TimeParam=0.500000
     bTriggerOnceOnly=False
     bCollideActors=False
}
