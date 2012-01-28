//=============================================================================
// HumanMilitary.
//=============================================================================
class HumanMilitary extends ScriptedPawn
	abstract;

function PostBeginPlay()
{
	Super.PostBeginPlay();

	// change the sounds for chicks
	if (bIsFemale)
	{
		HitSound1 = Sound'FemalePainMedium';
		HitSound2 = Sound'FemalePainLarge';
		Die = Sound'FemaleDeath';
	}
}

function bool WillTakeStompDamage(actor stomper)
{
	// This blows chunks!
	if (stomper.IsA('PlayerPawn') && (GetPawnAllianceType(Pawn(stomper)) != ALLIANCE_Hostile))
		return false;
	else
		return true;
}

//HitSound1=Sound'DeusExSounds.Player.MalePainSmall'
//HitSound2=Sound'DeusExSounds.Player.MalePainMedium'
//Die=Sound'DeusExSounds.Player.MaleDeath'

defaultproperties
{
     BaseAccuracy=0.200000
     Skill=3.000000
     maxRange=1000.000000
     MinHealth=20.000000
     bPlayIdle=True
     bCanCrouch=True
     bSprint=True
     CrouchRate=1.000000
     SprintRate=1.000000
     bReactAlarm=True
     EnemyTimeout=5.000000
     bCanTurnHead=True
     WaterSpeed=80.000000
     AirSpeed=160.000000
     AccelRate=500.000000
     BaseEyeHeight=40.000000
     UnderWaterTime=20.000000
     AttitudeToPlayer=ATTITUDE_Ignore
     Intelligence=BRAINS_HUMAN
     VisibilityThreshold=0.010000
     DrawType=DT_Mesh
     Mass=150.000000
     Buoyancy=155.000000
     BindName="HumanMilitary"
}
