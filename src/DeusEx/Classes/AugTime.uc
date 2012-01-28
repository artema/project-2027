//=============================================================================
// AugSpeedDxMod.
//=============================================================================
class AugTime extends Augmentation;

#exec OBJ LOAD FILE=Effects

var() config float slowspeed;
var float normalspeed;
var bool bDoing;
var() float redrawtime;
var float koef;

simulated function Timer()
{
	local Pawn P;
	local projectile Proj;
	local weapon Weap;
	local MotionBlur MyBlur;
	local DeusExPlayer player;

	/*if(bDoing){
		for(P = Level.PawnList; P != None; P = P.NextPawn) {
			if(P.BindName != "JCDenton")
				MyBlur = Spawn(class'MotionBlur', P, , P.Location, P.Rotation);
		}


		foreach AllActors(class'ScriptedPawn', P) {
			MyBlur = Spawn(class'MotionBlur', P, , P.Location, P.Rotation);
		}*/

		/*foreach AllActors(class'Projectile',Proj) {
			MyBlur = Spawn(class'MotionBlur', Proj, , Proj.Location, Proj.Rotation);
		}

		foreach AllActors(class'Weapon',Weap) {
			MyBlur = Spawn(class'MotionBlur', Weap, , Weap.Location, Weap.Rotation);
		}*/

		
		//SetTimer(koef,False);
	//}
}

function SetSpeed(float Speed)	
{   
    Level.Game.Level.TimeDilation = Speed;
    Level.Game.SetTimer(Level.TimeDilation, true);
}

state Active
{
Begin:
	normalspeed = level.default.timedilation;
	slowspeed = normalspeed / LevelValues[CurrentLevel];
	SetSpeed(slowspeed);
	koef = slowspeed*redrawtime;
	bDoing = true;
	SetTimer(koef,False);
}

function Deactivate()
{	
	local DeusExRootWindow root;
	
	normalspeed = level.default.timedilation;
	Super.Deactivate();	
	SetSpeed(normalspeed);
	bDoing = false;
}

defaultproperties
{
     redrawtime=0.1
     EnergyRate=600.000000
     Icon=Texture'GameMedia.UserInterface.AugIconTime'
     smallIcon=Texture'GameMedia.UserInterface.AugIconTimeSmall'
     LevelValues(0)=1.500000
     LevelValues(1)=2.000000
     MaxLevel=1
     ActivateSound=Sound'GameMedia.Augs.AugTimeOn'
     DeActivateSound=Sound'GameMedia.Augs.AugTimeOff'
     LoopSound=Sound'GameMedia.Augs.AugTimeLoop'
     AugmentationLocation=LOC_Cranial
}