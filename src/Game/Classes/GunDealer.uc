//=============================================================================
// �������� �������. ������� Ded'�� ��� ���� 2027
// Gun dealer. Copyright (C) 2003 Ded
//=============================================================================
class GunDealer extends HumanThug;

defaultproperties
{
     BaseAccuracy=0.100000
     Skill=3.000000
     CarcassType=Class'Game.GunDealerCarcass'
     bImportant=True
     bInvincible=True
     InitialInventory(0)=(Inventory=Class'Game.WeaponAutoShotgun')
     InitialInventory(1)=(Inventory=Class'DeusEx.RAmmoShell',Count=50)
     InitialInventory(2)=(Inventory=Class'Game.WeaponIronCrowbar')
     walkAnimMult=1.050000
     GroundSpeed=200.000000
     WalkingSpeed=0.296000
     Mesh=LodMesh'DeusExCharacters.GM_DressShirt'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.Businessman2Tex0'
     MultiSkins(1)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(2)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.JoJoFineTex2'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.JoJoFineTex0'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.HowardStrongTex1'
     MultiSkins(6)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(7)=Texture'DeusExItems.Skins.BlackMaskTex'
     CollisionRadius=20.000000
     CollisionHeight=47.500000
     BindName="GunDealer"
}
