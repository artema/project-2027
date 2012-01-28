//=============================================================================
// ����. �������� Ded'�� ��� ���� 2027
// Leaf. Copyright (C) 2004 Ded
// ����� ������/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class OldLeaf extends Trash;

function PostBeginPlay()
{
	Super.PostBeginPlay();

	if ((FRand() > 0.0) && (FRand() < 0.25))
	   MultiSkins[0] = Texture'GameMedia.Skins.LeafTex0';
	else if ((FRand() > 0.25) && (FRand() < 0.5))
	   MultiSkins[0] = Texture'GameMedia.Skins.LeafTex1';
	else if ((FRand() > 0.5) && (FRand() < 0.75))
	   MultiSkins[0] = Texture'GameMedia.Skins.LeafTex2';
	else
	   MultiSkins[0] = Texture'GameMedia.Skins.LeafTex3';

}

defaultproperties
{
     bStasis=False
     LODBias=2.000000
     LifeSpan=90
     PushSound=None
     bInvincible=True
     Mesh=LodMesh'GameMedia.Leaf'
     FragType=Class'Game.EmptyFragment'
     ScaleGlow=0.300000
     CollisionRadius=6.500000
     CollisionHeight=0.500000
}
