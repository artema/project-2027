//=============================================================================//
//             ����� ����� ������. �������� Ded'�� ��� ���� 2027               //
//                  New Player Class. Copyright (C) 2005 Ded                   //
//=============================================================================//
class TruePlayer extends JCDentonMale
	config(user);

#exec OBJ LOAD FILE=GameEffects

//=======================================================//
                     //=����������=//

var bool bTimeActive;
var bool bCamo;
var bool bGhost;
var bool bFly;
var bool bThirdView;
var bool bSubmarine;
var input byte bScopeIn; 
var input byte bScopeOut;
var Inventory item;
var travel bool bTPHasItems;
var bool bBerserkActive;
var float MaxBloodRegen;
var float BloodRegenRate;
var localized String msgBloodCritical;
var localized String msgEnergy;
var localized String msgCheatsActivated;
var localized String msgDieworld;
var localized String msgTimeFast;
var localized String msgTimeSlow;
var localized String msgTimeNormal;
var localized String msgSubmarineOn;
var localized String msgSubmarineOff;
var localized String msgGodOn;
var localized String msgGodOff;
var localized String msgInvisibleOn;
var localized String msgInvisibleOff;
var localized String msgGhost;
var localized String msgGhostOff;
var localized String msgFly;
var localized String msgFlyOff;
var localized String msgFirstView;
var localized String msgThirdView;
var localized String msgHasAllAmmo;
//var localized String msgHeroLevelAward;
var float BloodLosses;
var float BloodRegen;
var float BloodMax;
var float Blood;
var String   strIntroMap;
var String   strTrainingMap;
var bool bShadowKilled;

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

function Texture GetGridTexture(Texture tex)
{
	if (tex == None)
		return Texture'BlackMaskTex';
	else if (tex == Texture'BlackMaskTex')
		return Texture'BlackMaskTex';
	else if (tex == Texture'GrayMaskTex')
		return Texture'BlackMaskTex';
	else if (tex == Texture'PinkMaskTex')
		return Texture'BlackMaskTex';
	else
		return FireTexture'GameEffects.InvisibleTex';
}

function UpdateTranslucency(float DeltaTime)
{
   local float DarkVis;
   local float CamoVis;
   local AdaptiveArmor armor;
   local bool bMakeTranslucent;
   local DeusExMPGame Game;
   local int i,j;
   
   bMakeTranslucent = false;

   //Check cloaking.
   if (AugmentationSystem.GetAugLevelValue(class'AugCloak') != -1.0)
   {
      bMakeTranslucent = TRUE;
   }
   
   // go through the actor list looking for owned AdaptiveArmor
   // since they aren't in the inventory anymore after they are used
   if (UsingChargedPickup(class'AdaptiveArmor'))
      {
         CamoVis = CamoVis * Game.CloakEffect;
         bMakeTranslucent = TRUE;
      }

   //Translucent is < 0.1, untranslucent if > 0.2, not same edge to prevent sharp breaks.
   if (bMakeTranslucent)
   {
   	  ScaleGlow = 0.2;
      Style = STY_Translucent;
      
      if (Self.IsA('JCDentonMale'))
      {
      	for (i=0; i<6; i++)
			MultiSkins[i] = GetGridTexture(MultiSkins[i]);
		
         MultiSkins[6] = Texture'BlackMaskTex';
         MultiSkins[7] = Texture'BlackMaskTex';
      }
   }
   else
   {
      if (Self.IsA('JCDentonMale'))
      {     	
      	j=8;
      	
      	if(PlayerSkin == 1 || PlayerSkin == 2)
      		j=6;
      	
      	for (i=1; i<j; i++)
			MultiSkins[i] = Default.MultiSkins[i];
			
		switch(PlayerSkin)
		{
			case 0:	
			MultiSkins[0] = Texture'DanielTex0_0'; 		
			break;
			
			case 1:	
			MultiSkins[0] = Texture'GameMedia.Characters.DanielTex0_1'; 
			MultiSkins[6] = Texture'DeusExCharacters.Skins.FramesTex2'; 
			MultiSkins[7] = Texture'DeusExCharacters.Skins.LensesTex3'; 
			break;
			
			case 2:	
			MultiSkins[0] = Texture'GameMedia.Characters.DanielTex0_2'; 
			MultiSkins[6] = Texture'GameMedia.Characters.FramesSquare'; 
			MultiSkins[7] = Texture'DeusExCharacters.Skins.LensesTex3'; 
			break;
		}
      }
      
      ScaleGlow = Default.ScaleGlow;
      Style = Default.Style;
   }
}

/////////////////////////////////////////////////////////////////////////
// ����� ������� ��������� � �������                                   //
/////////////////////////////////////////////////////////////////////////
function RemoveItemDuringConversation(Inventory item)
{
	if (item != None)
	{
		if (item == inHand)
			PutInHand(None);

		RemoveItemFromSlot(item);

		if (item.IsA('DeusExWeapon'))
		{
			DeusExWeapon(item).ScopeOff();
			DeusExWeapon(item).LaserOff();

		}
		else if (item.IsA('DeusExPickup'))
		{
			if (DeusExPickup(item).bActive)
				DeusExPickup(item).Activate();
		}
		else if (item.IsA('WeaponGuidGun'))
		{
                         WeaponGuidGun(item).TrackOff();

		}
		
	}
}

/////////////////////////////////////////////////////////////////////////
// ����� ������� ��� ��������                                          //
/////////////////////////////////////////////////////////////////////////
state Conversation
{
ignores SeePlayer, HearNoise, Bump;

	event PlayerTick(float deltaTime)
	{
		local rotator tempRot;
		local float   yawDelta;

		UpdateInHand();
		UpdateDynamicMusic(deltaTime);

		DrugEffects(deltaTime);
		Bleed(deltaTime);
		MaintainEnergy(deltaTime);

		ViewFlash(deltaTime);

		CheckActiveConversationRadius();
	
		CheckActorDistances();

		Super.PlayerTick(deltaTime);
		LipSynch(deltaTime);

		if (ConversationActor != None)
		{
			LookAtActor(ConversationActor, true, true, true, 0, 0.5);

			tempRot = rot(0,0,0);
			tempRot.Yaw = (DesiredRotation.Yaw - Rotation.Yaw) & 65535;
			if (tempRot.Yaw > 32767)
				tempRot.Yaw -= 65536;
			yawDelta = RotationRate.Yaw * deltaTime;
			if (tempRot.Yaw > yawDelta)
				tempRot.Yaw = yawDelta;
			else if (tempRot.Yaw < -yawDelta)
				tempRot.Yaw = -yawDelta;
			SetRotation(Rotation + tempRot);
		}

		UpdateTimePlayed(deltaTime);
	}

	function LoopHeadConvoAnim()
	{
	}

	function EndState()
	{
		conPlay = None;

		MakePlayerIgnored(false);

		MoveTarget = None;
		bBehindView = false;
		StopBlendAnims();
		ConversationActor = None;
	}

Begin:
	Velocity.X = 0;
	Velocity.Y = 0;
	Velocity.Z = 0;

	Acceleration = Velocity;

	PlayRising();

	if (bOnFire)
	ExtinguishFire();

	MakePlayerIgnored(true);

	LookAtActor(conPlay.startActor, true, false, true, 0, 0.5);

	SetRotation(DesiredRotation);

	PlayTurning();

	if (!conPlay.StartConversation(Self))
	{
		AbortConversation(True);
	}
        else
	{
		if ( conPlay.GetDisplayMode() == DM_ThirdPerson )
		{
			bBehindView = true;
			DroneDisabled();	
		}
	}
	
        if (item != None)
	{
		if (item == inHand)
			PutInHand(None);

		RemoveItemFromSlot(item);

		if (item.IsA('DeusExWeapon'))
		{
			DeusExWeapon(item).ScopeOff();
			DeusExWeapon(item).LaserOff();

		}
		else if (item.IsA('DeusExPickup'))
		{
			if (DeusExPickup(item).bActive)
				DeusExPickup(item).Activate();
		}
		else if (item.IsA('WeaponGuidGun'))
		{
                         WeaponGuidGun(item).TrackOff();

		}
		
	}

}

exec function ParseLeftClick()
{
	if (RestrictInput())
		return;

	if (bSpyDroneActive)
	{
		if(aDrone != None)
		{
			if(PerkSystem.CheckPerkState(class'PerkBotexplode'))
				DroneExplode();
				
			return;
		}		
		else
		{
			DroneDisabled();
			return;
		}
	}

	if ((inHand != None) && !bInHandTransition)
	{
		if (inHand.bActivatable)
			inHand.Activate();
		else if (FrobTarget != None)
		{
			if ((FrobTarget.IsA('DeusExMover')) || (FrobTarget.IsA('CardReader')))
				if (inHand.IsA('NanoKeyRing') || inHand.IsA('Lockpick'))
					DoFrob(Self, inHand);

			if (FrobTarget.IsA('HackableDevices'))
			{
				if (inHand.IsA('Multitool'))
				{
					if (( Level.Netmode != NM_Standalone ) && (TeamDMGame(DXGame) != None) && FrobTarget.IsA('AutoTurretGun') && (AutoTurretGun(FrobTarget).team==PlayerReplicationInfo.team) )
					{
						MultiplayerNotifyMsg( MPMSG_TeamHackTurret );
						return;
					}
					else
						DoFrob(Self, inHand);
				}
			}
		}
	}
}

