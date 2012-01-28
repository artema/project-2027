//=============================================================================
// ��������� ��� ���������. ������� Ded'�� ��� ���� 2027
// Pencil can.  Copyright (C) 2003 Ded
// ����� ������/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class PencilCan extends DeusExDecoration;

enum EType
{
	MT_Normal,
	MT_Random
};

var() EType MeshType;
var bool bRandomType;

function BeginPlay()
{
	Super.BeginPlay();

	switch (MeshType)
	{
		case MT_Normal:                      bRandomType=False;
                                                                 break;

		case MT_Random:                       bRandomType=True;
                                                                 break;
	}
}

function PostBeginPlay()
{
	Super.PostBeginPlay();

     if (bRandomType)
     {
	if (FRand() < 0.4)
	   MultiSkins[2] = Texture'PinkMaskTex';

	if (FRand() < 0.1)
	   MultiSkins[3] = Texture'PinkMaskTex';

	if (FRand() < 0.3)
	   MultiSkins[4] = Texture'PinkMaskTex';

	if (FRand() < 0.2)
	   MultiSkins[5] = Texture'PinkMaskTex';

	if (FRand() < 0.1)
	   MultiSkins[6] = Texture'PinkMaskTex';
     }
}

defaultproperties
{
     HitPoints=30
     FragType=Class'DeusEx.MetalFragment'
     Mesh=LodMesh'GameMedia.PencilCan'
     CollisionRadius=1.800000
     CollisionHeight=4.050000
     Mass=0.500000
     Buoyancy=40.000000
}
