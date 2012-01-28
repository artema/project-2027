//=============================================================================
// AugmentationDisplayWindow.
//=============================================================================
class AugmentationDisplayWindow extends HUDBaseWindow;

var ViewportWindow winBot;
var StaticInterlacedWindow winBotStatic;
var StaticInterlacedWindow winDataStatic;
var StaticInterlacedWindow winDataStaticMax;
var bool bBotCreated;
var bool bBotReferenced;
var int BotX, BotY, BotW, BotH;
var int DroneX, DroneY, DroneW, DroneH;

var ViewportWindow winZoom;
var float margin;
var float corner;

var bool bDefenseActive;
var DeusExProjectile defenseTargets[30];

var ViewportWindow winDrone;
var StaticInterlacedWindow winDroneStatic;
var bool bDroneCreated;
var bool bDroneReferenced;

var bool bTargetActive;
var int targetLevel;
var Actor lastTarget;
var float lastTargetTime;

var bool bVisionActive;
var bool bGogglesActive;
var int visionLevel;
var float visionLevelValue;
var int activeCount;

var localized String msgBotDanger;
var localized String msgBotHealth;
var localized String msgBotEnergy;
var localized String msgRange;
var localized String msgRangeUnits;
var localized String msgHigh;
var localized String msgMedium;
var localized String msgLow;
var localized String msgHealth;
var localized String msgOverall;
var localized String msgPercent;
var localized String msgHead;
var localized String msgTorso;
var localized String msgLeftArm;
var localized String msgRightArm;
var localized String msgLeftLeg;
var localized String msgRightLeg;
var localized String msgLegs;
var localized String msgWeapon;
var localized String msgNone;
var localized String msgScanning1;
var localized String msgScanning2;
var localized String msgADSTracking;
var localized String msgADSDetonating;
var localized String msgBehind;
var localized String msgDroneActive;
var localized String msgEnergyLow;
var localized String msgCantLaunch;
var localized String msgLightAmpActive;
var localized String msgIRAmpActive;
var localized String msgNoImage;
var localized String msgDisabled;
var localized String SpottedTeamString;
var localized String YouArePoisonedString;
var localized String YouAreBurnedString;
var localized String TurretInvincibleString;
var localized String CameraInvincibleString;
var localized String NeutBurnPoisonString;
var localized String	OnlyString;
var localized String KillsToGoString;
var localized String KillToGoString;
var localized String	LessThanMinuteString;
var localized String	LessThanXString1;
var localized String	LessThanXString2;
var localized String	LeadsMatchString;
var localized String	TiedMatchString;
var localized String WillWinMatchString;
var localized String OutOfRangeString;
var localized String LostLegsString;
var localized String DropItem1String;
var localized String DropItem2String;
var localized String msgTeammateHit, msgTeamNsf, msgTeamUnatco;
var localized String	UseString;
var localized String	TeamTalkString;
var localized String	TalkString;
var localized String YouKilledTeammateString;
var localized String TeamLAMString;
var localized String TeamComputerString;
var localized String NoCloakWeaponString;
var localized String TeamHackTurretString;
var localized String KeyNotBoundString;

var localized String hintDroneOff;
var localized String hintDroneBlow;
var localized String hintBotSwitch;
var localized String hintBotOrder;
var localized String hintBotOff;

var localized String OutOfAmmoString;
var float OutOfAmmoTime;

var Actor VisionBlinder; //So the same thing doesn't blind me twice.

var int VisionTargetStatus; //For picking see through wall texture
const VISIONENEMY = 1;
const VISIONALLY = 2;
const VISIONNEUTRAL = 0;

// Show name of player in multiplayer on a timer
var String	targetPlayerName;					// Player's name in targeting reticle
var String  targetPlayerHealthString;     // Target player's health (for targeting aug)'
var String  targetPlayerLocationString;   // Point on target player at which you are aiming (For multiplayer)
var float	targetPlayerTime;					// Timer
var float	targetRangeTime;
var color	targetPlayerColor;				// Color red or green
var bool		targetOutOfRange;					// Is target out of range with current weapon
const			targetPlayerDelay		= 3;			// Delay in seconds until name is not displayed
const			targetPlayerXMul		= 0.08;
const			targetPlayerYMul		= 0.79;

var String	keyDropItem, keyTalk, keyTeamTalk;

var Color	colRed, colGreen, colWhite;


var StaticWindow winVisionStatic;
var StaticInterlacedWindow winVisionLines;
var StaticDottedWindow winVisionDots;

var string				MenuValues1[17];
var string				MenuValues2[17];
var string				AliasNames[17];

struct S2_KeyDisplayItem
{
	var EInputKey inputKey;
	var localized String DisplayName;
};

var localized S2_KeyDisplayItem          keyDisplayNames[71];
var bool bKeyCacheBuild;



// ----------------------------------------------------------------------
// InitWindow()
// ----------------------------------------------------------------------

event InitWindow()
{
	Super.InitWindow();
	bTickEnabled = True;
	Lower();
	RefreshMultiplayerKeys();
}

function BuildKeyBindingsCache()
{
	local int i, j, pos;
	local string KeyName;
	local string Alias;

	if(!bKeyCacheBuild)
	{
		for(i=0; i<arrayCount(MenuValues1); i++)
		{
			MenuValues1[i] = "";
			MenuValues2[i] = "";
		}
		
		for ( i=0; i<255; i++ )
		{
			KeyName = player.ConsoleCommand ( "KEYNAME "$i );
			if ( KeyName != "" )
			{
				Alias = player.ConsoleCommand( "KEYBINDING "$KeyName );
	
				if ( Alias != "" )
				{
					pos = InStr(Alias, " " );
					if ( pos != -1 )
						Alias = Left(Alias, pos);
	
					for ( j=0; j<arrayCount(AliasNames); j++ )
					{
						if ( AliasNames[j] == Alias )
						{
							if ( MenuValues1[j] == "" )
								MenuValues1[j] = GetKeyDisplayNameFromKeyName(KeyName);
							else if ( MenuValues2[j] == "" )
								MenuValues2[j] = GetKeyDisplayNameFromKeyName(KeyName);
						}
					}
				}
			}
		}
		
		bKeyCacheBuild = True;
	}
}

function String GetKeyDisplayNameFromKeyName(string keyName)
{
	local int keyIndex;

	for(keyIndex=0; keyIndex<arrayCount(keyDisplayNames); keyIndex++)
	{
		if (mid(string(GetEnum(enum'EInputKey', keyDisplayNames[keyIndex].inputKey)), 3) == keyName)
		{
			return keyDisplayNames[keyIndex].DisplayName;
			break;
		}
	}

	return keyName;
}

function String GetInputDisplayText(int keyIndex)
{
	if ( MenuValues1[keyIndex] == "" )
		return "[-]";
	else if ( MenuValues2[keyIndex] != "" )
		return MenuValues1[keyIndex] $ "," @ MenuValues2[keyIndex];
	else
		return MenuValues1[keyIndex];
}

function String GetKeys(String action)
{
	local int j;
	
	BuildKeyBindingsCache();
	
	for ( j=0; j<arrayCount(AliasNames); j++ )
	{
		if ( AliasNames[j] == action)
		{
			return GetInputDisplayText(j);
		}
	}
	
	return "";
}

// ----------------------------------------------------------------------
// TraceLOS()
// ----------------------------------------------------------------------

function Actor TraceLOS(float checkDist, out vector HitLocation)
{
	local Actor target;
	local Vector HitLoc, HitNormal, StartTrace, EndTrace;

	target = None;

	// figure out how far ahead we should trace
	StartTrace = Player.Location;
	EndTrace = Player.Location + (Vector(Player.ViewRotation) * checkDist);

	// adjust for the eye height
	StartTrace.Z += Player.BaseEyeHeight;
	EndTrace.Z += Player.BaseEyeHeight;

	// find the object that we are looking at
	// make sure we don't select the object that we're carrying
	foreach Player.TraceActors(class'Actor', target, HitLoc, HitNormal, EndTrace, StartTrace)
	{
		if (target.IsA('Pawn'))
		{
				if ( (Player.Level.NetMode != NM_Standalone) && target.IsA('DeusExPlayer') )
				{
					if ( DeusExPlayer(target).AdjustHitLocation( HitLoc, EndTrace - StartTrace ) )
						break;
					else
						target = None;
				}
				else
					break;
		}
	}

	HitLocation = HitLoc;

	return target;
}

// ----------------------------------------------------------------------
// Interpolate()
// ----------------------------------------------------------------------

function Interpolate(GC gc, float fromX, float fromY, float toX, float toY, int power)
{
	local float xPos, yPos;
	local float deltaX, deltaY;
	local float maxDist;
	local int   points;
	local int   i;

	maxDist = 16;

	points = 1;
	deltaX = (toX-fromX);
	deltaY = (toY-fromY);
	while (power >= 0)
	{
		if ((deltaX >= maxDist) || (deltaX <= -maxDist) || (deltaY >= maxDist) || (deltaY <= -maxDist))
		{
			deltaX *= 0.5;
			deltaY *= 0.5;
			points *= 2;
			power--;
		}
		else
			break;
	}

	xPos = fromX + ((Player.Level.TimeSeconds % 0.5) * deltaX * 2);
	yPos = fromY + ((Player.Level.TimeSeconds % 0.5) * deltaY * 2);
	for (i=0; i<points-1; i++)
	{
		xPos += deltaX;
		yPos += deltaY;
		gc.DrawPattern(xPos, yPos, 2, 2, 0, 0, Texture'Solid');
	}
}

// ----------------------------------------------------------------------
// ConfigurationChanged()
// ----------------------------------------------------------------------

function ConfigurationChanged()
{
	local float x, y, w, h, cx, cy;

	/*if ((winDrone != None) || (winZoom != None))
	{
		w = width/4;
		h = height/4;
		cx = width/8 + margin;
		cy = height/2;
		x = cx - w/2;
		y = cy - h/2;

		if (winDrone != None)
			winDrone.ConfigureChild(x, y, w, h);

		if (winZoom != None)
			winZoom.ConfigureChild(x, y, w, h);
	}*/

	if (winDrone != None)
	{

		DroneW = width/3;//8
		DroneH = height/3;//8
		DroneX = width/2 - DroneW/2;
		DroneY = height/2 - DroneH/2;

		winDrone.ConfigureChild(DroneX, DroneY, DroneW, DroneH);
	}

	if (winBot != None)
	{

		BotW = width/5;//8
		BotH = height/5;//8
		BotX = width - BotW*2;
		BotY = height - BotH*2;

		if (winBot != None)
			winBot.ConfigureChild(BotX, BotY, BotW, BotH);
	}
}//##

// ----------------------------------------------------------------------
// ChildRequestedReconfiguration()
// ----------------------------------------------------------------------

function bool ChildRequestedReconfiguration(Window childWin)
{
	ConfigurationChanged();

	return True;
}

