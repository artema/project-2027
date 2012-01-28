//=============================================================================
// ����� "�����. ������� Ded'�� ��� ���� 2027
// "Options" screen. Copyright (C) 2003 Ded
//=============================================================================
class GameMenuScreenOptions expands MenuUIScreenWindow;

// ----------------------------------------------------------------------
// SaveSettings()
// ----------------------------------------------------------------------
function SaveSettings()
{
	Super.SaveSettings();
	player.SaveConfig();
}

defaultproperties
{
     choices(0)=Class'DeusEx.MenuChoice_ObjectNames'
     choices(1)=Class'DeusEx.MenuChoice_WeaponAutoReload'
     choices(2)=Class'DeusEx.MenuChoice_GoreLevel'
     choices(3)=Class'DeusEx.MenuChoice_Subtitles'
     choices(4)=Class'DeusEx.MenuChoice_UIBackground'
     choices(5)=Class'DeusEx.MenuChoice_HUDAugDisplay'
     choices(6)=Class'DeusEx.MenuChoice_Resurrection'
     choices(7)=Class'DeusEx.MenuChoice_Weather'
     choices(8)=Class'DeusEx.MenuChoice_MaxLogLines'
     actionButtons(0)=(Align=HALIGN_Right,Action=AB_OK)
     ClientWidth=537
     ClientHeight=406
     clientTextures(0)=Texture'DeusExUI.UserInterface.MenuGameOptionsBackground_1'
     clientTextures(1)=Texture'DeusExUI.UserInterface.MenuGameOptionsBackground_2'
     clientTextures(2)=Texture'DeusExUI.UserInterface.MenuGameOptionsBackground_3'
     clientTextures(3)=Texture'DeusExUI.UserInterface.MenuGameOptionsBackground_4'
     clientTextures(4)=Texture'DeusExUI.UserInterface.MenuGameOptionsBackground_5'
     clientTextures(5)=Texture'DeusExUI.UserInterface.MenuGameOptionsBackground_6'
     helpPosY=354
}
