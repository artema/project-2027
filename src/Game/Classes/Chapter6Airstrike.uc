class Chapter6Airstrike expands CutSceneScript;

var float MainTimer;

// ----------------------------------------------------------------------
// FirstFrame()
// 
// Stuff to check at first frame
// ----------------------------------------------------------------------
function FirstFrame()
{
	local Dispatcher disp;

	Super.FirstFrame();
	   
        MainTimer = Level.TimeSeconds;
}

// ----------------------------------------------------------------------
// Timer()
//
// Main state machine for the mission
// ----------------------------------------------------------------------

function Timer()
{
	local DummyTarget DD;

	Super.Timer();

	if (Level.TimeSeconds - MainTimer >= 2.0)
        {
		foreach AllActors(class'DummyTarget', DD)
			break;

		player.StartConversationByName('Airstrike', DD, False, True);
        }

}

// ----------------------------------------------------------------------
// PreTravel()
// 
// Set flags upon exit of a certain map
// ----------------------------------------------------------------------

function PreTravel()
{
	Super.PreTravel();
}
// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
}
