//=============================================================================
// ���� ������ �����. ������� Ded'�� ��� ���� 2027
// Black gang member. Copyright (C) 2003 Ded
//=============================================================================
class BlackGangMember extends HumanThug;

defaultproperties
{
     bHasTorsoDefence=True
     BaseAccuracy=0.100000
     CarcassType=Class'Game.BlackGangMemberCarcass'
     WalkingSpeed=0.296000
     InitialInventory(0)=(Inventory=Class'Game.WeaponShotgun')
     InitialInventory(1)=(Inventory=Class'DeusEx.RAmmoShell',Count=40)
     InitialInventory(2)=(Inventory=Class'Game.WeaponIronCrowbar')
     walkAnimMult=0.800000
     GroundSpeed=200.000000
     Mesh=LodMesh'DeusExCharacters.GM_DressShirt'
     MultiSkins(0)=Texture'GameMedia.Characters.BlackGangTex0'
     MultiSkins(1)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(2)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(3)=Texture'GameMedia.Characters.BlackGangTex2'
     MultiSkins(4)=Texture'GameMedia.Characters.BlackGangTex0'
     MultiSkins(5)=Texture'GameMedia.Characters.BlackGangTex1'
     MultiSkins(6)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(7)=Texture'DeusExItems.Skins.BlackMaskTex'
     CollisionRadius=20.000000
     CollisionHeight=47.500000
     BindName="BlackGangMember"
}
