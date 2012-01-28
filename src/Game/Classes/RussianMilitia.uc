//=============================================================================
// ������� �������. �������� Ded'�� ��� ���� 2027
// Russian Militia. Copyright (C) 2003 Ded
//=============================================================================
class RussianMilitia extends HumanMilitary;

#exec OBJ LOAD FILE=MPCharacters

function GotoDisabledState(name damageType, EHitLocation hitPos)
{
	if (!bCollideActors && !bBlockActors && !bBlockPlayers)
		return;
	else if ((damageType == 'TearGas') || (damageType == 'HalonGas'))
		GotoNextState();
	else if (damageType == 'Stunned')
		GotoState('Stunned');
	else if (CanShowPain())
		TakeHit(hitPos);
	else
		GotoNextState();
}

defaultproperties
{
     bHasTorsoDefence=True
     bHasLegDefence=True
     bHasHelmet=True
     bHasMask=True
     BaseAccuracy=0.000000
     CarcassType=Class'Game.RussianMilitiaCarcass'
     WalkingSpeed=0.296000
     walkAnimMult=0.780000
     GroundSpeed=200.000000
     InitialInventory(0)=(Inventory=Class'Game.WeaponAK74')
     InitialInventory(1)=(Inventory=Class'DeusEx.RAmmo762mm',Count=50)
     InitialInventory(2)=(Inventory=Class'Game.WeaponKnife')
     Texture=Texture'GameMedia.Characters.MilitiaTex0'
     Mesh=LodMesh'MPCharacters.mp_jumpsuit'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.MiscTex1'
     MultiSkins(1)=Texture'GameMedia.Characters.MilitiaTex1'
     MultiSkins(2)=Texture'GameMedia.Characters.MilitiaTex2'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.MiscTex1'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.MiscTex1'
     MultiSkins(5)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(6)=Texture'GameMedia.Characters.MilitiaTex3'
     CollisionRadius=20.000000
     CollisionHeight=47.500000
     BindName="RussianMilitia"
}
