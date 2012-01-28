//=============================================================================
// DeusExHUD.
//=============================================================================
class DeusExHUD expands Window;

var Crosshair						cross;
var TimerDisplay					timer;
var FrobDisplayWindow				frobDisplay;
var DamageHUDDisplay				damageDisplay;
var AugmentationDisplayWindow		augDisplay;

// NEW STUFF!
var HUDStatsDisplay status;
var HUDHitDisplay					hit;
var HUDCompassDisplay               compass;
var HUDAmmoDisplay					ammo;
var HUDObjectBelt					belt;
var HUDInformationDisplay           info;
var HUDBookWindow           		info2;
var HUDInfoLinkDisplay				infolink;
var HUDLogDisplay					msgLog;
var HUDConWindowFirst				conWindow;
var HUDMissionStartTextDisplay      startDisplay;
var HUDActiveItemsDisplay			activeItems;
var HUDBarkDisplay					barkDisplay;
var HUDReceivedDisplay				receivedItems;

var HUDMultiSkills					hms;

var HUDBox							hbox;
var HUDRPGDisplay					rpgstat;

// ----------------------------------------------------------------------
// InitWindow()
// ----------------------------------------------------------------------

event InitWindow()
{
	local DeusExRootWindow root;
	local DeusExPlayer player;

	Super.InitWindow();

	// Get a pointer to the root window
	root = DeusExRootWindow(GetRootWindow());

	// Get a pointer to the player
	player = DeusExPlayer(root.parentPawn);

	SetFont(Font'TechMedium');
	SetSensitivity(false);

	ammo			= HUDAmmoDisplay(NewChild(Class'HUDAmmoDisplay'));
	hit				= HUDHitDisplay(NewChild(Class'HUDHitDisplay'));
	cross			= Crosshair(NewChild(Class'Crosshair'));
	belt			= HUDObjectBelt(NewChild(Class'HUDObjectBelt'));
	activeItems		= HUDActiveItemsDisplay(NewChild(Class'HUDActiveItemsDisplay'));
	damageDisplay	= DamageHUDDisplay(NewChild(Class'DamageHUDDisplay'));
	compass     	= HUDCompassDisplay(NewChild(Class'HUDCompassDisplay'));
	hbox				= HUDBox(NewChild(Class'HUDBox'));
rpgstat = HUDRPGDisplay(NewChild(Class'HUDRPGDisplay'));
	hms				= HUDMultiSkills(NewChild(Class'HUDMultiSkills'));

	// Create the InformationWindow
	info = HUDInformationDisplay(NewChild(Class'HUDInformationDisplay', False));
	info2 = HUDBookWindow(NewChild(Class'HUDBookWindow', False));

	// Create the log window
	msgLog	= HUDLogDisplay(NewChild(Class'HUDLogDisplay', False));
	msgLog.SetLogTimeout(player.GetLogTimeout());

	frobDisplay = FrobDisplayWindow(NewChild(Class'FrobDisplayWindow'));
	frobDisplay.SetWindowAlignments(HALIGN_Full, VALIGN_Full);

	augDisplay	= AugmentationDisplayWindow(NewChild(Class'AugmentationDisplayWindow'));
	augDisplay.SetWindowAlignments(HALIGN_Full, VALIGN_Full);

	startDisplay = HUDMissionStartTextDisplay(NewChild(Class'HUDMissionStartTextDisplay', False));
//	startDisplay.SetWindowAlignments(HALIGN_Full, VALIGN_Full);

	// Bark display
	barkDisplay = HUDBarkDisplay(NewChild(Class'HUDBarkDisplay', False));

	// Received Items Display
	receivedItems = HUDReceivedDisplay(NewChild(Class'HUDReceivedDisplay', False));
}

// ----------------------------------------------------------------------
// DescendantRemoved()
// ----------------------------------------------------------------------
	
event DescendantRemoved(Window descendant)
{
	if      (descendant == ammo)
		ammo  = None;
	else if (descendant == hit)
		hit   = None;
	else if (descendant == cross)
		cross = None;
	else if (descendant == belt)
		belt  = None;
	else if (descendant == activeItems)
		activeItems = None;
	else if (descendant == damageDisplay)
		damageDisplay = None;
	else if (descendant == infolink)
		infolink = None;
	else if (descendant == timer)
		timer = None;
	else if (descendant == msgLog)
		msgLog = None;
	else if (descendant == info)
		info = None;
	else if (descendant == info2)
		info2 = None;
	else if (descendant == hbox)
		hbox = None;
	else if ( descendant == rpgstat )
		rpgstat = None;
	else if (descendant == conWindow)
		conWindow = None;
	else if (descendant == frobDisplay)
		frobDisplay = None;
	else if (descendant == augDisplay)
		augDisplay = None;
	else if (descendant == compass)
		compass = None;
	else if (descendant == startDisplay)
		startDisplay = None;
	else if (descendant == barkDisplay)
		barkDisplay = None;
	else if (descendant == receivedItems)
		receivedItems = None;
	else if ( descendant == hms )
		hms = None;
//	else if ( descendant == status )
//		status = None;
}

