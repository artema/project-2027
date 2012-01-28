//=============================================================================
// Pigeon.
//=============================================================================
class Pigeon extends Bird;

defaultproperties
{
     CarcassType=Class'DeusEx.PigeonCarcass'
     WalkingSpeed=0.666667
     GroundSpeed=24.000000
     WaterSpeed=8.000000
     AirSpeed=150.000000
     AccelRate=500.000000
     JumpZ=0.000000
     BaseEyeHeight=3.000000
     Health=2
     UnderWaterTime=20.000000
     AttitudeToPlayer=ATTITUDE_Fear
     HealthHead=2
     HealthTorso=2
     HealthLegLeft=2
     HealthLegRight=2
     HealthArmLeft=2
     HealthArmRight=2
     Alliance=Pigeon
     DrawType=DT_Mesh
     Mesh=LodMesh'DeusExCharacters.Pigeon'
     CollisionRadius=10.000000
     CollisionHeight=3.000000
     Mass=5.000000
     Buoyancy=2.500000
     RotationRate=(Pitch=6000)
     BindName="Pigeon"
     FamiliarName="Голубь"
     UnfamiliarName="Голубь"
}
