//=============================================================================
// ������ �������. ������� Ded'�� ��� ���� 2027
// Advanced valve.  Copyright (C) 2003 Ded
//=============================================================================
class AdvValve extends DeusExDecoration;

#exec OBJ LOAD FILE=MoverSFX
#exec OBJ LOAD FILE=Ambient

enum EStartAnim
{
	SA_Opened,
	SA_Closed
};

var() bool bOnceOnly;
var bool bNoMore;
var bool bOpened;
var bool bOpen;
var bool bPlayOn;
var() EStartAnim StartAnimation;

function Frob(Actor Frobber, Inventory frobWith)
{

   if (bOnceOnly)
   {
          if (!bNoMore)
          {
                 if (bOpened)
                 {
		  PlaySound(sound'ValveClose',,,, 256);
		  PlayAnim('Close',, 0.001);
	          Super.Frob(Frobber, frobWith);
                  bNoMore=True;
                 }
                 else
                 {
		  PlaySound(sound'ValveOpen',,,, 256);
		  PlayAnim('Open',, 0.001);
	          Super.Frob(Frobber, frobWith);
                  bNoMore=True;
                 }
          }
   }

   else
   {
	Super.Frob(Frobber, frobWith);

	if (bOpen)
	{
		PlaySound(sound'ValveOpen',,,, 256);
		PlayAnim('Open',, 0.001);
	}
	else
	{
		PlaySound(sound'ValveClose',,,, 256);
		PlayAnim('Close',, 0.001);
	}

	bOpen = !bOpen;
   }

}

function PostBeginPlay()
{
	Super.PostBeginPlay();

	switch (StartAnimation)
	{

		case SA_Opened:	   PlayAnim('Open', 10.0, 0.001);
                                   bOpened=True;
                                   bOpen=True;
                                   break;

		case SA_Closed:	   PlayAnim('Close', 10.0, 0.001);
                                   bOpened=False;
                                   bOpen=False;
                                   break;
	}
}

defaultproperties
{
     bOnceOnly=False
     bInvincible=True
     bPushable=False
     Physics=PHYS_None
     Mesh=LodMesh'DeusExDeco.Valve'
     SoundRadius=6
     SoundVolume=48
     SoundPitch=96
     AmbientSound=Sound'Ambient.Ambient.WaterRushing'
     CollisionRadius=7.200000
     CollisionHeight=1.920000
     Mass=20.000000
     Buoyancy=10.000000
}
