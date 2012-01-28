//=============================================================================
// ���������� ���. �������� Ded'�� ��� ���� 2027
// Support bot. Copyright (C) 2002 Hejhujka (Modified by Ded (C) 2005)
//=============================================================================
class SupportBotImpl extends SupportBotBase
     abstract;

var(Sounds) sound SpeechIdle;
var int normalrate, funcrate;
var Float lastchargeTime;
var float time, energytime;
var bool bFuncActive;
var localized String msgDestroyed;
var localized String msgEMPed;
var localized String msgCharged;
var localized String msgChargedMax;
var localized String msgChargedMin;
var localized String msgWait1;
var localized String msgWait;
var bool bPlayedEMP;
var bool bPlayedTick;
var bool bPlayedDea;
var() Sound NoPowerSound;
var String ShortBotName;
var travel float worktime;
var int chargeAmount, chargeRefreshTime;


state BotDeactivated
{
	ignores bump, reacttoinjury;
	function BeginState()
	{
		StandUp();
		BlockReactions(true);
		bCanConverse = False;
		SeekPawn = None;
		EnableCheckDestLoc(false);
	}
	function EndState()
	{
		ResetReactions();
		bCanConverse = True;
	}

Begin:
	Acceleration=vect(0,0,0);
	DesiredRotation=Rotation;
	PlayAnimPivot('Still');

Idle:
}

simulated function Deactivated(optional bool bLostPower)
{
	local DeusExPlayer Player;

	if(bPlayedDea)
		return;

	ResetReactions();
	FuncOff();
	bNoEnergy=True;
	Player = DeusExPlayer(GetPlayerPawn());
	Player.StopBot();
	GotoState('BotDeactivated');
	BlockReactions(False);
	bCanConverse = False;
	SeekPawn = None;
	EnableCheckDestLoc(False);
	Acceleration=vect(0,0,0);
	DesiredRotation=Rotation;
	PlayAnimPivot('Still');

	AmbientSound=None;

	if(bLostPower){
		Player.ClientMessage(Sprintf(msgEMPed, FamiliarName));
		PlaySound(NoPowerSound, SLOT_None);
	}

	bPlayedDea=True;
}


simulated function bool SpecialFuncToggle()
{
	if(bFuncActive==False){
		FuncOn();
		bFuncActive=True;
	}
	else{
		FuncOff();
		bFuncActive=False;
	}

	return bFuncActive;
}

function FuncOn()
{
	bFuncActive=True;
}

function FuncOff()
{
	bFuncActive=False;
}

function Explode(vector HitLocation)
{
	local int i;
	local Effects puff;
	local Fragment frag;
	local ParticleGenerator gen;
	local vector loc;
	local rotator rot;
	local SFXExplosionLight light;
	local DeusExDecal mark;
    local AnimatedSprite expeffect;
    local float dist;
    local DeusExPlayer player;
    local SFXShockRing ring;
    local vector normal;
    local float explosionRadius;
    local Projectile proj;
    local DeusExFragment s;
    
    DeusExPlayer(GetPlayerPawn()).ClientMessage(Sprintf(msgDestroyed, FamiliarName));
    
    explosionRadius = (CollisionRadius + CollisionHeight) * 1.5;
    
	PlaySound(explosionSound, SLOT_None, 2.0,, explosionRadius*20);
	
	AISendEvent('LoudNoise', EAITYPE_Audio, 2.0, explosionRadius*20);

	rot.Pitch = 16384 + FRand() * 16384 - 8192;
	rot.Yaw = FRand() * 65536;
	rot.Roll = 0;

	for (i=0; i<explosionRadius/15; i++)
	{
		if (FRand() < 0.9)
		{
			Spawn(class'SFXFireComet', None);

			frag = spawn(class'Rockchip',,, HitLocation);
				
			if (frag != None)
				frag.CalcVelocity(VRand(), explosionRadius*1.5);
		}
	}
	
	for (i=0; i<FMax(3, explosionRadius/6); i++)
	{
		s = Spawn(class'MetalFragment', Owner);
		if (s != None)
		{
			s.Instigator = Instigator;
			s.CalcVelocity(Velocity, explosionRadius);
			s.DrawScale = explosionRadius*0.04*FRand();
			s.Skin = GetMeshTexture();
			if (FRand() < 0.75)
				s.bSmoking = True;
		}
	}

	light = Spawn(class'SFXExplosionLight',,, HitLocation);
	light.size = 8;

	expeffect = spawn(class'SFXExplosionMini',,, HitLocation);
	expeffect.ScaleFactor = 1.2;

	expeffect = Spawn(class'SFXExplosionSmoke', None);
	expeffect.ScaleFactor = 0.75;

	HurtRadius(0.75*explosionRadius, 10*explosionRadius, 'Exploded', 120*explosionRadius, Location);

	/*player.DoExplosionSilence();*/

	/*if(HasSpawnGrenade())
	{
		proj = Spawn(GrenadeClass,,, HitLocation);

		if (DeusExProjectile(proj) != None)
		{
			//DeusExProjectile(proj).Instigator = Instigator;
			DeusExProjectile(proj).blastRadius *= Max(0.75, 2.0 * DeusExPlayer(GetPlayerPawn()).SkillSystem.GetSkillLevelValue(class'SkillTechnics'));
			DeusExProjectile(proj).bStuck = False;
			GrenadeProjectile(proj).bEmitWeaponShot = False;
			DeusExProjectile(proj).Explode(Location, normal);
		}
	}*/

	Player.StopBot();
}

