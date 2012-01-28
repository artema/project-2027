//=============================================================================
// ��������� - 9x19��  �������. �������� Ded'�� ��� ���� 2027
// Ammo - 9x19mm rounds. Copyright (C) 2005 Ded 
// ����� ������/Model created by: Kelkos
// Deus Ex: 2027
//=============================================================================
class RAmmo9x19mm extends DeusExAmmo;

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

defaultproperties
{
	 bCannotBePickedUp=True
     bShowInfo=True
     AmmoAmount=32
     MaxAmmo=224
     PickupViewMesh=LodMesh'DeusExItems.TestBox'
     Mesh=LodMesh'DeusExItems.TestBox'
     Icon=Texture'GameMedia.Icons.BeltIcon9x19mm'
     largeIcon=Texture'GameMedia.Icons.LargeIcon9x19mm'
     largeIconWidth=42
     largeIconHeight=32
     CollisionRadius=4.000000
     CollisionHeight=0.500000
     bCollideActors=True
}
