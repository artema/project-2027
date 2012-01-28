//=============================================================================
// Окно проигрывания музыки. Сделано Ded'ом для мода 2027
// Play music window. Copyright (C) 2003 Ded
//=============================================================================
class GamePlayMusicWindow expands ToolWindow;


var RadioBoxWindow      radSongType;
var Window              winSongType;
var ToolListWindow		lstSongs;
var ToolButtonWindow	btnPlay;    
var ToolButtonWindow	btnClose;  

var ToolRadioButtonWindow	btnAmbient;
var ToolRadioButtonWindow	btnAmbient2;
var ToolRadioButtonWindow	btnCombat;
var ToolRadioButtonWindow	btnConversation;
var ToolRadioButtonWindow	btnOutro;
var ToolRadioButtonWindow	btnDying;


var String songList[23];
var String songNames[23];

var int savedSongSection;

// ----------------------------------------------------------------------
// InitWindow()
// ----------------------------------------------------------------------
event InitWindow()
{
	Super.InitWindow();

	// Center this window	
	SetSize(370, 430);
	SetTitle("Play Song");

	// Create the controls
	CreateControls();
	PopulateSongsList();

	// Save current song playing
	savedSongSection = player.SongSection;
}

// ----------------------------------------------------------------------
// DestroyWindow()
// ----------------------------------------------------------------------

event DestroyWindow()
{
	// Shut down the music
	player.ClientSetMusic(player.Level.Song, savedSongSection, 255, MTRAN_FastFade);
}

// ----------------------------------------------------------------------
// CreateControls()
// ----------------------------------------------------------------------

function CreateControls()
{
	// Songslist box
	CreateSongsList();

	// Create a RadioBox window for the boolean radiobuttons
	radSongType = RadioBoxWindow(NewChild(Class'RadioBoxWindow'));
	radSongType.SetPos(280, 65);
	radSongType.SetSize(100, 130);
	winSongType = radSongType.NewChild(Class'Window');

	btnAmbient = ToolRadioButtonWindow(winSongType.NewChild(Class'ToolRadioButtonWindow'));
	btnAmbient.SetText("|&Ambient");
	btnAmbient.SetPos(0, 0);

	btnAmbient2 = ToolRadioButtonWindow(winSongType.NewChild(Class'ToolRadioButtonWindow'));
	btnAmbient2.SetText("|&Ambient2");
	btnAmbient2.SetPos(0, 20);

	btnCombat = ToolRadioButtonWindow(winSongType.NewChild(Class'ToolRadioButtonWindow'));
	btnCombat.SetText("Co|&mbat");
	btnCombat.SetPos(0, 40);

	btnConversation = ToolRadioButtonWindow(winSongType.NewChild(Class'ToolRadioButtonWindow'));
	btnConversation.SetText("Co|&nvo");
	btnConversation.SetPos(0, 60);

	btnOutro = ToolRadioButtonWindow(winSongType.NewChild(Class'ToolRadioButtonWindow'));
	btnOutro.SetText("|&Outro");
	btnOutro.SetPos(0, 80);

	btnDying = ToolRadioButtonWindow(winSongType.NewChild(Class'ToolRadioButtonWindow'));
	btnDying.SetText("|&Dying");
	btnDying.SetPos(0, 100);


	btnAmbient.SetToggle(True);

	// Buttons
	btnPlay  = CreateToolButton(280, 362, "Play |&Song");
	btnClose = CreateToolButton(280, 387, "|&Close");
}

// ----------------------------------------------------------------------
// CreateSongsList()
// ----------------------------------------------------------------------

function CreateSongsList()
{
	// Now create the List Window
	lstSongs = CreateToolList(15, 38, 255, 372);
	lstSongs.EnableMultiSelect(False);
	lstSongs.EnableAutoExpandColumns(True);
	lstSongs.SetColumns(2);
	lstSongs.HideColumn(1);
}

// ----------------------------------------------------------------------
// PopulateSongsList()
// ----------------------------------------------------------------------

