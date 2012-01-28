//=============================================================================
// InformationDevices.
//=============================================================================
class InformationDevices extends DeusExDecoration
	abstract;

var() name					textTag;
var string				TextPackage;
var() class<DataVaultImage>	imageClass;
var() class<DataVaultImage>	imageClass2;
var() class<DataVaultImage>	imageClass3;

//var transient HUDReadWindow infoWindow;
var transient HUDInformationDisplay infoWindow;

var transient TextWindow winText;				// Last text window we added
var Bool bSetText;
var() Bool bAddToVault;					// True if we need to add this text to the DataVault
var String vaultString;
var DeusExPlayer aReader;				// who is reading this?
var localized String msgNoText;
var Bool bFirstParagraph;
var localized String ImageLabel;
var localized String AddedToDatavaultLabel;

// ----------------------------------------------------------------------
// Destroyed()
//
// If the item is destroyed, make sure we also destroy the window
// if it happens to be visible!
// ----------------------------------------------------------------------

function Destroyed()
{
	DestroyWindow();

	Super.Destroyed();
}

// ----------------------------------------------------------------------
// DestroyWindow()
// ----------------------------------------------------------------------

function DestroyWindow()
{
	local DeusExPlayer player;
	local DeusExRootWindow root;

    player = DeusExPlayer(GetPlayerPawn());
	root = DeusExRootWindow(aReader.rootWindow);
    
	// restore the crosshairs and the other hud elements
	if (aReader != None)
	{
		DeusExRootWindow(aReader.rootWindow).hud.cross.SetReadingCrosshair(False);
		DeusExRootWindow(aReader.rootWindow).hud.frobDisplay.Show();
	}

	if (infoWindow != None)
	{
		infoWindow.ClearTextWindows();
		infoWindow.Hide();
		
		if (root != None)
   		{
   			root.ModalBackground(False);
   		}
	}

	infoWindow = None;
	winText = None;
	aReader = None;
}

// ----------------------------------------------------------------------
// Tick()
//
// Only display the window while the player is in front of the object
// ----------------------------------------------------------------------

function Tick(float deltaTime)
{
	// if the reader strays too far from the object, kill the text window
	if ((aReader != None) && (infoWindow != None))
		if (aReader.FrobTarget != Self)
			DestroyWindow();
}

// ----------------------------------------------------------------------
// Frob()
// ----------------------------------------------------------------------

function Frob(Actor Frobber, Inventory frobWith)
{
	local DeusExPlayer player;
	local DeusExRootWindow root;

	Super.Frob(Frobber, frobWith);

	player = DeusExPlayer(Frobber);
	root = DeusExRootWindow(player.rootWindow);

	if (player != None)
	{
		if (infoWindow == None)
		{
			aReader = player;
			CreateInfoWindow();

			// hide the crosshairs if there's text to read, otherwise display a message
			if (infoWindow != None)
			{
				if (root != None)
   				{
   					root.ModalBackground(True);
   				}
   				
				DeusExRootWindow(player.rootWindow).hud.cross.SetReadingCrosshair(True);
				DeusExRootWindow(player.rootWindow).hud.frobDisplay.Hide();
//DeusExRootWindow(player.rootWindow).MaskBackground(True);

				
			}
			else
				player.ClientMessage(msgNoText);
		}
		else
		{
			DestroyWindow();
		}
	}
}

function AddToVault(){
	aReader.AddNote(vaultString,, True);
}

// ----------------------------------------------------------------------
// CreateInfoWindow()
// ----------------------------------------------------------------------

