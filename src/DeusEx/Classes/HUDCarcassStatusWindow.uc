class HUDCarcassStatusWindow extends TextWindow;

var DeusExPlayer player;
var Font         fontText;
var Float        logDuration;
var Float        logTimer;

var() Color colRed;

// ----------------------------------------------------------------------
// InitWindow()
//
// Initialize the Window
// ----------------------------------------------------------------------

event InitWindow()
{
	Super.InitWindow();

	SetMaxLines(2);
	SetFont(fontText);
	SetWidth(202);
	SetTextMargins(2, 1);
	SetTextAlignments(HALIGN_Left, VALIGN_Top);

	// Get a pointer to the player
	player = DeusExPlayer(GetRootWindow().parentPawn);

	StyleChanged();
}

// ----------------------------------------------------------------------
// Tick()
// ----------------------------------------------------------------------

function Tick(float deltaTime)
{
	logTimer += deltaTime;
	
	if (logTimer > logDuration)
	{
		SetText("");
		bTickEnabled = False;
	}
}

// ----------------------------------------------------------------------
// StyleChanged()
// ----------------------------------------------------------------------

event StyleChanged()
{
	local ColorTheme theme;
	local Color colText;

	theme = player.ThemeManager.GetCurrentHUDColorTheme();

	// Title colors
	colText = theme.GetColorFromName('HUDColor_ListText');

	SetTextColor(colRed);
}

// ----------------------------------------------------------------------
// AddText()
// ----------------------------------------------------------------------

function AddText(String newText)
{
	SetText(newText);
	logTimer = 0.0;
	bTickEnabled = True;
}

// ----------------------------------------------------------------------
// ClearText()
// ----------------------------------------------------------------------

function ClearText()
{
	SetText("");
	bTickEnabled = False;
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
	 colRed=(R=255)
     fontText=Font'DeusExUI.FontTiny'
     logDuration=4.000000
}
