//=======================================================
// ������ (NPC) - �������. �������� Ded'�� ��� ���� 2027
// Weapon (NPC) - Machinegun. Copyright (C) 2003 Ded
//=======================================================
class WeaponBotSubMachinegun extends WeaponNPC;

var SFXSubMachinegunMuzzle muzzle;

simulated function SwapMuzzleFlashTexture2()
{
	local vector loc;
	local rotator normal;
	
    if (!bHasMuzzleFlash)
    	return;

	if(ScriptedPawn(Owner) != None)
	{
		loc = ScriptedPawn(Owner).Location;
		loc.Z -= 29.007805;
		
		loc = loc + vector(ScriptedPawn(Owner).Rotation) * 5.5;

		if(muzzle == None)
		{
			muzzle = Spawn(class'SFXSubMachinegunMuzzle', Self,, loc, ScriptedPawn(Owner).Rotation);
			muzzle.SetOwner(ScriptedPawn(Owner));
			muzzle.SetBase(ScriptedPawn(Owner));
		}
		
		if(muzzle != None)
		{
			muzzle.SetLocation(loc);
			muzzle.SetRotation(ScriptedPawn(Owner).Rotation);
			muzzle.bHidden = False;
		}
	}
	
	MuzzleFlashLight();
	SetTimer(0.2, False);
}

simulated function EraseMuzzleFlashTexture2()
{
	if(muzzle != None)
	{
		muzzle.bHidden = True;		
	}
}

function timer()
{
	if(muzzle != None)
	{
		muzzle.bHidden = True;		
	}
}

simulated function Destroyed()
{
	if (muzzle != None)
		muzzle.Destroy();

	Super.Destroyed();
}

function Fire(float Value)
{
	PlayerViewOffset.Y = -PlayerViewOffset.Y;
	Super.Fire(Value);
}

defaultproperties
{
	 bHasMuzzleFlash=True
     HitDamage=8

     BaseAccuracy=0.35
     MinWeaponAcc=0.35

     ShotTime=0.07
     reloadTime=2.0

     ShotDeaccuracy=0.05

     recoilStrength=0.0

     shakemag=10

     maxRange=3000
     AccurateRange=2000

     NoiseLevel=1.900000


     AmmoName=Class'DeusEx.RAmmo556mm'

     ReloadCount=100
     PickupAmmoCount=100

     FireSound=Sound'GameMedia.Weapons.AugFire'

     AltFireSound=Sound'GameMedia.Weapons.MP40ReloadEnd'
     CockingSound=Sound'GameMedia.Weapons.MP40Reload'
     SelectSound=Sound'GameMedia.Weapons.MP40Select'
}
