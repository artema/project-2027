class Chapter4Vladimir expands CutSceneScript;

var float PreTimer;

// ----------------------------------------------------------------------
// FirstFrame()
// 
// Stuff to check at first frame
// ----------------------------------------------------------------------
function FirstFrame()
{
	Super.FirstFrame();

	flags.SetBool('MS_C4VladimirPlayed', True,, 5);
	PreTimer = Level.TimeSeconds;
}

// ----------------------------------------------------------------------
// Timer()
//
// Main state machine for the mission
// ----------------------------------------------------------------------

function Timer()
{
	local VladimirGrigoryev VG;

	Super.Timer();

	if (Level.TimeSeconds - PreTimer >= 4.0)
    {
		foreach AllActors(class'VladimirGrigoryev', VG)
		{
			player.StartConversationByName('VladimirMeeting', VG, True, True);
			break;
		}
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
