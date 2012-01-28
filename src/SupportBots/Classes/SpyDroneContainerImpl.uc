class SpyDroneContainerImpl extends SpyDroneItem
     abstract;

#exec obj load file="..\2027\Textures\GameEffects.utx" package=GameEffects

var() class<Inventory> itemNeeded;
var localized string msgNeedItem;

var localized String HealthEMPRemainingLabel;
var localized String PointsLabel;
var localized String ChargePlacedLabel;
var localized String DescInfoLabel;
var localized String StatInfoLabel;
var localized String EnergyInfo;

var() int normalrate;

state Activated
{
	function BeginState()
	{
		local DeusExPlayer Player;
		local vector spawnlocation;

		Player = DeusExPlayer(Owner);
		
		if (Player != None)
		{
			if(!CanUseDrone(Self.class))
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

		UseOnce();

		Super.BeginState();
	}
	
	function Activate()
	{
		local DeusExPlayer Player;
		local vector spawnlocation;

		Player = DeusExPlayer(Owner);
		
		if (Player != None)
		{
			if(!CanUseDrone(Self.class))
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

		UseOnce();
		
		Super.Activate();
	}
}

function bool CreateBot(DeusExPlayer Player, vector spawnLocation)
{
	local Vector loc,X,Y,Z;

	if(!CreateDrone())
		return false;
	
	Player.PutInHand(None);
	SetOwner(Player);
	Player.bSpyDroneActive = True;
	Player.FixedViewRotation = Player.ViewRotation;		
	
	return true;
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
			dropVect.Z += Player.BaseEyeHeight;
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

function bool CanUseDrone(class<SpyDroneItem> itemclass, optional out int bUsingVision)
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

function bool CreateDrone()
{
	local Vector loc;
	local DeusExPlayer Player;

	Player = DeusExPlayer(GetPlayerPawn());

	loc = (2.0 + spawnClass.Default.CollisionRadius + Player.CollisionRadius) * Vector(Player.ViewRotation);
	loc.Z = Player.BaseEyeHeight;
	loc += Player.Location;
	
	Player.aDrone = Spawn(spawnClass, Player,, loc, Player.ViewRotation);
	
	if (Player.aDrone != None)
	{
		Player.aDrone.Speed = 400 * Player.SkillSystem.GetSkillLevelValue(class'SkillTechnics');
		Player.aDrone.MaxSpeed = 600 * Player.SkillSystem.GetSkillLevelValue(class'SkillTechnics');
		Player.aDrone.Damage = 30;
		Player.aDrone.blastRadius = 256;
		Player.aDrone.SetSpawnGrenade(SpawnGrenadeClass);
		Player.aDrone.GrenadeClass = GrenadeClasses[SpawnGrenadeClass];
		Player.aDrone.HitPoints = BotHealth;
		Player.aDrone.BotEMPHealth = BotEMPHealth;
		Player.aDrone.BotEMPHealthDefault = Default.BotEMPHealth;
		Player.aDrone.normalrate = normalrate;
		Player.aDrone.Instigator = Player;
		
		return true;
	}
	
	return false;
}

simulated function Float GetCurrentBotEMPHealth()
{
	return (BotEMPHealth / Default.BotEMPHealth) * 100.0;
}

simulated function Int GetBotEnergyNormal()
{
	local float mult;
	
	mult = FMin(DeusExPlayer(GetPlayerPawn()).SkillSystem.GetAltSkillLevelValue(class'SkillTechnics'), 1.0);
	
	return Max(1, normalrate * mult);
}

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

		winInfo.SetText(StatInfoLabel $ winInfo.CR());
		outText = HealthEMPRemainingLabel @ Int(GetCurrentBotEMPHealth()) $ "%" $ " (" $ BotEMPHealth $ " " $ PointsLabel $ ")" $ winInfo.CR();
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

		outText = winInfo.CR() $ DescInfoLabel $ winInfo.CR() $ Description $ winInfo.CR() $ winInfo.CR();
		winInfo.AppendText(outText);

		outText = EnergyInfo @ GetBotEnergyNormal() $ " " $ PointsLabel $ winInfo.CR();
		winInfo.AppendText(outText);
	}

	return True;
}

defaultproperties
{
	M_Activated=""
	M_Deactivated=""
	Mesh=LodMesh'DeusExCharacters.SpyDrone'
	PlayerViewOffset=(X=20.00,Y=0.00,Z=-12.00),
    PlayerViewMesh=LodMesh'DeusExCharacters.SpyDrone'
    //PlayerViewScale=0.60
    PickupViewMesh=LodMesh'DeusExCharacters.SpyDrone'
    ThirdPersonMesh=LodMesh'DeusExCharacters.SpyDrone'
    //ThirdPersonScale=0.60
	CollisionRadius=13.000000
    CollisionHeight=2.760000
    Mass=10.000000
    Buoyancy=2.000000
}