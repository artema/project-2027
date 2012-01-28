class HUDCarcassWindow extends DeusExBaseWindow;

var bool bFirstFrameDone;

var DeusExCarcass carcassOwner;	

var HUDCarcassButton btnKeys[8];

var HUDCarcassStatusWindow winStatus;
var PersonaButtonBarWindow winActionButtons;
var PersonaActionButtonWindow btnPick;
var PersonaActionButtonWindow btnExit;

var Texture texBackground;
var Texture texBorder;

var bool bBorderTranslucent;
var bool bBackgroundTranslucent;
var bool bDrawBorder;

var Color colBackground;
var Color colBorder;
var Color colHeaderText;

var localized String PickButtonLabel;
var localized String ExitButtonLabel;

// ----------------------------------------------------------------------
// InitWindow()
//
// Initialize the Window
// ----------------------------------------------------------------------

event InitWindow()
{
	Super.InitWindow();

	SetWindowAlignments(HALIGN_Center, VALIGN_Center);
	SetSize(233, 200);
	SetMouseFocusMode(MFocus_EnterLeave);
	
	CreateStatusWindow();
	CreateButtons();

	bTickEnabled = True;

	StyleChanged();
}

// ----------------------------------------------------------------------
// DestroyWindow()
//
// Destroys the Window
// ----------------------------------------------------------------------

event DestroyWindow()
{
	Super.DestroyWindow();

	DeusExPlayer(GetPlayerPawn()).bInCarcassMenu = False;

	carcassOwner.carcasswindow = None;
	carcassOwner = None;
}

// ----------------------------------------------------------------------
// InitData()
// 
// Do the post-InitWindow stuff
// ----------------------------------------------------------------------

function InitData()
{
	CreateInventoryButtons();
	
	DeusExPlayer(GetPlayerPawn()).bInCarcassMenu = True;
}

// ----------------------------------------------------------------------
// Tick()
// ----------------------------------------------------------------------

function Tick(float deltaTime)
{
	if (!bFirstFrameDone)
	{
		SetCursorPos(width, height);
		bFirstFrameDone = True;
	}
}

function CreateStatusWindow()
{
	winStatus = HUDCarcassStatusWindow(NewChild(Class'HUDCarcassStatusWindow'));
	winStatus.SetPos(18, 135);
}

function CreateButtons()
{
	winActionButtons = PersonaButtonBarWindow(NewChild(Class'PersonaButtonBarWindow'));
	winActionButtons.SetPos(16, 166);
	winActionButtons.SetWidth(206);

	btnExit = PersonaActionButtonWindow(winActionButtons.NewChild(Class'PersonaActionButtonWindow'));
	btnExit.SetButtonText(ExitButtonLabel);

	btnPick = PersonaActionButtonWindow(winActionButtons.NewChild(Class'PersonaActionButtonWindow'));
	btnPick.SetButtonText(PickButtonLabel);
}

// ----------------------------------------------------------------------
// DrawWindow()
// 
// DrawWindow event (called every frame)
// ----------------------------------------------------------------------

event DrawWindow(GC gc)
{
	DrawBackground(gc);
	DrawBorder(gc);

	Super.DrawWindow(gc);
}

// ----------------------------------------------------------------------
// DrawBackground()
// ----------------------------------------------------------------------

function DrawBackground(GC gc)
{
	if (bBackgroundTranslucent)
		gc.SetStyle(DSTY_Translucent);
	else
		gc.SetStyle(DSTY_Masked);
	
	gc.SetTileColor(colBackground);

	gc.DrawTexture(0, 0, width, height, 0, 0, texBackground);
}

// ----------------------------------------------------------------------
// DrawBorder()
// ----------------------------------------------------------------------

function DrawBorder(GC gc)
{
	if (bDrawBorder)
	{
		if (bBorderTranslucent)
			gc.SetStyle(DSTY_Translucent);
		else
			gc.SetStyle(DSTY_Masked);
		
		gc.SetTileColor(colBorder);

		gc.DrawTexture(0, 0, width, height, 0, 0, texBorder);
	}
}

