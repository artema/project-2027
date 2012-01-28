//=======================================================
// ������ - Spas 12. �������� Ded'�� ��� ���� 2027
// Weapon - Spas 12. Copyright (C) 2003 Ded 
// ����� ������/Model created by: dieworld
// Deus Ex: 2027
//=======================================================
class WeaponShotGun extends GameWeapon;

var int RoundsToLoad;
var int CurrentRound;

simulated function M37Pump()
{
      if(!SupressSounds()) Owner.PlaySound(Sound'MP5S.M37Pump', SLOT_None,,, 1024, TruePlayer(GetPlayerPawn()).GetSoundPitchMultiplier()); 
}

simulated function M37InsertShell()
{
      if(!SupressSounds()) Owner.PlaySound(Sound'MP5S.M37InsertShell', SLOT_None,,, 1024, TruePlayer(GetPlayerPawn()).GetSoundPitchMultiplier()); 
}

state Reload
{
	ignores Fire, AltFire;

	function float GetReloadTime()
	{
		local float val;

		val = ReloadTime;

		if (ScriptedPawn(Owner) != None)
		{
			val = ReloadTime * (ScriptedPawn(Owner).BaseAccuracy*2+1);
		}
		else if (DeusExPlayer(Owner) != None)
		{
			// check for skill use if we are the player
			val = GetWeaponSkill();
			val = ReloadTime + (val*ReloadTime);
		}

		return val;
	}

	function NotifyOwner(bool bStart)
	{
		local DeusExPlayer player;
		local ScriptedPawn pawn;

		player = DeusExPlayer(Owner);
		pawn   = ScriptedPawn(Owner);

		if (player != None)
		{
			if (bStart)
				player.Reloading(self, GetReloadTime()+(1.0/AnimRate));
			else
			{
				player.DoneReloading(self);
			}
		}
		else if (pawn != None)
		{
			if (bStart)
				pawn.Reloading(self, GetReloadTime()+(1.0/AnimRate));
			else
				pawn.DoneReloading(self);
		}
	}

Begin:
	FinishAnim();

	// only reload if we have ammo left
	if ((AmmoType.AmmoAmount > AmmoLeftInClip() && AmmoLeftInClip() < ReloadCount) || RoundsToLoad > 0)
	{
		if(RoundsToLoad == 0)
			RoundsToLoad = Min(ReloadCount - AmmoLeftInClip(), AmmoType.AmmoAmount);
		
		if(RoundsToLoad == 0)
			GotoState('Idle');
		else
		{		
			bWasZoomed = bZoomed;
			if (bWasZoomed) ScopeOff();
	
			Owner.PlaySound(CockingSound, SLOT_None,,, 1024, DeusExPlayer(GetPlayerPawn()).GetSoundPitchMultiplier());
			PlayAnim('ReloadBegin', GetReloadingAnimRate());
			NotifyOwner(True);
			FinishAnim();
			
			for(CurrentRound=0; CurrentRound<RoundsToLoad; CurrentRound++)
			{
				PlayAnim('Reload', GetReloadingAnimRate());
				Sleep(GetReloadTime());
				FinishAnim();
			}
			
			RoundsToLoad = 0;
				
			Owner.PlaySound(AltFireSound, SLOT_None,,, 1024, DeusExPlayer(GetPlayerPawn()).GetSoundPitchMultiplier());
			PlayAnim('ReloadEnd', GetReloadingAnimRate());
			FinishAnim();
			NotifyOwner(False);
			ClipCount = 0;
			GotoState('Idle');
		}
	}
	else
	{
		RoundsToLoad = 0;
		GotoState('Idle');
	}
}

