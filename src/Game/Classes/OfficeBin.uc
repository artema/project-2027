//=============================================================================
// �������� �������. ������� Ded'�� ��� ���� 2027
// Office bin. Copyright (C) 2005 Ded
// Deus Ex: 2027
//=============================================================================
class OfficeBin extends Containers;

enum ESkinColor
{
	SC_Dark,
	SC_Light
};

var() ESkinColor SkinColor;

function BeginPlay()
{
	Super.BeginPlay();

	switch (SkinColor)
	{
		case SC_Dark:	Skin = Texture'GameMedia.Skins.OfficeBinTex0'; break;
		case SC_Light:	Skin = Texture'GameMedia.Skins.OfficeBinTex1'; break;
	}
}

defaultproperties
{
     bGenerateFlies=False
     HitPoints=20
     Mesh=LodMesh'GameMedia.OfficeBin'
     CollisionRadius=11.300000
     CollisionHeight=16.000000
     Mass=20.000000
     Buoyancy=40.000000
}
