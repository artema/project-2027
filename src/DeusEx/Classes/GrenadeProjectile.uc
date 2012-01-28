class GrenadeProjectile extends ThrownProjectile
	abstract;

var() bool bEmitWeaponShot;

var bool bFallen;

function float CalculateSkillTime()
{
	return FClamp(-10.0 * DeusExPlayer(GetPlayerPawn()).SkillSystem.GetSkillLevelValue(class'SkillWeaponHeavy'), 1.5, 10.0);
}

event SupportActor( actor StandingActor )
{
	if (!bFallen)
	{
		if (StandingActor.Isa('TruePlayer'))
			SetPhysics(PHYS_Falling);
		bFallen=true;
	}
}

function Frob(Actor Frobber, Inventory frobWith)
{
	bFallen=false;
	Super.Frob(Frobber, frobWith);
}
	
defaultproperties
{
	speed=1000.000000
    MaxSpeed=1000.000000
    Damage=500.000000
    MomentumTransfer=50000
    LifeSpan=0.000000
    Mass=5.000000
    Buoyancy=2.000000
	bEmitWeaponShot=True
	bVisionImportant=True
	fuseLength=3.000000
	proxRadius=128.000000
    AISoundLevel=0.0
}