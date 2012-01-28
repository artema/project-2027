//===========================================================
// HUD - Статус. Сделанно Ded'ом для мода 2027
// HUD - Status display. Copyright (C) 2003 Ded
//=========================================================== 
class HUDStatsDisplay expands HUDBaseWindow; 

#exec OBJ LOAD FILE=GameUI

var DeusExPlayer    player;
var Window	    winPulse1;
var int             drawPos;
var int             wrapPos;

var(Textures) texture texBackground;
var(Textures) texture texBorder;
var(Textures) texture PulseTexture;

var ProgressBarWindow winBloodBar;

var float	BloodBarPercent;

// ----------------------------------------------------------------------
// InitWindow()
// ----------------------------------------------------------------------
event InitWindow()
{
	Super.InitWindow();

	Hide();

	player = DeusExPlayer(DeusExRootWindow(GetRootWindow()).parentPawn);

	SetSize(84, 75);

	winBloodBar = CreateProgressBar(13, 42);

	CreatePulseWindow();
}

// ----------------------------------------------------------------------
// CreatePulseWindow()
// ----------------------------------------------------------------------
function CreatePulseWindow()
{
	local Window winPulseClip;

	winPulseClip = NewChild(Class'Window');
	winPulseClip.SetSize(53, 25);
	winPulseClip.SetPos(12, 11);

	winPulse1 = CreatePulseTickWindow(winPulseClip);

}

// ----------------------------------------------------------------------
// CreatePulseTickWindow()
// ----------------------------------------------------------------------
function Window CreatePulseTickWindow(Window winParent)
{
	local Window winPulse;

	winPulse = winParent.NewChild(Class'Window');
	winPulse.SetPos(0, 0);
	winPulse.SetSize(53, 25);
	winPulse.SetBackground(PulseTexture);
	winPulse.SetBackgroundStyle(DSTY_Masked);

	return winPulse;
}

// ----------------------------------------------------------------------
// CreateProgressBar()
// ----------------------------------------------------------------------
function ProgressBarWindow CreateProgressBar(int posX, int posY)
{
	local ProgressBarWindow winProgress;

	winProgress = ProgressBarWindow(NewChild(Class'ProgressBarWindow'));
	winProgress.UseScaledColor(True);
	winProgress.SetSize(55, 3);
	winProgress.SetPos(posX, posY);
	winProgress.SetValues(0, 100);
	winProgress.SetCurrentValue(100);
	winProgress.SetVertical(False);

	return winProgress;
}

// ----------------------------------------------------------------------
// Tick()
// ----------------------------------------------------------------------
event Tick(float deltaTime)
{
        UpdateHackBar();
}

// ----------------------------------------------------------------------
// UpdateHackBar()
// ----------------------------------------------------------------------
event UpdateHackBar()
{
}

// ----------------------------------------------------------------------
// VisibilityChanged()
// ----------------------------------------------------------------------
event VisibilityChanged(bool bNewVisibility)
{
	bTickEnabled = bNewVisibility;
}

// ----------------------------------------------------------------------
// DrawBackground()
// ----------------------------------------------------------------------
function DrawBackground(GC gc)
{
	gc.SetStyle(backgroundDrawStyle);
	gc.SetTileColor(colBackground);
	gc.DrawTexture(10, 10, 60, 54, 0, 0, texBackground);
}

// ----------------------------------------------------------------------
// DrawBorder()
// ----------------------------------------------------------------------
function DrawBorder(GC gc)
{
	if (bDrawBorder)
	{
		gc.SetStyle(borderDrawStyle);
		gc.SetTileColor(colBorder);
		gc.DrawTexture(0, 0, 84, 65, 0, 0, texBorder);
	}
}

// ----------------------------------------------------------------------
// SetVisibility()
// ----------------------------------------------------------------------
function SetVisibility( bool bNewVisibility )
{
	Show( bNewVisibility );

	bTickEnabled = bNewVisibility;
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     texBackground=Texture'GameUI.HUD.StatusBackgr'
     texBorder=Texture'GameUI.HUD.StatusBorder'
     PulseTexture=Texture'GameUI.pulse.pulse_A00'
     PulseTexture=Texture'BlackMaskTex'
}
