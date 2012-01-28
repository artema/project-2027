//=============================================================================
// MenuChoice_SampleRate
//=============================================================================

class MenuChoice_SampleRate extends MenuUIChoiceEnum;

var bool bMessageDisplayed;

var Localized String RestartTitle;
var Localized String RestartMessage;

// ----------------------------------------------------------------------
// LoadSetting()
// ----------------------------------------------------------------------

function LoadSetting()
{
	local int sampleRate;

	sampleRate = int(player.ConsoleCommand("get " $ configSetting));
	if ( sampleRate == 11025 ) 
		SetValue(0);
	else if ( sampleRate == 22050 ) 
		SetValue(1);
	else
		SetValue(2);
}

// ----------------------------------------------------------------------
// SaveSetting()
// ----------------------------------------------------------------------

function SaveSetting()
{
	player.ConsoleCommand("set " $ configSetting $ " " $ enumText[GetValue()] );
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
     defaultValue=44100
     defaultInfoWidth=83
helpText="Низкая частота воспроизведения звука занимает меньше процессорного времени, но так снижается его качество."
actionText="Частота звука"
configSetting="ini:Engine.Engine.AudioDevice OutputRate"
enumText(0)="11025 Гц"
enumText(1)="22050 Гц"
enumText(2)="44100 Гц"
RestartTitle="Качество звука"
RestartMessage="Это изменение вступит в силу после перезагрузки 2027."
}
