//=============================================================================//
//            ����� ����� ��� ������. ������� Ded'�� ��� ���� 2027             //
//                  New Weapon class. Copyright (C) 2003 Ded                   //
//=============================================================================//
class GameWeapon extends DeusExWeapon
     abstract; 

#exec obj load file="..\2027\Textures\GameEffects.utx" package=GameEffects
#exec obj load file="..\2027\Textures\GameMisc.utx" package=GameMisc
#exec obj load file="..\Textures\Effects.utx" package=Effects

var() bool bMeleeDamage;
var() bool bHasPuff;

var() mesh     PlusPickupMesh;
var() mesh     Plus3rdMesh;
var() mesh     HIResPickupMesh;
var() mesh     LOResPickupMesh;
var() mesh     HIRes3rdMesh;
var() mesh     LORes3rdMesh;

var() int MuzzleMaterial;

var() bool bNewSkin;
var bool bFired;
var() bool bPlayerViewSkinned;
var float tickTime;
var() texture PlayerViewSkins[8];
var() texture PickupViewSkins[8];

var() float ShotDeaccuracy;

var() int ShotDamage[3]; //�����������
var() float ShotUntargeting[3]; //�������� ��������� �������� ����� ��������
var() float NoiseVolume[3], NoiseVolumeSilenced[3]; //���������: ������� � � ����������
var() float ShotShake[3]; //������ ������ ��� ��������
var() float ShotRecoil[3]; //������
var() sound ShotSound[3], ShotSoundSilenced[3]; //���� ��������: ������� � � ����������

var() bool bSemiAutomatic; //��� �������� ����� ������ ��� �������� ������
var() bool bOldStyle; //������ �������� �� ������� ���������

var() float RealMass; //������� Mass ������ �� ������, ��� ��� �� �����

var() Name ShootAnim;
var() float ShootAnimRate;

var float BulletDegrade;

var int rocketShotCount;
var bool bRocketLaunchOn;

var texture NormalPlayerViewSkins[10];
var texture CamoPlayerViewSkins[10];
var bool bWeaponInvisible;

var float shotPeriod;

var() bool bHideInfo;

var localized string msgInfoHumanDamage;

function PostBeginPlay()
{
	if(bCannotBePickedUp)
		bNativeAttack = True;
		
	Super.PostBeginPlay();
}


simulated function HandleAmmunition()
{
	local int i;

	for(i=0;i<3;i++)
	{
		if(AmmoNames[i] != None && AmmoType != None){
		if(AmmoType.Class == AmmoNames[i])
		{
			HitDamage = ShotDamage[i];
			shakemag = ShotShake[i];
			recoilStrength = ShotRecoil[i];
			ShotDeaccuracy = ShotUntargeting[i];

			if(bHasSilencer)
			{
				bHasMuzzleFlash = False;
				//NoiseLevel = NoiseVolumeSilenced[i];
				//FireSound = ShotSoundSilenced[i];
				NoiseLevel = NoiseVolume[i];
				FireSound = ShotSound[i];
			}
			else
			{
				bHasMuzzleFlash = Default.bHasMuzzleFlash;
				NoiseLevel = NoiseVolume[i];
				FireSound = ShotSound[i];
			}

			break;
		}
		}
	}
}


simulated function SwapMuzzleFlashTexture2()
{
   if (!bHasMuzzleFlash)
      return;


if (FRand() < 0.35)
	MultiSkins[MuzzleMaterial] = Texture'GameEffects.Fire.ef_Shot_001';
else if (FRand() < 0.65)
	MultiSkins[MuzzleMaterial] = Texture'GameEffects.Fire.ef_Shot_002';
else
	MultiSkins[MuzzleMaterial] = Texture'GameEffects.Fire.ef_Shot_003';

	MuzzleFlashLight();
	SetTimer(0.1, False);
}

simulated function EraseMuzzleFlashTexture2()
{
}

simulated function SwapMuzzleFlashTexture()
{
   /*if (!bHasMuzzleFlash)
      return;


if (FRand() < 0.3)
	MultiSkins[MuzzleMaterial] = Texture'GameEffects.Fire.ef_Shot_001';
else if (FRand() < 0.6)
	MultiSkins[MuzzleMaterial] = Texture'GameEffects.Fire.ef_Shot_002';
else
	MultiSkins[MuzzleMaterial] = Texture'GameEffects.Fire.ef_Shot_003';

	MuzzleFlashLight();
	SetTimer(0.1, False);*/
}

///
// ������� ��� ���������� �������
///
function ScopeOn()
{
	if (bHasScope && !bZoomed && (Owner != None) && Owner.IsA('DeusExPlayer'))
	{
		bZoomed = True;
		RefreshScopeDisplay(DeusExPlayer(Owner), False, bZoomed);
	}
}

function ScopeOff()
{
	if (bHasScope && bZoomed && (Owner != None) && Owner.IsA('DeusExPlayer'))
	{
		bZoomed = False;
                RefreshScopeDisplay(DeusExPlayer(Owner), False, bZoomed);
	}
}

// ----------------------------------------------------------------------
// RefreshScopeDisplay()
// ----------------------------------------------------------------------
simulated function RefreshScopeDisplay(DeusExPlayer player, bool bInstant, bool bScopeOn)
{
	if (bScopeOn && (player != None))
	{
		DeusExRootWindow(player.rootWindow).scopeView.ActivateView(ScopeFOV, False, bInstant);
	}
   else if (!bScopeOn)
   {
   DeusExrootWindow(player.rootWindow).scopeView.DeactivateView();
   }
}

//-----------------------------------------------------
// ����������� ���� ����������� �� ���� ��������
//-----------------------------------------------------
function name WeaponDamageType()
{
	local name                    damageType;
	local Class<DeusExProjectile> projClass;

	projClass = Class<DeusExProjectile>(ProjectileClass);
	if (bInstantHit)
	{
		if (StunDuration > 0)
			damageType = 'Stunned';
		else
			damageType = 'Shot';

		if (AmmoType != None)
			if (AmmoType.IsA('RAmmoSabot') || AmmoType.IsA('RAmmo3006Ultra'))
				damageType = 'Sabot';
	}
	else if (projClass != None)
		damageType = projClass.Default.damageType;
	else
		damageType = 'None';

	return (damageType);
}

//-----------------------------------------------------
// ������ ���� �� ���������
//-----------------------------------------------------
function SpawnEffects(Vector HitLocation, Vector HitNormal, Actor Other, float Damage)
{
        local TraceHitter hitspawner;
	local Name damageType;
        local DeusExPlayer pl;

	damageType = WeaponDamageType();


   if (bPenetrating)
   {
      if (bHandToHand)
      {
             hitspawner = Spawn(class'Game.TraceHitterHandSpawner',Other,,HitLocation,Rotator(HitNormal));
      }
      else
      {
             hitspawner = Spawn(class'Game.TraceHitter',Other,,HitLocation,Rotator(HitNormal));
      }
   }
   else
   {
      if (bHandToHand)
      {
         hitspawner = Spawn(class'Game.TraceHitterHandNon',Other,,HitLocation,Rotator(HitNormal));
      }
      else
      {
         hitspawner = Spawn(class'Game.TraceHitterNon',Other,,HitLocation,Rotator(HitNormal));
      }
   }
   if (hitSpawner != None)
	{
      hitspawner.HitDamage = Damage;
		hitSpawner.damageType = damageType;
	}
	if (bHandToHand)
	{

		/*if (Other.IsA('DeusExDecoration'))
			Owner.PlaySound(Misc3Sound, SLOT_None,,, 1024);
		else if (Other.IsA('Pawn'))
			Owner.PlaySound(Misc1Sound, SLOT_None,,, 1024);
		else if (Other.IsA('BreakableGlass'))
			Owner.PlaySound(sound'GlassHit1', SLOT_None,,, 1024);
		else if (GetWallMaterial(HitLocation, HitNormal) == 'Glass')
			Owner.PlaySound(sound'BulletProofHit', SLOT_None,,, 1024);
		else
			Owner.PlaySound(Misc2Sound, SLOT_None,,, 1024);*/

		if (Other.IsA('DeusExDecoration')){
			Owner.PlaySound(Misc3Sound, SLOT_None,,, 1024);
		}
		else if (Other.IsA('Pawn')){
			Owner.PlaySound(Misc1Sound, SLOT_None,,, 1024);
		}
		//else if (Other.IsA('DeusExMover') && Other(DeusExMover).FragmentClass==Class'DeusEx.GlassFragment'){
		//	Owner.PlaySound(sound'GlassHit1', SLOT_None,,, 1024);
		//}
		else if (GetWallMaterial(HitLocation, HitNormal) == 'Glass')
			Owner.PlaySound(sound'GlassHit1', SLOT_None,,, 1024);
		else
			Owner.PlaySound(Misc2Sound, SLOT_None,,, 1024);
	}
}

function SetSkins()
{
	local int     i;
	local texture curSkin;

	if(!Owner.IsA('DeusExPlayer')) return;

	for (i=0; i<8; i++)
	{
		if(!bHasMuzzleFlash || (bHasMuzzleFlash && i != MuzzleMaterial))
		{
			if(bNewSkin && bPlayerViewSkinned && PlayerViewSkins[i] != None)
				NormalPlayerViewSkins[i] = PlayerViewSkins[i];
			else
				NormalPlayerViewSkins[i] = MultiSkins[i];
		}
	}
		
	NormalPlayerViewSkins[8] = Skin;
	NormalPlayerViewSkins[9] = Texture;

	for (i=0; i<8; i++)
	{
		if(!bHasMuzzleFlash || (bHasMuzzleFlash && i != MuzzleMaterial))
		{
			curSkin = GetMeshTexture(i);
			CamoPlayerViewSkins[i] = GetGridTexture(curSkin);
		}
	}
	
	CamoPlayerViewSkins[8] = GetGridTexture(NormalPlayerViewSkins[8]);
	CamoPlayerViewSkins[9] = GetGridTexture(NormalPlayerViewSkins[9]);
	
	Style = STY_Translucent;
}

