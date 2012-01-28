//=============================================================================
// HUDBox
//=============================================================================
class HUDBox expands HUDBaseWindow;

var DeusExPlayer	player;


// ----------------------------------------------------------------------
// InitWindow()
//
// Initialize the Window
// ----------------------------------------------------------------------
event InitWindow()
{
	Super.InitWindow();

	Hide();

	player = DeusExPlayer(DeusExRootWindow(GetRootWindow()).parentPawn);

	SetSize(width, height);

	SetWindowAlignments(HALIGN_Full, VALIGN_Full);

	CreateBox();
}


// ----------------------------------------------------------------------
// CreateBox()
// ----------------------------------------------------------------------
function CreateBox()
{
	local Window   winLineTop;
	local Window   winLineBottom;
	local Window   winLineLeft;
	local Window   winLineRight;


	winLineTop = NewChild(Class'Window');
	winLineTop.SetWindowAlignments(HALIGN_Left, VALIGN_Top);
	winLineTop.SetSize(3000, 1);
	//winLineTop.SetPos(0, 0);
	winLineTop.SetBackground(Texture'BlackMaskTex');
	winLineTop.SetBackgroundStyle(DSTY_Normal);

	winLineBottom = NewChild(Class'Window');
	winLineTop.SetWindowAlignments(HALIGN_Left, VALIGN_Bottom);
	winLineBottom.SetSize(3000, 1);
	//winLineBottom.SetPos(0, 0);
	winLineBottom.SetBackground(Texture'BlackMaskTex');
	winLineBottom.SetBackgroundStyle(DSTY_Normal);

	winLineLeft = NewChild(Class'Window');
	winLineTop.SetWindowAlignments(HALIGN_Left, VALIGN_Top);
	winLineLeft.SetSize(1, 3000);
	//winLineLeft.SetPos(0, 1);
	winLineLeft.SetBackground(Texture'BlackMaskTex');
	winLineLeft.SetBackgroundStyle(DSTY_Normal);

	winLineRight = NewChild(Class'Window');
	winLineTop.SetWindowAlignments(HALIGN_Right, VALIGN_Top);
	winLineRight.SetSize(1, 3000);
	//winLineRight.SetPos(width - 1, 1);
	winLineRight.SetBackground(Texture'BlackMaskTex');
	winLineRight.SetBackgroundStyle(DSTY_Normal);
}

// ----------------------------------------------------------------------
// SetVisibility()
// ----------------------------------------------------------------------
function SetVisibility( bool bNewVisibility )
{
	Show( bNewVisibility );
}

defaultproperties
{
}
