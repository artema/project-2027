//=============================================================================
// ����� ���������� �����. �������� Ded'�� ��� ���� 2027
// Support bot control. Copyright (C) 2002 Hejhujka (Modified by Ded (C) 2005)
//=============================================================================
class SupportBotControlImpl extends SupportBotControlBase;

var() Name BotType[2];
var() Name CurrentBot;
var bool bSupportBot;
var bool bDoNothing;
var localized String msgSBPatrol;
var localized String msgSBSupporting;
var localized String msgSBDeactivated;
var localized String msgSBChanged;
var localized String msgSBFuncOn;
var localized String msgSBFuncOff;
var localized String msgSBNoBot;

replication
{
reliable if ((Role == ROLE_Authority) && (bNetOwner))
	bSupportBot;

reliable if ( Role == ROLE_Authority )
	SwichOrders;

reliable if ( Role < ROLE_Authority )
	SupportBotOn, SupportBotOff, SupportBotToggle;
}

//===================================================
//	����������
//===================================================

//===================================================
// ����� �������
simulated function bool ClientFire(float Value)
{
	PlaySelectiveFiring();
	GotoState('Zooming');
        
	//return true;
	PlayFiringSound();
}
function Fire(float Value)
{
	if(!bDoNothing){
		PlaySelectiveFiring();
		PlayFiringSound();
		ClientFire(Value);
	}
}
state Zooming
{	
	simulated function BeginState()
	{
		if (!bSupportBot && (Owner != None) && Owner.IsA('DeusExPlayer'))
		{
			bSupportBot = True;
			SwichOrders(DeusExPlayer(Owner), bSupportBot);
		}
		else if (bSupportBot)
		{
			bSupportBot = False;
			SwichOrders(DeusExPlayer(Owner), bSupportBot);
      		}
	}
	
Begin:
       PlayerPawn(Owner).PlayFiring();
       PlayAnim('UseLoop',3,0.1);
       FinishAnim();
Done:
       GotoState('FinishFire');	
}

//===================================================
// ����������
simulated function bool ClientAltFire(float Value)
{
    PlaySelectiveFiring();
    PlayFiringSound();
	GotoState('AltZooming');	
	return true;
}
function AltFire(float Value)
{
	if(!bDoNothing && DeusExPlayer(Owner).aBot != None){
		ClientAltFire(Value);
	}
}
state AltZooming
{
	simulated function BeginState()
	{
		local SupportBotImpl SB;
		local string CurrentBotName;
		//local DeusExPlayer Player;

		foreach AllActors(Class'SupportBotImpl', SB){
	
		if((SB !=None) && SB.IsA(CurrentBot) && (SB.EMPHitPoints>0) && !SB.bNoEnergy)
		{
			//SB.Deactivated(SB.Health, SB.EMPHitPoints);
			CurrentBotName=GetBotName(CurrentBot);
			Pawn(Owner).ClientMessage(Sprintf(msgSBDeactivated, CurrentBotName));
			//SB.FuncOff();
			//SB.Destroy();

			//SB.bNoEnergy=True;
			SB.Deactivated();

			//if (SB.GetStateName() != 'Disabled')
			//	SB.GotoState('Disabled');

			SB=None;
		}}

		CurrentBot='';

		//Player = DeusExPlayer(GetPlayerPawn());
		//Player.StopBot();		
	}
	
Begin:
       PlayerPawn(Owner).PlayFiring();
       PlayAnim('UseLoop',3,0.1);
       FinishAnim();
Done:
       GotoState('FinishFire');	
}

//===================================================
// ���������� ������������
simulated function bool ClientBotFunc()
{
    /*PlaySelectiveFiring();
	//GotoState('BotFunc');
	GotoState('AltZooming');
    PlayFiringSound();*/
	return true;	
}
function ScopeOn() 
{ 
	/*if(!bDoNothing)
	{
		PlaySelectiveFiring();
		PlayFiringSound();
		ClientBotFunc();
	}*/
}
state BotFunc
{
	simulated function BeginState()
	{
		/*local SupportBotImpl SB;
		local string CurrentBotName;
		local bool result;

		foreach AllActors(Class'SupportBotImpl', SB)
		{	
			if((SB !=None) && SB.IsA(CurrentBot) && (SB.EMPHitPoints>0) && !SB.bNoEnergy)
			{
				CurrentBotName=GetBotName(CurrentBot);
				result=SB.SpecialFuncToggle();
	
				if(result)
					Pawn(Owner).ClientMessage(Sprintf(msgSBFuncOn, CurrentBotName));
				else
					Pawn(Owner).ClientMessage(Sprintf(msgSBFuncOff, CurrentBotName));
			}
		}*/
	}
	
Begin:
       PlayerPawn(Owner).PlayFiring();
       PlayAnim('UseLoop',3,0.1);
       FinishAnim();
Done:
       GotoState('FinishFire');	
}

