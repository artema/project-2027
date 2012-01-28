//=============================================================================
// MenuChoice_Resurrection
//=============================================================================
class MenuChoice_Resurrection extends MenuChoice_OnOff;

var bool   bMessageDisplayed;
var Localized String RestartTitle;
var Localized String RestartMessage;

// ----------------------------------------------------------------------
// LoadSetting()
// ----------------------------------------------------------------------
function LoadSetting()
{
	SetValue(int(player.bNoResurrection));
}

// ----------------------------------------------------------------------
// SaveSetting()
// ----------------------------------------------------------------------

function SaveSetting()
{
	player.bNoResurrection = bool(GetValue());
	player.SaveConfig();
}

// ----------------------------------------------------------------------
// CycleNextValue()
// ----------------------------------------------------------------------

function CycleNextValue()
{
	Super.CycleNextValue();

	if (!bMessageDisplayed)
	{
		DeusExRootWindow(GetRootWindow()).MessageBox(RestartTitle, RestartMessage, 1, False, Self);
		bMessageDisplayed = True;
	}
}

// ----------------------------------------------------------------------
// CyclePreviousValue()
// ----------------------------------------------------------------------

function CyclePreviousValue()
{
	Super.CyclePreviousValue();

	if (!bMessageDisplayed)
	{
		DeusExRootWindow(GetRootWindow()).MessageBox(RestartTitle, RestartMessage, 1, False, Self);
		bMessageDisplayed = True;
	}
}

// ----------------------------------------------------------------------
// BoxOptionSelected()
// ----------------------------------------------------------------------

event bool BoxOptionSelected(Window msgBoxWindow, int buttonNumber)
{
	// Destroy the msgbox!  
	DeusExRootWindow(GetRootWindow()).PopWindow();

	return True;
}

function ResetToDefault()
{
	SetValue(int(player.bNoResurrection));
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     defaultValue=1
     defaultInfoWidth=98
}
