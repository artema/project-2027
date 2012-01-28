//=============================================================================
// ����������� �������. �������� Ded'�� ��� ���� 2027
// DetailTextures. Copyright (C) 2004 Ded
//=============================================================================
class GameMenuChoice_DetailTextures extends MenuChoice_OnOff;

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
//			break;
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
     configSetting="ini:Engine.Engine.GameRenderDevice DetailTextures"
}