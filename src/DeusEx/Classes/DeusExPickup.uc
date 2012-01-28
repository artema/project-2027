//=============================================================================
// DeusExPickup.
//=============================================================================
class DeusExPickup extends Pickup
	abstract;

#exec obj load file="..\2027\Textures\GameEffects.utx" package=GameEffects

var bool            bBreakable;		// true if we can destroy this item
var class<Fragment> fragType;		// fragments created when pickup is destroyed
var int				maxCopies;		// 0 means unlimited copies

var localized String CountLabel;
var localized String msgTooMany;

var texture NormalPlayerViewSkins[10];
var texture CamoPlayerViewSkins[10];
var bool bItemInvisible;

var() bool bNewSkin;
var() bool bPlayerViewSkinned;
var() texture PlayerViewSkins[8];

// ----------------------------------------------------------------------
// Networking Replication
// ----------------------------------------------------------------------

replication
{
   //client to server function
   reliable if ((Role < ROLE_Authority) && (bNetOwner))
      UseOnce;
}

// ----------------------------------------------------------------------
// HandlePickupQuery()
//
// If the bCanHaveMultipleCopies variable is set to True, then we want
// to stack items of this type in the player's inventory.
// ----------------------------------------------------------------------

function bool HandlePickupQuery( inventory Item )
{
	local DeusExPlayer player;
	local Inventory anItem;
	local Bool bAlreadyHas;
	local Bool bResult;

	if ( Item.Class == Class )
	{
		player = DeusExPlayer(Owner);
		bResult = False;

		// Check to see if the player already has one of these in 
		// his inventory
		anItem = player.FindInventoryType(Item.Class);

		if ((anItem != None) && (bCanHaveMultipleCopies))
		{
			// don't actually put it in the hand, just add it to the count
			NumCopies += DeusExPickup(item).NumCopies;

			if ((MaxCopies > 0) && (NumCopies > MaxCopies))
			{
				NumCopies -= DeusExPickup(item).NumCopies;
				player.ClientMessage(msgTooMany);

				// abort the pickup
				return True;
			}
			bResult = True;
		}

		if (bResult)
		{
			if(Item.itemArticle != "" && Item.itemArticle != " " && DeusExPlayer(GetPlayerPawn()).bShowItemArticles)
				player.ClientMessage(Item.PickupMessage @ Item.itemArticle @ Item.itemName, 'Pickup');
			else
				player.ClientMessage(Item.PickupMessage @ Item.itemName, 'Pickup');

			// Destroy me!
         // DEUS_EX AMSD In multiplayer, we don't want to destroy the item, we want it to set to respawn
         if (Level.NetMode != NM_Standalone)
            Item.SetRespawn();
         else			
            Item.Destroy();
		}
		else
		{
			bResult = MyHandlePickupQuery(Item);
		}

		// Update object belt text
		if (bResult)			
			UpdateBeltText();	

		return bResult;
	}

	if ( Inventory == None )
		return false;

	return Inventory.HandlePickupQuery(Item);
}

function bool MyHandlePickupQuery( inventory Item )
{
	if (item.class == class) 
	{
		if (bCanHaveMultipleCopies) 
		{
			NumCopies++;
			if (Level.Game.LocalLog != None)
				Level.Game.LocalLog.LogPickup(Item, Pawn(Owner));
			if (Level.Game.WorldLog != None)
				Level.Game.WorldLog.LogPickup(Item, Pawn(Owner));
			if ( Item.PickupMessageClass == None )
			{
				if(item.itemArticle != "" && item.itemArticle != " " && DeusExPlayer(GetPlayerPawn()).bShowItemArticles)
					Pawn(Owner).ClientMessage(item.PickupMessage @ item.itemArticle @ item.itemName, 'Pickup');
				else
					Pawn(Owner).ClientMessage(item.PickupMessage @ item.itemName, 'Pickup');
			}
			else
				Pawn(Owner).ReceiveLocalizedMessage( item.PickupMessageClass, 0, None, None, item.Class );
				
			Item.PlaySound (Item.PickupSound,,2.0);
			Item.SetRespawn();
		}
		else if ( bDisplayableInv ) 
			return false;

		return true;				
	}
	if ( Inventory == None )
		return false;

	return Inventory.HandlePickupQuery(Item);
}

function String GetHumanName()
{
	if(itemArticle != "" && itemArticle != " " && DeusExPlayer(GetPlayerPawn()).bShowItemArticles)
		return ItemArticle @ ItemName;
	else
		return ItemName;
}