function ResetSkins()
{
	local int i;

	if(!Owner.IsA('DeusExPlayer')) return;

	for (i=0; i<8; i++)
		if((!bHasMuzzleFlash) || (bHasMuzzleFlash && i != MuzzleMaterial))
			MultiSkins[i] = NormalPlayerViewSkins[i];
		
	Skin = NormalPlayerViewSkins[8];
	Texture = NormalPlayerViewSkins[9];
	
	Style = Default.Style;
}

function Texture GetGridTexture(Texture tex)
{
	if (tex == None)
		return FireTexture'GameEffects.InvisibleTex';
		//return Texture'BlackMaskTex';
	else if (tex == Texture'BlackMaskTex')
		return Texture'BlackMaskTex';
	else if (tex == Texture'GrayMaskTex')
		return Texture'BlackMaskTex';
	else if (tex == Texture'PinkMaskTex')
		return Texture'BlackMaskTex';
	else
		return FireTexture'GameEffects.InvisibleTex';
}

function bool IsValidLockTarget(Actor Target)
{
	if(Target == None)
		return false;
		
	if(DeusExPlayer(Owner) != None)
	{
		return (Target.IsA('ScriptedPawn') && !ScriptedPawn(Target).bCloakOn);
	}
	else if(ScriptedPawn(Owner) != None)
	{
		return (Target.IsA('DeusExPlayer') && !DeusExPlayer(Target).IsInvisibleForCreatures());
	}
	
	return false;
}

simulated function Tick(float deltaTime)
{
	local vector loc;
	local rotator rot;
	local float beepspeed, recoil;
	local DeusExPlayer player;
    local Actor RealTarget;
	local Pawn pawn;
    local int i;
	local rotator recoilOffset;

	player = DeusExPlayer(Owner);
	pawn = Pawn(Owner);

	if(LORes3rdMesh != None){
		if(LOResPickupMesh != None && HIResPickupMesh != None && HIRes3rdMesh != None){
    			if (DeusExPlayer(GetPlayerPawn()).bNoResurrection)
   			{
   				PickupViewMesh=LOResPickupMesh;
    				ThirdPersonMesh=LORes3rdMesh;
    			}
    			else
    			{
   				if(bHasScope && (PlusPickupMesh != None && Plus3rdMesh != None))
				{
					PickupViewMesh=PlusPickupMesh;
					ThirdPersonMesh=Plus3rdMesh;
				}
				else
				{
					PickupViewMesh=HIResPickupMesh;
					ThirdPersonMesh=HIRes3rdMesh;
				}
    			}
		}
	}

	if(player != None)
	{
		if((player.AugmentationSystem != None && player.AugmentationSystem.GetClassLevel(class'AugCloak') >= 0) || player.UsingChargedPickup(class'AdaptiveArmor'))
		{
			if(!bWeaponInvisible)
			{
				SetSkins();				
				bWeaponInvisible = True;	
			}	
		}
		else
		{
			if(bWeaponInvisible)
			{
				ResetSkins();				
				bWeaponInvisible = False;	
			}	
		}
	}
	else if(pawn == None)
	{
		//No owner, so we are probably being dropped
		if(bWeaponInvisible)
		{
			ResetSkins();				
			bWeaponInvisible = False;
		}
	}

	if(bWeaponInvisible)
	{
		for (i=0; i<8; i++)
			MultiSkins[i] = CamoPlayerViewSkins[i];

		Skin = CamoPlayerViewSkins[8];
		Texture = CamoPlayerViewSkins[9];
		
		Style = STY_Translucent;
	}
	else
	{
		Style = Default.Style;
	}

	Super(Weapon).Tick(deltaTime);

	HandleAmmunition();

	if (pawn == None)
	{
		LockMode = LOCK_None;
		MaintainLockTimer = 0;
		LockTarget = None;
		LockTimer = 0;
		return;
	}

	if (pawn.Weapon != self)
	{
		LockMode = LOCK_None;
		MaintainLockTimer = 0;
		LockTarget = None;
		LockTimer = 0;
		return;
	}

	if (ClipCount < ReloadCount)
	{
		if (bHandToHand && (ProjectileClass != None) && (!Self.IsA('WeaponThrowingKnife')))
		{
			if (NearWallCheck())
			{
				if (!bNearWall || (AnimSequence == 'Select'))
				{
					PlayAnim('PlaceBegin',, 0.1);
					bNearWall = True;
				}
			}
			else
			{
				if (bNearWall)
				{
					PlayAnim('PlaceEnd',, 0.1);
					bNearWall = False;
				}
			}
		}


      SoundTimer += deltaTime;

      if ( (Level.Netmode == NM_Standalone) || ( (Player != None) && (Player.PlayerIsClient()) ) )
      {
         if (bCanTrack)
         {
            Target = AcquireTarget();
            RealTarget = Target;

            if (Target != None)
               TargetRange = Abs(VSize(Target.Location - Location));

            MaintainLockTimer -= deltaTime;

            if ((Target == None) || IsInState('Reload'))
            {
               if (MaintainLockTimer <= 0)
               {
                  SetLockMode(LOCK_None);
                  MaintainLockTimer = 0;
                  LockTarget = None;
               }
               else if (LockMode == LOCK_Locked)
                  Target = LockTarget;
            }
            else if ((Target != LockTarget) && (IsValidLockTarget(Target)) && (LockMode == LOCK_Locked))
            {
               SetLockMode(LOCK_None);
               LockTarget = None;
            }
            else if (!IsValidLockTarget(Target))
            {
               if (MaintainLockTimer <=0 )
                  SetLockMode(LOCK_Invalid);
            }
            else
            {
               if (TargetRange > MaxRange)
               {
                  SetLockMode(LOCK_Range);
               }
               else
               {
                  if (LockTimer == 0)
                     LockTime = FMax(Default.LockTime + 3.0 * GetWeaponSkill(), 0.0);

                  LockTimer += deltaTime;
                  
                  if (LockTimer >= LockTime)
                     SetLockMode(LOCK_Locked);
                  else
                     SetLockMode(LOCK_Acquire);
               }
            }

            switch (LockMode)
            {
	            case LOCK_None:
	               TargetMessage = msgNone;
	               LockTimer -= deltaTime;
	               break;
	
	            case LOCK_Invalid:
	               TargetMessage = msgLockInvalid;
	               LockTimer -= deltaTime;
	               break;
	
	            case LOCK_Range:
	               TargetMessage = msgLockRange @ Int(TargetRange/16) @ msgRangeUnit;
	               LockTimer -= deltaTime;
	               break;
	
	            case LOCK_Acquire:
	               TargetMessage = msgLockAcquire @ Left(String(LockTime-LockTimer), 4) @ msgTimeUnit;
	               beepspeed = FClamp((LockTime - LockTimer) / Default.LockTime, 0.2, 1.0);
	               
	               if (SoundTimer > beepspeed)
	               {
	                  Owner.PlaySound(TrackingSound, SLOT_None);
	                  SoundTimer = 0;
	               }
	               
	               break;
	
	            case LOCK_Locked:
	               if ((RealTarget != None) && ((RealTarget == LockTarget) || (LockTarget == None)))
	               {
	                  if (Level.NetMode != NM_Standalone)
	                     MaintainLockTimer = default.MaintainLockTimer;
	                  else
	                     MaintainLockTimer = 0;
	                     
	                  LockTarget = Target;
	               }
	               
	               TargetMessage = msgLockLocked @ Int(TargetRange/16) @ msgRangeUnit;
	               break;
            }
         }
         else
         {
            LockMode = LOCK_None;
            TargetMessage = msgNone;
            LockTimer = 0;
            MaintainLockTimer = 0;
            LockTarget = None;
         }

         if (LockTimer < 0)
            LockTimer = 0;
      }
   }
   else
   {
      LockMode = LOCK_None;
      TargetMessage=msgNone;
      MaintainLockTimer = 0;
      LockTarget = None;
      LockTimer = 0;
   }

   if ((LockMode == LOCK_Locked) && (SoundTimer > 0.1) && (Role == ROLE_Authority))
   {
      PlayLockSound();
      SoundTimer = 0;
   }

	currentAccuracy = CalculateAccuracy();

	if (player != None)
	{
		recoil = recoilStrength + ModRecoilStrength + GetWeaponSkill() * 2.0;
		
		if (recoil < 0.05)
			recoil = 0.05;

		if (bFiring && IsAnimating() && (AnimSequence == 'Shoot') && (recoil > 0.0) && (shotPeriod <= ShotTime))
		{
			shotPeriod += deltaTime;
			
			recoilOffset = CalculateRecoil(FMin(1.0, FMax(0.0, shotPeriod / ShotTime)));
			
			player.ViewRotation.Yaw += deltaTime * recoilOffset.Yaw * recoil;
			player.ViewRotation.Pitch += deltaTime * recoilOffset.Pitch * recoil;
			
			if ((player.ViewRotation.Pitch > 16384) && (player.ViewRotation.Pitch < 32768))
				player.ViewRotation.Pitch = 16384;
		}
	}



	//if (player != None)
	//{

	if (VSize(Owner.Velocity) < 10){
		if(!bFiring)
			standingTimer += deltaTime;
	}
	else
		standingTimer = FMax(0, standingTimer - 0.03*deltaTime*VSize(Owner.Velocity));

	if(standingTimer > 5)
		standingTimer = 5;

	if(IsInState('Reload'))
		standingTimer = 0;

	//}


	tickTime = deltaTime;


	if (bLasing || bZoomed)
	{
		if (ShakeTimer > 0.25)
		{
			ShakeYaw = currentAccuracy * (Rand(4096) - 2048);
			ShakePitch = currentAccuracy * (Rand(4096) - 2048);
			ShakeTimer -= 0.25;
		}

		ShakeTimer += deltaTime;

		if (bLasing && (Emitter != None))
		{
			loc = Owner.Location;
			loc.Z += Pawn(Owner).BaseEyeHeight;

			rot = Pawn(Owner).ViewRotation;
			rot.Yaw += Rand(5) - 2;
			rot.Pitch += Rand(5) - 2;

			Emitter.SetLocation(loc);
			Emitter.SetRotation(rot);
		}

		if ((player != None) && bZoomed)
		{
			player.ViewRotation.Yaw += deltaTime * ShakeYaw;
			player.ViewRotation.Pitch += deltaTime * ShakePitch;
		}
	}

}

