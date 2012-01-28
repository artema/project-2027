//=============================================================================
// Ёкран загрузки. —делано Ded'ом дл€ мода 2027
// Downloading screen.  Copyright (C) 2003 Ded
//=============================================================================
class GameComputerScreenDownload extends HUDBaseWindow;

var PersonaHeaderTextWindow   winDownloadMessage;
var PersonaActionButtonWindow btnDownload;
var ProgressBarWindow         barDownloadProgress;

var NetworkTerminal           winTerm;
var Float                     DownloadTime;
var Float                     saveDownloadTime;
var Float                     DownloadingTime;
var Float                     saveDownloadingTime;
var Float                     blinkTimer;
var Bool                      bDownloading;
var Bool		      bDownloaded;

var Texture texBackground;
var Texture texBorder;

var localized String DownloadButtonLabel;
var localized String ReturnButtonLabel;
var localized String DownloadReadyLabel;
var localized String DownloadInitializingLabel;
var localized String DownloadSuccessfulLabel;

// ----------------------------------------------------------------------
// InitWindow()
//
// Initialize the Window
// ----------------------------------------------------------------------
event InitWindow()
{
	Super.InitWindow();

	SetSize(215, 112);

	CreateControls();

	SetDownloadMessage(DownloadReadyLabel);	
}

// ----------------------------------------------------------------------
// DestroyWindow()
//
// Destroys the Window
// ----------------------------------------------------------------------
event DestroyWindow()
{
	Super.DestroyWindow();
}

// ----------------------------------------------------------------------
// CreateControls()
// ----------------------------------------------------------------------
function CreateControls()
{
	CreateDownloadMessageWindow();
	CreateDownloadProgressBar();
	CreateDownloadButton();	
}

// ----------------------------------------------------------------------
// CreateDownloadMessageWindow()
// ----------------------------------------------------------------------
function CreateDownloadMessageWindow()
{
	winDownloadMessage = PersonaHeaderTextWindow(NewChild(Class'PersonaHeaderTextWindow'));
	winDownloadMessage.SetPos(22, 19);
	winDownloadMessage.SetSize(168, 47);
	winDownloadMessage.SetTextAlignments(HALIGN_Center, VALIGN_Center);
	winDownloadMessage.SetBackgroundStyle(DSTY_Modulated);
	winDownloadMessage.SetBackground(Texture'HackInfoBackground');
}

// ----------------------------------------------------------------------
// CreateDownloadProgressBar()
// ----------------------------------------------------------------------
function CreateDownloadProgressBar()
{
	barDownloadProgress = ProgressBarWindow(NewChild(Class'ProgressBarWindow'));
	barDownloadProgress.SetPos(22, 71);
	barDownloadProgress.SetSize(169, 12);
	barDownloadProgress.SetValues(0, 100);
	barDownloadProgress.SetVertical(False);
	barDownloadProgress.UseScaledColor(True);
	barDownloadProgress.SetDrawBackground(False);
	barDownloadProgress.SetCurrentValue(100);
}

// ----------------------------------------------------------------------
// CreateDownloadButton()
// ----------------------------------------------------------------------
function CreateDownloadButton()
{
	local PersonaButtonBarWindow winActionButtons;

	winActionButtons = PersonaButtonBarWindow(NewChild(Class'PersonaButtonBarWindow'));
	winActionButtons.SetPos(20, 86);
	winActionButtons.SetWidth(88);
	winActionButtons.FillAllSpace(False);

	btnDownload = PersonaActionButtonWindow(winActionButtons.NewChild(Class'PersonaActionButtonWindow'));
	btnDownload.SetButtonText(DownloadButtonLabel);
}

// ----------------------------------------------------------------------
// DrawBackground()
// ----------------------------------------------------------------------
function DrawBackground(GC gc)
{
	gc.SetStyle(backgroundDrawStyle);
	gc.SetTileColor(colBackground);
	gc.DrawTexture(
		backgroundPosX, backgroundPosY, 
		backgroundWidth, backgroundHeight, 
		0, 0, texBackground);
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
		gc.DrawTexture(0, 0, 221, 112, 0, 0, texBorder);
	}
}

// ----------------------------------------------------------------------
// SetNetworkTerminal()
// ----------------------------------------------------------------------
function SetNetworkTerminal(NetworkTerminal newTerm)
{
	winTerm = newTerm;
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
		case btnDownload:
			if (winTerm != None)
			{
//				if (bDownloaded)
//					winTerm.ComputerDownloaded();
//				else
					StartDownload();

				btnDownload.SetSensitivity(False);
			}
			break;

		default:
			bHandled = False;
			break;
	}

	if (bHandled)
		return True;
	else
		return Super.ButtonActivated(buttonPressed);
}

// ----------------------------------------------------------------------
// StartDownload()
// ----------------------------------------------------------------------
function StartDownload()
{
	bDownloading     = True;
	bTickEnabled = True;

   if (Player.Level.NetMode == NM_Standalone)	
      SetDownloadMessage(DownloadInitializingLabel);
}

