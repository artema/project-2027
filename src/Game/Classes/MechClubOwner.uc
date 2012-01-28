//=============================================================================
// ������� �������. �������� Ded'�� ��� ���� 2027
// Russian Militia. Copyright (C) 2003 Ded
//=============================================================================
class MechClubOwner extends HumanThug;

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
     MinHealth=0.000000
     CarcassType=Class'Game.MechClubOwnerCarcass'
     WalkingSpeed=0.296000
     AvoidAccuracy=0.100000
     CrouchRate=0.250000
     SprintRate=0.250000
     walkAnimMult=0.780000
     GroundSpeed=200.000000
     Health=140
     HealthHead=140
     HealthTorso=140
     HealthLegLeft=140
     HealthLegRight=140
     HealthArmLeft=140
     HealthArmRight=140
     Texture=Texture'DeusExItems.Skins.PinkMaskTex'
     Mesh=LodMesh'MPCharacters.mp_jumpsuit'
     MultiSkins(0)=Texture'GameMedia.Characters.MechClubOwnerTex0'
     MultiSkins(1)=Texture'GameMedia.Characters.MJ12CyborgTex2'
     MultiSkins(2)=Texture'GameMedia.Characters.MechClubOwnerTex1'
     MultiSkins(3)=Texture'GameMedia.Characters.MechClubOwnerTex0'
     MultiSkins(4)=Texture'GameMedia.Characters.MechClubOwnerTex0'
     MultiSkins(5)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(6)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(7)=Texture'DeusExItems.Skins.PinkMaskTex'
     CollisionRadius=20.000000
     CollisionHeight=47.500000
     BindName="Dmitri"
     BarkBindName="Dmitri"
}