function GetSkillInfoFromProj( DeusExPlayer killer, Actor proj )
{
	local class<Skill> skillClass;

	if ( proj.IsA('P_RiotGrenade') || proj.IsA('P_LAM') || proj.IsA('P_EMPGrenade') || proj.IsA('TearGas'))
		skillClass = class'SkillWeaponHeavy';
	else if ( proj.IsA('P_GEPRocket') || proj.IsA('P_RocketLAW') || proj.IsA('P_GEPRocketWP') || proj.IsA('Fireball') || proj.IsA('P_PlasmaBolt'))
		skillClass = class'SkillWeaponHeavy';
	else if ( proj.IsA('P_Dart') || proj.IsA('P_DartFlare') || proj.IsA('P_DartPoison') || proj.IsA('P_ThrowingKnife'))
		skillClass = class'SkillMedicine';
	else if ( proj.IsA('P_HE20mm') )
		skillClass = class'SkillWeaponRifle';
	else if ( proj.IsA('DeusExDecoration') )
	{
		killProfile.activeSkill = NoneString;
		killProfile.activeSkillLevel = 0;
		return;
	}
	if ( killer.SkillSystem != None )
	{
		killProfile.activeSkill = skillClass.Default.skillName;
		killProfile.activeSkillLevel = killer.SkillSystem.GetSkillLevel(skillClass);
	}
}


///////////////////////////////////////////////////////////////////////////////
//                 �������� ������������ �������� ����                       //
///////////////////////////////////////////////////////////////////////////////
function CreateColorThemeManager()
{
	if (ThemeManager == None)
	{
		ThemeManager = Spawn(Class'ColorThemeManager', Self);


		// ����� ����
		ThemeManager.AddTheme(Class'ColorThemeMenu_2027');
		ThemeManager.AddTheme(Class'ColorThemeMenu_2027Dark');
            ThemeManager.AddTheme(Class'ColorThemeMenu_Default');
            ThemeManager.AddTheme(Class'ColorThemeMenu_BlueAndGold');
		ThemeManager.AddTheme(Class'ColorThemeMenu_CoolGreen');
		ThemeManager.AddTheme(Class'ColorThemeMenu_Cops');
		ThemeManager.AddTheme(Class'ColorThemeMenu_Cyan');
		ThemeManager.AddTheme(Class'ColorThemeMenu_DesertStorm');
		ThemeManager.AddTheme(Class'ColorThemeMenu_Devil');
            ThemeManager.AddTheme(Class'ColorThemeMenu_DriedBlood');
		ThemeManager.AddTheme(Class'ColorThemeMenu_Dusk');
		ThemeManager.AddTheme(Class'ColorThemeMenu_Earth');
		ThemeManager.AddTheme(Class'ColorThemeMenu_Green');
		ThemeManager.AddTheme(Class'ColorThemeMenu_Grey');
		ThemeManager.AddTheme(Class'ColorThemeMenu_IonStorm');
		ThemeManager.AddTheme(Class'ColorThemeMenu_Lava');
		ThemeManager.AddTheme(Class'ColorThemeMenu_NightVision');
		ThemeManager.AddTheme(Class'ColorThemeMenu_Ninja');
		ThemeManager.AddTheme(Class'ColorThemeMenu_Olive');
		ThemeManager.AddTheme(Class'ColorThemeMenu_PaleGreen');
		ThemeManager.AddTheme(Class'ColorThemeMenu_Pastel');
		ThemeManager.AddTheme(Class'ColorThemeMenu_Plasma');
		ThemeManager.AddTheme(Class'ColorThemeMenu_Primaries');
		ThemeManager.AddTheme(Class'ColorThemeMenu_Purple');
		ThemeManager.AddTheme(Class'ColorThemeMenu_Red');
		ThemeManager.AddTheme(Class'ColorThemeMenu_Resurrection');
		ThemeManager.AddTheme(Class'ColorThemeMenu_Seawater');
		ThemeManager.AddTheme(Class'ColorThemeMenu_SoylentGreen');
		ThemeManager.AddTheme(Class'ColorThemeMenu_Starlight');
		ThemeManager.AddTheme(Class'ColorThemeMenu_Steel');
		ThemeManager.AddTheme(Class'ColorThemeMenu_SteelGreen');
		ThemeManager.AddTheme(Class'ColorThemeMenu_Superhero');
		ThemeManager.AddTheme(Class'ColorThemeMenu_Terminator');
		ThemeManager.AddTheme(Class'ColorThemeMenu_Violet');

		// ����� HUD
		ThemeManager.AddTheme(Class'ColorThemeHUD_2027');
		ThemeManager.AddTheme(Class'ColorThemeHUD_2027Dark');
            ThemeManager.AddTheme(Class'ColorThemeHUD_Default');
		ThemeManager.AddTheme(Class'ColorThemeHUD_Amber');
		ThemeManager.AddTheme(Class'ColorThemeHUD_Cops');
		ThemeManager.AddTheme(Class'ColorThemeHUD_Cyan');
		ThemeManager.AddTheme(Class'ColorThemeHUD_DarkBlue');
		ThemeManager.AddTheme(Class'ColorThemeHUD_DesertStorm');
            ThemeManager.AddTheme(Class'ColorThemeHUD_Devil');
		ThemeManager.AddTheme(Class'ColorThemeHUD_DriedBlood');
		ThemeManager.AddTheme(Class'ColorThemeHUD_Dusk');
		ThemeManager.AddTheme(Class'ColorThemeHUD_Grey');
		ThemeManager.AddTheme(Class'ColorThemeHUD_IonStorm');
		ThemeManager.AddTheme(Class'ColorThemeHUD_NightVision');
		ThemeManager.AddTheme(Class'ColorThemeHUD_Ninja');
		ThemeManager.AddTheme(Class'ColorThemeHUD_PaleGreen');
		ThemeManager.AddTheme(Class'ColorThemeHUD_Pastel');
		ThemeManager.AddTheme(Class'ColorThemeHUD_Plasma');
		ThemeManager.AddTheme(Class'ColorThemeHUD_Primaries');
		ThemeManager.AddTheme(Class'ColorThemeHUD_Purple');
		ThemeManager.AddTheme(Class'ColorThemeHUD_Red');
		ThemeManager.AddTheme(Class'ColorThemeHUD_Resurrection');
		ThemeManager.AddTheme(Class'ColorThemeHUD_SoylentGreen');
		ThemeManager.AddTheme(Class'ColorThemeHUD_Starlight');
		ThemeManager.AddTheme(Class'ColorThemeHUD_SteelGreen');
		ThemeManager.AddTheme(Class'ColorThemeHUD_Superhero');
		ThemeManager.AddTheme(Class'ColorThemeHUD_Terminator');
		ThemeManager.AddTheme(Class'ColorThemeHUD_Violet');
	}
}

//////////////////////////////////////////////////////////////////////////////
//                ������� ��� �������� ������ ����                          //
//////////////////////////////////////////////////////////////////////////////
exec function ShowMainMenu()
{
   local DeusExRootWindow root;
   local DeusExLevelInfo info;
   local MissionEndgame Script;
   local String  TempMapName;

   if (bIgnoreNextShowMenu)
   {
     bIgnoreNextShowMenu = False;
     return;
   }

   info = GetLevelInfo();


   if ((info != None) && (info.bCutScene)) 
   {
     TempMapName = info.NextMapName;
     bIgnoreNextShowMenu = True;

	if (conPlay != None)
		conPlay.TerminateConversation();

     SetFOVAngle(Default.DesiredFOV);
     Level.Game.SendPlayer(Self, TempMapName);
   }
   else
   {
      root = DeusExRootWindow(rootWindow);
       if (root != None)
          root.InvokeMenu(class'GameMenuMain');
   }
}

//////////////////////////////////////////////////////////////////////////////
//                  ������� ��� ����������� �������                         //
//////////////////////////////////////////////////////////////////////////////
exec function ScopeIn() 
{ 
     local ZoomWeapon W; 

     if (RestrictInput()) 
          return; 

     W = ZoomWeapon(Weapon); 
     if (W != None) 
          W.InScope(); 
} 

exec function ScopeOut() 
{ 
     local ZoomWeapon W; 

     if (RestrictInput()) 
          return; 

     W = ZoomWeapon(Weapon); 
     if (W != None) 
          W.OutScope(); 
}

////////////////////////////////////////////////////////////////////////////
// ��������� ���� ����� Legend
//
exec function Legend()
{
	// ������ �� ����������
}

////////////////////////////////////////////////////////////////////////////
// ���� ����� Conspiracy
//
exec function Conspiracy()
{
	if (!bCheatsEnabled)
		return;

	InvokeUIScreen(Class'Game.ConspiracyMenu');
}

//=======================================================================
// ToggleAllHUD()
//=======================================================================
exec function ToggleAllHUD()
{
	//ToggleHUDBox();
	ToggleObjectBelt();
	ToggleHitDisplay();
	ToggleAmmoDisplay();
	ToggleAugDisplay();
	ToggleCompass();
	ToggleCrosshair();
	ToggleStatus();
	//ToggleRPGStatDisplay();
}

function ResetPlayer(optional bool bTraining)
{
	if (AugmentationSystem != None)
	{
		AugmentationSystem.ResetAugmentations();
		AugmentationSystem.Destroy();
		AugmentationSystem = None;
	}
	
	if (PerkSystem != None)
	{
		PerkSystem.ResetPerks();
		PerkSystem.Destroy();
		PerkSystem = None;
	}
	
	if (SkillSystem != None)
	{
		SkillSystem.ResetSkills();
		SkillSystem.Destroy();
		SkillSystem = None;
	}
	
	ResetPlayerToDefaults();
}

