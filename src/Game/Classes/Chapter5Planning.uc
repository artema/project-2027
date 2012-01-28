class Chapter5Planning expands CutSceneScript;

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
	local VladimirGrigoryev VG;

	Super.Timer();

	if (Level.TimeSeconds - PreTimer >= 11.0)
        {
		foreach AllActors(class'VladimirGrigoryev', VG)
			break;

		if (VG != None)
		{
			player.StartConversationByName('VladimirPlanning', VG, True, True);
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
