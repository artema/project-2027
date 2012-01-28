//=============================================================================
// MenuChoice_Decals
//=============================================================================
class MenuChoice_VSync extends MenuChoice_OnOff;

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
     helpText="Включение этой опции позволяет сделать смену кадров более плавной (работает только под Direct3D)."
     actionText="Ве|&ртикальная синхронизация"
     configSetting="ini:Engine.Engine.GameRenderDevice UseVSync"
}
