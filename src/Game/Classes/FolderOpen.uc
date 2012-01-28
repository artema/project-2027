//=============================================================================
// �����. ������� Ded'�� ��� ���� 2027
// Folder. Copyright (C) 2005 Ded
// ����� ������/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class FolderOpen extends InformationDevices;

enum ESkinColor
{
	SC_1,
	SC_2
};

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

defaultproperties
{
     bCanBeBase=True
     Mesh=LodMesh'GameMedia.FolderOpen'
     CollisionRadius=12.000000
     CollisionHeight=0.200000
     Mass=1.000000
     Buoyancy=4.000000
}
