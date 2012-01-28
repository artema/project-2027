//=============================================================================
// MenuChoice_Decals
//=============================================================================

class MenuChoice_Decals extends MenuChoice_OnOff;

// ----------------------------------------------------------------------
// LoadSetting()
// ----------------------------------------------------------------------

function LoadSetting()
{
	local String detailString;
	local int enumIndex;
	local int detailChoice;

	detailString = player.ConsoleCommand("get " $ configSetting);
	detailChoice = 0;

	for (enumIndex=0; enumIndex<arrayCount(FalseTrue); enumIndex++)
	{
		if (FalseTrue[enumIndex] == detailString)
		{
			detailChoice = enumIndex;
			break;
		}	
	}

	SetValue(detailChoice);
}

// ----------------------------------------------------------------------
// SaveSetting()
// ----------------------------------------------------------------------

function SaveSetting()
{
	player.ConsoleCommand("set " $ configSetting $ " " $ FalseTrue[GetValue()]);
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     defaultValue=1
     defaultInfoWidth=98
     helpText="Отключение деколей на слабых машинах может повысить быстродействие."
     actionText="Д|&еколи"
     configSetting="ini:Engine.Engine.ViewportManager Decals"
}