// ----------------------------------------------------------------------
// FinishDownload()
// ----------------------------------------------------------------------
function FinishDownload()
{
	bDownloaded = True;

	SetDownloadMessage(DownloadSuccessfulLabel);

//	if (winTerm != None)
//		winTerm.ComputerDownloaded();
}

// ----------------------------------------------------------------------
// SetDownloadMessage()
// ----------------------------------------------------------------------
function SetDownloadMessage(String newDownloadMessage)
{
	if (newDownloadMessage == "")
		winDownloadMessage.Hide();
	else
		winDownloadMessage.Show();

	winDownloadMessage.SetText(newDownloadMessage);
}

// ----------------------------------------------------------------------
// SetDownloadTime()
// ----------------------------------------------------------------------
function SetDownloadTime(Float newDownloadTime)
{
	DownloadTime     = newDownloadTime + newDownloadTime;
	saveDownloadTime = DownloadTime;

	DownloadTime      = newDownloadTime;
	saveDownloadTime  = DownloadTime;
}

// ----------------------------------------------------------------------
// GetSaveDownloadTime()
// ----------------------------------------------------------------------
function Float GetSaveDownloadTime()
{
	return saveDownloadTime;
}

// ----------------------------------------------------------------------
// UpdateDownloadTime()
// ----------------------------------------------------------------------
function UpdateDownloadTime(Float newDownloadTime)
{
	DownloadTime = newDownloadTime;

	UpdateDownloadBar();
}

// ----------------------------------------------------------------------
// UpdateDownloadBar()
// ----------------------------------------------------------------------
function UpdateDownloadBar()
{
	local float percentRemaining;

	percentRemaining = (DownloadTime / saveDownloadTime) * 100;
	barDownloadProgress.SetCurrentValue(percentRemaining);
}

// ----------------------------------------------------------------------
// SetDownloadButtonToReturn()
// ----------------------------------------------------------------------
function SetDownloadButtonToReturn()
{
	btnDownload.SetSensitivity(True);
	btnDownload.SetButtonText(ReturnButtonLabel);
}

// ----------------------------------------------------------------------
// Tick()
// ----------------------------------------------------------------------
function Tick(float deltaTime)
{
	if (bDownloading)
	{
		DownloadTime     -= deltaTime;
		blinkTimer       -= deltaTime;

		if (blinkTimer < 0)
		{
			if (winDownloadMessage.GetText() == "")
			{
				blinkTimer = Default.blinkTimer;

            if (Player.Level.NetMode == NM_Standalone)	
               SetDownloadMessage(DownloadInitializingLabel);
            else
               SetDownloadMessage(DownloadInitializingLabel);
			}
			else
			{
				blinkTimer = Default.blinkTimer / 3;
				winDownloadMessage.SetText("");
			}
		}

		if (DownloadTime < 0)
		{
			bDownloading = False;
			FinishDownload();
		}	
	}
/*	
	if (bHackDetected)
	{
		detectionTime -= deltaTime;
		blinkTimer    -= deltaTime;

		// Update blinking text
		if (blinkTimer < 0)
		{
			if (winHackMessage.GetText() == "")
			{
				blinkTimer = Default.blinkTimer;
				winHackMessage.SetText(HackDetectedLabel);
			}
			else
			{
				blinkTimer = Default.blinkTimer / 3;
				winHackMessage.SetText("");
			}
		}

		if (detectionTime < 0)
		{
			if (winTerm != None)
			{
				bHackDetectedNotified = True;
				winTerm.HackDetected();
			}
		}
	}
	else
	{
		// manage detection
		detectionTime -= deltaTime;

		// Update the progress bar
		UpdateHackBar();

		if (detectionTime < 0)
		{
			detectionTime = 0;
			bTickEnabled = False;
			HackDetected();
		}
	}
*/

}

// ----------------------------------------------------------------------
// VirtualKeyPressed()
//
// Called when a key is pressed; provides a virtual key value
// ----------------------------------------------------------------------
event bool VirtualKeyPressed(EInputKey key, bool bRepeat)
{
	local bool bKeyHandled;
	bKeyHandled = True;

	switch( key ) 
	{	
		case IK_Escape:
			winTerm.ForceCloseScreen();	
			break;

		default:
			bKeyHandled = False;
	}

	if (bKeyHandled)
		return True;
	else
		return Super.VirtualKeyPressed(key, bRepeat);
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     blinkTimer=1.000000
     texBackground=Texture'Game.UI.ComputerDownloadBackground'
     texBorder=Texture'Game.UI.ComputerDownloadBorder'
     DownloadButtonLabel="|&Download"
     ReturnButtonLabel="|&Cancel"
     DownloadInitializingLabel="Initializing ICE Breaker..."
     DownloadSuccessfulLabel="ICE Breaker Hack Successful..."
     backgroundWidth=187
     backgroundHeight=94
     backgroundPosX=14
     backgroundPosY=13
}