function CreateInfoWindow()
{
	local DeusExTextParser parser;
	local DeusExRootWindow rootWindow;
	local DeusExNote note;
	local DataVaultImage image;
	local bool bImageAdded;

	rootWindow = DeusExRootWindow(aReader.rootWindow);


	// First check to see if we have a name
	if ( textTag != '' )
	{
		// Create the text parser
		parser = new(None) Class'DeusExTextParser';
								    
		// Attempt to find the text object
		if ((aReader != None) && (parser.OpenText(textTag,TextPackage)))
		{
			parser.SetPlayerName(aReader.TruePlayerName);
//infoWindow = HUDReadWindow(rootWindow.InvokeUIScreen(Class'HUDReadWindow', True));
			infoWindow = rootWindow.hud.ShowInfoWindow();
			infoWindow.AddTextWindow();

			vaultString = "";
			bFirstParagraph = True;

			while(parser.ProcessText())
				ProcessTag(parser);

			parser.CloseText();

			if (bAddToVault)
			{
				note = aReader.GetNote(textTag);

				if (note == None)
				{
					note = aReader.AddNote(vaultString,, True);
					note.SetTextTag(textTag);
				}

				vaultString = "";
			}
		}
		CriticalDelete(parser);
	}









	if ((imageClass != None) && (aReader != None))
	{
		image = Spawn(imageClass, aReader);
		if (image != None)  
		{
			image.GiveTo(aReader);
			image.SetBase(aReader);
			bImageAdded = aReader.AddImage(image);

			if (infoWindow == None)
			{
				infoWindow = rootWindow.hud.ShowInfoWindow();
				winText = infoWindow.AddTextWindow();
				winText.SetText(Sprintf(ImageLabel, image.imageDescription));
			}

			if (bImageAdded)
			{
				aReader.ClientMessage(Sprintf(AddedToDatavaultLabel, image.imageDescription));
			}
		}
	}

	if ((imageClass2 != None) && (aReader != None))
	{
		image = Spawn(imageClass2, aReader);
		if (image != None)  
		{
			image.GiveTo(aReader);
			image.SetBase(aReader);
			bImageAdded = aReader.AddImage(image);

			if (infoWindow == None)
			{
				infoWindow = rootWindow.hud.ShowInfoWindow();
				winText = infoWindow.AddTextWindow();
				winText.SetText(Sprintf(ImageLabel, image.imageDescription));
			}

			if (bImageAdded)
			{
				aReader.ClientMessage(Sprintf(AddedToDatavaultLabel, image.imageDescription));
			}
		}
	}

	if ((imageClass3 != None) && (aReader != None))
	{
		image = Spawn(imageClass3, aReader);
		if (image != None)  
		{
			image.GiveTo(aReader);
			image.SetBase(aReader);
			bImageAdded = aReader.AddImage(image);

			if (infoWindow == None)
			{
				infoWindow = rootWindow.hud.ShowInfoWindow();
				winText = infoWindow.AddTextWindow();
				winText.SetText(Sprintf(ImageLabel, image.imageDescription));
			}

			if (bImageAdded)
			{
				aReader.ClientMessage(Sprintf(AddedToDatavaultLabel, image.imageDescription));
			}
		}
	}
}

// ----------------------------------------------------------------------
// ProcessTag()
// ----------------------------------------------------------------------

function ProcessTag(DeusExTextParser parser)
{
	local String text;
//	local EDeusExTextTags tag;
	local byte tag;
	local Name fontName;
	local String textPart;

	tag  = parser.GetTag();

	// Make sure we have a text window to operate on.
	if (winText == None)
	{
		winText = infoWindow.AddTextWindow();
		bSetText = True;
	}

	switch(tag)
	{
		// If a winText window doesn't yet exist, create one.
		// Then add the text
		case 0:				// TT_Text:
		case 9:				// TT_PlayerName:
		case 10:			// TT_PlayerFirstName:
			text = parser.GetText();

			// Add the text
			if (bSetText)
				winText.SetText(text);
			else
				winText.AppendText(text);

			vaultString = vaultString $ text;
			bSetText = False;
			break;

		// Create a new text window
		case 18:			// TT_NewParagraph:
			// Create a new text window
			winText = infoWindow.AddTextWindow();

			// Only add a return if this is not the *first*
			// paragraph.
			if (!bFirstParagraph)
				vaultString = vaultString $ winText.CR();

			bFirstParagraph = False;

			bSetText = True;
			break;

		case 13:				// TT_LeftJustify:
			winText.SetTextAlignments(HALIGN_Left, VALIGN_Center);
			break;

		case 14:			// TT_RightJustify:
			winText.SetTextAlignments(HALIGN_Right, VALIGN_Center);
			break;

		case 12:				// TT_CenterText:
			winText.SetTextAlignments(HALIGN_Center, VALIGN_Center);
			break;

		case 26:			// TT_Font:
//			fontName = parser.GetName();
//			winText.SetFont(fontName);
			break;

		case 15:			// TT_DefaultColor:
		case 16:			// TT_TextColor:
		case 17:			// TT_RevertColor:
			winText.SetTextColor(parser.GetColor());
			break;
	}
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     TextPackage="GameText"
     msgNoText="��� ������ ����������� ��� ���������"
     ImageLabel="[�����������: %s]"
     AddedToDatavaultLabel="�������� ����������� - ��������� � ����� ������"
     FragType=Class'DeusEx.PaperFragment'
     bPushable=False
}
