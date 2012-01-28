//=============================================================================
// PersonaLevelIconWindow
//=============================================================================

class PersonaLevelIconWindow extends PersonaBaseWindow;

var int     currentLevel;
var int     maxLevel;
var Texture texLevel;
var Bool    bSelected;

var int iconSizeX;
var int iconSizeY;

var Color colIconFree;

// ----------------------------------------------------------------------
// InitWindow()
//
// Initialize the Window
// ----------------------------------------------------------------------

event InitWindow()
{
	Super.InitWindow();

	SetSize(23, 5);
}

// ----------------------------------------------------------------------
// SetSelected()
// ----------------------------------------------------------------------

function SetSelected(bool bNewSelected)
{
	bSelected = bNewSelected;
	StyleChanged();
}

// ----------------------------------------------------------------------
// DrawWindow()
// ----------------------------------------------------------------------

event DrawWindow(GC gc)
{	
	local int levelCount;

	gc.SetTileColor(colText);
	gc.SetStyle(DSTY_Masked);

	for(levelCount=0; levelCount<=currentLevel; levelCount++)
		gc.DrawTexture(levelCount * (iconSizeX + 1), 0, iconSizeX, iconSizeY, 0, 0, texLevel);
	
	if(currentLevel < maxLevel)
	{
		gc.SetTileColor(colIconFree);
		gc.SetStyle(DSTY_Masked);
		
		for(levelCount=levelCount;levelCount<=maxLevel; levelCount++)
			gc.DrawTexture(levelCount * (iconSizeX + 1), 0, iconSizeX, iconSizeY, 0, 0, texLevel);
	}
}

// ----------------------------------------------------------------------
// SetLevel()
// ----------------------------------------------------------------------

function SetLevel(int newLevel, optional int newMaxLevel)
{
	currentLevel = newLevel;
	maxLevel = newMaxLevel;
}

// ----------------------------------------------------------------------
// StyleChanged()
// ----------------------------------------------------------------------

event StyleChanged()
{
	local ColorTheme theme;

	theme = player.ThemeManager.GetCurrentHUDColorTheme();

	if (bSelected)
		colText = theme.GetColorFromName('HUDColor_ButtonTextFocus');
	else
		colText = theme.GetColorFromName('HUDColor_ButtonTextNormal');
		
	colIconFree = theme.GetColorFromName('HUDColor_ButtonTextDisabled');
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     texLevel=Texture'DeusExUI.UserInterface.PersonaSkillsChicklet'
     iconSizeX=5
     iconSizeY=5
}
