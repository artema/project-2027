//=============================================================================
// �������. �������� Ded'�� ��� ���� 2027
// Evgeny. Copyright (C) 2004 Ded
//=============================================================================
class Evgeny extends HumanThug;

#exec OBJ LOAD FILE=MPCharacters

defaultproperties
{
     bHasTorsoDefence=True
     BaseAccuracy=0.000000
     CarcassType=Class'Game.EvgenyCarcass'
     WalkingSpeed=0.296000
     bKeepWeaponDrawn=False
     InitialInventory(0)=(Inventory=Class'Game.WeaponAK74')
     InitialInventory(1)=(Inventory=Class'DeusEx.RAmmo556mm',Count=50)
     InitialInventory(2)=(Inventory=Class'Game.WeaponKnife')
     walkAnimMult=0.780000
     GroundSpeed=210.000000
     Health=250
     Skill=4.000000
     NameArticle=""
     HealthHead=220
     HealthTorso=220
     HealthLegLeft=220
     HealthLegRight=220
     HealthArmLeft=220
     HealthArmRight=220
     Texture=Texture'DeusExItems.Skins.PinkMaskTex'
     Mesh=LodMesh'MPCharacters.mp_jumpsuit'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.JockTex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.JoJoFineTex2'
     MultiSkins(2)=Texture'GameMedia.Characters.EvgenyTex2'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.JockTex0'
     MultiSkins(4)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(5)=Texture'GameMedia.Characters.TechnoGogglesTex0'
     MultiSkins(6)=Texture'GameMedia.Characters.TechnoGogglesTex0'
     MultiSkins(7)=Texture'DeusExItems.Skins.PinkMaskTex'
     CollisionRadius=20.000000
     CollisionHeight=47.500000
     BindName="Evgeny"
}
