//=============================================================================
// ���������� - EMP ����. �������� Ded'�� ��� ���� 2027
// Aug - EMP Field.  Copyright (C) 2003 Ded
//=============================================================================
class AugEMPShield extends Augmentation;

var bool bDefenseActive;

var float defenseSoundTime;
const defenseSoundDelay = 2;

var bool bFieldActive;

var float empTimer;

var() int EmpDamage[2];
var() float DefenceEnergyRate;
var() float AttackEnergyRate;

state Active
{
	function Timer()
	{
		local Actor target;
		local float mindist;
		local DeusExProjectile projectiles[30];
		local DeusExProjectile proj;
		local bool bFound;
		local int i;

		if(empTimer >= 1 + FRand()*0.5)
		{
			empTimer = 0.0;
			
	        target = FindValidActor();
			
			if (target != None)
			{
	            bFieldActive = True;
	            mindist = VSize(Player.Location - target.Location);
	       		
				if (mindist < LevelValues[CurrentLevel])
				{
					Player.PlaySound(Sound'DeusExSounds.Weapons.EMPGrenadeExplode', SLOT_None,,,, 1.0*Player.GetSoundPitchMultiplier());
					
					if(target.IsA('SpyDrone'))
						SpyDrone(target).bEMPed = True;
					else
	                	target.TakeDamage(EmpDamage[CurrentLevel], Player, target.Location, vect(0,0,0),'EMP');
	                
	                if(target.IsA('DeusExDecoration'))
	                	DeusExDecoration(target).SpawnEmpHitEffect();
	                else if(target.IsA('ScriptedPawn'))
	                	ScriptedPawn(target).SpawnEmpHitEffect();
	                    
	                SetEnergyRate(AttackEnergyRate);
				}
			}
			else
			{
	            bFieldActive = false;
	        }
		}
		else
		{
			bFieldActive = false;
			empTimer += 0.1;	
		}
        
        if(CurrentLevel >= 1)
		{
	        bFound = FindProjectiles(projectiles);
	        
	        if (bFound)
			{
				bDefenseActive = True;
	            SetDefenseAugStatus(True, projectiles);
	
				Player.PlaySound(Sound'GEPGunLock', SLOT_None,,,, 2.0*Player.GetSoundPitchMultiplier());
				
				for(i=0; i<30; i++)
				{
					proj = projectiles[i];
					
					if(proj != None && (VSize(Player.Location - proj.Location) < LevelValues[CurrentLevel]))
					{
						proj.bEMPed = True;
						proj.SpawnEmpHitEffect();
						Player.PlaySound(Sound'ProdFire', SLOT_None,,,, 2.0*Player.GetSoundPitchMultiplier());
						SetEnergyRate(DefenceEnergyRate);
					}
					else
						break;
				}
			}
			else
			{
	            SetDefenseAugStatus(False, projectiles);
				bDefenseActive = false;
			}
		}
	}

Begin:
SetTimer(0.1, True);
}

function Deactivate()
{
	local DeusExProjectile projectiles[30];
	
	Super.Deactivate();
	
	SetTimer(0.1, False);
	SetDefenseAugStatus(False, projectiles);
}

simulated function Actor FindValidActor()
{
   local Actor mytarget, target;
   local float dist, mindist;
   
   target = None;
   mindist = LevelValues[CurrentLevel];
   
   ForEach Player.RadiusActors(class'Actor', mytarget, mindist, Player.Location)
   {
      if (IsAValidTarget(myTarget))
      {
         if (mytarget != Player)
         {              
			dist = VSize(Player.Location - mytarget.Location);
			
		  	if (dist < mindist)
			{
				mindist = dist;
				target = mytarget;
			}					
         }
      }
   }

   return target;
}