function PopulateSongsList()
{
	local int songIndex;

	lstSongs.DeleteAllRows();

	for( songIndex=0; songIndex<arrayCount(songList); songIndex++)
		lstSongs.AddRow(songList[songIndex] $ ";" $ songNames[songIndex]);

	// Sort the maps by name
	lstSongs.Sort();

	EnableButtons();
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
		case btnPlay:
			PlaySong(lstSongs.GetSelectedRow());
			break;

		case btnClose:
			root.PopWindow();
			break;

		default:
			bHandled = False;
			break;
	}

	if ( !bHandled ) 
		bHandled = Super.ButtonActivated( buttonPressed );

	return bHandled;
}

// ----------------------------------------------------------------------
// ListSelectionChanged() 
//
// When the user clicks on an item in the list, update the buttons
// appropriately
// ----------------------------------------------------------------------

event bool ListSelectionChanged(window list, int numSelections, int focusRowId)
{
	EnableButtons();

	return true;
}

// ----------------------------------------------------------------------
// ListRowActivated()
// ----------------------------------------------------------------------

event bool ListRowActivated(window list, int rowId)
{
	PlaySong(rowID);
	return true;
}

// ----------------------------------------------------------------------
// PlaySong()
// ----------------------------------------------------------------------

function PlaySong(int rowID)
{
	local String songName;
	local Int songSection;

//   0 - Ambient 1
//   1 - Dying
//   2 - Ambient 2 (optional)
//   3 - Combat
//   4 - Conversation
//   5 - Outro

	if (btnAmbient.GetToggle())
		songSection = 0;
	else if (btnDying.GetToggle())
		songSection = 1;
	else if (btnAmbient2.GetToggle())
		songSection = 2;
	else if (btnCombat.GetToggle())
		songSection = 3;
	else if (btnConversation.GetToggle())
		songSection = 4;
	else if (btnOutro.GetToggle())
		songSection = 5;

	songName = lstSongs.GetField(rowID, 1);
	player.PlayMusic(songName, songSection);
}

// ----------------------------------------------------------------------
// EnableButtons()
//
// Checks the state of the list control and updates the pushbuttons
// appropriately
// ----------------------------------------------------------------------

function EnableButtons()
{
	btnPlay.SetSensitivity( lstSongs.GetNumSelectedRows() > 0 );
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     songList(0)="Main Theme"
     songList(1)="La Chavalier Noir"
     songList(2)="CIA HQ"
     songList(3)="Council"
     songList(4)="Credits"
     songList(5)="Chinese Dragons"
     songList(6)="Enclave"
     songList(7)="Epilogue"
     songList(8)="Illuminati hideout"
     songList(9)="Infiltration"
     songList(10)="Latin Quarter"
     songList(11)="Lucius DeBeers"
     songList(12)="Mt.Weather Bunker"
     songList(13)="North Labs"
     songList(14)="Pacific Ocean"
     songList(15)="Prologue"
     songList(16)="Quotes"
     songList(17)="Rage"
     songList(18)="Revolutionist"
     songList(19)="Thanatos"
     songList(20)="Vector"
     songList(21)="Washington"
     songList(22)="When Angels Cry"
     songNames(0)="2027Title_Music"
     songNames(1)="2027ChavalierNoir_Music"
     songNames(2)="2027CIA_Music"
     songNames(3)="2027Council_Music"
     songNames(4)="2027Credits_Music"
     songNames(5)="2027Dragons_Music"
     songNames(6)="2027Enclave_Music"
     songNames(7)="2027Epilogue_Music"
     songNames(8)="2027Illuminati_Music"
     songNames(9)="2027Infiltration_Music"
     songNames(10)="2027LatinQuarter_Music"
     songNames(11)="2027LuciusDeBeers_Music"
     songNames(12)="2027MtWeather_Music"
     songNames(13)="2027NorthLabs_Music"
     songNames(14)="2027Pacific_Music"
     songNames(15)="2027Prologue_Music"
     songNames(16)="2027Quotes_Music"
     songNames(17)="2027Rage_Music"
     songNames(18)="2027Revolutionist_Music"
     songNames(19)="2027Thanatos_Music"
     songNames(20)="2027Vector_Music"
     songNames(21)="2027Washington_Music"
     songNames(22)="2027Angels_Music"
}
