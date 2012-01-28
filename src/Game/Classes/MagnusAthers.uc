//=============================================================================
// ������ �����. �������� Ded'�� ��� ���� 2027
// Magnus Athers. Copyright (C) 2003 Ded
//=============================================================================
class MagnusAthers extends HumanMilitary;

var sound MetalHitSound;

//
// ������� ����������� ��� �������:
//
// Shot			- 65%
// Sabot		- 85%
// Exploded		- 100%
// TearGas		- 0%
// PoisonGas		- 0%
// Poison		- 0%
// HalonGas		- 0%
// Radiation		- 0%
// Shocked		- 0%
// Stunned		- 0%
// KnockedOut  		- 0%
// Flamed		- 0%
// Burned		- 0%
// NanoVirus		- 0%
// EMP			- 0%
//

function TakeDamageBase(int Damage, Pawn instigatedBy, Vector hitlocation, Vector momentum, name damageType, bool bPlayAnim)
{
	local int          actualDamage;
	local Vector       offset;
	local float        origHealth;
	local EHitLocation hitPos;
	local float        shieldMult;

	// use the hitlocation to determine where the pawn is hit
	// transform the worldspace hitlocation into objectspace
	// in objectspace, remember X is front to back
	// Y is side to side, and Z is top to bottom
	offset = (hitLocation - Location) << Rotation;

	if (!CanShowPain())
		bPlayAnim = false;

	// Prevent injury if the NPC is intangible
	if (!bBlockActors && !bBlockPlayers && !bCollideActors)
		return;

	// No damage + no damage type = no reaction
	if ((Damage <= 0) && (damageType == 'None'))
		return;

	// Block certain damage types; perform special ops on others
	if (!FilterDamageType(instigatedBy, hitLocation, offset, damageType))
		return;

	if ((damageType == 'Flamed') || (damageType == 'Burned') || (damageType == 'Stunned') || (damageType == 'KnockedOut'))
		return;
	else if ((damageType == 'TearGas') || (damageType == 'PoisonGas') || (damageType == 'HalonGas') || (damageType == 'Radiation') || (damageType == 'Shocked') || (damageType == 'Poison') || (damageType == 'PoisonEffect'))
		return;

	// Impart momentum
	ImpartMomentum(momentum, instigatedBy);

	actualDamage = ModifyDamage(Damage, instigatedBy, hitLocation, offset, damageType);

	if (actualDamage > 0)
	{
		shieldMult = ShieldDamage(damageType);
		if (shieldMult > 0)
			actualDamage = Max(int(actualDamage*shieldMult), 1);
		else
			actualDamage = 0;
		if (shieldMult < 1.0)
			DrawShield();
	}

	origHealth = Health;

	hitPos = HandleDamage(actualDamage, hitLocation, offset, damageType);
	if (!bPlayAnim || (actualDamage <= 0))
		hitPos = HITLOC_None;

	if (bCanBleed)
		if ((damageType != 'Stunned') && (damageType != 'TearGas') && (damageType != 'HalonGas') &&
		    (damageType != 'PoisonGas') && (damageType != 'Radiation') && (damageType != 'EMP') &&
		    (damageType != 'NanoVirus') && (damageType != 'Drowned') && (damageType != 'KnockedOut') &&
		    (damageType != 'Poison') && (damageType != 'PoisonEffect'))
			bleedRate += (origHealth-Health)/(0.3*Default.Health);  // 1/3 of default health = bleed profusely

	if (CarriedDecoration != None)
		DropDecoration();

	//if ((actualDamage > 0) && (damageType == 'Poison'))
	//	StartPoison(Damage, instigatedBy);

	if ((damageType == 'Shot') || (damageType == 'AutoShot'))
		actualDamage *= 0.65;

	if ((damageType == 'Sabot'))
		actualDamage *= 0.85;

	if (Health <= 0)
	{
		ClearNextState();
		//PlayDeathHit(actualDamage, hitLocation, damageType);
		if ( actualDamage > mass )
			Health = -1 * actualDamage;
		SetEnemy(instigatedBy, 0, true);

		// gib us if we get blown up
		if (DamageType == 'Exploded')
			Health = -10000;
		else
			Health = -1;

		Died(instigatedBy, damageType, HitLocation);

		if ((DamageType == 'Flamed') || (DamageType == 'Burned'))
		{
			bBurnedToDeath = true;
			ScaleGlow *= 0.1;  // blacken the corpse
		}
		else
			bBurnedToDeath = false;

		return;
	}

	// play a hit sound
	if (DamageType != 'Stunned')
		PlayTakeHitSound(actualDamage, damageType, 1);

	if ((DamageType == 'Flamed') && !bOnFire)
		CatchFire();

	ReactToInjury(instigatedBy, damageType, hitPos);
}

