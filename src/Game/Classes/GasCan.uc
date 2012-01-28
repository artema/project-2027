//=============================================================================
// �������� �������. ������� Ded'�� ��� ���� 2027
// Gas can. Copyright (C) 2003 Ded
// ����� ������/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class GasCan extends Containers;

auto state Active
{

	function TakeDamage(int Damage, Pawn instigatedBy, Vector hitlocation, Vector momentum, name damageType)
	{
		local ParticleGenerator gen;
		local ProjectileGenerator projgen;
		local float size;
		local Vector loc;
		local Actor A;
		local SmokeTrail puff;
		local int i;
                local DeusExPlayer player;

                player = DeusExPlayer(GetPlayerPawn());

		if (bStatic || bInvincible)
			return;

		if ((damageType == 'TearGas') || (damageType == 'PoisonGas') || (damageType == 'HalonGas'))
			return;

		if ((damageType == 'EMP') || (damageType == 'NanoVirus') || (damageType == 'Radiation'))
			return;

		if (Damage >= minDamageThreshold)
		{
			if (HitPoints-Damage <= 0)
			{
				foreach BasedActors(class'Actor', A)
				{
					if (A.IsA('ParticleGenerator'))
						ParticleGenerator(A).DelayedDestroy();
					else if (A.IsA('ProjectileGenerator'))
						A.Destroy();
				}


				for (i=0; i<explosionRadius/50; i++)
				{
					loc = Location;
					loc.X += FRand() * explosionRadius - explosionRadius * 0.3;
					loc.Y += FRand() * explosionRadius - explosionRadius * 0.3;

				   if (player.bNoResurrection)
				   {
						puff = spawn(class'SmokeTrail',,, loc);
						if (puff != None)
						{
						        puff.Texture = FireTexture'Effects.Smoke.SmokePuff1';
							puff.RiseRate = FRand() + 5;
							puff.DrawScale = FRand() + 1;
							puff.OrigScale = puff.DrawScale;
							puff.LifeSpan = FRand() * 2 + 5;
							puff.OrigLifeSpan = puff.LifeSpan;
						}
				   }
                                   else
				   {		
						puff = spawn(class'SmokeTrail',,, loc);
						if (puff != None)
						{
							puff.RiseRate = FRand() + 5;
							puff.DrawScale = FRand() + 0.05;
							puff.OrigScale = puff.DrawScale;
							puff.LifeSpan = FRand() * 2 + 5;
							puff.OrigLifeSpan = puff.LifeSpan;
						}
				   }
				}

			}

			
		}

		Super.TakeDamage(Damage, instigatedBy, hitlocation, momentum, damageType);
	}
}

defaultproperties
{
     bExplosive=True
     explosionDamage=200
     explosionRadius=500
     HitPoints=4
     bBlockSight=True
     Mesh=LodMesh'GameMedia.GasCan'
     CollisionRadius=12.000000
     CollisionHeight=16.500000
     Mass=50.000000
     Buoyancy=90.000000
}
