//=============================================================================
// ������� ����. �������� Ded'�� ��� ���� 2027
// Main menu. Copyright (C) 2003 Ded
//=============================================================================
class GameMenuMain expands MenuUIMenuWindow;

var string strGameVersion;

// ----------------------------------------------------------------------
// InitWindow()
// ----------------------------------------------------------------------
event InitWindow()
{
	Super.InitWindow();

	UpdateButtonStatus();
	ShowVersionInfo();
}

// ----------------------------------------------------------------------
// UpdateButtonStatus()
// ----------------------------------------------------------------------
function UpdateButtonStatus()
{
	local DeusExLevelInfo info;

	info = player.GetLevelInfo();

	if ((info != None) && (info.MissionNumber > 0))
	{
		winButtons[0].SetSensitivity(False);
	}

	if (((info != None) && (info.MissionNumber < 0)) || ((player.IsInState('Dying')) || (player.IsInState('Paralyzed')) || (player.IsInState('Interpolating'))))
	{
           if (Player.Level.NetMode == NM_Standalone)
           {
              winButtons[1].SetSensitivity(False);
              winButtons[5].SetSensitivity(False);
           }
        }

        if ((info != None) && (info.bCutScene))
           if (Player.Level.NetMode == NM_Standalone)
           {
                winButtons[1].SetSensitivity(False);
           }

	if (player.dataLinkPlay != None)
		winButtons[1].SetSensitivity(False);
}

// ----------------------------------------------------------------------
// ShowVersionInfo()
// ----------------------------------------------------------------------
function ShowVersionInfo()
{
	local TextWindow version;

	version = TextWindow(NewChild(Class'TextWindow'));
	version.SetTextMargins(0, 0);
	version.SetWindowAlignments(HALIGN_Right, VALIGN_Bottom);
	version.SetTextColorRGB(255, 255, 255);
	version.SetTextAlignments(HALIGN_Center, VALIGN_Bottom);
	version.SetText(strGameVersion);
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
	 strGameVersion="1.2.1"
     buttonXPos=7
     buttonWidth=245
     buttonDefaults(0)=(Y=13,Invoke=Class'Game.GameSetDifficulty')
     buttonDefaults(1)=(Y=49,Action=MA_MenuScreen,Invoke=Class'DeusEx.MenuScreenSaveGame')
     buttonDefaults(2)=(Y=85,Action=MA_MenuScreen,Invoke=Class'DeusEx.MenuScreenLoadGame')
     buttonDefaults(3)=(Y=121,Invoke=Class'Game.GameMenuSettings')
     buttonDefaults(4)=(Y=157,Action=MA_Credits)
     buttonDefaults(5)=(Y=193,Action=MA_Previous)
     buttonDefaults(6)=(Y=251,Action=MA_Quit)
     ClientWidth=258
     ClientHeight=295
     verticalOffset=2
     clientTextures(0)=Texture'DeusExUI.UserInterface.MenuMainBackground_1'
     clientTextures(1)=Texture'DeusExUI.UserInterface.MenuMainBackground_2'
     clientTextures(2)=Texture'DeusExUI.UserInterface.MenuMainBackground_3'
     textureCols=2
}
