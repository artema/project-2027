//=============================================================================
// �����. ������� Ded'�� ��� ���� 2027
// Arman. Copyright (C) 2005 Ded
//=============================================================================
class Arman extends HumanThug;

enum EType
{
	MT_Standart,
	MT_Military
};

var() EType MeshType;

function BeginPlay()
{
	Super.BeginPlay();

	switch (MeshType)
	{
		case MT_Standart:
		break;

		case MT_Military:

		bHasTorsoDefence=True;
		bHasLegDefence=True;
		CarcassType=Class'Game.ArmanCarcass2';
		MultiSkins[3]=Texture'GameMedia.Characters.ArmanTex2';
		MultiSkins[5]=Texture'GameMedia.Characters.ArmanTex1';
		break;
	}
}

defaultproperties
{
     Health=130
     HealthHead=130
     HealthTorso=130
     HealthLegLeft=130
     HealthLegRight=130
     HealthArmLeft=130
     HealthArmRight=130
     BaseAccuracy=-0.100000
     CarcassType=Class'Game.ArmanCarcass'
     WalkingSpeed=0.213333
     walkAnimMult=0.500000
     GroundSpeed=180.000000
     Mesh=LodMesh'DeusExCharacters.GM_DressShirt'
     DrawScale=1.050000
     MultiSkins(0)=Texture'GameMedia.Characters.ArmanTex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.CopTex0'
     MultiSkins(2)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.PantsTex8'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.CopTex0'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.ChildMale2Tex1'
     MultiSkins(6)=Texture'DeusExCharacters.Skins.FramesTex2'
     MultiSkins(7)=Texture'DeusExCharacters.Skins.LensesTex5'
     CollisionRadius=21.000000
     CollisionHeight=49.880001
     BindName="Arman"
     BarkBindName="Arman"
}
