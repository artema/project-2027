class Chapter6 expands MissionScript;

var travel int AugTroopersCount;

var float MainTimer;

//----------------------------------
//
//----------------------------------
function InitStateMachine()
{
    super.InitStateMachine();
    FirstFrame();
}

//==============================================================================================================================================================================
//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//==============================================================================================================================================================================
//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//==============================================================================================================================================================================
//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//==============================================================================================================================================================================
//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//==============================================================================================================================================================================
//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//==============================================================================================================================================================================
function PreTravel()
{
	local string SN;
	local DeusExLevelInfo info;
	
	Super.PreTravel();
	
	if (localURL == "06_TITANHACK")
	{
		player.PutInHand(None);
	
		info =  player.GetLevelInfo();
		SN = info.NextMapScreen;
		player.SetLoadScr(SN);
	}
}

//==============================================================================================================================================================================
//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//==============================================================================================================================================================================
//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//==============================================================================================================================================================================
//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//==============================================================================================================================================================================
//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//==============================================================================================================================================================================
//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//==============================================================================================================================================================================

function FirstFrame()
{
	local Actor a;
	local Keypad pad;
	local MJ12Troop_Aug MJA;
	local ScriptedPawn pawn;
	local Dispatcher disp;
	local DeusExMover mover;
	local SecurityCamera camera;
	local AmbientSoundTriggered sound;
	local Trigger trig;
	local F117 jet;

	Super.FirstFrame();

	//Check Amrita
	if (!flags.GetBool('MS_Global_MagnusGotAmrita'))
	{
		if(!flags.GetBool('C4_GotAmrita') || flags.GetBool('MS_Global_GaveAmritaToMagnus'))
		{
			flags.SetBool('MS_Global_MagnusGotAmrita', True,, 7);
		}
	}
	
	//Check where Magnus is
	if(!flags.GetBool('MS_C6_MagnusAtRocket') && !flags.GetBool('MS_C6_MagnusAtBunker'))
	{
		if(flags.GetBool('MS_Global_VladimirComplete') && !flags.GetBool('MS_Global_VladimirDead'))
			flags.SetBool('MS_C6_MagnusAtRocket', True,, 7);
		else
			flags.SetBool('MS_C6_MagnusAtBunker', True,, 7);
	}

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

	if (localURL == "06_MTWEATHER_ENTRANCE")
	{
		//Startup
		if(!flags.GetBool('MS_C6Started'))
		{	
			//Remove the ambush troopers
			foreach AllActors(class'ScriptedPawn', pawn, 'VladimirAmbushTrooper')
				pawn.LeaveWorld();
				
			flags.SetBool('MS_C6Started', True,, 7);			
		}

		//Add Vladimir
		if(!flags.GetBool('MS_C6VladimirAdded'))
		{
			if (flags.GetBool('MS_Global_VladimirComplete') && !flags.GetBool('MS_Global_VladimirDead'))
			{
				foreach AllActors(class'ScriptedPawn', pawn, 'VladimirGrigoryev')
					pawn.bHidden = False;
			}
			
			flags.SetBool('MS_C6VladimirAdded', True,, 7);
		}
		
		//Remove Vladimir if player has not met him
		if(!flags.GetBool('MS_C6VladimirRemoved'))
		{
			if (!flags.GetBool('MS_Global_VladimirComplete') || flags.GetBool('MS_Global_VladimirDead'))
			{
				foreach AllActors(class'ScriptedPawn', pawn, 'VladimirGrigoryev')
					pawn.LeaveWorld();
				
				Player.StartDataLinkTransmission("DL_AltStartUp");
			}
			
			flags.SetBool('MS_C6VladimirRemoved', True,, 7);
		}
		
		//Hide aug troops
		if (!flags.GetBool('MS_C6AugSoldiersSpawned'))
		{
		    foreach AllActors(class'MJ12Troop_Aug', MJA, 'AugTroopers')
				MJA.LeaveWorld();
        }
		
		//Disable alarm if Omars are not attacking the base
		if(!flags.GetBool('MS_Global_Amrita_Complete') && !flags.GetBool('MS_C6AlarmDisabled'))
		{
			foreach AllActors(class'AmbientSoundTriggered', sound, 'AlarmSound')
				sound.UnTrigger(None, None);

			foreach AllActors(class'Trigger', trig, 'JetPlaneFlyTrigger')
				trig.SetCollision(False);

			foreach AllActors(class'F117', Jet, 'JetPlaneSelf')
				jet.LeaveWorld();

		    foreach AllActors(class'Actor', a, 'PlaneParticles')
				a.Destroy();

			foreach AllActors(class'ScriptedPawn', pawn, 'ExtraTrooper')
				pawn.LeaveWorld();
				
			foreach AllActors(class'Actor', a, 'RocketLauncher')
				a.Destroy();

			flags.SetBool('MS_C6AlarmDisabled', True,, 7);
		}
		
		//Take Amrita from Magnus if HH agents had failed in Moscow
		if(!flags.GetBool('MS_Global_MagnusGotAmrita') && !flags.GetBool('MS_C6MagnusHasNoAmrita'))
		{
			foreach AllActors(class'ScriptedPawn', pawn, 'MagnusAthers')
				pawn.AmritaRate = 0;
			
			flags.SetBool('MS_C6MagnusHasNoAmrita', True,, 7);
		}
		
		//Remove Magnus if he is already dead OR if he is not there
		if (!flags.GetBool('MS_C6RocketMagnusRemoved') && (flags.GetBool('MS_Global_MagnusDead') || !flags.GetBool('MS_C6_MagnusAtRocket')))
		{
			foreach AllActors(class'ScriptedPawn', pawn, 'MagnusAthers')
				pawn.LeaveWorld();
			
			foreach AllActors(class'ScriptedPawn', pawn, 'MagnusHelp')
				pawn.LeaveWorld();
			
			flags.SetBool('MS_C6RocketMagnusRemoved', True,, 7);
		}
		
		//Open shaft door after visiting the bunker
		if (flags.GetBool('C6_FoundWayUp'))
		{
		    foreach AllActors(class'DeusExMover', mover, 'ShaftLoadingDoor')
				mover.bLocked = False;
        }
		
		//Unlock the command room keypad if the rocket is prepared and Vladimir is alive
		if (flags.GetBool('C6_RocketReady') && flags.GetBool('MS_Global_VladimirComplete') && !flags.GetBool('MS_Global_VladimirDead') && !flags.GetBool('MS_C6CommRoomUnlocked'))
		{
			//Prepare the ambush
			foreach AllActors(class'Trigger', trig, 'VladimirAmbush')
				trig.SetCollision(True);
				
			foreach AllActors(class'Keypad', pad, 'CommRoomPad')
			{
				pad.bAlwaysWrong = False;
				pad.hackStrength = 0.0;
				break;
			}
			
			foreach AllActors(class'DeusExMover', mover, 'CommandCenterDoor')
			{
				mover.Trigger(None, None);
				break;
			}
			
			flags.SetBool('MS_C6CommRoomUnlocked', True,, 7);
		}
		
        //Enable rocket keypad if player has reached the bunker
		if (flags.GetBool('MS_C6ReachedBunker'))
		{
			foreach AllActors(class'Keypad', pad, 'RocketPad')
				pad.bAlwaysWrong = False;
		}	
	}

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

	if (localURL == "06_TITANHACK")
	{
		MainTimer = Level.TimeSeconds;
	}

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	if (localURL == "06_MTWEATHER_MAIN")
	{
		//Startup
		if (!flags.GetBool('MS_C6ReachedBunker'))
		{
			foreach AllActors(class'Dispatcher', disp, 'StartupDispatcher')
		        disp.Trigger(None, None);
		    
		    foreach AllActors(class'ScriptedPawn', pawn, 'GeneratorAmbushTrooper')
				pawn.LeaveWorld();
		     
		    foreach AllActors(class'ScriptedPawn', pawn, 'AmbushOnOmarsTrooper')
				pawn.LeaveWorld();
		    
		    foreach AllActors(class'ScriptedPawn', pawn, 'VladimirGrigoryev')
				pawn.LeaveWorld();
		           
			flags.SetBool('MS_C6ReachedBunker', True,, 7);
			
			Player.StartDataLinkTransmission("DL_BunkerStartup");
		}
		
		//Remove Vladimir-related stuff
		if(!flags.GetBool('MS_C6VladimirSolved'))
		{
			if (!flags.GetBool('MS_Global_VladimirComplete') || flags.GetBool('MS_Global_VladimirDead'))
			{
				foreach AllActors(class'Actor', a, 'StartRocket')
				{
					a.Tag = 'OldStartRocket';
					break;	
				}
				
				foreach AllActors(class'Actor', a, 'MockStartRocket')
				{
					a.Tag = 'StartRocket';
					break;	
				}
			}
			
			flags.SetBool('MS_C6VladimirSolved', True,, 7);
		}
		
		//Remove Omars if we don't need them
		if (!flags.GetBool('MS_Global_Amrita_Complete') && !flags.GetBool('MS_C6OmarsSolved'))
		{		
			foreach AllActors(class'ScriptedPawn', pawn, 'Omars')
				pawn.LeaveWorld();
				
			foreach AllActors(class'ScriptedPawn', pawn, 'OmarPetr')
				pawn.LeaveWorld();
			
			foreach AllActors(class'ScriptedPawn', pawn, 'OmarYuri')
				pawn.LeaveWorld();
				
			foreach AllActors(class'ScriptedPawn', pawn, 'OmarsBot')
				pawn.LeaveWorld();
				
			foreach AllActors(class'Actor', a, 'DeadOmar')
			{
            	a.Destroy();
            	break;	
			}

			flags.SetBool('MS_C6OmarsSolved', True,, 7);
		}		
		//Otherwise, add Omars and remove MJ12 troops
		else if (flags.GetBool('MS_Global_Amrita_Complete') && !flags.GetBool('MS_C6OmarsSolved'))
		{
			foreach AllActors(class'Actor', a, 'LinuxBotConsole')
				a.Destroy();
				
			foreach AllActors(class'Actor', a, 'PostLaser')
				a.Destroy();
			
			foreach AllActors(class'Actor', a, 'PostTurret1')
				a.Destroy();
			
			foreach AllActors(class'SecurityCamera', camera, 'PostCamera1')
				camera.bNoAlarm = True;
				
			foreach AllActors(class'ScriptedPawn', pawn, 'LinuxBot')
				pawn.LeaveWorld();
				
			foreach AllActors(class'ScriptedPawn', pawn, 'PostBot')
				pawn.LeaveWorld();
				
			foreach AllActors(class'ScriptedPawn', pawn, 'LinuxMib')
				pawn.LeaveWorld();
				
			foreach AllActors(class'ScriptedPawn', pawn, 'LinuxSoldier')
				pawn.LeaveWorld();
			
			foreach AllActors(class'ScriptedPawn', pawn, 'PostSoldier')
				pawn.LeaveWorld();
			
			//Check if Petr should come
			if(!flags.GetBool('MS_Global_PetrIsOmar'))
			{
				foreach AllActors(class'ScriptedPawn', pawn, 'OmarPetr')
					pawn.LeaveWorld();	
			}

			flags.SetBool('MS_C6OmarsSolved', True,, 7);
		}
		
		//Check if Omars are raging
		if(flags.GetBool('MS_Global_OmarsRage'))
		{
			foreach AllActors(class'Dispatcher', disp, 'OmarsRage')
				disp.Trigger(None, None);
		}
	}

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	if (localURL == "06_MTWEATHER_THANATOS")
	{
		flags.SetBool('MS_C6ThanatosStartUp', True,, 7);
		
		//Take Amrita from Magnus if HH agents had failed in Moscow
		if(!flags.GetBool('MS_Global_MagnusGotAmrita') && !flags.GetBool('MS_C6Magnus2HasNoAmrita'))
		{
			foreach AllActors(class'ScriptedPawn', pawn, 'MagnusAthers')
				pawn.AmritaRate = 0;
			
			flags.SetBool('MS_C6Magnus2HasNoAmrita', True,, 7);
		}
		
		//Remove Magnus if he is already dead OR if he is not there
		if (!flags.GetBool('MS_C6CaveMagnusRemoved') && (flags.GetBool('MS_Global_MagnusDead') || !flags.GetBool('MS_C6_MagnusAtBunker')))
		{
			foreach AllActors(class'ScriptedPawn', pawn, 'MagnusAthers')
				pawn.LeaveWorld();
			
			foreach AllActors(class'ScriptedPawn', pawn, 'MagnusHelp')
				pawn.LeaveWorld();
			
			flags.SetBool('MS_C6CaveMagnusRemoved', True,, 7);
		}
		
		//Remove Omars ambush
		if (!flags.GetBool('MS_C6OmarsAmbushRemoved'))
		{
			foreach AllActors(class'ScriptedPawn', pawn, 'OmarsAmbush1')
				pawn.LeaveWorld();
			
			foreach AllActors(class'ScriptedPawn', pawn, 'OmarsAmbush2')
				pawn.LeaveWorld();
			
			foreach AllActors(class'ScriptedPawn', pawn, 'OmarsAmbush2Petr')
				pawn.LeaveWorld();
				
			foreach AllActors(class'ScriptedPawn', pawn, 'OmarsAmbush2Yuri')
				pawn.LeaveWorld();
				
			foreach AllActors(class'ScriptedPawn', pawn, 'OmarsAmbush3Cyclope')
				pawn.LeaveWorld();
				
			foreach AllActors(class'ScriptedPawn', pawn, 'OmarsAmbush3Mech')
				pawn.LeaveWorld();
				
			foreach AllActors(class'ScriptedPawn', pawn, 'OmarsAmbush3Spider')
				pawn.LeaveWorld();
			
			foreach AllActors(class'ScriptedPawn', pawn, 'MajesticAmbush')
				pawn.LeaveWorld();
			
			flags.SetBool('MS_C6OmarsAmbushRemoved', True,, 7);
		}
		
		//Remove Omars if they are not here
		if(!flags.GetBool('MS_C6_OmarsMoved') || !flags.GetBool('MS_Global_Amrita_Complete'))
		{
			foreach AllActors(class'ScriptedPawn', pawn, 'Omars')
				pawn.LeaveWorld();
				
			foreach AllActors(class'ScriptedPawn', pawn, 'OmarPetr')
				pawn.LeaveWorld();
			
			foreach AllActors(class'ScriptedPawn', pawn, 'OmarYuri')
				pawn.LeaveWorld();
				
			foreach AllActors(class'ScriptedPawn', pawn, 'GepMech')
				pawn.LeaveWorld();
				
			foreach AllActors(class'Trigger', trig, 'OmarsCutsceneTrigger')
				trig.SetCollision(False);
		}
		//Otherwise, add them
		else if(!flags.GetBool('MS_C6_OmarsMovedAndPlaced'))
		{
			foreach AllActors(class'ScriptedPawn', pawn, 'Omars')
			{
				if(pawn.BindName == "Cyclope" && flags.GetBool('MS_Global_CyclopeDead'))
				{
					pawn.LeaveWorld();
					continue;
				}
				else if(pawn.BindName == "Dmitri" && flags.GetBool('MS_Global_MechClubOwnerDead'))
				{
					pawn.LeaveWorld();
					continue;
				}
					
				pawn.EnterWorld();
			}

			foreach AllActors(class'ScriptedPawn', pawn, 'OmarPetr')
			{
				if(flags.GetBool('MS_Global_PetrDead') || !flags.GetBool('MS_Global_PetrIsOmar'))
					pawn.LeaveWorld();
				else
					pawn.EnterWorld();
			}
		
			foreach AllActors(class'ScriptedPawn', pawn, 'OmarYuri')
			{
				if(flags.GetBool('MS_Global_YuriDead'))
					pawn.LeaveWorld();
				else
					pawn.EnterWorld();
			}
				
			foreach AllActors(class'ScriptedPawn', pawn, 'GepMech')
				pawn.EnterWorld();
				
			foreach AllActors(class'Trigger', trig, 'OmarsCutsceneTrigger')
				trig.SetCollision(True);
				
			//Check if Omars are raging
			if(flags.GetBool('MS_Global_OmarsRage'))
			{
				foreach AllActors(class'Dispatcher', disp, 'OmarsRage')
					disp.Trigger(None, None);
			}
			
			flags.SetBool('MS_C6_OmarsMovedAndPlaced', True,, 7);
		}
	}
}

