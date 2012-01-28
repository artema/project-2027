//=============================================================================
// ���� "���������". �������� Ded'�� ��� ���� 2027
// "Other options" menu. Copyright (C) 2003 Ded
//=============================================================================
class GameMenuSettings expands MenuUIMenuWindow;

defaultproperties
{
     buttonXPos=7
     buttonWidth=282
     buttonDefaults(0)=(Y=13,Action=MA_MenuScreen,Invoke=Class'Game.GameMenuScreenCustomizeKeys')
     buttonDefaults(1)=(Y=49,Action=MA_MenuScreen,Invoke=Class'Game.GameMenuScreenDisplay')
     buttonDefaults(2)=(Y=85,Action=MA_MenuScreen,Invoke=Class'Game.GameMenuScreenSound')
     buttonDefaults(3)=(Y=158,Action=MA_Previous)
     ClientWidth=294
     ClientHeight=308
     clientTextures(0)=Texture'GameMedia.UI.GameMenuOptionsBackground_1'
     clientTextures(1)=Texture'GameMedia.UserInterface.GameMenuOptionsBackground_2'
     textureCols=2
}
