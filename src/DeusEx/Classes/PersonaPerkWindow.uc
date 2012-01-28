//=============================================================================
// PersonaPerkWindow
//=============================================================================
class PersonaPerkWindow extends PersonaBaseWindow;


var() texture bgtex;
var() int winwidth,winheight;


event DrawWindow(GC gc)
{	
	DrawBackground(gc);

	// Don't call the DrawBorder routines if 
	// they are disabled
	if (bDrawBorder)
		DrawBorder(gc);

	// Draw the textures
	if (player.GetHUDBackgroundTranslucency())
		gc.SetStyle(DSTY_Translucent);
	else
		gc.SetStyle(DSTY_Masked);

	gc.SetTileColor(colBackground);

	gc.DrawTexture(0, 0, winwidth, winheight, 0, 0, bgtex);
}

simulated function setbg(Texture tex)
{
	bgtex = tex;
}
simulated function setwinsize(int w, int h)
{
	winwidth = w;
	winheight = h;
}

defaultproperties
{
}
