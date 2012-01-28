//=============================================================================
// DeusExScopeView.
//=============================================================================
class DeusExScopeView expands Window;

var bool bActive;		// is this view actually active?

var DeusExPlayer player;
var Color colLines;
var Bool  bBinocs;
var Bool  bNoise;
var Bool  bViewVisible;
var Bool  bAlreadyVisible;
var int   desiredFOV;

var Float lineInterval;
var Float lastLine;
var int currentLinePosY;
var Bool bLinePauseDelay;
var Bool bLineVisible;
var Float linePauseDelay;

// ----------------------------------------------------------------------
// InitWindow()
//
// Initialize the Window
// ----------------------------------------------------------------------

event InitWindow()
{
	Super.InitWindow();
	
	// Get a pointer to the player
	player = DeusExPlayer(GetRootWindow().parentPawn);

	bTickEnabled = true;

	bLineVisible = (FRand() > 0.20);

	RandomizeStatic();

	StyleChanged();
}

// ----------------------------------------------------------------------
// RandomizeStatic()
// ----------------------------------------------------------------------

function RandomizeStatic()
{
	lineInterval    = (FRand() / 15);
	linePauseDelay  = (FRand() / 2) + 0.75;
	currentLinePosY = (Rand(256) - 6);
}

// ----------------------------------------------------------------------
// Tick()
// ----------------------------------------------------------------------

event Tick(float deltaSeconds)
{
	local Crosshair        cross;
	local DeusExRootWindow dxRoot;

	dxRoot = DeusExRootWindow(GetRootWindow());
	if (dxRoot != None)
	{
		cross = dxRoot.hud.cross;

		if (bActive)
			cross.SetCrosshair(false);
		else
			cross.SetCrosshair(player.bCrosshairVisible);
	}

	lastLine += deltaSeconds;

	if (bLinePauseDelay)
	{
		if (lastLine > linePauseDelay)
		{
			bLinePauseDelay = False;
			lastLine = 0.0;
		}
	}
	else
	{
		if (lastLine > LineInterval)
		{
			lastLine = 0.0;

			currentLinePosY += 1;

			if (currentLinePosY > 256)
			{
				currentLinePosY = -6;
				bLinePauseDelay = True;
			}
		}
	}
}

// ----------------------------------------------------------------------
// ActivateView()
// ----------------------------------------------------------------------

function ActivateView(int newFOV, bool bNewBinocs, bool bInstant, optional bool bNewNoise)
{
	desiredFOV = newFOV;

	bBinocs = bNewBinocs;
	bNoise = bNewNoise;

	if (player != None)
	{
		if (bInstant)
			player.SetFOVAngle(desiredFOV);
		else
			player.desiredFOV = desiredFOV;

		bViewVisible = True;
                bAlreadyVisible = True;
		Show();
	}
}

// ----------------------------------------------------------------------
// DeactivateView()
// ----------------------------------------------------------------------

function DeactivateView()
{
	if (player != None)
	{
		Player.DesiredFOV = Player.Default.DefaultFOV;
		bViewVisible = False;
                bAlreadyVisible = False;
		Hide();
	}
}

// ----------------------------------------------------------------------
// HideView()
// ----------------------------------------------------------------------

function HideView()
{
	if (bViewVisible)
	{
		Hide();
		Player.SetFOVAngle(Player.Default.DefaultFOV);
	}
}

// ----------------------------------------------------------------------
// ShowView()
// ----------------------------------------------------------------------

function ShowView()
{
	if (bViewVisible)
	{
		Player.SetFOVAngle(desiredFOV);
		Show();
	}
}

// ----------------------------------------------------------------------
// DrawWindow()
// ----------------------------------------------------------------------

event DrawWindow(GC gc)
{
	local float			fromX, toX;
	local float			fromY, toY;
	local float			scopeWidth, scopeHeight;

	Super.DrawWindow(gc);

	if (GetRootWindow().parentPawn != None)
	{
		if (player.IsInState('Dying'))
			return;
	}

	// Figure out where to put everything
	if (bBinocs)
		scopeWidth  = 512;
	else
		scopeWidth  = 512;

	if (bBinocs)
		scopeHeight = 256;
	else
		scopeHeight = 512;

	fromX = (width-scopeWidth)/2;
	fromY = (height-scopeHeight)/2;
	toX   = fromX + scopeWidth;
	toY   = fromY + scopeHeight;

	gc.SetTileColorRGB(0, 0, 0);
	gc.SetStyle(DSTY_Normal);

	if (bBinocs)
	{
	    if (bNoise)
	    {
			gc.SetStyle(DSTY_Modulated);
			gc.DrawPattern(fromX, fromY, 512, 256, 0, 0, Texture'GameMedia.UI.VisorLined');

			if (bLineVisible)
			{
				gc.SetStyle(DSTY_Modulated);
				gc.DrawPattern(fromX, currentLinePosY, 512, 6, 0, 0, Texture'StaticLine');
			}
	    }

		gc.SetStyle(DSTY_Modulated);
		gc.DrawTexture(fromX,       fromY, 256, scopeHeight, 0, 0, Texture'HUDBinocularView_1');
		gc.DrawTexture(fromX + 256, fromY, 256, scopeHeight, 0, 0, Texture'HUDBinocularView_2');

		gc.SetTileColor(colLines);
		gc.SetStyle(DSTY_Masked);
		gc.DrawTexture(fromX,       fromY, 256, scopeHeight, 0, 0, Texture'HUDBinocularCrosshair_1');
		gc.DrawTexture(fromX + 256, fromY, 256, scopeHeight, 0, 0, Texture'HUDBinocularCrosshair_2');
	}
	else
	{
		if ( Player.Level.NetMode == NM_Standalone )
		{
			gc.SetStyle(DSTY_Modulated);
			gc.DrawTexture(fromX, fromY, scopeWidth, scopeHeight, 0, 0, Texture'HUDScopeView');
			gc.SetTileColor(colLines);
			gc.SetStyle(DSTY_Masked);
			gc.DrawTexture(fromX + 128, fromY + 128, scopeWidth, scopeHeight, 0, 0, Texture'HUDScopeCrosshair');
		}
	}
	
	// Only block out screen real estate in single player
	if ( Player.Level.NetMode == NM_Standalone )	
	{
		gc.SetTileColorRGB(0, 0, 0);
		//gc.SetStyle(DSTY_Normal);
		gc.SetStyle(DSTY_Modulated);
		gc.DrawPattern(0, 0, width, fromY, 0, 0, Texture'HUDScopeView2');
		gc.DrawPattern(0, toY, width, fromY, 0, 0, Texture'HUDScopeView2');
		gc.DrawPattern(0, fromY, fromX, scopeHeight, 0, 0, Texture'HUDScopeView2');
		gc.DrawPattern(toX, fromY, fromX, scopeHeight, 0, 0, Texture'HUDScopeView2');
	}
}

// ----------------------------------------------------------------------
// StyleChanged()
// ----------------------------------------------------------------------

event StyleChanged()
{
	local ColorTheme theme;

	theme = player.ThemeManager.GetCurrentHUDColorTheme();

	colLines = theme.GetColorFromName('HUDColor_HeaderText');
}

// ----------------------------------------------------------------------
// VisibilityChanged()
// ----------------------------------------------------------------------

event VisibilityChanged(bool bNewVisibility)
{
	bTickEnabled = (bNewVisibility && bLineVisible);
}

defaultproperties
{
     lineInterval=0.020000
     currentLinePosY=-6
     bLineVisible=True
     linePauseDelay=1.000000
}
