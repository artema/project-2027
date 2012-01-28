//=============================================================================
// MenuChoice_WorldTextureDetail
//=============================================================================

class MenuChoice_WorldTextureDetail extends MenuChoice_LowMedHigh;

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

	for (enumIndex=0; enumIndex<arrayCount(enumText); enumIndex++)
	{
		if (englishEnumText[enumIndex] == detailString)
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
	player.ConsoleCommand("set " $ configSetting $ " " $ englishEnumText[GetValue()]);
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     defaultInfoWidth=98
helpText="Изменяет качество текстур окружающего мира."
actionText="|&Текстуры мира"
     configSetting="ini:Engine.Engine.ViewportManager TextureDetail"
}