// ----------------------------------------------------------------------
// RefreshMultiplayerKeys()
// ----------------------------------------------------------------------
function RefreshMultiplayerKeys()
{
	local String Alias, keyName;
	local int i;

	for ( i = 0; i < 255; i++ )
	{
		keyName = player.ConsoleCommand ( "KEYNAME "$i );
		if ( keyName != "" )
		{
			Alias = player.ConsoleCommand( "KEYBINDING "$keyName );
			if ( Alias ~= "DropItem" )
				keyDropItem = keyName;
			else if ( Alias ~= "Talk" )
				keyTalk = keyName;
			else if ( Alias ~= "TeamTalk" )
				keyTeamTalk = keyName;
		}
	}
	if ( keyDropItem ~= "" )
		keyDropItem = KeyNotBoundString;
	if ( keyTalk ~= "" )
		keyTalk = KeyNotBoundString;
	if ( keyTeamTalk ~= "" )
		keyTeamTalk = KeyNotBoundString;
}

// ----------------------------------------------------------------------
// Tick()
// ----------------------------------------------------------------------

function Tick(float deltaTime)
{
	if (winZoom != None)
	{
		if ((bTargetActive && (lastTarget == None)) || !bTargetActive)
		{
			winZoom.Destroy();
			winZoom = None;
		}
	}

	visionLevel = DeusExPlayer(GetPlayerPawn()).AugmentationSystem.GetClassLevel(class'AugVision');
	bVisionActive = (visionLevel >= 0);

	if(!bVisionActive && bGogglesActive)
	{
		bVisionActive = True;		
		visionLevel = 1;
		VisionLevelValue = 1500;
	}
	else
		VisionLevelValue = DeusExPlayer(GetPlayerPawn()).AugmentationSystem.GetAugLevelValue(class'AugVision');

	if(bVisionActive){
		
		
		//Vision: green
		/*if(visionLevel == 0 && winVisionStatic == None){
			winVisionStatic = StaticWindow(NewChild(Class'StaticWindow'));
			winVisionStatic.AskParentForReconfigure();
			winVisionStatic.StaticTexture=Texture'DeusExUI.UserInterface.ScopeStatic';
			winVisionStatic.SetSize(width, height);
			winVisionStatic.RandomizeStatic();
			winVisionStatic.SetPos(0, 0);
			winVisionStatic.SetBackgroundStyle(DSTY_Modulated);
			winVisionStatic.Raise();

			if(winVisionLines != None){
				winVisionLines.Destroy();
				winVisionLines = None;
			}

			if(winVisionDots != None){
				winVisionDots.Destroy();
				winVisionDots = None;
			}
		}
		else */
		//Vision: blue
		if((visionLevel == 0) && winVisionLines == None){
			winVisionLines = StaticInterlacedWindow(NewChild(Class'StaticInterlacedWindow'));
			winVisionLines.AskParentForReconfigure();
			winVisionLines.StaticTexture=Texture'GameMedia.UI.VisorLined';
			winVisionLines.SetSize(width, height);
			winVisionLines.RandomizeStatic();
			winVisionLines.SetPos(0, 0);
			winVisionLines.SetBackgroundStyle(DSTY_Modulated);
			winVisionLines.Raise();

			if(winVisionStatic != None){
				winVisionStatic.Destroy();
				winVisionStatic = None;
			}

			if(winVisionDots != None){
				winVisionDots.Destroy();
				winVisionDots = None;
			}
		}
		//Vision: red
		else if((visionLevel == 1) && winVisionDots == None){
			winVisionDots = StaticDottedWindow(NewChild(Class'StaticDottedWindow'));
			winVisionDots.AskParentForReconfigure();
			winVisionDots.StaticTexture=Texture'GameMedia.UI.VisorDotted';
			winVisionDots.SetSize(width, height);
			winVisionDots.SetPos(0, 0);
			winVisionDots.SetBackgroundStyle(DSTY_Modulated);
			winVisionDots.Raise();

			if(winVisionStatic != None){
				winVisionStatic.Destroy();
				winVisionStatic = None;
			}

			if(winVisionLines != None){
				winVisionLines.Destroy();
				winVisionLines = None;
			}
		}
	}
	else if(!bVisionActive){
		if(winVisionStatic != None){
			winVisionStatic.Destroy();
			winVisionStatic = None;
		}

		if(winVisionLines != None){
			winVisionLines.Destroy();
			winVisionLines = None;
		}

		if(winVisionDots != None){
			winVisionDots.Destroy();
			winVisionDots = None;
		}
	}
	
	if(bVisionActive)
	{
		//Vision: blue
		if((visionLevel == 0) && winVisionLines != None)
		{
			winVisionLines.AskParentForReconfigure();
			winVisionLines.SetSize(width, height);
			winVisionLines.SetPos(0, 0);
			winVisionLines.Raise();
		}
		//Vision: red
		else if((visionLevel == 1) && winVisionDots != None)
		{
			winVisionDots.AskParentForReconfigure();
			winVisionDots.SetSize(width, height);
			winVisionDots.SetPos(0, 0);
			winVisionDots.Raise();
		}
	}
	
	if (Player.bBotControlActive && (winBot == None))
	{
		winBot = ViewportWindow(NewChild(class'ViewportWindow'));

		if (winBot != None)
		{
			winBot.AskParentForReconfigure();
			winBot.Lower();
			
			if(Player.aBot != None)
				winBot.SetViewportActor(Player.aBot);
			else
				winBot.SetViewportActor(None);
		}
	}

	if (Player.bBotControlActive && (winBotStatic == None) && (Player.aBot != None))
	{
		winBotStatic = StaticInterlacedWindow(NewChild(Class'StaticInterlacedWindow'));
		
		if (winBotStatic != None)
		{
			winBotStatic.AskParentForReconfigure();
			winBotStatic.StaticTexture=Texture'GameMedia.UI.VisorLined';
			winBotStatic.SetSize(BotW, BotH);
			winBotStatic.RandomizeStatic();
			winBotStatic.SetPos(BotX, BotY);
			winBotStatic.SetBackgroundStyle(DSTY_Modulated);
			winBotStatic.Raise();
		}
	}


	// check for the drone ViewportWindow being constructed
	if (Player.bSpyDroneActive && (Player.aDrone != None) && (winDrone == None))
	{
		winDrone = ViewportWindow(NewChild(class'ViewportWindow'));
		
		if (winDrone != None)
		{
			winDrone.AskParentForReconfigure();
			winDrone.Lower();
			
			if(Player.aDrone != None)
				winDrone.SetViewportActor(Player.aDrone);
			else
				winBot.SetViewportActor(None);
		}
	}

	if (Player.bSpyDroneActive && (Player.aDrone != None) && (winDroneStatic == None))
	{
		winDroneStatic = StaticInterlacedWindow(NewChild(Class'StaticInterlacedWindow'));
		
		if (winDroneStatic != None)
		{
			winDroneStatic.AskParentForReconfigure();
			winDroneStatic.StaticTexture=Texture'GameMedia.UI.VisorLined';
			winDroneStatic.SetSize(DroneW, DroneH);
			winDroneStatic.RandomizeStatic();
			winDroneStatic.SetPos(DroneX, DroneY);
			winDroneStatic.SetBackgroundStyle(DSTY_Modulated);
			winDroneStatic.Raise();
		}
	}

	// check for the target ViewportWindow being constructed
	/*if (bTargetActive && (targetLevel > 2) && (winZoom == None) && (lastTarget != None) && (Player.Level.NetMode == NM_Standalone))
	{
		winZoom = ViewportWindow(NewChild(class'ViewportWindow'));
		if (winZoom != None)
		{
			winZoom.AskParentForReconfigure();
			winZoom.Lower();
		}
	}*/

	// handle Destroy() in Tick() since they can't be in DrawWindow()
	if (!Player.bSpyDroneActive)
	{
		if (winDrone != None)
		{
			if(winDrone.watchActor != None)
			{
				RemoveActorRef(winDrone.watchActor);
			}
			
			winDrone.EnableViewport(False);
			winDrone.Destroy();
			winDrone = None;
		}
		
		if (winDroneStatic != None)
		{
			winDroneStatic.Destroy();
			winDroneStatic = None;
		}
		
		//if ((Player.aDrone != None) && IsActorValid(Player.aDrone))
		//{
			if(Player.aDrone != None)
				RemoveActorRef(Player.aDrone);
				
			bDroneReferenced = false;
		//}
		//bDroneCreated = false;
	}
	else
	{
		if (winDroneStatic != None)
		{
			winDroneStatic.AskParentForReconfigure();
			winDroneStatic.SetSize(DroneW, DroneH);
			winDroneStatic.SetPos(DroneX, DroneY);
			winDroneStatic.Raise();
		}
	}


	if (!Player.bBotControlActive)
	{
		if (winBot != None)
		{
			winBot.Destroy();
			winBot = None;
		}

		if (winBotStatic != None)
		{
			winBotStatic.Destroy();
			winBotStatic = None;
		}

		//if ((Player.aBot != None) && IsActorValid(Player.aBot))
		//{
			if(Player.aBot != None)
				RemoveActorRef(Player.aBot);
				
			bBotReferenced = false;
		//}
		//bBotCreated = false;
	}
	else
	{
		if (winBotStatic != None)
		{
			winBotStatic.AskParentForReconfigure();
			winBotStatic.SetSize(BotW, BotH);
			winBotStatic.SetPos(BotX, BotY);
			winBotStatic.Raise();
		}
	}
	
	
	if(DeusExPlayer(GetPlayerPawn()).bProcessingData)
	{
		if(winDataStatic == None)
		{
			winDataStatic = StaticInterlacedWindow(NewChild(Class'StaticInterlacedWindow'));
			winDataStatic.AskParentForReconfigure();
			winDataStatic.StaticTexture=Texture'DeusExUI.UserInterface.ScopeStatic2';
			winDataStatic.SetSize(width, height);
			winDataStatic.RandomizeStatic();
			winDataStatic.SetPos(0, 0);
			winDataStatic.SetBackgroundStyle(DSTY_Translucent);
			winDataStatic.Raise();
		}
		else
		{
			winDataStatic.AskParentForReconfigure();
			winDataStatic.SetSize(width, height);
			winDataStatic.SetPos(0, 0);
			winDataStatic.Raise();
		}
	}
	else if(DeusExPlayer(GetPlayerPawn()).bProcessingDataMax)
	{
		if(winDataStaticMax == None)
		{
			winDataStaticMax = StaticInterlacedWindow(NewChild(Class'StaticInterlacedWindow'));
			winDataStaticMax.AskParentForReconfigure();
			winDataStaticMax.StaticTexture=Texture'DeusExUI.UserInterface.ScopeStatic2';
			winDataStaticMax.SetSize(width, height);
			winDataStaticMax.RandomizeStatic();
			winDataStaticMax.SetPos(0, 0);
			winDataStaticMax.SetBackgroundStyle(DSTY_Translucent);
			winDataStaticMax.Raise();
		}
		else
		{
			winDataStatic.AskParentForReconfigure();
			winDataStatic.SetSize(width, height);
			winDataStatic.SetPos(0, 0);
			winDataStatic.Raise();
		}
	}
	else
	{
		if(winDataStatic != None)
		{
			winDataStatic.Destroy();
			winDataStatic = None;
		}	
		
		if(winDataStaticMax != None)
		{
			winDataStaticMax.Destroy();
			winDataStaticMax = None;
		}
	}
}

// ----------------------------------------------------------------------
// PostDrawWindow()
// ----------------------------------------------------------------------