function Tick(float deltaTime)
{
	local float rate;
	local DeusExPlayer Player;

	//Super.Tick(deltaTime);

	Player = DeusExPlayer(GetPlayerPawn());
//	Player.bBotReady=True;

	if (CheckEnemyPresence(deltaTime, True, True))
		HandleEnemy();
	else
	{
		CheckBeamPresence(deltaTime);
		CheckCarcassPresence(deltaTime);
	}

	time += deltaTime;
	energytime += deltaTime;

	if ((time > 1.0) && (EMPHitPoints>0) && (!bPlayedDea))
	{
		time = 0;
		if (FRand() < 0.05)
			PlayBotBark();
	}

	if ((EMPHitPoints>0) && (!bPlayedDea))
	{
		if(!bFuncActive && (energytime >= (60.0 / GetEnergyRate()) )){
			energytime=0;
			EMPHitPoints--;
		}
		else if(bFuncActive && (energytime >= (60.0 / funcrate) )){
			energytime=0;
			EMPHitPoints--;
		}
	}

	if(EMPHitPoints<=0 && !bPlayedTick && (!bPlayedDea)){
		bPlayedTick=true;
		Deactivated(True);
	}

	if(!bNoEnergy)
		worktime += deltaTime;
}

function int GetEnergyRate()
{
	local float mult;
	
	mult = FMin(DeusExPlayer(GetPlayerPawn()).SkillSystem.GetAltSkillLevelValue(class'SkillTechnics'), 1.0);
	
	return Max(1, normalrate * mult);
}

function PlayBotBark()
{
	/*if(!bNoEnergy){
		if(FRand() <0.5)
			PlaySound(SpeechScanning, SLOT_None,,, 2048); 
		else
			PlaySound(SpeechIdle, SLOT_None,,, 2048);
	}*/
}


/*
function Frob(Actor Frobber, Inventory frobWith)
{
	local int timetogo;	

	Super.Frob(Frobber, frobWith);

	if (DeusExPlayer(Frobber) == None)
		return;
        
	if (CanCharge())
	{
		PlaySound(sound'BioElectricHiss', SLOT_None,,, 256);
		ChargePlayer(DeusExPlayer(Frobber));
		Pawn(Frobber).ClientMessage(Sprintf(msgCharged, chargeAmount));
	}
	else
	{
		timetogo = int(chargeRefreshTime - (Level.TimeSeconds - lastChargetime));

		if(timetogo==1)
			Pawn(Frobber).ClientMessage(Sprintf(msgWait1, timetogo));
		else
			Pawn(Frobber).ClientMessage(Sprintf(msgWait, timetogo));
	}
}

function int ChargePlayer(DeusExPlayer PlayerToCharge)
{
	local int chargedPoints;

	if ( CanCharge() )
	{
		chargedPoints = PlayerToCharge.ChargePlayer( chargeAmount );
		lastChargeTime = Level.TimeSeconds;
	}
	
	return chargedPoints;
}

simulated function bool CanCharge()
{	
	return ( (Level.TimeSeconds - int(lastChargeTime)) > chargeRefreshTime);
}

simulated function Float GetRefreshTimeRemaining()
{
	return chargeRefreshTime - (Level.TimeSeconds - lastChargeTime);
}

simulated function Int GetAvailableCharge()
{
	if (CanCharge())
		return chargeAmount; 
	else
		return 0;
}
*/