exec function Summon(string ClassName)
{
	if (!bCheatsEnabled)
		return;

	if(instr(ClassName, ".") == -1) ClassName = "Game." $ ClassName;

	Super(PlayerPawnExt).Summon(ClassName);
}

exec function SpawnMass(Name ClassName, optional int TotalCount)
{
	local actor        spawnee;
	local vector       spawnPos;
	local vector       center;
	local rotator      direction;
	local int          maxTries;
	local int          count;
	local int          numTries;
	local float        maxRange;
	local float        range;
	local float        angle;
	local class<Actor> spawnClass;
	local string		holdName;

	if (!bCheatsEnabled)
		return;

	if (!bAdmin && (Level.Netmode != NM_Standalone))
		return;

	if (instr(ClassName, ".") == -1)
		holdName = "Game." $ ClassName;
	else
		holdName = "" $ ClassName;  // barf

	spawnClass = class<actor>(DynamicLoadObject(holdName, class'Class'));
	if (spawnClass == None)
	{
		ClientMessage("Illegal actor name "$GetItemName(String(ClassName)));
		return;
	}

	if (totalCount <= 0)
		totalCount = 10;
	if (totalCount > 250)
		totalCount = 250;
	maxTries = totalCount*2;
	count = 0;
	numTries = 0;
	maxRange = sqrt(totalCount/3.1416)*4*SpawnClass.Default.CollisionRadius;

	direction = ViewRotation;
	direction.pitch = 0;
	direction.roll  = 0;
	center = Location + Vector(direction)*(maxRange+SpawnClass.Default.CollisionRadius+CollisionRadius+20);
	while ((count < totalCount) && (numTries < maxTries))
	{
		angle = FRand()*3.14159265359*2;
		range = sqrt(FRand())*maxRange;
		spawnPos.X = sin(angle)*range;
		spawnPos.Y = cos(angle)*range;
		spawnPos.Z = 0;
		spawnee = spawn(SpawnClass,,,center+spawnPos, Rotation);
		if (spawnee != None)
			count++;
		numTries++;
	}

	ClientMessage(count$" actor(s) spawned");

}

////////////////////////////////////////////////////////////////////////////
// ���� ������ ������
//

exec function GiveItems()
{
	local inventory anItem;

	if (!bCheatsEnabled)
		return;

	   if (!bTPHasItems)
           {
		anItem = Spawn(class'Game.WeaponSilencedPistol');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = True;
		anItem = Spawn(class'Game.WeaponMP5');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = True;
		anItem = Spawn(class'Game.WeaponKnife');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = True;
		anItem = Spawn(class'Game.WeaponSniperRifle');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = True;
		anItem = Spawn(class'Game.WeaponShotgun');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = True;
		anItem = Spawn(class'Medkit');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = False;
		anItem = Spawn(class'Medkit');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = False;
		anItem = Spawn(class'Medkit');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = False;
		anItem = Spawn(class'Medkit');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = False;
		anItem = Spawn(class'Medkit');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = False;
		anItem = Spawn(class'Medkit');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = False;
		anItem = Spawn(class'Lockpick');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = False;
		anItem = Spawn(class'Lockpick');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = False;
		anItem = Spawn(class'Lockpick');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = False;
		anItem = Spawn(class'Lockpick');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = False;
		anItem = Spawn(class'Lockpick');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = False;
		anItem = Spawn(class'Lockpick');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = False;
		anItem = Spawn(class'Multitool');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = False;
		anItem = Spawn(class'Multitool');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = False;
		anItem = Spawn(class'Multitool');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = False;
		anItem = Spawn(class'Multitool');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = False;
		anItem = Spawn(class'Multitool');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = False;
		anItem = Spawn(class'Multitool');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = False;
		anItem = Spawn(class'Game.BigBioelectricCell');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = False;
		anItem = Spawn(class'Game.BigBioelectricCell');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = False;
		anItem = Spawn(class'Game.BigBioelectricCell');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = False;
		anItem = Spawn(class'Game.BigBioelectricCell');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = False;
		anItem = Spawn(class'Game.BigBioelectricCell');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = False;
		anItem = Spawn(class'DeusEx.RAmmo10mm');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = False;
		anItem = Spawn(class'DeusEx.RAmmo10mm');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = False;
		anItem = Spawn(class'DeusEx.RAmmo10mm');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = False;
		anItem = Spawn(class'DeusEx.RAmmo10mm');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = False;
		anItem = Spawn(class'DeusEx.RAmmo10mm');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = False;
		anItem = Spawn(class'DeusEx.RAmmo10mm');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = False;
		anItem = Spawn(class'DeusEx.RAmmo10mm');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = False;
		anItem = Spawn(class'DeusEx.RAmmo10mmJHP');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = False;
		anItem = Spawn(class'DeusEx.RAmmo10mmJHP');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = False;
		anItem = Spawn(class'DeusEx.RAmmo10mmJHP');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = False;
		anItem = Spawn(class'DeusEx.RAmmo556mm');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = False;
		anItem = Spawn(class'DeusEx.RAmmo556mm');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = False;
		anItem = Spawn(class'DeusEx.RAmmo556mm');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = False;
		anItem = Spawn(class'DeusEx.RAmmo556mm');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = False;
		anItem = Spawn(class'DeusEx.RAmmo556mm');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = False;
		anItem = Spawn(class'DeusEx.RAmmo556mmJHP');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = False;
		anItem = Spawn(class'DeusEx.RAmmo556mmJHP');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = False;
		anItem = Spawn(class'DeusEx.RAmmo556mmJHP');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = False;
		anItem = Spawn(class'DeusEx.RAmmo762mm');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = False;
		anItem = Spawn(class'DeusEx.RAmmo762mm');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = False;
		anItem = Spawn(class'DeusEx.RAmmo762mm');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = False;
		anItem = Spawn(class'DeusEx.RAmmo3006');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = False;
		anItem = Spawn(class'DeusEx.RAmmo3006');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = False;
		anItem = Spawn(class'DeusEx.RAmmo3006');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = False;
		anItem = Spawn(class'DeusEx.RAmmoShell');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = False;
		anItem = Spawn(class'DeusEx.RAmmoShell');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = False;
		anItem = Spawn(class'DeusEx.RAmmoShell');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = False;
		anItem = Spawn(class'DeusEx.RAmmoShell');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = False;
		anItem = Spawn(class'Game.WeaponLAMGrenade');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = True;
		anItem = Spawn(class'Game.WeaponLAMGrenade');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = True;
		anItem = Spawn(class'Game.WeaponLAMGrenade');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = True;
		anItem = Spawn(class'Game.WeaponLAMGrenade');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = True;
		anItem = Spawn(class'Game.WeaponPulseGrenade');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = True;
		anItem = Spawn(class'Game.WeaponPulseGrenade');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = True;
		anItem = Spawn(class'Game.WeaponPulseGrenade');
		anItem.Frob(Self, None);
		anItem.bInObjectBelt = True;
      	
        	AugmentationSystem.GivePlayerAugmentation(class'DeusEx.AugEMPShield');
        	AugmentationSystem.GivePlayerAugmentation(class'DeusEx.AugHealing');
           	AugmentationSystem.GivePlayerAugmentation(class'DeusEx.AugVision');
			AugmentationSystem.GivePlayerAugmentation(class'DeusEx.AugTime');
			AugmentationSystem.GivePlayerAugmentation(class'DeusEx.AugCloak');
        	

                bTPHasItems=True;
	   }
}

// ----------------------------------------------------------------------
// ShowCredits()
// ----------------------------------------------------------------------
function ShowCredits(optional bool bLoadIntro)
{
	local DeusExRootWindow root;
	local GameCreditsWindow winCredits;

	root = DeusExRootWindow(rootWindow);

	if (root != None)
	{
		winCredits = GameCreditsWindow(root.InvokeMenuScreen(Class'GameCreditsWindow', bLoadIntro));
		winCredits.SetLoadIntro(bLoadIntro);
	}
}

// ----------------------------------------------------------------------
// ShowQuotesWindow()
// ----------------------------------------------------------------------
exec function ShowQuotesWindow()
{
	if (!bCheatsEnabled)
		return;

	InvokeUIScreen(Class'GameQuotesWindow');
}

// ----------------------------------------------------------------------
// ShowIntro()
// ----------------------------------------------------------------------
function ShowIntro(optional bool bStartNewGame)
{
	if (DeusExRootWindow(rootWindow) != None)
		DeusExRootWindow(rootWindow).ClearWindowStack();

	bStartNewGameAfterIntro = bStartNewGame;

	AugmentationSystem.DeactivateAll();

	Level.Game.SendPlayer(Self, strIntroMap);
}

// ----------------------------------------------------------------------
// StartNewGame()
//
// Starts a new game given the map passed in
// ----------------------------------------------------------------------
exec function StartNewGame(String startMap)
{
	if (DeusExRootWindow(rootWindow) != None)
		DeusExRootWindow(rootWindow).ClearWindowStack();

	flagBase.SetBool('PlayerTraveling', True, True, 0);

	SaveSkillPoints();
	ResetPlayer();
	DeleteSaveGameFiles();

	bStartingNewGame = True;

	Level.Game.SendPlayer(Self, startMap);
}

