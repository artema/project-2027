//=============================================================================
// ��������� - 3006 �������. �������� Ded'�� ��� ���� 2027
// Ammo - 3006 rounds. Copyright (C) 2003 Ded 
// ����� ������/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class RAmmo3006 extends DeusExAmmo;

var localized string ItemNameBullet;
var localized string ItemArticleBullet;

enum EType
{
	ET_Box,
	ET_Bullet
};

var() EType AmmoType;

function BeginPlay()
{
	Super.BeginPlay();

	switch (AmmoType)
	{
		case ET_Box:                               AmmoAmount=6;
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

function bool UseAmmo(int AmountNeeded)
{
	local vector offset, tempvec, X, Y, Z;
	local Shell3006 shell;

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
         shell = spawn(class'Shell3006',,, Owner.Location + offset);
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
// - Box -        4.0         2.3        //
// - Bullet -     0.65        2.3        //
//=======================================//
// - Box -        3006Box                //
// - Bullet -     3006Bullet             //
//=======================================//

defaultproperties
{
     RealMesh1=LodMesh'GameMedia.3006Box'
     RealMesh2=LodMesh'GameMedia.3006Bullet'
     bShowInfo=True
     AmmoAmount=6
     MaxAmmo=60
     PickupViewMesh=LodMesh'GameMedia.3006Box'
     LandSound=Sound'DeusExSounds.Generic.MetalHit1'
     Icon=Texture'GameMedia.Icons.BeltIcon3006'
     largeIcon=Texture'GameMedia.Icons.LargeIcon3006'
     largeIconWidth=39
     largeIconHeight=31
     Mesh=LodMesh'GameMedia.3006Box'
     CollisionRadius=4.000000
     CollisionHeight=2.300000
     bCollideActors=True
}
