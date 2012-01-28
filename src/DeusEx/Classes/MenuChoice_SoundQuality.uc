//=============================================================================
// MenuChoice_SoundQuality
//=============================================================================

class MenuChoice_SoundQuality extends MenuUIChoiceEnum;

var bool bMessageDisplayed;

var Localized String RestartTitle;
var Localized String RestartMessage;

// ----------------------------------------------------------------------
// LoadSetting()
// ----------------------------------------------------------------------

function LoadSetting()
{
	local String boolString;

	boolString = player.ConsoleCommand("get " $ configSetting);

	if (boolString == "True")
		SetValue(0);
	else
		SetValue(1);
}

// ----------------------------------------------------------------------
// SaveSetting()
// ----------------------------------------------------------------------

function SaveSetting()
{
	if (GetValue() == 0)
		player.ConsoleCommand("set " $ configSetting $ " True");
	else
		player.ConsoleCommand("set " $ configSetting $ " False");
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

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
RestartTitle=" ачество звука"
RestartMessage="„тобы изменени€ вступили в силу, необходимо перезапустить 2027."
helpText="16-битный звук, конечно, более высокого качества, но расходует в 2 раза больше пам€ти чем 8-битный."
actionText=" ачество |&звука"
enumText(0)="8-бит"
enumText(1)="16-бит"
     defaultValue=1
     defaultInfoWidth=83
     configSetting="ini:Engine.Engine.AudioDevice LowSoundQuality"
}
