//=============================================================================
// ����������� �������. �������� Ded'�� ��� ���� 2027
// DetailTextures. Copyright (C) 2004 Ded
//=============================================================================
class GameMenuChoice_HiResTextures extends MenuChoice_OnOff;

var() float LODMax, LODMin;

// ----------------------------------------------------------------------
// LoadSetting()
// ----------------------------------------------------------------------

function LoadSetting()
{
	local String detailString;
	local int enumIndex;
	local int detailChoice;
	local string desc;
	local float curval;

	desc = player.ConsoleCommand("get ini:Engine.Engine.GameRenderDevice Description");

	if(desc != "OpenGL" && desc != "Direct3D"){
		btnAction.SetButtonText(actionText $ " (" $ OnlyThatRendering $ " Direct3D" $ ")");
		btnAction.SetSensitivity(False);
		SetSensitivity(False);
	}

	detailString = player.ConsoleCommand("get " $ configSetting);
	detailChoice = 0;

	if(float(detailString) != 0)
		SetValue(1);
	else
		SetValue(0);
}

// ----------------------------------------------------------------------
// SaveSetting()
// ----------------------------------------------------------------------

function SaveSetting()
{
	local string desc;
	local float curval;

	desc = player.ConsoleCommand("get ini:Engine.Engine.GameRenderDevice Description");

	if(desc == "OpenGL" || desc == "Direct3D")
	{
		if(GetValue() == 0)
			player.ConsoleCommand("set " $ configSetting $ " " $ LODMin);
		else
			player.ConsoleCommand("set " $ configSetting $ " " $ LODMax);
	}
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     LODMax=-1.5
     LODMin=0.0
     defaultValue=1
     defaultInfoWidth=98
     configSetting="ini:Engine.Engine.GameRenderDevice LODBias"
}