//=============================================================================
// ������������ �������. �������� Ded'�� ��� ���� 2027
// American SWAT. Copyright (C) 2003 Ded
//=============================================================================
class SWAT_3 extends HumanMilitary;

#exec OBJ LOAD FILE=MPCharacters

defaultproperties
{
	 bHasTorsoDefence=True
     bHasLegDefence=True
     bHasMask=True
     bHasHelmet=True
     BaseAccuracy=0.150000
     MinHealth=0.000000
     CarcassType=Class'Game.SWAT_3Carcass'
     WalkingSpeed=0.296000
     bKeepWeaponDrawn=True
     bShowPain=False
     InitialInventory(0)=(Inventory=Class'Game.WeaponColtCommando')
     InitialInventory(1)=(Inventory=Class'DeusEx.RAmmo762mm',Count=50)
     InitialInventory(2)=(Inventory=Class'Game.WeaponKnife')
     walkAnimMult=0.780000
     GroundSpeed=230.000000
     Health=125
     Skill=4.000000
     HealthHead=125
     HealthTorso=125
     HealthLegLeft=125
     HealthLegRight=125
     HealthArmLeft=125
     HealthArmRight=125
     Texture=Texture'DeusExItems.Skins.PinkMaskTex'
     Mesh=LodMesh'DeusExItems.TestBox'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.SkinTex1'
     MultiSkins(1)=Texture'GameMedia.Skins.SWATTex2'
     MultiSkins(2)=Texture'GameMedia.Skins.SWATTex1'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.Male1Tex0'
     MultiSkins(4)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(5)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(6)=Texture'GameMedia.Skins.SWATTex3'
     MultiSkins(7)=Texture'DeusExItems.Skins.BlackMaskTex'
     CollisionRadius=20.000000
     CollisionHeight=47.500000
     BindName="AmericanSWAT"
}
