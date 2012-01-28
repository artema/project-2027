//=============================================================================
// ������ MJ12 (����������������). �������� Ded'�� ��� ���� 2027
// MJ12 Troop (Augmented). Copyright (C) 2003 Ded
//=============================================================================
class MJ12Troop_Aug extends HumanMilitary;

#exec OBJ LOAD FILE=MPCharacters

function ShowCloakEffect()
{
	SetSkinStyle(STY_Translucent, Texture'WhiteStatic', 0.02);
	Spawn(class'SFXCamoOnLight',,, Location);
	Spawn(class'SFXCamoOnFlash',,, Location);
	PlaySound(Sound'CloakUp', SLOT_None, 0.85,, 768, 1.0);
}

function HideCloakEffect()
{
	ResetSkinStyle();
	Spawn(class'SFXCamoOnLight',,, Location);
	Spawn(class'SFXCamoOnFlash',,, Location);
	PlaySound(Sound'CloakDown', SLOT_None, 0.85,, 768, 1.0);
}

defaultproperties
{
     CarcassType=Class'Game.MJ12Troop_AugCarcass'
     InitialInventory(0)=(Inventory=Class'Game.WeaponMP5')
     InitialInventory(1)=(Inventory=Class'DeusEx.RAmmo556mm',Count=50)
     InitialInventory(2)=(Inventory=Class'Game.WeaponSilencedPistol')
     InitialInventory(3)=(Inventory=Class'DeusEx.RAmmo10mm',Count=50)
     bHasCloak=True
     WalkingSpeed=0.296000
     walkAnimMult=0.780000
     CloakThreshold=150
     GroundSpeed=200.000000
     Skill=3.000000
     Texture=Texture'DeusExItems.Skins.PinkMaskTex'
     Mesh=LodMesh'MPCharacters.mp_jumpsuit'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.SkinTex1'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.MJ12TroopTex1'
     MultiSkins(2)=Texture'Game.Skins.MJ12AugTex2'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.SkinTex1'
     MultiSkins(4)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(5)=Texture'DeusExItems.Skins.BlackMaskTex'
     MultiSkins(6)=Texture'GameMedia.Skins.MJ12OfficerTex4'
     MultiSkins(7)=Texture'DeusExItems.Skins.PinkMaskTex'
     CollisionRadius=20.000000
     CollisionHeight=47.500000
     BindName="MJ12Troop"
}
