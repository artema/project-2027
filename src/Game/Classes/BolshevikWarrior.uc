class BolshevikWarrior extends HumanThug;

enum EGogglesType
{
	GT_None,
	GT_Red1,
	GT_Red2,
	GT_Yellow
};

var() EGogglesType GogglesType;

enum EFaceType
{
	FT_Default,
	FT_RedEyes,
	FT_Wires
};

var() EFaceType FaceType;

enum EBodyType
{
	BT_Vest,
	BT_Muscle
};

var() EBodyType BodyType;

enum ELegsType
{
	LT_Normal,
	LT_Mech
};

var() ELegsType LegsType;

function BeginPlay()
{
	Super.BeginPlay();

	switch (GogglesType)
	{
		case GT_None:
			MultiSkins[4]=Texture'DeusExCharacters.Skins.PinkMaskTex';
			break;
			
		case GT_Red1:
			MultiSkins[4]=Texture'GameMedia.Characters.BolshevikTex3a';
			break;
			
		case GT_Red2:
			MultiSkins[4]=Texture'GameMedia.Characters.BolshevikTex3b';
			break;
			
		case GT_Yellow:
			MultiSkins[4]=Texture'GameMedia.Characters.BolshevikTex3c';
			break;
	}
	
	switch (FaceType)
	{
		case FT_Default:
			MultiSkins[2]=Texture'GameMedia.Characters.BolshevikTex1a';
			MultiSkins[3]=Texture'GameMedia.Characters.BolshevikTex1a';
			break;
		
		case FT_Wires:
			MultiSkins[2]=Texture'GameMedia.Characters.BolshevikTex1b';
			MultiSkins[3]=Texture'GameMedia.Characters.BolshevikTex1b';
			break;
			
		case FT_RedEyes:
			MultiSkins[2]=Texture'GameMedia.Characters.BolshevikTex1c';
			MultiSkins[3]=Texture'GameMedia.Characters.BolshevikTex1c';
			break;
	}
	
	switch (BodyType)
	{
		case BT_Vest:
			MultiSkins[0]=Texture'GameMedia.Characters.BolshevikTex2a';
			break;
			
		case BT_Muscle:
			MultiSkins[0]=Texture'GameMedia.Characters.BolshevikTex2b';
			break;
	}
	
	switch (LegsType)
	{
		case LT_Normal:
			MultiSkins[1]=Texture'GameMedia.Characters.BolshevikTex4a';
			break;
			
		case LT_Mech:
			MultiSkins[1]=Texture'GameMedia.Characters.BolshevikTex4b';
			WalkSound=Sound'DeusExSounds.Robot.SecurityBot2Walk';
			bHasLegDefence=True;
			break;
	}
}

function Carcass SpawnCarcass()
{
	local Carcass carc;
	local int i;
	
	carc = Super.SpawnCarcass();
	
	for(i=0; i<8; i++)
		carc.MultiSkins[i] = MultiSkins[i];
	
	return carc;
}

defaultproperties
{
	 AmritaRate=5
	 bHasTorsoDefence=True
     bHasLegDefence=True
     bHasMask=True
	 Health=170
     HealthHead=170
     HealthTorso=170
     HealthLegLeft=170
     HealthLegRight=170
     HealthArmLeft=170
     HealthArmRight=170
     BaseAccuracy=0.05
     CarcassType=Class'Game.BolshevikWarriorCarcass'
     WalkingSpeed=0.350000
     walkAnimMult=0.750000
     GroundSpeed=210.000000
     Texture=Texture'DeusExItems.Skins.BlackMaskTex'
     Mesh=LodMesh'DeusExCharacters.GM_DressShirt_B'
     MultiSkins(0)=Texture'GameMedia.Characters.BolshevikTex2a'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.ThugMale3Tex2'
     MultiSkins(2)=Texture'GameMedia.Characters.BolshevikTex1a'
     MultiSkins(3)=Texture'GameMedia.Characters.BolshevikTex1a'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.PinkMaskTex'
     MultiSkins(5)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(6)=Texture'DeusExItems.Skins.BlackMaskTex'
     MultiSkins(7)=Texture'DeusExItems.Skins.BlackMaskTex'
     CollisionRadius=20.000000
     CollisionHeight=47.500000
     BindName="AsuraWarrior"
     BarkBindName="AsuraWarrior"
}