// ----------------------------------------------------------------------
// StartTrainingMission()
// ----------------------------------------------------------------------
function StartTrainingMission()
{
	if (DeusExRootWindow(rootWindow) != None)
		DeusExRootWindow(rootWindow).ClearWindowStack();

	if (!bAskedToTrain)
	{
		bAskedToTrain = True;
		SaveConfig();
	}

   SkillSystem.ResetSkills();
   PerkSystem.ResetPerks();
	ResetPlayer(True);
	DeleteSaveGameFiles();
	bStartingNewGame = True;
	Level.Game.SendPlayer(Self, strTrainingMap);
}

exec function Say(string Msg)
{
	local Pawn P;
	local String str;

	str = TruePlayerName $ ": " $ Msg;

	if ( Role == ROLE_Authority )
		log(str);

	for( P = Level.PawnList; P != None; P = P.nextPawn )
	{
		if( P.bIsPlayer )
			P.ClientMessage( str, 'Say', true );
	}

	return;
}

exec function Type()
{
	if (!bCheatsEnabled)
		return;

	Player.Console.TypedStr="";
	Player.Console.GotoState('Typing');
}


exec function SShot()
{
	local float b;

	b = float(ConsoleCommand("get ini:Engine.Engine.ViewportManager Brightness"));
//	ConsoleCommand("set ini:Engine.Engine.ViewportManager Brightness "$string(B));
//	ConsoleCommand("flush");
	ConsoleCommand("shot");
//	ConsoleCommand("set ini:Engine.Engine.ViewportManager Brightness "$string(B));
//	ConsoleCommand("flush");
}


//////////////////////////////////////////////////////////////////
// ����                                                         //
//////////////////////////////////////////////////////////////////
exec function Amphibious()
{
}

exec function Submarine()
{
	if( !bCheatsEnabled )
		return;

	if ( !bAdmin && (Level.Netmode != NM_Standalone) )
		return;

	if(!bSubmarine)
        {
             bSubmarine=True;
	     UnderwaterTime = +999999.0;
	     ClientMessage(msgSubmarineOn);
        }
        else
        {
             bSubmarine=False;
	     UnderwaterTime = Default.UnderwaterTime;
	     ClientMessage(msgSubmarineOff);
        }
}
	
exec function Fly()
{
	if( !bCheatsEnabled )
		return;

	if ( !bAdmin && (Level.Netmode != NM_Standalone) )
		return;

      if(!bFly)
      {
        bFly=True;		
	UnderWaterTime = Default.UnderWaterTime;	
	ClientMessage(msgFly);
	SetCollision(true, true , true);
	bCollideWorld = true;
	GotoState('CheatFlying');
      }
      else
      {
        bFly=False;
	ClientMessage(msgFlyOff);
        Walk();
      }
}

exec function Ghost()
{
	if( !bCheatsEnabled )
		return;

	if ( !bAdmin && (Level.Netmode != NM_Standalone) )
		return;
      if(!bGhost)
      {
        bGhost=True;
	UnderWaterTime = -1.0;	
	ClientMessage(msgGhost);
	SetCollision(false, false, false);
	bCollideWorld = false;
	GotoState('CheatFlying');
      }
      else
      {
        bGhost=False;
	ClientMessage(msgGhostOff);
        Walk();
      }

}

exec function AllAmmo()
{
}

exec function Ammunition()
{
	local Inventory Inv;

	if( !bCheatsEnabled )
		return;

	if ( !bAdmin && (Level.Netmode != NM_Standalone) )
		return;

	for( Inv=Inventory; Inv!=None; Inv=Inv.Inventory ) 
		if (Ammo(Inv)!=None) 
			Ammo(Inv).AmmoAmount  = Ammo(Inv).MaxAmmo;

	ClientMessage(msgHasAllAmmo);
}


exec function Invisible(bool B)
{
}

exec function Camo()
{
	if( !bCheatsEnabled )
		return;

	if ( !bAdmin && (Level.Netmode != NM_Standalone) )
		return;

	if (!bCamo)
	{
                bCamo=True;
		bHidden = true;
		Visibility = 0;
		bDetectable = false;
		ClientMessage(msgInvisibleOn);
	}
	else
	{
                bCamo=False;
		bHidden = false;
		Visibility = Default.Visibility;
		bDetectable = true;
		ClientMessage(msgInvisibleOff);
	}	
}
	
exec function God()
{
}

exec function Deus()
{
	if( !bCheatsEnabled )
		return;

	if ( !bAdmin && (Level.Netmode != NM_Standalone) )
		return;

	if ( ReducedDamageType == 'All' )
	{
		ReducedDamageType = '';
		ClientMessage(msgGodOff);
		return;
	}

	ReducedDamageType = 'All'; 
	ClientMessage(msgGodOn);
}

exec function BehindView( Bool B )
{
}

exec function ThirdView()
{
	if (!bCheatsEnabled)
		return;

	if (!bThirdView)
        {
          bThirdView=True;
	  bBehindView = True;
	  ClientMessage(msgThirdView);
        }
        else
        {
          bThirdView=False;
	  bBehindView = False;
	  ClientMessage(msgFirstView);
        }
}

exec function SloMo( float T )
{
}

exec function Chronos(float T)
{
	if (!bCheatsEnabled)
		return;

        if (T == 1)
        {
           ClientMessage(msgTimeNormal);
	   ServerSetSloMo(1);
        }
        else if (T > 1)
        {
           ClientMessage(msgTimeFast);
	   ServerSetSloMo(T);
        }
        else
        {
           ClientMessage(msgTimeSlow);
	   ServerSetSloMo(T);
        }
}

exec function KillAll(class<actor> aClass)
{
}

exec function KillPawns()
{
}

exec function Dieworld()
{
	local Pawn P;
	
	if(!bCheatsEnabled)
		return;
	if ( !bAdmin && (Level.Netmode != NM_Standalone) )
		return;
	ForEach AllActors(class 'Pawn', P)
		if (PlayerPawn(P) == None)
			P.Destroy();

	  ClientMessage(msgDieworld);
}

exec function AllEnergy()
{
}

exec function AllPower()
{
	Energy = 9000;
	ClientMessage(msgEnergy);
}

exec function Thingamabob()
{
	PlaySound(Sound'Menu_BuySkills', SLOT_Interface, 0.75 );
	ClientMessage(msgCheatsActivated);
    bCheatsEnabled = true;
    bCheatsActivated = true;
}

exec function Skulgun()
{
	Thingamabob();
}

exec function AllData()
{
	local Vector loc;
	local Inventory item;

	if (!bCheatsEnabled)
		return;

	item = Spawn(class'C3_Agents');
	item.Frob(Self, None);
	item = Spawn(class'C4_Area51');
	item.Frob(Self, None);
	item = Spawn(class'C4_Ment');
	item.Frob(Self, None);
	item = Spawn(class'C4_Panel');
	item.Frob(Self, None);
	item = Spawn(class'C4_NorthLabs');
	item.Frob(Self, None);
	item = Spawn(class'C4_Russia');
	item.Frob(Self, None);
	item = Spawn(class'C5_Alien');
	item.Frob(Self, None);
	item = Spawn(class'C5_MainRouter');
	item.Frob(Self, None);
	item = Spawn(class'C5_NorthBaseSattelite');
	item.Frob(Self, None);
	item = Spawn(class'C5_Titan');
	item.Frob(Self, None);
	item = Spawn(class'C6_MtWeather');
	item.Frob(Self, None);
}

// ----------------------------------------------------------------------
// TravelPostAccept()
// ----------------------------------------------------------------------
event TravelPostAccept()
{
	local DeusExLevelInfo info;

	Super.TravelPostAccept();

	switch(PlayerSkin)
	{
		case 0:	
		MultiSkins[0] = Texture'DanielTex0_0'; 		
		break;
		
		case 1:	
		//Mesh = LodMesh'DeusExCharacters.GM_Trench_F';
		MultiSkins[0] = Texture'GameMedia.Characters.DanielTex0_1'; 
		MultiSkins[6] = Texture'DeusExCharacters.Skins.FramesTex2'; 
		MultiSkins[7] = Texture'DeusExCharacters.Skins.LensesTex3'; 
		//Fatness = 127;
		break;
		
		case 2:	
		MultiSkins[0] = Texture'GameMedia.Characters.DanielTex0_2'; 
		MultiSkins[6] = Texture'GameMedia.Characters.FramesSquare'; 
		MultiSkins[7] = Texture'DeusExCharacters.Skins.LensesTex3'; 
		//Fatness = 127;
		break;
	}
}

function UpdatePlayerSkin()
{
	local DanielCarcass dCarcass;
	local DanielDouble dd;

	foreach AllActors(class'DanielCarcass', dCarcass)
		dCarcass.SetSkin(Self);

	foreach AllActors(class'DanielDouble', dd)
		dd.SetSkin(Self);
}

