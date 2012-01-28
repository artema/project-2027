//=============================================================================
// AugSpeed.
//=============================================================================
class AugSpeed extends Augmentation;

state Active
{
Begin:
	Player.GroundSpeed *= LevelValues[CurrentLevel];
	
	if(CurrentLevel >= 1)
		Player.JumpZ *= LevelValues[CurrentLevel];
		
	if ( Level.NetMode != NM_Standalone )
	{
		if ( Human(Player) != None )
			Human(Player).UpdateAnimRate( LevelValues[CurrentLevel] );
	}
}

function Deactivate()
{
	Super.Deactivate();

	Player.GroundSpeed = Player.Default.GroundSpeed;

	Player.JumpZ = Player.Default.JumpZ;
	
	if ( Level.NetMode != NM_Standalone )
	{
		if ( Human(Player) != None )
			Human(Player).UpdateAnimRate( -1.0 );
	}
}

defaultproperties
{
     EnergyRate=80.000000
     Icon=Texture'DeusExUI.UserInterface.AugIconSpeedJump'
     smallIcon=Texture'DeusExUI.UserInterface.AugIconSpeedJump_Small'
     LevelValues(0)=1.500000
     LevelValues(1)=1.800000
     MaxLevel=1
     AugmentationLocation=LOC_Leg
}
