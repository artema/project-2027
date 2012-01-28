//=============================================================================
// ��������� - 5.56�� JHP �������. �������� Ded'�� ��� ���� 2027
// Ammo - 5.56mm JHP rounds. Copyright (C) 2003 Ded 
// ����� ������/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class RAmmo556mmJHP extends DeusExAmmo;

var localized string ItemNameBullet;
var localized string ItemArticleBullet;

enum EType
{
	ET_Crate,
	ET_Bullet,
};

var() EType AmmoType;

function BeginPlay()
{
	Super.BeginPlay();

	switch (AmmoType)
	{
		case ET_Crate:                            AmmoAmount=30;
                                          ItemName=Default.ItemName;
                                          ItemArticle=Default.ItemArticle;
                                                         Mesh=RealMesh1;
                                               PickupViewMesh=RealMesh1;
                                               
                                                                  break;

		case ET_Bullet:                            AmmoAmount=1;
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
	local Shell556mm shell;

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
         shell = spawn(class'Shell556mm',,, Owner.Location + offset);
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
// - Crate -      2.6         1.77       //
// - Bullet -     0.5         1.1        //
//=======================================//
// - Crate -       556mmJHPCrate         //
// - Bullet -      556mmJHP              //
//=======================================//

defaultproperties
{
     bIsNonStandard=True
     RealMesh1=LodMesh'GameMedia.556mmJHPCrate'
     RealMesh2=LodMesh'GameMedia.556mmJHP'
     bShowInfo=True
     AmmoAmount=30
     MaxAmmo=300
     PickupViewMesh=LodMesh'GameMedia.556mmJHPCrate'
     Icon=Texture'GameMedia.Icons.BeltIcon556mmJHP'
     largeIcon=Texture'GameMedia.Icons.LargeIcon556mmJHP'
     largeIconWidth=40
     largeIconHeight=31
     Mesh=LodMesh'GameMedia.556mmJHPCrate'
     CollisionRadius=2.600000
     CollisionHeight=1.770000
     bCollideActors=True
}
