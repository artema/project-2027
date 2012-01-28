class Chapter4Arrival expands CutSceneScript;

// ----------------------------------------------------------------------
// FirstFrame()
// 
// Stuff to check at first frame
// ----------------------------------------------------------------------
function FirstFrame()
{
	Super.FirstFrame();

	flags.SetBool('MS_StartArrival', True, True, 5);
}

// ----------------------------------------------------------------------
// Timer()
//
// Main state machine for the mission
// ----------------------------------------------------------------------

function Timer()
{
	local Dispatcher disp;

	Super.Timer();

		if (flags.GetBool('MS_StartArrival'))
		{
        	foreach AllActors(class'Dispatcher', disp, 'ArrivalPatcher')
				disp.Trigger(None, None);
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
