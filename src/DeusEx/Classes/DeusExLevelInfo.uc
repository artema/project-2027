//=============================================================================
// DeusExLevelInfo
//=============================================================================
class DeusExLevelInfo extends Info
	native;

var() String				MapName;
var() String				MapAuthor;
var() localized String	    MissionLocation;
var() int		    missionNumber;
var() Bool			bMultiPlayerMap;
var() Bool			bStaticMusic;
var() class<MissionScript>	Script;
var() int				TrueNorth;
var() localized String		startupMessage[4];
var() String			ConversationPackage;
var() Bool  bCutScene;
var() String  NextMapName;
var() String  ConstructionTime;
var() String  Comment;
var() String  BuildNote;
var() String  NextMapScreen;
var() String  CurrentMapScreen;

function SpawnScript()
{
	local MissionScript scr;
	local bool bFound;


	if (Script != None)
	{
		bFound = False;
		foreach AllActors(class'MissionScript', scr)
			bFound = True;

		if (!bFound)
		{
			if (Spawn(Script) == None)
				log("DeusExLevelInfo - WARNING! - Could not spawn mission script '"$Script$"'");
			else
				log("DeusExLevelInfo - Spawned new mission script '"$Script$"'");
		}
		else
			log("DeusExLevelInfo - WARNING! - Already found mission script '"$Script$"'");
	}
}

function PostBeginPlay()
{
	Super.PostBeginPlay();

	SpawnScript();
}

defaultproperties
{
     ConversationPackage="GameConversations"
     Texture=Texture'Engine.S_ZoneInfo'
     bAlwaysRelevant=True
     NextMapScreen=""
     CurrentMapScreen=""
}