// ----------------------------------------------------------------------
// ConfigurationChanged()
// ----------------------------------------------------------------------

function ConfigurationChanged()
{
	local float hboxWidth, hboxHeight;
	local float qWidth, qHeight;
	local float compassWidth, compassHeight;
	local float statusWidth, statusHeight;
	local float beltWidth, beltHeight;
	local float ammoWidth, ammoHeight;
	local float hitWidth, hitHeight;
	local float infoX, infoY, infoTop, infoBottom;
	local float infoWidth, infoHeight, maxInfoWidth, maxInfoHeight;
	local float info2X, info2Y, info2Top, info2Bottom;
	local float info2Width, info2Height, maxInfo2Width, maxInfo2Height;
	local float itemsWidth, itemsHeight;
	local float damageWidth, damageHeight;
	local float conHeight;
	local float barkWidth, barkHeight;
	local float recWidth, recHeight, recPosY;
	local float logTop;

	local float goodwidth, goodheight;

	goodwidth = width;
	goodheight = height;

	if (hbox != None)
	{
		if (hbox.IsVisible())
		{
                        hboxWidth = goodwidth;
                        hboxHeight = goodheight;
			hbox.QueryPreferredSize(hboxWidth, hboxHeight);
			hbox.ConfigureChild(0, 0, goodwidth, goodheight);
		}
	}

	if (ammo != None)
	{
		if (ammo.IsVisible())
		{
			ammo.QueryPreferredSize(ammoWidth, ammoHeight);
			ammo.ConfigureChild(0, goodheight-ammoHeight, ammoWidth, ammoHeight);
		}
		else
		{
			ammoWidth  = 0;
			ammoHeight = 0;
		}
	}

	if (hit != None)
	{
		if (hit.IsVisible())
		{
			hit.QueryPreferredSize(hitWidth, hitHeight);
			hit.ConfigureChild(0, 0, hitWidth, hitHeight);
		}
	}

	if (rpgstat != None)
	{
		if (rpgstat.IsVisible())
		{
			rpgstat.QueryPreferredSize(statusWidth, statusHeight);
			rpgstat.ConfigureChild(0, hitHeight + 1, statusWidth, statusHeight);

			if (hitWidth == 0)
				hitWidth = statusWidth;
		}
	}

	if (compass != None)
	{
		compass.QueryPreferredSize(compassWidth, compassHeight);
		compass.ConfigureChild(0, hitHeight + statusHeight + 1, compassWidth, compassHeight);

		//if (hitWidth == 0)
		//	hitWidth = compassWidth;
	}

	if (cross != None)
	{
		cross.QueryPreferredSize(qWidth, qHeight);
		cross.ConfigureChild((goodwidth-qWidth)*0.5+0.5, (goodheight-qHeight)*0.5+0.5, qWidth, qHeight);
	}
	if (belt != None)
	{
		belt.QueryPreferredSize(beltWidth, beltHeight);
		belt.ConfigureChild(goodwidth - beltWidth, goodheight - beltHeight, beltWidth, beltHeight);

		infoBottom = goodheight - beltHeight;
		info2Bottom = goodheight - beltHeight;
	}
	else
	{
		infoBottom = goodheight;
		info2Bottom = goodheight;
	}

	// Damage display
	//
	// Left side, under the compass

	if (damageDisplay != None)
	{
		// Doesn't check to see if it might bump into the Hit Display 
		damageDisplay.QueryPreferredSize(damageWidth, damageHeight);
		damageDisplay.ConfigureChild(0, hitHeight + compassHeight + 4, damageWidth, damageHeight);
	}

	// Active Items, includes Augmentations and various charged Items
	// 
	// Upper right corner

	if (activeItems != None)
	{
		itemsWidth = activeItems.QueryPreferredWidth(height - beltHeight);
		activeItems.ConfigureChild(goodwidth - itemsWidth, 0, itemsWidth, goodheight - beltHeight);
	}

	// Display the Log in the upper-left corner, to the right of
	// the hit display.

	if (msgLog != None)
	{
		qHeight = msgLog.QueryPreferredHeight(goodwidth - hitWidth - itemsWidth - 40);
		msgLog.ConfigureChild(hitWidth + 20, 10, width - hitWidth - itemsWidth - 40, qHeight);

		if (msgLog.IsVisible())
			logTop = max(max(infoTop, 10 + qHeight), max(info2Top, 10 + qHeight));
	}
	
	// Display the infolink to the right of the hit display
	// and underneath the Log window if it's visible.

	if (infolink != None)
	{
		infolink.QueryPreferredSize(qWidth, qHeight);

		if ((msgLog != None) && (msgLog.IsVisible()))
			infolink.ConfigureChild(hitWidth + 20, msgLog.Height + 20, qWidth, qHeight);
		else
			infolink.ConfigureChild(hitWidth + 20, 0, qWidth, qHeight);

		if (infolink.IsVisible()){
			infoTop = max(infoTop, 10 + qHeight);
			info2Top = max(info2Top, 10 + qHeight);
		}
	}

	// First-person conversation window

	if (conWindow != None)
	{
		qWidth  = Min(goodwidth - 100, 800);
		conHeight = conWindow.QueryPreferredHeight(qWidth);

		// Stick it above the belt
		conWindow.ConfigureChild((width / 2) - (qwidth / 2), (max(infoBottom, info2Bottom) - conHeight) - 20, qWidth, conHeight);
	}

	// Bark Display.  Position where first-person convo window would
	// go, or above it if the first-person convo is visible
	if (barkDisplay != None)
	{
		qWidth = Min(goodwidth - 100, 800);
		barkHeight = barkDisplay.QueryPreferredHeight(qWidth);

		barkDisplay.ConfigureChild(
			(goodwidth / 2) - (qwidth / 2), (max(infoBottom, info2Bottom) - barkHeight - conHeight) - 20, 
			qWidth, barkHeight);
	}

	// Received Items display
	// 
	// Stick below the crosshair, but above any bark/convo windows that might 
	// be visible.

	if (receivedItems != None)
	{
		receivedItems.QueryPreferredSize(recWidth, recHeight);

		recPosY = (height / 2) + 20;

		if ((barkDisplay != None) && (barkDisplay.IsVisible()))
			recPosY -= barkHeight;
		if ((conWindow != None) && (conWindow.IsVisible()))
			recPosY -= conHeight;

		receivedItems.ConfigureChild(
			(goodwidth / 2) - (recWidth / 2), recPosY,
			recWidth, recHeight);
	}

	// Display the timer above the object belt if it's visible

	if (timer != None)
	{
		timer.QueryPreferredSize(qWidth, qHeight);

		if ((belt != None) && (belt.IsVisible()))
			timer.ConfigureChild(goodwidth-qWidth, goodheight-qHeight-beltHeight-10, qWidth, qHeight);
		else
			timer.ConfigureChild(goodwidth-qWidth, goodheight-qHeight, qWidth, qHeight);
	}

	// Mission Start Text
	if (startDisplay != None)
	{
		// Stick this baby right in the middle of the screen.
		startDisplay.QueryPreferredSize(qWidth, qHeight);
//		startDisplay.ConfigureChild(10, ammoHeight + 120, qWidth, qHeight);
		startDisplay.ConfigureChild(10, goodheight - beltHeight - 210, qWidth, qHeight);
	}

	// Display the Info Window sandwiched between all the other windows.  :)
	if ((info != None) && (info.IsVisible(False)))
	{
		// Must redo these formulas
		maxInfoWidth  = Min(goodwidth - 170, 800);
		maxInfoHeight = (infoBottom - infoTop) - 20;

		info.QueryPreferredSize(infoWidth, infoHeight);

		if (infoWidth > maxInfoWidth)
		{
			infoHeight = info.QueryPreferredHeight(maxInfoWidth);
			infoWidth  = maxInfoWidth;
		}

		infoX = (goodwidth / 2) - (infoWidth / 2);
		infoY = infoTop + (((infoBottom - infoTop) / 2) - (infoHeight / 2)) + 10;

		info.ConfigureChild(infoX, infoY, infoWidth, infoHeight);
	}

	// Display the Info Window sandwiched between all the other windows.  :)
	if ((info2 != None) && (info2.IsVisible(False)))
	{
		// Must redo these formulas
		maxInfo2Width  = Min(goodwidth - 170, 800);
		maxInfo2Height = (info2Bottom - info2Top) - 20;

		info2.QueryPreferredSize(info2Width, info2Height);

		if (info2Width > maxInfo2Width)
		{
			info2Height = info2.QueryPreferredHeight(maxInfo2Width);
			info2Width  = maxInfo2Width;
		}

		info2X = (goodwidth / 2) - (info2Width / 2);
		info2Y = info2Top + (((info2Bottom - info2Top) / 2) - (info2Height / 2)) + 10;

		info2.ConfigureChild(info2X, info2Y, info2Width, info2Height);
	}
}

