//=============================================================================
// ���������� ��� (���������). �������� Ded'�� ��� ���� 2027
// Support bot (Container). Copyright (C) 2002 Hejhujka (Modified by Ded (C) 2005)
//=============================================================================
class SupportBotContainerImpl extends SupportBotItem
     abstract;

var() class<SupportBotImpl> SpawnClass;

var localized String HealthRemainingLabel;
var localized String HealthEMPRemainingLabel;
var localized String PointsLabel;
var localized String StatInfoLabel;
var localized String DescInfoLabel;
var localized String FuncInfoLabel;
var localized String FuncDesc;
var localized String EnergyInfo;
var localized String EnergyNormal;
var localized String EnergyFunc;
var localized String ShortBotName;
var localized String FullBotName;
var localized String ChargePlacedLabel;
var localized string msgNeedItem;

var() class<Inventory> itemNeeded;

var() int normalrate, funcrate;
var() int chargeAmount, chargeRefreshTime;
var() String BindBotName;
var travel float BotLastRecharge;

var SupportBotImpl SB;

state Activated
{
	function BeginState()
	{
		local DeusExPlayer Player;
		local vector spawnlocation;

		Player = DeusExPlayer(Owner);
		
		if (Player != None)
		{
			if(!CanUseBot(Self.class))
			{
				Player.ClientMessage(Sprintf(msgNeedItem, itemNeeded.Default.ItemName));
				return;	
			}
			
			if(!CanSpawnBot(Player, spawnLocation))
			{
				Player.ClientMessage(Player.CannotDropHere);
				return;
			}
			
			if(!CreateBot(Player, spawnLocation))
			{
				Player.ClientMessage(Player.CannotDropHere);
				return;	
			}
		}
		
		Destroy();
		
		Super.BeginState();		
	}
	
	function Activate()
	{
		local DeusExPlayer Player;
		local vector spawnlocation;

		Player = DeusExPlayer(Owner);
		
		if (Player != None)
		{
			if(!CanUseBot(Self.class))
			{
				Player.ClientMessage(Sprintf(msgNeedItem, itemNeeded.Default.ItemName));
				return;	
			}
			
			if(!CanSpawnBot(Player, spawnLocation))
			{
				Player.ClientMessage(Player.CannotDropHere);
				return;
			}
			
			if(!CreateBot(Player, spawnLocation))
			{
				Player.ClientMessage(Player.CannotDropHere);
				return;	
			}
		}
		
		Destroy();
		
		Super.Activate();	
	}
}

function bool CanSpawnBot(DeusExPlayer Player, out vector spawnLocation)
{
	local Vector X, Y, Z, dropVect, origLoc, HitLocation, HitNormal, extent;
	local float velscale, size, mult;
	local bool bSuccess;
	local Actor hitActor;
	
	origLoc = Location;
	GetAxes(Rotation, X, Y, Z);
	
	if ((Player.FrobTarget != None) && !Player.FrobTarget.IsA('Pawn'))
	{
			// try to drop the object about one foot above the target
			size = Player.FrobTarget.CollisionRadius - CollisionRadius * 2;
			dropVect.X = size/2 - FRand() * size;
			dropVect.Y = size/2 - FRand() * size;
			dropVect.Z = Player.FrobTarget.CollisionHeight + CollisionHeight + 16;
			dropVect += Player.FrobTarget.Location;
	}
	else
	{
			dropVect = Location + ( CollisionRadius + Player.CollisionRadius + 4) * X;
			//dropVect.Z += Player.BaseEyeHeight;
	}
	
	if (FastTrace(dropVect))
	{
			extent.X = CollisionRadius;
			extent.Y = CollisionRadius;
			extent.Z = 1;
			hitActor = Trace(HitLocation, HitNormal, dropVect, Location, True, extent);

			if ((hitActor == None) && SetLocation(dropVect))
				bSuccess = True;
			else
				SetLocation(origLoc);
	}
	
	spawnLocation = dropVect;
	
	return bSuccess;
}

// ----------------------------------------------------------------------
// ChargedPickupBegin()
// ----------------------------------------------------------------------
function bool CreateBot(DeusExPlayer Player, vector spawnLocation)
{
	local Vector loc,X,Y,Z;
      
	SB = Spawn(SpawnClass,,,spawnLocation);
	
	if(SB != None)
	{
		Player.PutInHand(None);
		SetOwner(Player);    
	    Player.DeleteInventory(Self);
    
		SB.GrenadeClass = GrenadeClasses[SpawnGrenadeClass];
		SB.SpawnGrenadeClass = SpawnGrenadeClass;
		SB.Health = BotHealth;		
		SB.EMPHitPoints = BotEMPHealth;
		SB.worktime = BotWorkTime;
		SB.lastChargeTime = BotLastRecharge;
		SB.ShortBotName = ShortBotName;
		SB.UnfamiliarName = FullBotName;
		SB.FamiliarName = FullBotName;
		SB.chargeRefreshTime = chargeRefreshTime;
		SB.chargeAmount = chargeAmount;
		SB.funcrate = funcrate;
		SB.normalrate = normalrate;
	
		Player.CreateBot(SB);
		Player.PlaySound(ActivateSound, SLOT_None);
		
		return true;
	}
	
	return false;
}

// ----------------------------------------------------------------------
// GetBotEnergyNormal()
// ----------------------------------------------------------------------
simulated function Int GetBotEnergyNormal()
{	
	local float mult;
	
	mult = FMin(DeusExPlayer(GetPlayerPawn()).SkillSystem.GetAltSkillLevelValue(class'SkillTechnics'), 1.0);
	
	return Max(1, normalrate * mult);
}

