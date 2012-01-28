//=============================================================================
// ����������. ������� Ded'�� ��� ���� 2027
// Photo.  Copyright (C) 2003 Ded
// ����� ������/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class Photo1 extends Photos;

function BeginPlay()
{
	Super.BeginPlay();

      if(ImageTexture != None)
      {
          MultiSkins[1] = ImageTexture;
      }
      else
      {
          MultiSkins[1] = Texture'GameMedia.Skins.Photo1Tex0';
	  log("***2027 - No photo!***");
      }
}

defaultproperties
{
     bInvincible=True
     FragType=Class'DeusEx.PaperFragment'
     HitPoints=10
     Mesh=LodMesh'GameMedia.Photo1'
     bBlockActors=False
     bBlockPlayers=False
     bCollideActors=True
     bCollideWorld=False
     CollisionRadius=4.500000
     CollisionHeight=0.100000
     Mass=0.100000
     Buoyancy=5.000000
}