// ----------------------------------------------------------------------
// UseOnce()
//
// Subtract a use, then destroy if out of uses
// ----------------------------------------------------------------------

function UseOnce()
{
	local DeusExPlayer player;

	player = DeusExPlayer(Owner);
	NumCopies--;

	if (!IsA('SkilledTool'))
		GotoState('DeActivated');

	if (NumCopies <= 0)
	{
		if (player.inHand == Self)
			player.PutInHand(None);
		Destroy();
	}
	else
	{
		UpdateBeltText();
	}
}

// ----------------------------------------------------------------------
// UpdateBeltText()
// ----------------------------------------------------------------------

function UpdateBeltText()
{
	local DeusExRootWindow root;

	if (DeusExPlayer(Owner) != None)
	{
		root = DeusExRootWindow(DeusExPlayer(Owner).rootWindow);

		// Update object belt text
		if ((bInObjectBelt) && (root != None) && (root.hud != None) && (root.hud.belt != None))
			root.hud.belt.UpdateObjectText(beltPos);
	}
}

// ----------------------------------------------------------------------
// BreakItSmashIt()
// ----------------------------------------------------------------------

simulated function BreakItSmashIt(class<fragment> FragType, float size) 
{
	local int i;
	local DeusExFragment s;

	for (i=0; i<Int(size); i++) 
	{
		s = DeusExFragment(Spawn(FragType, Owner));
		if (s != None)
		{
			s.Instigator = Instigator;
			s.CalcVelocity(Velocity,0);
			s.DrawScale = ((FRand() * 0.05) + 0.05) * size;
			s.Skin = GetMeshTexture();

			// play a good breaking sound for the first fragment
			if (i == 0)
				s.PlaySound(sound'GlassBreakSmall', SLOT_None,,, 768);
		}
	}

	Destroy();
}

singular function BaseChange()
{
	Super.BaseChange();

	// Make sure we fall if we don't have a base
	if ((base == None) && (Owner == None))
		SetPhysics(PHYS_Falling);
}

// ----------------------------------------------------------------------
// state Pickup
// ----------------------------------------------------------------------

auto state Pickup
{
	// if we hit the ground fast enough, break it, smash it!!!
	function Landed(Vector HitNormal)
	{
		Super.Landed(HitNormal);

		if (bBreakable)
			if (VSize(Velocity) > 400)
				BreakItSmashIt(fragType, (CollisionRadius + CollisionHeight) / 2);
	}
	
	function Frob(Actor Other, Inventory frobWith)
	{
		// If touched by a player pawn, let him pick this up.
		if( ValidTouch(Other) )
		{
			if (Level.Game.LocalLog != None)
				Level.Game.LocalLog.LogPickup(Self, Pawn(Other));
			if (Level.Game.WorldLog != None)
				Level.Game.WorldLog.LogPickup(Self, Pawn(Other));
				
			SpawnCopy(Pawn(Other));
			
			if ( PickupMessageClass == None )
			{
				if(itemArticle != "" && itemArticle != " " && DeusExPlayer(GetPlayerPawn()).bShowItemArticles)
					Pawn(Other).ClientMessage(PickupMessage @ itemArticle @ itemName, 'Pickup');
				else
					Pawn(Other).ClientMessage(PickupMessage @ itemName, 'Pickup');
			}
			else
				Pawn(Other).ReceiveLocalizedMessage( PickupMessageClass, 0, None, None, Self.Class );
			PlaySound (PickupSound);		
			if ( Level.Game.Difficulty > 1 )
				Other.MakeNoise(0.1 * Level.Game.Difficulty);
			if ( Pawn(Other).MoveTarget == self )
				Pawn(Other).MoveTimer = -1.0;		
		}
		else if ( bTossedOut && (Other.Class == Class)
				&& Inventory(Other).bTossedOut )
				Destroy();
	}
}

state DeActivated
{
}

// ----------------------------------------------------------------------
// UpdateInfo()
// ----------------------------------------------------------------------

simulated function bool UpdateInfo(Object winObject)
{
	local PersonaInfoWindow winInfo;
	local string str;

	winInfo = PersonaInfoWindow(winObject);
	if (winInfo == None)
		return False;

	winInfo.SetTitle(itemName);
	winInfo.SetText(Description $ winInfo.CR() $ winInfo.CR());

	if (bCanHaveMultipleCopies)
	{
		// Print the number of copies
		str = CountLabel @ String(NumCopies);
		winInfo.AppendText(str);
	}

	return True;
}

