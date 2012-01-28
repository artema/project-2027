//=============================================================================
// Окно комментариев. Сделано Ded'ом для мода 2027
// Comments window. Copyright (C) 2003 Ded
//=============================================================================
class GameCommentsWindow expands ToolWindow;

var ToolButtonWindow	btnClose;
var string LevelComment;
var string LevelAuthor;
var string LevelBuild;

// ----------------------------------------------------------------------
// InitWindow()
// ----------------------------------------------------------------------
event InitWindow()
{
	Super.InitWindow();


	CreateControls();

	SetSize(370, 430);
	SetTitle("Comments");
}

// ----------------------------------------------------------------------
// CreateControls()
// ----------------------------------------------------------------------
function CreateControls()
{
	local DeusExLevelInfo info;

	info = player.GetLevelInfo();

        LevelComment = info.Comment;
        LevelAuthor = info.MapAuthor;
        LevelBuild = info.ConstructionTime;


	btnClose = CreateToolButton(280, 387, "|&Close");
	CreateToolLabel(20, 115, LevelComment);
	CreateToolLabel(20, 150, LevelAuthor);
	CreateToolLabel(20, 185, LevelBuild);
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

defaultproperties
{
}