state Disabled
{
	ignores bump, reacttoinjury;
	function BeginState()
	{
		StandUp();
		BlockReactions(true);
		bCanConverse = False;
		SeekPawn = None;
	}
	function EndState()
	{
		ResetReactions();
		bCanConverse = True;
	}

Begin:
	Acceleration=vect(0,0,0);
	DesiredRotation=Rotation;
	PlayDisabled();

Disabled:
}


function Frob(Actor Frobber, Inventory frobWith)
{
	local SupportBotContainerImpl cdc;
	local DeusExPlayer Player;
	local int timetogo;

	Player = DeusExPlayer(GetPlayerPawn());

	if(bNoEnergy)
	{
		cdc = SupportBotContainerImpl(Spawn(SpawnClass,,, Location, Rotation));
		
		if (cdc != None)
		{
			//cdc.bHidden = True;
			//cdc.SetCollision(False, False, False);
			cdc.SetPhysics(PHYS_None);
			cdc.BotHealth = Health;
			cdc.BotEMPHealth = EMPHitPoints;
			cdc.BotWorkTime = worktime;
			cdc.BotLastRecharge = lastChargeTime;
			cdc.SpawnGrenadeClass = SpawnGrenadeClass;
			Player.FrobTarget = cdc;
			Player.ParseRightClick();
			Destroy();
		}		
		
		Player.StopBot();
	}
}


simulated function bool CanCharge()
{	
	return ((worktime - lastChargeTime) > chargeRefreshTime);
}

simulated function int GetRefreshTimeRemaining()
{
	return int(chargeRefreshTime - (worktime - lastChargeTime));
}

function ChargePlayer(DeusExPlayer PlayerToCharge)
{
	if(PlayerToCharge.Energy + chargeAmount > 100)
		PlayerToCharge.Energy = 100;
	else
		PlayerToCharge.Energy += chargeAmount;

	lastChargeTime = worktime;
}











function PostBeginPlay()
{
	Super.PostBeginPlay();
   
	if (IsImmobile())
		bAlwaysRelevant = True;

	//lastChargeTime = -chargeRefreshTime;
	bFuncActive=False;
	bPlayedEMP=False;
	bPlayedTick=false;
	//if(EMPHitPoints<=0)
	//	TakeDamage(1, Self, Location, vect(0,0,0), 'EMP');
}

