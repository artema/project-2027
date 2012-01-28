//=============================================================================
// ����� ���. ������� Ded'�� ��� ���� 2027
// FBI Agent. Copyright (C) 2003 Ded
//=============================================================================
class FBI extends HumanMilitary;

defaultproperties
{
     BaseAccuracy=0.050000
     CarcassType=Class'Game.FBICarcass'
     WalkingSpeed=0.210000
     InitialInventory(0)=(Inventory=Class'Game.WeaponBeretta')
     InitialInventory(1)=(Inventory=Class'Game.TAmmo10mm',Count=100)
     InitialInventory(2)=(Inventory=Class'Game.WeaponRiotProd')
     InitialInventory(3)=(Inventory=Class'Game.TAmmoBattery',Count=50)
     walkAnimMult=0.750000
     GroundSpeed=180.000000
     Health=120
     Intelligence=BRAINS_HUMAN
     Skill=4.000000
     bKeepWeaponDrawn=True
     HealthHead=120
     HealthTorso=120
     HealthLegLeft=120
     HealthLegRight=120
     HealthArmLeft=120
     HealthArmRight=120
     Mesh=LodMesh'DeusExCharacters.GM_Suit'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.SecretServiceTex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.PantsTex5'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.SecretServiceTex0'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.MIBTex1'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.MIBTex1'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.FramesTex2'
     MultiSkins(6)=Texture'DeusExCharacters.Skins.LensesTex3'
     MultiSkins(7)=Texture'DeusExItems.Skins.PinkMaskTex'
     CollisionRadius=20.000000
     CollisionHeight=47.500000
     BindName="FBI"
}
