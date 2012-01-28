//=============================================================================
// StaticWindow
//=============================================================================
class StaticDottedWindow expands Window;

var() Texture StaticTexture;

// ----------------------------------------------------------------------
// InitWindow()
// ----------------------------------------------------------------------
event InitWindow()
{
	Super.InitWindow();
	Hide();
}


// ----------------------------------------------------------------------
// DrawWindow()
// ----------------------------------------------------------------------
event DrawWindow(GC gc)
{	
	gc.SetStyle(DSTY_Modulated);
	gc.DrawPattern(0, 0, width, height, 0, 0, StaticTexture);
}

// ----------------------------------------------------------------------
// VisibilityChanged()
// ----------------------------------------------------------------------
event VisibilityChanged(bool bNewVisibility)
{
	bTickEnabled = (bNewVisibility);
}

defaultproperties
{
     StaticTexture=Texture'GameMedia.UI.VisorDotted'
}
