//=============================================================================
// ������ �����������. ������� Ded'�� ��� ���� 2027
// Advanced light switch.  Copyright (C) 2003 Ded
//=============================================================================
class AdvLightSwitch extends DeusExDecoration;

enum EStartAnim 
{
	SA_LightOn,
	SA_LightOff
};

var() bool bOnceOnly;
var bool bNoMore;
var bool bLightOn;
var bool bOn;
var bool bPlayOn;
var() EStartAnim StartAnimation;

simulated function bool IsOn()
{
	return bOn;	
}

simulated function TurnOn()
{
	local Actor A;
	local DeusExPlayer Player;

	PlaySound(sound'Switch4ClickOff');
	PlayAnim('On');
	bOn = True;
	bLightOn = False;

	if (Event != '')
		foreach AllActors(class 'Actor', A, Event)
			A.Trigger(Self, None);

}

function Trigger(Actor Other, Pawn Instigator)
{
	Super.Trigger(Other, Instigator);

	Frob(Instigator, None);
}

function Frob(Actor Frobber, Inventory frobWith)
{

   if (bOnceOnly)
   {
          if (!bNoMore)
          {
                 if (bLightOn)
                 {
		  PlaySound(sound'Switch4ClickOff');
		  PlayAnim('On');
	          Super.Frob(Frobber, frobWith);
                  bNoMore=True;
                 }
                 else
                 {
		  PlaySound(sound'Switch4ClickOn');
		  PlayAnim('Off');
	          Super.Frob(Frobber, frobWith);
                  bNoMore=True;
                 }
          }
   }

   else
   {
	Super.Frob(Frobber, frobWith);

	if (bOn)
	{
		PlaySound(sound'Switch4ClickOff');
		PlayAnim('Off');
	}
	else
	{
		PlaySound(sound'Switch4ClickOn');
		PlayAnim('On');
	}

	bOn = !bOn;
   }

}

function PostBeginPlay()
{
	Super.PostBeginPlay();

	switch (StartAnimation)
	{

		case SA_LightOn:	PlayAnim('Off');
                                          bLightOn=True;
                                              bOn=False;
                                                  break;

		case SA_LightOff:	 PlayAnim('On');
                                         bLightOn=False;
                                               bOn=True;
                                                  break;
	}
}

defaultproperties
{
     MultiSkins(0)=Texture'GameMedia.Skins.LightButtonTex0'
     bOnceOnly=False
     bInvincible=True
     bPushable=False
     Physics=PHYS_None
     Mesh=LodMesh'DeusExDeco.LightSwitch'
     CollisionRadius=3.750000
     CollisionHeight=6.250000
     Mass=30.000000
     Buoyancy=40.000000
}
