//=============================================================================
// Crosshair.
//=============================================================================
class Crosshair extends Window;

var bool bIsReading;

// ----------------------------------------------------------------------
// InitWindow()
// ----------------------------------------------------------------------

event InitWindow()
{
	local Color col;

	Super.InitWindow();

	SetBackgroundStyle(DSTY_Masked);
	SetBackground(Texture'CrossSquare');
	col.R = 255;
	col.G = 255;
	col.B = 255;
	//SetCrosshairColor(col);
	SetTileColor(col);
}

// ----------------------------------------------------------------------
// SetCrosshair()
// ----------------------------------------------------------------------

function SetReadingCrosshair( bool bReading )
{
	bIsReading = bReading;
}

function SetCrosshair( bool bShow )
{
	Show(bShow && !bIsReading);
}

// ----------------------------------------------------------------------
// SetCrosshairColor()
// ----------------------------------------------------------------------

function SetCrosshairColor(color newColor)
{
	//SetTileColor(newColor);
}

defaultproperties
{
}