// ----------------------------------------------------------------------
// ChildRequestedReconfiguration()
// ----------------------------------------------------------------------

function bool ChildRequestedReconfiguration(window child)
{
	ConfigurationChanged();

	return TRUE;
}

// ----------------------------------------------------------------------
// ChildRequestedVisibilityChange()
// ----------------------------------------------------------------------

function ChildRequestedVisibilityChange(window child, bool bNewVisibility)
{
	child.SetChildVisibility(bNewVisibility);

	ConfigurationChanged();
}

// ----------------------------------------------------------------------
// CreateInfoLinkWindow()
//
// Creates the InfoLink window used to display messages.  If a 
// InfoLink window already exists, then return None.  If the Log window
// is visible, it hides it.
// ----------------------------------------------------------------------

function HUDInfoLinkDisplay CreateInfoLinkWindow()
{
	if ( infolink != None )
		return None;

	infolink = HUDInfoLinkDisplay(NewChild(Class'HUDInfoLinkDisplay'));

	// Hide Log window
	if ( msgLog != None )
		msgLog.Hide();

	infolink.AskParentForReconfigure();

	return infolink;
}

// ----------------------------------------------------------------------
// DestroyInfoLinkWindow()
// ----------------------------------------------------------------------

function DestroyInfoLinkWindow()
{
	if ( infoLink != None )
	{
		infoLink.Destroy();

		// If the msgLog window was visible, show it again
		if (( msgLog != None ) && ( msgLog.MessagesWaiting() ))
			msgLog.Show();
	}
}