/*state Supporting
{
	function BeginState()
	{
		if(VSize(DeusExPlayer(GetPlayerPawn()).Location - Location) > 1000)
			SetOrders('RunningTo',, True);
		else
			SetOrders('Following',, True);
	}
}

state Hiding
{
	ignores EnemyNotVisible;

	function SetFall()
	{
		StartFalling('Standing', 'ContinueStand');
	}

	function AnimEnd()
	{
		PlayWaiting();
	}

	function HitWall(vector HitNormal, actor Wall)
	{
		if (Physics == PHYS_Falling)
			return;
		Global.HitWall(HitNormal, Wall);
		CheckOpenDoor(HitNormal, Wall);
	}

	function Tick(float deltaSeconds)
	{
		animTimer[1] += deltaSeconds;
		Global.Tick(deltaSeconds);
	}

	function BeginState()
	{
		GotoState('Wandering');

		//StandUp();
		//SetEnemy(None, EnemyLastSeen, true);
		//Disable('AnimEnd');
		//bCanJump = false;

		//bStasis = False;

		//SetupWeapon(false);
		//SetDistress(false);
		//SeekPawn = None;
		//EnableCheckDestLoc(false);
		
		//bReactPresence = False;
		//customVisibility = 0.5;
	}

	function EndState()
	{
		EnableCheckDestLoc(false);
		bAcceptBump = True;

		if (JumpZ > 0)
			bCanJump = true;
		bStasis = True;

		StopBlendAnims();
		
		bReactPresence = True;
		customVisibility = 0.0;
	}

Begin:
	WaitForLanding();
	if (!bUseHome)
		Goto('StartStand');

MoveToBase:
	if (!IsPointInCylinder(self, HomeLoc, 16-CollisionRadius))
	{
		EnableCheckDestLoc(true);
		while (true)
		{
			if (PointReachable(HomeLoc))
			{
				if (ShouldPlayWalk(HomeLoc))
					PlayWalking();
				MoveTo(HomeLoc, GetWalkingSpeed());
				CheckDestLoc(HomeLoc);
				break;
			}
			else
			{
				MoveTarget = FindPathTo(HomeLoc);
				if (MoveTarget != None)
				{
					if (ShouldPlayWalk(MoveTarget.Location))
						PlayWalking();
					MoveToward(MoveTarget, GetWalkingSpeed());
					CheckDestLoc(MoveTarget.Location, true);
				}
				else
					break;
			}
		}
		EnableCheckDestLoc(false);
	}
	TurnTo(Location+HomeRot);

StartStand:
	Acceleration=vect(0,0,0);
	Goto('Stand');

ContinueFromDoor:
	Goto('MoveToBase');

Stand:
ContinueStand:
	// nil
	bStasis = True;

	PlayWaiting();
	if (!bPlayIdle)
		Goto('DoNothing');
	Sleep(FRand()*14+8);

Fidget:
	if (FRand() < 0.5)
	{
		PlayIdle();
		FinishAnim();
	}
	else
	{
		if (FRand() > 0.5)
		{
			PlayTurnHead(LOOK_Up, 1.0, 1.0);
			Sleep(2.0);
			PlayTurnHead(LOOK_Forward, 1.0, 1.0);
			Sleep(0.5);
		}
		else if (FRand() > 0.5)
		{
			PlayTurnHead(LOOK_Left, 1.0, 1.0);
			Sleep(1.5);
			PlayTurnHead(LOOK_Forward, 1.0, 1.0);
			Sleep(0.9);
			PlayTurnHead(LOOK_Right, 1.0, 1.0);
			Sleep(1.2);
			PlayTurnHead(LOOK_Forward, 1.0, 1.0);
			Sleep(0.5);
		}
		else
		{
			PlayTurnHead(LOOK_Right, 1.0, 1.0);
			Sleep(1.5);
			PlayTurnHead(LOOK_Forward, 1.0, 1.0);
			Sleep(0.9);
			PlayTurnHead(LOOK_Left, 1.0, 1.0);
			Sleep(1.2);
			PlayTurnHead(LOOK_Forward, 1.0, 1.0);
			Sleep(0.5);
		}
	}
	if (FRand() < 0.3)
		PlayIdleSound();
	Goto('Stand');

DoNothing:
	// nil
}

state RunningTo
{
	function SetFall()
	{
		StartFalling('RunningTo', 'ContinueRun');
	}

	function HitWall(vector HitNormal, actor Wall)
	{
		if (Physics == PHYS_Falling)
			return;
		Global.HitWall(HitNormal, Wall);
		CheckOpenDoor(HitNormal, Wall);
	}

	function Bump(actor bumper)
	{
		// If we hit the guy we're going to, end the state
		if (bumper == OrderActor)
			GotoState('RunningTo', 'Done');

		// Handle conversations, if need be
		Global.Bump(bumper);
	}

	function Touch(actor toucher)
	{
		// If we hit the guy we're going to, end the state
		if (toucher == OrderActor)
			GotoState('RunningTo', 'Done');

		// Handle conversations, if need be
		Global.Touch(toucher);
	}

	function BeginState()
	{
		StandUp();
		//BlockReactions();
		SetupWeapon(false);
		SetDistress(false);
		bStasis = False;
		SeekPawn = None;
		EnableCheckDestLoc(true);
	}
	function EndState()
	{
		EnableCheckDestLoc(false);
		//ResetReactions();
		bStasis = True;
	}

Begin:
	Acceleration = vect(0, 0, 0);
	if (orderActor == None)
		Goto('Done');

Follow:
	if (IsOverlapping(orderActor))
		Goto('Done');
	MoveTarget = GetNextWaypoint(orderActor);
	if ((MoveTarget != None) && (!MoveTarget.Region.Zone.bWaterZone) &&
	    (MoveTarget.Physics != PHYS_Falling))
	{
		if ((MoveTarget == orderActor) && MoveTarget.IsA('Pawn'))
		{
			if (GetNextVector(orderActor, useLoc))
			{
				if (ShouldPlayWalk(useLoc))
					PlayRunning();
				MoveTo(useLoc, MaxDesiredSpeed);
				CheckDestLoc(useLoc);
			}
			else
				Goto('Pause');
		}
		else
		{
			if (ShouldPlayWalk(MoveTarget.Location))
				PlayRunning();
			MoveToward(MoveTarget, MaxDesiredSpeed);
			CheckDestLoc(MoveTarget.Location, true);
		}
		if (IsOverlapping(orderActor))
			Goto('Done');
		else
			Goto('Follow');
	}

Pause:
	Acceleration = vect(0, 0, 0);
	TurnToward(orderActor);
	PlayWaiting();
	Sleep(1.0);
	Goto('Follow');

Done:
	if (orderActor.IsA('PatrolPoint'))
		TurnTo(Location + PatrolPoint(orderActor).lookdir);
	GotoState('Following');

ContinueRun:
ContinueFromDoor:
	PlayRunning();
	Goto('Follow');
}*/

