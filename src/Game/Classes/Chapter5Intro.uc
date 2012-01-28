class Chapter5Intro expands CutSceneScript;

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

	if (Level.TimeSeconds - PreTimer >= 9.0)
        {
		foreach AllActors(class'DanielDouble', DD, 'DanielDouble')
			break;

			player.StartConversationByName('Chapter5Intro', DD, False, True);
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