function BecomePickup()
{
	local int i;

	bPlayerViewSkinned = False;

	super.BecomePickup();

	if(bNewSkin)
		for(i=0;i<8;i++)
			MultiSkins[i]=PickupViewSkins[i];
}

function BecomeItem()
{
	local int i;

	bPlayerViewSkinned = True;

	super.BecomeItem();

	if(bNewSkin && Owner.IsA('DeusExPlayer'))
		for(i=0;i<8;i++)
			MultiSkins[i]=PlayerViewSkins[i];
}

simulated function TraceFire(float Accuracy)
{
	local vector HitLocation, HitNormal, StartTrace, EndTrace, X, Y, Z;
	local Rotator rot;
	local actor Other;
	local float dist, alpha, degrade;
	local int i, numSlugs;
	local float volume, radius;

	BulletDegrade = 0;

	if (/*!bHasSilencer && */!bHandToHand)
	{
		GetAIVolume(volume, radius);
		Owner.AISendEvent('WeaponFire', EAITYPE_Audio, volume, radius);
		Owner.AISendEvent('LoudNoise', EAITYPE_Audio, volume, radius*2);
		if (!Owner.IsA('PlayerPawn'))
			Owner.AISendEvent('Distress', EAITYPE_Audio, volume, radius*2);
	}

	GetAxes(Pawn(owner).ViewRotation,X,Y,Z);
	StartTrace = ComputeProjectileStart(X, Y, Z);
	AdjustedAim = pawn(owner).AdjustAim(1000000, StartTrace, 2.75*AimError, False, False);

	if (AreaOfEffect == AOE_Cone && AmmoName != Class'RAmmoSabot')
		numSlugs = NumConeSlugs;
	else
		numSlugs = 1;

	//else if (bLasing || bZoomed)
	//	Accuracy = 0.0;

	for (i=0; i<numSlugs; i++)
	{

      if ((i > 0) && (Level.NetMode == NM_Standalone) && !(bHandToHand))
         if (Accuracy < MinSpreadAcc)
            Accuracy = MinSpreadAcc;

      if ((bHandToHand) && (NumSlugs > 1) && (Level.NetMode != NM_Standalone))
      {
         StartTrace = ComputeProjectileStart(X,Y,Z);
         StartTrace = StartTrace + (numSlugs/2 - i) * SwingOffset;
      }

      EndTrace = StartTrace + Accuracy * (FRand()-0.5)*Y*1000 + Accuracy * (FRand()-0.5)*Z*1000 ;
      EndTrace += (FMax(1024.0, MaxRange) * vector(AdjustedAim));
      
      Other = Pawn(Owner).TraceShot(HitLocation,HitNormal,EndTrace,StartTrace);

		if ( (FRand() < 0.3) /*&& (!bZoomed && (numSlugs == 1))*/ )
		{
			if ((AmmoName == Class'RAmmo10mm') || (AmmoName == Class'RAmmo10mmJHP') || (AmmoName == Class'RAmmo3006') || (AmmoName == Class'RAmmo3006Ultra') || (AmmoName == Class'RAmmo556mm') || (AmmoName == Class'RAmmo556mmJHP') || (AmmoName == Class'RAmmo762mm') || (AmmoName == Class'RAmmo762mmB'))
			{
				if (VSize(HitLocation - StartTrace) > 250)
				{
				   rot = Rotator(EndTrace - StartTrace);
				   
				   if (Self.IsA('WeaponSniperRifle'))
	               {
	                  Spawn(class'SniperTracer',,, StartTrace + 96 * Vector(rot), rot);
	               }
	               else
	               {
	                  Spawn(class'Tracer',,, StartTrace + 96 * Vector(rot), rot);
	               }
				}
			}
		}
		else{
			if ((AmmoName == Class'RAmmo10mm') || (AmmoName == Class'RAmmo3006') || (AmmoName == Class'RAmmo10mmJHP') || (AmmoName == Class'RAmmo556mm') || (AmmoName == Class'RAmmo556mmJHP') || (AmmoName == Class'RAmmo762mm') || (AmmoName == Class'RAmmo762mmB')/* || (AmmoName == Class'RAmmoShell') || (AmmoName == Class'RAmmoSabot')*/)
			{
				if (VSize(HitLocation - StartTrace) > 250)
				{
					//for (i=0; i<=numSlugs; i++){
						rot = Rotator(EndTrace - StartTrace);
						Spawn(class'InvisibleTracer',,, StartTrace + 96 * Vector(rot), rot);
					//}
				}
			}
		}

		dist = Abs(VSize(HitLocation - Owner.Location));
		

		if (dist <= AccurateRange)
			ProcessTraceHit(Other, HitLocation, HitNormal, vector(AdjustedAim),Y,Z);
		else if (dist <= MaxRange)
		{
			alpha = (dist - AccurateRange) / (MaxRange - AccurateRange);
			degrade = 1.5 * Square(alpha);
			BulletDegrade = alpha;
			HitLocation.Z -= Abs(degrade * (Owner.Location.Z - Owner.CollisionHeight));
			ProcessTraceHit(Other, HitLocation, HitNormal, vector(AdjustedAim),Y,Z);
		}

		//Pawn(Owner).ClientMessage( dist @ "(" @ dist/52.5 @ ") " @ alpha );
	}
}

simulated function ProcessTraceHit(Actor Other, Vector HitLocation, Vector HitNormal, Vector X, Vector Y, Vector Z)
{
	local float        mult;
	local name         damageType;
	local DeusExPlayer dxPlayer;
	local float degrade;
	local float humMult;

	if (Other != None)
	{
		degrade = 0;

		if(BulletDegrade > 0)
			degrade = BulletDegrade * HitDamage;

		// AugMuscle increases our damage if hand to hand
		mult = 1.0;
		if (bMeleeDamage && (DeusExPlayer(Owner) != None) && DeusExPlayer(Owner).AugmentationSystem.GetClassLevel(class'AugMuscle') >= 1)
		{
			if(!IsA('WeaponRiotProd'))
			{
				mult = DeusExPlayer(Owner).AugmentationSystem.GetAugLevelValue(class'AugMuscle');
				if (mult == -1.0)
					mult = 1.0;
			}
		}

		// skill also affects our damage
		// GetWeaponSkill returns 0.0 to -0.7 (max skill/aug)
		//mult += -2.0 * GetWeaponSkill();
		
		humMult = 1.0;
		
		if(Other == None || !Other.IsA('Pawn') || Other.IsA('Robot'))
			humMult = NonHumanDamageMultiplier;
		
		if(!bMeleeDamage || (bMeleeDamage && Other != None && Other.IsA('Pawn') && !Other.IsA('Robot')))
			mult += Abs(GetWeaponSkill());		

		// Determine damage type
		damageType = WeaponDamageType();

		if (Other != None)
		{
			if (Other.bOwned)
			{
				dxPlayer = DeusExPlayer(Owner);
				if (dxPlayer != None)
					dxPlayer.AISendEvent('Futz', EAITYPE_Visual);
			}
		}
		if ((Other == Level) || (Other.IsA('Mover')))
		{	
			if ( Role == ROLE_Authority )
				Other.TakeDamage(HitDamage * humMult * mult - degrade, Pawn(Owner), HitLocation, 1000.0*X, damageType);

			SelectiveSpawnEffects( HitLocation, HitNormal, Other, HitDamage * humMult * mult);
		}
		else if ((Other != self) && (Other != Owner))
		{
			if ( Role == ROLE_Authority )
				Other.TakeDamage(HitDamage * humMult * mult - degrade, Pawn(Owner), HitLocation, 1000.0*X, damageType);

			if (bHandToHand)
				SelectiveSpawnEffects( HitLocation, HitNormal, Other, HitDamage * humMult * mult - degrade);

			if (bPenetrating && Other.IsA('Pawn') && !Other.IsA('Robot'))
				SpawnBlood(HitLocation, HitNormal);
		}

		//if(bMeleeDamage)
			//Pawn(Owner).ClientMessage(HitDamage * mult - degrade $ "");
	}


	if(DeusExMPGame(Level.Game) != None)
	{
		if (DeusExPlayer(Other) != None)
			DeusExMPGame(Level.Game).TrackWeapon(self,HitDamage * humMult * mult * degrade);
		else
			DeusExMPGame(Level.Game).TrackWeapon(self,0);
	}
}

simulated function SawedOffCockSound()
{
	if ((AmmoType.AmmoAmount > 0) && (WeaponShotGun(Self) != None))
		Owner.PlaySound(SelectSound, SLOT_None,,, 1024);
}

