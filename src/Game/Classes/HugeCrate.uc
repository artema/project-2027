//=============================================================================
// �������. ������� Ded'�� ��� ���� 2027
// Crate. Copyright (C) 2003 Ded
//=============================================================================
class HugeCrate extends Containers;

function PostBeginPlay()
{
	Super.BeginPlay();

         MultiSkins[1] = Texture'GameMedia.Skins.HugeCrateTex0';
}

defaultproperties
{
     MultiSkins(0)=Texture'GameMedia.Skins.HugeCrateTex0'
     bInvincible=True
     bFlammable=False
     bBlockSight=True
     Mesh=LodMesh'DeusExDeco.DXMPAmmobox'
     CollisionRadius=22.500000
     CollisionHeight=16.000000
     Mass=40.000000
     Buoyancy=50.000000
}