simulated function bool IsAValidTarget(Actor myTarget)
{
        if (mytarget.IsA('Robot')) 
        {     
        	if(Robot(mytarget).EMPHitPoints > 0)
        		return true;
        	else
        		return false;
        }
        
        if (mytarget.IsA('SpyDrone')) 
        {     
        	if(SpyDrone(mytarget).BotEMPHealth > 0)
        		return true;
        	else
        		return false;
        }
        
        if(mytarget.IsA('ScriptedPawn'))
		{
			if((ScriptedPawn(mytarget).bHasCloak && ScriptedPawn(mytarget).bCloakOn) || (ScriptedPawn(mytarget).EmpFieldRadius > 1 && ScriptedPawn(mytarget).CloakEMPTimer <= 0))
				return true;
        	else
        		return false;
		}

        if (mytarget.IsA('GrenadeProjectile'))
        {
        	if (!GrenadeProjectile(mytarget).bDisabled) 
            	return true;
        	else  
            	return false;
        }

        if (mytarget.IsA('AutoTurret'))
        {
        	if(AutoTurret(mytarget).bConfused && (AutoTurret(mytarget).confusionTimer + 1 > AutoTurret(mytarget).confusionDuration))
        		return true;
        	else if(AutoTurret(mytarget).bConfused || AutoTurret(mytarget).bDisabled)
        		return false;
        	else
        		return true;
        }

        if (mytarget.IsA('SecurityCamera'))
        {
        	if(SecurityCamera(mytarget).bConfused && (SecurityCamera(mytarget).confusionTimer + 1 > SecurityCamera(mytarget).confusionDuration))
        		return true;
        	else if(SecurityCamera(mytarget).bConfused || !SecurityCamera(mytarget).bActive)
        		return false;
        	else
        		return true;
        }

        if (mytarget.IsA('AlarmUnit'))
        {
        	if(AlarmUnit(mytarget).bConfused && (AlarmUnit(mytarget).confusionTimer + 1 > AlarmUnit(mytarget).confusionDuration))
        		return true;
        	else if(AlarmUnit(mytarget).bConfused || AlarmUnit(mytarget).bDisabled)
        		return false;
        	else
        		return true;
        }

        if (mytarget.IsA('BeamTrigger'))
        {
        	if(BeamTrigger(mytarget).bConfused && (BeamTrigger(mytarget).confusionTimer + 1 > BeamTrigger(mytarget).confusionDuration))
        		return true;
        	else if(BeamTrigger(mytarget).bConfused || !BeamTrigger(mytarget).bIsOn)
        		return false;
        	else
        		return true;
        }

        if (mytarget.IsA('LaserTrigger'))
        {
        	if(LaserTrigger(mytarget).bConfused && (LaserTrigger(mytarget).confusionTimer + 1 > LaserTrigger(mytarget).confusionDuration))
        		return true;
        	else if(LaserTrigger(mytarget).bConfused || !LaserTrigger(mytarget).bIsOn)
        		return false;
        	else
        		return true;
        }

        return false;
}

simulated function float SetEnergyRate(float Rate)
{
	energyRate += Rate;
}

simulated function float GetEnergyRate()
{	
	local float totEnergy;

	totEnergy = energyRate;
	energyRate = Default.EnergyRate;
	return totEnergy;
}

//------------------------------------------------------------------------------------------------------------------------

simulated function SetDefenseAugStatus(bool bDefenseActive, DeusExProjectile defenseTargets[30])
{
	local int i;
	
   if (Player == None)
      return;
      
   if (Player.rootWindow == None)
      return;
      
   DeusExRootWindow(Player.rootWindow).hud.augDisplay.bDefenseActive = bDefenseActive;
   
	for(i=0; i<30; i++)
	{
		if(defenseTargets[i] != None)
   			DeusExRootWindow(Player.rootWindow).hud.augDisplay.defenseTargets[i] = defenseTargets[i];
   		else
   			DeusExRootWindow(Player.rootWindow).hud.augDisplay.defenseTargets[i] = None;   		
	}
}

function bool FindProjectiles(out DeusExProjectile list[30])
{
	local DeusExProjectile proj;
	local float dist;
	local bool bValidProj;
	local int i;
	local bool bHasFound;
	
	i = 0;
	
	foreach AllActors(class'DeusExProjectile', proj)
	{
		if(i == 30)
			break;
			
		bValidProj = (!proj.bEMPed && proj.IsA('Rocket'));

		if (bValidProj)
		{
			if (VSize(proj.Velocity) > 100)
			{
				dist = VSize(Player.Location - proj.Location);
				
				if (dist < 5000)
				{
					list[i] = proj;
					bHasFound = True;
					i++;
				}
			}
		}
	}
	
	return bHasFound;
}

defaultproperties
{
	 DefenceEnergyRate=1500
	 AttackEnergyRate=3000
	 EmpDamage(0)=10
	 EmpDamage(1)=30
     EnergyRate=30.000000
     Icon=Texture'GameMedia.UserInterface.AugIconEMP'
     smallIcon=Texture'GameMedia.UserInterface.AugIconEMPSmall'
     LevelValues(0)=350.000000
     LevelValues(1)=750.000000
     AugmentationLocation=LOC_Cranial
     LoopSound=None
     MaxLevel=1
}