simulated function Projectile ProjectileFire(class<projectile> ProjClass, float ProjSpeed, bool bWarn)
{
	local Vector Start, X, Y, Z;
	local DeusExProjectile proj;
	local float mult;
	local float volume, radius;
	local int i, numProj;
	local Pawn aPawn;

	mult = 1.0;
	if (bHandToHand && (DeusExPlayer(Owner) != None) && DeusExPlayer(Owner).AugmentationSystem.GetClassLevel(class'AugMuscle') >= 1)
	{
		mult = DeusExPlayer(Owner).AugmentationSystem.GetAugLevelValue(class'AugMuscle');
		if (mult == -1.0)
			mult = 1.0;
		ProjSpeed *= mult;
	}

	mult += -2.0 * GetWeaponSkill();

	if (/*!bHasSilencer && */!bHandToHand)
	{
		GetAIVolume(volume, radius);
		Owner.AISendEvent('WeaponFire', EAITYPE_Audio, volume, radius);
		Owner.AISendEvent('LoudNoise', EAITYPE_Audio, volume, radius*2);
		if (!Owner.IsA('PlayerPawn'))
			Owner.AISendEvent('Distress', EAITYPE_Audio, volume, radius*2);
	}

	if (AreaOfEffect == AOE_Cone)
		numProj = 3;
	else
		numProj = 1;

	GetAxes(Pawn(owner).ViewRotation,X,Y,Z);
	Start = ComputeProjectileStart(X, Y, Z);

	for (i=0; i<numProj; i++)
	{
      if ((i > 0) && (Level.NetMode != NM_Standalone))
         if (currentAccuracy < MinProjSpreadAcc)
            currentAccuracy = MinProjSpreadAcc;
         
		AdjustedAim = pawn(owner).AdjustAim(ProjSpeed, Start, AimError, True, bWarn);
		AdjustedAim.Yaw += currentAccuracy * (Rand(1024) - 384);
		AdjustedAim.Pitch += currentAccuracy * (Rand(1024) - 384);


		if (( Level.NetMode == NM_Standalone ) || ( Owner.IsA('DeusExPlayer') && DeusExPlayer(Owner).PlayerIsListenClient()) )
		{
			proj = DeusExProjectile(Spawn(ProjClass, Owner,, Start, AdjustedAim));
			if (proj != None)
			{
				proj.Damage *= mult;

				if (bCanTrack && (LockTarget != None) && (LockMode == LOCK_Locked))
				{
					proj.Target = LockTarget;
					proj.bTracking = True;
				}
			}
		}
		else
		{
			if (( Role == ROLE_Authority ) || (DeusExPlayer(Owner) == DeusExPlayer(GetPlayerPawn())) )
			{
				if ( bCanTrack || Self.IsA('WeaponThrowingKnife') || Self.IsA('WeaponCrossbow') || Self.IsA('WeaponLAMGrenade') || Self.IsA('WeaponPulseGrenade') || Self.IsA('WeaponRiotGrenade') || Self.IsA('WeaponNapalmGrenade') || Self.IsA('WeaponRadioGrenade'))
				{
					if ( Role == ROLE_Authority )
					{
						proj = DeusExProjectile(Spawn(ProjClass, Owner,, Start, AdjustedAim));
						if (proj != None)
						{
								proj.Damage *= mult;

							if (bCanTrack && (LockTarget != None) && (LockMode == LOCK_Locked))
							{
								proj.Target = LockTarget;
								proj.bTracking = True;
							}
						}
					}
				}
				else
				{
					proj = DeusExProjectile(Spawn(ProjClass, Owner,, Start, AdjustedAim));
					if (proj != None)
					{
						proj.RemoteRole = ROLE_None;

						if ( Role == ROLE_Authority )
							proj.Damage *= mult;
						else
							proj.Damage = 0;
					}
					if ( Role == ROLE_Authority )
					{
						for ( aPawn = Level.PawnList; aPawn != None; aPawn = aPawn.nextPawn )
						{
							if ( aPawn.IsA('DeusExPlayer') && ( DeusExPlayer(aPawn) != DeusExPlayer(Owner) ))
								DeusExPlayer(aPawn).ClientSpawnProjectile( ProjClass, Owner, Start, AdjustedAim );
						}
					}
				}
			}
		}

	}
	return proj;
}

function Fire(float Value)
{
	local float sndVolume;
	local bool bListenClient;

	if (Self.IsA('WeaponBotSuperRocket'))
	{
		if(!bRocketLaunchOn)
		{
			bRocketLaunchOn = True;
			if(ScriptedPawn(Owner) != None) ScriptedPawn(Owner).bRocketLaunchOn = True;
			StartRocketLaunch();
		}
		
		return;
	}

	bListenClient = (Owner.IsA('DeusExPlayer') && DeusExPlayer(Owner).PlayerIsListenClient());

	sndVolume = TransientSoundVolume;

	if ((EnviroEffective == ENVEFF_Air) || (EnviroEffective == ENVEFF_Vacuum) || (EnviroEffective == ENVEFF_AirVacuum))
	{
		if (Region.Zone.bWaterZone)
		{
			if (Pawn(Owner) != None)
			{
				Pawn(Owner).ClientMessage(msgNotWorking);
				if (!bHandToHand)
					PlaySimSound( Misc1Sound, SLOT_None, sndVolume, 1024 );
			}
			GotoState('Idle');
			return;
		}
	}


	if (bHandToHand)
	{
		if (ReloadCount > 0)
			AmmoType.UseAmmo(1);

		bReadyToFire = False;
		GotoState('NormalFire');
		bPointing=True;
		if ( Owner.IsA('PlayerPawn') )
			PlayerPawn(Owner).PlayFiring();
		PlaySelectiveFiring();
		PlayFiringSound();
	}
	else if ((ClipCount < ReloadCount) || (ReloadCount == 0))
	{
		if ((ReloadCount == 0) || AmmoType.UseAmmo(1))
		{
			if (( Level.NetMode != NM_Standalone ) && !bListenClient )
				bClientReady = False;

			ClipCount++;
			bFiring = True;
			bReadyToFire = False;
			GotoState('NormalFire');
			
			if (( Level.NetMode == NM_Standalone ) || ( Owner.IsA('DeusExPlayer') && DeusExPlayer(Owner).PlayerIsListenClient()) )
			{
				if ( PlayerPawn(Owner) != None )
				{
					PlayerPawn(Owner).ShakeView(ShakeTime, currentAccuracy * ShakeMag + ShakeMag + (ShakeMag * GetWeaponSkill() * 2), currentAccuracy * ShakeVert);
					shotPeriod = 0.0;
					//...
				}
			}
			
			bPointing=True;
			if (bInstantHit)
				TraceFire(currentAccuracy);
			else
				ProjectileFire(ProjectileClass, ProjectileSpeed, bWarnTarget);
                 		bFired=true;

			if (Owner.IsA('PlayerPawn'))
				PlayerPawn(Owner).PlayFiring();

			if (RAmmo20mm(AmmoType) == None)
				PlaySelectiveFiring();

			PlayFiringSound();
			if ( Owner.bHidden )
				CheckVisibility();
		}
		else
			PlaySimSound( Misc1Sound, SLOT_None, sndVolume, 1024 );
	}
	else
		PlaySimSound( Misc1Sound, SLOT_None, sndVolume, 1024 );

	if (DeusExPlayer(Owner) != None)
		DeusExPlayer(Owner).UpdateBeltText(Self);
}



simulated function bool ClientFire( float value )
{
	local bool bWaitOnAnim;
	local vector shake;

	if ((EnviroEffective == ENVEFF_Air) || (EnviroEffective == ENVEFF_Vacuum) || (EnviroEffective == ENVEFF_AirVacuum))
	{
		if (Region.Zone.bWaterZone)
		{
			if (Pawn(Owner) != None)
			{
				Pawn(Owner).ClientMessage(msgNotWorking);
				if (!bHandToHand)
					PlaySimSound( Misc1Sound, SLOT_None, TransientSoundVolume * 2.0, 1024 );
			}
			return false;
		}
	}
	
	/*if(Self.IsA('WeaponBotSuperRocket') && bRocketLaunchOn)
	{
		bWaitOnAnim = True;
	}
	else */if ( !bLooping )
	{
		bWaitOnAnim = ( IsAnimating() && ((bOldStyle && (AnimSequence == 'Shoot')) || ((AnimSequence == 'Select') || (AnimSequence == 'ReloadBegin') || (AnimSequence == 'Reload') || (AnimSequence == 'ReloadEnd') || (AnimSequence == 'Down'))));
	}
	else
	{
		bWaitOnAnim = False;
		bLooping = False;
	}

	if ( (Owner.IsA('DeusExPlayer') && (DeusExPlayer(Owner).NintendoImmunityTimeLeft > 0.01)) ||
		  (!bClientReadyToFire) || bInProcess || bWaitOnAnim)
	{
		DeusExPlayer(Owner).bJustFired = False;
		bPointing = False;
		bFiring = False;
		return false;
	}

	if ( !Self.IsA('WeaponFireThrower') )
		ServerForceFire();

	if (bHandToHand)
	{
		SimAmmoAmount = AmmoType.AmmoAmount - 1;

		bClientReadyToFire = False;
		bInProcess = True;
		GotoState('ClientFiring');
		bPointing = True;
		if ( PlayerPawn(Owner) != None )
			PlayerPawn(Owner).PlayFiring();
		PlaySelectiveFiring();
		PlayFiringSound();
	}
	else if ((ClipCount < ReloadCount) || (ReloadCount == 0))
	{
		if ((ReloadCount == 0) || (AmmoType.AmmoAmount > 0))
		{
			SimClipCount = ClipCount + 1;

			if ( AmmoType != None )
				AmmoType.SimUseAmmo();

			bFiring = True;
			bPointing = True;
			bClientReadyToFire = False;
			bInProcess = True;
			GotoState('ClientFiring');
			if ( PlayerPawn(Owner) != None )
			{
				shake.X = 0.0;
				shake.Y = 100.0 * (ShakeTime*0.5);
				shake.Z = 100.0 * -(currentAccuracy * ShakeVert);
				PlayerPawn(Owner).ClientShake( shake );
				PlayerPawn(Owner).PlayFiring();
			}

			if ( RAmmo20mm(AmmoType) == None )
				PlaySelectiveFiring();

			PlayFiringSound();

			if ( bInstantHit &&  ( RAmmo20mm(AmmoType) == None ))
				TraceFire(currentAccuracy);
			else
			{
				if ( !bFlameOn && Self.IsA('WeaponFireThrower'))
				{
					bFlameOn = True;
					StartFlame();
				}
				
				ProjectileFire(ProjectileClass, ProjectileSpeed, bWarnTarget);
			}

		}
		else
		{
			if ( Owner.IsA('DeusExPlayer') && DeusExPlayer(Owner).bAutoReload )
			{
				if ( MustReload() && CanReload() )
				{
					bClientReadyToFire = False;
					bInProcess = False;
					if ((AmmoType.AmmoAmount == 0) && (AmmoName != AmmoNames[0]))
						CycleAmmo();

					ReloadAmmo();
				}
			}
			PlaySimSound( Misc1Sound, SLOT_None, TransientSoundVolume * 2.0, 1024 );
		}
	}
	else
	{
		if ( Owner.IsA('DeusExPlayer') && DeusExPlayer(Owner).bAutoReload )
		{
			if ( MustReload() && CanReload() )
			{
				bClientReadyToFire = False;
				bInProcess = False;
				if ((AmmoType.AmmoAmount == 0) && (AmmoName != AmmoNames[0]))
					CycleAmmo();
				ReloadAmmo();
			}
		}
		PlaySimSound( Misc1Sound, SLOT_None, TransientSoundVolume * 2.0, 1024 );		// play dry fire sound
	}
	return true;
}

