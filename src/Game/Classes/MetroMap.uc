//=============================================================================
// ����������. ������� Ded'�� ��� ���� 2027
// Photo card.  Copyright (C) 2003 Ded
// ����� ������/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class MetroMap extends Photos;

/*function BeginPlay()
{
	Super.BeginPlay();

      if(ImageTexture != None)
      {
          MultiSkins[1] = ImageTexture;
      }
      else
      {
          MultiSkins[1] = Texture'GameMedia.Skins.DefaultPhotoS';
	  log("***2027 - No photo!***");
      }
}*/

defaultproperties
{
     Mesh=LodMesh'GameMedia.MetroMap'
     DrawScale=1.3
     CollisionRadius=23.000000
     CollisionHeight=28.000000
     bBlockActors=False
     bBlockPlayers=False
     bCollideWorld=False
     Mass=10.000000
     Buoyancy=5.000000
}
