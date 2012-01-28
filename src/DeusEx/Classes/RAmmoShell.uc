//=============================================================================
// ��������� - ��������. �������� Ded'�� ��� ���� 2027
// Ammo - Shell. Copyright (C) 2003 Ded 
// ����� ������/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class RAmmoShell extends DeusExAmmo;

var localized string ItemNameBullet;
var localized string ItemArticleBullet;

enum EType
{
	ET_Box,
	ET_SmallBox,
	ET_Bullet
};

var() EType AmmoType;

function BeginPlay()
{
	Super.BeginPlay();

	switch (AmmoType)
	{
		case ET_Box:                             AmmoAmount=12;
                                           ItemName=Default.ItemName;
                                           ItemArticle=Default.ItemArticle;
                                                        Mesh=RealMesh1;
                                              PickupViewMesh=RealMesh1;
                                                                 break;

		case ET_SmallBox:                         AmmoAmount=12;
                                           ItemName=Default.ItemName;
                                           ItemArticle=Default.ItemArticle;
                                                        Mesh=RealMesh1;
                                              PickupViewMesh=RealMesh1;
                                                                 break;

		case ET_Bullet:                           AmmoAmount=1;
                                            ItemName=Default.ItemNameBullet;
                                            ItemArticle=Default.ItemArticleBullet;
                                                        Mesh=RealMesh3;
                                              PickupViewMesh=RealMesh3;
                                                                 break;

	}
}

function bool UseAmmo(int AmountNeeded)
{
	local vector offset, tempvec, X, Y, Z;
	local ShellBuckshot shell;

	if (Super.UseAmmo(AmountNeeded))
	{
		GetAxes(Pawn(Owner).ViewRotation, X, Y, Z);
		offset = Owner.CollisionRadius * X + 0.3 * Owner.CollisionRadius * Y;
		tempvec = 0.8 * Owner.CollisionHeight * Z;
		offset.Z += tempvec.Z;
      if ((DeusExMPGame(Level.Game) != None) && (!DeusExMPGame(Level.Game).bSpawnEffects))
      {
         shell = None;
      }
      else
      {
         shell = spawn(class'ShellBuckshot',,, Owner.Location + offset);
      }
		if (shell != None)
		{
			shell.Velocity = (FRand()*20+90) * Y + (10-FRand()*20) * X;
			shell.Velocity.Z = 0;
		}
		return True;
	}

	return False;
}

//=======================================//
//           ������� ��������            //
//                                       //
//               Radius      Height      //
// - Box -        3.2         2.5        //
// - Bullet -     0.7         1.8        //
//=======================================//
// - Box -        12mmBox                //
// - Bullet -     12mmBBullet            //
//=======================================//

defaultproperties
{
     RealMesh1=LodMesh'GameMedia.12mmBox'
     RealMesh3=LodMesh'GameMedia.12mmBBullet'
     bShowInfo=True
     AmmoAmount=12
     MaxAmmo=180
     PickupViewMesh=LodMesh'GameMedia.12mmBox'
     LandSound=Sound'DeusExSounds.Generic.MetalHit1'
     Icon=Texture'GameMedia.Icons.BeltIcon12mmB'
     largeIcon=Texture'GameMedia.Icons.LargeIcon12mmB'
     largeIconWidth=32
     largeIconHeight=31
     Mesh=LodMesh'GameMedia.12mmBox'
     CollisionRadius=3.200000
     CollisionHeight=2.500000
     bCollideActors=True
}
