//=============================================================================
// CreditsWindow
//=============================================================================
class GameCreditsWindow extends CreditsWindow;

#exec obj load file="..\2027\Textures\GameSigns.utx" package=GameSigns

var string textPackage;
var Texture EndCreditsLogo[6];
var Window        LogoWindow;

// ----------------------------------------------------------------------
// CreateControls()
// ----------------------------------------------------------------------
function CreateControls()
{
	winScroll = TileWindow(NewChild(Class'TileWindow'));
	winScroll.SetWidth(maxTileWidth);
	winScroll.SetOrder(ORDER_Down);
	winScroll.SetChildAlignments(HALIGN_Center, VALIGN_Top);
	winScroll.SetMargins(0, 0);
	winScroll.SetMinorSpacing(0);
	winScroll.SetMajorSpacing(0);
	winScroll.MakeWidthsEqual(False);
	winScroll.MakeHeightsEqual(False);
	winScroll.SetPos(0, root.Height);
	winScroll.FillParent(False);

	// Create the two fading windows (top and bottom)

	winFadeTop = NewChild(Class'Window');
	winFadeTop.SetBackground(Texture'FadeTop');
	winFadeTop.SetBackgroundStyle(DSTY_Modulated);

	LogoWindow = NewChild(Class'Window');
	LogoWindow.SetBackground(Texture'GameSigns.Credits.Credits_A000');

	winFadeBottom = NewChild(Class'Window');
	winFadeBottom.SetBackground(Texture'FadeBottom');
	winFadeBottom.SetBackgroundStyle(DSTY_Modulated);
}

// ----------------------------------------------------------------------
// Tick()
// ----------------------------------------------------------------------

function Tick(float deltaTime)
{
	local int diff;

	if (bScrolling)
	{
		scrollSpeed -= deltaTime;

		diff = 0;
		while (scrollSpeed < 0.0)
		{
			scrollSpeed += currentScrollSpeed;
			diff++;
		}

		if (diff > 0)
		{
			winScroll.SetPos(winScroll.x, winScroll.y - diff);

			// Check to see if we've finished scrolling
			if ((winScroll.y + winScroll.height) < 0)
			{
				bScrolling = False;
				FinishedScrolling();
			}
		}
	}
}

// ----------------------------------------------------------------------
// ConfigurationChanged()
// ----------------------------------------------------------------------

function ConfigurationChanged()
{
	local float qWidth, qHeight;

	if (LogoWindow != None)
	{
		LogoWindow.QueryPreferredSize(qWidth, qHeight);
		LogoWindow.ConfigureChild(0, height - qHeight*1.25, qWidth, qHeight);
		LogoWindow.Lower();
	}

	if (winFadeTop != None)
	{
		winFadeTop.QueryPreferredSize(qWidth, qHeight);
		winFadeTop.ConfigureChild(0, 0, width, qHeight);
	}

	if (winFadeBottom != None)
	{
		winFadeBottom.QueryPreferredSize(qWidth, qHeight);
		winFadeBottom.ConfigureChild(0, height - qHeight, width, qHeight);
	}

	if (winScroll != None)
	{
		winScroll.QueryPreferredSize(qWidth, qHeight);
		winScroll.ConfigureChild((width / 2) - (qwidth / 2), winScroll.vMargin0, qWidth, qHeight);
	}
}

