//=======================================================
// ������ - Guid Gun. �������� Ded'�� ��� ���� 2027
// Weapon - Guid Gun. Copyright (C) 2003 Ded
//=======================================================
class WeaponGuidGun extends GameWeapon;

var bool bMayTrack;

var localized String msgTrackActive;
var localized String msgTrackPassive;

var localized String shortName;

replication
{
	reliable if((Role == ROLE_Authority) && (bNetOwner))
		bMayTrack;

	reliable if(Role == ROLE_Authority)
		TrackFire;

	reliable if(Role < ROLE_Authority)
		TrackOn, TrackOff, TrackToggle;
}

// ----------------------------------------------------------------------
// RefreshScopeDisplay()
// ----------------------------------------------------------------------
simulated function RefreshScopeDisplay(DeusExPlayer player, bool bInstant, bool bScopeOn)
{
	if (bScopeOn && (player != None))
	{
		DeusExRootWindow(player.rootWindow).scopeView.ActivateView(ScopeFOV, True, bInstant, True);
	}
	else if(!bScopeOn)
	{
		DeusExrootWindow(player.rootWindow).scopeView.DeactivateView();
	}
}

simulated function bool ClientAltFire( float Value )
{
	GotoState('Zooming');   
	return true;
}

function AltFire( float Value )
{
	ClientAltFire(Value);   
}

state Zooming
{
	
	simulated function BeginState()
	{                        
		if(!bMayTrack && (Owner != None) && Owner.IsA('TruePlayer'))
		{
			bMayTrack = True;
			TrackFire(TruePlayer(Owner), bMayTrack);
		}
		else if(bMayTrack)
		{
			bMayTrack = False;
			TrackFire(TruePlayer(Owner), bMayTrack);
		}
                            
		GotoState('Idle');
	}
		
}

function TrackOn()
{
	if(!bMayTrack && (Owner != None) && Owner.IsA('TruePlayer'))
	{
		bMayTrack = True;
		TrackFire(TruePlayer(Owner), bMayTrack);
	}
}

function TrackOff()
{
	if(bMayTrack && (Owner != None) && Owner.IsA('TruePlayer'))
	{
		bMayTrack = False;
		TrackFire(TruePlayer(Owner), bMayTrack);
	}
}

simulated function TrackToggle()
{
	if(IsInState('Idle'))
	{
		if((Owner != None) && Owner.IsA('TruePlayer'))
		{
			if(bMayTrack)
				TrackOff();
			else
				TrackOn();
		}
	}
}

simulated function TrackFire(TruePlayer player, bool bMayTrack)
{
	if(bMayTrack && (Player !=None))
	{       
		bCanTrack = False;   
		Pawn(Owner).ClientMessage(Sprintf(msgTrackPassive));
		Owner.PlaySound(Sound'GameMedia.Weapons.LockOn', SLOT_None, 1024);
	}   
	else if(!bMayTrack)
	{	
		bCanTrack = True;
		Pawn(Owner).ClientMessage(Sprintf(msgTrackActive));
		Owner.PlaySound(Sound'GameMedia.Weapons.LockOn', SLOT_None, 1024);
	}
}


simulated function ClientDownWeapon()
{
	bWasInFiring = IsInState('ClientFiring') || IsInState('ClientAltFiring') || IsInState('SimFinishFire') || IsInState('Zooming');
	bClientReadyToFire = False;
        GotoState('SimDownWeapon');
}

state DownWeapon
{
	ignores Fire, AltFire;

	function bool PutDown()
	{
		AIEndEvent('WeaponDrawn', EAITYPE_Visual);
		return Super.PutDown();
	}

Begin:

	ScopeOff();
	LaserOff();
        TrackOff();
  	if((Level.NetMode == NM_DedicatedServer) || ((Level.NetMode == NM_ListenServer) && Owner.IsA('TruePlayer') && !TruePlayer(Owner).PlayerIsListenClient()))
		ClientDownWeapon();

	TweenDown();
	FinishAnim();

	if(Level.NetMode != NM_Standalone)
		ClipCount = 0;

	bOnlyOwnerSee = false;

	if (Pawn(Owner) != None)
		Pawn(Owner).ChangedWeapon();
}

