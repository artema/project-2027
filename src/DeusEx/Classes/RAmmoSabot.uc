//=============================================================================
// ��������� - �����. �������� Ded'�� ��� ���� 2027
// Ammo - Sabot. Copyright (C) 2003 Ded 
// ����� ������/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class RAmmoSabot extends DeusExAmmo;

var localized string ItemNameBullet;
var localized string ItemArticleBullet;

enum EType
{
	ET_Box,
	ET_Bullet
};

var() EType AmmoType;

function PostBeginPlay()
{
	Super.PostBeginPlay();

	switch (AmmoType)
	{
		case ET_Box:                             AmmoAmount=12;
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

function bool UseAmmo(int AmountNeeded)
{
	local vector offset, tempvec, X, Y, Z;
	local ShellSabot shell;

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
         shell = spawn(class'ShellSabot',,, Owner.Location + offset);
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
// - Box -        12mmBoxSabot           //
// - Bullet -     12mmSBullet            //
//=======================================//

defaultproperties
{
     bIsNonStandard=True
     RealMesh1=LodMesh'GameMedia.12mmBoxSabot'
     RealMesh2=LodMesh'GameMedia.12mmSBullet'
     bShowInfo=True
     AmmoAmount=12
     MaxAmmo=180
     PickupViewMesh=LodMesh'GameMedia.12mmBoxSabot'
     LandSound=Sound'DeusExSounds.Generic.MetalHit1'
     Icon=Texture'GameMedia.Icons.BeltIcon12mmS'
     largeIcon=Texture'GameMedia.Icons.LargeIcon12mmS'
     largeIconWidth=30
     largeIconHeight=32
     Mesh=LodMesh'GameMedia.12mmBoxSabot'
     CollisionRadius=3.200000
     CollisionHeight=2.500000
     bCollideActors=True
}