function bool LoadAmmo(int ammoNum)
{
	local class<Ammo> newAmmoClass;
	local Ammo newAmmo;
	local Pawn P;

	if ((ammoNum < 0) || (ammoNum > 2))
		return False;

	P = Pawn(Owner);

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
				bInstantHit = False;
				bAutomatic = False;
				ShotTime = 1.0;
				if (HasReloadMod())
					ReloadTime = 2.0 * (1.0+ModReloadTime);
				else
					ReloadTime = 2.0;
				FireSound = None;
				ProjectileClass = ProjectileNames[ammoNum];
				ProjectileSpeed = ProjectileClass.Default.Speed;
			}

			AmmoName = newAmmoClass;
			AmmoType = newAmmo;

			if ( Level.NetMode != NM_Standalone )
				SetClienTAmmoParams( bInstantHit, bAutomatic, ShotTime, FireSound, ProjectileClass, ProjectileSpeed );

			if (DeusExPlayer(P) != None)
				DeusExPlayer(P).UpdateBeltText(Self);

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

simulated function PlayFiringSound()
{
	if (bMeleeDamage && TruePlayer(Owner) != None && TruePlayer(Owner).AugmentationSystem.GetClassLevel(class'AugMuscle') >= 1)
	{
		PlaySound(Sound'GameMedia.Misc.RobotLegs4', SLOT_None, 0.5, , 1200, (1.0 - 0.1*FRand()) * TruePlayer(GetPlayerPawn()).GetSoundPitchMultiplier());
	}
	
	PlaySimSound(FireSound, SLOT_None, TransientSoundVolume, 2048 * NoiseLevel);
}

function GetAIVolume(out float volume, out float radius)
{
	volume = 0;
	radius = 0;

	if (!bHandToHand)
	{
		volume = NoiseLevel*Pawn(Owner).SoundDampening;
		radius = volume * 1200.0;
	}
}

simulated function int PlaySimSound( Sound snd, ESoundSlot Slot, float Volume, float Radius )
{
	if ( Owner != None )
	{
		if ( Level.NetMode == NM_Standalone )
			return ( Owner.PlaySound( snd, Slot, Volume, , Radius, TruePlayer(GetPlayerPawn()).GetSoundPitchMultiplier() ) );
		else
		{
			Owner.PlayOwnedSound( snd, Slot, Volume, , Radius, TruePlayer(GetPlayerPawn()).GetSoundPitchMultiplier() );
			return 1;
		}
	}
	return 0;
}

state FlameThrowerOn
{
	function float GetShotTime()
	{
		local float mult, sTime;

		if (ScriptedPawn(Owner) != None)
			return ShotTime * (ScriptedPawn(Owner).BaseAccuracy*2+1);
		else
		{
			// AugCombat decreases shot time
			mult = 1.0;
			if (bHandToHand && DeusExPlayer(Owner) != None)
			{
				mult = 1.0 / DeusExPlayer(Owner).AugmentationSystem.GetAugLevelValue(class'AugCombat');
				if (mult == -1.0)
					mult = 1.0;
			}
			//sTime = ShotTime * mult;
			sTime = ShotTime;
			return (sTime);
		}
	}
Begin:
	if ( (DeusExPlayer(Owner).Health > 0) && bFlameOn && (ClipCount < ReloadCount))
	{
		if (( flameShotCount == 0 ) && (Owner != None))
		{
			PlayerPawn(Owner).PlayFiring();
			PlaySelectiveFiring();
			PlayFiringSound();
			flameShotCount = 6;
		}
		else
			flameShotCount--;

		Sleep( GetShotTime() );
		GenerateBullet();
		goto('Begin');
	}
Done:
	bFlameOn = False;
	GotoState('FinishFire');
}

simulated function DecreaseAmmo()
{
	AmmoType.UseAmmo(1);
	if ( AmmoType.AmmoAmount <= 0 )
		Destroy();
}

state NormalFire
{
	function AnimEnd()
	{
		if (bAutomatic)
		{
if(bOldStyle)
{
			if ((Pawn(Owner).bFire != 0) && (AmmoType.AmmoAmount > 0))
			{
				if (PlayerPawn(Owner) != None)
					Global.Fire(0);
				else 
					GotoState('FinishFire');
			}
			else 
				GotoState('FinishFire');
}

if (bHasMuzzleFlash)
	EraseMuzzleFlashTexture();
		}
		else
		{
			if (bHandToHand && (ReloadCount > 0) && (AmmoType.AmmoAmount <= 0) && !IsA('WeaponRiotProd'))
				Destroy();
		}
	}
	function float GetShotTime()
	{
		local float mult, sTime;

		if (ScriptedPawn(Owner) != None)
			return ShotTime;
		else
		{
			mult = 1.0;
			if (bHandToHand && DeusExPlayer(Owner) != None && DeusExPlayer(Owner).AugmentationSystem.GetClassLevel(class'AugMuscle') >= 1)
			{
				mult = 1.0 / DeusExPlayer(Owner).AugmentationSystem.GetAugLevelValue(class'AugMuscle');
				if (mult == -1.0)
					mult = 1.0;
			}
			sTime = ShotTime * mult;
			return (sTime);
		}
	}

Begin:

	if ((ClipCount >= ReloadCount) && (ReloadCount != 0))
	{
		if(!bAutomatic)
		{
			bFiring = False;
			FinishAnim();
		}

		if (Owner != None)
		{
			if (Owner.IsA('DeusExPlayer'))
			{
				bFiring = False;

				if (DeusExPlayer(Owner).bAutoReload)
				{
					if ((AmmoType.AmmoAmount == 0) && (AmmoName != AmmoNames[0]))
						CycleAmmo();
					ReloadAmmo();
				}
				else
				{
					if (bHasMuzzleFlash)
						EraseMuzzleFlashTexture();
					GotoState('Idle');
				}
			}
			else if (Owner.IsA('ScriptedPawn'))
			{
				bFiring = False;
				ReloadAmmo();
			}
		}
		else
		{
			if (bHasMuzzleFlash)
				EraseMuzzleFlashTexture();

			GotoState('Idle');
		}
	}

	if(bAutomatic && (( Level.NetMode == NM_DedicatedServer ) || ((Level.NetMode == NM_ListenServer) && Owner.IsA('DeusExPlayer') && !DeusExPlayer(Owner).PlayerIsListenClient())))
		GotoState('Idle');

	standingTimer -= standingTimer*ShotDeaccuracy*2;
SwapMuzzleFlashTexture2();
	Sleep(GetShotTime());
EraseMuzzleFlashTexture2();

	if(bOldStyle && bAutomatic)
	{
		GenerateBullet();
		Goto('Begin');
	}

	bFiring = False;

	if(bOldStyle)
		FinishAnim();

	if ((ReloadCount == 0) && !bHandToHand)
	{
		if (DeusExPlayer(Owner) != None)
			DeusExPlayer(Owner).RemoveItemFromSlot(Self);

		Destroy();
	}
	ReadyToFire();
Done:
	bFiring = False;
	Finish();
}