function PostDrawWindow(GC gc)
{
	local PlayerPawn pp;

	pp = Player.GetPlayerPawn();

//		DrawFogAugmentation(gc);

   //DEUS_EX AMSD Draw vision first so that everything else doesn't get washed green
	if (bVisionActive)
		DrawVisionAugmentation(gc);

	//if ( Player.Level.NetMode != NM_Standalone )
	//	DrawMiscStatusMessages( gc );

	if (bDefenseActive)
		DrawDefenseAugmentation(gc);

   // draw IFF and accuracy information all the time, return False if target aug is not active
	DrawTargetAugmentation(gc);
	
	if (Player.bSpyDroneActive)
	{
		DrawSpyDroneAugmentation(gc);
		//DeusExRootWindow(Player.rootWindow).hud.UpdateSettings(Player);
	}

	if (Player.bBotControlActive)
		DrawBotAugmentation(gc);

    gc.SetFont(Font'FontMenuSmall_DS');
	gc.SetTextColor(colHeaderText);
	gc.SetStyle(DSTY_Normal);
	gc.SetTileColor(colBorder);

   if ( (pp != None) && (pp.bShowScores) )
	{
		if ( DeathMatchGame(Player.DXGame) != None )
			DeathMatchGame(Player.DXGame).ShowDMScoreboard( Player, gc, width, height );
		else if ( TeamDMGame(Player.DXGame) != None )
			TeamDMGame(Player.DXGame).ShowTeamDMScoreboard( Player, gc, width, height );
	}
}

// ----------------------------------------------------------------------
// DrawDefenseAugmentation()
// ----------------------------------------------------------------------

function DrawDefenseAugmentation(GC gc)
{
	local String str;
	local float boxCX, boxCY;
	local float x, y, w, h, mult;
	local DeusExProjectile defenseTarget;
	local int behindCount;
	local int i;

	gc.SetFont(Font'FontAugOverlaySmall');

	behindCount = 0;

	for(i=0; i<30; i++)
	{
		defenseTarget = defenseTargets[i];
		
		if (defenseTarget != None)
		{
			mult = VSize(defenseTarget.Location - Player.Location);
			//str = str $ CR() $ msgRange @ Int(mult/16) @ msgRangeUnits;
			str = Int((mult/52.5)*0.7) @ "";
	
			if (ConvertVectorToCoordinates(defenseTarget.Location, boxCX, boxCY))
			{
				gc.DrawTexture(boxCX-16, boxCY-16, 32, 32, 0, 0, Texture'GameMedia.UI.AugTargetCross');
				
				gc.GetTextExtent(0, w, h, str);
				gc.SetTextColorRGB(255,255,255);
				gc.DrawText(boxCX+16+4, boxCY-(h/2), w, h, str);
				gc.SetTextColor(colHeaderText);
			}
			else
			{
				behindCount++;
			}
	
			/*gc.GetTextExtent(0, w, h, str);
			x = boxCX - w/2;
			y = boxCY - h;
			gc.SetTextColorRGB(255,0,0);
			gc.DrawText(x, y, w, h, str);
			gc.SetTextColor(colHeaderText);
	
			if (bDrawLine)
			{
				gc.SetTileColorRGB(255,0,0);
				Interpolate(gc, width/2, height/2, boxCX, boxCY, 64);
				gc.SetTileColor(colHeaderText);
			}*/
		}
		else
			break;
	}
	
	if(behindCount > 0)
	{
		if (Player.Level.TimeSeconds % 0.3 > (0.3 / 2))
			gc.SetTextColorRGB(255,255,255);
		else
			gc.SetTextColorRGB(255,0,0);
			
		gc.SetFont(Font'FontAugOverlayBold');
		
		str = msgBehind;
		gc.GetTextExtent(0, w, h, str);
		gc.DrawText(width/2 - w/2, (height/2 - h) - 40, w, h, str);
		
		gc.SetTextColor(colHeaderText);
	}
}

// ----------------------------------------------------------------------
// DrawBotAugmentation()
// ----------------------------------------------------------------------

function DrawBotAugmentation(GC gc)
{
	local String str;
	local float boxCX, boxCY, boxTLX, boxTLY, boxBRX, boxBRY, boxW, boxH;
	local float x, y, w, h, mult;
	local Vector loc;
	local DeusExPlayer Player;
	local int benergy, bhealth;

	Player = DeusExPlayer(GetPlayerPawn());

//BotX, BotY, BotW, BotH

	boxW = BotW;			//width/4
	boxH = BotH;		//height/4
	boxCX = BotW/2 + margin;	//width/8 + margin
	boxCY = BotH*2;		//height/2
	boxTLX = BotX;	//boxCX - boxW/2
	boxTLY = BotY;	//boxCY - boxH/2
	boxBRX = BotX + BotW;	//boxCX + boxW/2
	boxBRY = BotY + BotH;	//boxCY + boxH/2

	DrawDropShadowBox(gc, boxTLX, boxTLY, boxW, boxH);
	gc.SetFont(Font'FontAugOverlaySmall');//GC!!1

	if (Player.bBotControlActive && Player.aBot == None)
	{
		if(winBot!=None){
			winBot.SetViewportActor(None);
			winBot.Destroy();
			winBot = None;
		}

		if(winBotStatic!=None){
			winBotStatic.Destroy();
			winBotStatic = None;
		}

		gc.SetStyle(DSTY_Normal);
		gc.SetTileColorRGB(0,0,0);
		gc.DrawPattern(botX, botY, botW, botH, 0, 0, Texture'Solid');
		
		str = msgNoImage;
		gc.GetTextExtent(0, w, h, str);
		x = BotX + boxCX - w/2;
		y = boxBRY - h - margin;
		gc.SetTextColor(colHeaderText);
		gc.DrawText(x, y, w, h, str);
		gc.SetTextColor(colHeaderText);
	}

	if ((winBot != None) && Player.bBotControlActive && Player.aBot != None)
	{
		winBot.SetViewportActor(Player.aBot);
		
		gc.SetStyle(DSTY_Modulated);
		gc.DrawPattern(BotX, BotY, BotW, BotH, 0, 0, Texture'GameMedia.UI.VisorWhite');
		gc.DrawPattern(BotX, BotY, BotW, BotH, 0, 0, Texture'GameMedia.UI.VisorWhite');
		gc.DrawPattern(BotX, BotY, BotW, BotH, 0, 0, Texture'VisionBlue');
		gc.DrawPattern(BotX, BotY, BotW, BotH, 0, 0, Texture'VisionBlue');
		gc.SetStyle(DSTY_Normal);
	
		bhealth = Int((Float(Player.aBot.Health) / Float(Player.aBot.SpawnClass.Default.BotHealth)) * 100.0);
		benergy = Int((Float(Player.aBot.EMPHitPoints) / Float(Player.aBot.SpawnClass.Default.BotEMPHealth)) * 100.0);

		str = msgBotHealth $ bhealth $ "%";
		gc.GetTextExtent(0, w, h, str);
		x = boxTLX + margin;
		y = boxTLY + margin;
		gc.SetTextColor(GetColorScaled(Float(bhealth)/100));
		gc.DrawText(x, y, w, h, str);
		gc.SetTextColor(colHeaderText);

		str = msgBotEnergy $ benergy $ "%";
		gc.GetTextExtent(0, w, h, str);
		x = boxTLX + margin;
		y = boxTLY + margin;
		gc.SetTextColor(GetColorScaled(Float(benergy)/100));
		gc.DrawText(x, y+h, w, h, str);
		gc.SetTextColor(colHeaderText);

		str = Player.aBot.FamiliarName;
		gc.GetTextExtent(0, w, h, str);
		x = BotX + boxCX - w/2;
		y = boxTLY - h - margin;
		gc.DrawText(x, y, w, h, str);

		if (bhealth <= Player.aBot.MinHealth)
		{
			str = msgBotDanger;
			gc.GetTextExtent(0, w, h, str);
			x = BotX + boxCX - w/2;
			y = boxBRY - h - margin;
			gc.SetTextColorRGB(255,0,0);
			gc.DrawText(x, y, w, h, str);
			gc.SetTextColor(colHeaderText);
		}
	}
	
		gc.SetFont(Font'FontFixedWidthSmall');

		str = GetKeys("ReloadWeapon") $  " = " $ hintBotSwitch;
		gc.GetTextExtent(0, w, h, str);
		x = BotX + margin;
		y = BotY + BotH + margin;
		gc.DrawText(x, y, w, h, str);
		
		if(Player.aBot != None)
		{
			str = GetKeys("ParseRightClick") $  " = " $ hintBotOff;
			gc.GetTextExtent(0, w, h, str);
			x = BotX + margin;
			y = BotY + BotH + margin;
			gc.DrawText(x, y+h, w, h, str);
		
			str = GetKeys("ParseLeftClick|Fire") $  " = " $ hintBotOrder;
			gc.GetTextExtent(0, w, h, str);
			x = BotX + margin;
			y = BotY + BotH + margin;
			gc.DrawText(x, y+(2*h), w, h, str);
		}

		gc.SetFont(Font'FontAugOverlaySmall');

	if ( !bBotReferenced )
	{
		if ( Player.aBot != None )
		{
			bBotReferenced = true;
			AddActorRef( Player.aBot );
		}
	}
}

// ----------------------------------------------------------------------
// DrawSpyDroneAugmentation()
// ----------------------------------------------------------------------