//===================================================
// ����� ����
function UpdateCurrentBot()
{
	/*local SupportBotImpl SB;
	local string CurrentBotName;
	local int i;

	Pawn(Owner).ClientMessage(Sprintf("JOPA"));

	for(i=0;i<2;i++){
		SB=None;
		foreach AllActors(Class'SupportBotImpl', SB, BotType[i])
		if((SB!=None) && (BotType[i]!=CurrentBot) && (SB.EMPHitPoints>0)){
			bDoNothing=False;
			CurrentBot=BotType[i];
			CurrentBotName=GetBotName(CurrentBot);
			Pawn(Owner).ClientMessage(Sprintf(msgSBChanged, CurrentBotName));
			//break;
			i=2;
		}
	}*/
}

simulated function ReloadAmmo()
{
	local string CurrentBotName;
	local DeusExPlayer Player;
	local SupportBotImpl Bot;

	Player = DeusExPlayer(GetPlayerPawn());

	if(CurrentBot==BotType[0]){
		CurrentBot=BotType[1];
	}
	else{
		CurrentBot=BotType[0];
	}
	
	if(CurrentBot!=''){
		Bot = GetBotValue(CurrentBot);}
	

	if(!Bot.bNoEnergy && Bot != None){

	CurrentBotName=GetBotName(CurrentBot);
	Pawn(Owner).ClientMessage(Sprintf(msgSBChanged, CurrentBotName));
	Player.SetBot(Bot);
	}
	else{
	Pawn(Owner).ClientMessage(Sprintf(msgSBChanged, msgSBNoBot));
	Player.StopBot();
	}
}

//===================================================
//	�������
//===================================================
simulated function string GetBotName(Name CurBot)
{
	local SupportBotImpl SB;
	local String BotName;

	bDoNothing=True;

	foreach AllActors(Class'SupportBotImpl', SB){
		if((SB !=None) && SB.IsA(CurBot) && !SB.bNoEnergy)
		{
			BotName=SB.ShortBotName;
			bDoNothing=False;
			return BotName;
		}
	}
}

simulated function SupportBotImpl GetBotValue(Name CurBot)
{
	local SupportBotImpl SB;

	SB=None;

	bDoNothing=True;

	foreach AllActors(Class'SupportBotImpl', SB){
		if((SB !=None) && SB.IsA(CurBot) && !SB.bNoEnergy)
		{
			bDoNothing=False;
			return SB;
		}
	}
	
	//return None;
}

function SupportBotOn()
{
	if (!bSupportBot && (Owner != None) && Owner.IsA('DeusExPlayer'))
	{
		bSupportBot = True;
                SwichOrders(DeusExPlayer(Owner), bSupportBot);
	}
}

function SupportBotOff()
{
	if (bSupportBot && (Owner != None) && Owner.IsA('DeusExPlayer'))
	{
		bSupportBot = False;
                SwichOrders(DeusExPlayer(Owner), bSupportBot);
	}
}

simulated function SupportBotToggle()
{
	if (IsInState('Idle'))
	{
		if ((Owner != None) && Owner.IsA('DeusExPlayer'))
		{
			if (bSupportBot)
				SupportBotOff();
			else
				SupportBotOn();
		}
	}
}

simulated function SwichOrders(DeusExPlayer player, bool bSilenced)
{
	local SupportBotImpl SB;
	local string CurrentBotName;

	if (bSupportBot && (Player !=None))
	{          
		foreach AllActors(Class'SupportBotImpl', SB)
		{
			if((SB !=None) && SB.IsA(CurrentBot) && (SB.EMPHitPoints>0) && !SB.bNoEnergy)
			{
				SB.SetOrders('Wandering',, True);//Hiding
				CurrentBotName = GetBotName(CurrentBot);
				Pawn(Owner).ClientMessage(Sprintf(msgSBPatrol, CurrentBotName));
        	}
		}
	} 
	else if (!bSupportBot && (Player !=None))
	{
		foreach AllActors(Class'SupportBotImpl', SB)   
		{ 
			if((SB !=None) && SB.IsA(CurrentBot) && (SB.EMPHitPoints>0) && !SB.bNoEnergy)
			{
				SB.SetOrders('Following',, True);//Supporting
				CurrentBotName = GetBotName(CurrentBot);
				Pawn(Owner).ClientMessage(Sprintf(msgSBSupporting, CurrentBotName));
			}
		}
	}
}