simulated state ClientFiring
{
	simulated function AnimEnd()
	{
		/*if(Self.IsA('WeaponBotSuperRocket') && bRocketLaunchOn)
			return;*/
			
		bInProcess = False;

		if (bAutomatic)
		{
			if ((Pawn(Owner).bFire != 0) && (AmmoType.AmmoAmount > 0))
			{
				if (PlayerPawn(Owner) != None)
					ClientReFire(0);
				else
					GotoState('SimFinishFire');
			}
			else 
				GotoState('SimFinishFire');
		}
	}
	simulated function float GetSimShotTime()
	{
		local float mult, sTime;

		if (ScriptedPawn(Owner) != None)
			return ShotTime;
		else
		{
			mult = 1.0;
			if (bHandToHand && DeusExPlayer(Owner) != None && DeusExPlayer(Owner).AugmentationSystem.GetClassLevel(class'AugMuscle') >= 1)
			{
				mult = 1.0 / DeusExPlayer(Owner).AugmentationSystem.GetAugLevelValue(class'AugMuscle');
				if (mult == -1.0)
					mult = 1.0;
			}
			sTime = ShotTime * mult;
			return (sTime);
		}
	}
Begin:

	if ((ClipCount >= ReloadCount) && (ReloadCount != 0))
	{
		if (!bAutomatic)
		{
			bFiring = False;
			FinishAnim();
		}

		if (Owner != None)
		{
			if (Owner.IsA('DeusExPlayer'))
			{
				bFiring = False;
				if (DeusExPlayer(Owner).bAutoReload)
				{
					bClientReadyToFire = False;
					bInProcess = False;
					if ((AmmoType.AmmoAmount == 0) && (AmmoName != AmmoNames[0]))
						CycleAmmo();
					ReloadAmmo();
					GotoState('SimQuickFinish');
				}
				else
				{
					if (bHasMuzzleFlash)
						EraseMuzzleFlashTexture();
					IdleFunction();
					GotoState('SimQuickFinish');
				}
			}
			else if (Owner.IsA('ScriptedPawn'))
			{
				bFiring = False;
			}
		}
		else
		{
			if (bHasMuzzleFlash)
				EraseMuzzleFlashTexture();
			IdleFunction();
			GotoState('SimQuickFinish');
		}
	}

	standingTimer -= standingTimer*ShotDeaccuracy*2;

	Sleep(GetSimShotTime());

	if(bOldStyle && bAutomatic)
	{
		SimGenerateBullet();
		Goto('Begin');
	}

	bFiring = False;

	if(bOldStyle)
		FinishAnim();

	bInProcess = False;
Done:
	bInProcess = False;
	bFiring = False;
	SimFinish();
}

simulated function PlaySelectiveFiring()
{
	local Pawn aPawn;
	local Name anim;

	anim = ShootAnim;

	if (bHandToHand)
	{
		anim = GetMeleeAttackAnim();
	}

	if(Self.IsA('WeaponRiotProd') || Self.IsA('WeaponFireThrower') || Self.IsA('WeaponMace'))
	{
		LoopAnim('Shoot', ShootAnimRate, 0.25);
	}
	else if (bOldStyle && bAutomatic)
	{//Pawn(Owner).ClientMessage("1");
		LoopAnim(anim,, 0.1);
	}
	else if(bOldStyle && bHandToHand)
	{//Pawn(Owner).ClientMessage("2");
		PlayAnim(anim,,0.1);
	}
	else
	{//Pawn(Owner).ClientMessage("3");
		//PlayAnim(anim,,0.1);
		PlayAnim('Shoot', ShootAnimRate, 0.01);
	}
}

function Name GetMeleeAttackAnim()
{
	local Name anim;
	local float rnd;
	
	rnd = FRand();
	if (rnd < 0.33)
		anim = 'Attack';
	else if (rnd < 0.66)
		anim = 'Attack2';
	else
		anim = 'Attack3';
		
	return anim;
}

simulated function float CalculateAccuracy()
{
	local float accuracy;
	local float tempacc, div;
   	local float weapskill;
	local int HealthArmRight, HealthArmLeft, HealthHead;
	local int BestArmRight, BestArmLeft, BestHead;
	local bool checkit, checkwithperk;
	local DeusExPlayer player;

	accuracy = BaseAccuracy;
  	weapskill = GetWeaponSkill();
  	
	if (DeusExPlayer(Owner) != None)
	{
		player = DeusExPlayer(Owner);
		accuracy += weapskill;

		HealthArmRight = player.HealthArmRight;
		HealthArmLeft  = player.HealthArmLeft;
		HealthHead     = player.HealthHead;
		BestArmRight   = player.Default.HealthArmRight;
		BestArmLeft    = player.Default.HealthArmLeft;
		BestHead       = player.Default.HealthHead;
		checkit = True;
	}
	else if (ScriptedPawn(Owner) != None)
	{
		accuracy += ScriptedPawn(Owner).BaseAccuracy;

		HealthArmRight = ScriptedPawn(Owner).HealthArmRight;
		HealthArmLeft  = ScriptedPawn(Owner).HealthArmLeft;
		HealthHead     = ScriptedPawn(Owner).HealthHead;
		BestArmRight   = ScriptedPawn(Owner).Default.HealthArmRight;
		BestArmLeft    = ScriptedPawn(Owner).Default.HealthArmLeft;
		BestHead       = ScriptedPawn(Owner).Default.HealthHead;
		checkit = True;
	}
	else
		checkit = False;

	checkwithperk = False;

	if (DeusExPlayer(Owner) != None && DeusExPlayer(Owner).PerkSystem != None)
		if(DeusExPlayer(Owner).PerkSystem.CheckPerkState(class'PerkMarksman'))
			checkwithperk = True;

	if(checkit)
	{
		if (HealthArmRight < 1)
			accuracy += 0.5;
		else if(!checkwithperk)
		{
			if (HealthArmRight < BestArmRight * 0.34)
				accuracy += 0.2;
			else if (HealthArmRight < BestArmRight * 0.67)
				accuracy += 0.1;
		}

		if (HealthArmLeft < 1)
			accuracy += 0.5;
		else if(!checkwithperk)
		{
			if (HealthArmLeft < BestArmLeft * 0.34)
				accuracy += 0.2;
			else if (HealthArmLeft < BestArmLeft * 0.67)
				accuracy += 0.1;
		}

		if ((HealthHead < BestHead * 0.67) && !checkwithperk)
			accuracy += 0.1;
	}

	tempacc = accuracy;

	if (ScriptedPawn(Owner) != None)
	{
		//weapskill = DeusExPlayer(GetPlayerPawn()).SkillSystem.GetSkillFromClass(GoverningSkill).LevelValues[int(ScriptedPawn(Owner).Skill-1)];
		weapskill = 0;
	}
		
	if (standingTimer > 0)
	{
		div = Max(10.0 + 29.0 * weapskill, 0.0);
		accuracy -= FClamp(standingTimer/div, 0.0, 0.4);
	}

	if ((accuracy < 0.1) && (tempacc > 0.1))
		accuracy = 0.1;	
			
	if ((accuracy > 1.0) && (tempacc < 1.0))
		accuracy = 1.0;

	if (accuracy < 0.0)
		accuracy = 0.0;

	if(accuracy < GetMinWeaponAccuracy())
		accuracy = GetMinWeaponAccuracy();

	return accuracy;
}

function float GetMinWeaponAccuracy()
{
	local float value;

	if (DeusExPlayer(Owner) != None)
	{
		if(bHasScope && !bZoomed)
		{
			return 1.0;
		}
		else if (MinWeaponAcc > 0.0 && MinWeaponAcc < 1.0)
		{
			if(DeusExPlayer(Owner).SkillSystem.GetSkillLevel(GoverningSkill) == 3) return 0.0;
			
			value = MinWeaponAcc + (DeusExPlayer(Owner).SkillSystem.GetSkillLevelValue(GoverningSkill) * 0.3);
			
			if(value < 0.05)
				value = 0.05;
				
			if(value > 0.5)
				value = 0.5;
				
			return value;
		}
	}
	
	return MinWeaponAcc;
}

simulated function float GetWeaponSkill()
{
	local DeusExPlayer player;
	local float value;

	value = 0;

	if (Owner != None)
	{
		player = DeusExPlayer(Owner);
		
		if(player != None)
		{
			if((player.AugmentationSystem != None ) && ( player.SkillSystem != None ))
			{
				/*value = player.AugmentationSystem.GetAugLevelValue(class'AugTarget');
				if (value == -1.0)
					value = 0;*/
					
				value = 0;

				if(GoverningSkill == Class'DeusEx.SkillMedicine')
					value += player.SkillSystem.GetAltSkillLevelValue(GoverningSkill);
				else
					value += player.SkillSystem.GetSkillLevelValue(GoverningSkill);
			}
		}
		else if(ScriptedPawn(Owner) != None)
		{
			value = 0;
			//value = DeusExPlayer(GetPlayerPawn()).SkillSystem.GetSkillFromClass(GoverningSkill).LevelValues[int(ScriptedPawn(Owner).Skill-1)];
		}
	}
	
	return value;
}

simulated function bool ClientAltFire(float Value){}
function AltFire(float Value){ClientAltFire(Value);}

// ----------------------------------------------------------------------
// UpdateInfo()
// ----------------------------------------------------------------------