/*function DrawSpyDroneAugmentation(GC gc)
{
	local String str;
	local float boxCX, boxCY, boxTLX, boxTLY, boxBRX, boxBRY, boxW, boxH;
	local float x, y, w, h, mult;
	local Vector loc;

	// set the coords of the drone window
	boxW = width/4;
	boxH = height/4;
	boxCX = width/8 + margin;
	boxCY = height/2;
	boxTLX = boxCX - boxW/2;
	boxTLY = boxCY - boxH/2;
	boxBRX = boxCX + boxW/2;
	boxBRY = boxCY + boxH/2;

	gc.SetFont(Font'FontMenuTitle');//GC!!1

	if (winDrone != None)
	{
		DrawDropShadowBox(gc, boxTLX, boxTLY, boxW, boxH);

		str = msgDroneActive;
		gc.GetTextExtent(0, w, h, str);
		x = boxCX - w/2;
		y = boxTLY - h - margin;
		gc.DrawText(x, y, w, h, str);

		// print a low energy warning message
		if ((Player.Energy / Player.Default.Energy) < 0.2)
		{
			str = msgEnergyLow;
			gc.GetTextExtent(0, w, h, str);
			x = boxCX - w/2;
			y = boxTLY + margin;
			gc.SetTextColorRGB(255,0,0);
			gc.DrawText(x, y, w, h, str);
			gc.SetTextColor(colHeaderText);
		}
	}
	// Since drone is created on server, they is a delay in when it will actually show up on the client
	// the flags dronecreated and drone referenced negotiate this timing
	if ( !bDroneReferenced )
	{
		if ( Player.aDrone != None )
		{
			bDroneReferenced = true;
			AddActorRef( Player.aDrone );
		}
	}
}
*/
function DrawSpyDroneAugmentation(GC gc)
{
	local String str;
	local float boxCX, boxCY, boxTLX, boxTLY, boxBRX, boxBRY, boxW, boxH;
	local float x, y, w, h, mult;
	local Vector loc;
	local DeusExPlayer Player;
	local int benergy, bhealth;

	Player = DeusExPlayer(GetPlayerPawn());

//BotX, BotY, BotW, BotH

	boxW = DroneW;			//width/4
	boxH = DroneH;		//height/4
	boxCX = DroneW/2 + margin;	//width/8 + margin
	boxCY = DroneH*2;		//height/2
	boxTLX = DroneX;	//boxCX - boxW/2
	boxTLY = DroneY;	//boxCY - boxH/2
	boxBRX = DroneX + DroneW;	//boxCX + boxW/2
	boxBRY = DroneY + DroneH;	//boxCY + boxH/2

	DrawDropShadowBox(gc, boxTLX, boxTLY, boxW, boxH);
	gc.SetFont(Font'FontAugOverlaySmall');//GC!!1

	if ((winDrone != None) && Player.bSpyDroneActive && Player.aDrone != None)
	{
		gc.SetStyle(DSTY_Modulated);
		gc.DrawPattern(DroneX, DroneY, DroneW, DroneH, 0, 0, Texture'GameMedia.UI.VisorWhite');
		gc.DrawPattern(DroneX, DroneY, DroneW, DroneH, 0, 0, Texture'GameMedia.UI.VisorWhite');
		gc.DrawPattern(DroneX, DroneY, DroneW, DroneH, 0, 0, Texture'GameMedia.UI.VisionPurple');
		gc.DrawPattern(DroneX, DroneY, DroneW, DroneH, 0, 0, Texture'GameMedia.UI.VisionPurple');
		gc.SetStyle(DSTY_Normal);
	
		//bhealth = Int((Float(Player.aBot.Health) / Float(Player.aBot.SpawnClass.Default.BotHealth)) * 100.0);
		benergy = Int((Float(Player.aDrone.BotEMPHealth) / Float(Player.aDrone.BotEMPHealthDefault)) * 100.0);

		/*str = msgBotHealth $ bhealth $ "%";
		gc.GetTextExtent(0, w, h, str);
		x = boxTLX + margin;
		y = boxTLY + margin;
		gc.SetTextColor(GetColorScaled(Float(bhealth)/100));
		gc.DrawText(x, y, w, h, str);
		gc.SetTextColor(colHeaderText);*/

		str = msgBotEnergy $ benergy $ "%";
		gc.GetTextExtent(0, w, h, str);
		x = boxTLX + margin;
		y = boxTLY + margin;
		gc.SetTextColor(GetColorScaled(Float(benergy)/100));
		gc.DrawText(x, y/*+h*/, w, h, str);
		gc.SetTextColor(colHeaderText);




		gc.SetFont(Font'FontFixedWidthSmall');

		str = GetKeys("ParseRightClick") $  " = " $ hintDroneOff;
		gc.GetTextExtent(0, w, h, str);
		x = DroneX + margin;
		y = DroneY + DroneH + margin;
		gc.DrawText(x, y, w, h, str);
		
		//if(Player.aDrone.HasSpawnGrenade())
		if(Player.PerkSystem.CheckPerkState(class'PerkBotexplode'))
		{
			str = GetKeys("ParseLeftClick|Fire") $  " = " $ hintDroneBlow;
			gc.GetTextExtent(0, w, h, str);
			x = DroneX + margin;
			y = DroneY + DroneH + margin;
			gc.DrawText(x, y+h, w, h, str);
		}

		gc.SetFont(Font'FontAugOverlaySmall');
		
		/*str = Player.aBot.FamiliarName;
		gc.GetTextExtent(0, w, h, str);
		x = BotX + boxCX - w/2;
		y = boxTLY - h - margin;
		gc.DrawText(x, y, w, h, str);*/

		/*if (bhealth <= Player.aBot.MinHealth)
		{
			str = msgBotDanger;
			gc.GetTextExtent(0, w, h, str);
			x = BotX + boxCX - w/2;
			y = boxBRY - h - margin;
			gc.SetTextColorRGB(255,0,0);
			gc.DrawText(x, y, w, h, str);
			gc.SetTextColor(colHeaderText);
		}*/
	}

	if ( !bDroneReferenced )
	{
		if (Player.bSpyDroneActive && Player.aDrone != None )
		{
			bDroneReferenced = true;
			AddActorRef( Player.aDrone );
		}
	}
}

//-------------------------------------------------------------------------------------------------
// TopCentralMessage()
//-------------------------------------------------------------------------------------------------

function float TopCentralMessage( GC gc, String str, color textColor )
{
	local float x, y, w, h;

	gc.SetFont(Font'FontMenuTitle');
	gc.GetTextExtent( 0, w, h, str );
	gc.SetTextColor( textColor );
	x = (width * 0.5) - (w * 0.5);
	y = height * 0.33;
	DrawFadedText( gc, x, y, textColor, str );
	return( y + h );
}

// ----------------------------------------------------------------------
// DrawFadedText()
// ----------------------------------------------------------------------
function DrawFadedText( GC gc, float x, float y, Color msgColor, String msg )
{
	local Color adj;
	local float mul, w, h;

	EnableTranslucentText(True);
	gc.SetStyle(DSTY_Translucent);
	mul = FClamp( (Player.mpMsgTime - Player.Level.Timeseconds)/Player.mpMsgDelay, 0.0, 1.0 );
	adj.r = mul * msgColor.r;
	adj.g = mul * msgColor.g;
	adj.b = mul * msgColor.b;
	gc.SetTextColor(adj);
	gc.GetTextExtent( 0, w, h, msg );
	gc.DrawText( x, y, w, h, msg );
	gc.SetStyle(DSTY_Normal);
	EnableTranslucentText(False);
}

// ----------------------------------------------------------------------
// DrawMiscStatusMessages()
// ----------------------------------------------------------------------
function DrawMiscStatusMessages( GC gc )
{
	local DeusExWeapon weap;
	local float x, y, w, h, cury;
	local Color msgColor;
	local String str;
	local bool bNeutralMsg;
	local String dropKeyName, keyName;
	local int i;

	bNeutralMsg = False;

	if (( Player.Level.Timeseconds < Player.mpMsgTime ) && !Player.bShowScores )
	{
		msgColor = colGreen;

		switch( Player.mpMsgCode )
		{
			case Player.MPMSG_TeamUnatco:
				str = msgTeamUnatco;
				cury = TopCentralMessage( gc, str, msgColor );
				if ( keyTalk ~= KeyNotBoundString )
					RefreshMultiplayerKeys();
				str = UseString $ keyTalk $ TalkString;
				gc.GetTextExtent( 0, w, h, str );
				cury += h;
				DrawFadedText( gc, (width * 0.5) - (w * 0.5), cury, msgColor, str );
				if ( TeamDMGame(Player.DXGame) != None )
				{
					cury += h;
					if ( keyTeamTalk ~= KeyNotBoundString )
						RefreshMultiplayerKeys();
					str = UseString $ keyTeamTalk $ TeamTalkString;
					gc.GetTextExtent( 0, w, h, str );
					DrawFadedText( gc, (width * 0.5) - (w * 0.5), cury, msgColor, str );
				}
				break;
			case Player.MPMSG_TeamNsf:
				str = msgTeamNsf;
				cury = TopCentralMessage( gc, str, msgColor );
				if ( keyTalk ~= KeyNotBoundString )
					RefreshMultiplayerKeys();
				str = UseString $ keyTalk $ TalkString;
				gc.GetTextExtent( 0, w, h, str );
				cury += h;
				DrawFadedText( gc, (width * 0.5) - (w * 0.5), cury, msgColor, str );
				if ( TeamDMGame(Player.DXGame) != None )
				{
					cury += h;
					if ( keyTeamTalk ~= KeyNotBoundString )
						RefreshMultiplayerKeys();
					str = UseString $ keyTeamTalk $ TeamTalkString;
					gc.GetTextExtent( 0, w, h, str );
					DrawFadedText( gc, (width * 0.5) - (w * 0.5), cury, msgColor, str );
				}
				break;
			case Player.MPMSG_TeamHit:
				msgColor = colRed;
				str = msgTeammateHit;
				TopCentralMessage( gc, str, msgColor );
				break;
			case Player.MPMSG_TeamSpot:
				str = SpottedTeamString;
				TopCentralMessage( gc, str, msgColor );
				break;
			case Player.MPMSG_FirstPoison:
				str = YouArePoisonedString;
				cury = TopCentralMessage( gc, str, msgColor );
				gc.GetTextExtent( 0, w, h, NeutBurnPoisonString );
				x = (width * 0.5) - (w * 0.5);
				DrawFadedText( gc, x, cury, msgColor, NeutBurnPoisonString );
				break;
			case Player.MPMSG_FirstBurn:
				str = YouAreBurnedString;
				cury = TopCentralMessage( gc, str, msgColor );
				gc.GetTextExtent( 0, w, h, NeutBurnPoisonString );
				x = (width * 0.5) - (w * 0.5);
				DrawFadedText( gc, x, cury, msgColor, NeutBurnPoisonString );
				break;
			case Player.MPMSG_TurretInv:
				str = TurretInvincibleString;
				TopCentralMessage( gc, str, msgColor );
				break;
			case Player.MPMSG_CameraInv:
				str = CameraInvincibleString;
				TopCentralMessage( gc, str, msgColor );
				break;
			case Player.MPMSG_CloseKills:
				if ( Player.mpMsgOptionalParam > 1 )
					str = OnlyString $ Player.mpMsgOptionalParam $ KillsToGoString;
				else
					str = OnlyString $ Player.mpMsgOptionalParam $ KillToGoString;
				if ( Player.mpMsgOptionalString ~= "Tied" )	// Should only happen in a team game
					str = str $ TiedMatchString;
				else
					str = str $ Player.mpMsgOptionalString $ WillWinMatchString;
				TopCentralMessage( gc, str, msgColor );
				break;
			case Player.MPMSG_TimeNearEnd:
				if ( Player.mpMsgOptionalParam > 1 )
					str = LessThanXString1 $ Player.mpMsgOptionalParam $ LessThanXString2;
				else
					str = LessThanMinuteString;

				if ( Player.mpMsgOptionalString ~= "Tied" )	// Should only happen in a team game
					str = str $ TiedMatchString;
				else
					str = str $ Player.mpMsgOptionalString $ LeadsMatchString;
				TopCentralMessage( gc, str, msgColor );
				break;
			case Player.MPMSG_LostLegs:
				str = LostLegsString;
				TopCentralMessage( gc, str, msgColor );
				break;
			case Player.MPMSG_DropItem:
				if ( keyDropItem ~= KeyNotBoundString )
					RefreshMultiplayerKeys();
				str = DropItem1String $ keyDropItem $ DropItem2String;
				TopCentralMessage( gc, str, msgColor );
				break;
			case Player.MPMSG_KilledTeammate:
				msgColor = colRed;
				TopCentralMessage( gc, YouKilledTeammateString, msgColor );
				break;
			case Player.MPMSG_TeamLAM:
				str = TeamLAMString;
				TopCentralMessage( gc, str, msgColor );
				break;
			case Player.MPMSG_TeamComputer:
				str = TeamComputerString;
				TopCentralMessage( gc, str, msgColor );
				break;
			case Player.MPMSG_NoCloakWeapon:
				str = NoCloakWeaponString;
				TopCentralMessage( gc, str, msgColor );
				break;
			case Player.MPMSG_TeamHackTurret:
				str = TeamHackTurretString;
				TopCentralMessage( gc, str, msgColor );
				break;
		}
		gc.SetTextColor(colWhite);
	}
	if ( Player.Level.Timeseconds < targetPlayerTime )
	{
		gc.SetFont(Font'FontMenuSmall');
		gc.GetTextExtent(0, w, h, targetPlayerName $ targetPlayerHealthString $ targetPlayerLocationString);
		gc.SetTextColor(targetPlayerColor);
		x = width * targetPlayerXMul - (w*0.5);
		if ( x < 1) x = 1;
		y = height * targetPlayerYMul;
		gc.DrawText( x, y, w, h, targetPlayerName $ targetPlayerHealthString $ targetPlayerLocationString);
		if (( targetOutOfRange ) && ( targetRangeTime > Player.Level.Timeseconds ))
		{
			gc.GetTextExtent(0, w, h, OutOfRangeString);
			x = (width * 0.5) - (w*0.5);
			y = (height * 0.5) - (h * 3.0);
			gc.DrawText( x, y, w, h, OutOfRangeString );
		}
		gc.SetTextColor(colWhite);
	}
	weap = DeusExWeapon(Player.inHand);
	if (( weap != None ) && ( weap.AmmoLeftInClip() == 0 ) && (weap.NumClips() == 0) )
	{
		if ( weap.IsA('WeaponLAM') ||
			  weap.IsA('WeaponGasGrenade') ||
			  weap.IsA('WeaponEMPGrenade') ||
			  weap.IsA('WeaponShuriken') ||
			  weap.IsA('WeaponLAW') )
		{
		}
		else
		{
			if ( Player.Level.Timeseconds < OutOfAmmoTime )
			{
				gc.SetFont(Font'FontMenuTitle');
				gc.GetTextExtent( 0, w, h, OutOfAmmoString );
				gc.SetTextColor(colRed);
				x = (width*0.5) - (w*0.5);
				y = (height*0.5) - (h*5.0);
				gc.DrawText( x, y, w, h, OutOfAmmoString );
			}
			if ( Player.Level.Timeseconds-OutOfAmmoTime > 0.33 )
				OutOfAmmoTime = Player.Level.Timeseconds + 1.0;
		}
	}
}