function SelfExplode()
{
	local SFXSphereEffect sphere;
	local ScorchMark s;
	local SFXExplosionLight light;
	local int i, num;
	local float explosionDamage;
	local float explosionRadius;
	local DeusExFragment f;
	local FleshFragment gib;

	explosionDamage = 100;
	explosionRadius = 1024;

	AISendEvent('LoudNoise', EAITYPE_Audio, , explosionRadius*16);
	PlaySound(Sound'LargeExplosion1', SLOT_None,,, explosionRadius*16);

	light = Spawn(class'SFXExplosionLight',,, Location);
	if (light != None)
		light.size = 12;

	Spawn(class'SFXExplosionLarge',,, Location + 2*VRand()*CollisionRadius);

	sphere = Spawn(class'SFXSphereEffect',,, Location);
	if (sphere != None)
		sphere.size = explosionRadius / 32.0;

	s = spawn(class'ScorchMark', Base,, Location-vect(0,0,1)*CollisionHeight, Rotation+rot(16384,0,0));
	if (s != None)
	{
		s.DrawScale = FClamp(explosionDamage/20, 0.1, 3.0);
		s.ReattachDecal();
	}

	for (i=0; i<explosionDamage/3; i++)
	{
		if (FRand() < 0.3)
			spawn(class'Rockchip',,,Location);
	}

	num = FMax(3, explosionRadius/25);
	for (i=0; i<num; i++)
	{
		f = Spawn(class'MetalFragment', Owner);
		if (f != None)
		{
			f.Instigator = Instigator;
			f.CalcVelocity(Velocity, explosionRadius*0.4);
			f.DrawScale = explosionRadius*0.25*0.009*FRand();
			if (FRand() < 0.75)
				f.bSmoking = True;
		}
	}

	HurtRadius(explosionDamage, explosionRadius, 'Exploded', explosionDamage*150, Location);
}

function GotoDisabledState(name damageType, EHitLocation hitPos)
{
	if (!bCollideActors && !bBlockActors && !bBlockPlayers)
		return;
	if (CanShowPain())
		TakeHit(hitPos);
	else
		GotoNextState();
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

	volume = FMax(Mult*TransientSoundVolume, Mult*2.0);

	SetDistressTimer();

	PlaySound(hitSound, SLOT_Pain, volume,,, RandomPitch() * TruePlayer(GetPlayerPawn()).GetSoundPitchMultiplier());

    if ((damageType == 'Shot') || (damageType == 'Sabot') || (damageType == 'Autoshot'))
    {
		metalSound = MetalHitSound;
        PlaySound(metalSound, SLOT_Pain, volume,,, RandomPitch() * TruePlayer(GetPlayerPawn()).GetSoundPitchMultiplier());
    }

	if ((hitSound != None) && bEmitDistress)
		AISendEvent('Distress', EAITYPE_Audio, volume);
}

function ShowCloakEffect()
{
	SetSkinStyle(STY_Translucent, Texture'WhiteStatic', 0.02);
	MultiSkins[5] = Texture'DeusExItems.Skins.BlackMaskTex';
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
	 bHasMask=True
	 bHasHelmet=True
	 bHasTorsoDefence=True
	 EmpFieldRadius=800
	 bHasCloak=True
	 CloakThreshold=70
	 bExplodingCorpse=True
     Skill=4.0
     MetalHitSound=Sound'DeusExSounds.Generic.ArmorRicochet'
     CarcassType=Class'Game.MagnusAthersCarcass'
     WalkingSpeed=0.350000
     InitialInventory(0)=(Inventory=Class'Game.WeaponColtCommando')
     InitialInventory(1)=(Inventory=Class'DeusEx.RAmmo762mm',Count=50)
     InitialInventory(2)=(Inventory=Class'Game.WeaponKnife')
     BurnPeriod=0.000000
     walkAnimMult=1.1250000
     runAnimMult=1.2
     GroundSpeed=315.000000
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
     Mass=400.000000
     MultiSkins(0)=Texture'GameMedia.Characters.MagnusAthersTex1'
     MultiSkins(1)=Texture'GameMedia.Characters.MagnusAthersTex2'
     MultiSkins(2)=Texture'GameMedia.Characters.MagnusAthersTex0'
     MultiSkins(3)=Texture'GameMedia.Characters.MagnusAthersTex0'
     MultiSkins(4)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.FramesTex4'
     MultiSkins(6)=Texture'DeusExCharacters.Skins.LensesTex5'
     MultiSkins(7)=Texture'DeusExItems.Skins.BlackMaskTex'
     WalkSound=Sound'GameMedia.Misc.MechWalk'
     CollisionRadius=24.200001
     CollisionHeight=52.450001
     BindName="MagnusAthers"
}
