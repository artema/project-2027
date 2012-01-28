//=============================================================================
// PersonaPerkButtonWindow
//=============================================================================
class PersonaAgentButtonWindow extends PersonaBorderButtonWindow;

var string WinDesc, WinTitle;

var Bool     bSelected;

simulated function SetWinDesc(string str){WinDesc = str;}
simulated function string GetWinText(){return WinDesc;}

simulated function SetWinTitle(string str){WinTitle = str;}
simulated function string GetWinTitle(){return WinTitle;}

// ----------------------------------------------------------------------
// StyleChanged()
// ----------------------------------------------------------------------

event StyleChanged()
{
	local ColorTheme theme;

	theme = player.ThemeManager.GetCurrentHUDColorTheme();

	bTranslucent  = player.GetHUDBackgroundTranslucency();

	colButtonFace = theme.GetColorFromName('HUDColor_ButtonFace');
	colText[0]    = theme.GetColorFromName('HUDColor_ButtonTextNormal');
	
	//colText[1]    = theme.GetColorFromName('HUDColor_ButtonTextFocus');
	//colText[2]    = colText[1];
	//colText[3]    = theme.GetColorFromName('HUDColor_ButtonTextDisabled');
	colText[1] = colText[0];
	colText[2] = colText[0];
	colText[3] = colText[0];
}

// ----------------------------------------------------------------------
// SelectButton()
// ----------------------------------------------------------------------

function SelectButton(Bool bNewSelected)
{
	// TODO: Replace with HUD sounds
	PlaySound(Sound'Menu_Press', 0.25); 

	bSelected = bNewSelected;
}

defaultproperties
{
     Left_Textures(0)=(Tex=Texture'DeusExUI.UserInterface.PersonaActionButtonNormal_Left',Width=4)
     Left_Textures(1)=(Tex=Texture'DeusExUI.UserInterface.PersonaActionButtonPressed_Left',Width=4)
     Right_Textures(0)=(Tex=Texture'DeusExUI.UserInterface.PersonaActionButtonNormal_Right',Width=8)
     Right_Textures(1)=(Tex=Texture'DeusExUI.UserInterface.PersonaActionButtonPressed_Right',Width=8)
     Center_Textures(0)=(Tex=Texture'DeusExUI.UserInterface.PersonaActionButtonNormal_Center',Width=2)
     Center_Textures(1)=(Tex=Texture'DeusExUI.UserInterface.PersonaActionButtonPressed_Center',Width=2)
     buttonHeight=16
     minimumButtonWidth=20
     bUseTextOffset=False
}