// ----------------------------------------------------------------------
// GetTargetReticle()
// ----------------------------------------------------------------------

function GetTargetReticleColor( Actor target, out Color xcolor )
{
	local DeusExPlayer safePlayer;
	local AutoTurret turret;
	local bool bDM, bTeamDM;
	local Vector dist;
   local float SightDist;
	local DeusExWeapon w;
	local int team;
	local String titleString;

	bDM = (DeathMatchGame(player.DXGame) != None);
	bTeamDM = (TeamDMGame(player.DXGame) != None);

	if ( target.IsA('ScriptedPawn') )
	{
		if (ScriptedPawn(target).GetPawnAllianceType(Player) == ALLIANCE_Hostile)
			xcolor = colRed;
		else
			xcolor = colGreen;
	}
	else if ( Player.Level.NetMode != NM_Standalone )	// Only do the rest in multiplayer
	{
		if ( target.IsA('DeusExPlayer') && (target != player) )	// Other players IFF
		{
			if ( bTeamDM && (TeamDMGame(player.DXGame).ArePlayersAllied(DeusExPlayer(target),player)) )
			{
				xcolor = colGreen;
				if ( (Player.mpMsgFlags & Player.MPFLAG_FirstSpot) != Player.MPFLAG_FirstSpot )
					Player.MultiplayerNotifyMsg( Player.MPMSG_TeamSpot );
			}
			else
				xcolor = colRed;

         SightDist = VSize(target.Location - Player.Location);

			if ( ( bTeamDM && (TeamDMGame(player.DXGame).ArePlayersAllied(DeusExPlayer(target),player))) ||
				  (target.Style != STY_Translucent) || (bVisionActive && (Sightdist <= visionLevelvalue)) )
			{
				targetPlayerName = DeusExPlayer(target).PlayerReplicationInfo.PlayerName;
            // DEUS_EX AMSD Show health of enemies with the target active.
            if (bTargetActive)
               TargetPlayerHealthString = "(" $ int(100 * (DeusExPlayer(target).Health / Float(DeusExPlayer(target).Default.Health))) $ "%)";
				targetOutOfRange = False;
				w = DeusExWeapon(player.Weapon);
				if (( w != None ) && ( xcolor != colGreen ))
				{
					dist = player.Location - target.Location;
					if ( VSize(dist) > w.maxRange )
					{
						if (!(( WeaponAssaultGun(w) != None ) && ( Ammo20mm(WeaponAssaultGun(w).AmmoType) != None )))
						{
							targetRangeTime = Player.Level.Timeseconds + 0.1;
							targetOutOfRange = True;
						}
					}
				}
				targetPlayerTime = Player.Level.Timeseconds + targetPlayerDelay;
				targetPlayerColor = xcolor;
			}
			else
				xcolor = colWhite;	// cloaked enemy
		}
		else if (target.IsA('ThrownProjectile'))	// Grenades IFF
		{
			if ( ThrownProjectile(target).bDisabled )
				xcolor = colWhite;
			else if ( (bTeamDM && (ThrownProjectile(target).team == player.PlayerReplicationInfo.team)) ||
				(player == DeusExPlayer(target.Owner)) )
				xcolor = colGreen;
			else
				xcolor = colRed;
		}
		else if ( target.IsA('AutoTurret') || target.IsA('AutoTurretGun') ) // Autoturrets IFF
		{
			if ( target.IsA('AutoTurretGun') )
			{
				team = AutoTurretGun(target).team;
				titleString = AutoTurretGun(target).titleString;
			}
			else
			{
				team = AutoTurret(target).team;
				titleString = AutoTurret(target).titleString;
			}
			if ( (bTeamDM && (player.PlayerReplicationInfo.team == team)) ||
				  (!bTeamDM && (player.PlayerReplicationInfo.PlayerID == team)) )
				xcolor = colGreen;
			else if (team == -1)
				xcolor = colWhite;
			else
				xcolor = colRed;

			targetPlayerName = titleString;
			targetOutOfRange = False;
			targetPlayerTime = Player.Level.Timeseconds + targetPlayerDelay;
			targetPlayerColor = xcolor;
		}
		else if ( target.IsA('ComputerSecurity'))
		{
			if ( ComputerSecurity(target).team == -1 )
				xcolor = colWhite;
			else if ((bTeamDM && (ComputerSecurity(target).team==player.PlayerReplicationInfo.team)) ||
						 (bDM && (ComputerSecurity(target).team==player.PlayerReplicationInfo.PlayerID)))
				xcolor = colGreen;
			else
				xcolor = colRed;
		}
		else if ( target.IsA('SecurityCamera'))
		{
         if ( !SecurityCamera(target).bActive )
            xcolor = colWhite;
			else if ( SecurityCamera(target).team == -1 )
				xcolor = colWhite;
			else if ((bTeamDM && (SecurityCamera(target).team==player.PlayerReplicationInfo.team)) ||
						 (bDM && (SecurityCamera(target).team==player.PlayerReplicationInfo.PlayerID)))
				xcolor = colGreen;
			else
				xcolor = colRed;
		}
	}
}


// ----------------------------------------------------------------------
// DrawTargetAugmentation()
// ----------------------------------------------------------------------

