//=============================================================================
// ������ MJ12. �������� Ded'�� ��� ���� 2027
// MJ12 Troop. Copyright (C) 2003 Ded
//=============================================================================
class MJ12Trooper extends HumanMilitary
	abstract;

//#exec OBJ LOAD FILE=MPCharacters
//Mesh=LodMesh'MPCharacters.mp_jumpsuit'

defaultproperties
{
	 Health=140
     HealthHead=130
     HealthTorso=140
     HealthLegLeft=140
     HealthLegRight=140
     HealthArmLeft=140
     HealthArmRight=140
	 bHasTorsoDefence=True
     bHasLegDefence=True
     bHasHelmet=True
	 bKeepWeaponDrawn=True
     WalkingSpeed=0.296000
     InitialInventory(0)=(Inventory=Class'Game.WeaponMP5')
     InitialInventory(1)=(Inventory=Class'DeusEx.RAmmo556mm',Count=50)
     InitialInventory(2)=(Inventory=Class'Game.WeaponKnife')
     walkAnimMult=0.780000
     GroundSpeed=200.000000
     Texture=Texture'DeusExItems.Skins.PinkMaskTex'
     Mesh=LodMesh'DeusExCharacters.GM_Jumpsuit'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.SkinTex1'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.MJ12TroopTex1'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.MJ12TroopTex2'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.SkinTex1'
     MultiSkins(4)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.MJ12TroopTex3'
     MultiSkins(6)=Texture'DeusExCharacters.Skins.MJ12TroopTex4'
     MultiSkins(7)=Texture'DeusExItems.Skins.PinkMaskTex'
     CollisionRadius=20.000000
     CollisionHeight=47.500000
     BindName="MJ12Troop"
}