// ----------------------------------------------------------------------
// ResetPlayerToDefaults()
//
// Resets all travel variables to their defaults
// ----------------------------------------------------------------------
function ResetPlayerToDefaults()
{
	local inventory anItem;
	local inventory nextItem;

   // reset the image linked list
	FirstImage = None;

	if (DeusExRootWindow(rootWindow) != None)
		DeusExRootWindow(rootWindow).ResetFlags();

	// Remove all the keys from the keyring before
	// it gets destroyed
	if (KeyRing != None)
	{
		KeyRing.RemoveAllKeys();
      if ((Role == ROLE_Authority) && (Level.NetMode != NM_Standalone))
      {
         KeyRing.ClientRemoveAllKeys();
      }
		KeyRing = None;
	}

	while(Inventory != None)
	{
		anItem = Inventory;
		DeleteInventory(anItem);
		anItem.Destroy();
	}

	// Clear object belt
	if (DeusExRootWindow(rootWindow) != None)
		DeusExRootWindow(rootWindow).hud.belt.ClearBelt();

	// clear the notes and the goals
	DeleteAllNotes();
	DeleteAllGoals();

	// Nuke the history
	ResetConversationHistory();

	// Other defaults
	Credits = Default.Credits;
	Energy  = Default.Energy;
	SkillPointsTotal = Default.SkillPointsTotal;
	SkillPointsAvail = Default.SkillPointsAvail;
	ExperiencePoints = Default.ExperiencePoints;
	HeroLevel = Default.HeroLevel;
	UpgradePoints = Default.UpgradePoints;

	aBot=None;
	bBotControlActive=False;
	
	aDrone=None;
	bSpyDroneActive=False;

	SetInHandPending(None);
	SetInHand(None);

	bInHandTransition = False;

	RestoreAllHealth();
	ClearLog();

	saveCount = 0;
	saveTime  = 0.0;

	bCheatsActivated = False;

	InitializeSubSystems();
}

// ------------------------------------------------------------------------
// GiveInitialInventory()
// ------------------------------------------------------------------------

function GiveInitialInventory()
{
}

// ----------------------------------------------------------------------
// AllSkillPoints()
// ----------------------------------------------------------------------
exec function AllSkillPoints()
{
	if (!bCheatsEnabled)
		return;

	SkillPointsTotal = 100500;
	SkillPointsAvail = 100500;
	ExperiencePoints = 100500;
}

exec function AllPerks()
{
	if (!bCheatsEnabled)
		return;

	UpgradePoints = MaxHeroLevel-1;
	PerkSystem.AddAllPerks();
}

exec function AllSkills()
{
	if (!bCheatsEnabled)
		return;

	SkillPointsTotal = 900000;
	SkillPointsAvail = 900000;
	SkillSystem.AddAllSkills();
	SkillPointsTotal = 9000;
	SkillPointsAvail = 9000;
}


// ----------------------------------------------------------------------
// CreateBot()
// ----------------------------------------------------------------------
simulated function CreateBot(SupportBotBase OurBot)
{
	local Vector loc;

	/*loc = (2.0 + class'SupportBot'.Default.CollisionRadius + CollisionRadius) * Vector(ViewRotation);
	loc.Z = BaseEyeHeight;
	loc += Location;
	//aBot = Spawn(class'SupportBot', Self,, loc, ViewRotation);*/
	aBot=OurBot;
}

// ----------------------------------------------------------------------
// SetBot()
// ----------------------------------------------------------------------
simulated function SetBot(SupportBotBase OurBot)
{
	aBot=OurBot;
}

// ----------------------------------------------------------------------
// StopBot()
// ----------------------------------------------------------------------
simulated function StopBot()
{
	aBot=None;
}

// ----------------------------------------------------------------------
// StopBotControl()
// ----------------------------------------------------------------------
simulated function StopBotControl()
{
	bBotControlActive=False;
}

// ----------------------------------------------------------------------
// state Dying
//
// make sure the death animation finishes
// ----------------------------------------------------------------------

state Dying
{
	ignores all;

	event PlayerTick(float deltaTime)
	{
      if (PlayerIsClient())      
         ClientDeath();
		UpdateDynamicMusic(deltaTime);

		Super.PlayerTick(deltaTime);
	}

	exec function Fire(optional float F)
	{
		if ( Level.NetMode != NM_Standalone )
        Super.Fire();
	}

	exec function ShowMainMenu()
	{
		// reduce the white glow when the menu is up
		if (InstantFog != vect(0,0,0))
		{
			InstantFog   = vect(0.1,0.1,0.1);
			InstantFlash = 0.01;

			// force an update
			ViewFlash(1.0);
		}

		Global.ShowMainMenu();
	}

	function BeginState()
	{
		FrobTime = Level.TimeSeconds;
		ShowHud(False);
      ClientDeath();
	}

   function TakeDamage(int Damage, Pawn instigatedBy, Vector hitlocation, Vector momentum, name damageType)
	{
	}

	function PlayerCalcView(out actor ViewActor, out vector CameraLocation, out rotator CameraRotation)
	{
		local vector ViewVect, HitLocation, HitNormal, whiteVec;
		local float ViewDist;
		local actor HitActor;
		local float time;

		local float BrightDot;
		local Vector loc;
		local float dist;
  		local float DrawGlow;
  		local float RadianView;
  		local float OldFlash, NewFlash;
   		local vector OldFog, NewFog;
		local vector Fog, whiteVec2;
		local float Flash;
		local DeusExPlayer Player;

		ViewActor = Self;
		if (bHidden)
		{
			// spiral up and around carcass and fade to white in five seconds
			time = Level.TimeSeconds - FrobTime;

			if ( ((myKiller != None) && (killProfile != None) && (!killProfile.bKilledSelf)) || 
				  ((killProfile != None) && killProfile.bValid && (!killProfile.bKilledSelf)))
			{
				if ( killProfile.bValid && killProfile.bTurretKilled )
					ViewVect = killProfile.killerLoc - Location;
				else if ( killProfile.bValid && killProfile.bProximityKilled )
					ViewVect = killProfile.killerLoc - Location;
				else if (( !killProfile.bKilledSelf ) && ( myKiller != None ))
					ViewVect = myKiller.Location - Location;
				CameraLocation = Location;
				CameraRotation = Rotator(ViewVect);
			}
			else if (time < 20)
			{
				//��� ��� �����, �� �� ������ �� �������
				/*
				whiteVec.X = time / 16.0;//@
				whiteVec.Y = time / 16.0;
				whiteVec.Z = time / 16.0;

				InstantFog = whiteVec;
				InstantFlash = 0.5;
				ViewFlash(1.0);
				*/
//------------------------------------------------------------------------------------------------
/*
             //  BrightDot = Normal(Vector(Player.ViewRotation)) dot Normal(A.Location - Player.Location);

		BrightDot = Normal(vect(0,0,1));

                  //VisionBlinder = A;
                  NewFlash = 10.0 * BrightDot;
                  NewFog = vect(1000,1000,900) * BrightDot * 0.9;
                  OldFlash = player.DesiredFlashScale;
                  OldFog = player.DesiredFlashFog * 1000;
                  
                  // Don't add increase the player's flash above the current newflash.
                  NewFlash = FMax(0,NewFlash - OldFlash);
                  NewFog.X = FMax(0,NewFog.X - OldFog.X);
                  NewFog.Y = FMax(0,NewFog.Y - OldFog.Y);
                  NewFog.Z = FMax(0,NewFog.Z - OldFog.Z);
                  player.ClientFlash(NewFlash,NewFog);
                  player.IncreaseClientFlashLength(4.0*BrightDot*BrightDot);
*/
//------------------------------------------------------------------------------------------------

				//whiteVec.X = time/16;
				//whiteVec.Y = time/16;
				//whiteVec.Z = time/16;

				whiteVec.X = FMin(0.0 + (time) / 13.0, 1);
				whiteVec.Y = FMin(0.0 + (time) / 13.0, 1);
				whiteVec.Z = FMin(0.0 + (time) / 13.0, 1);
Fog = whiteVec;


				ClientFlash(whiteVec.X,whiteVec);// float scale, vector fog 
								ViewFlash(1.0);
IncreaseClientFlashLength(15);
				CameraRotation.Pitch = -16384;
				CameraRotation.Yaw = (time * 8192.0/1.5) % 65536;
				ViewDist = 32 + time * 32;

				// make sure we don't go through the ceiling
				ViewVect = vect(0,0,1);
				HitActor = Trace(HitLocation, HitNormal, Location + ViewDist * ViewVect, Location);
				if ( HitActor != None )
					CameraLocation = HitLocation;
				else
					CameraLocation = Location + ViewDist * ViewVect;
			}
			else
			{
				if  ( Level.NetMode != NM_Standalone )
				{
					// Don't fade to black in multiplayer
				}
				else
				{
					// then, fade out to black in four seconds and bring up
					// the main menu automatically
					/*whiteVec.X = FMax(0.5 - (time-8.0) / 8.0, -1.0);
					whiteVec.Y = FMax(0.5 - (time-8.0) / 8.0, -1.0);
					whiteVec.Z = FMax(0.5 - (time-8.0) / 8.0, -1.0);
					CameraRotation.Pitch = -16384;
					CameraRotation.Yaw = (time * 8192.0) % 65536;
					 ViewDist = 32 + 8.0 * 32;
					InstantFog = whiteVec;
					InstantFlash = whiteVec.X;
					ViewFlash(1.0);*/

					//CameraRotation.Pitch = -16384;
					//CameraRotation.Yaw = (time * 8192.0) % 65536;
					// ViewDist = 32 + 8.0 * 32;

				//whiteVec2.X = -1;
				//whiteVec2.Y = -1;
				//whiteVec2.Z = -1;

					whiteVec2.X = FMax(0.5 - (time-10.0) / 8.0, -1.0);
					whiteVec2.Y = FMax(0.5 - (time-10.0) / 8.0, -1.0);
					whiteVec2.Z = FMax(0.5 - (time-10.0) / 8.0, -1.0);

				/*if(whiteVec.X < -1.0){
					whiteVec.X = -1.0;
					whiteVec.Y = -1.0;
					whiteVec.Z = -1.0;
				}*/

				//ClientFlash(whiteVec2.X,whiteVec2);// float scale, vector fog 
				//ViewFlash(1);
				//IncreaseClientFlashLength(10);

					// start the splash screen after a bit
					// only if we don't have a menu open
					// DEUS_EX AMSD Don't do this in multiplayer!!!!
					if (Level.NetMode == NM_Standalone)
					{
						//if (whiteVec == vect(-1.0,-1.0,-1.0))
						//if (time > 15)
							if ((MenuUIWindow(DeusExRootWindow(rootWindow).GetTopWindow()) == None) &&
								(ToolWindow(DeusExRootWindow(rootWindow).GetTopWindow()) == None))
								ConsoleCommand("OPEN DXONLY");
					}
				}
				// make sure we don't go through the ceiling
				ViewVect = vect(0,0,1);
				HitActor = Trace(HitLocation, HitNormal, Location + ViewDist * ViewVect, Location);
				if ( HitActor != None )
					CameraLocation = HitLocation;
				else
					CameraLocation = Location + ViewDist * ViewVect;
			}
		}
		else
		{
			// use FrobTime as the cool DeathCam timer
			FrobTime = Level.TimeSeconds;

			// make sure we don't go through the wall
		    ViewDist = 190;
			ViewVect = vect(1,0,0) >> Rotation;
			HitActor = Trace( HitLocation, HitNormal, 
					Location - ViewDist * vector(CameraRotation), Location, false, vect(12,12,2));
			if ( HitActor != None )
				CameraLocation = HitLocation;
			else
				CameraLocation = Location - ViewDist * ViewVect;
		}

		// don't fog view if we are "paused"
		if (DeusExRootWindow(rootWindow).bUIPaused)
		{
			InstantFog   = vect(0,0,0);
			InstantFlash = 0;
			ViewFlash(1.0);
		}
	}

Begin:
	// Dead players comes back to life with scope view, so this is here to prevent that
	if ( DeusExWeapon(inHand) != None )
	{
		DeusExWeapon(inHand).bZoomed = False;
		DeusExWeapon(inHand).RefreshScopeDisplay(Self, True, False);
	}

	if ( DeusExRootWindow(rootWindow).hud.augDisplay != None )
	{
		DeusExRootWindow(rootWindow).hud.augDisplay.bVisionActive = False;
		DeusExRootWindow(rootWindow).hud.augDisplay.activeCount = 0;
	}

	// Don't come back to life drugged or posioned
	poisonCounter		= 0; 
	poisonTimer			= 0;    
	drugEffectTimer	= 0;

	// Don't come back to life crouched
	bCrouchOn			= False;
	bWasCrouchOn		= False;
	bIsCrouching		= False;
	bForceDuck			= False;
	lastbDuck			= 0;
	bDuck					= 0;

	FrobTime = Level.TimeSeconds;
	bBehindView = True;
	Velocity = vect(0,0,0);
	Acceleration = vect(0,0,0);
	DesiredFOV = Default.DesiredFOV;
	FinishAnim();
	KillShadow();

   FlashTimer = 0;

	// hide us and spawn the carcass
	bHidden = True;
	SpawnCarcass();
   //DEUS_EX AMSD Players should not leave physical versions of themselves around :)
   if (Level.NetMode != NM_Standalone)
      HidePlayer();
      
     aDrone = None;
     bSpyDroneActive = False;
}

