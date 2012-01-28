//=============================================================================
// ������ MJ12. ������� Ded'�� ��� ���� 2027
// MJ12 Cyborg. Copyright (C) 2003 Ded
//=============================================================================
class MJ12Cyborg extends HumanMilitary;

var sound MetalHitSound;

function GotoDisabledState(name damageType, EHitLocation hitPos)
{
	if (!bCollideActors && !bBlockActors && !bBlockPlayers)
		return;
	else if (!IgnoreDamageType(damageType) && CanShowPain())
		TakeHit(hitPos);
	else
		GotoNextState();
}

function bool IgnoreDamageType(Name damageType)
{
	if ((damageType == 'TearGas') || (damageType == 'HalonGas') || (damageType == 'PoisonGas') || (damageType == 'Radiation'))
		return True;
	else if ((damageType == 'Poison') || (damageType == 'PoisonEffect'))
		return True;
	else if (damageType == 'KnockedOut')
		return True;
	else
		return False;
}

function float ShieldDamage(Name damageType)
{
	if (IgnoreDamageType(damageType))
		return 0.0;
	else if ((damageType == 'Burned') || (damageType == 'Flamed'))
		return 0.5;
	else if ((damageType == 'Poison') || (damageType == 'PoisonEffect'))
		return 0.5;
	else
		return Super.ShieldDamage(damageType);
}

// ----------------------------------------------------------------------
// PlayTakeHitSound()
// ----------------------------------------------------------------------
function PlayTakeHitSound(int Damage, name damageType, int Mult)
{
	local Sound hitSound;
	local Sound metalSound;
	local float volume;

	if (Level.TimeSeconds - LastPainSound < 0.1)
		return;
	if (Damage <= 0)
		return;

	LastPainSound = Level.TimeSeconds;

	if (Damage <= 30)
		hitSound = HitSound1;
	else
		hitSound = HitSound2;

		metalSound = MetalHitSound;

	volume = FMax(Mult*TransientSoundVolume, Mult*2.0);

	SetDistressTimer();

	PlaySound(hitSound, SLOT_Pain, volume,,, RandomPitch() * TruePlayer(GetPlayerPawn()).GetSoundPitchMultiplier());
	PlaySound(metalSound, SLOT_Pain, volume,,, RandomPitch() * TruePlayer(GetPlayerPawn()).GetSoundPitchMultiplier());

	if ((hitSound != None) && bEmitDistress)
		AISendEvent('Distress', EAITYPE_Audio, volume);
}

defaultproperties
{
	 bHasMask=True
	 bHasHelmet=True
	 bHasTorsoDefence=True
     MetalHitSound=Sound'DeusExSounds.Generic.ArmorRicochet'
     BaseAccuracy=-0.100000
     Skill=4.000000
     CarcassType=Class'Game.MJ12CyborgCarcass'
     WalkingSpeed=0.350000
     walkAnimMult=0.750000
     GroundSpeed=220.000000
     bKeepWeaponDrawn=True
     DrawScale=1.100000
     InitialInventory(0)=(Inventory=Class'Game.WeaponColtCommando')
     InitialInventory(1)=(Inventory=Class'DeusEx.RAmmo762mm',Count=50)
     InitialInventory(2)=(Inventory=Class'Game.WeaponKnife')
     Health=250
     HealthHead=250
     HealthTorso=250
     HealthLegLeft=250
     HealthLegRight=250
     HealthArmLeft=250
     HealthArmRight=250
     Texture=Texture'DeusExCharacters.Skins.VisorTex1'
     Mesh=LodMesh'DeusExCharacters.GM_DressShirt_B'
     MultiSkins(0)=Texture'GameMedia.Characters.MJ12CyborgTex1'
     MultiSkins(1)=Texture'GameMedia.Characters.MJ12CyborgTex2'
     MultiSkins(2)=Texture'GameMedia.Characters.MJ12CyborgTex0'
     MultiSkins(3)=Texture'GameMedia.Characters.MJ12CyborgTex0'
     MultiSkins(4)=Texture'GameMedia.Characters.MJ12CyborgTex3'
     MultiSkins(5)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(6)=Texture'DeusExItems.Skins.BlackMaskTex'
     MultiSkins(7)=Texture'DeusExItems.Skins.BlackMaskTex'
     WalkSound=Sound'DeusExSounds.Robot.SecurityBot2Walk'
     CollisionRadius=24.200001
     CollisionHeight=52.599998
     BindName="MJ12Cyborg"
}