// ----------------------------------------------------------------------
// PlayLandingSound()
// ----------------------------------------------------------------------

function PlayLandingSound()
{
	if (LandSound != None)
	{
		if (Velocity.Z <= -200)
		{
			PlaySound(LandSound, SLOT_None, TransientSoundVolume,, 768, DeusExPlayer(GetPlayerPawn()).GetSoundPitchMultiplier());
			AISendEvent('LoudNoise', EAITYPE_Audio, TransientSoundVolume, 768);
		}
	}
}


// ----------------------------------------------------------------------
// ----------------------------------------------------------------------



function ShowCamo()
{
	local int     i;
	local texture curSkin;

	if(!bItemInvisible)
	{
		bItemInvisible = True;
		
		for (i=0; i<8; i++)
			NormalPlayerViewSkins[i] = MultiSkins[i];
			
		NormalPlayerViewSkins[8] = Skin;
		NormalPlayerViewSkins[9] = Texture;
	
		for (i=0; i<8; i++)
		{
			curSkin = GetMeshTexture(i);
			CamoPlayerViewSkins[i] = GetGridTexture(curSkin);
		}
		
		CamoPlayerViewSkins[8] = GetGridTexture(NormalPlayerViewSkins[8]);
		CamoPlayerViewSkins[9] = GetGridTexture(NormalPlayerViewSkins[9]);
		
		for (i=0; i<8; i++)
			MultiSkins[i] = CamoPlayerViewSkins[i];
	
		Skin = CamoPlayerViewSkins[8];
		Texture = CamoPlayerViewSkins[9];
		
		Style = STY_Translucent;
	}
}

function HideCamo()
{
	local int i;

	if(bItemInvisible)
	{
		for (i=0; i<8; i++)
			MultiSkins[i] = NormalPlayerViewSkins[i];
			
		Skin = NormalPlayerViewSkins[8];
		Texture = NormalPlayerViewSkins[9];
		
		Style = Default.Style;
		
		bItemInvisible = False;
	}
}

function Texture GetGridTexture(Texture tex)
{
	if (tex == None)
		return Texture'BlackMaskTex';
	else if (tex == Texture'BlackMaskTex')
		return Texture'BlackMaskTex';
	else if (tex == Texture'GrayMaskTex')
		return Texture'BlackMaskTex';
	else if (tex == Texture'PinkMaskTex')
		return Texture'BlackMaskTex';
	else
		return FireTexture'GameEffects.InvisibleTex';
}

simulated function Tick(float deltaTime)
{
	Super.Tick(deltaTime);
}

function BecomePickup()
{
	local int i;
	
	bPlayerViewSkinned = False;
	
	super.BecomePickup();
	
	for (i=0; i<8; i++) MultiSkins[i] = Default.MultiSkins[i];
}

function BecomeItem()
{
	local int i;

	bPlayerViewSkinned = True;

	super.BecomeItem();

	if(bNewSkin)
		for(i=0;i<8;i++)
			MultiSkins[i]=PlayerViewSkins[i];
}

simulated event RenderOverlays(canvas Canvas)
{
	local int i;
	
	if ( Owner == None )
		return;
	if ( (Level.NetMode == NM_Client) && (!Owner.IsA('PlayerPawn') || (PlayerPawn(Owner).Player == None)) )
		return;
	
	if ( DeusExPlayer(Owner) == None )
		return;
		
	SetLocation( Owner.Location + CalcDrawOffset() );
	SetRotation( Pawn(Owner).ViewRotation );
	
	if(!bItemInvisible && bNewSkin && bPlayerViewSkinned)
	{
		for (i=0; i<8; i++) MultiSkins[i] = PlayerViewSkins[i];
	}
	
	Canvas.DrawActor(self, false);
	
	if(!bItemInvisible && bNewSkin && bPlayerViewSkinned)
	{
		for (i=0; i<8; i++) MultiSkins[i] = Default.MultiSkins[i];
	}
}

defaultproperties
{
     FragType=Class'DeusEx.GlassFragment'
     NumCopies=1
     ItemName="DEFAULT PICKUP NAME - REPORT THIS AS A BUG"
     RespawnTime=30.000000
     LandSound=Sound'DeusExSounds.Generic.PaperHit1'
}