//==============================================================================================================================================================================
//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//==============================================================================================================================================================================
//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//==============================================================================================================================================================================
//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//==============================================================================================================================================================================
//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//==============================================================================================================================================================================
//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//==============================================================================================================================================================================

function Timer()
{
	local Actor a;
	local DeusExMover DXM;
	local Mover M;
	local MJ12Troop_Aug MJA;
	local AdvSwitch2 sw2;
    local F117 Jet;
    local ParticleGenerator pg;
	local ScriptedPawn pawn;
	local int count;
	local Dispatcher disp;
	local Secretary Op;
	local Trigger trig;
	local OmarCarcass omarcarc;
	local BolshevikWarriorCarcass bolshcarc;
	local MechClubOwnerCarcass mechcarc;
	local OmarCyclopeCarcass cyclopecarc;
	local VladimirGrigoryevCarcass vladcarc;
	local ParticleGenerator smokeGen;
	local ParticleGenerator smokeGen2;
	local Rotator rot;
	local Vector loc;
	local Actor xander;
	local int PlayerEnergy;
	local MagnusAthersCarcass magnuscarc;

	Super.Timer();

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

	if (localURL == "06_MTWEATHER_ENTRANCE")
	{
		//Hide jet after fly-by
		if (flags.GetBool('C6_JetFlyAway'))
		{
		    foreach AllActors(class'F117', Jet, 'JetPlaneSelf')
				Jet.LeaveWorld();

		    foreach AllActors(class'ParticleGenerator', pg, 'PlaneParticles')
				pg.Destroy();
        }
        
        //Show camo soldiers
		if (flags.GetBool('MS_C6AugSoldiersAppear') && !flags.GetBool('MS_C6AugSoldiersSpawned'))
		{
		    foreach AllActors(class'MJ12Troop_Aug', MJA, 'AugTroopers')
		    {
				MJA.EnterWorld();
				MJA.KillShadow();
				AugTroopersCount++;				
		    }
				
			flags.SetBool('MS_C6AugSoldiersSpawned', True,, 7);
        }
        
        //Check if all camo troops are dead
        if (flags.GetBool('MS_C6AugSoldiersSpawned') && !flags.GetBool('MS_C6AugSoldiersKilled'))
        {
        	count = 0;
        	
        	foreach AllActors(class'MJ12Troop_Aug', MJA, 'AugTroopers')
		    	count++;
		    	
        	if(count == 0)
        	{
        		flags.SetBool('MS_C6AugSoldiersKilled', True,, 7);	
        		
        		Player.StartDataLinkTransmission("DL_MJ12WaitingAfter");
        	}
        }
        
        //Send good Magnus message
		if (flags.GetBool('MS_Global_GoodMagnusEnding') && !flags.GetBool('C6_MagnusGoodPlayed'))
		{
			Player.StartDataLinkTransmission("DL_MagnusGood");
		}
        
        //Disable Magnus trigger
		if(flags.GetBool('MS_Global_GoodMagnusEnding') && !flags.GetBool('MS_C6MagnusRageDisabled'))
		{
			foreach AllActors(class'Trigger', trig, 'MagnusRageTrigger')
				trig.SetCollision(False);
				
			flags.SetBool('MS_C6MagnusRageDisabled', True,, 7);
		}
        
        //Check if Magnus is dead
		if (!flags.GetBool('MS_Global_MagnusDead') && flags.GetBool('MS_C6_MagnusAtRocket'))
		{
		    foreach AllActors(class'MagnusAthersCarcass', magnuscarc)
		    {
		    	flags.SetBool('MS_Global_MagnusDead', True,, 7);
		    	break;
		    }
		}
		
		//Check if Vladimir is dead
		if (!flags.GetBool('MS_Global_VladimirDead'))
		{
		    count = 0;

		    foreach AllActors(class'ScriptedPawn', pawn, 'VladimirGrigoryev')
		    {
				count++;
				break;	
		    }

			if (count == 0)
			{
				flags.SetBool('MS_Global_VladimirDead', True,, 7);
				
				//Vladimir was shot before the startup convo
				if(!flags.GetBool('C6VladimirPlayed'))
				{
					Player.StartDataLinkTransmission("DL_AltStartUp");
				}				
				//Vladimir was shot after the startup convo...
				else
				{
					//...but before the last conversation at the rocket shaft
					if(!flags.GetBool('C6VladimirLabPreConvoPlayed'))
					{
						Player.GoalFailed('GetVladimirToLab');
					}
					//...between two conversations at the rocket shaft
					else if(!flags.GetBool('C6VladimirLabConvoPlayed'))
					{
						Player.GoalFailed('StartVladimirRocket');
					}
					//...after the last conversation at the rocket shaft
					else
					{
						Player.GoalFailed('Final_Rocket');
					}
					
					flags.SetBool('MS_C6_TitanIsLeading', True,, 7); //So Titan will open the bunker doors instead of Vladimir
				}
				
				Player.StartDataLinkTransmission("DL_VladimirKilled");
			}
		}
        
        //Vladimir (or Titan) now have access to the security systems and opens the bunker doors
        if (flags.GetBool('C6VladimirOpensDoor'))
		{
			foreach AllActors(class'DeusExMover', DXM)
			{
				if (DXM.Tag == 'MainBlastDoorLittle')
                	DXM.bIsDoor = True;

				if (DXM.Tag == 'ParkingZoneDoor')
                	DXM.bIsDoor = True;
            }
        }        
        
        //Start the final ambush
		if (flags.GetBool('C6_StartVladimirAmbush') && flags.GetBool('MS_Global_VladimirComplete') && !flags.GetBool('MS_Global_VladimirDead') && !flags.GetBool('MS_C6AmbushSoldiersSpawned'))
		{
		    foreach AllActors(class'ScriptedPawn', pawn, 'VladimirAmbushTrooper')
				pawn.EnterWorld();
				
			flags.SetBool('MS_C6AmbushSoldiersSpawned', True,, 7);
        }
        
        //Player is trying to launch the rocket...
        if(flags.GetBool('C6_LaunchRocket') && !flags.GetBool('MS_C6_RocketLaunchHandled'))
        {
        	//...but Vladimir is dead
        	if(flags.GetBool('MS_Global_VladimirDead') || !flags.GetBool('MS_Global_VladimirComplete'))
        	{
        		foreach AllActors(class'Dispatcher', disp, 'LaunchRocketFailed')
					disp.Trigger(None, Player);
        	}
        	//...and Vladimir helps him
        	else
        	{
        		//Spawn some effects and start the countdown
        		foreach AllActors(class'Dispatcher', disp, 'LaunchRocketStarted')
					disp.Trigger(None, Player);
					
				//Make Vladimir invincible
				foreach AllActors(class'ScriptedPawn', pawn, 'VladimirGrigoryev')
			    {
			    	pawn.bInvincible = True;
			    	break;
			    }
			    
			    //Block the level exits
			    foreach AllActors(class'Actor', a, 'RocketBlocker')
					a.SetCollision(True, True, True);
        	}
        	
        	flags.SetBool('MS_C6_RocketLaunchHandled', True,, 7);
        }        
        
        //Xander is flying away
        if(flags.GetBool('C6_XanderFlyingAway') && !flags.GetBool('MS_C6_XanderFlyingAway_Started'))
        {
        	foreach AllActors(class'Actor', a, 'HeliPlants')
        		a.AnimRate = 0.02;
        	
        	//Xander dies
        	if(flags.GetBool('Global_XanderIsDamaged'))
        	{
        		foreach AllActors(class'Actor', a, 'Xander')
        		{
        			a.Event = 'HeliPathBad';
        			
        			rot = a.Rotation;
        			loc = a.Location;
        			
        			smokeGen2 = Spawn(class'ParticleGenerator', a,, loc, rot);
				
					if (smokeGen2 != None)
					{
						smokeGen2.particleDrawScale = 1.0;
						smokeGen2.particleLifeSpan = 2.0;
						smokeGen2.checkTime = 0.01;
						smokeGen2.frequency = 0.1;
						smokeGen2.riseRate = 200.0;
						smokeGen2.ejectSpeed = 20.0;
						smokeGen2.bRandomEject = True;
						smokeGen2.SetBase(a);
				        smokeGen2.RemoteRole = ROLE_None;
				        smokeGen2.particleTexture = Texture'GameMedia.Effects.ef_ExpSmoke009';
				        
				        smokeGen2.LifeSpan = 15;
					}
        			
        			rot.Yaw += 32768;
        			loc.Z += 100;
        			
        			smokeGen = Spawn(class'ParticleGenerator', a,, loc, rot);
				
					if (smokeGen != None)
					{
						smokeGen.particleDrawScale = 1.0;
						smokeGen.particleLifeSpan = 2.0;
						smokeGen.checkTime = 0.01;
						smokeGen.frequency = 0.1;
						smokeGen.riseRate = 300.0;
						smokeGen.ejectSpeed = 10.0;
						smokeGen.bRandomEject = True;
						smokeGen.SetBase(a);
				        smokeGen.RemoteRole = ROLE_None;
				        smokeGen.particleTexture = Texture'GameMedia.Effects.ef_ExpSmoke011';
				        
				        smokeGen.LifeSpan = 20;
					}
					
					
					
					xander = a;					
					break;
        		}
        		
        		foreach AllActors(class'Dispatcher', disp, 'XanderFlyingBad')
					disp.Trigger(None, Player);
        	}
        	else
        	{
        		foreach AllActors(class'Actor', a, 'Xander')
        			a.Event = 'HeliPathGood';
        			
        		foreach AllActors(class'Dispatcher', disp, 'XanderFlyingGood')
					disp.Trigger(None, Player);
        	}
        	
        	flags.SetBool('MS_C6_XanderFlyingAway_Started', True,, 7);
        }
        
        if(flags.GetBool('Global_XanderIsDamaged') && flags.GetBool('MS_C6_XanderFlyingAway_Started') && !flags.GetBool('C6_XanderExplosion'))
        {
        	rot = xander.Rotation;
        	smokeGen2.SetRotation(rot);
        				
			rot.Yaw = xander.Rotation.Yaw + 32768;			
			smokeGen.SetRotation(rot);
			
        }
        
        //Xander explodes
        if(flags.GetBool('C6_XanderExplosion') && !flags.GetBool('MS_C6_XanderExplosion_Added'))
        {
        	
        	foreach AllActors(class'Actor', a, 'Xander')
        	{
        		Spawn(class'SFXExplosionHeli',,, a.Location);
        		a.Destroy();
        		break;
        	}
        		
        	if(smokeGen != None)
        		smokeGen.Destroy();
        	
        	flags.SetBool('MS_C6_XanderExplosion_Added', True,, 7);
        }
	}

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

	if (localURL == "06_TITANHACK")
	{
		if (Level.TimeSeconds - MainTimer >= 2.0)
        {
			foreach AllActors(class'Secretary', Op)
				break;
	
			player.StartConversationByName('TitanHack', Op, False, True);
        }
	}

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

	if (localURL == "06_MTWEATHER_MAIN")
	{
		//Start the generator ambush
		if (flags.GetBool('C6_Generator2Online') && !flags.GetBool('MS_C6GeneratorSoldiersSpawned'))
		{
		    foreach AllActors(class'MJ12Troop_Aug', MJA, 'GeneratorAmbushTrooper')
		    {
				MJA.EnterWorld();
				MJA.KillShadow();			
		    }
		    
		    foreach AllActors(class'Dispatcher', disp, 'StartGeneratorAmbush')
				disp.Trigger(None, None);
				
			flags.SetBool('MS_C6GeneratorSoldiersSpawned', True,, 7);
        }
		
		//Start attack on Omars
		if(flags.GetBool('C6_AttackOnOmars') && !flags.GetBool('MS_C6_AttackOnOmars_Started'))
		{
			foreach AllActors(class'ScriptedPawn', pawn, 'AmbushOnOmarsTrooper')
				pawn.EnterWorld();
				
			flags.SetBool('MS_C6_AttackOnOmars_Started', True,, 7);
		}
		
		//Omars are going to the cave
		if (flags.GetBool('C6_BothGeneratorsOnline') && flags.GetBool('MS_Global_Amrita_Complete') && !flags.GetBool('MS_C6_OmarsMoved'))
		{
			foreach AllActors(class'ScriptedPawn', pawn, 'Omars')
				pawn.LeaveWorld();
				
			foreach AllActors(class'ScriptedPawn', pawn, 'OmarPetr')
				pawn.LeaveWorld();
			
			foreach AllActors(class'ScriptedPawn', pawn, 'OmarYuri')
				pawn.LeaveWorld();
				
			foreach AllActors(class'ScriptedPawn', pawn, 'OmarsBot')
				pawn.LeaveWorld();

			flags.SetBool('MS_C6_OmarsMoved', True,, 7);
		}
		
		//Add Vladimir if needed
		if (flags.GetBool('C6_BothGeneratorsOnline') && !flags.GetBool('MS_Global_VladimirComplete') && !flags.GetBool('MS_Global_VladimirDead') && !flags.GetBool('MS_C6_VladimirAdded'))
		{
			foreach AllActors(class'ScriptedPawn', pawn, 'VladimirGrigoryev')
				pawn.EnterWorld();
					
			flags.SetBool('MS_C6_VladimirAdded', True,, 7);
		}
		
		//Check if Bad Vladimir is dead
		if (flags.GetBool('MS_C6_VladimirAdded') && !flags.GetBool('MS_Global_VladimirDead'))
		{
		    count = 0;

		    foreach AllActors(class'VladimirGrigoryevCarcass', vladcarc)
		    {
				count++;
				break;	
		    }

			if (count >= 1)
			{
				Player.StartDataLinkTransmission("DL_BadVladimirKilled");
				
				flags.SetBool('MS_Global_VladimirDead', True,, 7);				
			}
		}
		
		//Make Vladimir invisible
		if(flags.GetBool('C6_SetVladimirInvisible') && !flags.GetBool('MS_C6_VladimirIsInvisible'))
		{
			foreach AllActors(class'ScriptedPawn', pawn, 'VladimirGrigoryev')
			{
				pawn.bHasCloak = True;
				pawn.CloakThreshold = 9000;				
				break;
			}
					
			flags.SetBool('MS_C6_VladimirIsInvisible', True,, 7);
		}
	}

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

	if (localURL == "06_MTWEATHER_MAIN" || localURL == "06_MTWEATHER_THANATOS")
	{	
		//Check routers	
		if (!flags.GetBool('C6_TitanReady') && flags.GetBool('C6_Router1Online') && flags.GetBool('C6_Router2Online') && flags.GetBool('C6_Router3Online'))
		{
			flags.SetBool('C6_TitanReady', True,, 7);
		}
		
		//Check Omar-related stuff here
		if (flags.GetBool('MS_Global_Amrita_Complete'))
		{
			//Check if someone is dead
			
			if(!flags.GetBool('MS_Global_CyclopeDead'))
			{
				foreach AllActors(class'OmarCyclopeCarcass', cyclopecarc)
				{
					Player.StartDataLinkTransmission("DL_CyclopeDead");
					
					flags.SetBool('MS_Global_CyclopeDead', True,, 7);
					break;
				}
			}
			
			if(!flags.GetBool('MS_Global_PetrDead') || !flags.GetBool('MS_Global_YuriDead'))
			{
				foreach AllActors(class'OmarCarcass', omarcarc)
				{
					if (omarcarc.AliveBindName == "Petr")
						flags.SetBool('MS_Global_PetrDead', True,, 7);
					else if (omarcarc.AliveBindName == "Yuri")
						flags.SetBool('MS_Global_YuriDead', True,, 7);
				}
			}
			
			if(!flags.GetBool('MS_Global_MechClubOwnerDead'))
			{
				foreach AllActors(class'MechClubOwnerCarcass', mechcarc)
				{
					flags.SetBool('MS_Global_MechClubOwnerDead', True,, 7);
					break;
				}
			}
			
			//Check if Omars are angry
			if (!flags.GetBool('MS_Global_OmarsRage'))
			{
				count = 0;
	
				foreach AllActors(class'OmarCarcass', omarcarc)
				{
					if (omarcarc.KillerBindName == "JCDenton")
						count++;
				}
				
				foreach AllActors(class'BolshevikWarriorCarcass', bolshcarc)
				{
					if (bolshcarc.KillerBindName == "JCDenton")
						count++;
				}
				
				foreach AllActors(class'MechClubOwnerCarcass', mechcarc)
				{
					if (mechcarc.KillerBindName == "JCDenton")
						count++;
				}
				
				if(count >= 1)
				{
					Player.GoalFailed('Final_Omars');
					
					if(!flags.GetBool('MS_Global_CyclopeDead'))
						Player.StartDataLinkTransmission("DL_OmarsRage");
					
					foreach AllActors(class'Dispatcher', disp, 'OmarsRage')
						disp.Trigger(None, None);
					
					flags.SetBool('MS_Global_OmarsRage', True,, 7);
				}
			}
			
			//Check if Omars are ready
			if(flags.GetBool('MS_Global_VladimirDead') && flags.GetBool('MS_C6_OmarsMoved') && !flags.GetBool('MS_Global_OmarsRage') && !flags.GetBool('C6_OmarsReady'))
			{
				Player.StartDataLinkTransmission("DL_End_Omars");
				
				flags.SetBool('C6_OmarsReady', True,, 7);
			}
		}
	}

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

	if (localURL == "06_MTWEATHER_THANATOS")
	{
        //Startup
		if (flags.GetBool('MS_C6ThanatosStartUp') && !flags.GetBool('MS_C6ThanatosStartUpPlayed'))
		{
		    Player.StartDataLinkTransmission("DL_ThanatosEntrance");

		    flags.SetBool('MS_C6ThanatosStartUpPlayed', True,, 7);
        }
        
        //Send good Magnus message
		if (flags.GetBool('MS_Global_GoodMagnusEnding') && !flags.GetBool('C6_MagnusGoodPlayed'))
		{
			Player.StartDataLinkTransmission("DL_MagnusGood");
		}
        
        //Disable Magnus trigger
		if(flags.GetBool('MS_Global_GoodMagnusEnding') && !flags.GetBool('MS_C6MagnusRageDisabled'))
		{
			foreach AllActors(class'Trigger', trig, 'MagnusRageTrigger')
				trig.SetCollision(False);
				
			flags.SetBool('MS_C6MagnusRageDisabled', True,, 7);
		}
        
        //Check if Magnus is dead
		if (!flags.GetBool('MS_Global_MagnusDead') && flags.GetBool('MS_C6_MagnusAtBunker'))
		{
		    foreach AllActors(class'MagnusAthersCarcass', magnuscarc)
		    {
		    	flags.SetBool('MS_Global_MagnusDead', True,, 7);
		    	break;
		    }
		}
        
        //Check if bot was killed byt he GEP trooper
        if (flags.GetBool('MS_Global_Amrita_Complete') && flags.GetBool('MS_C6_OmarsMoved') && !flags.GetBool('MS_C6BotGeped'))
		{
			count = 0;
			
			foreach AllActors(class'ScriptedPawn', pawn, 'GepPrey')
			{
				count++;
				break;
			}
				
			if(count == 0)
			{
				foreach AllActors(class'Dispatcher', disp, 'EndOmarsCutscene')
					disp.Trigger(None, None);
				
				flags.SetBool('MS_C6BotGeped', True,, 7);
			}
		}
        
        //Titan now can open the Thanatos bunker
		if(flags.GetBool('C6_TitanReady') && !flags.GetBool('MS_C6TitanCanOpenThanatos'))
		{
			foreach AllActors(class'Trigger', trig, 'ClosedThanatosDatalink')
				trig.SetCollision(False);

			foreach AllActors(class'Trigger', trig, 'OpenThanatosBunkerTrigger')
				trig.SetCollision(True);
				
			flags.SetBool('MS_C6TitanCanOpenThanatos', True,, 7);
		}

		//Titan attacks player
		if (flags.GetBool('C6TitanAttacksPlayer') && !flags.GetBool('MS_C6TitanAttacksPlayer'))
		{
			PlayerEnergy = Player.Energy;
			loc = Player.Location;
			loc.Z += Player.CollisionHeight * 0.78;
		    Player.TakeDamage(Max(PlayerEnergy, 20), None, loc, vect(0,0,0), 'Shocked');
		    Player.TakeDamage(9000, None, vect(0,0,0), vect(0,0,0), 'EMP');

		    flags.SetBool('MS_C6TitanAttacksPlayer', True,, 7);
        }
        
        //Disable Omars endgame if they are raging
        if(flags.GetBool('MS_Global_OmarsRage') && !flags.GetBool('MS_C6OmarsEndgameDisabled'))
        {
        	foreach AllActors(class'Trigger', trig, 'OmarsEndgameTrigger')
				trig.SetCollision(False);   
				
			flags.SetBool('MS_C6OmarsEndgameDisabled', True,, 7);     
		}
		
		//Thanatos is dead
		if(flags.GetBool('C6_ThanatosKilled'))
		{
			//Start the Omars ambush
			if(flags.GetBool('MS_Global_Amrita_Complete'))
			{
				if (!flags.GetBool('MS_C6OmarsAmbushStarted'))
				{
					flags.SetBool('MS_Global_OmarsRage', True,, 7);
					
					foreach AllActors(class'ScriptedPawn', pawn, 'Omars')
						pawn.LeaveWorld();
						
					foreach AllActors(class'ScriptedPawn', pawn, 'OmarPetr')
						pawn.LeaveWorld();
						
					foreach AllActors(class'ScriptedPawn', pawn, 'OmarYuri')
						pawn.LeaveWorld();
						
					foreach AllActors(class'ScriptedPawn', pawn, 'GepMech')
						pawn.LeaveWorld();
					
					Player.GoalFailed('Final_Omars');
					
					foreach AllActors(class'Dispatcher', disp, 'OmarsAmbushSequence')
						disp.Trigger(None, None);
						
					foreach AllActors(class'Trigger', trig, 'AllAtOnce')
						trig.SetCollision(True);
					
					flags.SetBool('MS_C6OmarsAmbushStarted', True,, 7);
				}
				
				//Omars ambush: wave 1
				if(flags.GetBool('C6_OmarsAmbushWave1') && !flags.GetBool('MS_C6_OmarsAmbushWave1_Ready'))
				{
					foreach AllActors(class'ScriptedPawn', pawn, 'OmarsAmbush1')
						pawn.EnterWorld();
						
					flags.SetBool('MS_C6_OmarsAmbushWave1_Ready', True,, 7);
				}
				
				//Omars ambush: wave 2
				if(flags.GetBool('C6_OmarsAmbushWave2') && !flags.GetBool('MS_C6_OmarsAmbushWave2_Ready'))
				{
					foreach AllActors(class'ScriptedPawn', pawn, 'OmarsAmbush2')
					{
						pawn.EnterWorld();
						pawn.CloakThreshold = 500;
					}
					
					if(!flags.GetBool('MS_Global_PetrDead') && flags.GetBool('MS_Global_PetrIsOmar'))
					{
						foreach AllActors(class'ScriptedPawn', pawn, 'OmarsAmbush2Petr')
						{
							pawn.EnterWorld();
							pawn.CloakThreshold = 500;
							break;
						}
					}
					
					if(!flags.GetBool('MS_Global_YuriDead'))
					{
						foreach AllActors(class'ScriptedPawn', pawn, 'OmarsAmbush2Yuri')
						{
							pawn.EnterWorld();
							pawn.CloakThreshold = 500;
							break;
						}
					}
						
					flags.SetBool('MS_C6_OmarsAmbushWave2_Ready', True,, 7);
				}
				
				//Omars ambush: wave 3
				if(flags.GetBool('C6_OmarsAmbushWave3') && !flags.GetBool('MS_C6_OmarsAmbushWave3_Ready'))
				{
					if(!flags.GetBool('MS_Global_CyclopeDead'))
					{
						foreach AllActors(class'ScriptedPawn', pawn, 'OmarsAmbush3Cyclope')
							pawn.EnterWorld();
					}
					
					if(!flags.GetBool('MS_Global_MechClubOwnerDead'))
					{
						foreach AllActors(class'ScriptedPawn', pawn, 'OmarsAmbush3Mech')
							pawn.EnterWorld();
					}
					
					foreach AllActors(class'ScriptedPawn', pawn, 'OmarsAmbush3Spider')
						pawn.EnterWorld();
						
					flags.SetBool('MS_C6_OmarsAmbushWave3_Ready', True,, 7);
				}
			}
			//Otherwise, just send some MJ12 troopers
			else
			{
				if (!flags.GetBool('MS_C6MajesticAmbushStarted'))
				{
					foreach AllActors(class'ScriptedPawn', pawn, 'MajesticAmbush')
						pawn.EnterWorld();

					flags.SetBool('MS_C6MajesticAmbushStarted', True,, 7);
				}
			}
		}
	}
}

defaultproperties
{
	bAutosave=True
	AutosaveName="Mt. Weather"
}