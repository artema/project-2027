//=============================================================================
// ������. ������� Ded'�� ��� ���� 2027
// Hitman. Copyright (C) 2007 Ded
//=============================================================================
class Hitman extends HumanThug;

defaultproperties
{
     BaseAccuracy=-0.500000
     Skill=4.000000
     CarcassType=Class'Game.HitmanCarcass'
     WalkingSpeed=0.213333
     BaseAssHeight=-23.000000
     GroundSpeed=180.000000
     Mesh=LodMesh'DeusExCharacters.GM_Trench'
     MultiSkins(0)=Texture'GameMedia.Characters.HitmanTex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.SmugglerTex2'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.PantsTex8'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.SmugglerTex0'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.GilbertRentonTex1'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.SmugglerTex2'
     MultiSkins(6)=Texture'DeusExCharacters.Skins.FramesTex5'
     MultiSkins(7)=Texture'DeusExCharacters.Skins.LensesTex3'
     InitialInventory(0)=(Inventory=Class'Game.WeaponSpecialSilencedPistol')
     InitialInventory(1)=(Inventory=Class'DeusEx.RAmmo10mm',Count=150)
     InitialInventory(2)=(Inventory=Class'Game.WeaponSpecialKnife')
     CollisionRadius=20.000000
     CollisionHeight=47.500000
     BindName="Hitman"
}
