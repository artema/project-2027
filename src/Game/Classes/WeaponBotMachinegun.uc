//=======================================================
// ������ (NPC) - �������. �������� Ded'�� ��� ���� 2027
// Weapon (NPC) - Machinegun. Copyright (C) 2003 Ded
//=======================================================
class WeaponBotMachinegun extends WeaponNPC;

var SFXMinigunMuzzle muzzle;

simulated function SwapMuzzleFlashTexture2()
{
	local vector loc;
	local rotator normal;
	
    if (!bHasMuzzleFlash)
    	return;

	if(ScriptedPawn(Owner) != None)
	{
		normal = Rotation;
		normal.Yaw -= 16384;
		
		loc = ScriptedPawn(Owner).Location;
		loc.Z += 6.5;
		
		loc = loc + vector(ScriptedPawn(Owner).Rotation) * 51.5;
		loc = loc + vector(normal) * 7;

		if(muzzle == None)
		{
			muzzle = Spawn(class'SFXMinigunMuzzle', Self,, loc, ScriptedPawn(Owner).Rotation);
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

defaultproperties
{
	 bHasMuzzleFlash=True
     HitDamage=10

     BaseAccuracy=0.5
     MinWeaponAcc=0.5

     ShotTime=0.075
     reloadTime=2.0

     ShotDeaccuracy=0.05

     recoilStrength=0.0

     shakemag=10

     maxRange=4500
     AccurateRange=2000

     NoiseLevel=1.900000


     AmmoName=Class'DeusEx.RAmmo10mm'

     ReloadCount=100
     PickupAmmoCount=100

     FireSound=Sound'GameMedia.Weapons.RobotFire'

     AltFireSound=Sound'GameMedia.Weapons.RobotReloadEnd'
     CockingSound=Sound'GameMedia.Weapons.RobotReloadStart'
     SelectSound=Sound'GameMedia.Weapons.MP40Select'
}
