//=============================================================================
// ������� ������. �������� Ded'�� ��� ���� 2027
// Russian soldier. Copyright (C) 2003 Ded
//=============================================================================
class RussianArmy_2 extends HumanMilitary;

#exec OBJ LOAD FILE=MPCharacters

/*function GotoDisabledState(name damageType, EHitLocation hitPos)
{
	if (!bCollideActors && !bBlockActors && !bBlockPlayers)
		return;
	//else if ((damageType == 'TearGas') || (damageType == 'HalonGas'))
	else if ((damageType == 'HalonGas'))
		GotoNextState();
	else if (damageType == 'Stunned')
		GotoState('Stunned');
	else if (CanShowPain())
		TakeHit(hitPos);
	else
		GotoNextState();
}*/

defaultproperties
{
     bHasTorsoDefence=True
     bHasLegDefence=True
     bHasMask=False
     bHasHelmet=True
     BaseAccuracy=0.000000
     MinHealth=10.000000
     CarcassType=Class'Game.RussianArmy_2Carcass'
     WalkingSpeed=0.296000
     bKeepWeaponDrawn=True
     bShowPain=False
     InitialInventory(0)=(Inventory=Class'Game.WeaponAK74')
     InitialInventory(1)=(Inventory=Class'DeusEx.RAmmo762mm',Count=50)
     InitialInventory(2)=(Inventory=Class'Game.WeaponKnife')
     walkAnimMult=0.780000
     GroundSpeed=230.000000
     Skill=4.000000
	 Health=140
     HealthHead=130
     HealthTorso=140
     HealthLegLeft=140
     HealthLegRight=140
     HealthArmLeft=140
     HealthArmRight=140

     Texture=Texture'DeusExItems.Skins.PinkMaskTex'
     Mesh=LodMesh'MPCharacters.mp_jumpsuit'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.SkinTex1'
     MultiSkins(1)=Texture'GameMedia.Skins.SWATTex2'
     MultiSkins(2)=Texture'GameMedia.Skins.SWATTex1'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.Male1Tex0'
     MultiSkins(4)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(5)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(6)=Texture'GameMedia.Skins.SWATTex3'
     MultiSkins(7)=Texture'DeusExItems.Skins.BlackMaskTex'
     CollisionRadius=20.000000
     CollisionHeight=47.500000
     BindName="RussianArmy"
     BarkBindName="RussianArmy"
}