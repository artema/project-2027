//=============================================================================
// DeusExAmmo.
//=============================================================================
class DeusExAmmo extends Ammo
	abstract;

var localized String msgInfoRounds;
var() mesh        RealMesh1;
var() mesh        RealMesh2;
var() mesh        RealMesh3;
var bool bIsNonStandard;

// True if this ammo can be displayed in the Inventory screen
// by clicking on the "Ammo" button.

var bool bShowInfo;
var int MPMaxAmmo; //Max Ammo in multiplayer.

var() bool bCannotBePickedUp;

var travel bool bExistenceSet;

// ----------------------------------------------------------------------
// PostBeginPlay()
// ----------------------------------------------------------------------
function PostBeginPlay()
{
	Super.PostBeginPlay();
   if (Level.NetMode != NM_Standalone)
   {   
      if (MPMaxAmmo == 0)      
         MPMaxAmmo = AmmoAmount * 3;
      MaxAmmo = MPMaxAmmo;
   }
}

// ----------------------------------------------------------------------
// UpdateInfo()
// ----------------------------------------------------------------------

simulated function bool UpdateInfo(Object winObject)
{
	local PersonaInfoWindow winInfo;

	winInfo = PersonaInfoWindow(winObject);
	if (winInfo == None)
		return False;

	winInfo.SetTitle(itemName);
	winInfo.SetText(Description $ winInfo.CR() $ winInfo.CR());

	// number of rounds left
	winInfo.AppendText(Sprintf(msgInfoRounds, AmmoAmount));

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
			PlaySound(LandSound, SLOT_None, TransientSoundVolume,, 768);
			AISendEvent('LoudNoise', EAITYPE_Audio, TransientSoundVolume, 768);
		}
	}
}

simulated function CalcVelocity(vector Momentum, float ExplosionSize)
{
	Velocity = VRand()*(ExplosionSize+FRand()*150.0+100.0 + VSize(Momentum)/80); 
}

function bool HandlePickupQuery( inventory Item )
{
	if ( (class == item.class) || 
		(ClassIsChildOf(item.class, class'Ammo') && (class == Ammo(item).parentammo)) ) 
	{
		if (AmmoAmount==MaxAmmo) return true;
		if (Level.Game.LocalLog != None)
			Level.Game.LocalLog.LogPickup(Item, Pawn(Owner));
		if (Level.Game.WorldLog != None)
			Level.Game.WorldLog.LogPickup(Item, Pawn(Owner));
		if (Item.PickupMessageClass == None)
		{
			if(Item.itemArticle != "" && Item.itemArticle != " " && DeusExPlayer(GetPlayerPawn()).bShowItemArticles)
				Pawn(Owner).ClientMessage( Item.PickupMessage @ Item.itemArticle @ Item.ItemName, 'Pickup' );
			else
				Pawn(Owner).ClientMessage( Item.PickupMessage @ Item.ItemName, 'Pickup' );
		}
		else
			Pawn(Owner).ReceiveLocalizedMessage( Item.PickupMessageClass, 0, None, None, item.Class );
		item.PlaySound( item.PickupSound );
		AddAmmo(Ammo(item).AmmoAmount);
		item.SetRespawn();
		return true;				
	}
	if ( Inventory == None )
		return false;

	return Inventory.HandlePickupQuery(Item);
}

function String GetHumanName()
{
	if(itemArticle != "" && itemArticle != " " && DeusExPlayer(GetPlayerPawn()).bShowItemArticles)
		return ItemArticle@ItemName;
	else
		return ItemName;
}

auto state Pickup
{
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

simulated function Tick(float deltaTime)
{
      Super.Tick(deltaTime);

	if(!bExistenceSet)
	{
		if(Owner == None)
		{
			if(GetPlayerPawn() != None)
			{
				bExistenceSet = True;
				
				UpdateCount();
				
				if(!UpdateExistence())
					Destroy();
				else
					bHidden = False;
			}
		}
		else
		{
			bExistenceSet = True;
			bHidden = False;
		}
	}
}

function UpdateCount()
{
	
}

function bool UpdateExistence()
{
	return True;
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
	 bHidden=True
     bIsNonStandard=False
     RealMesh1=LodMesh'DeusExItems.TestBox'
     RealMesh2=LodMesh'DeusExItems.TestBox'
     RealMesh3=LodMesh'DeusExItems.TestBox'
     msgInfoRounds="%d Rounds remaining"
     bDisplayableInv=False
     ItemName="DEFAULT AMMO NAME - REPORT THIS AS A BUG"
     LandSound=Sound'DeusExSounds.Generic.PaperHit1'
}
