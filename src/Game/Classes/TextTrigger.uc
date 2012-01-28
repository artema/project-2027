//=============================================================================
// ��������� �������. �������� Ded'�� ��� ���� 2027
// Text trigger. Copyright (C) 2003 Ded
//=============================================================================
class TextTrigger expands Trigger;

var() name				textTag;
var string				TextPackage;
var localized String NoteAdded;
var transient HUDInformationDisplay infoWindow;
var transient TextWindow winText;
var Bool bSetText;
var String vaultString;
var DeusExPlayer aReader;
var Bool bFirstParagraph;

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
	if (infoWindow != None)
	{
		infoWindow.ClearTextWindows();
		infoWindow.Hide();
	}

	infoWindow = None;
	winText = None;
	aReader = None;
}

// ----------------------------------------------------------------------
// Tick()
// ----------------------------------------------------------------------
function Tick(float deltaTime)
{
	if ((aReader != None) && (infoWindow != None))
			DestroyWindow();
}

// ----------------------------------------------------------------------
// CreateInfoWindow()
// ----------------------------------------------------------------------
function CreateInfoWindow()
{
	local DeusExTextParser parser;
	local DeusExRootWindow rootWindow;
	local DeusExNote note;

	rootWindow = DeusExRootWindow(aReader.rootWindow);

	if ( textTag != '' )
	{
		parser = new(None) Class'DeusExTextParser';
								    
		if ((aReader != None) && (parser.OpenText(textTag,TextPackage)))
		{
			parser.SetPlayerName(aReader.TruePlayerName);

			infoWindow = rootWindow.hud.ShowInfoWindow();
			infoWindow.ClearTextWindows();

			vaultString = "";
			bFirstParagraph = True;

			while(parser.ProcessText())
				ProcessTag(parser);

			parser.CloseText();

				note = aReader.GetNote(textTag);

				if (note == None)
				{
					note = aReader.AddNote(vaultString,, True);
					note.SetTextTag(textTag);
				}

				vaultString = "";
		}
		CriticalDelete(parser);
	}
}

// ----------------------------------------------------------------------
// ProcessTag()
// ----------------------------------------------------------------------
function ProcessTag(DeusExTextParser parser)
{
	local String text;
	local byte tag;
	local Name fontName;
	local String textPart;

	tag  = parser.GetTag();

	if (winText == None)
	{
		winText = infoWindow.AddTextWindow();
		bSetText = True;
	}

	switch(tag)
	{
		case 0:				// TT_Text:
		case 9:				// TT_PlayerName:
		case 10:			// TT_PlayerFirstName:
			text = parser.GetText();

			if (bSetText)
				winText.SetText(text);
			else
				winText.AppendText(text);

			vaultString = vaultString $ text;
			bSetText = False;
			break;

		case 18:

			winText = infoWindow.AddTextWindow();

			if (!bFirstParagraph)
				vaultString = vaultString $ winText.CR();

			bFirstParagraph = False;

			bSetText = True;
			break;

		case 13:
			winText.SetTextAlignments(HALIGN_Left, VALIGN_Center);
			break;

		case 14:
			winText.SetTextAlignments(HALIGN_Right, VALIGN_Center);
			break;

		case 12:
			winText.SetTextAlignments(HALIGN_Center, VALIGN_Center);
			break;

		case 26:
			break;

		case 15:
		case 16:
		case 17:
			winText.SetTextColor(parser.GetColor());
			break;
	}
}

function Trigger(Actor Other, Pawn Instigator)
{
	local DeusExPlayer player;

	Super.Trigger(Other, Instigator);

	player = DeusExPlayer(Instigator);

	if (player != None)
	{
		if (infoWindow == None)
		{
			aReader = player;
			CreateInfoWindow();
		}
		else
		{
			DestroyWindow();
		}
	}

	player.ClientMessage(NoteAdded);
}

defaultproperties
{
     bTriggerOnceOnly=True
     TextPackage="GameText"
}
