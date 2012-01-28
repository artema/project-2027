class P_IcarusProxy extends ThrownProjectile;

var ScriptedPawn shooter;

auto simulated state Flying
{
	simulated function ProcessTouch (Actor Other, Vector HitLocation)
	{
	}
	
	simulated function Explode(vector HitLocation, vector HitNormal)
	{
		local float dist;
		local ScriptedPawn pawn;
		local float damage, radius, flashRadius;
		local DeusExPlayer player;
		local float addDamage;
		
		damage = class'WeaponMinibotIcarus'.Default.ExplosionDamage;
		radius = class'WeaponMinibotIcarus'.Default.DamageRadius;
		flashRadius = class'WeaponMinibotIcarus'.Default.FlashRadius;

		addDamage = damage * DeusExPlayer(GetPlayerPawn()).SkillSystem.GetSkillLevelValue(class'SkillTechnics');

		foreach VisibleActors(class'ScriptedPawn', pawn, radius)
		if (pawn != shooter)
		{
			if(pawn.IsA('Robot'))
			{
				if(pawn.IsA('SupportBot'))
					pawn.TakeDamage(damage * 0.25, Instigator, pawn.Location, vect(0,0,0), 'Exploded');
				else
					pawn.TakeDamage(damage + addDamage, Instigator, pawn.Location, vect(0,0,0), 'Exploded');
			}
			else
				pawn.TakeDamage(damage + addDamage, Instigator, pawn.Location, vect(0,0,0), 'Shot');
		}	
		
		player = DeusExPlayer(GetPlayerPawn());
		
		if(Abs(VSize(player.Location - Location)) < radius)
			player.TakeDamage(damage * 0.75, Instigator, pawn.Location, vect(0,0,0), 'Exploded');
		
		foreach VisibleActors(class'ScriptedPawn', pawn, flashRadius)
		if (pawn != Owner)
		{
			if(!pawn.IsA('Robot') && FRand() < 0.85)
				pawn.DamageEyes();
		}
		
		GotoState('Exploding');
	}
	
	simulated function HitWall (vector HitNormal, actor HitWall)
	{
	}
	
	simulated function BeginState()
	{
		local Rotator newRot;

		SetPhysics(PHYS_None);
	}
}

simulated function BeginPlay()
{
	local float length;
	
	length = class'P_Icarus'.Default.fuseLength;
	
	fuseLength = length + (length * 0.75 * 2);	

	Super.BeginPlay();
}

defaultproperties
{
	 blastRadius=0.1
     DamageType=Shot
     Damage=1.0

     speed=0.0
     MaxSpeed=0.0
     
	 bHighlight=False
     bExplodes=True
     bBlood=False
     bDebris=False
     bHidden=True

     ImpactSound=None
     ExplosionDecal=None
     
	 Mesh=None
     CollisionRadius=0.1
     CollisionHeight=0.1
}