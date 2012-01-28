//=============================================================================
// ������. ������� Ded'�� ��� ���� 2027
// Bandit. Copyright (C) 2004 Ded
//=============================================================================
class Bandit2 extends HumanThug;

defaultproperties
{
     bKeepWeaponDrawn=True
     BaseAccuracy=0.100000
     CarcassType=Class'Game.Bandit2Carcass'
     InitialInventory(0)=(Inventory=Class'Game.WeaponAK74')
     InitialInventory(1)=(Inventory=Class'DeusEx.RAmmo556mm',Count=50)
     InitialInventory(2)=(Inventory=Class'Game.WeaponKnife')
     WalkingSpeed=0.296000
     walkAnimMult=0.780000
     GroundSpeed=200.000000
     Texture=Texture'DeusExItems.Skins.PinkMaskTex'
     Mesh=LodMesh'MPCharacters.mp_jumpsuit'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.SkinTex1'
     MultiSkins(1)=Texture'GameMedia.Characters.BanditTex2'
     MultiSkins(2)=Texture'GameMedia.Characters.BanditTex1'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.SkinTex1'
     MultiSkins(4)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(5)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(6)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(7)=Texture'DeusExItems.Skins.PinkMaskTex'
     CollisionRadius=20.000000
     CollisionHeight=47.500000
     BindName="Bandit"
}
