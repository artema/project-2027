class ChapterEndgame expands CutSceneScript;

var float PreTimer;

var() float ShowQuoteTime;
var() float CutsceneLength;
var() localized string EndgameQuote[2];
var() Name ConversationName;

var bool bConvoStarted;

var bool bInCredits;
var bool bQuotePrinted;

var byte savedSoundVolume;

var HUDMissionStartTextDisplay quoteDisplay;

function FirstFrame()
{
	Super.FirstFrame();

	PreTimer = Level.TimeSeconds;
	
	if(Player != None)
	{
		savedSoundVolume = SoundVolume;
		SoundVolume = 0;
		Player.SetInstantSoundVolume(SoundVolume);
	}
}

function Timer()
{
	local ScriptedPawn pawn;
	
	Super.Timer();

	if (!bQuotePrinted && (Level.TimeSeconds - PreTimer >= ShowQuoteTime))
	{
		bQuotePrinted = True;
		PrintEndgameQuote();
	}

	if (!bInCredits && ((Level.TimeSeconds - PreTimer >= CutsceneLength) && flags.GetBool('C7_EndgamePlayed')))
    {
    	bInCredits = True;
		ShowCredits();
    }
    
    if (!bConvoStarted && Level.TimeSeconds - PreTimer >= 4.0)
    {
		foreach AllActors(class'ScriptedPawn', pawn, 'DanielDouble')
		{
			Player.StartConversationByName(ConversationName, pawn, True, True);
			bConvoStarted = True;
			break;
		}
    }
}

function PreTravel()
{
	Super.PreTravel();

	SoundVolume = savedSoundVolume;
	Player.SetInstantSoundVolume(SoundVolume);

	DeusExRootWindow(Player.rootWindow).ResetFlags();
	
	if (flags != None)
		flags.DeleteAllFlags();
}

function PrintEndgameQuote()
{
	local int i;
	local DeusExRootWindow root;

	root = DeusExRootWindow(Player.rootWindow);
	
	if (root != None)
	{
		quoteDisplay = HUDMissionStartTextDisplay(root.NewChild(Class'HUDMissionStartTextDisplay', True));
		
		if (quoteDisplay != None)
		{
			quoteDisplay.displayTime = 9000;
			quoteDisplay.SetWindowAlignments(HALIGN_Center, VALIGN_Center);

			quoteDisplay.AddMessage(EndgameQuote[0]);
			quoteDisplay.AddMessage(EndgameQuote[1]);

			quoteDisplay.StartMessage();
		}
	}
}

function ShowCredits()
{
	Level.Game.SendPlayer(Player, Player.GetLevelInfo().NextMapName);	
}

defaultproperties
{
	EndgameQuote(0)="NO"
    EndgameQuote(1)="QUOTE"
}
