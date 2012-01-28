class Chapter5Titan expands CutSceneScript;

// ----------------------------------------------------------------------
// FirstFrame()
// 
// Stuff to check at first frame
// ----------------------------------------------------------------------
function FirstFrame()
{
	Super.FirstFrame();

	flags.SetBool('MS_C5TitanConvoPlayed', True,, 7);
	flags.SetBool('C5_TitanPlayed', True,, 7);
}

// ----------------------------------------------------------------------
// Timer()
//
// Main state machine for the mission
// ----------------------------------------------------------------------

function Timer()
{
	local DummyTarget TT;

	Super.Timer();

		foreach AllActors(class'DummyTarget', TT)
		{
			player.StartConversationByName('TitanConvo', TT, True, True);
			break;
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