function DrawTargetAugmentation(GC gc)
{
	local String str;
	local Actor target;
	local float boxCX, boxCY, boxTLX, boxTLY, boxBRX, boxBRY, boxW, boxH;
	local float x, y, w, h, mult;
	local Vector v1, v2;
	local int i, j, k;
	local DeusExWeapon weapon;
	local bool bUseOldTarget;
	local Color crossColor;
	local DeusExPlayer own;
	local vector AimLocation;
	local int AimBodyPart;


	gc.SetFont(Font'FontAugOverlay');//GC!!1

	crossColor.R = 255; crossColor.G = 255; crossColor.B = 255;

	// check 500 feet in front of the player
	target = TraceLOS(8000,AimLocation);

   targetplayerhealthstring = "";
   targetplayerlocationstring = "";

	if ( target != None )
	{
		//GetTargetReticleColor( target, crossColor );

		if ((DeusExPlayer(target) != None) && (bTargetActive))
		{
			AimBodyPart = DeusExPlayer(target).GetMPHitLocation(AimLocation);
			if (AimBodyPart == 1)
				TargetPlayerLocationString = "("$msgHead$")";
			else if ((AimBodyPart == 2) || (AimBodyPart == 5) || (AimBodyPart == 6))
				TargetPlayerLocationString = "("$msgTorso$")";
			else if ((AimBodyPart == 3) || (AimBodyPart == 4))
				TargetPlayerLocationString = "("$msgLegs$")";
		}

		weapon = DeusExWeapon(Player.Weapon);
		if ((weapon != None) && !weapon.bHandToHand && !bUseOldTarget)
		{
			// if the target is out of range, don't draw the reticle
			if (weapon.MaxRange >= VSize(target.Location - Player.Location))
			{
				w = width;
				h = height;
				x = int(w * 0.5)-1;
				y = int(h * 0.5)-1;

				// scale based on screen resolution - default is 640x480
				mult = FClamp(weapon.currentAccuracy * 80.0 * (width/640.0), corner, 80.0);

				// make sure it's not too close to the center unless you have a perfect accuracy
				mult = FMax(mult, corner+4.0);
				if (weapon.currentAccuracy == 0.0)
					mult = corner;

				// draw the drop shadowed reticle
				gc.SetTileColorRGB(0,0,0);
				for (i=1; i>=0; i--)
				{
					gc.DrawBox(x+i, y-mult+i, 1, corner, 0, 0, 1, Texture'Solid');
					gc.DrawBox(x+i, y+mult-corner+i, 1, corner, 0, 0, 1, Texture'Solid');
					gc.DrawBox(x-(corner-1)/2+i, y-mult+i, corner, 1, 0, 0, 1, Texture'Solid');
					gc.DrawBox(x-(corner-1)/2+i, y+mult+i, corner, 1, 0, 0, 1, Texture'Solid');

					gc.DrawBox(x-mult+i, y+i, corner, 1, 0, 0, 1, Texture'Solid');
					gc.DrawBox(x+mult-corner+i, y+i, corner, 1, 0, 0, 1, Texture'Solid');
					gc.DrawBox(x-mult+i, y-(corner-1)/2+i, 1, corner, 0, 0, 1, Texture'Solid');
					gc.DrawBox(x+mult+i, y-(corner-1)/2+i, 1, corner, 0, 0, 1, Texture'Solid');

					gc.SetTileColor(crossColor);
				}
			}
		}
		// movers are invalid targets for the aug
		if (target.IsA('DeusExMover'))
			target = None;
	}

	// let there be a 0.5 second delay before losing a target
	if (target == None)
	{
		if ((Player.Level.TimeSeconds - lastTargetTime < 0.5) && IsActorValid(lastTarget))//!!1
		{
			target = lastTarget;
			bUseOldTarget = True;
		}
		else
		{
			RemoveActorRef(lastTarget);
			lastTarget = None;
		}
	}
	else
	{
		lastTargetTime = Player.Level.TimeSeconds;
		bUseOldTarget = False;
		if (lastTarget != target)
		{
			RemoveActorRef(lastTarget);
			lastTarget = target;
			AddActorRef(lastTarget);
		}
	}

	if (target != None)
	{
		// draw a cornered targetting box
		v1.X = target.CollisionRadius;
		v1.Y = target.CollisionRadius;
		v1.Z = target.CollisionHeight;

		if (ConvertVectorToCoordinates(target.Location, boxCX, boxCY))
		{
			boxTLX = boxCX;
			boxTLY = boxCY;
			boxBRX = boxCX;
			boxBRY = boxCY;

			// get the smallest box to enclose actor
			// modified from Scott's ActorDisplayWindow
			for (i=-1; i<=1; i+=2)
			{
				for (j=-1; j<=1; j+=2)
				{
					for (k=-1; k<=1; k+=2)
					{
						v2 = v1;
						v2.X *= i;
						v2.Y *= j;
						v2.Z *= k;
						v2.X += target.Location.X;
						v2.Y += target.Location.Y;
						v2.Z += target.Location.Z;

						if (ConvertVectorToCoordinates(v2, x, y))
						{
							boxTLX = FMin(boxTLX, x);
							boxTLY = FMin(boxTLY, y);
							boxBRX = FMax(boxBRX, x);
							boxBRY = FMax(boxBRY, y);
						}
					}
				}
			}

			boxTLX = FClamp(boxTLX, margin, width-margin);
			boxTLY = FClamp(boxTLY, margin, height-margin);
			boxBRX = FClamp(boxBRX, margin, width-margin);
			boxBRY = FClamp(boxBRY, margin, height-margin);

			boxW = boxBRX - boxTLX;
			boxH = boxBRY - boxTLY;

			if ((bTargetActive) && (Player.Level.Netmode == NM_Standalone))
			{
				// set the coords of the zoom window, and draw the box
				// even if we don't have a zoom window
				x = width/8 + margin;
				y = height/2;
				w = width/4;
				h = height/4;

				DrawDropShadowBox(gc, x-w/2, y-h/2, w, h);

				boxCX = width/8 + margin;
				boxCY = height/2;
				boxTLX = boxCX - width/8;
				boxTLY = boxCY - height/8;
				boxBRX = boxCX + width/8;
				boxBRY = boxCY + height/8;

				if (targetLevel > 2)
				{
					if (winZoom != None)
					{
						mult = (target.CollisionRadius + target.CollisionHeight);
						v1 = Player.Location;
						v1.Z += Player.BaseEyeHeight;
						v2 = 1.5 * Player.Normal(target.Location - v1);
						winZoom.SetViewportLocation(target.Location - mult * v2);
						winZoom.SetWatchActor(target);
					}
					// window construction now happens in Tick()
				}
				else
				{
					// black out the zoom window and draw a "no image" message
					gc.SetStyle(DSTY_Normal);
					gc.SetTileColorRGB(0,0,0);
					gc.DrawPattern(boxTLX, boxTLY, w, h, 0, 0, Texture'Solid');

					gc.SetTextColorRGB(255,255,255);
					gc.GetTextExtent(0, w, h, msgNoImage);
					x = boxCX - w/2;
					y = boxCY - h/2;
					gc.DrawText(x, y, w, h, msgNoImage);
				}

				if (target.IsA('Pawn'))
					str = target.UnfamiliarName;//BindName

				if (target.IsA('Robot') && !target.bHidden && (Robot(target).EMPHitPoints == 0 || Robot(target).Orders == 'Idle' || Robot(target).Orders == 'Disabled'))
					str = str $ " (" $ msgDisabled $ ")";
					
				gc.SetFont(Font'FontAugOverlaySmall');
				gc.SetTextColor(crossColor);

				mult = VSize(target.Location - Player.Location);
				str = str $ CR() $ msgRange @ Int(mult/16) @ msgRangeUnits;

				gc.GetTextExtent(0, w, h, str);
				x = boxTLX + margin;
				y = boxTLY - h - margin;
				gc.DrawText(x, y, w, h, str);

				// level zero gives very basic health info
				if (target.IsA('Pawn'))
					mult = Float(Pawn(target).Health) / Float(Pawn(target).Default.Health);
				else
					mult = 1.0;

				if (targetLevel == 0)
				{
					// level zero only gives us general health readings
					if (mult >= 0.66)
					{
						str = msgHigh;
						mult = 1.0;
					}
					else if (mult >= 0.33)
					{
						str = msgMedium;
						mult = 0.5;
					}
					else
					{
						str = msgLow;
						mult = 0.05;
					}

					str = str @ msgHealth;
				}
				else
				{
					// level one gives exact health readings
					str = Int(mult * 100.0) $ msgPercent;
					if (target.IsA('Pawn') && !target.IsA('Robot') && !target.IsA('Animal'))
					{
						x = mult;		// save this for color calc
						str = str @ msgOverall;
						mult = Float(Pawn(target).HealthHead) / Float(Pawn(target).Default.HealthHead);
						str = str $ CR() $ Int(mult * 100.0) $ msgPercent @ msgHead;
						mult = Float(Pawn(target).HealthTorso) / Float(Pawn(target).Default.HealthTorso);
						str = str $ CR() $ Int(mult * 100.0) $ msgPercent @ msgTorso;
						mult = Float(Pawn(target).HealthArmLeft) / Float(Pawn(target).Default.HealthArmLeft);
						str = str $ CR() $ Int(mult * 100.0) $ msgPercent @ msgLeftArm;
						mult = Float(Pawn(target).HealthArmRight) / Float(Pawn(target).Default.HealthArmRight);
						str = str $ CR() $ Int(mult * 100.0) $ msgPercent @ msgRightArm;
						mult = Float(Pawn(target).HealthLegLeft) / Float(Pawn(target).Default.HealthLegLeft);
						str = str $ CR() $ Int(mult * 100.0) $ msgPercent @ msgLeftLeg;
						mult = Float(Pawn(target).HealthLegRight) / Float(Pawn(target).Default.HealthLegRight);
						str = str $ CR() $ Int(mult * 100.0) $ msgPercent @ msgRightLeg;
						mult = x;
					}
					else
					{
						str = str @ msgHealth;
					}
				}

				gc.GetTextExtent(0, w, h, str);
				x = boxTLX + margin;
				y = boxTLY + margin;
				gc.SetTextColor(GetColorScaled(mult));
				gc.DrawText(x, y, w, h, str);
				gc.SetTextColor(colHeaderText);

			}
			else
			{
				if (target.IsA('Robot') && !target.bHidden && ((Robot(target).EMPHitPoints <= 0) || (Robot(target).bNoEnergy) || Robot(target).Orders == 'Idle'))
				{
					str = msgDisabled;
					gc.SetFont(Font'FontAugOverlaySmall');
					gc.SetTextColor(crossColor);
					gc.GetTextExtent(0, w, h, str);
					x = boxCX - w/2;
					y = boxTLY - h - margin;
					gc.DrawText(x, y, w, h, str);
				}
			}
		}
	}
	else if ((bTargetActive) && (Player.Level.NetMode == NM_Standalone))
	{
		if (Player.Level.TimeSeconds % 1.5 > 0.75)
			str = msgScanning1;
		else
			str = msgScanning2;
		gc.GetTextExtent(0, w, h, str);
		x = width/2 - w/2;
		y = (height/2 - h) - 20;
		gc.DrawText(x, y, w, h, str);
	}

	// set the crosshair colors
	DeusExRootWindow(player.rootWindow).hud.cross.SetCrosshairColor(crossColor);
}

