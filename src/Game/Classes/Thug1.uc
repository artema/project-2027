//=============================================================================
// ����������. ������� Ded'�� ��� ���� 2027
// Thug. Copyright (C) 2003 Ded
//=============================================================================
class Thug1 extends HumanThug;

defaultproperties
{
     CarcassType=Class'Game.Thug1Carcass'
     WalkingSpeed=0.296000
     InitialInventory(0)=(Inventory=Class'Game.WeaponShotGun')
     InitialInventory(1)=(Inventory=Class'DeusEx.RAmmoShell',Count=50)
     InitialInventory(2)=(Inventory=Class'Game.WeaponIronCrowbar')
     walkAnimMult=0.800000
     GroundSpeed=200.000000
     Mesh=LodMesh'MPCharacters.mp_jumpsuit'
     MultiSkins(0)=Texture'GameMedia.Characters.Thug1Tex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.JoJoFineTex2'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.ThugMale2Tex1'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.ThugMale2Tex0'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.ThugMale2Tex0'
     MultiSkins(5)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(6)=Texture'DeusExCharacters.Skins.ThugMale3Tex3'
     MultiSkins(7)=Texture'GameMedia.Characters.Thug1Tex0'
     Texture=Texture'DeusExItems.Skins.PinkMaskTex'
     Skin=Texture'DeusExItems.Skins.PinkMaskTex'
     CollisionRadius=20.000000
     CollisionHeight=47.500000
     BindName="Thug"
     BarkBindName="Thug"
     Mass=100.000000
}
