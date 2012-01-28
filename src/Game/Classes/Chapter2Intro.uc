class Chapter2Intro expands CutSceneScript;

// ----------------------------------------------------------------------
// FirstFrame()
// 
// Stuff to check at first frame
// ----------------------------------------------------------------------
function FirstFrame()
{
	local Dispatcher disp;
	
	Super.FirstFrame();

	foreach AllActors(class'Dispatcher', disp, 'StartDispatcher')
		disp.Trigger(None, None);
}

// ----------------------------------------------------------------------
// Timer()
//
// Main state machine for the mission
// ----------------------------------------------------------------------

function Timer()
{
	Super.Timer();
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