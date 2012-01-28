//=============================================================================
// Computers.
//=============================================================================
class Computers extends ElectronicDevices
	abstract;

enum EAccessLevel
{
	AL_Untrained,
	AL_Trained,
	AL_Advanced,
	AL_Master
};

struct sSpecialOptions
{
	var() localized string	Text;
	var() localized string	TriggerText;
	var() string			userName;
	var() name				TriggerEvent;
	var() name				UnTriggerEvent;
	var() bool				bTriggerOnceOnly;	
	var bool				bAlreadyTriggered;
	//var() EAccessLevel MinAccessLevel;
};

var() localized sSpecialOptions specialOptions[4];
var() EAccessLevel specialOptionsAccessLevel[4];

var class<NetworkTerminal> terminalType;
var NetworkTerminal termwindow;
var bool bOn;
var bool bAnimating;
var bool bLockedOut;				// true if this terminal is locked out
var float lockoutDelay;//()			// delay until locked out terminal can be used
var float lockoutTime;				// time when terminal was locked out
var float lastHackTime;				// last time the terminal was hacked
var DeusExPlayer curFrobber;     // player currently frobbing.
var localized String msgLockedOut;

// userlist information
struct sUserInfo
{
	var() string		userName;
	var() string		password;
	var() EAccessLevel	accessLevel;
};

var() sUserInfo userList[8];

var string TextPackage;

// NEW STUFF!!

/*enum EComputerNodes
{
	CN_UNATCO, 
	CN_VersaLife,
	CN_QueensTower,
	CN_USNavy,
	CN_MJ12Net,
	CN_PageIndustries,
	CN_Area51,
	CN_Everett,
	CN_NSF,
	CN_NYC,
	CN_China,
	CN_HKNet,
	CN_QuickStop,
	CN_LuckyMoney,
	CN_Illuminati
};

struct sNodeInfo
{
	var localized string nodeName;
	var localized string nodeDesc;
	var string nodeAddress;
	var Texture nodeTexture;
};*/

//var() EComputerNodes ComputerNode;
//var   localized sNodeInfo NodeInfo[20];

// alarm vars
var float lastAlarmTime;		// last time the alarm was sounded
var int alarmTimeout;			// how long before the alarm silences itself

var localized string CompInUseMsg;

function bool PlayerCanAccess(EAccessLevel level)
{
	local DeusExPlayer player;
	local float playerLevel;

	player = DeusExPlayer(GetPlayerPawn());
	
	if (player != None)
	{
		playerLevel = player.SkillSystem.GetSkillLevel(class'SkillElectronics');
		
		if(level == AL_Untrained)
			return true;
		else if(level == AL_Trained && playerLevel >= 1)
			return true;
		else if(level == AL_Advanced && playerLevel >= 2)
			return true;
		else if(level == AL_Master && playerLevel >= 3)
			return true;
		else
			return false;
	}
	
	return false;
}

// -----------------------------------------------------------------------
// PostBeginPlay
// -----------------------------------------------------------------------
function PostBeginPlay()
{
   Super.PostBeginPlay();
   curFrobber = None;
}

//
// Alarm functions for when you get caught hacking
//
function BeginAlarm()
{
	AmbientSound = Sound'Klaxon2';
	SoundVolume = 128;
	SoundRadius = 64;
	SoundPitch = 64;
	lastAlarmTime = Level.TimeSeconds;
	AIStartEvent('Alarm', EAITYPE_Audio, SoundVolume/255.0, 25*(SoundRadius+1));

	// make sure we can't go into stasis while we're alarming
	bStasis = False;
}

function EndAlarm()
{
	AmbientSound = Default.AmbientSound;
	SoundVolume = Default.SoundVolume;
	SoundRadius = Default.SoundRadius;
	SoundPitch = Default.SoundPitch;
	lastAlarmTime = 0;
	AIEndEvent('Alarm', EAITYPE_Audio);

	// reset our stasis info
	bStasis = Default.bStasis;
}

function Tick(float deltaTime)
{
	Super.Tick(deltaTime);

   // DEUS_EX AMSD IN multiplayer, set lockout to 0
   if (Level.NetMode != NM_Standalone)
      bLockedOut = False;

	// shut off the alarm if the timeout has expired
	if (lastAlarmTime != 0)
	{
		if (Level.TimeSeconds - lastAlarmTime >= alarmTimeout)
			EndAlarm();
	}
}
// ----------------------------------------------------------------------
// ChangePlayerVisibility()
// ----------------------------------------------------------------------

function ChangePlayerVisibility(bool bInviso)
{
	local DeusExPlayer player;

   if (Level.NetMode != NM_Standalone)
      return;
	player = DeusExPlayer(GetPlayerPawn());
	if (player != None)
		player.MakePlayerIgnored(!bInviso);
}

// ----------------------------------------------------------------------
// state On
// ----------------------------------------------------------------------

state On
{
	function Tick(float deltaTime)
	{
		Global.Tick(deltaTime);

		if (bOn)
		{
			if ((termwindow == None) && (Level.NetMode == NM_Standalone))
         {
				GotoState('Off');
         }            
         if (curFrobber == None)
         {
            GotoState('Off');
         }
         else if (VSize(curFrobber.Location - Location) > 1500)
         {
            log("Disabling computer "$Self$" because user "$curFrobber$" was too far away");
			//Probably should be "GotoState('Off')" instead, but no good way to test, so I'll leave it alone.
            curFrobber = None;
         }
		}
	}

Begin:
	if (!bOn)
	{
      AdditionalActivation(curFrobber);
		bAnimating = True;
		PlayAnim('Activate');
		FinishAnim();
		bOn = True;
		bAnimating = False;
		ChangePlayerVisibility(False);
      TryInvoke();
	}
}