function PostBeginPlay()
{
	Super.PostBeginPlay();

	if (ScriptedPawn(Owner) != None)
                LockTime=0.400000;
}


simulated function Tick(float deltaTime)
{
	Super.Tick(deltaTime);

	if (ScriptedPawn(Owner) != None)
                LockTime=0.400000;
}

defaultproperties
{
     ShotDamage(0)=300
     ShotDamage(1)=300

     BaseAccuracy=0.65
     MinWeaponAcc=0.2

     ShotTime=2.0
     reloadTime=2.5

     ShotUntargeting(0)=0.2
     ShotUntargeting(1)=0.5

     ShotRecoil(0)=1.0
     ShotRecoil(1)=1.0

     ShotShake(0)=600
     ShotShake(1)=600

     maxRange=24000
     AccurateRange=14400
     AIMinRange=1400

     NoiseVolume(0)=5.0
     NoiseVolume(1)=5.0

     ScopeFOV=15
     bCanTrack=True
     LockTime=3.000000
     LockedSound=Sound'GameMedia.Weapons.GEPLock'
     TrackingSound=Sound'GameMedia.Weapons.GEPTrack'

     bCanHaveScope=True
     bHasScope=True
     bCanHaveModReloadTime=True
     bCanHaveModRecoilStrength=True

     AmmoName=Class'DeusEx.RAmmoRocket'
     AmmoNames(0)=Class'DeusEx.RAmmoRocket'
     AmmoNames(1)=Class'DeusEx.RAmmoRocketWP'

     ProjectileClass=Class'Game.P_GEPRocket'
     ProjectileNames(0)=Class'Game.P_GEPRocket'
     ProjectileNames(1)=Class'Game.P_GEPRocketWP'

     ReloadCount=1
     PickupAmmoCount=4
     LowAmmoWaterMark=4

     bHasMuzzleFlash=False
     bUseWhileCrouched=False
     bInstantHit=False
     bAutomatic=False
     bOldStyle=True

     ShotSound(0)=Sound'DeusExSounds.Weapons.GEPGunFire'
     ShotSound(1)=Sound'DeusExSounds.Weapons.GEPGunFireWP'

     AltFireSound=Sound'GDeusExSounds.Weapons.GEPGunReloadEnd'
     CockingSound=Sound'DeusExSounds.Weapons.GEPGunReload'
     SelectSound=Sound'DeusExSounds.Weapons.GEPGunSelect'
     LandSound=Sound'DeusExSounds.Generic.DropLargeWeapon'

     Icon=Texture'DeusExUI.Icons.BeltIconGEPGun'
     largeIcon=Texture'DeusExUI.Icons.LargeIconGEPGun'
     largeIconWidth=203
     largeIconHeight=77
     invSlotsX=4
     invSlotsY=2
     InventoryGroup=110

     GoverningSkill=Class'DeusEx.SkillWeaponHeavy'

     FireOffset=(X=-46.000000,Y=22.000000,Z=10.000000)
     PlayerViewOffset=(X=36.000000,Y=-22.000000,Z=-10.000000)//X=46.000000,Y=-22.000000,Z=-10.000000
     PlayerViewMesh=LodMesh'DeusExItems.GEPGun'
     PickupViewMesh=LodMesh'DeusExItems.GEPGunPickup'
     ThirdPersonMesh=LodMesh'DeusExItems.GEPGun3rd'
     Mesh=LodMesh'DeusExItems.GEPGunPickup'
     CollisionRadius=27.000000
     CollisionHeight=6.600000
     Mass=50.000000
     RealMass=18.0
     
     bHideInfo=True
}