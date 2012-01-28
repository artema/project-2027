//=============================================================================
// AugHealing.
//=============================================================================
class AugHealing extends Augmentation;

state Active
{
	function DrawAmrita()
	{
		local EllipseEffect shield;
		
		shield = Spawn(class'EllipseEffect', DeusExPlayer(GetPlayerPawn()),, DeusExPlayer(GetPlayerPawn()).Location, DeusExPlayer(GetPlayerPawn()).Rotation);
	
		if (shield != None)
			shield.SetBase(DeusExPlayer(GetPlayerPawn()));		
	}	
	
Begin:
Loop:
	Sleep(1.0);

	if (Player.Health < 100)
		Player.HealPlayer(Int(LevelValues[CurrentLevel]), False);
	else
		Deactivate();

	DrawAmrita();
	
	Player.ClientFlash(0.5, vect(0, 0, 500));
	Goto('Loop');
}

function Deactivate()
{
	Super.Deactivate();
}

defaultproperties
{
     EnergyRate=150.000000
     Icon=Texture'DeusExUI.UserInterface.AugIconHealing'
     smallIcon=Texture'DeusExUI.UserInterface.AugIconHealing_Small'
     LevelValues(0)=5.0
     MaxLevel=0
     AugmentationLocation=LOC_Torso
}
