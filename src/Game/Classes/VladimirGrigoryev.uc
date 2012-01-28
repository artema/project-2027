//=============================================================================
// �������� ���������. ������� Ded'�� ��� ���� 2027
// Vladimir Grigoryev. Copyright (C) 2003 Ded
//=============================================================================
class VladimirGrigoryev extends HumanThug;

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

     GroundSpeed=180.000000;
     bKeepWeaponDrawn=False;
     CarcassType=Class'Game.VladimirGrigoryevCarcass';
     Mesh=LodMesh'DeusExCharacters.GM_Suit';
     MultiSkins[0]=Texture'GameMedia.Characters.VladimirTex0';
     MultiSkins[1]=Texture'DeusExCharacters.Skins.Male2Tex2';
     MultiSkins[2]=Texture'GameMedia.Characters.VladimirTex0';
     MultiSkins[3]=Texture'DeusExCharacters.Skins.JoeGreeneTex1';
     MultiSkins[4]=Texture'DeusExCharacters.Skins.JoeGreeneTex1';
     MultiSkins[5]=Texture'DeusExItems.Skins.GrayMaskTex';
     MultiSkins[6]=Texture'DeusExItems.Skins.BlackMaskTex';
     MultiSkins[7]=Texture'DeusExItems.Skins.PinkMaskTex';
                                                                 break;

		case MT_Military:

     GroundSpeed=240.000000;
     runAnimMult=1.05;
     bKeepWeaponDrawn=True;
     CarcassType=Class'Game.VladimirGrigoryevMCarcass';
     Mesh=LodMesh'MPCharacters.mp_jumpsuit';
     MultiSkins[0]=Texture'DeusExItems.Skins.BlackMaskTex';
     MultiSkins[1]=Texture'GameMedia.Characters.VladimirMilitaryTex2';
     MultiSkins[2]=Texture'GameMedia.Characters.VladimirMilitaryTex1';
     MultiSkins[3]=Texture'GameMedia.Characters.VladimirTex0';
     MultiSkins[4]=Texture'DeusExItems.Skins.PinkMaskTex';
     MultiSkins[5]=Texture'GameMedia.Characters.VladimirMilitaryTex3';
     MultiSkins[6]=Texture'GameMedia.Characters.VladimirMilitaryTex3';
     MultiSkins[7]=Texture'DeusExItems.Skins.BlackMaskTex';
     Texture=Texture'DeusExItems.Skins.PinkMaskTex';
                                                                 break;
	}
}

function ShowCloakEffect()
{
	SetSkinStyle(STY_Translucent, Texture'WhiteStatic', 0.0075);
	Spawn(class'SFXCamoOnLight',,, Location);
	Spawn(class'SFXCamoOnFlash',,, Location);
	PlaySound(Sound'CloakUp', SLOT_None, 0.85,, 768, 1.0);
}

function HideCloakEffect()
{
	ResetSkinStyle();
	Spawn(class'SFXCamoOnLight',,, Location);
	Spawn(class'SFXCamoOnFlash',,, Location);
	PlaySound(Sound'CloakDown', SLOT_None, 0.85,, 768, 1.0);
}

function ResetSkinStyle()
{
	MultiSkins[0]=Texture'DeusExItems.Skins.BlackMaskTex';
    MultiSkins[1]=Texture'GameMedia.Characters.VladimirMilitaryTex2';
    MultiSkins[2]=Texture'GameMedia.Characters.VladimirMilitaryTex1';
    MultiSkins[3]=Texture'GameMedia.Characters.VladimirTex0';
    MultiSkins[4]=Texture'DeusExItems.Skins.PinkMaskTex';
    MultiSkins[5]=Texture'GameMedia.Characters.VladimirMilitaryTex3';
    MultiSkins[6]=Texture'GameMedia.Characters.VladimirMilitaryTex3';
    MultiSkins[7]=Texture'DeusExItems.Skins.BlackMaskTex';
    Texture=Texture'DeusExItems.Skins.PinkMaskTex';
     
	Skin      = Default.Skin;
	ScaleGlow = Default.ScaleGlow;
	Style     = Default.Style;
}

defaultproperties
{
     BaseAccuracy=0.000000
     Skill=4.000000
     bImportant=True
     bInvincible=True
     CarcassType=Class'Game.VladimirGrigoryevCarcass'
     WalkingSpeed=0.213333
     walkAnimMult=0.750000
     GroundSpeed=180.000000
     bKeepWeaponDrawn=True
     Health=350
     HealthHead=350
     HealthTorso=350
     HealthLegLeft=350
     HealthLegRight=350
     HealthArmLeft=350
     HealthArmRight=350
     Mesh=LodMesh'DeusExCharacters.GM_Suit'
     MultiSkins(0)=Texture'GameMedia.Characters.VladimirTex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.Male2Tex2'
     MultiSkins(2)=Texture'GameMedia.Characters.VladimirTex0'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.JoeGreeneTex1'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.JoeGreeneTex1'
     MultiSkins(5)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(6)=Texture'DeusExItems.Skins.BlackMaskTex'
     MultiSkins(7)=Texture'DeusExItems.Skins.PinkMaskTex'
     InitialInventory(0)=(Inventory=Class'Game.WeaponSpecialAK47')
     InitialInventory(1)=(Inventory=Class'DeusEx.RAmmo762mm',Count=250)
     InitialInventory(2)=(Inventory=Class'Game.WeaponSpecialSilencedPistol')
     InitialInventory(3)=(Inventory=Class'DeusEx.RAmmo10mm',Count=250)
     InitialInventory(4)=(Inventory=Class'Game.WeaponSpecialKnife')
     CollisionRadius=20.000000
     CollisionHeight=47.500000
     BindName="VladimirGrigoryev"
     BarkBindName="VladimirGrigoryev"
}