// ----------------------------------------------------------------------
// GetHitLocation()
// Returns 1 for head, 2 for torso, 3 for left leg, 4 for right leg, 5 for
// left arm, 6 for right arm, 0 for nothing.
// ----------------------------------------------------------------------
function int GetHitLocation(Vector hitLocation)
{
	local float headOffsetZ, headOffsetY, armOffset;
	local Vector offset, dst;
	
	offset = (hitLocation - Location) << Rotation;
	
	headOffsetZ = CollisionHeight * 0.78;
	headOffsetY = CollisionRadius * 0.35;
	armOffset = CollisionRadius * 0.35;	
	
		if (offset.z > headOffsetZ)	// head
		{
			// narrow the head region
			if ((Abs(offset.x) < headOffsetY) || (Abs(offset.y) < headOffsetY))
			{
				//head
				return 1;
			}
			else
			{
				//none
				return 0;
			}
		}
		else if (offset.z < 0.0) // legs
		{
			if (offset.y > 0.0)
			{
				//right leg
				return 4;
			}
			else
			{
				//left leg
				return 3;
			}
		}
		else // arms and torso
		{
			if (offset.y > armOffset)
			{
				//right arm
				return 6;
			}
			else if (offset.y < -armOffset)
			{
				//left arm
				return 5;
			}
			else
			{
				//torso
				return 2;
			}
		}
		
	return 0;
}

////////////////////////////////////////////////////////////////////////////////
//      ����� ������� ����������� ����������� �� ������� � ����������         //
////////////////////////////////////////////////////////////////////////////////
function bool DXReduceDamage(int Damage, name damageType, vector hitLocation, out int adjustedDamage, bool bCheckOnly)
{
	local float newDamage;
	local float augLevel, skillLevel;
	local float pct;
	local HazMatSuit suit;
	local BallisticArmor armor;
	local bool bReduced;
    local float tempdamage;

	bReduced = False;
	newDamage = Float(Damage);
        tempdamage=newDamage;

	if ((damageType == 'TearGas') || (damageType == 'PoisonGas') || (damageType == 'HalonGas')  || (damageType == 'PoisonEffect') || (damageType == 'Poison'))
	{
		if (AugmentationSystem != None)
			augLevel = AugmentationSystem.GetAugLevelValue(class'AugEnviro');

		if (augLevel >= 0.0)
			newDamage *= augLevel;

		if (newDamage ~= 0.0 || PerkSystem.CheckPerkState(class'PerkFire'))
		{
			StopPoison();
			drugEffectTimer -= 4;
			if (drugEffectTimer < 0)
				drugEffectTimer = 0;
		}
	}
	
	if ((damageType == 'TearGas') || (damageType == 'PoisonGas') || (damageType == 'Radiation') || (damageType == 'HalonGas')  || (damageType == 'PoisonEffect') || (damageType == 'Poison') || (damageType == 'Burned') || (damageType == 'Flamed') || (damageType == 'Shocked'))
	{
		if (UsingChargedPickup(class'HazMatSuit'))
        {
			skillLevel = SkillSystem.GetAltSkillLevelValue(class'SkillPower');
			newDamage *= 0.75 * skillLevel;
		}
	}
	
	if ((damageType == 'TearGas') || (damageType == 'PoisonGas') || (damageType == 'Radiation') || (damageType == 'HalonGas')  || (damageType == 'PoisonEffect') || (damageType == 'Poison'))
	{
		if(PerkSystem.CheckPerkState(class'PerkFire'))
			newDamage *= 0.5;
	}

	if ((damageType == 'Shot') || (damageType == 'Exploded') || (damageType == 'AutoShot'))
	{
     	if (UsingChargedPickup(class'BallisticArmor') && GetHitLocation(hitLocation) == 2) //Defend torso only
		{
			skillLevel = SkillSystem.GetAltSkillLevelValue(class'SkillPower');
			newDamage *= 0.5 * skillLevel;
		}
	}

    if (damageType == 'HalonGas')
	{
		if (bOnFire && !bCheckOnly)
			ExtinguishFire();
	}

	if ((damageType == 'Shot') || (damageType == 'AutoShot'))
	{
		if (AugmentationSystem != None)
			augLevel = AugmentationSystem.GetAugLevelValue(class'AugBallistic');

		if (augLevel >= 0.0)
			newDamage *= augLevel;
	}

	if ((damageType == 'Burned') || (damageType == 'Flamed') || (damageType == 'Exploded') || (damageType == 'Shocked'))
	{
		if(AugmentationSystem.GetClassLevel(class'AugBallistic') >= 1)
		{
			if (AugmentationSystem != None)
				augLevel = AugmentationSystem.GetAugLevelValue(class'AugBallistic');
	
			if (augLevel >= 0.0)
				newDamage *= augLevel;
		}
		
		if(PerkSystem.CheckPerkState(class'PerkFire'))
			newDamage *= 0.75;
	}

	if (newDamage < Damage)
	{
		if (!bCheckOnly)
		{
			pct = 1.0 - (newDamage / Float(Damage));
			SetDamagePercent(pct);
			ClientFlash(0.01, vect(0, 0, 50));
		}
		
		bReduced = True;
	}
	else
	{
		if (!bCheckOnly)
			SetDamagePercent(0.0);
	}


	if ((damageType == 'Shot') || (damageType == 'AutoShot'))
	{
		newDamage *= CombatDifficulty;

		if ((newDamage <= 1) && (Damage > 0))
			newDamage = 1;
	}

	adjustedDamage = Int(newDamage);

	return bReduced;
}


