//=============================================================================
// �����. ������� Ded'�� ��� ���� 2027
// Lamp. Copyright (C) 2004 Ded
// ����� ������/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class CageLamp extends DeusExDecoration;

enum ESkinColor
{
	SC_Yellow,
	SC_Blue,
	SC_Red
};

var() ESkinColor SkinColor;

function BeginPlay()
{
	Super.BeginPlay();

	switch (SkinColor)
	{
		case SC_Yellow:	MultiSkins[1] = Texture'GameMedia.Skins.CageLampTex0'; break;
		case SC_Blue:	MultiSkins[1] = Texture'GameMedia.Skins.CageLampTex1'; break;
		case SC_Red:	MultiSkins[1] = Texture'GameMedia.Skins.CageLampTex2'; break;
	}
}

defaultproperties
{
     bMovable=False
     HitPoints=5
     bInvincible=True
     FragType=Class'DeusEx.GlassFragment'
     bHighlight=False
     bCanBeBase=False
     bPushable=False
     Physics=PHYS_None
     Mesh=LodMesh'GameMedia.CageLamp'
     ScaleGlow=2.000000
     CollisionRadius=12.000000
     CollisionHeight=18.000000
     Mass=20.000000
     Buoyancy=10.000000
}
