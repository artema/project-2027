//=============================================================================
// ������ �����. �������� Ded'�� ��� ���� 2027
// Magnus Athers. Copyright (C) 2003 Ded
//=============================================================================
class MagnusAthersJr extends HumanMilitary;

defaultproperties
{
     Skill=4.0
     WalkingSpeed=0.350000
     walkAnimMult=0.750000
     GroundSpeed=210.000000
     CarcassType=Class'Game.MagnusAthersJrCarcass'
     InitialInventory(0)=(Inventory=Class'Game.WeaponAutoShotgun')
     InitialInventory(1)=(Inventory=Class'DeusEx.RAmmoShell',Count=50)
     InitialInventory(2)=(Inventory=Class'Game.WeaponKnife')
     BaseEyeHeight=44.000000
     Health=500
     HealthHead=600
     HealthTorso=400
     HealthLegLeft=400
     HealthLegRight=400
     HealthArmLeft=400
     HealthArmRight=400
     Texture=Texture'DeusExItems.Skins.BlackMaskTex'
     Mesh=LodMesh'DeusExCharacters.GM_DressShirt_B'
     DrawScale=1.100000
     Mass=150.000000
     MultiSkins(0)=Texture'GameMedia.Characters.MagnusAthersJrTex1'
     MultiSkins(1)=Texture'GameMedia.Characters.MagnusAthersJrTex2'
     MultiSkins(2)=Texture'GameMedia.Characters.MagnusAthersJrTex0'
     MultiSkins(3)=Texture'GameMedia.Characters.MagnusAthersJrTex0'
     MultiSkins(4)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.FramesTex4'
     MultiSkins(6)=Texture'DeusExCharacters.Skins.LensesTex5'
     MultiSkins(7)=Texture'DeusExItems.Skins.PinkMaskTex'
     CollisionRadius=24.200001
     CollisionHeight=52.450001
     BindName="MagnusAthers"
}
