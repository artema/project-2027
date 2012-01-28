//=============================================================================
// MenuChoice_LogTimeoutValue
//=============================================================================

class MenuChoice_LogTimeoutValue extends MenuUIChoiceSlider;

var localized String msgSecond;

// ----------------------------------------------------------------------
// LoadSetting()
// ----------------------------------------------------------------------

function LoadSetting()
{
	SetValue(player.GetLogTimeout());
}

// ----------------------------------------------------------------------
// SaveSetting()
// ----------------------------------------------------------------------

function SaveSetting()
{
	player.SetLogTimeout(GetValue());
}

// ----------------------------------------------------------------------
// SetEnumerators()
// ----------------------------------------------------------------------

function SetEnumerators()
{
	local float timeOut;
	local int enumIndex;

	enumIndex=0;
	for(timeOut=1.0; timeOut<=10; timeOut+=0.5)
	{
		SetEnumeration(enumIndex++, Left(String(timeOut), Instr(String(timeOut), ".") + 2) $ msgSecond);
	}
}

// ----------------------------------------------------------------------
// ResetToDefault()
// ----------------------------------------------------------------------

function ResetToDefault()
{
	SetValue(defaultValue);
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     msgSecond="с"
     numTicks=19
     startValue=1.000000
     defaultValue=3.000000
helpText="Установить время, в течении которого сообщения видны на экране."
actionText="|&Время показа сообщений"
}
