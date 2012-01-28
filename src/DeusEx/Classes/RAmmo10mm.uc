//=============================================================================
// ��������� - 10�� FMJ �������. �������� Ded'�� ��� ���� 2027
// Ammo - 10mm FMJ rounds. Copyright (C) 2003 Ded 
// ����� ������/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class RAmmo10mm extends DeusExAmmo;

var localized string ItemNameBullet;
var localized string ItemArticleBullet;

enum EType
{
	ET_Box,
	ET_Crate,
	ET_Bullet
};

var() EType AmmoType;

function BeginPlay()
{
	Super.BeginPlay();

	switch (AmmoType)
	{
		case ET_Box:                              AmmoAmount=9;
                                           ItemName=Default.ItemName;
                                           ItemArticle=Default.ItemArticle;
                                                        Mesh=RealMesh1;
                                              PickupViewMesh=RealMesh1;                                              
                                                                 break;

		case ET_Crate:                           AmmoAmount=18;
                                           ItemName=Default.ItemName;
                                           ItemArticle=Default.ItemArticle;
                                                        Mesh=RealMesh2;
                                              PickupViewMesh=RealMesh2;
                                                                 break;

		case ET_Bullet:                           AmmoAmount=1;
                                            ItemName=ItemNameBullet;
                                            ItemArticle=ItemArticleBullet;
                                                        Mesh=RealMesh3;
                                              PickupViewMesh=RealMesh3;
                                                                 break;

	}
}

function bool UpdateExistence()
{
	if(FRand() <= DeusExPlayer(GetPlayerPawn()).GetBadLuck())
	{
		if(AmmoType == ET_Crate) return false;
	}
	
	return true;
}

function bool UseAmmo(int AmountNeeded)
{
	local vector offset, tempvec, X, Y, Z;
	local Shell10mm shell;

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
         shell = spawn(class'Shell10mm',,, Owner.Location + offset);
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
// - Box -        1.5         1.4        //
// - Crate -      2.5         1.4        //
// - Bullet -     0.5         1.1        //
//=======================================//
// - Box -        10mmFMJBox             //
// - Crate -      10mmFMJCrate           //
// - Bullet -     10mmBullet             //
//=======================================//

defaultproperties
{
     RealMesh1=LodMesh'GameMedia.10mmFMJBox'
     RealMesh2=LodMesh'GameMedia.10mmFMJCrate'
     RealMesh3=LodMesh'GameMedia.10mmBullet'
     bShowInfo=True
     AmmoAmount=9
     MaxAmmo=180
     PickupViewMesh=LodMesh'GameMedia.10mmFMJBox'
     Icon=Texture'GameMedia.Icons.BeltIcon10mmFMJ'
     largeIcon=Texture'GameMedia.Icons.LargeIcon10mmFMJ'
     largeIconWidth=42
     largeIconHeight=32
     Mesh=LodMesh'GameMedia.10mmFMJBox'
     CollisionRadius=1.500000
     CollisionHeight=1.400000
     bCollideActors=True
}
