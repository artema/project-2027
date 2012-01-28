//=============================================================================
// ������� �������. �������� Ded'�� ��� ���� 2027
// Russian Militia. Copyright (C) 2003 Ded
//=============================================================================
class RussianMent extends HumanMilitary;

defaultproperties
{
	 bCanStrafe=False
	 bCanSit=False
     bHasTorsoDefence=True
     bHasLegDefence=True
     bAimForHead=True
     BaseAccuracy=-0.200000
     CarcassType=Class'Game.RussianMentCarcass'
     WalkingSpeed=0.296000
     walkAnimMult=0.680000
     GroundSpeed=150.000000
     MinHealth=50
     bKeepWeaponDrawn=True
     InitialInventory(0)=(Inventory=Class'Game.WeaponBeretta')
     InitialInventory(1)=(Inventory=Class'DeusEx.RAmmo10mm',Count=50)
     InitialInventory(2)=(Inventory=Class'Game.WeaponKnife')
     Mesh=LodMesh'DeusExCharacters.GM_DressShirt_F'
     MultiSkins(0)=Texture'GameMedia.Characters.MentTex0'
     MultiSkins(1)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(2)=Texture'GameMedia.Characters.MentTex0'
     MultiSkins(3)=Texture'GameMedia.Characters.MilitiaTex1'
     MultiSkins(4)=Texture'GameMedia.Characters.MentTex0'
     MultiSkins(5)=Texture'GameMedia.Characters.MilitiaTex2'
     MultiSkins(6)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(7)=Texture'DeusExItems.Skins.BlackMaskTex'
     CollisionRadius=20.000000
     CollisionHeight=47.500000
     BindName="RussianMent"
     FamiliarName="Ment"
     UnfamiliarName="Ment"
}
