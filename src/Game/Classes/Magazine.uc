//=============================================================================
// ������. �������� Ded'�� ��� ���� 2027
// Magazine. Copyright (C) 2003 Ded
// ����� ������/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class Magazine extends InformationDevices;

enum ESkin
{
	ES_Yaht1,
        ES_Yaht2,
        ES_Arctic,
        ES_Napoleon,
	ES_RusTech1,
	ES_RusTech2,
	ES_RusTech3,
	ES_RusTech4,
	ES_RusTech5,
};

var() ESkin SkinType;

function BeginPlay()
{
	Super.BeginPlay();

	switch (SkinType)
	{
		case ES_Yaht1:
                  MultiSkins[1] = Texture'GameMedia.Skins.MagazineTex0';
                                                                  break;

		case ES_Yaht2:
                  MultiSkins[1] = Texture'GameMedia.Skins.MagazineTex1';
                                                                  break;

		case ES_Arctic:
                  MultiSkins[1] = Texture'GameMedia.Skins.MagazineTex2';
                                                                  break;

		case ES_Napoleon:
                  MultiSkins[1] = Texture'GameMedia.Skins.MagazineTex3';
                                                                  break;

		case ES_RusTech1:
                  MultiSkins[1] = Texture'GameMedia.Skins.MagazineTex4';
                                                                  break;

		case ES_RusTech2:
                  MultiSkins[1] = Texture'GameMedia.Skins.MagazineTex5';
                                                                  break;

		case ES_RusTech3:
                  MultiSkins[1] = Texture'GameMedia.Skins.MagazineTex6';
                                                                  break;

		case ES_RusTech4:
                  MultiSkins[1] = Texture'GameMedia.Skins.MagazineTex7';
                                                                  break;

		case ES_RusTech5:
                  MultiSkins[1] = Texture'GameMedia.Skins.MagazineTex8';
                                                                  break;
	}
}

defaultproperties
{
     bCanBeBase=True
     ScaleGlow=0.6
     Mesh=LodMesh'GameMedia.Magazine'
     CollisionRadius=8.000000
     CollisionHeight=0.300000
     Mass=10.000000
     Buoyancy=11.000000
}
