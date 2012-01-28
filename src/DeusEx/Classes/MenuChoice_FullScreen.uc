//=============================================================================
// MenuChoice_FullScreen
//=============================================================================

class MenuChoice_FullScreen extends MenuUIChoiceAction;

// ----------------------------------------------------------------------
// ButtonActivated()
//
// If the action button was pressed, cycle to the next available
// choice (if any)
// ----------------------------------------------------------------------

function bool ButtonActivated( Window buttonPressed )
{
	ToggleFullScreen();
	return True;
}

// ----------------------------------------------------------------------
// ToggleFullScreen()
// ----------------------------------------------------------------------

function ToggleFullScreen()
{
	player.ConsoleCommand("TOGGLEFULLSCREEN");
//	GetScreenResolutions();
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     Action=MA_Custom
helpText="Переключение между полноэкранным и оконным режимом."
actionText="Вкл/выкл полноэкранный режим"
}
