//=============================================================================
// PersonaPerkTextWindow
//=============================================================================

class PersonaPerkTextWindow extends PersonaNormalTextWindow;

var bool bSelected;
var() string WinDesc;

var int      borderWidth;
var int      borderHeight;

var Color colSelectionBorder;

var Texture texBorders[9];

// ----------------------------------------------------------------------
// SetSelected()
// ----------------------------------------------------------------------

function SetSelected(bool bNewSelected)
{
	bSelected = bNewSelected;
	StyleChanged();
}

simulated function SetWinDesc(string str)
{
	WinDesc = str;
}

simulated function string GetWinText()
{
	return WinDesc;
}

// ----------------------------------------------------------------------
// CreateControls()
// ----------------------------------------------------------------------
function CreateControls()
{
	SetBorderSize(32,32);

}

// ----------------------------------------------------------------------
// SetBorderSize()
// ----------------------------------------------------------------------

function SetBorderSize(int newWidth, int newHeight)
{
	borderWidth  = newWidth;
	borderHeight = newHeight;
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

// ----------------------------------------------------------------------
// StyleChanged()
// ----------------------------------------------------------------------

event StyleChanged()
{
	local ColorTheme theme;
	local Color colText;

	theme = player.ThemeManager.GetCurrentHUDColorTheme();

	// Title colors
	if (bSelected)
		colText = theme.GetColorFromName('HUDColor_ButtonTextFocus');
	else
		colText = theme.GetColorFromName('HUDColor_ButtonTextNormal');

	SetTextColor(colText);
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     texBorders(0)=Texture'DeusExUI.UserInterface.PersonaItemHighlight_TL'
     texBorders(1)=Texture'DeusExUI.UserInterface.PersonaItemHighlight_TR'
     texBorders(2)=Texture'DeusExUI.UserInterface.PersonaItemHighlight_BL'
     texBorders(3)=Texture'DeusExUI.UserInterface.PersonaItemHighlight_BR'
     texBorders(4)=Texture'DeusExUI.UserInterface.PersonaItemHighlight_Left'
     texBorders(5)=Texture'DeusExUI.UserInterface.PersonaItemHighlight_Right'
     texBorders(6)=Texture'DeusExUI.UserInterface.PersonaItemHighlight_Top'
     texBorders(7)=Texture'DeusExUI.UserInterface.PersonaItemHighlight_Bottom'
     texBorders(8)=Texture'DeusExUI.UserInterface.PersonaItemHighlight_Center'
     colSelectionBorder=(R=255,G=255,B=255)
}
