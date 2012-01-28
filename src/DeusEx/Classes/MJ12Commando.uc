//=============================================================================
// MJ12Commando.
//=============================================================================
class MJ12Commando extends HumanMilitary;

function Bool HasTwoHandedWeapon()
{
	return False;
}

function PlayReloadBegin()
{
	TweenAnimPivot('Shoot', 0.1);
}

function PlayReload()
{
}

function PlayReloadEnd()
{
}

function PlayIdle()
{
}

function TweenToShoot(float tweentime)
{
	if (Region.Zone.bWaterZone)
		TweenAnimPivot('TreadShoot', tweentime, GetSwimPivot());
	else if (!bCrouching)
		TweenAnimPivot('Shoot2', tweentime);
}

function PlayShoot()
{
	if (Region.Zone.bWaterZone)
		PlayAnimPivot('TreadShoot', , 0, GetSwimPivot());
	else
		PlayAnimPivot('Shoot2', , 0);
}

function bool IgnoreDamageType(Name damageType)
{
	if ((damageType == 'TearGas') || (damageType == 'PoisonGas'))
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


function GotoDisabledState(name damageType, EHitLocation hitPos)
{
	if (!bCollideActors && !bBlockActors && !bBlockPlayers)
		return;
	else if (!IgnoreDamageType(damageType) && CanShowPain())
		TakeHit(hitPos);
	else
		GotoNextState();
}

defaultproperties
{
     WalkSound=Sound'DeusExSounds.Robot.SecurityBot2Walk'
     MinHealth=0.000000
     CarcassType=Class'DeusEx.MJ12CommandoCarcass'
     WalkingSpeed=0.296000
     bCanCrouch=False
     CloseCombatMult=0.500000
     BurnPeriod=0.000000
     GroundSpeed=200.000000
     HealthHead=250
     HealthTorso=250
     HealthLegLeft=250
     HealthLegRight=250
     HealthArmLeft=250
     HealthArmRight=250
     Mesh=LodMesh'DeusExItems.TestBox'
     MultiSkins(0)=Texture'DeusExCharacters.Skins.MJ12CommandoTex1'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.MJ12CommandoTex1'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.MJ12CommandoTex0'
     MultiSkins(3)=Texture'DeusExCharacters.Skins.MJ12CommandoTex1'
     CollisionRadius=28.000000
     CollisionHeight=49.880001
     BindName="MJ12Commando"
     FamiliarName="MJ12 Commando"
     UnfamiliarName="MJ12 Commando"
}
