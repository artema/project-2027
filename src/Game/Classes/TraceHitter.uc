//======================================================
// ������ �� ��������. �������� Ded'�� ��� ���� 2027
// Smoke Effect. Copyright (C) 2003 Ded
//======================================================
class TraceHitter extends TraceHitSpawner;

simulated function PlayRicochet()
{
   local float rnd;
   local sound snd;

	rnd = FRand();

	if (rnd < 0.25)
		snd = sound'Ricochet1';
	else if (rnd < 0.5)
		snd = sound'Ricochet2';
	else if (rnd < 0.75)
		snd = sound'Ricochet3';
	else
		snd = sound'Ricochet4';

    PlaySound(snd, SLOT_Misc, 1.0, false, 500.0, 1.2 - 0.3*FRand());
}


simulated function PlayHitSound(actor destActor, Actor hitActor)
{
}


simulated function SpawnEffects(Actor Other, float Damage)
{
   local int           i;
   local int num;
   local BulletHole hole;
   local RockChip   chip;
   local Rotator     rot;
   local DeusExMover mov;
   local Spark     spark;
   local HitMuzzle mz;
   local sound snd;
   local DeusExPlayer player;
   local ParticleGenerator boobleGen;

   SetTimer(0.05,False);

     player = DeusExPlayer(GetPlayerPawn());

	if (bPenetrating && !bHandToHand && !Other.IsA('DeusExDecoration') && !Other.IsA('Pawn'))
	{
		if(!Region.Zone.bWaterZone){
               	if (FRand() < 0.45)
					spawn(class'HitPuff1',,,Location+(Vector(Rotation)*1.5), Rotation);
                else if (FRand() < 0.9)
					spawn(class'HitPuff2',,,Location+(Vector(Rotation)*1.5), Rotation);
		}
		else{
			num = FRand()*3;
			for (i=0; i<num; i++)
				Spawn(class'AirBubble',,,Location+(Vector(Rotation)*1.5), Rotation);
		}

     if (!Other.IsA('DeusExMover'))
         for (i=0; i<2; i++)
         {
            if (player.bNoResurrection)
            {
              if (FRand() < 0.2)
              {
                 chip = spawn(class'Rockchip',,,Location+Vector(Rotation));
                 if (chip != None)
                    chip.RemoteRole = ROLE_None;
              }
            }
            else
            {
              if (FRand() < 0.6)
              {
                 chip = spawn(class'Rockchip',,,Location+Vector(Rotation));
                 if (chip != None)
                    chip.RemoteRole = ROLE_None;
              }
            }
         }

               PlayRicochet();
	}

   if ((!bHandToHand) && bInstantHit && bPenetrating)
	{
      hole = spawn(class'BulletHole', Other,, Location+Vector(Rotation), Rotation);
      if (hole != None)      
         hole.RemoteRole = ROLE_None;

		if (!Other.IsA('DeusExPlayer') && !Region.Zone.bWaterZone && (FRand() < 0.8))
		{
			mz = spawn(class'HitMuzzle',,,Location+Vector(Rotation), Rotation);
			if (spark != None)
			{
				mz.RemoteRole = ROLE_None;
				PlayHitSound(mz, other);
			}
		}
	}

	if (bPenetrating || bHandToHand)
	{
		if (Other.IsA('DeusExMover'))
		{
			mov = DeusExMover(Other);
			if ((mov != None) && (hole == None))
         {
            hole = spawn(class'BulletHole', Other,, Location+Vector(Rotation), Rotation);
            if (hole != None)
               hole.remoteRole = ROLE_None;
         }

			if (hole != None)
			{
				if (mov.bBreakable && (mov.minDamageThreshold <= Damage))
				{
					if (mov.bDestroyed)
						hole.Destroy();
					else if (mov.FragmentClass == class'GlassFragment')
					{
						if (FRand() < 0.5)
							hole.Texture = Texture'FlatFXTex29';
						else
							hole.Texture = Texture'FlatFXTex30';

						hole.DrawScale = 0.1;
						hole.ReattachDecal();
					}
					else
					{
						if (FRand() < 0.5)
							hole.Texture = Texture'FlatFXTex7';
						else
							hole.Texture = Texture'FlatFXTex8';

						hole.DrawScale = 0.4;
						hole.ReattachDecal();
					}
				}
				else
				{
					if (!bPenetrating || bHandToHand)
						hole.Destroy();
				}
			}
		}
	}
}

defaultproperties
{
}