function MaintainEnergy(float deltaTime)
{
	local Float energyUse;
	local Float energyRegen;

	// make sure we can't continue to go negative if we take damage
	// after we're already out of energy
	if (Energy <= 0)
	{
		Energy = 0;
		EnergyDrain = 0;
		EnergyDrainTotal = 0;
	}

	energyUse = 0;

	// Don't waste time doing this if the player is dead or paralyzed
	if ((!IsInState('Dying')) && (!IsInState('Paralyzed')))
	{
		if (Energy > 0)
		{
			// Decrement energy used for augmentations
			energyUse = AugmentationSystem.CalcEnergyUse(deltaTime);
         
			Energy -= EnergyUse;
         
			// Calculate the energy drain due to EMP attacks
			if (EnergyDrain > 0)
			{
				energyUse = EnergyDrainTotal * deltaTime;
				Energy -= EnergyUse;
				EnergyDrain -= EnergyUse;

				if (EnergyDrain <= 0)
				{
					EnergyDrain = 0;
					EnergyDrainTotal = 0;
				}
			}
		}

		//Do check if energy is 0.  
		// If the player's energy drops to zero, deactivate 
		// all augmentations
		if (Energy <= 0)
		{
			//If we were using energy, then tell the client we're out.
			//Otherwise just make sure things are off.  If energy was
			//already 0, then energy use will still be 0, so we won't
			//spam.  DEUS_EX AMSD
			if (energyUse > 0)         
				ClientMessage(EnergyDepleted);

			Energy = 0;
			EnergyDrain = 0;
			EnergyDrainTotal = 0;         
			AugmentationSystem.DeactivateAll();
		}

		// If all augs are off, then start regenerating up to 25%.
		if (!bProcessingData && (energyUse == 0) && (Energy <= MaxRegenPoint) && (PerkSystem.CheckPerkState(class'PerkEnergy')))
		{
			energyRegen = RegenRate * deltaTime;
			Energy += energyRegen;
		}
	}
}

function CatchFire( Pawn burner )
{
	local Fire f;
	local int i;
	local vector loc;

	myBurner = burner;

	burnTimer = 0;

   if (bOnFire || Region.Zone.bWaterZone)
		return;

	bOnFire = True;
	burnTimer = 0;

	for (i=0; i<4; i++)
	{
		loc.X = 0.5*CollisionRadius * (1.0-2.0*FRand());
		loc.Y = 0.5*CollisionRadius * (1.0-2.0*FRand());
		loc.Z = 0.6*CollisionHeight * (1.0-2.0*FRand());
		loc += Location;
	
		f = Spawn(class'Fire', Self,, loc);

		if(f != None)
		{
			f.DrawScale = 0.5*FRand() + 0.5;

			if (i > 0)
			{
				f.AmbientSound = None;
				f.LightType = LT_None;
			}

			if ((FRand() < 0.5) && (Level.NetMode == NM_Standalone))
				f.smokeGen.Destroy();
			if ((FRand() < 0.5) && (Level.NetMode == NM_Standalone))
				f.AddFire();
		}
	}

	// set the burn timer
	SetTimer(1.0, True);
}

simulated function PlayFootStep()
{
	local Sound stepSound;
	local float rnd;
	local float speedFactor, massFactor;
	local float volume, pitch, range;
	local float radius, mult;
	local float volumeMultiplier, realVolumeMultiplier;
	local DeusExPlayer pp;
	local bool bOtherPlayer;

	// Only do this on ourself, since this takes into account aug stealth and such
	if ( Level.NetMode != NM_StandAlone )
		pp = DeusExPlayer( GetPlayerPawn() );

	if ( pp != Self )
		bOtherPlayer = True;
	else
		bOtherPlayer = False;

	rnd = FRand();

	volumeMultiplier = 1.0;
	realVolumeMultiplier = 1.0;
	
	if (IsInState('PlayerSwimming') || (Physics == PHYS_Swimming))
	{
		volumeMultiplier = 0.5;
		if (rnd < 0.5)
			stepSound = Sound'Swimming';
		else
			stepSound = Sound'Treading';
	}
	else if (FootRegion.Zone.bWaterZone)
	{
		volumeMultiplier = 1.0;
		if (rnd < 0.33)
			stepSound = Sound'WaterStep1';
		else if (rnd < 0.66)
			stepSound = Sound'WaterStep2';
		else
			stepSound = Sound'WaterStep3';
	}
	else
	{
		switch(FloorMaterial)
		{
			case 'Textile':
			case 'Paper':
				volumeMultiplier = 0.6;
				if (rnd < 0.25)
					stepSound = Sound'CarpetStep1';
				else if (rnd < 0.5)
					stepSound = Sound'CarpetStep2';
				else if (rnd < 0.75)
					stepSound = Sound'CarpetStep3';
				else
					stepSound = Sound'CarpetStep4';
				break;

			case 'Foliage':
				volumeMultiplier = 0.8;
				if (rnd < 0.25)
					stepSound = Sound'GameMedia.Misc.Step_Grass1';
				else if (rnd < 0.5)
					stepSound = Sound'GameMedia.Misc.Step_Grass2';
				else if (rnd < 0.75)
					stepSound = Sound'GameMedia.Misc.Step_Grass3';
				else
					stepSound = Sound'GameMedia.Misc.Step_Grass4';
				break;
							
			case 'Earth':
				volumeMultiplier = 0.7;
				if (rnd < 0.25)
					stepSound = Sound'GameMedia.Misc.Step_Earth1';
				else if (rnd < 0.5)
					stepSound = Sound'GameMedia.Misc.Step_Earth2';
				else if (rnd < 0.75)
					stepSound = Sound'GameMedia.Misc.Step_Earth3';
				else
					stepSound = Sound'GameMedia.Misc.Step_Earth4';
				break;

			case 'Metal':
			case 'Ladder':
				volumeMultiplier = 1.1;
				if (rnd < 0.25)
					stepSound = Sound'GameMedia.Misc.Step_Metal1';
				else if (rnd < 0.5)
					stepSound = Sound'GameMedia.Misc.Step_Metal2';
				else if (rnd < 0.75)
					stepSound = Sound'GameMedia.Misc.Step_Metal3';
				else
					stepSound = Sound'GameMedia.Misc.Step_Metal4';
				break;

			case 'Snow':
				volumeMultiplier = 1.1;
				if (rnd < 0.25)
					stepSound = Sound'GameMedia.Misc.Step_Snow1';
				else if (rnd < 0.5)
					stepSound = Sound'GameMedia.Misc.Step_Snow2';
				else if (rnd < 0.75)
					stepSound = Sound'GameMedia.Misc.Step_Snow3';
				else
					stepSound = Sound'GameMedia.Misc.Step_Snow4';
				break;

			case 'Ceramic':
			case 'Glass':
			case 'Tiles':
				volumeMultiplier = 0.75;
				if (rnd < 0.25)
					stepSound = Sound'TileStep1';
				else if (rnd < 0.5)
					stepSound = Sound'TileStep2';
				else if (rnd < 0.75)
					stepSound = Sound'TileStep3';
				else
					stepSound = Sound'TileStep4';
				break;

			case 'Wood':
				volumeMultiplier = 0.95;
				if (rnd < 0.25)
					stepSound = Sound'GameMedia.Misc.Step_Wood1';
				else if (rnd < 0.5)
					stepSound = Sound'GameMedia.Misc.Step_Wood2';
				else if (rnd < 0.75)
					stepSound = Sound'GameMedia.Misc.Step_Wood3';
				else
					stepSound = Sound'GameMedia.Misc.Step_Wood4';
				break;
				
			case 'Brick':
			case 'Concrete':
				realVolumeMultiplier = 0.6;
				volumeMultiplier = 0.85;
				if (rnd < 0.25)
					stepSound = Sound'GameMedia.Misc.Step_Stone1';
				else if (rnd < 0.5)
					stepSound = Sound'GameMedia.Misc.Step_Stone1';
				else if (rnd < 0.75)
					stepSound = Sound'GameMedia.Misc.Step_Stone1';
				else
					stepSound = Sound'GameMedia.Misc.Step_Stone1';
				break;
				
			case 'Stone':
			case 'Stucco':
			default:
				realVolumeMultiplier = 0.5;
				volumeMultiplier = 0.85;
				if (rnd < 0.25)
					stepSound = Sound'GameMedia.Misc.Step_Stone1';
				else if (rnd < 0.5)
					stepSound = Sound'GameMedia.Misc.Step_Stone2';
				else if (rnd < 0.75)
					stepSound = Sound'GameMedia.Misc.Step_Stone3';
				else
					stepSound = Sound'GameMedia.Misc.Step_Stone4';
				break;
		}
	}

	if (IsInState('PlayerSwimming') || (Physics == PHYS_Swimming))
		speedFactor = WaterSpeed/180.0;
	else
		speedFactor = VSize(Velocity)/180.0;

	massFactor  = Mass/150.0;
	radius      = 375.0;
	volume      = (speedFactor+0.2) * massFactor;
	range       = radius * volume;
	pitch       = (volume+0.5);
	volume      = FClamp(volume, 0, 1.0) * 0.75 * realVolumeMultiplier;											
	range       = FClamp(range, 0.01, radius*4);
	pitch       = FClamp(pitch, 1.0, 1.5);

	RunSilentValue = 1.0;
	
	if(AugmentationSystem.GetClassLevel(class'AugSpeed') == -1 && PerkSystem.CheckPerkState(class'PerkStealth'))
		RunSilentValue = 0.5;
	
	volume *= RunSilentValue;
	
	pitch *= GetSoundPitchMultiplier();

	if(AugmentationSystem.GetClassLevel(class'AugSpeed') >= 0)
	{
		PlaySound(Sound'GameMedia.Misc.MechWalk', SLOT_Pain, volume * 1.4, , range, pitch);
		volume *= 1.5;	
	}
	
	PlaySound(stepSound, SLOT_Interact, volume, , range, pitch);

	AISendEvent('LoudNoise', EAITYPE_Audio, volume*volumeMultiplier, range*volumeMultiplier);
}