// ----------------------------------------------------------------------
// DrawVisionAugmentation()
// ----------------------------------------------------------------------
function DrawVisionAugmentation(GC gc)
{
	local Vector loc;
	local float boxCX, boxCY, boxTLX, boxTLY, boxBRX, boxBRY, boxW, boxH;
	local float dist, x, y, w, h;
	local float BrightDot;
	local Actor A;
	local float DrawGlow;
	local float RadianView;
	local float OldFlash, NewFlash;
	local vector OldFog, NewFog;
	local Texture oldSkins[9];
	local string labeltext;
	local HeatEffect MyHeat;
	local ScriptedPawn pawn;

	boxW = width/2;
	boxH = height/2;
	boxCX = width/2;
	boxCY = height/2;
	boxTLX = boxCX - boxW/2;
	boxTLY = boxCY - boxH/2;
	boxBRX = boxCX + boxW/2;
	boxBRY = boxCY + boxH/2;

	gc.SetFont(Font'FontAugOverlaySmall');//GC!!1

//Vision: green
/*if (visionLevel == 0)
{
	gc.SetStyle(DSTY_Modulated);
	gc.DrawPattern(0, 0, width, height, 0, 0, Texture'SolidGreen');
	gc.DrawPattern(0, 0, width, height, 0, 0, Texture'SolidGreen');
	gc.DrawPattern(0, 0, width, height, 0, 0, Texture'SolidGreen');
	gc.SetStyle(DSTY_Normal);

	if ((A != VisionBlinder) && (A.IsA('ExplosionLight')) && (Player.LineOfSightTo(A,True)))
	{
		BrightDot = Normal(Vector(Player.ViewRotation)) dot Normal(A.Location - Player.Location);
		dist = VSize(A.Location - Player.Location);
              
		if (dist > 3000)
			DrawGlow = 0;
		else if (dist < 300)
			DrawGlow = 1;
		else
			DrawGlow = ( 3000 - dist ) / ( 3000 - 300 );
              
		RadianView = (Player.FovAngle / 180) * 3.141593;
              
		if ((BrightDot >= Cos(RadianView)) && (DrawGlow > 0.2) && (BrightDot * DrawGlow * 0.9 > 0.2))
		{
			VisionBlinder = A;
			NewFlash = 10.0 * BrightDot * DrawGlow;
			NewFog = vect(1000,1000,900) * BrightDot * DrawGlow * 0.9;
			OldFlash = player.DesiredFlashScale;
			OldFog = player.DesiredFlashFog * 1000;
                  
			NewFlash = FMax(0,NewFlash - OldFlash);
			NewFog.X = FMax(0,NewFog.X - OldFog.X);
			NewFog.Y = FMax(0,NewFog.Y - OldFog.Y);
			NewFog.Z = FMax(0,NewFog.Z - OldFog.Z);
			player.ClientFlash(NewFlash,NewFog);
			player.IncreaseClientFlashLength(4.0*BrightDot*DrawGlow*BrightDot);
		}
	}
}*/
//Vision: blue
if (visionLevel == 0)
{
	gc.SetStyle(DSTY_Modulated);
	gc.DrawPattern(0, 0, width, height, 0, 0, Texture'GameMedia.UI.VisorWhite');
	gc.DrawPattern(0, 0, width, height, 0, 0, Texture'GameMedia.UI.VisorWhite');
	gc.DrawPattern(0, 0, width, height, 0, 0, Texture'VisionBlue');
	gc.DrawPattern(0, 0, width, height, 0, 0, Texture'VisionBlue');
	gc.SetStyle(DSTY_Normal);

	loc = Player.Location;
	loc.Z += Player.BaseEyeHeight;

	foreach Player.AllActors(class'Actor', A)
	{
		if (A.bVisionImportant)
		{
			if (IsHeatSource(A))
			{
				dist = VSize(A.Location - loc);

				//No looking through wall for level 0
				/*if ((dist <= (visionLevelValue)) && IsHeatSource(A))
				{           
					VisionTargetStatus = GetVisionTargetStatus(A);               
					SetSkins(A, oldSkins);
					gc.DrawActor(A, False, False, True, 1.0, 2.0, None);
					ResetSkins(A, oldSkins);
				}
				else */if (Player.LineOfSightTo(A,true))
				{
					VisionTargetStatus = GetVisionTargetStatus(A);               
					SetSkins(A, oldSkins);
                  
					if ((dist < VisionLevelValue * 1.5)/* || (VisionTargetStatus != VISIONENEMY)*/)
					{
						DrawGlow = 3.0;
					}
					else
					{
						// Fadeoff with distance square
						DrawGlow = 3.0 / ((dist / (VisionLevelValue * 1.5)) * (dist / (VisionLevelValue * 1.5)));
						// Don't make the actor harder to see than without the aug.
						//DrawGlow = FMax(DrawGlow,A.ScaleGlow);
						// Set a minimum.
						DrawGlow = FMax(DrawGlow,0.25);
					}   
               
					gc.DrawActor(A, False, False, True, 1.0, DrawGlow, None);
					ResetSkins(A, oldSkins);
				}
			}
			//Bling us
			else if ((A != VisionBlinder) && (A.IsA('ExplosionLight')) && (Player.LineOfSightTo(A,True)))
			{
				BrightDot = Normal(Vector(Player.ViewRotation)) dot Normal(A.Location - Player.Location);
				dist = VSize(A.Location - Player.Location);
               
				if (dist > 3000)
					DrawGlow = 0;
				else if (dist < 300)
					DrawGlow = 1;
				else
					DrawGlow = ( 3000 - dist ) / ( 3000 - 300 );
               
				RadianView = (Player.FovAngle / 180) * 3.141593;
               
				if ((BrightDot >= Cos(RadianView)) && (DrawGlow > 0.2) && (BrightDot * DrawGlow * 0.9 > 0.2))
				{
					VisionBlinder = A;
					NewFlash = 10.0 * BrightDot * DrawGlow;
					NewFog = vect(1000,1000,900) * BrightDot * DrawGlow * 0.9;
					OldFlash = player.DesiredFlashScale;
					OldFog = player.DesiredFlashFog * 1000;
                  
					NewFlash = FMax(0,NewFlash - OldFlash);
					NewFog.X = FMax(0,NewFog.X - OldFog.X);
					NewFog.Y = FMax(0,NewFog.Y - OldFog.Y);
					NewFog.Z = FMax(0,NewFog.Z - OldFog.Z);
					player.ClientFlash(NewFlash,NewFog);
					player.IncreaseClientFlashLength(4.0*BrightDot*DrawGlow*BrightDot);
				}
			}
		}
	}
}
//Vision: red
else if (visionLevel == 1)
{
	gc.SetStyle(DSTY_Modulated);
	gc.DrawPattern(0, 0, width, height, 0, 0, Texture'GameMedia.UI.VisorWhite');
	gc.DrawPattern(0, 0, width, height, 0, 0, Texture'GameMedia.UI.VisorWhite');

	gc.DrawPattern(0, 0, width, height, 0, 0, Texture'SolidRed');
	gc.DrawPattern(0, 0, width, height, 0, 0, Texture'SolidRed');

	//gc.DrawPattern(0, 0, width, height, 0, 0, Texture'GameMedia.UI.VisorLined');
	gc.SetStyle(DSTY_Normal);

	loc = Player.Location;
	loc.Z += Player.BaseEyeHeight;

	foreach Player.AllActors(class'Actor', A)
	{
		if (A.bVisionImportant)
		{
			if (IsHeatSource(A))
			{
				dist = VSize(A.Location - loc);

				//Look through walls
				if (dist <= visionLevelValue)
				{                        
					SetSkins(A, oldSkins);
					gc.DrawActor(A, False, False, True, 1.0, 2.0, None);
					ResetSkins(A, oldSkins);
				}
				else if (Player.LineOfSightTo(A,true))
				{             
					SetSkins(A, oldSkins);
                  
					if (dist < VisionLevelValue * 1.5)
					{
						DrawGlow = 3.0;
					}
					else
					{
						// Fadeoff with distance square
						DrawGlow = 3.0 / ((dist / (VisionLevelValue * 1.5)) * (dist / (VisionLevelValue * 1.5)));
						// Don't make the actor harder to see than without the aug.
						//DrawGlow = FMax(DrawGlow,A.ScaleGlow);
						// Set a minimum.
						DrawGlow = FMax(DrawGlow,0.15);
					}   
               
					gc.DrawActor(A, False, False, True, 1.0, DrawGlow, None);
					ResetSkins(A, oldSkins);
				}
			}
		}
	}
}

}

// ----------------------------------------------------------------------
// IsHeatSource()
// ----------------------------------------------------------------------

function bool IsHeatSource(Actor A)
{
	if (A.bHidden)
		return False;
		
	if (A.IsA('ScriptedPawn'))
	{
		if(visionLevel == 0 && (!ScriptedPawn(A).bCloakOn && !A.IsA('Robot') && !A.IsA('Greasel') && !A.IsA('Fishes') && !A.IsA('Fly') && !A.IsA('Karkian')))
			return True;
		else if(visionLevel == 1 && !A.IsA('Fly') && (A.IsA('Robot') || ScriptedPawn(A).GetStateName() != 'Idle'))
			return True;
	}
	else if((visionLevel == 1) && (A.IsA('SecurityCamera') || A.IsA('AutoTurretGun') || A.IsA('AutoTurret')
									 || A.IsA('AlarmUnit') || A.IsA('ElectronicDevices') 
									 || A.IsA('LaserTrigger') || A.IsA('BeamTrigger')
									 || A.IsA('GrenadeProjectile') || A.IsA('LaserProxy')
	))
		return True;
	else if (A.IsA('DeusExCarcass') && (!A.IsA('KarkianCarcass') && !A.IsA('GreaselCarcass') && !A.IsA('KarkianBabyCarcass')))
		return True;
	else if (A.IsA('FleshFragment'))
		return True;
	else if (A.IsA('Rocket'))
		return True;
	else
		return False;
}



// ----------------------------------------------------------------------
// SetSkins()
//
// copied from ActorDisplayWindow
// ----------------------------------------------------------------------

function SetSkins(Actor actor, out Texture oldSkins[9])
{
	local int     i;
	local texture curSkin;

	for (i=0; i<8; i++)
		oldSkins[i] = actor.MultiSkins[i];
	oldSkins[i] = actor.Skin;

	for (i=0; i<8; i++)
	{
		curSkin = actor.GetMeshTexture(i);
		actor.MultiSkins[i] = GetGridTexture(curSkin);
	}
	actor.Skin = GetGridTexture(oldSkins[i]);
}

// ----------------------------------------------------------------------
// ResetSkins()
//
// copied from ActorDisplayWindow
// ----------------------------------------------------------------------

function ResetSkins(Actor actor, Texture oldSkins[9])
{
	local int i;

	for (i=0; i<8; i++)
		actor.MultiSkins[i] = oldSkins[i];
	actor.Skin = oldSkins[i];
}

// ----------------------------------------------------------------------
// DrawDropShadowBox()
// ----------------------------------------------------------------------

function DrawDropShadowBox(GC gc, float x, float y, float w, float h)
{
	local Color oldColor;

	gc.GetTileColor(oldColor);
	gc.SetTileColorRGB(0,0,0);
	gc.DrawBox(x, y+h+1, w+2, 1, 0, 0, 1, Texture'Solid');
	gc.DrawBox(x+w+1, y, 1, h+2, 0, 0, 1, Texture'Solid');
	gc.SetTileColor(colBorder);
	gc.DrawBox(x-1, y-1, w+2, h+2, 0, 0, 1, Texture'Solid');
	gc.SetTileColor(oldColor);
}

// ----------------------------------------------------------------------
// GetGridTexture()
//
// modified from ActorDisplayWindow
// ----------------------------------------------------------------------

function Texture GetGridTexture(Texture tex)
{
	if (tex == None)
		return Texture'BlackMaskTex';
	else if (tex == Texture'BlackMaskTex')
		return Texture'BlackMaskTex';
	else if (tex == Texture'GrayMaskTex')
		return Texture'GrayMaskTex';
		//return Texture'BlackMaskTex';
	else if (tex == Texture'PinkMaskTex')
		return Texture'PinkMaskTex';
		//return Texture'BlackMaskTex';
	else if (/*VisionTargetStatus == VISIONENEMY && */visionLevel == 0){
		return FireTexture'GameEffects.HeatFireTexture';
	}
	/*else if (VisionTargetStatus == VISIONALLY && visionLevel == 0){
		return FireTexture'GameEffects.HeatFireTexture2';
	}*/
	else{
		if(visionLevel == 0)
			return Texture'BlackMaskTex';
		else if(visionLevel == 1)
			return FireTexture'GameEffects.HeatSoundTexture';
		else
			return Texture'BlackMaskTex';
	}
}

// ----------------------------------------------------------------------
// VisionTargetStatus()
// ----------------------------------------------------------------------

