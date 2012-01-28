//=============================================================================
// AugVision.
//=============================================================================
class AugVision extends Augmentation;

var localized String NotWithGoggles;

// ----------------------------------------------------------------------------
// Networking Replication
// ----------------------------------------------------------------------------

/*replication
{
   //server to client function calls
   reliable if (Role == ROLE_Authority)
      SetVisionAugStatus;
}*/

state Active
{
Begin:
}

function Activate()
{
	local bool bWasActive;
	local HeatEffect heat;
	local Pawn P;
	
	if(!CanUseVision())
	{
		Player.ClientMessage(NotWithGoggles);
		return;
	}
	
	bWasActive = bIsActive;

	Super.Activate();

	if (!bWasActive && bIsActive)
	{
		//SetVisionAugStatus(CurrentLevel,LevelValues[CurrentLevel],True);
		Player.RelevantRadius = LevelValues[CurrentLevel];

		/*for(P = Level.PawnList; P != None; P = P.NextPawn) {
			if(P.BindName != "JCDenton")
				heat = Spawn(class'HeatEffect', P, , P.Location, P.Rotation);
		}*/

	}
}

function Deactivate()
{
	local bool bWasActive;
	local HeatEffect heat;
	
	bWasActive = bIsActive;

	Super.Deactivate();

	if (bWasActive && !bIsActive)
	{
		//SetVisionAugStatus(CurrentLevel,LevelValues[CurrentLevel],False);
		Player.RelevantRadius = 0;

		/*foreach AllActors(class'HeatEffect', heat){
			heat.Destroy();
		}*/
	}
}

function bool CanUseVision()
{
	return !DeusExRootWindow(Player.rootWindow).hud.augDisplay.bGogglesActive;
}

// ----------------------------------------------------------------------
// SetVisionAugStatus()
// ----------------------------------------------------------------------

/*simulated function SetVisionAugStatus(int Level, int LevelValue, bool IsActive)
{
   if (IsActive)
   {
      if (++DeusExRootWindow(Player.rootWindow).hud.augDisplay.activeCount == 1)      
         DeusExRootWindow(Player.rootWindow).hud.augDisplay.bVisionActive = True;
   }
   else
   {
      if (--DeusExRootWindow(Player.rootWindow).hud.augDisplay.activeCount == 0)
         DeusExRootWindow(Player.rootWindow).hud.augDisplay.bVisionActive = False;
      DeusExRootWindow(Player.rootWindow).hud.augDisplay.visionBlinder = None;
   }
	DeusExRootWindow(Player.rootWindow).hud.augDisplay.visionLevel = Level;
   DeusExRootWindow(Player.rootWindow).hud.augDisplay.visionLevelValue = LevelValue;
}*/

defaultproperties
{
     EnergyRate=30.000000
     Icon=Texture'DeusExUI.UserInterface.AugIconVision'
     smallIcon=Texture'DeusExUI.UserInterface.AugIconVision_Small'
     LevelValues(0)=1200.000000
     LevelValues(1)=1500.000000
     MaxLevel=1
     AugmentationLocation=LOC_Eye
}