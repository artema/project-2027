//=======================================================
// ������ (NPC) - �����������. �������� Ded'�� ��� ���� 2027
// Weapon (NPC) - Electrowave. Copyright (C) 2003 Ded
//=======================================================
class WeaponSpider extends WeaponNPCRange;
var ElectricityEmitter emitter;
var float zapTimer;
var vector lastHitLocation;
var int shockDamage;

function name WeaponDamageType()
{
	return 'EMP';
}

function ProcessTraceHit(Actor Other, Vector HitLocation, Vector HitNormal, Vector X, Vector Y, Vector Z)
{
	Super.ProcessTraceHit(Other, HitLocation, HitNormal, X, Y, Z);

	zapTimer = 0.5;
	if (emitter != None)
	{
		emitter.SetLocation(Owner.Location);
		emitter.SetRotation(Rotator(HitLocation - emitter.Location));
		emitter.TurnOn();
		emitter.SetBase(Owner);
		lastHitLocation = HitLocation;
	}
}

function Tick(float deltaTime)
{
	Super.Tick(deltaTime);

	if (zapTimer > 0)
	{
		zapTimer -= deltaTime;

		// update the rotation of the emitter
		emitter.SetRotation(Rotator(lastHitLocation - emitter.Location));

		// turn off the electricity after the timer has expired
		if (zapTimer < 0)
		{
			zapTimer = 0;
			emitter.TurnOff();
		}
	}
}

function Destroyed()
{
	if (emitter != None)
	{
		emitter.Destroy();
		emitter = None;
	}

	Super.Destroyed();
}

function PostBeginPlay()
{
	Super.PostBeginPlay();

	zapTimer = 0;
	emitter = Spawn(class'ElectricityEmitter', Self);
	if (emitter != None)
	{
		emitter.bFlicker = False;
		emitter.randomAngle = 1024;
		emitter.damageAmount = shockDamage;
		emitter.TurnOff();
		emitter.Instigator = Pawn(Owner);
	}
}

defaultproperties
{
     HitDamage=25
     shockDamage=25

     ShotTime=1.0

     maxRange=1280
     AccurateRange=640

     BaseAccuracy=0.000000

     AmmoName=Class'DeusEx.RAmmoBattery'

     ReloadCount=20
     PickupAmmoCount=20

     bInstantHit=True
     bAutomatic=False
     bOldStyle=True

     FireSound=Sound'GameMedia.Weapons.LightningZap1'
     //FireSound=Sound'DeusExSounds.Weapons.ProdFire' 
}
