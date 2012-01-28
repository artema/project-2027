//=============================================================================
// ���� Quotes. ������� Ded'�� ��� ���� 2027
// Quotes Window. Copyright (C) 2003 Ded
//=============================================================================
class GameQuotesWindow expands CreditsScrollWindow;

var string textPackage;
var Texture EndQuotesLogo[6];
var Texture QuotesBannerTextures[6];
var bool    bClearStack;
var Window        LogoWindow;

// ----------------------------------------------------------------------
// CreateControls()
// ----------------------------------------------------------------------
function CreateControls()
{
	LogoWindow = NewChild(Class'Window');
	//LogoWindow.SetBackground(Texture'GameSigns.Quotes.Quotes_A000');

	Super.CreateControls();
}

// ----------------------------------------------------------------------
// DestroyWindow()
// ----------------------------------------------------------------------
event DestroyWindow()
{
	if (bLoadIntro)
	{
		player.Level.Game.SendPlayer(player, "dxonly");
	}
	Super.DestroyWindow();
}

// ----------------------------------------------------------------------
// SetClearStack()
// ----------------------------------------------------------------------
function SetClearStack(bool bNewClearStack)
{
	bClearStack = bNewClearStack;
}

// ----------------------------------------------------------------------
// FinishedScrolling()
// ----------------------------------------------------------------------
function FinishedScrolling()
{
	if (bClearStack)
		root.ClearWindowStack();
	else
		Super.FinishedScrolling();
}

// ----------------------------------------------------------------------
// ProcessText()
// ----------------------------------------------------------------------
function ProcessText()
{
	local DeusExTextParser parser;

	PrintPicture(QuotesBannerTextures, 2, 1, 505, 128);
	PrintLn();

	if (textName != '')
	{
		parser = new(None) Class'DeusExTextParser';

		if (parser.OpenText(textName,textPackage))
		{
			while(parser.ProcessText())
				ProcessTextTag(parser);

			parser.CloseText();
		}
		CriticalDelete(parser);
	}
	ProcessFinished();
}

// ----------------------------------------------------------------------
// ProcessFinished()
// ----------------------------------------------------------------------
function ProcessFinished()
{
	PrintLn();
	PrintPicture(EndQuotesLogo, 3, 1, 600, 214);
	Super.ProcessFinished();
}

// ----------------------------------------------------------------------
// ProcessTextTag()
// ----------------------------------------------------------------------
function ProcessTextTag(DeusExTextParser parser)
{
	local String text;
	local byte tag;
	local bool bTagHandled;

	bTagHandled = False;

	tag  = parser.GetTag();

	switch(tag)
	{
		case 0:				// TT_Text:
			text = parser.GetText();

			if (text == "")
			{
				PrintLn();
			}
			else
			{
				if (bBold)
				{
					bBold = False;
					PrintHeader(parser.GetText());
				}
				else
				{
					ProcessQuoteLine(parser.GetText());
				}
			}
			bTagHandled = True;
			break;
	}

	if (!bTagHandled)
		Super.ProcessTextTag(parser);
}

// ----------------------------------------------------------------------
// ProcessQuoteLine()
// ----------------------------------------------------------------------
function ProcessQuoteLine(String parseText)
{
	local string personText;
	local string quoteText;
	local int colonPos;

	// Find the colon
	colonPos = InStr(parseText, ":");

	if (colonPos == -1)
	{
		PrintText(parseText);
	}
	else
	{
		PrintAlignText(Left(parseText, colonPos + 1), Right(parseText, Len(parseText) - colonPos - 1));
	}
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

	if ( IsKeyDown( IK_Alt ) || IsKeyDown( IK_Shift ) )
		return False;

	switch( key ) 
	{	
		case IK_Escape:
			FinishedScrolling();
			break;

		default:
			bKeyHandled = False;
			break;
	}

	if (bKeyHandled)
		return bKeyHandled;
	else
		return Super.VirtualKeyPressed(key, bRepeat);
}

// ----------------------------------------------------------------------
// ConfigurationChanged()
// ----------------------------------------------------------------------

function ConfigurationChanged()
{
	local float qWidth, qHeight;

        super.ConfigurationChanged();

	if (LogoWindow != None)
	{
		LogoWindow.QueryPreferredSize(qWidth, qHeight);
		LogoWindow.ConfigureChild(0, height - qHeight*1.25, qWidth, qHeight);
		LogoWindow.Lower();
	}
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     QuotesBannerTextures(0)=Texture'DeusExUI.UserInterface.CreditsBanner_1'
     QuotesBannerTextures(1)=Texture'DeusExUI.UserInterface.CreditsBanner_2'
     EndQuotesLogo(0)=Texture'BlackMaskTex'
     EndQuotesLogo(1)=Texture'BlackMaskTex'
     EndQuotesLogo(2)=Texture'BlackMaskTex'
     ScrollMusicString="2027Quotes_Music.2027Quotes_Music"
     textPackage="GameText"
     textName=GameQuotes
     fontHeader=Font'DeusExUI.FontConversationBold'
     colHeader=(R=79,G=255,B=255)
     colText=(R=0,G=128,B=128)
}