simulated function bool UpdateInfo(Object winObject)
{
	local PersonaInventoryInfoWindow winInfo;
	local string str;
	local int i, dmg;
	local float mod, mult;
	local bool bHasAmmo;
	local bool bAmmoAvailable;
	local class<DeusExAmmo> ammoClass;
	local Pawn P;
	local Ammo weaponAmmo;
	local int  ammoAmount;
	local int ammonum;
	local bool bUseNewSystem;
	local float size;
	local bool bShowAmmoList;
	local bool bNonHuman;

	bUseNewSystem = False;
	bShowAmmoList = False;

	P = Pawn(Owner);
	if (P == None)
		return False;

	winInfo = PersonaInventoryInfoWindow(winObject);
	if (winInfo == None)
		return False;

	winInfo.SetTitle(itemName);
	winInfo.SetText(msgInfoWeaponStats);
	winInfo.AddLine();

	// Create the ammo buttons.  Start with the AmmoNames[] array,
	// which is used for weapons that can use more than one 
	// type of ammo.

	if (AmmoNames[0] != None && AmmoNames[1] != None)
	{
		bShowAmmoList = True;
	}

	if (AmmoNames[0] != None)
	{
		for (i=0; i<ArrayCount(AmmoNames); i++)
		{
			if (AmmoNames[i] != None) 
			{
				// Check to make sure the player has this ammo type
				// *and* that the ammo isn't empty
				weaponAmmo = Ammo(P.FindInventoryType(AmmoNames[i]));

				if (weaponAmmo != None)
				{
					ammoAmount = weaponAmmo.AmmoAmount;
					bHasAmmo = (weaponAmmo.AmmoAmount > 0);
				}
				else
				{
					ammoAmount = 0;
					bHasAmmo = False;
				}

				if(bShowAmmoList)
					winInfo.AddAmmo(AmmoNames[i], bHasAmmo, ammoAmount);
					
				bAmmoAvailable = True;

				if (AmmoNames[i] == AmmoName)
				{
					if(bShowAmmoList)
						winInfo.SetLoaded(AmmoName);
					ammoClass = class<DeusExAmmo>(AmmoName);
				}
			}
		}
	}
	else
	{
		// Now peer at the AmmoName variable, but only if the AmmoNames[] 
		// array is empty
		if ((AmmoName != class'AmmoNone') && (!bHandToHand) && (ReloadCount != 0))
		{	
			weaponAmmo = Ammo(P.FindInventoryType(AmmoName));

			if (weaponAmmo != None)
			{
				ammoAmount = weaponAmmo.AmmoAmount;
				bHasAmmo = (weaponAmmo.AmmoAmount > 0);
			}
			else
			{
				ammoAmount = 0;
				bHasAmmo = False;
			}

			if(bShowAmmoList)
			{
				winInfo.AddAmmo(AmmoName, bHasAmmo, ammoAmount);
				winInfo.SetLoaded(AmmoName);
			}
			
			ammoClass = class<DeusExAmmo>(AmmoName);
			bAmmoAvailable = True;
		}
	}

	// Only draw another line if we actually displayed ammo.
	if (bAmmoAvailable && bShowAmmoList)
		winInfo.AddLine();	

	// Ammo loaded
	if ((AmmoName != class'AmmoNone') && (!bHandToHand) && (ReloadCount != 0) && bShowAmmoList)
		winInfo.AddAmmoLoadedItem(msgInfoAmmoLoaded, AmmoType.itemName);

	// ammo info
	if ((AmmoName == class'AmmoNone') || bHandToHand || (ReloadCount == 0)){
		//str = msgInfoNA;
	}
	else
		str = AmmoName.Default.ItemName;

	if(bShowAmmoList)
	{
		for (i=0; i<ArrayCount(AmmoNames); i++)
			if ((AmmoNames[i] != None) && (AmmoNames[i] != AmmoName))
				str = str $ "|n" $ AmmoNames[i].Default.ItemName;
	
		for (i=0; i<ArrayCount(AmmoNames); i++)
			if ((AmmoNames[i] != None) && (AmmoNames[i] == AmmoName)){
				ammonum = i;
				bUseNewSystem = True;
				break;
			}
	}

	//if(!bHandToHand)
	//	winInfo.AddAmmoTypesItem(msgInfoAmmo, str);

	// base damage
	if (AreaOfEffect == AOE_Cone && AmmoName != Class'RAmmoSabot')
	{
		if (bInstantHit)
		{
			if(bUseNewSystem)
			{
				dmg = Default.ShotDamage[ammonum] * NumConeSlugs;
				str = String(Default.ShotDamage[ammonum]) $ "*" $ String(NumConeSlugs);	
			}
			else
			{
				dmg = Default.HitDamage * NumConeSlugs;
				str = String(Default.HitDamage) $ "*" $ String(NumConeSlugs);	
			}			
		}
		else
		{
			if(bUseNewSystem)
				dmg = Default.ShotDamage[ammonum] * 3;
			else
				dmg = Default.HitDamage * 3;
				
			str = String(dmg);
		}
	}
	else
	{
		if(bUseNewSystem)
			dmg = Default.ShotDamage[ammonum];
		else
			dmg = Default.HitDamage;
			
		str = String(dmg);
	}

	bNonHuman = (NonHumanDamageMultiplier > 1.0 || NonHumanDamageMultiplier < 1.0);

	if(bNonHuman)
	{
		dmg *= NonHumanDamageMultiplier;
		str = String(dmg);
	}

	mult = 1.0;

	if (bMeleeDamage && (DeusExPlayer(Owner) != None) && DeusExPlayer(Owner).AugmentationSystem.GetClassLevel(class'AugMuscle') >= 1)
	{
		if(!IsA('WeaponRiotProd'))
		{
			mod = DeusExPlayer(Owner).AugmentationSystem.GetAugLevelValue(class'AugMuscle');
			if (mod > 1.0) mult = mod;
		}
	}

	if (!bNonHuman)
		mult += Abs(GetWeaponSkill());

	if (mult != 1.0)
	{
		str = str @ BuildPercentString(mult - 1.0);
		str = str @ "=" @ FormatFloatString(dmg * mult, 1.0);
	}
	else if (AreaOfEffect == AOE_Cone && AmmoName != Class'RAmmoSabot')
	{
		str = str @ "=" @ FormatFloatString(dmg, 1.0);
	}

	if(dmg > 0 && !bIsGrenade)
	{
		if(IsA('WeaponThrowingKnife'))
			winInfo.AddInfoItem(msgInfoHumanDamage, str, (mult != 1.0));
		else
			winInfo.AddInfoItem(msgInfoDamage, str, (mult != 1.0));
	}







	if(bMeleeDamage)
	{
		dmg = Default.HitDamage;			
		str = String(dmg);
		
		mult = 1.0;
	
		if (DeusExPlayer(Owner) != None && DeusExPlayer(Owner).AugmentationSystem.GetClassLevel(class'AugMuscle') >= 1)
		{
			if(!IsA('WeaponRiotProd'))
			{
				mod = DeusExPlayer(Owner).AugmentationSystem.GetAugLevelValue(class'AugMuscle');
				if (mod > 1.0) mult = mod;
			}
		}

		mult += Abs(GetWeaponSkill());
	
		if (mult != 1.0)
		{
			str = str @ BuildPercentString(mult - 1.0);
			str = str @ "=" @ FormatFloatString(dmg * mult, 1.0);
		}
	
		if(dmg > 0) winInfo.AddInfoItem(msgInfoHumanDamage, str, (mult != 1.0));
	}







	// clip size
	if ((Default.ReloadCount == 0) || bHandToHand)
	{
		str = msgInfoNA;
	}
	else
	{
		if ( Level.NetMode != NM_Standalone )
			str = String(Default.mpReloadCount);// @ msgInfoRounds;
		else
			str = String(Default.ReloadCount);// @ msgInfoRounds;
	}

	if (HasClipMod())
	{
		str = str @ BuildPercentString(ModReloadCount);
		str = str @ "=" @ String(ReloadCount);// @ msgInfoRounds;
	}

	if(!bHandToHand && !bHideInfo && Default.ReloadCount >= 2 && !bMeleeDamage)
		winInfo.AddInfoItem(msgInfoClip, str, HasClipMod());

	// rate of fire
	if ((Default.ReloadCount == 0) || bHandToHand)
	{
		//str = msgInfoNA;
	}
	else
	{
		if (bAutomatic)
			str = msgInfoAuto;
		else
			str = msgInfoSingle;

		str = /*str $ "," @*/ FormatFloatString(1.0/Default.ShotTime, 0.1) @ msgInfoRoundsPerSec;
	}
	
	if(!bHandToHand && !bHideInfo && Default.ReloadCount >= 2 && !bMeleeDamage)
		winInfo.AddInfoItem(msgInfoROF, str);

	// reload time
	if ((Default.ReloadCount == 0) || bHandToHand)
	{
		//str = msgInfoNA;
	}
	else
	{
		if (Level.NetMode != NM_Standalone )
			str = FormatFloatString(Default.mpReloadTime, 0.1) @ msgTimeUnit;
		else
			str = FormatFloatString(Default.ReloadTime, 0.1) @ msgTimeUnit;
	}

	if (HasReloadMod())
	{
		str = str @ BuildPercentString(ModReloadTime);
		str = str @ "=" @ FormatFloatString(ReloadTime, 0.1) @ msgTimeUnit;
	}

	if(!bHandToHand && !bHideInfo && !bMeleeDamage)
		winInfo.AddInfoItem(msgInfoReload, str, HasReloadMod());

	// recoil
	if(bUseNewSystem)
		size = Default.ShotRecoil[ammonum];
	else
		size = Default.recoilStrength;

	//str = FormatFloatString(size, 0.01);
	str = String(/*Int(100 * size)*/100) $ "%";
	mod = ModRecoilStrength + GetWeaponSkill() * 2.0;

	if (mod < -0.95) mod = -0.95;

	if (mod != 0.0)
	{
		str = str @ BuildPercentString(mod);
		str = str @ "=" @ String(100 - Int(Abs(Int(100 * mod /*(size + (size*mod))*/)))) $ "%";//FormatFloatString(size + (size*mod), 0.001);
	}

	if(!bHandToHand && !bHideInfo && bCanHaveModRecoilStrength && !bMeleeDamage)
		winInfo.AddInfoItem(msgInfoRecoil, str, (mod != 0.0));

	// base accuracy (2.0 = 0%, 0.0 = 100%)
	str = Int((2.0 - Default.BaseAccuracy)*50.0) $ "%";
	mod = (Default.BaseAccuracy - (BaseAccuracy + GetWeaponSkill())) * 0.5;
	if (mod != 0.0)
	{
		str = str @ BuildPercentString(mod);
		str = str @ "=" @ Min(100, Int(100.0*mod+(2.0 - Default.BaseAccuracy)*50.0)) $ "%";
	}
	
	if(!bHandToHand && !bHideInfo)
		winInfo.AddInfoItem(msgInfoAccuracy, str, (mod != 0.0));

	// accurate range
	if (bHandToHand)
	{
		//str = msgInfoNA;
	}
	else
	{
		if (Level.NetMode != NM_Standalone)
			str = FormatFloatString(Default.mpAccurateRange/52.5, 1.0) @ msgRangeUnit;
		else
			str = FormatFloatString(Default.AccurateRange/52.5, 1.0) @ msgRangeUnit;
	}

	if (HasRangeMod())
	{
		str = str @ BuildPercentString(ModAccurateRange);
		str = str @ "=" @ FormatFloatString(AccurateRange/52.5, 1.0) @ msgRangeUnit;
	}
	
	//if(!bHandToHand && !bHideInfo)
	//	winInfo.AddInfoItem(msgInfoAccRange, str, HasRangeMod());

	// max range
	if (bHandToHand)
	{
		//str = msgInfoNA;
	}
	else
	{
		if ( Level.NetMode != NM_Standalone )
			str = FormatFloatString(Default.mpMaxRange/52.5, 1.0) @ msgRangeUnit;
		else
			str = FormatFloatString(Default.MaxRange/52.5, 1.0) @ msgRangeUnit;
	}
	
	if(!bHandToHand && !bHideInfo && !bMeleeDamage)
		winInfo.AddInfoItem(msgInfoAccRange, str); //msgInfoMaxRange

	if(!bHandToHand && RealMass > 0)
		winInfo.AddInfoItem(msgInfoMass, FormatFloatString(Default.RealMass, 0.1) @ msgMassUnit);

	// laser mod
	/*if (bCanHaveLaser)
	{
		if (bHasLaser)
			str = msgInfoYes;
		else
			str = msgInfoNo;
	}
	else
	{
		str = msgInfoNA;
	}
	winInfo.AddInfoItem(msgInfoLaser, str, bCanHaveLaser && bHasLaser && (Default.bHasLaser != bHasLaser));*/

	// scope mod
	if (bCanHaveScope)
	{
		if (bHasScope)
			str = msgInfoYes;
		else
			str = msgInfoNo;
	}
	else
	{
		str = msgInfoNA;
	}
	
	if(!bHandToHand && !bHideInfo && bHasScope)
		winInfo.AddInfoItem(msgInfoScope, str, bCanHaveScope && bHasScope && (Default.bHasScope != bHasScope));

	// silencer mod
	/*if (bCanHaveSilencer)
	{
		if (bHasSilencer)
			str = msgInfoYes;
		else
			str = msgInfoNo;
	}
	else
	{
		str = msgInfoNA;
	}
	winInfo.AddInfoItem(msgInfoSilencer, str, bCanHaveSilencer && bHasSilencer && (Default.bHasSilencer != bHasSilencer));*/

	// Governing Skill
	winInfo.AddInfoItem(msgInfoSkill, GoverningSkill.default.SkillName);

	winInfo.AddLine();
	winInfo.SetText(Description);

	// If this weapon has ammo info, display it here
	if (ammoClass != None && bShowAmmoList)
	{
		winInfo.AddLine();
		winInfo.AddAmmoDescription(ammoClass.Default.ItemName $ "|n" $ ammoClass.Default.description);
	}

	return True;
}

