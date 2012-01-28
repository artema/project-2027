//=============================================================================
// ���� ����� �����. ������� Ded'�� ��� ���� 2027
// White gang member. Copyright (C) 2003 Ded
//=============================================================================
class WhiteGangMember2 extends HumanThug;

defaultproperties
{
     BaseAccuracy=0.100000
     CarcassType=Class'Game.WhiteGangMember2Carcass'
     WalkingSpeed=0.296000
     InitialInventory(0)=(Inventory=Class'Game.WeaponShotgun')
     InitialInventory(1)=(Inventory=Class'Game.TAmmoShell',Count=40)
     InitialInventory(2)=(Inventory=Class'Game.WeaponIronCrowbar')
     walkAnimMult=0.800000
     GroundSpeed=200.000000
     Mesh=LodMesh'DeusExCharacters.GM_DressShirt'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.SkinTex3'
     MultiSkins(1)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(2)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.PantsTex6'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.CopTex0'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.SoldierTex1'
     MultiSkins(6)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(7)=Texture'DeusExItems.Skins.BlackMaskTex'
     CollisionRadius=20.000000
     CollisionHeight=47.500000
     BindName="WhiteGangMember"
     BarkBindName="WhiteGangMember"
}
