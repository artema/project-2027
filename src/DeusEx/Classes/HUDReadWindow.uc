//=============================================================================
// Экран чтения. Сделанно Ded'ом для мода 2027
// Reading window. Copyright (C) 2006 Ded
//=============================================================================
class HUDReadWindow extends DeusExBaseWindow;

// ----------------------------------------------------------------------
// Local Variables
// ----------------------------------------------------------------------

// Tile window containing all the child TextWindows
var TileWindow winTile;
var MenuUIScrollAreaWindow winScroll;

var InformationDevices readOwner;

var MenuUIActionButtonWindow btnClose;
var MenuUIActionButtonWindow btnSave;

// Default Colors
var Color colBackground;
var Color colBorder;
var Color colHeaderText;

// Border and Background Translucency
var bool bBorderTranslucent;
var bool bBackgroundTranslucent;
var bool bDrawBorder;

var Font fontInfo;

var Texture texBackground;
var Texture texBorder;

var localized string ButtonCloseLabel;
var localized string ButtonSaveLabel;

// ----------------------------------------------------------------------
// InitWindow()
//
// Initialize the Window
// ----------------------------------------------------------------------

event InitWindow()
{
	Super.InitWindow();



	SetWindowAlignments(HALIGN_Center, VALIGN_Center);
	SetSize(800, 600);
	SetMouseFocusMode(MFocus_EnterLeave);

	winScroll = MenuUIScrollAreaWindow(NewChild(Class'MenuUIScrollAreaWindow'));
	winScroll.SetPos(10, 21);
	winScroll.SetSize(787, 538);

	winTile = TileWindow(winScroll.clipWindow.NewChild(Class'TileWindow'));
	winTile.SetOrder( ORDER_Down );
	winTile.SetChildAlignments( HALIGN_Left, VALIGN_Top );
	winTile.SetMargins(20, 0);
	winTile.SetMinorSpacing(0);
	winTile.MakeWidthsEqual(True);
	winTile.MakeHeightsEqual(False);
	bTickEnabled = True;

	btnSave = MenuUIActionButtonWindow(NewChild(Class'MenuUIActionButtonWindow'));
	btnSave.SetButtonText(ButtonSaveLabel);
	btnSave.SetPos(590, 562);
	btnSave.SetWidth(110);

	btnClose = MenuUIActionButtonWindow(NewChild(Class'MenuUIActionButtonWindow'));
	btnClose.SetButtonText(ButtonCloseLabel);
	btnClose.SetPos(710, 562);
	btnClose.SetWidth(65);

	bTickEnabled = True;

	StyleChanged();
}

// ----------------------------------------------------------------------
// ButtonActivated()
// ----------------------------------------------------------------------

function bool ButtonActivated( Window buttonPressed )
{
	local bool bHandled;

	bHandled = True;

	switch( buttonPressed )
	{
		case btnSave:
			SaveNote();
			break;

		case btnClose:
			CloseNote();
			break;

		default:
			bHandled = False;
			break;
	}

	if ( !bHandled )
		bHandled = Super.ButtonActivated(buttonPressed);

	return bHandled;
}

function CloseNote(){
	readOwner.infoWindow = None;
	root.PopWindow();
}

function SaveNote(){
	readOwner.AddToVault();
	readOwner.infoWindow = None;
	root.PopWindow();
}

// ----------------------------------------------------------------------
// ConfigurationChanged()
// ----------------------------------------------------------------------

function ConfigurationChanged()
{
	winTile.ConfigureChild(0, 0, 800, winTile.QueryPreferredHeight(800));
}


// ----------------------------------------------------------------------
// ChildRequestedReconfiguration()
// ----------------------------------------------------------------------

event bool ChildRequestedReconfiguration(window childWin)
{
	return False;
}

// ----------------------------------------------------------------------
// DestroyWindow()
//
// Destroys the Window
// ----------------------------------------------------------------------

event DestroyWindow()
{
	Super.DestroyWindow();

	readOwner.infoWindow = None;
}

// ----------------------------------------------------------------------
// DrawWindow()
// 
// DrawWindow event (called every frame)
// ----------------------------------------------------------------------

event DrawWindow(GC gc)
{
	// First draw the background then the border
	DrawBackground(gc);
	DrawBorder(gc);

	Super.DrawWindow(gc);
}


// ----------------------------------------------------------------------
// DrawBackground()
// ----------------------------------------------------------------------

function DrawBackground(GC gc)
{
	if (bBackgroundTranslucent)
		gc.SetStyle(DSTY_Translucent);
	else
		gc.SetStyle(DSTY_Masked);
	
	gc.SetTileColor(colBackground);

	gc.DrawTexture(0, 0, 512, 512, 0, 0, Texture'GameMedia.UI.ReadScreen_01');
	gc.DrawTexture(512, 0, 288, 512, 0, 0, Texture'GameMedia.UI.ReadScreen_02');
	gc.DrawTexture(0, 512, 512, 88, 0, 0, Texture'GameMedia.UI.ReadScreen_03');
	gc.DrawTexture(512, 512, 288, 88, 0, 0, Texture'GameMedia.UI.ReadScreen_04');
}

// ----------------------------------------------------------------------
// DrawBorder()
// ----------------------------------------------------------------------

function DrawBorder(GC gc)
{
	/*if (bDrawBorder)
	{
		if (bBorderTranslucent)
			gc.SetStyle(DSTY_Translucent);
		else
			gc.SetStyle(DSTY_Masked);
		
		gc.SetTileColor(colBorder);

		gc.DrawTexture(0, 0, width, height, 0, 0, texBorder);
	}*/
}


// ----------------------------------------------------------------------
// AddTextWindow()
//
// Adds a text window
// ----------------------------------------------------------------------

function TextWindow AddTextWindow()
{
	local TextWindow winText;

	// Create the Text window containing the message text
	winText = TextWindow(winTile.NewChild(Class'TextWindow'));
	winText.SetFont(fontInfo);
	winText.SetTextColor(colHeaderText);
	winText.SetWordWrap(True);
	winText.SetTextAlignments(HALIGN_Full, VALIGN_Top);	
	winText.SetTextMargins(0, 0);
	AskParentForReconfigure();

	return winText;
}





// ----------------------------------------------------------------------
// StyleChanged()
// ----------------------------------------------------------------------

event StyleChanged()
{
	local ColorTheme theme;

	theme = player.ThemeManager.GetCurrentHUDColorTheme();

	colBackground = theme.GetColorFromName('HUDColor_Background');
	colBorder     = theme.GetColorFromName('HUDColor_Borders');
	colHeaderText = theme.GetColorFromName('HUDColor_HeaderText');

	bBorderTranslucent     = player.GetHUDBorderTranslucency();
	bBackgroundTranslucent = player.GetHUDBackgroundTranslucency();
	bDrawBorder            = player.GetHUDBordersVisible();
}



// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     ButtonCloseLabel="Закрыть"
     ButtonSaveLabel="Сохранить в базу"
     fontInfo=Font'DeusExUI.FontConversation'
}