class HUDCarcassButton expands ButtonWindow;

var DeusExPlayer player;

var bool bBorderTranslucent;
var bool bBackgroundTranslucent;
var bool bDrawBorder;

var Color colBackground;
var Color colBorder;
var Color colHeaderText;
var Color colSensitive;
var Color colInsensitive;

var Window winIcon;

var int num;

var Texture carcassButtonTextures[2];

event InitWindow()
{
	Super.InitWindow();
	
	SetSize(50, 56);

	player = DeusExPlayer(GetRootWindow().parentPawn);

	StyleChanged();
	
	CreateIcon();
}

event DrawWindow(GC gc)
{		
	local HUDCarcassWindow parent;

	parent = HUDCarcassWindow(GetParent());

	gc.SetTileColor(colBackground);

	if (bBackgroundTranslucent)
		gc.SetStyle(DSTY_Translucent);
	else
		gc.SetStyle(DSTY_Masked);
	
	if (bButtonPressed)
		gc.DrawTexture(0, 0, width, height, 0, 0, carcassButtonTextures[1]);
	else
		gc.DrawTexture(0, 0, width, height, 0, 0, carcassButtonTextures[0]);

	if (bIsSensitive)
		gc.SetTextColor(colSensitive);
	else
		gc.SetTextColor(colInsensitive);

	gc.SetFont(Font'DeusExUI.FontTiny');
	gc.SetAlignments(HALIGN_Center, VALIGN_Top);
	gc.EnableTranslucentText(True);

	gc.DrawText(1, 42, 48, 11, parent.IndexToTitle(num));

	winIcon.SetBackground(parent.IndexToIcon(num));
}

function CreateIcon()
{
	winIcon = NewChild(Class'Window');
	winIcon.SetBackgroundStyle(DSTY_Masked);
	winIcon.SetPos(4, 4);
	winIcon.SetSize(42, 37);
}

event StyleChanged()
{
	local ColorTheme theme;

	theme = player.ThemeManager.GetCurrentHUDColorTheme();

	colBackground = theme.GetColorFromName('HUDColor_Background');

	bBorderTranslucent     = player.GetHUDBorderTranslucency();
	bBackgroundTranslucent = player.GetHUDBackgroundTranslucency();
	bDrawBorder            = player.GetHUDBordersVisible();
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     colSensitive=(R=255,G=255,B=255)
     colInsensitive=(R=64,G=64,B=64)
     carcassButtonTextures(0)=Texture'GameMedia.UI.HUDCarcassButton_Normal'
     carcassButtonTextures(1)=Texture'GameMedia.UI.HUDCarcassButton_Pressed'
}