// ----------------------------------------------------------------------
// ProcessText()
// ----------------------------------------------------------------------
function ProcessText()
{
	local DeusExTextParser parser;

	//PrintPicture(CreditsBannerTextures, 2, 1, 505, 128);
	//PrintLn();

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
// Overridden to display the logo instead of the Ion Storm 
// developer's photo
// ----------------------------------------------------------------------

function ProcessFinished()
{
	PrintLn();
	//PrintPicture(EndCreditsLogo, 1, 1, 512, 256);
}

// ----------------------------------------------------------------------
// FinishedScrolling()
// ----------------------------------------------------------------------
function FinishedScrolling()
{
	/*if (player.bQuotesenabled)
	{
		player.PlaySound(Sound'CreditsEnd');
	}
	else
	{
		Super.FinishedScrolling();
	}*/
	
	Super.FinishedScrolling();
}

// ----------------------------------------------------------------------
// InvokeQuotesWindow()
// ----------------------------------------------------------------------
function InvokeQuotesWindow()
{
	/*local GameQuotesWindow winQuotes;

	if (player.bQuotesEnabled)
	{
		winQuotes = GameQuotesWindow(root.InvokeMenuScreen(Class'GameQuotesWindow'));
		winQuotes.SetLoadIntro(bLoadIntro);
		winQuotes.SetClearStack(True);
	}*/
}

// ----------------------------------------------------------------------
// EggFound()
// ----------------------------------------------------------------------
function EggFound(int eggIndex)
{
	/*PlayEggFoundSound();

	easterPhraseIndex  = eggIndex;
	bShowEasterPhrases = True;

	if (easterSearch == "QUOTES")
	{
		player.bQuotesEnabled = True;
		player.SaveConfig();
	}
	else if (easterSearch == "DANCEPARTY")
	{
		player.ConsoleCommand("OPEN 99_ENDGAME4");
	}
	else if (easterSearch == "THEREISNOSPOON")
	{
		player.Matrix();
	}
	else if (easterSearch == "HUTHUT")
	{
	}
	else if (easterSearch == "BIGHEAD")
	{
	}
	else if (easterSearch == "IAMWARREN")
	{
		player.IAmWarren();
	}

	easterSearch = "";*/
}

// ----------------------------------------------------------------------
// StartMusic()
// ----------------------------------------------------------------------

function StartMusic()
{
	local Music CreditsMusic;

	if (ScrollMusicString != "")
	{
		CreditsMusic = Music(DynamicLoadObject(ScrollMusicString, class'Music'));

		if (CreditsMusic != None)
		{
			savedSongSection = player.SongSection;
			player.ClientSetMusic(CreditsMusic, 0, 255, MTRAN_FastFade);
		}
	}
}

// ----------------------------------------------------------------------
// StopMusic()
// ----------------------------------------------------------------------

function StopMusic()
{/*
	// Shut down the music
	player.ClientSetMusic(player.Level.Song, savedSongSection, 255, MTRAN_FastFade);*/
}

defaultproperties
{
     EndCreditsLogo=Texture'GameSigns.Screens.LoadingScr'
     CreditsBannerTextures(0)=Texture'DeusExUI.UserInterface.CreditsBanner_1'
     CreditsBannerTextures(1)=Texture'DeusExUI.UserInterface.CreditsBanner_2'
     easterStrings(0)="QUOTES"
     easterStrings(1)="DANCEPARTY"
     easterStrings(2)="THEREISNOSPOON"
     easterStrings(3)="HUTHUT"
     easterStrings(4)="BIGHEAD"
     easterStrings(5)="IAMWARREN"
     easterStrings(6)="MOREFROGS"
     foundStrings(0)="QUOTES ENABLED!"
     foundStrings(1)="DANCE PARTY ENABLED!"
     foundStrings(2)="MAY TRICKS MODE ENABLED!"
     foundStrings(3)="HUT HUT HUT HUT HUT!"
     foundStrings(4)="SO YOU THINK YOU'RE SMART?"
     foundStrings(5)="GENERAL PROTECTION FAULT!"
     foundStrings(6)="I HAVE TEN FINGERS AND TEN TOES!"
     easterEggTimer=3.000000
     ScrollMusicString="2027Quotes_Music.2027Quotes_Music"
     textPackage="GameText"
     textName=GameCredits
     fontHeader=Font'DeusExUI.FontConversationBold'
     colHeader=(R=100,G=100,B=255)
     colText=(R=100,G=100,B=200)
}
