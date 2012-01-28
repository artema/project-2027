//=============================================================================
// �����. ������� Ded'�� ��� ���� 2027
// Folder. Copyright (C) 2005 Ded
// ����� ������/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class FolderBig extends DeusExDecoration;

enum ESkinColor
{
	SC_1,
	SC_2
};

var() bool bCanBeTaken;
var() ESkinColor SkinColor;

function BeginPlay()
{
	Super.BeginPlay();

	switch (SkinColor)
	{
		case SC_1:	Skin = Texture'GameMedia.Skins.FolderTex0'; break;
		case SC_2:	Skin = Texture'GameMedia.Skins.FolderTex1'; break;
	}
}

function Frob(Actor Frobber, Inventory frobWith)
{
	if (bCanBeTaken)
	{
		Super.Frob(Frobber, frobWith);
                Destroy();
	}
}

defaultproperties
{
     bInvincible=True
     bCanBeBase=True
     bPushable=False
     Physics=PHYS_None
     Mesh=LodMesh'GameMedia.FolderBig'
     CollisionRadius=10.000000
     CollisionHeight=0.700000
     Mass=2.000000
     Buoyancy=4.000000
}