function DoJump( optional float F )
{
	local DeusExWeapon w;
	local float scaleFactor, augLevel;

	if ((CarriedDecoration != None) && (CarriedDecoration.Mass > 20))
		return;
	else if (bForceDuck || IsLeaning())
		return;

	if (Physics == PHYS_Walking)
	{
		PlaySound(JumpSound, SLOT_None, 1.5, , 1200, (1.0 - 0.2*FRand()) * GetSoundPitchMultiplier() );
		
		if(AugmentationSystem.GetClassLevel(class'AugSpeed') >= 1)
		{
			PlaySound(Sound'GameMedia.Misc.RobotLegs4', SLOT_None, 0.5, , 1200, (1.0 - 0.1*FRand()) * GetSoundPitchMultiplier());
		}
		
		if ( (Level.Game != None) && (Level.Game.Difficulty > 0) )
			MakeNoise(0.1 * Level.Game.Difficulty);
		PlayInAir();

		Velocity.Z = JumpZ;

		if ( Level.NetMode != NM_Standalone )
		{
         if (AugmentationSystem == None)
            augLevel = -1.0;
         else			
            augLevel = AugmentationSystem.GetAugLevelValue(class'AugSpeed');
			w = DeusExWeapon(InHand);
			if ((augLevel != -1.0) && ( w != None ) && ( w.Mass > 30.0))
			{
				scaleFactor = 1.0 - FClamp( ((w.Mass - 30.0)/55.0), 0.0, 0.5 );
				Velocity.Z *= scaleFactor;
			}
		}
		
		// reduce the jump velocity if you are crouching
//		if (bIsCrouching)
//			Velocity.Z *= 0.9;

		if ( Base != Level )
			Velocity.Z += Base.Velocity.Z;
		SetPhysics(PHYS_Falling);
		if ( bCountJumps && (Role == ROLE_Authority) )
			Inventory.OwnerJumped();
	}
}

simulated function float GetSoundPitchMultiplier()
{
	local float pitch;
	
	pitch = 1.0;
	
	if(AugmentationSystem.GetClassLevel(class'AugTime') >= 0)
		pitch = 1 / (AugmentationSystem.GetAugLevelValue(class'AugTime') * 0.75);
	
	return pitch;
}

simulated function TimeEffects(float deltaTime)
{	
	local DeusExRootWindow root;

	root = DeusExRootWindow(rootWindow);
	
	if(AugmentationSystem.GetClassLevel(class'AugTime') >= 0)
	{
		if(!bTimeActive)
		{
			ClientFlash(10, vect(500,500,500));			
			bTimeActive = True;
		}
		
		/*if ((root != None) && (root.hud != None))
		{
			if (root.hud.background == None)
			{
				root.hud.SetBackground(Texture'TimeEffect');
				root.hud.SetBackgroundSmoothing(True);
				root.hud.SetBackgroundStretching(True);
				root.hud.SetBackgroundStyle(DSTY_Translucent);
			}
		}*/
	}
	else
	{
		if(bTimeActive)
		{
			ClientFlash(10, vect(500,500,500));
			bTimeActive = False;
		}
		
		/*if ((root != None) && (root.hud != None))
		{
			if (root.hud.background != None)
			{
				root.hud.SetBackground(None);
				root.hud.SetBackgroundStyle(DSTY_Normal);
			}
		}*/
	}
}

function PlayDyingSound()
{
	local string soundFileName;
	local int num;
	local string numStr;
	
	if (Health >= -80) //Gibbed
	{
		if (Region.Zone.bWaterZone)
			PlaySound(sound'MaleWaterDeath', SLOT_Pain,,,, RandomPitch());
		else
		{
			num = Rand(12);
			
			if(num < 10)
				numStr = "0" $ num;
			else
				numStr = "" $ num;
			
			soundFileName = "GameMedia.Human.Death" $ numStr;

			PlaySound(Sound(DynamicLoadObject(soundFileName, class'Sound')), SLOT_Pain,,,, RandomPitch());

			//PlaySound(sound'MaleDeath', SLOT_Pain,,,, RandomPitch());
		}
	}
}

function PlayTakeHitSound(int Damage, name damageType, int Mult)
{
	local float rnd;
	local string soundFileName;
	local int num;
	local string numStr;
	local Sound hitSound;

	if ( Level.TimeSeconds - LastPainSound < FRand() + 0.75)
		return;

	LastPainSound = Level.TimeSeconds;

	if (Region.Zone.bWaterZone && damageType == 'Drowned')
	{
		if (FRand() < 0.8)
			PlaySound(sound'MaleDrown', SLOT_Pain, FMax(Mult * TransientSoundVolume, Mult * 2.0),,, RandomPitch());
	}
	else
	{
		if ((damageType == 'TearGas') || (damageType == 'HalonGas'))
			PlaySound(sound'MaleEyePain', SLOT_Pain, FMax(Mult * TransientSoundVolume, Mult * 2.0),,, RandomPitch());
		else if (damageType == 'PoisonGas')
			PlaySound(sound'MaleCough', SLOT_Pain, FMax(Mult * TransientSoundVolume, Mult * 2.0),,, RandomPitch());
		else
		{
			if (Damage <= 20)
			{
				num = Rand(9);
				numStr = "0" $ num;			
				soundFileName = "GameMedia.Human.PainSmall" $ numStr;
			}
			else
			{
				num = Rand(7);
				numStr = "0" $ num;			
				soundFileName = "GameMedia.Human.PainBig" $ numStr;
			}

			hitSound = Sound(DynamicLoadObject(soundFileName, class'Sound'));
			PlaySound(hitSound, SLOT_Pain, FMax(Mult * TransientSoundVolume, Mult * 2.0),,, RandomPitch());
			
			/*rnd = FRand();
			if (rnd < 0.33)
				PlaySound(sound'MalePainSmall', SLOT_Pain, FMax(Mult * TransientSoundVolume, Mult * 2.0),,, RandomPitch());
			else if (rnd < 0.66)
				PlaySound(sound'MalePainMedium', SLOT_Pain, FMax(Mult * TransientSoundVolume, Mult * 2.0),,, RandomPitch());
			else
				PlaySound(sound'MalePainLarge', SLOT_Pain, FMax(Mult * TransientSoundVolume, Mult * 2.0),,, RandomPitch());*/
		}
		AISendEvent('LoudNoise', EAITYPE_Audio, FMax(Mult * TransientSoundVolume, Mult * 2.0));
	}
}

function PreTravel()
{
	local DeusExLevelInfo info;

	info=GetLevelInfo();

	player.console.LoadingMessage = LoadingScrName;
	LoadingScrName = "";

	Super.PreTravel();
}

function ShowCloakOnEffect()
{
	Spawn(class'SFXCamoOnLight',,, Location);
	Spawn(class'SFXCamoOnFlash',,, Location);
}

function ShowCloakOffEffect()
{
	Spawn(class'SFXCamoOnLight',,, Location);
	Spawn(class'SFXCamoOnFlash',,, Location);
}

defaultproperties
{
	 bCheatsEnabled=False
	 ExperiencePoints=0
	 HeroLevel=1
	 UpgradePoints=0
	 ExperienceLevel(0)=0
	 ExperienceLevel(1)=3000
	 ExperienceLevel(2)=4500
	 ExperienceLevel(3)=6000
	 ExperienceLevel(4)=7500
	 ExperienceLevel(5)=9000
	 ExperienceLevel(6)=10500
	 ExperienceLevel(7)=12000
	 ExperienceLevel(8)=13500
	 MaxRegenPoint=35.0
     Blood=100.0
     BloodMax=100.0
     MaxBloodRegen=100.0
     BloodRegenRate=1.02
     TruePlayerName=""
     SkillPointsTotal=5000
     SkillPointsAvail=5000
     Credits=0
     ClotPeriod=40.000000
     strTrainingMap="02_Washington_CIA"
     strIntroMap="02_Washington_CIA"
     strStartMap="02_Washington_CIA"
     CarcassType=Class'Game.DanielCarcass'
     JumpSound=Sound'DeusExSounds.Player.MaleJump'
     HitSound1=Sound'DeusExSounds.Player.MalePainSmall'
     HitSound2=Sound'DeusExSounds.Player.MalePainMedium'
     Land=Sound'DeusExSounds.Player.MaleLand'
     Die=Sound'DeusExSounds.Player.MaleDeath'
     Mesh=LodMesh'DeusExCharacters.GM_Trench'
     MultiSkins(0)=Texture'GameMedia.Characters.DanielTex0_0'
     MultiSkins(1)=Texture'GameMedia.Characters.DanielTex2'
     MultiSkins(2)=Texture'GameMedia.Characters.DanielTex3'
     MultiSkins(3)=Texture'GameMedia.Characters.DanielTex0'
     MultiSkins(4)=Texture'GameMedia.Characters.DanielTex1'
     MultiSkins(5)=Texture'GameMedia.Characters.DanielTex2'
     MultiSkins(7)=Texture'DeusExCharacters.Skins.LensesTex3'
     BindName="JCDenton"
}