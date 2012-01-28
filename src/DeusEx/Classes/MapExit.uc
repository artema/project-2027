//=============================================================================
// MapExit.
//=============================================================================
class MapExit expands NavigationPoint;

//
// MapExit transports you to the next map
// change bCollideActors to False to make it triggered instead of touched
//

enum EScreen
{
	ES_Default,
	ES_Moscow_Streets,
	ES_Moscow_Streets_Snow,
	ES_Moscow_Bandits,
	ES_Moscow_Cafe,
	ES_Moscow_Club,
	ES_Moscow_Garage,
	ES_Moscow_Home,
	ES_Moscow_Metro,
	ES_Moscow_Pushkin,
	ES_Moscow_Station,
	ES_Moscow_Rooftop,
	ES_Moscow_Smuggler,
	ES_Moscow_Vladimir,
	ES_NorthLabs_Entrance,
	ES_NorthLabs_Main,
	ES_NorthLabs_Train,
	ES_MtWeather_Entrance,
	ES_MtWeather_Bunker,
	ES_MtWeather_Thanatos,
	ES_Paris_Home,
	ES_Paris_Latin,
	ES_Paris_Old,
	ES_Paris_Bar,
	ES_Paris_Cafe,
	ES_Paris_Club,
	ES_Paris_Cellar,
	ES_Paris_Smugglers,
	ES_Paris_Illuminati,
	ES_Paris_Lab,
	ES_Vector
};

var() EScreen LoadScreen;
var() string DestMap;
var() bool bPlayTransition;
var() name cameraPathTag;
var string ESName;
var DeusExPlayer Player;

var() bool bClearInHand;

function BeginPlay()
{
	Super.BeginPlay();

	switch (LoadScreen)
	{
		case ES_Default: 			ESName=""; 			break;
		case ES_Moscow_Streets:			ESName="MS_Streets";		break;
		case ES_Moscow_Streets_Snow: 		ESName="MS_Snow"; 		break;
		case ES_Moscow_Bandits:			ESName="MS_Bandits";		break;
		case ES_Moscow_Cafe: 			ESName="MS_Cafe"; 		break;
		case ES_Moscow_Club:			ESName="MS_Club";		break;
		case ES_Moscow_Garage: 			ESName="MS_Garage"; 		break;
		case ES_Moscow_Home:			ESName="MS_Home";		break;
		case ES_Moscow_Metro: 			ESName="MS_Metro";		break;
		case ES_Moscow_Pushkin:			ESName="MS_Pushkin";		break;
		case ES_Moscow_Station: 		ESName="MS_Station"; 		break;
		case ES_Moscow_Rooftop:			ESName="MS_Roof";		break;
		case ES_Moscow_Smuggler: 		ESName="MS_Smuggler";		break;
		case ES_Moscow_Vladimir:		ESName="MS_Vladimir";		break;
		case ES_NorthLabs_Entrance: 		ESName="NL_Entrance"; 		break;
		case ES_NorthLabs_Main:			ESName="NL_Main";		break;
		case ES_NorthLabs_Train: 		ESName="NL_Train"; 		break;
		case ES_MtWeather_Entrance:		ESName="MT_Entrance";		break;
		case ES_MtWeather_Bunker: 		ESName="MT_Bunker"; 		break;
		case ES_MtWeather_Thanatos:		ESName="MT_Thanatos";		break;
		case ES_Paris_Home: 			ESName="FR_Home"; 		break;
		case ES_Paris_Latin:			ESName="FR_Latin";		break;
		case ES_Paris_Old: 			ESName="FR_Old";		break;
		case ES_Paris_Bar:			ESName="FR_Bar";		break;
		case ES_Paris_Cafe: 			ESName="FR_Cafe"; 		break;
		case ES_Paris_Club:			ESName="FR_Club";		break;
		case ES_Paris_Cellar: 			ESName="FR_Cellar";		break;
		case ES_Paris_Smugglers:		ESName="FR_Smugglers";		break;
		case ES_Paris_Illuminati:		ESName="FR_Illuminati";		break;
		case ES_Paris_Lab:			ESName="FR_Lab";		break;
		case ES_Vector:				ESName="NL_Vector";		break;
	}
}

function LoadMap(Actor Other)
{
	// use GetPlayerPawn() because convos trigger by who's having the convo
	Player = DeusExPlayer(GetPlayerPawn());

	if (Player != None)
	{
		if(bClearInHand)
		{
			Player.PutInHand(None);
			Player.flagBase.SetBool('PlayerInCutscene', True, True, 0);
		}

		// Make sure we destroy all windows before sending the 
		// player on his merry way.
		DeusExRootWindow(Player.rootWindow).ClearWindowStack();

		Player.SetLoadScr(ESName);

		if (bPlayTransition)
		{
			PlayTransitionPath();
			Player.NextMap = DestMap;
		}
		else
			Level.Game.SendPlayer(Player, DestMap);
	}
}

function Trigger(Actor Other, Pawn Instigator)
{
	Super.Trigger(Other, Instigator);
	LoadMap(Other);
}

function Touch(Actor Other)
{
	Super.Touch(Other);
	LoadMap(Other);
}

function PlayTransitionPath()
{
	local InterpolationPoint I;

	if (Player != None)
	{
		foreach AllActors(class 'InterpolationPoint', I, cameraPathTag)
		{
			if (I.Position == 1)
			{
				Player.SetCollision(False, False, False);
				Player.bCollideWorld = False;
				Player.Target = I;
				Player.SetPhysics(PHYS_Interpolating);
				Player.PhysRate = 1.0;
				Player.PhysAlpha = 0.0;
				Player.bInterpolating = True;
				Player.bStasis = False;
				Player.ShowHud(False);
				Player.PutInHand(None);

				// if we're in a conversation, set the NextState
				// otherwise, goto the correct state
				if (Player.conPlay != None)
					Player.NextState = 'Interpolating';
				else
					Player.GotoState('Interpolating');

				break;
			}
		}
	}
}

defaultproperties
{
     Texture=Texture'Engine.S_Teleport'
     bCollideActors=False
}