// ----------------------------------------------------------------------
// CreateConWindowFirst()
// ----------------------------------------------------------------------

function HUDConWindowFirst CreateConWindowFirst()
{
	local DeusExRootWindow root;

	// Get a pointer to the root window
	root = DeusExRootWindow(GetRootWindow());

	conWindow = HUDConWindowFirst(NewChild(Class'HUDConWindowFirst', False));
	conWindow.AskParentForReconfigure();

	return conWindow;
}

// ----------------------------------------------------------------------
// VisibilityChanged()
//
// Used to display Log messages that were received while the HUD
// wasn't visible
// ----------------------------------------------------------------------

event VisibilityChanged(bool bNewVisibility)
{
	Super.VisibilityChanged( bNewVisibility );

	if (( msgLog != None ) && ( bNewVisibility ))
	{
		if (( infoLink == None ) && ( msgLog.MessagesWaiting() ))
			msgLog.Show();
	}
}

// ----------------------------------------------------------------------
// CreateTimerWindow()
//
// Creates the Timer window used to display countdowns.  If a 
// Timer window already exists, then return None.
// ----------------------------------------------------------------------

function TimerDisplay CreateTimerWindow()
{
	if ( timer != None )
		return None;

	timer = TimerDisplay(NewChild(Class'TimerDisplay'));
	timer.AskParentForReconfigure();

	return timer;
}

// ----------------------------------------------------------------------
// ShowInfoWindow()
// ----------------------------------------------------------------------
function HUDInformationDisplay ShowInfoWindow()
{
	if (info != None)
		info.Show();

	return info;
}

function HUDBookWindow ShowInfo2Window()
{
	if (info2 != None)
		info2.Show();

	return info2;
}

// ----------------------------------------------------------------------
// UpdateSettings()
//
// Show/Hide these items as dictated by settings in DeusExPlayer (until 
// DeusExHUD can be serialized)
// ----------------------------------------------------------------------

function UpdateSettings( DeusExPlayer player )
{
	belt.SetVisibility(player.bObjectBeltVisible);
	hbox.SetVisibility(player.bHUDBoxVisible);
	hit.SetVisibility(player.bHitDisplayVisible);
	ammo.SetVisibility(player.bAmmoDisplayVisible);
	activeItems.SetVisibility(player.bAugDisplayVisible);
	damageDisplay.SetVisibility(player.bHitDisplayVisible);
	compass.SetVisibility(player.bCompassVisible);
	cross.SetCrosshair(player.bCrosshairVisible && !player.bSpyDroneActive);
	//rpgstat.SetVisibility(player.bRPGStatVisible);
	rpgstat.SetVisibility(false);
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
}