// ----------------------------------------------------------------------
// state Off
// ----------------------------------------------------------------------

auto state Off
{
Begin:
	if (bOn)
	{
      AdditionalDeactivation(curFrobber);
		ChangePlayerVisibility(True);
		bAnimating = True;
		PlayAnim('Deactivate');
		FinishAnim();
		bOn = False;
		bAnimating = False;
		if (bLockedOut)
			BeginAlarm();

		// Resume any datalinks that may have started while we were 
		// in the computers (don't want them to start until we pop back out)
		ResumeDataLinks();
      curFrobber = None;
	}
}

// ----------------------------------------------------------------------
// ResumeDataLinks()
// ----------------------------------------------------------------------

function ResumeDataLinks()
{
	local DeusExPlayer player;

	player = curFrobber;
	if (player != None)
	{
		player.ResumeDataLinks();
	}
}

// ----------------------------------------------------------------------
// TryInvoke()
// ----------------------------------------------------------------------

function TryInvoke()
{
   if (IsInState('Off'))
      return;
   
   if (!Invoke())
   {
      GotoState('Off');
   }

   return;
}

// ----------------------------------------------------------------------
// Invoke()
// ----------------------------------------------------------------------

function bool Invoke()
{
	local DeusExPlayer player;

	if (termwindow != None)
		return False;

	player = curFrobber;
	if (player != None)
	{
      //pass timing info so the player can keep the time uptodate on his end.
      player.InvokeComputerScreen(self, lastHackTime, Level.TimeSeconds);
      // set owner for relevancy fer sure;
      SetOwner(Player);
	}

	return True;
}

// ----------------------------------------------------------------------
// CloseOut()
// ----------------------------------------------------------------------

function CloseOut()
{
   if (curFrobber != None)
   {
      //curFrobber = None;
      GotoState('Off');
   }
}

// ----------------------------------------------------------------------
// Frob()
// ----------------------------------------------------------------------

function Frob(Actor Frobber, Inventory frobWith)
{
	local DeusExPlayer player;
	local float elapsed, delay;

   // Don't allow someone else to use the computer when already in use.
   if (curFrobber != None)
   {
      if (DeusExPlayer(Frobber) != None)
         DeusExPlayer(Frobber).ClientMessage(Sprintf(CompInUseMsg,curFrobber.PlayerReplicationInfo.PlayerName));
      return;
   }

	Super.Frob(Frobber, frobWith);

   // DEUS_EX AMSD get player from frobber, not from getplayerpawn
	player = DeusExPlayer(Frobber);
	if (player != None)
	{
		if (bLockedOut)
		{
			// computer skill shortens the lockout duration
			delay = lockoutDelay / player.SkillSystem.GetSkillLevelValue(class'SkillElectronics');

			elapsed = Level.TimeSeconds - lockoutTime;
			if (elapsed < delay)
				player.ClientMessage(Sprintf(msgLockedOut, Int(delay - elapsed)));
			else
				bLockedOut = False;
		}
		if (!bAnimating && !bLockedOut)
      {
         curFrobber = player;
			GotoState('On');
      }
	}
}

// ----------------------------------------------------------------------
// NumUsers()
// ----------------------------------------------------------------------

function int NumUsers()
{
	local int i;

	for (i=0; i<ArrayCount(userList); i++)
		if (userList[i].userName == "")
			break;

	return i;
}

// ----------------------------------------------------------------------
// GetUserName()
// ----------------------------------------------------------------------

function string GetUserName(int userIndex)
{
	if ((userIndex >= 0) && (userIndex < ArrayCount(userList)))
		return userList[userIndex].userName;

	return "ERR";
}

// ----------------------------------------------------------------------
// GetPassword()
// ----------------------------------------------------------------------

function string GetPassword(int userIndex)
{
	if ((userIndex >= 0) && (userIndex < ArrayCount(userList)))
		return userList[userIndex].password;

	return "ERR";
}

// ----------------------------------------------------------------------
// GetAccessLevel()
// ----------------------------------------------------------------------

function int GetAccessLevel(int userIndex)
{
	if ((userIndex >= 0) && (userIndex < ArrayCount(userList)))
		return Int(userList[userIndex].accessLevel);

	return 0;
}

// ----------------------------------------------------------------------
// GetNodeName()
// ----------------------------------------------------------------------

function String GetNodeName()
{
	return "";
}

// ----------------------------------------------------------------------
// GetNodeDesc()
// ----------------------------------------------------------------------
function String GetNodeDesc()
{
	return "";
}

// ----------------------------------------------------------------------
// GetNodeAddress()
// ----------------------------------------------------------------------
function String GetNodeAddress()
{
	return "";
}

// ----------------------------------------------------------------------
// GetNodeTexture()
// ----------------------------------------------------------------------
function Texture GetNodeTexture()
{
	return None;
}

// ----------------------------------------------------------------------
// AdditionalActivation()
// Called for subclasses to do any additional activation steps.
// ----------------------------------------------------------------------

function AdditionalActivation(DeusExPlayer ActivatingPlayer)
{
}

// ----------------------------------------------------------------------
// AdditionalDeactivation()
// ----------------------------------------------------------------------

function AdditionalDeactivation(DeusExPlayer DeactivatingPlayer)
{
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     bOn=True
     lockoutDelay=30.000000
     lastHackTime=-9999.000000
     TextPackage="GameText"
     alarmTimeout=30
     CompInUseMsg="The computer is already in use by %s."
     Mass=20.000000
     Buoyancy=5.000000
}