simulated function IdleFunction()
{
	PlayIdleAnim();
	bInProcess = False;
	if ( bFlameOn )
	{
		StopFlame();
		bFlameOn = False;
	}
	
	if ( bRocketLaunchOn )
	{
		StopRocketLaunch();
		bRocketLaunchOn = False;
		if(ScriptedPawn(Owner) != None) ScriptedPawn(Owner).bRocketLaunchOn = False;
	}
}

simulated function SimFinish()
{
	ServerGotoFinishFire();

	bInProcess = False;
	bFiring = False;

	if ( bFlameOn )
	{
		StopFlame();
		bFlameOn = False;
	}
	
	if ( bRocketLaunchOn )
	{
		StopRocketLaunch();
		bRocketLaunchOn = False;
		if(ScriptedPawn(Owner) != None) ScriptedPawn(Owner).bRocketLaunchOn = False;
	}

	if (bHasMuzzleFlash)
		EraseMuzzleFlashTexture();

	if ( Owner.IsA('DeusExPlayer') && DeusExPlayer(Owner).bAutoReload )
	{
		if ( (SimClipCount >= ReloadCount) && CanReload() )
		{
			SimClipCount = 0;
			bClientReadyToFire = False;
			bInProcess = False;
			if ((AmmoType.AmmoAmount == 0) && (AmmoName != AmmoNames[0]))
				CycleAmmo();
			ReloadAmmo();
		}
	}

	if (Pawn(Owner) == None)
	{
		GotoState('SimIdle');
		return;
	}
	if ( PlayerPawn(Owner) == None )
	{
		if ( (Pawn(Owner).bFire != 0) && (FRand() < RefireRate) )
			ClientReFire(0);
		else
			GotoState('SimIdle');
		return;
	}
	if ( Pawn(Owner).bFire != 0 )
		ClientReFire(0);
	else
		GotoState('SimIdle');
}

function StartRocketLaunch()
{
}

function StopRocketLaunch()
{
}

function rotator CalculateRecoil(float shotState)
{
	local rotator recoil;
	
	recoil.Yaw = Cos(PI * 0.5 * shotState) * (Rand(20000) - 10000);
	recoil.Pitch = Cos(PI * 0.5 * shotState) * (27000 + Rand(9000));
	
	return recoil;
}

simulated function float GetReloadingAnimRate()
{
	local DeusExPlayer player;
	local float value;
	
	value = 1.0;
	
	player = DeusExPlayer(Owner);
	
	if (GoverningSkill != Class'DeusEx.SkillMedicine' && player != None && player.SkillSystem != None)
	{
		value = 1.0 - (player.SkillSystem.GetSkillLevelValue(GoverningSkill) * 2);
	}
	
	return value;	
}

simulated event RenderOverlays(canvas Canvas)
{
	local int i;
	
	if ( Owner == None )
		return;
	if ( (Level.NetMode == NM_Client) && (!Owner.IsA('DeusExPlayer') || (PlayerPawn(Owner).Player == None)) )
		return;
	
	if ( DeusExPlayer(Owner) == None )
		return;
		
	SetLocation( Owner.Location + CalcDrawOffset() );
	SetRotation( Pawn(Owner).ViewRotation );
	
	if(!bWeaponInvisible && bNewSkin && bPlayerViewSkinned)
	{
		for (i=0; i<8; i++) MultiSkins[i] = PlayerViewSkins[i];
	}
	
	Canvas.DrawActor(self, false);
	
	if(!bWeaponInvisible && bNewSkin && bPlayerViewSkinned)
	{
		for (i=0; i<8; i++) MultiSkins[i] = PickupViewSkins[i];
	}
}

defaultproperties
{
     ShootAnim='Shoot'
     ShootAnimRate=1.0
     ShotDeaccuracy=0.0
     ShotDamage(0)=10
     ShotDamage(1)=10
     ShotDamage(2)=10
     ShotUntargeting(0)=0
     ShotUntargeting(1)=0
     ShotUntargeting(2)=0
     NoiseVolume(0)=0
     NoiseVolume(1)=0
     NoiseVolume(2)=0
     NoiseVolumeSilenced(0)=0
     NoiseVolumeSilenced(1)=0
     NoiseVolumeSilenced(2)=0
     ShotShake(0)=0
     ShotShake(1)=0
     ShotShake(2)=0
     ShotRecoil(0)=0
     ShotRecoil(1)=0
     ShotRecoil(2)=0
     ShotSound(0)=None
     ShotSound(1)=None
     ShotSound(2)=None
     ShotSoundSilenced(0)=None
     ShotSoundSilenced(1)=None
     ShotSoundSilenced(2)=None
     bSemiAutomatic=False
     bOldStyle=False
     HIResPickupMesh=None
     LOResPickupMesh=None
     HIRes3rdMesh=None
     LORes3rdMesh=None
     PlusPickupMesh=None
     Plus3rdMesh=None
     bInstantHit=True
     bAltInstantHit=True
     bAutomatic=True
     MuzzleMaterial=2
     bReadyToFire=True
     LowAmmoWaterMark=10
     NoiseLevel=1.000000
     ShotTime=0.500000
     reloadTime=1.000000
     HitDamage=10
     maxRange=9600
     AccurateRange=4800
     BaseAccuracy=0.500000
     ScopeFOV=10
     MaintainLockTimer=1.000000
     EnviroEffective=ENVEFF_Air
     bPenetrating=True
     bHasMuzzleFlash=True
     bEmitWeaponDrawn=True
     bUseWhileCrouched=True
     bUseAsDrawnWeapon=True
     MinSpreadAcc=0.250000
     MinProjSpreadAcc=1.000000
     bHasPuff=True
     bNeedToSetMPPickupAmmo=True
     msgNone=""
     ReloadCount=10
     shakevert=10.000000
     Misc1Sound=Sound'DeusExSounds.Generic.DryFire'
     AutoSwitchPriority=0
     bRotatingPickup=False
     LandSound=Sound'DeusExSounds.Generic.DropSmallWeapon'
     bNoSmooth=False
     Mass=10.000000
     RealMass=3.0
     Buoyancy=5.000000
     MuzzleFlashStyle=STY_Masked
}
