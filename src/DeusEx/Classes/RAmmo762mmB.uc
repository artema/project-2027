//=============================================================================
// ��������� - 7.62�� ������ �������. �������� Ded'�� ��� ���� 2027
// Ammo - 7.62mm black rounds. Copyright (C) 2003 Ded 
// ����� ������/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class RAmmo762mmB extends DeusExAmmo;

var localized string ItemNameBullet;
var localized string ItemArticleBullet;

enum EType
{
	ET_Crate,
	ET_Bullet
};

var() EType AmmoType;

function BeginPlay()
{
	Super.BeginPlay();

	switch (AmmoType)
	{
		case ET_Crate:                           AmmoAmount=30;
                                                ItemName=Default.ItemName;
                                                ItemArticle=Default.ItemArticle;
                                                        Mesh=RealMesh1;
                                              PickupViewMesh=RealMesh1;
                                                                 break;

		case ET_Bullet:                           AmmoAmount=1;
                                                ItemName=ItemNameBullet;
                                                ItemArticle=ItemArticleBullet;
                                                        Mesh=RealMesh2;
                                              PickupViewMesh=RealMesh2;
                                                                 break;

	}
}

function bool UpdateExistence()
{
	if(FRand() <= DeusExPlayer(GetPlayerPawn()).GetBadLuck())
	{
		if(FRand() <= 0.5) return false;
	}
	
	return true;
}

function bool UseAmmo(int AmountNeeded)
{
	local vector offset, tempvec, X, Y, Z;
	local Shell762mm shell;

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
         shell = spawn(class'Shell762mm',,, Owner.Location + offset);
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
// - Crate -      2.1         2.3        //
// - Bullet -     0.5         1.5        //
//=======================================//
// - Crate -       762NoirCrate          //
// - Bullet -      762mmBulletB          //
//=======================================//

defaultproperties
{
     bIsNonStandard=True
     RealMesh1=LodMesh'GameMedia.762NoirCrate'
     RealMesh2=LodMesh'GameMedia.762mmBulletB'
     bShowInfo=True
     AmmoAmount=30
     MaxAmmo=300
     PickupViewMesh=LodMesh'GameMedia.762NoirCrate'
     Icon=Texture'GameMedia.Icons.BeltIcon762mmJHP'
     largeIcon=Texture'GameMedia.Icons.LargeIcon762mmJHP'
     largeIconWidth=27
     largeIconHeight=38
     Mesh=LodMesh'GameMedia.762NoirCrate'
     CollisionRadius=2.100000
     CollisionHeight=2.300000
     bCollideActors=True
}
