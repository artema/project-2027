//=============================================================================
// �����. ������� Ded'�� ��� ���� 2027
// Book.  Copyright (C) 2003 Ded
// ����� ������/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class OldBook extends InformationDevices;

enum ESkinColor
{
	SC_Blue,
	SC_Green,
	SC_Red
};

var() ESkinColor SkinColor;

function BeginPlay()
{
	Super.BeginPlay();

	switch (SkinColor)
	{
		case SC_Blue:		Skin = Texture'GameMedia.Skins.OldBookTex0'; break;
		case SC_Green:		Skin = Texture'GameMedia.Skins.OldBookTex1'; break;
		case SC_Red:		Skin = Texture'GameMedia.Skins.OldBookTex2'; break;
	}
}

defaultproperties
{
     bCanBeBase=True
     Mesh=LodMesh'GameMedia.OldBook'
     CollisionRadius=15.000000
     CollisionHeight=1.000000
     Mass=10.000000
     Buoyancy=11.000000
}