function int GetVisionTargetStatus(Actor Target)
{
	local DeusExPlayer PlayerTarget;
	local TeamDMGame TeamGame;

	if (Target == None)
		return VISIONNEUTRAL;

	if (target.IsA('Robot'))
		return VISIONALLY;
	else if ((target.IsA('ScriptedPawn') && !target.IsA('Robot')) || target.IsA('DeusExCarcass'))
		return VISIONENEMY;
	else
		return VISIONNEUTRAL;


/*
   if (target.IsA('DeusExPlayer'))
   {
      if (target == player)
         return VISIONNEUTRAL;

      TeamGame = TeamDMGame(player.DXGame);
      // In deathmatch, all players are hostile.
      if (TeamGame == None)
         return VISIONENEMY;

      PlayerTarget = DeusExPlayer(Target);

      if (TeamGame.ArePlayersAllied(PlayerTarget,Player))
         return VISIONALLY;
      else
         return VISIONENEMY;
   }
   else if ( (target.IsA('AutoTurretGun')) || (target.IsA('AutoTurret')) )
   {
      if (target.IsA('AutoTurretGun'))
         return GetVisionTargetStatus(target.Owner);
      else if ((AutoTurret(Target).bDisabled))
         return VISIONNEUTRAL;
      else if (AutoTurret(Target).safetarget == Player)
         return VISIONALLY;
      else if ((Player.DXGame.IsA('TeamDMGame')) && (AutoTurret(Target).team == -1))
         return VISIONNEUTRAL;
      else if ( (!Player.DXGame.IsA('TeamDMGame')) || (Player.PlayerReplicationInfo.Team != AutoTurret(Target).team) )
          return VISIONENEMY;
      else if (Player.PlayerReplicationInfo.Team == AutoTurret(Target).team)
         return VISIONALLY;
      else
         return VISIONNEUTRAL;
   }
   else if (target.IsA('SecurityCamera'))
   {
      if ( !SecurityCamera(target).bActive )
         return VISIONNEUTRAL;
      else if ( SecurityCamera(target).team == -1 )
         return VISIONNEUTRAL;
      else if (((Player.DXGame.IsA('TeamDMGame')) && (SecurityCamera(target).team==player.PlayerReplicationInfo.team)) ||
         ( (Player.DXGame.IsA('DeathMatchGame')) && (SecurityCamera(target).team==player.PlayerReplicationInfo.PlayerID)))
         return VISIONALLY;
      else
         return VISIONENEMY;
   }
   else
      return VISIONNEUTRAL;
*/
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     msgBotHealth="��������: "
     msgBotEnergy="�������: "
     margin=4.000000
     corner=9.000000
     msgRange="���������"
     msgRangeUnits="��"
     msgHigh="������"
     msgMedium="������"
     msgLow="�����"
     msgHealth="��������"
     msgOverall="�����"
     msgPercent="%"
     msgHead="������"
     msgTorso="����"
     msgLeftArm="� ����"
     msgRightArm="� ����"
     msgLeftLeg="� ����"
     msgRightLeg="� ����"
     msgLegs="����"
     msgWeapon="������:"
     msgNone="���"
     msgScanning1="* ��� ���� *"
     msgScanning2="* ������������ *"
     msgADSTracking="* ADS: ��������� *"
     msgADSDetonating="* ADS: ��������� *"
     msgBehind="�����"
     msgDroneActive="����-����� �������"
     msgEnergyLow="������������� ����������!"
     msgCantLaunch="������ - ��� ����� ��� ��������� �����!"
     msgLightAmpActive="����������� �������"
     msgIRAmpActive="����������� �������"
     msgNoImage="��� �����������"
     msgDisabled="��������"
     msgBotDanger="����������� ���������!"
     SpottedTeamString="You have spotted a teammate!"
     YouArePoisonedString="You have been poisoned!"
     YouAreBurnedString="You are burning!"
     TurretInvincibleString="Turrets are only affected by EMP damage!"
     CameraInvincibleString="Cameras are only affected by EMP damage!"
     NeutBurnPoisonString="(Use medkits to instantly neutralize)"
     OnlyString="Only "
     KillsToGoString=" more kills, and "
     KillToGoString=" more kill, and "
     LessThanMinuteString="Less than a minute to go, and "
     LessThanXString1="Less than "
     LessThanXString2=" minutes to go, and "
     LeadsMatchString=" leads the match!"
     TiedMatchString="it's a tied match!"
     WillWinMatchString=" will win the match!"
     OutOfRangeString="(Out of range)"
     LostLegsString="You've lost your legs!"
     DropItem1String="You can use <"
     DropItem2String="> to drop an equipped item."
     msgTeammateHit="You hit your teammate!"
     msgTeamNsf="You're on Team NSF!"
     msgTeamUnatco="You're on Team Unatco!"
     UseString="Use <"
     TeamTalkString="> to send team messages."
     TalkString="> to send regular chat messages."
     YouKilledTeammateString="You killed a teammate!"
     TeamLAMString="You cannot pickup your teammate's grenade!"
     TeamComputerString="That computer already belongs to your team!"
     NoCloakWeaponString="You cannot cloak while a weapon is drawn!"
     TeamHackTurretString="That turret already belongs to your team!"
     KeyNotBoundString="Key Not Bound"
     OutOfAmmoString="Out of Ammo!"
     colRed=(R=255)
     colGreen=(G=255)
     colWhite=(R=255,G=255,B=255)
     keyDisplayNames(0)=(inputKey=IK_LeftMouse,displayName="Left Mouse Button")
     keyDisplayNames(1)=(inputKey=IK_RightMouse,displayName="Right Mouse Button")
     keyDisplayNames(2)=(inputKey=IK_MiddleMouse,displayName="Middle Mouse Button")
     keyDisplayNames(3)=(inputKey=IK_CapsLock,displayName="CAPS Lock")
     keyDisplayNames(4)=(inputKey=IK_PageUp,displayName="Page Up")
     keyDisplayNames(5)=(inputKey=IK_PageDown,displayName="Page Down")
     keyDisplayNames(6)=(inputKey=IK_PrintScrn,displayName="Print Screen")
     keyDisplayNames(7)=(inputKey=IK_GreyStar,displayName="NumPad Asterisk")
     keyDisplayNames(8)=(inputKey=IK_GreyPlus,displayName="NumPad Plus")
     keyDisplayNames(9)=(inputKey=IK_GreyMinus,displayName="NumPad Minus")
     keyDisplayNames(10)=(inputKey=IK_GreySlash,displayName="NumPad Slash")
     keyDisplayNames(11)=(inputKey=IK_NumPadPeriod,displayName="NumPad Period")
     keyDisplayNames(12)=(inputKey=IK_NumLock,displayName="Num Lock")
     keyDisplayNames(13)=(inputKey=IK_ScrollLock,displayName="Scroll Lock")
     keyDisplayNames(14)=(inputKey=IK_LShift,displayName="Left Shift")
     keyDisplayNames(15)=(inputKey=IK_RShift,displayName="Right Shift")
     keyDisplayNames(16)=(inputKey=IK_LControl,displayName="Left Control")
     keyDisplayNames(17)=(inputKey=IK_RControl,displayName="Right Control")
     keyDisplayNames(18)=(inputKey=IK_MouseWheelUp,displayName="Mouse Wheel Up")
     keyDisplayNames(19)=(inputKey=IK_MouseWheelDown,displayName="Mouse Wheel Down")
     keyDisplayNames(20)=(inputKey=IK_MouseX,displayName="Mouse X")
     keyDisplayNames(21)=(inputKey=IK_MouseY,displayName="Mouse Y")
     keyDisplayNames(22)=(inputKey=IK_MouseZ,displayName="Mouse Z")
     keyDisplayNames(23)=(inputKey=IK_MouseW,displayName="Mouse W")
     keyDisplayNames(24)=(inputKey=IK_LeftBracket,displayName="Left Bracket")
     keyDisplayNames(25)=(inputKey=IK_RightBracket,displayName="Right Bracket")
     keyDisplayNames(26)=(inputKey=IK_SingleQuote,displayName="Single Quote")
     keyDisplayNames(27)=(inputKey=IK_Joy1,displayName="Joystick Button 1")
     keyDisplayNames(28)=(inputKey=IK_Joy2,displayName="Joystick Button 2")
     keyDisplayNames(29)=(inputKey=IK_Joy3,displayName="Joystick Button 3")
     keyDisplayNames(30)=(inputKey=IK_Joy4,displayName="Joystick Button 4")
     keyDisplayNames(31)=(inputKey=IK_JoyX,displayName="Joystick X")
     keyDisplayNames(32)=(inputKey=IK_JoyY,displayName="Joystick Y")
     keyDisplayNames(33)=(inputKey=IK_JoyZ,displayName="Joystick Z")
     keyDisplayNames(34)=(inputKey=IK_JoyR,displayName="Joystick R")
     keyDisplayNames(35)=(inputKey=IK_JoyU,displayName="Joystick U")
     keyDisplayNames(36)=(inputKey=IK_JoyV,displayName="Joystick V")
     keyDisplayNames(37)=(inputKey=IK_JoyPovUp,displayName="Joystick Pov Up")
     keyDisplayNames(38)=(inputKey=IK_JoyPovDown,displayName="Joystick Pov Down")
     keyDisplayNames(39)=(inputKey=IK_JoyPovLeft,displayName="Joystick Pov Left")
     keyDisplayNames(40)=(inputKey=IK_JoyPovRight,displayName="Joystick Pov Right")
     keyDisplayNames(41)=(inputKey=IK_Ctrl,displayName="Control")
     keyDisplayNames(42)=(inputKey=IK_Left,displayName="Left Arrow")
     keyDisplayNames(43)=(inputKey=IK_Right,displayName="Right Arrow")
     keyDisplayNames(44)=(inputKey=IK_Up,displayName="Up Arrow")
     keyDisplayNames(45)=(inputKey=IK_Down,displayName="Down Arrow")
     keyDisplayNames(46)=(inputKey=IK_Insert,displayName="Insert")
     keyDisplayNames(47)=(inputKey=IK_Home,displayName="Home")
     keyDisplayNames(48)=(inputKey=IK_Delete,displayName="Delete")
     keyDisplayNames(49)=(inputKey=IK_End,displayName="End")
     keyDisplayNames(50)=(inputKey=IK_NumPad0,displayName="NumPad 0")
     keyDisplayNames(51)=(inputKey=IK_NumPad1,displayName="NumPad 1")
     keyDisplayNames(52)=(inputKey=IK_NumPad2,displayName="NumPad 2")
     keyDisplayNames(53)=(inputKey=IK_NumPad3,displayName="NumPad 3")
     keyDisplayNames(54)=(inputKey=IK_NumPad4,displayName="NumPad 4")
     keyDisplayNames(55)=(inputKey=IK_NumPad5,displayName="NumPad 5")
     keyDisplayNames(56)=(inputKey=IK_NumPad6,displayName="NumPad 6")
     keyDisplayNames(57)=(inputKey=IK_NumPad7,displayName="NumPad 7")
     keyDisplayNames(58)=(inputKey=IK_NumPad8,displayName="NumPad 8")
     keyDisplayNames(59)=(inputKey=IK_NumPad9,displayName="NumPad 9")
     keyDisplayNames(60)=(inputKey=IK_Period,displayName="Period")
     keyDisplayNames(61)=(inputKey=IK_Comma,displayName="Comma")
     keyDisplayNames(62)=(inputKey=IK_Backslash,displayName="Backslash")
     keyDisplayNames(63)=(inputKey=IK_Semicolon,displayName="Semicolon")
     keyDisplayNames(64)=(inputKey=IK_Equals,displayName="Equals")
     keyDisplayNames(65)=(inputKey=IK_Slash,displayName="Slash")
     keyDisplayNames(66)=(inputKey=IK_Enter,displayName="Enter")
     keyDisplayNames(67)=(inputKey=IK_Alt,displayName="Alt")
     keyDisplayNames(68)=(inputKey=IK_Backspace,displayName="Backspace")
     keyDisplayNames(69)=(inputKey=IK_Shift,displayName="Shift")
     keyDisplayNames(70)=(inputKey=IK_Space,displayName="Space")
     AliasNames(0)="ParseLeftClick|Fire"
     AliasNames(1)="ParseRightClick"
     AliasNames(2)="DropItem"
     AliasNames(3)="MoveForward"
     AliasNames(4)="MoveBackward"
     AliasNames(5)="StrafeLeft"
     AliasNames(6)="StrafeRight"
     AliasNames(7)="LeanLeft"
     AliasNames(8)="LeanRight"
     AliasNames(9)="Jump"
     AliasNames(10)="Duck"
     AliasNames(11)="Walking"
     AliasNames(12)="NextBeltItem"
     AliasNames(13)="PrevBeltItem"
     AliasNames(14)="ScopeIn"
     AliasNames(15)="ScopeOut"
     AliasNames(16)="ReloadWeapon"
}
