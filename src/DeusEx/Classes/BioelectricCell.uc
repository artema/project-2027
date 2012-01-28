//=============================================================================
// BioelectricCell.
//=============================================================================
class BioelectricCell extends DeusExPickup;

var int rechargeAmount;
var int mpRechargeAmount;

var localized String msgRecharged;
var localized String msgCharged;
var localized String RechargesLabel;

var() float ChargeModifier;
var localized string DragToUse;

var() Sound ChargeSound;

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();

	// If this is a netgame, then override defaults
	if ( Level.NetMode != NM_StandAlone )
		MaxCopies = 5;
}

function PostBeginPlay()
{
   Super.PostBeginPlay();
   if (Level.NetMode != NM_Standalone)
      rechargeAmount = mpRechargeAmount;
}

state Activated
{
	function Activate()
	{
		// can't turn it off
	}

	function BeginState()
	{
		local DeusExPlayer player;
		local int chargecount;

		Super.BeginState();

		player = DeusExPlayer(Owner);
		if (player != None)
		{
			player.PlaySound(ChargeSound, SLOT_None,,, 256);

			chargecount = GetRechargeAmount();

			player.ClientMessage(Sprintf(msgRecharged, chargecount));
	
			player.Energy += chargecount;
			
			if (player.Energy > player.EnergyMax)
				player.Energy = player.EnergyMax;
		}

		UseOnce();
	}
Begin:
}

// ----------------------------------------------------------------------
// UpdateInfo()
// ----------------------------------------------------------------------

function bool UpdateInfo(Object winObject)
{
	local PersonaInfoWindow winInfo;
	local string str;

	winInfo = PersonaInfoWindow(winObject);
	if (winInfo == None)
		return False;

	winInfo.SetTitle(itemName);
	winInfo.SetText(Description $ winInfo.CR() $ winInfo.CR());
	winInfo.AppendText(Sprintf(RechargesLabel, GetRechargeAmount()));

	// Print the number of copies
	str = CountLabel @ String(NumCopies);
	winInfo.AppendText(winInfo.CR() $ winInfo.CR() $ DragToUse $ winInfo.CR() $ winInfo.CR() $ str);


	return True;
}

// ----------------------------------------------------------------------
// TestMPBeltSpot()
// Returns true if the suggested belt location is ok for the object in mp.
// ----------------------------------------------------------------------

simulated function bool TestMPBeltSpot(int BeltSpot)
{
   return (BeltSpot == 0);
}

simulated function bool CanChargeItem(Inventory Item)
{
	if (Item.IsA('SupportBotItem'))
	{
		if(SupportBotItem(Item).BotEMPHealth < SupportBotItem(Item).Default.BotEMPHealth)
			return True;
		else
			return False;
	}
	else if (Item.IsA('SpyDroneItem'))
	{
		if(SpyDroneItem(Item).BotEMPHealth < SpyDroneItem(Item).Default.BotEMPHealth)
			return True;
		else
			return False;
	}
	
	return false;
}

function string GetApplyMessage()
{
	return msgCharged;
}

function DestroyCell()
{
	NumCopies--;

	if(NumCopies<=0)
		Destroy();
}

function ApplyCell(Inventory Item)
{
	local SupportBotItem SBC;
	
	if (Item.IsA('SupportBotItem'))
	{
		SupportBotItem(Item).BotEMPHealth += GetRechargeAmount();
		
		if(SupportBotItem(Item).BotEMPHealth > SupportBotItem(Item).Default.BotEMPHealth)
			SupportBotItem(Item).BotEMPHealth = SupportBotItem(Item).Default.BotEMPHealth;
	}
	else if (Item.IsA('SpyDroneItem'))
	{
		SpyDroneItem(Item).BotEMPHealth += GetRechargeAmount();
		
		if(SpyDroneItem(Item).BotEMPHealth > SpyDroneItem(Item).Default.BotEMPHealth)
			SpyDroneItem(Item).BotEMPHealth = SpyDroneItem(Item).Default.BotEMPHealth;
	}
}

function int GetRechargeAmount()
{
	if(DeusExPlayer(GetPlayerPawn()).PerkSystem.CheckPerkState(class'PerkAugs'))
		return rechargeAmount * 2;
	else
		return rechargeAmount;
}

defaultproperties
{
     ChargeSound=sound'BioElectricHiss'
     rechargeAmount=25
     mpRechargeAmount=50
     maxCopies=20
     bCanHaveMultipleCopies=True
     bActivatable=True
     PlayerViewOffset=(X=30.000000,Z=-12.000000)
     PlayerViewMesh=LodMesh'DeusExItems.BioCell'
     PickupViewMesh=LodMesh'DeusExItems.BioCell'
     ThirdPersonMesh=LodMesh'DeusExItems.BioCell'
     LandSound=Sound'DeusExSounds.Generic.PlasticHit2'
     Icon=Texture'DeusExUI.Icons.BeltIconBioCell'
     largeIcon=Texture'DeusExUI.Icons.LargeIconBioCell'
     largeIconWidth=44
     largeIconHeight=43
     Mesh=LodMesh'DeusExItems.BioCell'
     CollisionRadius=4.700000
     CollisionHeight=0.930000
     Mass=5.000000
     Buoyancy=4.000000
}