function Texture IndexToIcon(int index)
{
	local Inventory item;
	
	item = IndexToItem(index);	
	if(item != None && IsValidPickup(item)) return item.Icon;
}

function String IndexToTitle(int index)
{
	local Inventory item;
	
	item = IndexToItem(index);	
	if(item != None && IsValidPickup(item)) return item.beltDescription;
}

function Inventory IndexToItem(int index)
{
	local Inventory item, nextItem, startItem;
	local int i;
	
	i=0;
	
	if (carcassOwner != None && carcassOwner.Inventory != None)
	{
		item = carcassOwner.Inventory;
		startItem = item;
		
		do
		{
			if(i == index)
			{
				if(item != None && IsValidPickup(item))	return item;
				else return None;
			}
			
			i++;
			item = item.Inventory;
		}
		until (item == None || item == startItem);
	}
}

// ----------------------------------------------------------------------
// CreateInventoryButtons()
// ----------------------------------------------------------------------

function CreateInventoryButtons()
{
	local int i,j,k;
	local Inventory item;

	j=0;k=0;

	for (i=0; i<8; i++)
	{
		item = IndexToItem(i);
		
		btnKeys[i] = HUDCarcassButton(NewChild(Class'HUDCarcassButton'));
		btnKeys[i].SetPos((j * (50 + 2)) + 16, (k * (56 + 2)) + 19);
		btnKeys[i].num = i;			
		
		if(item == None && IsValidPickup(item)) btnKeys[i].SetSensitivity(False);
		
		j++;
		if(i == 3){
			 k++;
			 j=0;
		}
	}
}

// ----------------------------------------------------------------------
// ButtonActivated()
// ----------------------------------------------------------------------

function bool ButtonActivated( Window buttonPressed )
{
	local bool bHandled;
	local int i;

	bHandled = False;

	for (i=0; i<8; i++)
	{
		if (buttonPressed == btnKeys[i])
		{
			PressButton(btnKeys[i].num);
			bHandled = True;
			break;
		}
	}

	if(!bHandled)
	{
		switch( buttonPressed )
		{
			case btnPick:
				PickUpCorpse();
				bHandled = True;
				break;
				
			case btnExit:
				CloseScreen();
				bHandled = True;
				break;
		}		
	}

	if (!bHandled) bHandled = Super.ButtonActivated(buttonPressed);
	return bHandled;
}

function PickUpCorpse()
{
	if(player.inHand != None)
	{
		player.PlaySound(Sound'DeusExSounds.Generic.Beep3', SLOT_None);
		player.ClientMessage(player.HandsFull);
		AddLog(player.HandsFull);
		return;
	}
	
	if(carcassOwner.PickUpCorpse(player))
	{
		root.PopWindow();
	}
}

function CloseScreen()
{
	root.PopWindow();	
}

// ----------------------------------------------------------------------
// PressButton()
//
// User pressed a keypad button
// ----------------------------------------------------------------------

function PressButton(int num)
{
	local Inventory item;
	local String errorMsg;
	
	item = IndexToItem(num);
	errorMsg = "";
	
	if(item != None && IsValidPickup(item))
	{
		if(PickupItem(item, errorMsg))
		{
			player.PlaySound(Sound'DeusExSounds.Generic.WeaponPickup', SLOT_None);
		}
		else
		{
			if(errorMsg != "")
			{
				player.PlaySound(Sound'DeusExSounds.Generic.Beep3', SLOT_None);
				player.ClientMessage(errorMsg);
				AddLog(errorMsg);
			}
		}
	}
}

function AddLog(String logText)
{
	if (winStatus != None)
		winStatus.AddText(logText);
}

// ----------------------------------------------------------------------
// StyleChanged()
// ----------------------------------------------------------------------