function float GetDamageModifier(Name damageType)
{
	local float skill;
	
	skill = DeusExPlayer(GetPlayerPawn()).SkillSystem.GetAltSkillLevelValue(class'SkillTechnics');
	
	switch(damageType)
	{
		case 'Shot':
			return 0.03 * skill;
			
		case 'Sabot':
			return 1.0;
			
		case 'Stunned':
		case 'KnockedOut':
		case 'Flamed':
		case 'Burned':
			return 0.04 * skill;
	}
	
	return 1.0;
}

defaultproperties
{
    SpawnClass=None
    
    FireAngle=60.00
    EnemyTimeout=7.00

    Health=50
    EMPHitPoints=25

    VisibilityThreshold=0.003
    MaxStepHeight=30.0
    GroundSpeed=300.0
    WaterSpeed=50.0
    AirSpeed=750.0
    AccelRate=800.0
    JumpZ=200.0
    UnderWaterTime=5.0
    bCanSwim=False
    bCanOpenDoors=False
    bAlwaysPatrol=True
    bAvoidAim=True
    
    Alliance=Player
    AttitudeToPlayer=5
    Intelligence=BRAINS_HUMAN
    bTickVisibleOnly=False
    
    Orders=Following
    MinHealth=10
    bMustFaceTarget=True
    bCanStrafe=True
    bReactShot=True
    bReactDistress=True
    bReactLoudNoise=False
    bHateDistress=True
    
    bHateInjury=False
    
    SoundRadius=128
    SoundVolume=140
    SearchingSound=None
    AmbientSound=Sound'DeusExSounds.Robot.MedicalBotMove'
    NoPowerSound=Sound'DeusExSounds.Pickup.PickupDeactivate'
    HitSound1=Sound'DeusExSounds.Generic.Spark1'
    HitSound2=Sound'DeusExSounds.Generic.Spark1'
    Die=Sound'DeusExSounds.Generic.Spark1'
    SearchingSound=None
	SpeechAreaSecure=Sound'DeusExSounds.Robot.SecurityBot3AreaSecure'
    SpeechTargetAcquired=Sound'DeusExSounds.Robot.SecurityBot3TargetAcquired'
    SpeechTargetLost=Sound'DeusExSounds.Robot.SecurityBot3TargetLost'
    SpeechOutOfAmmo=Sound'DeusExSounds.Robot.SecurityBot3OutOfAmmo'
    SpeechCriticalDamage=Sound'DeusExSounds.Robot.SecurityBot3CriticalDamage'
    SpeechScanning=Sound'DeusExSounds.Robot.SecurityBot3Scanning'
    SpeechIdle=Sound'DeusExSounds.Robot.SecurityBot3Scanning'
    
    DrawType=DT_Mesh
    Mesh=LodMesh'DeusExCharacters.SpiderBot2'
    DrawScale=0.600000
    
    CollisionRadius=20.148
    CollisionHeight=9.144
    Mass=60.0
    Buoyancy=50.0
    
    BindName="SupportBot"
    ShortBotName="Bot"
}