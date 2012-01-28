//=============================================================================
// ������������ �������������. �������� Ded'�� ��� ���� 2027
// VSync. Copyright (C) 2004 Ded
//=============================================================================
class GameMenuChoice_VSync extends MenuChoice_OnOff;

// ----------------------------------------------------------------------
// LoadSetting()
// ----------------------------------------------------------------------

function LoadSetting()
{
	local String detailString;
	local int enumIndex;
	local int detailChoice;

	if(player.ConsoleCommand("get ini:Engine.Engine.GameRenderDevice Description") != "Direct3D"){
		btnAction.SetButtonText(actionText $ " (" $ OnlyThatRendering $ " OpenGL" $ ")");
		btnAction.SetSensitivity(False);
		SetSensitivity(False);
	}

	detailString = player.ConsoleCommand("get " $ configSetting);
	detailChoice = 0;

	if(detailString == FalseTrue[1])
		SetValue(1);
	else
		SetValue(0);
}

// ----------------------------------------------------------------------
// SaveSetting()
// ----------------------------------------------------------------------

function SaveSetting()
{
	if(player.ConsoleCommand("get ini:Engine.Engine.GameRenderDevice Description") == "Direct3D")
	{
		player.ConsoleCommand("set " $ configSetting $ " " $ FalseTrue[GetValue()]);
		player.ConsoleCommand("set ini:Engine.Engine.GameRenderDevice UseTripleBuffering " $ FalseTrue[GetValue()]);
	}
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     defaultValue=1
     defaultInfoWidth=98
     configSetting="ini:Engine.Engine.GameRenderDevice UseVSync"
}
