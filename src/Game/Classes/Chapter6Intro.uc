class Chapter6Intro expands CutSceneScript;

var float PreTimer;

// ----------------------------------------------------------------------
// FirstFrame()
// 
// Stuff to check at first frame
// ----------------------------------------------------------------------
function FirstFrame()
{
	Super.FirstFrame();

	   PreTimer = Level.TimeSeconds;
}

// ----------------------------------------------------------------------
// Timer()
//
// Main state machine for the mission
// ----------------------------------------------------------------------

function Timer()
{
	local DanielDouble DD;

	Super.Timer();

	if (Level.TimeSeconds - PreTimer >= 8.0)
        {
		foreach AllActors(class'DanielDouble', DD)
			break;

			player.StartConversationByName('Chapter6Intro', DD, False, True);
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
