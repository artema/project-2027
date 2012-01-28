//=============================================================================
// ������ �����������. ������� Ded'�� ��� ���� 2027
// Advanced light switch.  Copyright (C) 2003 Ded
//=============================================================================
class AdvSwitch1 extends DeusExDecoration;

enum EStartAnim
{
	SA_Yellow,
	SA_Red
};

var() bool bOnceOnly;
var bool bNoMore;
var bool bYellow;
var bool bOn;
var bool bPlayOn;
var() EStartAnim StartAnimation;

function Frob(Actor Frobber, Inventory frobWith)
{

   if (bOnceOnly)
   {
          if (!bNoMore)
          {
                 if (bYellow)
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

		case SA_Yellow:	        PlayAnim('Off');
                                           bYellow=True;
                                              bOn=False;
                                                  break;

		case SA_Red:	         PlayAnim('On');
                                          bYellow=False;
                                               bOn=True;
                                                  break;
	}
}

defaultproperties
{
     bOnceOnly=False
     bInvincible=True
     bPushable=False
     Physics=PHYS_None
     Mesh=LodMesh'DeusExDeco.Switch1'
     CollisionRadius=2.630000
     CollisionHeight=2.970000
     Mass=10.000000
     Buoyancy=12.000000
}
