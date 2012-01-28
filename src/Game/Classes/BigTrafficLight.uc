//=============================================================================
// ��������. ������� Ded'�� ��� ���� 2027
// Spotlight. Copyright (C) 2003 Ded
// ����� ������/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class BigTrafficLight extends MoscowDecoration;

var bool bNormalFunction;
var bool bYellowOnly;
var bool bRedStatic;

enum EMode
{
	EM_Normal,
	EM_YellowOnly,
	EM_RedStatic
};

var() EMode WorkMode;

function BeginPlay()
{
	Super.BeginPlay();

	switch (WorkMode)
	{
		case EM_Normal:                 bNormalFunction = True;
                                                                 break;

		case EM_YellowOnly:                 bYellowOnly = True;
                                                                 break;

		case EM_RedStatic:                   bRedStatic = True;
                                                                 break;

	}

        MultiSkins[3] = Texture'PinkMaskTex';
	SetTimer(1,False);
}

simulated function Timer()
{
      if (bNormalFunction)
      {
      }

      if (bYellowOnly)
      {
          if (MultiSkins[3] == Texture'GameMedia.Skins.SpotlightYellow')
          {
                MultiSkins[3] = Texture'PinkMaskTex';
            	SetTimer(1.0,False);
          }
          else
          {
                MultiSkins[3] = Texture'GameMedia.Skins.SpotlightYellow';
            	SetTimer(1.0,False);
          }
      }

      if (bRedStatic)
                MultiSkins[3] = Texture'GameMedia.Skins.SpotlightRed';
}

//���� ������������ �� ��������� ����� 3...
defaultproperties
{
     bCanBeBase=True
     bInvincible=True
     bPushable=False
     Physics=PHYS_None
     Mesh=LodMesh'GameMedia.Spotlight'
     FragType=Class'DeusEx.MetalFragment'
     CollisionRadius=15.000000
     CollisionHeight=80.000000
     Mass=500.000000
     Buoyancy=15.000000
}
