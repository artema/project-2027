//=============================================================================
// ���� Conspiracy. ������� Ded'�� ��� ���� 2027
// Conspiracy window. Copyright (C) 2003 Ded
//=============================================================================
class ConspiracyMenu expands ToolWindow;

var ToolButtonWindow btnLoadMap;
var ToolButtonWindow btnQuotes;
var ToolButtonWindow btnComments;
var ToolButtonWindow btnPlayMusic;
var ToolButtonWindow btnClose;  
var ToolButtonWindow btnEditFlags; 

// ----------------------------------------------------------------------
// InitWindow()
// ----------------------------------------------------------------------

event InitWindow()
{
	Super.InitWindow();
	
	SetSize(300, 360);
	
	SetTitle("Conspiracy");

	CreateControls();

	SetTitleBarVisibility(False);
	SetWindowDragging(True);
}

// ----------------------------------------------------------------------
// DrawWindow()
// ----------------------------------------------------------------------

event DrawWindow(GC gc)
{	
	gc.SetStyle(DSTY_Normal);
	gc.DrawTexture( 10, 10, 256, 93, 0, 0, Texture'Game.UI.BehindTheCurtain1');
	gc.DrawTexture(266, 10,  21, 93, 0, 0, Texture'Game.UI.BehindTheCurtain2');
}

// ----------------------------------------------------------------------
// CreateControls()
// 
// Controls must be created in container window
// ----------------------------------------------------------------------

function CreateControls()
{
	btnLoadMap   = CreateToolButton(20, 110, "|&Maps");
	btnEditFlags = CreateToolButton(20, 135, "|&Edit Flags");
	//btnQuotes    = CreateToolButton(20, 135, "|&Quotes");
    //btnComments = CreateToolButton(20, 160, "|&Comments");
	//btnPlayMusic = CreateToolButton(20, 185, "|&Music");
	btnClose     = CreateToolButton(20, 325, "|&Close");

	CreateToolLabel(110, 115, "Load a map");
	//CreateToolLabel(110, 140, "View Quotes");
	//CreateToolLabel(110, 165, "View level comments");
	//CreateToolLabel(110, 190, "Music Jukebox");
	CreateToolLabel(110, 330, "Return to the 2027");
}

// ----------------------------------------------------------------------
// ButtonActivated()
// ----------------------------------------------------------------------

function bool ButtonActivated( Window buttonPressed )
{
	local bool bHandled;
	local Window win;

	bHandled = True;

	switch( buttonPressed )
	{
		case btnLoadMap:
			root.PushWindow(Class'DeusEx.LoadMapWindow', True);
			break;

		case btnEditFlags:
			root.PushWindow(Class'FlagEditWindow', True);
			break;

		//case btnQuotes:
		//	root.PushWindow(Class'Game.GameQuotesWindow', True);
		//	break;

		//case btnComments:
		//	root.PushWindow(Class'Game.GameCommentsWindow', True);
		//	break;

		case btnPlayMusic:
			root.PushWindow(Class'Game.GamePlayMusicWindow', True);
			break;

		case btnClose:
			root.PopWindow();
			break;

		default:
			bHandled = False;
			break;
	}

	if ( !bHandled ) 
		bHandled = Super.ButtonActivated( buttonPressed );

	return bHandled;
}


// ----------------------------------------------------------------------
// BoxOptionSelected()
// ----------------------------------------------------------------------

event bool BoxOptionSelected(Window msgBoxWindow, int buttonNumber)
{
	root.PopWindow();
	return true;
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
}