// ----------------------------------------------------------------------
// GetBotEnergyFunc()
// ----------------------------------------------------------------------
simulated function Int GetBotEnergyFunc()
{
	return (Default.funcrate);
}

// ----------------------------------------------------------------------
// GetCurrentBotHealth()
// ----------------------------------------------------------------------
simulated function Float GetCurrentBotHealth()
{
	return (Float(BotHealth) / Float(Default.BotHealth)) * 100.0;
}

// ----------------------------------------------------------------------
// GetCurrentBotEMPHealth()
// ----------------------------------------------------------------------
simulated function Float GetCurrentBotEMPHealth()
{
	return (Float(BotEMPHealth) / Float(Default.BotEMPHealth)) * 100.0;
}

// ----------------------------------------------------------------------
// UpdateInfo()
// ----------------------------------------------------------------------
simulated function bool UpdateInfo(Object winObject)
{
	local PersonaInfoWindow winInfo;
	local DeusExPlayer player;
	local String outText;
	local int points;
	local Projectile proj;
	local string projname;

	winInfo = PersonaInfoWindow(winObject);
	if (winInfo == None)
		return False;

	player = DeusExPlayer(Owner);

	if (player != None)
	{
		winInfo.Clear();
		winInfo.SetTitle(itemName);
	//	winInfo.SetText(Description $ winInfo.CR() $ winInfo.CR());

		//�������� � �������
		winInfo.SetText(StatInfoLabel $ winInfo.CR());
		
		points = BotHealth;
		outText = HealthRemainingLabel $ Int(GetCurrentBotHealth()) $ "%" $ winInfo.CR();
		winInfo.AppendText(outText);
		
		points = BotEMPHealth;
		outText = HealthEMPRemainingLabel @ Int(GetCurrentBotEMPHealth()) $ "%" $ " (" $ points $ " " $ PointsLabel $ ")" $ winInfo.CR();
		winInfo.AppendText(outText);

		if(HasSpawnGrenade() && player.PerkSystem.CheckPerkState(class'PerkBotexplode'))
		{
			proj = Spawn(GrenadeClasses[SpawnGrenadeClass], Owner);			

			if (proj != None)
			{
				projname = ThrownProjectile(proj).ItemName;
				proj.Destroy();
			}

			outText = ChargePlacedLabel @ projname $ winInfo.CR();
			winInfo.AppendText(outText);
		}

		//�������� ����
		outText = winInfo.CR() $ DescInfoLabel $ winInfo.CR() $ Description $ winInfo.CR() $ winInfo.CR();
		winInfo.AppendText(outText);

		//�������� �������
		//outText = FuncInfoLabel $ winInfo.CR() $ FuncDesc $ winInfo.CR() $ winInfo.CR();
		//winInfo.AppendText(outText);

		//������������
		//outText = EnergyInfo $ winInfo.CR() $ EnergyNormal @ GetBotEnergyNormal() $ " " $ PointsLabel $ winInfo.CR() $ EnergyFunc @ GetBotEnergyFunc() $ " " $ PointsLabel $ winInfo.CR() $ winInfo.CR();
		//winInfo.AppendText(outText);
		
		outText = EnergyInfo @ GetBotEnergyNormal() $ " " $ PointsLabel $ winInfo.CR();
		winInfo.AppendText(outText);
	}

	return True;
}


function bool CanUseBot(class<SupportBotItem> itemclass, optional out int bUsingVision)
{
	local bool bHasControl;
	local Inventory item, nextItem;
	local DeusExPlayer Player;
	local int i;

	if(itemNeeded != None)
	{
		Player = DeusExPlayer(Owner);

		item = Player.Inventory;
		nextItem = None;
		
		i = 0;
		
		while(true)
		{
			while((item != None) && (item.IsA('NanoKeyRing') || (!item.bDisplayableInv)))
				item = item.Inventory;

			if (item != None)
			{
				nextItem = item.Inventory;
				
				if (item.class == itemNeeded)
				{
					bHasControl = True;
					break;
				}
			}
				
			if (nextItem == None)
				break;	
			else
				item = nextItem;
				
			i++;
			
			if(i>9000)
				break;
		}
	}
	else
		bHasControl = true;
		
	return (bHasControl);
}

simulated function Tick(float deltaTime)
{
	Super.Tick(deltaTime);

	DrawScale=0.6;
}

function PostBeginPlay()
{
	Super.PostBeginPlay();
	
	DrawScale=0.6;
}

defaultproperties
{
    normalrate=10
    funcrate=25
    chargeAmount=50
    chargeRefreshTime=15
    BotHealth=100
    BotEMPHealth=25
    
    SpawnClass=None

    LandSound=Sound'DeusExSounds.Generic.DropLargeWeapon'
    
    PlayerViewOffset=(X=20.00,Y=0.00,Z=-12.00),
    PlayerViewMesh=LodMesh'DeusExCharacters.SpiderBot2'
    PlayerViewScale=0.60
    PickupViewMesh=LodMesh'DeusExCharacters.SpiderBot2'
    ThirdPersonMesh=LodMesh'DeusExCharacters.SpiderBot2'
    ThirdPersonScale=0.60
    
    Icon=Texture'DeusExUI.Icons.BeltIconArmorAdaptive'
    largeIcon=Texture'DeusExUI.Icons.LargeIconArmorAdaptive'
    largeIconWidth=35
    largeIconHeight=49
    
    invSlotsX=2
    invSlotsY=2
    
    M_Activated=""
	M_Deactivated=""
    
    Mesh=LodMesh'DeusExCharacters.SpiderBot2'
    DrawScale=0.6
    CollisionRadius=20.148
    CollisionHeight=9.144
    Mass=60.0
    Buoyancy=100.0
}