//=============================================================================
// CutSceneScript.
//=============================================================================
class CutSceneScript extends MissionScript
	transient
	abstract;

var ConPlay conPlay;

function InitStateMachine()
{
	Super.InitStateMachine();
	
	flags.SetBool('PlayerTraveling', True, True, 0);
	flags.SetBool('PlayerInCutscene', True, True, 0);
}

// ----------------------------------------------------------------------
// FinishCinematic()
// ----------------------------------------------------------------------
function FinishCinematic()
{
}

// ----------------------------------------------------------------------
// FirstFrame()
// 
// Stuff to check at first frame
// ----------------------------------------------------------------------
function FirstFrame()
{
	Super.FirstFrame();
	flags.SetBool('PlayerInCutscene', True, True, 0);
}

// ----------------------------------------------------------------------
// PreTravel()
// 
// Set flags upon exit of a certain map
// ----------------------------------------------------------------------

function PreTravel()
{
	local string SN;
	local DeusExLevelInfo info;

	Super.PreTravel();

	player.PutInHand(None);
	conPlay.SetInHand(None);

	info =  player.GetLevelInfo();
	SN = info.NextMapScreen;
	player.SetLoadScr(SN);
	
	flags.DeleteFlag('PlayerInCutscene', FLAG_Bool);
}

defaultproperties
{
     checkTime=0.500000
     localURL="NOTHING"
}
