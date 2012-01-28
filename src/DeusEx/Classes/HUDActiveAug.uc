//=============================================================================
// HUDActiveAug
//=============================================================================

class HUDActiveAug extends HUDActiveItemBase;

var Color colBlack;
var Color colAugActive;
var Color colAugInactive;

var int    hotKeyNum;
var String hotKeyString;

// ----------------------------------------------------------------------
// DrawHotKey()
// ----------------------------------------------------------------------

function DrawHotKey(GC gc)
{
	gc.SetAlignments(HALIGN_Right, VALIGN_Top);
	gc.SetFont(Font'DeusExUI.FontTiny');
	
	// Draw Dropshadow
	gc.SetTextColor(colBlack);
	gc.DrawText(7, 1, 25, 10, hotKeyString);//18.1.15.8

	// Draw Dropshadow
	gc.SetTextColor(colText);
	gc.DrawText(6, 0, 25, 10, hotKeyString);//17.0.15.8
}

// ----------------------------------------------------------------------
// SetObject()
//
// Had to write this because SetClientObject() is FINAL in Extension
// ----------------------------------------------------------------------

function SetObject(object newClientObject)
{
	if (newClientObject.IsA('Augmentation'))
	{
		// Get the function key and set the text
		SetKeyNum(Augmentation(newClientObject).GetHotKey());
		UpdateAugIconStatus();
	}
}

// ----------------------------------------------------------------------
// SetKeyNum()
// ----------------------------------------------------------------------

function SetKeyNum(int newNumber)
{
	// Get the function key and set the text
	hotKeyNum    = newNumber;
	hotKeyString = "F" $ String(hotKeyNum);
}

// ----------------------------------------------------------------------
// UpdateAugIconStatus()
// ----------------------------------------------------------------------

function UpdateAugIconStatus()
{
	local Augmentation aug;
	local ColorTheme theme;

	

	aug = Augmentation(GetClientObject());

	if (aug != None)
	{
		theme = player.ThemeManager.GetCurrentHUDColorTheme();

		if (aug.IsActive())
			colItemIcon = theme.GetColorFromName('HUDColor_ButtonTextNormal');
		else
			colItemIcon = theme.GetColorFromName('HUDColor_ButtonTextDisabled');
	}
}


// ----------------------------------------------------------------------
// StyleChanged()
// ----------------------------------------------------------------------

event StyleChanged()
{
	local ColorTheme theme;

	theme = player.ThemeManager.GetCurrentHUDColorTheme();

	coLBackground = theme.GetColorFromName('HUDColor_Background');
	colBorder     = theme.GetColorFromName('HUDColor_Borders');
	colText       = theme.GetColorFromName('HUDColor_NormalText');
	colHeaderText = theme.GetColorFromName('HUDColor_HeaderText');

	bDrawBorder            = player.GetHUDBordersVisible();

	if (player.GetHUDBorderTranslucency())
		borderDrawStyle = DSTY_Translucent;
	else
		borderDrawStyle = DSTY_Masked;

	if (player.GetHUDBackgroundTranslucency())
		backgroundDrawStyle = DSTY_Translucent;
	else
		backgroundDrawStyle = DSTY_Masked;

	colItemIcon = theme.GetColorFromName('HUDColor_ButtonTextDisabled');
	UpdateAugIconStatus();
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     colAugActive=(B=150)
     colAugInactive=(R=100,G=100,B=100)
     colItemIcon=(B=0)
}