event StyleChanged()
{
	local ColorTheme theme;

	theme = player.ThemeManager.GetCurrentHUDColorTheme();

	colBackground = theme.GetColorFromName('HUDColor_Background');
	colBorder     = theme.GetColorFromName('HUDColor_Borders');
	colHeaderText = theme.GetColorFromName('HUDColor_HeaderText');

	bBorderTranslucent     = player.GetHUDBorderTranslucency();
	bBackgroundTranslucent = player.GetHUDBackgroundTranslucency();
	bDrawBorder            = player.GetHUDBordersVisible();
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

function bool IsValidPickup(Inventory item)
{
	if(item == None) return False;

	if(item.IsA('DeusExAmmo') && DeusExAmmo(item).bCannotBePickedUp) return False;
	if(item.IsA('DeusExWeapon') && DeusExWeapon(item).bCannotBePickedUp) return False;
	
	return True;
	
	//return False;
}

function bool PickupItem(Inventory item, optional out String errorMsg)
{
	local DeusExWeapon W;
	local DeusExPickup invItem;
	local bool bSuccess;
	local int itemCount;
	local Actor prevTarget;
	local Ammo AmmoType;
	
	errorMsg = "";
	
	if(item != None && player != None) 
	{
		if (item.IsA('NanoKey'))
		{
			player.PickupNanoKey(NanoKey(item));
			carcassOwner.AddReceivedItem(player, item, 1);
			carcassOwner.DeleteInventory(item);
			item.Destroy();
			bSuccess = True;
		}
		else if (item.IsA('Credits'))
		{
			carcassOwner.AddReceivedItem(player, item, Credits(item).numCredits);
			player.Credits += Credits(item).numCredits;
			player.ClientMessage(Sprintf(Credits(item).msgCreditsAdded, Credits(item).numCredits));
			carcassOwner.DeleteInventory(item);
			item.Destroy();
			bSuccess = True;
		}
		else if(item.IsA('DeusExAmmo'))
		{
			itemCount = 0;
			
			if(DeusExAmmo(item).bIsNonStandard)
			{
				itemCount = DeusExAmmo(item).AmmoAmount;
			}
			else
			{
				if(item.IsA('RAmmo10mm')) itemCount = 10 + Rand(5);
				else if(item.IsA('RAmmo556mm')) itemCount = 10 + Rand(15);
				else if(item.IsA('RAmmo762mm')) itemCount = 10 + Rand(15);
				else if(item.IsA('RAmmoShell')) itemCount = 5 + Rand(5);
				else if(item.IsA('RAmmo3006')) itemCount = 3 + Rand(3);
				else if(item.IsA('RAmmoRocket')) itemCount = 2 + Rand(2);
				else if(item.IsA('RAmmoGas')) itemCount = 40 + Rand(60);
				else if(item.IsA('RAmmoBattery')) itemCount = 5 + Rand(5);
				else if(item.IsA('RAmmoDartPoison')) itemCount = 5 + Rand(5);
				else if(item.IsA('RAmmoPepper')) itemCount = 50 + Rand(50);
				else itemCount = 7 + Rand(13);
			}

			if(FRand() <= DeusExPlayer(GetPlayerPawn()).GetBadLuck())
				itemCount /= 2;

			if(itemCount < 1) itemCount = 1;

			if(player.FindInventoryType(item.Class) != None)
			{
	  			if(DeusExAmmo(player.FindInventoryType(item.Class)).AddAmmo(itemCount))
	  			{
					carcassOwner.AddReceivedItem(player, item, 1);
					player.UpdateAmmoBeltText(Ammo(item));
					
					if(item.itemArticle != "" && item.itemArticle != " " && DeusExPlayer(GetPlayerPawn()).bShowItemArticles)
						player.ClientMessage(item.PickupMessage @ item.itemArticle @ item.itemName, 'Pickup');
					else
						player.ClientMessage(item.PickupMessage @ item.itemName, 'Pickup');
						
					carcassOwner.DeleteInventory(item);
					item.Destroy();
					bSuccess = True;
	  			}
	  			else
	  			{
	  				errorMsg = player.TooMuchAmmo;
	  			}
			}
			else
			{		
				prevTarget = player.FrobTarget;
				player.FrobTarget = item;
				
				carcassOwner.DeleteInventory(item);
				
				DeusExAmmo(item).AmmoAmount = itemCount;
				
				if(player.HandleItemPickup(item, False, errorMsg))
				{
					item.bInObjectBelt=False;
			        item.BeltPos=-1;
					item.SpawnCopy(player);					
							
					carcassOwner.AddReceivedItem(player, item, 1);
					player.UpdateAmmoBeltText(Ammo(item));
					
					if(item.itemArticle != "" && item.itemArticle != " " && DeusExPlayer(GetPlayerPawn()).bShowItemArticles)
						player.ClientMessage(item.PickupMessage @ item.itemArticle @ item.itemName, 'Pickup');
					else
						player.ClientMessage(item.PickupMessage @ item.itemName, 'Pickup');	
							
					bSuccess = True;
				}
				
				player.FrobTarget = prevTarget;
			}
		}
		else if(item.IsA('DeusExWeapon'))
		{
			if (DeusExWeapon(item).bIsGrenade || DeusExWeapon(item).bHasSpecialAmmo)
			{
				W = DeusExWeapon(player.FindInventoryType(item.Class));
				
				if (W != None)
				{
					AmmoType = Ammo(player.FindInventoryType(DeusExWeapon(item).AmmoName));
	
	                if ((AmmoType != None) && (AmmoType.AmmoAmount < AmmoType.MaxAmmo))
					{
						AmmoType = Ammo(player.FindInventoryType(W.Default.AmmoName));
						Weapon(item).PickupAmmoCount = Rand(W.Default.PickupAmmoCount);
	                    AmmoType.AddAmmo(W.PickupAmmoCount);
	
						if (AmmoType.PickupViewMesh == Mesh'TestBox')
							carcassOwner.AddReceivedItem(player, item, Weapon(item).PickupAmmoCount);
						else
			                carcassOwner.AddReceivedItem(player, AmmoType, Weapon(item).PickupAmmoCount);
	
						player.UpdateAmmoBeltText(AmmoType);
	
						if (AmmoType.PickupViewMesh == Mesh'TestBox')
						{
							if(item.itemArticle != "" && item.itemArticle != " " && DeusExPlayer(GetPlayerPawn()).bShowItemArticles)
								player.ClientMessage(item.PickupMessage @ item.itemArticle @ item.itemName, 'Pickup');
							else
								player.ClientMessage(item.PickupMessage @ item.itemName, 'Pickup');
						}
						else
						{
							if(AmmoType.itemArticle != "" && AmmoType.itemArticle != " " && DeusExPlayer(GetPlayerPawn()).bShowItemArticles)
								player.ClientMessage(AmmoType.PickupMessage @ AmmoType.itemArticle @ AmmoType.itemName, 'Pickup');
							else
								player.ClientMessage(AmmoType.PickupMessage @ AmmoType.itemName, 'Pickup');
						}
	
						Weapon(item).AmmoType.AmmoAmount = 0;
						
						carcassOwner.DeleteInventory(item);
						item.Destroy();
						bSuccess = True;
					}
					else
					{
						errorMsg = player.TooMuchAmmo;
					}
				}
				else
				{
					if (player.FindInventorySlot(item, True))
					{
						prevTarget = player.FrobTarget;
						player.FrobTarget = item;
						
						carcassOwner.DeleteInventory(item);
						
						if(player.HandleItemPickup(item, False, errorMsg))
						{
							carcassOwner.AddReceivedItem(player, item, 1);							
							
							if(item.itemArticle != "" && item.itemArticle != " " && DeusExPlayer(GetPlayerPawn()).bShowItemArticles)
								player.ClientMessage(item.PickupMessage @ item.itemArticle @ item.itemName, 'Pickup');
							else
								player.ClientMessage(item.PickupMessage @ item.itemName, 'Pickup');
							
		                    item.bInObjectBelt=False;
		                    item.BeltPos=-1;
							item.SpawnCopy(player);
							bSuccess = True;
						}
						
						player.FrobTarget = prevTarget;
					}
					else
					{
						errorMsg = Sprintf(player.InventoryFull, item.itemName);
					}
				}
			}
			else
			{
				if(player.FindInventoryType(item.Class) != None) //Already has this weapon
				{
					errorMsg = Sprintf(player.CanCarryOnlyOne, item.itemName);
				}
				else
				{
					if(player.FindInventorySlot(item, True))
					{
						prevTarget = player.FrobTarget;
						player.FrobTarget = item;
						
						carcassOwner.DeleteInventory(item);
						
						if(player.HandleItemPickup(item, False, errorMsg))
						{
							carcassOwner.AddReceivedItem(player, item, 1);							
							
							if(item.itemArticle != "" && item.itemArticle != " " && DeusExPlayer(GetPlayerPawn()).bShowItemArticles)
								player.ClientMessage(item.PickupMessage @ item.itemArticle @ item.itemName, 'Pickup');
							else
								player.ClientMessage(item.PickupMessage @ item.itemName, 'Pickup');
							
		                    item.bInObjectBelt=False;
		                    item.BeltPos=-1;
							item.SpawnCopy(player);
							bSuccess = True;
						}
						
						player.FrobTarget = prevTarget;
					}
					else
					{
						errorMsg = Sprintf(player.InventoryFull, item.itemName);
					}
				}
			}
		}
		else if (item.IsA('DeusExPickup') && DeusExPickup(item).bCanHaveMultipleCopies && player.FindInventoryType(item.class) != None)
		{
			invItem = DeusExPickup(player.FindInventoryType(item.class));
			itemCount = DeusExPickup(item).numCopies;
			
			// Make sure the player doesn't have too many copies
			if ((invItem.MaxCopies > 0) && (DeusExPickup(item).numCopies + invItem.numCopies > invItem.MaxCopies))
			{	
				// Give the player the max #
				if ((invItem.MaxCopies - invItem.numCopies) > 0)
				{
					itemCount = (invItem.MaxCopies - invItem.numCopies);
					DeusExPickup(item).numCopies -= itemCount;
					invItem.numCopies = invItem.MaxCopies;
					
					if(invItem.itemArticle != "" && invItem.itemArticle != " " && DeusExPlayer(GetPlayerPawn()).bShowItemArticles)
						player.ClientMessage(invItem.PickupMessage @ invItem.itemArticle @ invItem.itemName, 'Pickup');
					else
						player.ClientMessage(invItem.PickupMessage @ invItem.itemName, 'Pickup');
						
					carcassOwner.AddReceivedItem(player, invItem, itemCount);
					bSuccess = True;
				}
				else
				{
					errorMsg = Sprintf(carcassOwner.msgCannotPickup, invItem.itemName);
				}
			}
			else
			{
				invItem.numCopies += itemCount;
				carcassOwner.DeleteInventory(item);
				
				if(invItem.itemArticle != "" && invItem.itemArticle != " " && DeusExPlayer(GetPlayerPawn()).bShowItemArticles)
					player.ClientMessage(invItem.PickupMessage @ invItem.itemArticle @ invItem.itemName, 'Pickup');
				else
					player.ClientMessage(invItem.PickupMessage @ invItem.itemName, 'Pickup');	
				
				carcassOwner.AddReceivedItem(player, invItem, itemCount);
				bSuccess = True;
			}
		}
		else
		{
			player.FrobTarget = item;
			if (player.HandleItemPickup(item, False, errorMsg) != False)
			{
				carcassOwner.DeleteInventory(item);
				item.bInObjectBelt=False;
				item.BeltPos=-1;
				item.SpawnCopy(player);
				carcassOwner.AddReceivedItem(player, item, 1);
				
				if(Item.itemArticle != "" && Item.itemArticle != " " && DeusExPlayer(GetPlayerPawn()).bShowItemArticles)
					player.ClientMessage(Item.PickupMessage @ Item.itemArticle @ Item.itemName, 'Pickup');
				else
					player.ClientMessage(Item.PickupMessage @ Item.itemName, 'Pickup');
					
				bSuccess = True;
			}
		}
	}

	return bSuccess;
}

defaultproperties
{
     texBackground=Texture'GameMedia.UI.HUDCarcassBackground'
     texBorder=Texture'GameMedia.UI.HUDCarcassBorder'
}
