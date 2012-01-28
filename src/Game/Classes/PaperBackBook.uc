//=============================================================================
// �����. �������� Ded'�� ��� ���� 2027
// Book. Copyright (C) 2003 Ded
// ����� ������/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class PaperBackBook extends InformationDevices;

enum ESkin
{
	ES_College,
        ES_Erich,
        ES_Kilt,
        ES_Mafia,
        ES_Red,
        ES_Horror,
        ES_Viruses,
        ES_PaleGreen,
        ES_America,
        ES_Business
};

var() ESkin SkinType;

function BeginPlay()
{
	Super.BeginPlay();

	switch (SkinType)
	{
		case ES_College:
                  MultiSkins[1] = Texture'GameMedia.Skins.SmallBookTex0';
                                                                   break;

		case ES_Erich:
                  MultiSkins[1] = Texture'GameMedia.Skins.SmallBookTex1';
                                                                   break;

		case ES_Kilt:
                  MultiSkins[1] = Texture'GameMedia.Skins.SmallBookTex2';
                                                                   break;

		case ES_Mafia:
                  MultiSkins[1] = Texture'GameMedia.Skins.SmallBookTex3';
                                                                   break;

		case ES_Red:
                  MultiSkins[1] = Texture'GameMedia.Skins.SmallBookTex4';
                                                                   break;

		case ES_Horror:
                  MultiSkins[1] = Texture'GameMedia.Skins.SmallBookTex5';
                                                                   break;

		case ES_Viruses:
                  MultiSkins[1] = Texture'GameMedia.Skins.SmallBookTex6';
                                                                   break;

		case ES_PaleGreen:
                  MultiSkins[1] = Texture'GameMedia.Skins.SmallBookTex7';
                                                                   break;

		case ES_America:
                  MultiSkins[1] = Texture'GameMedia.Skins.SmallBookTex8';
                                                                   break;

		case ES_Business:
                  MultiSkins[1] = Texture'GameMedia.Skins.SmallBookTex9';
                                                                   break;
	}
}

defaultproperties
{
     bCanBeBase=True
     Mesh=LodMesh'GameMedia.PaperBackBook'
     CollisionRadius=7.000000
     CollisionHeight=0.200000
     Mass=10.000000
     Buoyancy=11.000000
}