simulated function PlaySelectiveFiring()
{
	local Pawn aPawn;
	local Name anim;

	anim = 'UseLoop';

	if ((Level.NetMode == NM_Standalone) || (DeusExPlayer(Owner) == DeusExPlayer(GetPlayerPawn())))
	{
		PlayAnim(anim,3,0.1);
	}
	else if (Role == ROLE_Authority)
	{
		for (aPawn = Level.PawnList; aPawn != None; aPawn = aPawn.nextPawn)
		{
			if (aPawn.IsA('DeusExPlayer') && ( DeusExPlayer(Owner) != DeusExPlayer(aPawn)))
			{
				// If they can't see the weapon, don't bother
				if (DeusExPlayer(aPawn).FastTrace( DeusExPlayer(aPawn).Location, Location))
					DeusExPlayer(aPawn).ClientPlayAnimation( Self, anim, 0.1, bAutomatic);
			}
		}
	}
}
/*
simulated function Tick(float deltaTime)
{
	local DeusExPlayer Player;

	Player = DeusExPlayer(GetPlayerPawn());
	Player.bBotControlActive=True;

	//Super(GameWeapon).Tick(deltaTime);

}
*/
// ----------------------------------------------------------------------
// UpdateInfo()
// ----------------------------------------------------------------------
simulated function bool UpdateInfo(Object winObject)
{
	local PersonaInfoWindow winInfo;
	local DeusExPlayer player;
	local String outText;

	winInfo = PersonaInfoWindow(winObject);
	if (winInfo == None)
		return False;

	player = DeusExPlayer(Owner);

	if (player != None)
	{
		winInfo.Clear();
		winInfo.SetTitle(itemName);
		winInfo.SetText(Description $ winInfo.CR() $ winInfo.CR());
	}

	return True;
}

function BringUp()
{
	local DeusExPlayer player;

	Super.BringUp();

	player = DeusExPlayer(GetPlayerPawn());

	CurrentBot=Default.CurrentBot;
	bDoNothing=True;
	Player.bBotControlActive=True;
	ReloadAmmo();
}

defaultproperties
{
    BotType(0)="SupportBotMJ12"
    BotType(1)="SupportBotRussian"
    CurrentBot="SupportBotNULL"
    LowAmmoWaterMark=0
    GoverningSkill=Class'DeusEx.SkillElectronics'
    NoiseLevel=0.000000
    EnemyEffective=1
    Concealability=1
    reloadTime=0.00
    HitDamage=0
    maxRange=1
    AccurateRange=1
    BaseAccuracy=0.00
    bHasMuzzleFlash=False
    bEmitWeaponDrawn=False
    bUseAsDrawnWeapon=False
    bHandToHand=True
    bCanHaveScope=True
    bHasScope=True
    AmmoName=Class'DeusEx.AmmoNone'
    ReloadCount=0
    FireOffset=(X=-17.00,Y=7.00,Z=15.00),
    shakemag=20.00
    FireSound=Sound'DeusExSounds.Generic.Beep3'
    SelectSound=Sound'DeusExSounds.Weapons.HideAGunSelect'
    InventoryGroup=47
    PlayerViewOffset=(X=17.00,Y=-7.00,Z=-15.00),
    PlayerViewMesh=LodMesh'DeusExItems.MultitoolPOV'
    PickupViewMesh=LodMesh'DeusExItems.Multitool'
    ThirdPersonMesh=LodMesh'DeusExItems.Multitool3rd'
    LandSound=Sound'DeusExSounds.Generic.PlasticHit2'
    Icon=Texture'DeusExUI.Icons.BeltIconMultitool'
    largeIcon=Texture'DeusExUI.Icons.LargeIconMultitool'
    largeIconWidth=28
    largeIconHeight=46
    Mesh=LodMesh'DeusExItems.Multitool'
    CollisionRadius=4.80
    CollisionHeight=0.86
}
