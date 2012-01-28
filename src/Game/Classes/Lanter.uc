//=============================================================================
// ������. ������� Ded'�� ��� ���� 2027
// Lanter. Copyright (C) 2003 Ded
// ����� ������/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class Lanter extends HangingDecoration;

enum ESkinColor
{
	SC_Yellow,
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
		case SC_Yellow:	MultiSkins[1] = Texture'GameMedia.Skins.LanterTex0';
	                        MultiSkins[2] = Texture'GameMedia.Skins.LanterTex0'; break;
		case SC_Blue:	MultiSkins[1] = Texture'GameMedia.Skins.LanterTex1';
	                        MultiSkins[2] = Texture'GameMedia.Skins.LanterTex1'; break;
		case SC_Green:	MultiSkins[1] = Texture'GameMedia.Skins.LanterTex2';
	                        MultiSkins[2] = Texture'GameMedia.Skins.LanterTex2'; break;
		case SC_Red:	MultiSkins[1] = Texture'GameMedia.Skins.LanterTex3';
	                        MultiSkins[2] = Texture'GameMedia.Skins.LanterTex3'; break;
	}
}

defaultproperties
{
     FragType=Class'DeusEx.GlassFragment'
     bHighlight=False
     bInvincible=True
     bPushable=False
     Physics=PHYS_None
     PrePivot=(Z=13.000000)
     Mesh=LodMesh'GameMedia.Lanter'
     ScaleGlow=0.500000
     bUnlit=True
     CollisionRadius=13.500000
     CollisionHeight=10.000000
     Mass=15.000000
     Buoyancy=2.000000
}