function bool LoadAmmo(int ammoNum)
{
	local class<Ammo> newAmmoClass;
	local Ammo newAmmo;
	local Pawn P;

	if ((ammoNum < 0) || (ammoNum > 2))
		return False;

	P = Pawn(Owner);

	// sorry, only pawns can have weapons
	if (P == None)
		return False;

	newAmmoClass = AmmoNames[ammoNum];

	if (newAmmoClass != None)
	{
		if (newAmmoClass != AmmoName)
		{
			newAmmo = Ammo(P.FindInventoryType(newAmmoClass));
			if (newAmmo == None)
			{
				P.ClientMessage(Sprintf(msgOutOf, newAmmoClass.Default.ItemName));
				return False;
			}
			
			// if we don't have a projectile for this ammo type, then set instant hit
			if (ProjectileNames[ammoNum] == None)
			{
				bInstantHit = True;
				bAutomatic = Default.bAutomatic;
				ShotTime = Default.ShotTime;
				if ( Level.NetMode != NM_Standalone )
				{
					if (HasReloadMod())
						ReloadTime = mpReloadTime * (1.0+ModReloadTime);
					else
						ReloadTime = mpReloadTime;
				}
				else
				{
					if (HasReloadMod())
						ReloadTime = Default.ReloadTime * (1.0+ModReloadTime);
					else
						ReloadTime = Default.ReloadTime;
				}
				FireSound = Default.FireSound;
				ProjectileClass = None;
			}
			else
			{
				// otherwise, set us to fire projectiles
				bInstantHit = False;
				bAutomatic = False;
				ShotTime = 1.0;
				if (HasReloadMod())
					ReloadTime = 2.0 * (1.0+ModReloadTime);
				else
					ReloadTime = 2.0;
				FireSound = None;		// handled by the projectile
				ProjectileClass = ProjectileNames[ammoNum];
				ProjectileSpeed = ProjectileClass.Default.Speed;
			}

			AmmoName = newAmmoClass;
			AmmoType = newAmmo;

			if (DeusExPlayer(P) != None)
				DeusExPlayer(P).UpdateBeltText(Self);

			RoundsToLoad = Min(newAmmo.AmmoAmount, ReloadCount);

			ReloadAmmo();

			P.ClientMessage(Sprintf(msgNowHas, ItemName, newAmmoClass.Default.ItemName));
			return True;
		}
		else
		{
			P.ClientMessage(Sprintf(MsgAlreadyHas, ItemName, newAmmoClass.Default.ItemName));
		}
	}

	return False;
}

function rotator CalculateRecoil(float shotState)
{
	local rotator recoil;
	
	recoil.Yaw = Cos(PI * 0.5 * shotState) * (20000 - Rand(5000));
	recoil.Pitch = Cos(PI * 0.5 * shotState) * (20000 + Rand(7000));
	
	return recoil;
}

defaultproperties
{
     ShotDamage(0)=6
     ShotDamage(1)=50
     BaseAccuracy=0.75
     MinWeaponAcc=0.25

     ShotTime=0.3
     reloadTime=0.8

     ShotUntargeting(0)=0.7
     ShotUntargeting(1)=1.0

     ShotRecoil(0)=0.45
     ShotRecoil(1)=0.55

     ShotShake(0)=280
     ShotShake(1)=380

     maxRange=2400
     AccurateRange=1200

     NoiseVolume(0)=2.0
     NoiseVolume(1)=2.5

	 bUseWhileCrouched=False
     bCanHaveModReloadCount=True
     bCanHaveModReloadTime=True
     bCanHaveModRecoilStrength=True

     AmmoName=Class'DeusEx.RAmmoShell'
     AmmoNames(0)=Class'DeusEx.RAmmoShell'
     AmmoNames(1)=Class'DeusEx.RAmmoSabot'

     ReloadCount=6
     PickupAmmoCount=0
     LowAmmoWaterMark=6

     AreaOfEffect=AOE_Cone

     bCanHaveModReloadCount=True
     bCanHaveModReloadTime=True
     bCanHaveModRecoilStrength=True

     ShotSound(0)=Sound'MP5S.Weapons.M37Fire'
     ShotSound(1)=Sound'MP5S.Weapons.M37Fire'

     LandSound=Sound'DeusExSounds.Generic.DropMediumWeapon'

     bInstantHit=True
     bAutomatic=False
     bOldStyle=True

     Icon=Texture'Game.Icons.BeltIconShotgun'
     largeIcon=Texture'Game.Icons.LargeIconShotgun'
     largeIconWidth=159
     largeIconHeight=39
     invSlotsX=4
     InventoryGroup=125

     GoverningSkill=Class'DeusEx.SkillWeaponRifle'

     HIResPickupMesh=LodMesh'GameMedia.WinchesterPickup'
     LOResPickupMesh=LodMesh'GameMedia.WinchesterPickup'
     HIRes3rdMesh=LodMesh'GameMedia.Winchester3rd'
     LORes3rdMesh=LodMesh'GameMedia.Winchester3rd'
     Mesh=LodMesh'GameMedia.WinchesterPickup'
     PickupViewMesh=LodMesh'GameMedia.WinchesterPickup'
     ThirdPersonMesh=LodMesh'GameMedia.Winchester3rd'

     FireOffset=(X=-16.00,Y=5.00,Z=11.50)
     PlayerViewOffset=(X=16.00,Y=-5.00,Z=-20.50)
     PlayerViewMesh=LodMesh'MP5S.ithaca1st'

	 LODBias=5.0

     CollisionRadius=15.000000
     CollisionHeight=1.10
     Mass=30.000000
     RealMass=3.5
}