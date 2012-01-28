class Chapter4Intro expands CutSceneScript;

var float PreTimer;

// ----------------------------------------------------------------------
// FirstFrame()
// 
// Stuff to check at first frame
// ----------------------------------------------------------------------
function FirstFrame()
{
	local MilitaryHelicopter heli;

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
	local MilitaryHelicopter heli;

	Super.Timer();

	/*if (Level.TimeSeconds - PreTimer >= 9.0)
    {
		foreach AllActors(class'DanielDouble', DD)
			break;

		player.StartConversationByName('Chapter4Intro', DD, False, True);
    }*/

	if (flags.GetBool('C4Intro_UnCloackHeli') && !flags.GetBool('C4Intro_CloackOff'))
	{
		foreach AllActors(class'MilitaryHelicopter', heli, 'Helicopter1Self')
		{
			heli.GotoState('DeactivateCamo');
	                flags.SetBool('C4Intro_CloackOff', True,, 5);
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
