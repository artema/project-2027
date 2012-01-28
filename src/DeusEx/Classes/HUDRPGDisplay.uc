//=============================================================================
// HUDCompassDisplay
//=============================================================================
class HUDRPGDisplay expands HUDBaseWindow;

var DeusExPlayer		player;
var ProgressBarWindow winBar;

var Texture texBackground;
var Texture texBorder;
var Texture texIcon, texLevel;
var color BarColor;

var float	ExpPercent;

// ----------------------------------------------------------------------
// InitWindow()
// ----------------------------------------------------------------------

event InitWindow()
{
	Super.InitWindow();

	Hide();
	
	bTickEnabled = True;

	player = DeusExPlayer(DeusExRootWindow(GetRootWindow()).parentPawn);

	SetSize(73, 40);

	winBar = CreateProgressBar(16, 9);
}

// ----------------------------------------------------------------------
// CreateProgressBar()
// ----------------------------------------------------------------------
function ProgressBarWindow CreateProgressBar(int posX, int posY)
{
	local ProgressBarWindow winProgress;

	winProgress = ProgressBarWindow(NewChild(Class'ProgressBarWindow'));
	winProgress.UseScaledColor(True);
	winProgress.SetSize(33, 5);
	winProgress.SetPos(posX, posY);
	winProgress.SetValues(0, 100);
	winProgress.SetCurrentValue(0);
	winProgress.SetVertical(False);
	//winProgress.SetDrawBackground(False);
	winProgress.SetColors(BarColor, BarColor);

	return winProgress;
}

// ----------------------------------------------------------------------
// Tick()
//
// Update the Energy and Breath displays
// ----------------------------------------------------------------------
event Tick(float deltaSeconds)
{
	local int i, TotalPoints, Points;

	if(player.HeroLevel<player.MaxHeroLevel)
	{
		TotalPoints=0;
		for(i=0;i<player.HeroLevel;i++){
			TotalPoints += player.ExperienceLevel[i];
		}

		Points = player.ExperiencePoints - TotalPoints;
		ExpPercent = 100.0 * (float(Points) / float(player.ExperienceLevel[player.HeroLevel]));
	}
	else
		ExpPercent = 100;

	winBar.SetCurrentValue(ExpPercent);
}

// ----------------------------------------------------------------------
// DrawWindow()
// ----------------------------------------------------------------------
event DrawWindow(GC gc)
{
	local int level, i, move;

	Super.DrawWindow(gc);

	if (player != None) 
	{
		//Индикатор навыка
		if(player.UpgradePoints>0)
		{
			gc.SetStyle(DSTY_Normal);
			gc.SetTileColor(colText); //colHeaderText
			gc.DrawTexture(52, 8, 15, 14, 0, 0, texIcon);
		}


		//Индикатор уровня
		level = player.HeroLevel;
		if(level>1)
		{
			gc.SetStyle(DSTY_Normal);
			gc.SetTileColor(colText);

			for(i=2;i<=level&&i<=5;i++)
			{
				gc.DrawTexture(16 + (i-2)*7, 17, 4, 4, 0, 0, Texture'Solid');
			}

			if(level==6)
			{
				gc.SetTileColor(colText);
				gc.DrawTexture(44, 17, 5, 5, 0, 0, Texture'Solid');
			}
		}
	}
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
	gc.DrawTexture(11, 6, 60, 19, 0, 0, texBackground);
}

// ----------------------------------------------------------------------
// PostDrawBorder()
// ----------------------------------------------------------------------
function DrawBorder(GC gc)
{
	if (bDrawBorder)
	{
		gc.SetStyle(borderDrawStyle);
		gc.SetTileColor(colBorder);
		gc.DrawTexture(0, 0, 73, 40, 0, 0, texBorder);
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

defaultproperties
{
     texIcon=Texture'GameMedia.UI.RPG_Icon'
     texLevel=Texture'GameMedia.UI.RPG_LevelIcon'
     BarColor=(R=0,G=255,B=0)
     texBackground=Texture'GameMedia.UI.RPG_Background'
     texBorder=Texture'DeusExUI.UserInterface.HUDCompassBorder_1'
}
