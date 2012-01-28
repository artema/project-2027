//=============================================================================
// MenuChoice_Use3dHardware
//=============================================================================

class MenuChoice_Use3dHardware extends MenuChoice_OnOff;

var bool bMessageDisplayed;

var Localized String RestartTitle;
var Localized String RestartMessage;

// ----------------------------------------------------------------------
// LoadSetting()
// ----------------------------------------------------------------------

function LoadSetting()
{
	LoadSettingBool();
}

// ----------------------------------------------------------------------
// SaveSetting()
// ----------------------------------------------------------------------

function SaveSetting()
{
	SaveSettingBool();
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
helpText="Включение поддержки аппаратного 3D звука."
actionText="|&Аппаратный 3D звук"
configSetting="ini:Engine.Engine.AudioDevice Use3dHardware"
RestartTitle="3D звук"
RestartMessage="Чтобы изменения вступили в силу надо перезапустить 2027."
     defaultValue=1
     defaultInfoWidth=83
     configSetting="ini:Engine.Engine.AudioDevice Use3dHardware"
}
