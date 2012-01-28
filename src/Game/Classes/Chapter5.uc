class Chapter5 expands MissionScript;

var float xanderTimer;
var int TroopsCount;
var float cargoTimer;
var float cargoTimerTotal;

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
	Super.PreTravel();
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
    local Bandit B1;
    local Bandit2 B2;
    local Evgeny evg;
    local Boris bor;
	local Trigger trig;
	local ConversationTrigger TCTrig;
	local Dispatcher disp;
	local MilitaryHelicopter mchopper;
    local ScriptedPawn pawn;
	local GuardBot gbot;
	local CombatBot cbot;
    local BumMale BM;
	local RussianArmy RA;
	local RussianArmy_2 RA2;
	local RussianMilitia RM;
	local SecurityCamera camera;
	local SecurityTurret turret;
    local AllianceTrigger ATrig;
    local BeamTrigger laser;
	local DeusExMover M;
	local Button1 EC;
	local SpawnPoint SP;
	local Vector loc;
	local int i;
	local int count;
	local MetalFragment frag;
	local Rotator rot;
	local Keypad pad;
	local AmbientSoundTriggered trigsound;
	local Robot robot;
	local Vector tmp;
	local VladimirGrigoryevCarcass vladcarc;

    Super.Timer();

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

	if (localURL == "05_NORTHLABS_ENTRANCE")
	{
        //������������ ������� ������ ������
		if (flags.GetBool('MS_C5StartUp') && !flags.GetBool('MS_C5StartUpPlayed'))
		{
            foreach AllActors(class'Dispatcher', disp, 'StartUpDisp')
		           disp.Trigger(None, None);
		           
		    Player.StartDataLinkTransmission("DL_StartUp");

			flags.SetBool('MS_C5StartUpPlayed', True,, 6);
        }

        //������ ������ �������
		if (Level.TimeSeconds - xanderTimer >= 8.0)
	            flags.SetBool('MS_DestroyFirstHeli', True,, 6);

        //������ ������ �������� � ����� � ����� ����
		if (flags.GetBool('MS_DestroyFirstHeli'))
		{
		    foreach AllActors(class'MilitaryHelicopter', mchopper)
            {
				if (mchopper.Tag == 'YourHelicopterVH')
			           mchopper.LeaveWorld();
            }
        }

        //��������� ������� ���� ���������� ��������
		if (flags.GetBool('C5ShutterIsDown'))
		{
		   Player.GoalCompleted('ShutDownShutter');
        }

        //��������� �������� ����� ���������� ���� �������� �������
		if (flags.GetBool('C5TitanRouterOpen') && flags.GetBool('C5TitanInfoUploaded'))
		{
		   Player.StartDataLinkTransmission("DL_FindXander");
        }

        //�������� �������� ����� ��������� ���� �������
		if (flags.GetBool('C5TitanRouterOpen') && flags.GetBool('C5TitanInfoUploaded'))
		{
		    foreach AllActors(class'MilitaryHelicopter', mchopper, 'OutroHelicopterVH')
			   mchopper.EnterWorld();
        }

        //������� ������������ ����� ���������� �������
		if ((flags.GetBool('C5TitanRouterOpen')) && (flags.GetBool('C5TitanInfoUploaded')) && (!flags.GetBool('MS_C5Ambush1Appeared')))
		{
		    foreach AllActors(class'Robot', robot, 'DefenceBots')
			   robot.EnterWorld();

		    foreach AllActors(class'RussianArmy', RA, 'DefenceTroopers')
			   RA.EnterWorld();

			flags.SetBool('MS_C5Ambush1Appeared', True,, 6);
        }

		if (flags.GetBool('C5ShutterIsDown') && flags.GetBool('C5TitanRouterOpen'))
		{
			foreach AllActors(class'Trigger', trig, 'HeliMapExitTrig')
				trig.SetCollision(True);
		}
    }

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

	if (localURL == "05_NORTHLABS_MAINCOMPLEX")
	{
            //Disable datalink after Titans datalink
			if (flags.GetBool('C5TitanDatalinkPlayed'))
			{
				foreach AllActors(class'Trigger', trig, 'TitanConvoTrigger')
					trig.SetCollision(True);
			}

            //Disable trigger after Titan cutscene
		    if (flags.GetBool('MS_C5TitanConvoPlayed'))
			{
			   foreach AllActors(class'Trigger', trig, 'TitanConvoTrigger')
				   trig.SetCollision(False);
		    }

            //Spawn ambush troopers
			if ((flags.GetBool('C5TitanRouterOpen')) && (flags.GetBool('C5TitanInfoUploaded')) && (!flags.GetBool('MS_C5Ambush2Appeared')))
			{
				//Close labs door
				foreach AllActors(class'DeusExMover', M, 'GeneratorZoneBlastDoors')
				{
					if(M.KeyNum != 0)
						M.Trigger(None, None);
				}
				
				//Move elevator up
				foreach AllActors(class'DeusExMover', M, 'MainComplexElevator')
				{
					if(M.KeyNum != 0)
					{
						foreach AllActors(class'Dispatcher', disp, 'MainElevatorUp')
						{
		           			disp.Trigger(None, None);
		           			break;	
						}
					}
					
					break;
				}
			
			    foreach AllActors(class'ScriptedPawn', pawn, 'DefenceTroopers')
				   pawn.EnterWorld();

                foreach AllActors(class'Dispatcher', disp, 'AmbushDispatcher')
		           disp.Trigger(None, None);

				flags.SetBool('MS_C5Ambush2Appeared', True,, 6);
            }

            //Disable security after Titan is free
			if (flags.GetBool('C5TitanRouterOpen') && flags.GetBool('C5TitanInfoUploaded'))
			{
				foreach AllActors(class'SecurityTurret', turret)
					turret.UnTrigger(None, None);
					
				foreach AllActors(class'SecurityCamera', camera)
					camera.UnTrigger(None, None);
					
				foreach AllActors(class'BeamTrigger', laser)
					laser.UnTrigger(None, None);
	        }

            //Open router room
            if (flags.GetBool('MS_C5TitanConvoPlayed') && flags.GetBool('C5TitanInfoUploaded') && !flags.GetBool('MS_C5RouterDoorsOpened'))
			{
				foreach AllActors(class'Keypad', pad, 'RouterKeypad')
				{
					pad.bAlwaysWrong = False;
					break;
				}

				flags.SetBool('MS_C5RouterDoorsOpened', True,, 6);
            }
            
            //Cargo sabotage
            if (flags.GetBool('C5_SabotateCargo') && !flags.GetBool('MS_C5_SabotateCargoDone'))
			{
				if(!flags.GetBool('MS_C5_SabotateCargoStarted'))
				{
					cargoTimer = Level.TimeSeconds;
					
					foreach AllActors(class'DeusExMover', M, 'Cargo')
					{
						cargoTimerTotal = M.MoveTime * 0.5;
						M.Trigger(None, None);
						break;
					}
					
					flags.SetBool('MS_C5_SabotateCargoStarted', True,, 6);
				}
				
				//Time to explode
				if(Level.TimeSeconds - cargoTimer >= cargoTimerTotal)
				{
					foreach AllActors(class'DeusExMover', M, 'Cargo')
					{
						M.TakeDamage(100500+9000, GetPlayerPawn(), tmp, tmp, 'Exploded');
						break;	
					}
					
					foreach AllActors(class'DeusExMover', M, 'CraneControlWindows')
					{
						M.TakeDamage(100, GetPlayerPawn(), tmp, tmp, 'Exploded');
					}					
					
					foreach AllActors(class'SpawnPoint', SP, 'CargoPoint')
                    	Spawn(class'SFXCargoExplosion',,, SP.Location, SP.Rotation);
					
					flags.SetBool('MS_C5_SabotateCargoDone', True,, 6);
				}
			}
    }

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

	if (localURL == "05_NORTHLABS_TRAINSTATION")
	{
        //�������� � �������
		if (!flags.GetBool('MS_C5TrainStartUp'))
		{
			foreach AllActors(class'Dispatcher', disp, 'TrStartUpDisp')
				disp.Trigger(None, None);

			flags.SetBool('MS_C5TrainStartUp', True,, 6);
        }

		// �������� �������, ���� ��������� ��� �������
		if (!flags.GetBool('MS_C5ExplosionSpawned'))
		{
             foreach AllActors(class'DeusExMover', M, 'FuelCanister')
	             if (M.bDestroyed)
	             {
					if (!flags.GetBool('C5HelipadReady'))
					{
						foreach AllActors(class'Dispatcher', disp, 'FuelDispatcher')
				             disp.Trigger(None, None);
					}
	
					foreach AllActors(class'SpawnPoint', SP, 'FuelSpawnPoint')
					{
						loc = SP.Location;
						Spawn(class'BigFuelExplosion',,, loc);
	                }
	                
					flags.SetBool('MS_C5ExplosionSpawned', True,, 6);
				}
        }

        //����������� ���������
		if ((flags.GetBool('C5TrainHeliAppears')) && (!flags.GetBool('MS_C5TrainAmbushAppeared')))
		{
		    foreach AllActors(class'MilitaryHelicopter', mchopper)
            {
				if (mchopper.Tag == 'YourHelicopterTR')
			           mchopper.EnterWorld();
            }

		    foreach AllActors(class'RussianArmy', RA, 'BSSoldier')
			   RA.EnterWorld();
		    foreach AllActors(class'RussianArmy_2', RA2, 'BSSoldier')
			   RA2.EnterWorld();

			flags.SetBool('MS_C5TrainAmbushAppeared', True,, 6);
        }

        //�������� ������� ��������
		if (flags.GetBool('C5TrainHeliLanded'))
		{
			foreach AllActors(class'Trigger', trig, 'TrainMapExitTrig')
				trig.SetCollision(True);
        }

        //�������������� �������� ����������
		if ((flags.GetBool('C5HelipadReady')) && (!flags.GetBool('C5XanderSawFuel')))
		{
			Player.StartDataLinkTransmission("DL_XanderAboutHelipad");
        }

		if ((!flags.GetBool('C5HelipadReady')) && (flags.GetBool('C5XanderSawFuel')))
		{
			Player.StartDataLinkTransmission("DL_XanderAboutFuel");
        }
    }

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

	if (localURL == "05_MOSCOW_METRO")
	{
        //Play datalink at startup
		if (!flags.GetBool('MS_C5MoscowStartUpPlayed'))
		{
		    Player.StartDataLinkTransmission("DL_MoscowStartUp");
		    
		    if(flags.GetBool('MS_Global_Amrita_Complete'))
		    	Player.GoalFailed('MeetOmars');
		    
	        flags.SetBool('MS_C5MoscowStartUpPlayed', True,, 6);
        }
        
        //Player has the hideout code
		if(flags.GetBool('C4_KnowOmarsMetroCode') && !flags.GetBool('MS_C5_OmarsMetroCodeReady'))
		{
			foreach AllActors(class'Keypad', pad, 'OmarHideoutKeypad')
			{
				pad.bAlwaysWrong = False;
				break;
			}

			flags.SetBool('MS_C5_OmarsMetroCodeReady', True,, 6);
		}
        
        //Player has the armory code
		if(flags.GetBool('C4_GotOmarSafeCode') && !flags.GetBool('MS_C5OmarSafeReady'))
		{
			foreach AllActors(class'Keypad', pad, 'OmarSafeKeypad')
			{
				pad.bAlwaysWrong = False;
			}

			flags.SetBool('MS_C5OmarSafeReady', True,, 6);
		}
		
		//Player has the safe code
		if(flags.GetBool('C4_GotOmarAugCode') && !flags.GetBool('MS_C5OmarAugReady'))
		{
			foreach AllActors(class'Keypad', pad, 'OmarSafeKeypad2')
			{
				pad.bAlwaysWrong = False;
			}

			flags.SetBool('MS_C5OmarAugReady', True,, 6);
		}
	}

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

	if (localURL == "05_MOSCOW_STREETS")
	{
        //If player did not found Vladimir (or killed him earlier), turn lock his door
		if ((!flags.GetBool('MS_Global_VladimirComplete') || flags.GetBool('MS_C4_VladimirDead')) && !flags.GetBool('MS_C5VladimirDisabled'))
		{
			foreach AllActors(class'DeusExMover', M, 'VladimirApartaments')
			{
				M.bHighlight = False;
				M.bFrobbable = False;
            }

	        flags.SetBool('MS_C5VladimirDisabled', True,, 5);
		}
        
		//Check if military bot is destroyed
		if (!flags.GetBool('MS_C5SquareBotDestroyed'))
		{
			count = 0;
			
			foreach AllActors(class'CombatBot', cbot, 'SquareMilitaryBot')
				if(cbot.EMPHitPoints > 0)
					count++;
			
			if(count == 0)
			{
				flags.SetBool('MS_C5SquareBotDestroyed', True,, 6);
				
				if (!flags.GetBool('MS_C5MarchalLawDisabled'))
				{
					foreach AllActors(class'Dispatcher', disp, 'CombatBotDestroyed')
			        	disp.Trigger(None, None);
				}
			}
		}

		//Count militia forces
		if (!flags.GetBool('MS_C5MilitiaTroopsKilled'))
		{
		    count = 0;

		    foreach AllActors(class'CombatBot', cbot)
				count++;

		    foreach AllActors(class'RussianMilitia', RM)
				count++;

            if (count < TroopsCount)
		        flags.SetBool('MS_C5MilitiaTroopsKilled', True,, 6);
        }

		//Disable marshal law and mech riot if Amrita was not found
		if (!flags.GetBool('MS_Global_Amrita_Complete') && !flags.GetBool('MS_C5MarchalLawDisabled'))
		{
            foreach AllActors(class'AllianceTrigger', ATrig, 'DisableMarshalLaw')
		        ATrig.Trigger(None, None);

			foreach AllActors(class'ScriptedPawn', pawn, 'BolshevikWarriorIdler')
				pawn.LeaveWorld();
				
			foreach AllActors(class'ScriptedPawn', pawn, 'BolshevikAmbushWarrior')
				pawn.LeaveWorld();
				
			foreach AllActors(class'ScriptedPawn', pawn, 'BolshevikTankWarrior')
				pawn.LeaveWorld();

			foreach AllActors(class'AmbientSoundTriggered', trigsound, 'WarSounds')
			{
				if(trigsound.bActive)
				{
					trigsound.AmbientSound = None;
				}
			}

			flags.SetBool('MS_C5MarchalLawDisabled', True,, 6);
		}
		
		//Add warriors
		if (flags.GetBool('MS_Global_Amrita_Complete') && flags.GetBool('C5_MilitaristsCombatStarted') && !flags.GetBool('MS_C5_MilitaristsCombatStarted'))
		{
			foreach AllActors(class'ScriptedPawn', pawn, 'BolshevikAmbushWarrior')
				pawn.EnterWorld();
				
			flags.SetBool('MS_C5_MilitaristsCombatStarted', True,, 6);
		}
		
		//Add tank warrior
		if (flags.GetBool('MS_Global_Amrita_Complete') && flags.GetBool('C5_DestroyTankStarted') && !flags.GetBool('MS_C5_DestroyTankStarted'))
		{
			foreach AllActors(class'ScriptedPawn', pawn, 'BolshevikTankWarrior')
				pawn.EnterWorld();
				
			flags.SetBool('MS_C5_DestroyTankStarted', True,, 6);
		}
		
		//Change the militarists
		if (!flags.GetBool('MS_C5MilitaristsChanged'))
		{
			if(flags.GetBool('C4_Bandits_Job4Complete') && !flags.GetBool('MS_Global_BanditsRage'))
			{
				foreach AllActors(class'ScriptedPawn', pawn, 'Militarist')
					pawn.LeaveWorld();
			}
			else
			{
				foreach AllActors(class'ScriptedPawn', pawn, 'MilitaristStrong')
					pawn.LeaveWorld();
			}

			flags.SetBool('MS_C5MilitaristsChanged', True,, 6);
		}

		//Change troops alliance if any of them is killed
		if (flags.GetBool('MS_C5MilitiaTroopsKilled') && !flags.GetBool('MS_C5TroopsAllChanged'))
		{
            foreach AllActors(class'AllianceTrigger', ATrig, 'TroopsAlliance')
		        ATrig.Trigger(None, None);

			flags.SetBool('MS_C5TroopsAllChanged', True,, 6);
		}

		//Put heli on the map
		if (flags.GetBool('C5HeliCalled') && !flags.GetBool('MS_C5MoscowHeliReady'))
		{
		    foreach AllActors(class'MilitaryHelicopter', mchopper, 'LastHelicopter')
			   mchopper.EnterWorld();

		    flags.SetBool('MS_C5MoscowHeliReady', True,, 6);
        }
        
        //Check if player killed bum
        if (flags.GetBool('MS_C4YardBum_Killed') && !flags.GetBool('MS_C5YardBum_Removed'))
		{
			foreach AllActors(class'ScriptedPawn', pawn, 'YardBumMale')
				pawn.LeaveWorld();
			
			flags.SetBool('MS_C5YardBum_Removed', True,, 7);
		}

        /// --+==Trader==+-- \\\

	    if (flags.GetBool('MS_C5Buy_MP5') && !flags.GetBool('MS_C5Buy_MP5_Spawned'))
	    {
		        foreach AllActors(class'SpawnPoint', SP, 'SpawnPlace1a')
                {
                      loc = SP.Location;
                      Spawn(class'WeaponMP5',,, loc);
                }

		        foreach AllActors(class'SpawnPoint', SP, 'SpawnPlace1b')
                {
                      loc = SP.Location;
                      rot = SP.Rotation;
                      Spawn(class'RAmmo556mm',,, loc, rot);
                }

		        foreach AllActors(class'SpawnPoint', SP, 'SpawnPlace1c')
                {
                      loc = SP.Location;
                      rot = SP.Rotation;
                      Spawn(class'RAmmo556mm',,, loc, rot);
                }

		        foreach AllActors(class'SpawnPoint', SP, 'SpawnPlace1d')
                {
                      loc = SP.Location;
                      rot = SP.Rotation;
                      Spawn(class'RAmmo556mmJHP',,, loc, rot);
                }

			    flags.SetBool('MS_C5Buy_MP5_Spawned', True,, 6);
	     }

	     if (flags.GetBool('MS_C5Buy_Jackhammer') && !flags.GetBool('MS_C5Buy_Jackhammer_Spawned'))
	     {
		        foreach AllActors(class'SpawnPoint', SP, 'SpawnPlace2a')
                {
                      loc = SP.Location;
                      Spawn(class'WeaponAutoShotgun',,, loc);
                }

		        foreach AllActors(class'SpawnPoint', SP, 'SpawnPlace2b')
                {
                      loc = SP.Location;
                      rot = SP.Rotation;
                      Spawn(class'RAmmoShell',,, loc, rot);
                }

		        foreach AllActors(class'SpawnPoint', SP, 'SpawnPlace2c')
                {
                      loc = SP.Location;
                      rot = SP.Rotation;
                      Spawn(class'RAmmoShell',,, loc, rot);
                }

		        foreach AllActors(class'SpawnPoint', SP, 'SpawnPlace2d')
                {
                      loc = SP.Location;
                      rot = SP.Rotation;
                      Spawn(class'RAmmoSabot',,, loc, rot);
                }

			    flags.SetBool('MS_C5Buy_Jackhammer_Spawned', True,, 6);
	      }

	      if (flags.GetBool('MS_C5Buy_Grenades') && !flags.GetBool('MS_C5Buy_Grenades_Spawned'))
	      {
		        foreach AllActors(class'SpawnPoint', SP, 'SpawnPlace3a')
                {
                      loc = SP.Location;
                      rot = SP.Rotation;
                      Spawn(class'WeaponLAMGrenade',,, loc, rot);
                }

		        foreach AllActors(class'SpawnPoint', SP, 'SpawnPlace3b')
                {
                      loc = SP.Location;
                      rot = SP.Rotation;
                      Spawn(class'WeaponLAMGrenade',,, loc, rot);
                }

		        foreach AllActors(class'SpawnPoint', SP, 'SpawnPlace3c')
                {
                      loc = SP.Location;
                      rot = SP.Rotation;
                      Spawn(class'WeaponPulseGrenade',,, loc, rot);
                }

			    flags.SetBool('MS_C5Buy_Grenades_Spawned', True,, 6);
	      }

	      if (flags.GetBool('MS_C5Buy_Ammo') && !flags.GetBool('MS_C5Buy_Ammo_Spawned'))
	      {
		        foreach AllActors(class'SpawnPoint', SP, 'SpawnPlace4a')
                {
                      loc = SP.Location;
                      rot = SP.Rotation;
                      Spawn(class'RAmmo10mmJHP',,, loc, rot);
                }

		        foreach AllActors(class'SpawnPoint', SP, 'SpawnPlace4b')
                {
                      loc = SP.Location;
                      rot = SP.Rotation;
                      Spawn(class'RAmmo3006',,, loc, rot);
                }

		        foreach AllActors(class'SpawnPoint', SP, 'SpawnPlace4c')
                {
                      loc = SP.Location;
                      rot = SP.Rotation;
                      Spawn(class'RAmmo10mmJHP',,, loc, rot);
                }

			    flags.SetBool('MS_C5Buy_Ammo_Spawned', True,, 6);
	      }
	}

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

	if (localURL == "05_MOSCOW_BANDITS")
	{
        //��������� ����, ���� ����� �������� ������� ����
		if (!flags.GetBool('MS_C4BanditsLeaderKilled') && !flags.GetBool('MS_C4BanditsLeaved'))
		{
			count = 0;
			foreach AllActors(class'Evgeny', evg)
				count++;

			if (count == 0)
			{
				flags.SetBool('MS_C4BanditsLeaderKilled', True,, 7);
			}
		}

        //��������� ����, ���� ����� ����
		if (!flags.GetBool('MS_C4BanditBorisKilled'))
		{
			count = 0;
			foreach AllActors(class'Boris', bor)
				count++;

			if (count == 0)
			{
				flags.SetBool('MS_C4BanditBorisKilled', True,, 7);
			}
		}

        //���� ����� ���� ����� ���� �� ������ �������, �� ������ �������� ����������...
		if (!flags.GetBool('MS_C4BanditKilled') && !flags.GetBool('MS_C4BanditsLeaved'))
		{
			count = 0;

			foreach AllActors(class'Bandit', B1)
					count++;

			foreach AllActors(class'Bandit2', B2)
					count++;

			if (count <= 2)
				flags.SetBool('MS_C4BanditKilled', True,, 6);
		}

        //��������� ������� ��������
		if (flags.GetBool('MS_C4BanditKilled') || flags.GetBool('MS_C4BanditsLeaderKilled') || flags.GetBool('MS_C4BanditBorisKilled'))
		{
			flags.SetBool('MS_Global_BanditsRage', True,, 7);
		}

		//Check if lockers are hacked
		if(!flags.GetBool('MS_Global_BanditsRage'))
		{
			count = 0;
			
			foreach AllActors(class'DeusExMover', M)
			{
				if(M.Tag == 'Locker' || M.Tag == 'Locker2')
				{
					count++;
					
					if(M.lockStrength < 0.4 || M.doorStrength < 0.5)
					{
						flags.SetBool('MS_Global_BanditsRage', True,, 7);
						break;
					}
				}	
			}
			
			if(count < 2) flags.SetBool('MS_Global_BanditsRage', True,, 7);
		}

        //����������� ������ ��������
		if (flags.GetBool('MS_Global_BanditsRage') && !flags.GetBool('MS_C5BanditsAllianceChanged'))
		{
            foreach AllActors(class'AllianceTrigger', ATrig, 'SetBanditsHateYou')
		    	ATrig.Trigger(None, None);

			flags.SetBool('MS_C5BanditsAllianceChanged', True,, 6);
		}
	}
	
	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

	if (localURL == "05_MOSCOW_HOME")
	{
	   if(flags.GetBool('Global_ItalianMad') && !flags.GetBool('MS_Global_ItalianDead') && !flags.GetBool('MS_C5_ItalianAdded'))
	   {
	   		if(!flags.GetBool('MS_Global_OlegKilled'))
	   		{
		   		foreach AllActors(class'ScriptedPawn', pawn, 'OlegPavlov')
				{
					pawn.Health = 1;
					pawn.TakeDamage(150, pawn, pawn.Location, vect(0,0,0), 'Shot');
				}
	   		}
                 
            flags.SetBool('MS_C5_ItalianAdded', True,, 6);
	   }
    }
    
    //------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

	if (localURL == "05_MOSCOW_VLADIMIR")
	{
    	//Play datalink at startup
		if (!flags.GetBool('MS_C5MoscowStartUpPlayed') && flags.GetBool('C5TalkedToVladimir'))
		{
		    Player.StartDataLinkTransmission("DL_MoscowStartUp");
		    
		    if(flags.GetBool('MS_Global_Amrita_Complete'))
		    	Player.GoalFailed('MeetOmars');
		    
	        flags.SetBool('MS_C5MoscowStartUpPlayed', True,, 6);
        }
        
        //Check if Vladimir is dead
		if (!flags.GetBool('MS_Global_VladimirDead'))
		{
		    foreach AllActors(class'VladimirGrigoryevCarcass', vladcarc)
		    {
				flags.SetBool('MS_Global_VladimirDead', True,, 7);
				flags.SetBool('MS_C5_VladimirDead', True,, 7);
				Player.StartDataLinkTransmission("DL_VladimirKilled");
				break;	
		    }
		}
	}
	
	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

	if (localURL == "05_MOSCOW_CAFE")
	{
		//Check if bots are destroyed
		if (!flags.GetBool('MS_C5CafeBotsDestroyed'))
		{
			count = 0;
			
			foreach AllActors(class'Robot', robot, 'Spider')
			{
				if(robot.EMPHitPoints > 0)
					count++;
			}
				
			if(count == 0)
			{
				flags.SetBool('MS_C5CafeBotsDestroyed', True,, 6);
				
				foreach AllActors(class'Dispatcher', disp, 'TaskComplete')
			    	disp.Trigger(None, None);
			}
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
function FirstFrame()
{
    local Boris bor;
    local Evgeny evg;
    local Bandit B1;
    local Bandit2 B2;
	local DeusExMover MVR;
    local VladimirGrigoryev VG;
	local Dispatcher disp;
	local Trigger trig;
    local BumMale BM;
	local RussianArmy RA;
	local RussianArmy_2 RA2;
	local RussianMilitia RM;
	local GuardBot gbot;
	local CombatBot cbot;
    local ScriptedPawn pawn;
	local MilitaryHelicopter mchopper;
	local GuardBot bot;
	local int count;
	local Actor actor;
	local MapExit exit;
	local Actor a;
	local Robot robot;
	local ComputerPublic compPublic;

	Super.FirstFrame();

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

	if (localURL == "05_NORTHLABS_ENTRANCE")
	{
	   xanderTimer = Level.TimeSeconds;

	   flags.SetBool('MS_C5StartUp', True,, 6);

		if (!flags.GetBool('MS_C5Ambush1Appeared'))
		{
		    foreach AllActors(class'Robot', robot, 'DefenceBots')
			   robot.LeaveWorld();

		    foreach AllActors(class'RussianArmy', RA, 'DefenceTroopers')
			   RA.LeaveWorld();
        }

        //������� ����� ������ ����� ��������� ���� �������
        if (flags.GetBool('C5TitanRouterOpen') && flags.GetBool('C5TitanInfoUploaded'))
		{
				foreach AllActors(class'DeusExMover', MVR)
				{
					if (MVR.Tag == 'YourTrainDoor')
					{
                        MVR.bHighlight = True;
                        MVR.bFrobbable = True;
						MVR.Trigger(None, None);
                    }
                }

                //����������� ���� ���������
                foreach AllActors(class'Dispatcher', disp, 'TrainLightsTrigger')
		           disp.Trigger(None, None);
        }

        //������� ������������ ����� ���������� �������
		if (flags.GetBool('C5TitanRouterOpen') && flags.GetBool('C5TitanInfoUploaded'))
		{
		    foreach AllActors(class'RussianArmy', RA, 'DefenceTroopers')
			   RA.EnterWorld();
        }

	    //Not met Vlad, so we know Omars
	    //Default: Go to Moscow (metro)
		if(!flags.GetBool('MS_Global_VladimirComplete'))
		{
			foreach AllActors(class'MapExit', exit, 'HelicopterMapExit')
	    	{
	    		exit.DestMap = "05_Moscow_Metro";
	    		exit.LoadScreen = ES_Moscow_Metro;
	    		break;
	    	}		    	
	    	DeusExPlayer(GetPlayerPawn()).GetLevelInfo().NextMapName = "05_Moscow_Metro";
	    	DeusExPlayer(GetPlayerPawn()).GetLevelInfo().NextMapScreen = "MS_Metro";
		}
		//Met Vlad...
		else
	    {
	    	//...and he is NOT dead
	    	//Go to Moscow (Vladimir)
	    	if(!flags.GetBool('MS_Global_VladimirDead'))
	    	{
		    	foreach AllActors(class'MapExit', exit, 'HelicopterMapExit')
		    	{
		    		exit.DestMap = "05_Moscow_Vladimir";
		    		exit.LoadScreen = ES_Moscow_Vladimir;
		    		break;
		    	}	    	
		    	DeusExPlayer(GetPlayerPawn()).GetLevelInfo().NextMapName = "05_Moscow_Vladimir";
		    	DeusExPlayer(GetPlayerPawn()).GetLevelInfo().NextMapScreen = "MS_Vladimir";
	    	}
	    	//...and he IS dead
	    	else
	    	{
	    		//Omar are waiting for us?
	    		//Go to Moscow (metro)
	    		if(flags.GetBool('MS_Global_Amrita_Complete'))
	    		{
	    			foreach AllActors(class'MapExit', exit, 'HelicopterMapExit')
			    	{
			    		exit.DestMap = "05_Moscow_Metro";
			    		exit.LoadScreen = ES_Moscow_Metro;
			    		break;
			    	}		    	
			    	DeusExPlayer(GetPlayerPawn()).GetLevelInfo().NextMapName = "05_Moscow_Metro";
			    	DeusExPlayer(GetPlayerPawn()).GetLevelInfo().NextMapScreen = "MS_Metro";
	    		}
	    		//No, Vlad is dead and Omars are destroyed
	    		//Just go to Mt.Weather alone
	    		else
	    		{
	    			foreach AllActors(class'MapExit', exit, 'HelicopterMapExit')
			    	{
			    		exit.DestMap = "06_MtWeather_Entrance";
			    		exit.LoadScreen = ES_MtWeather_Entrance;
			    		break;
			    	}		    	
			    	DeusExPlayer(GetPlayerPawn()).GetLevelInfo().NextMapName = "06_MtWeather_Entrance";
			    	DeusExPlayer(GetPlayerPawn()).GetLevelInfo().NextMapScreen = "MT_Entrance";
	    		}
	    	}
	    }
    }

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

	if (localURL == "05_NORTHLABS_MAINCOMPLEX")
	{

		if (!flags.GetBool('MS_C5Ambush2Appeared'))
		{
		    //foreach AllActors(class'ScriptedPawn', pawn, 'ElevatorBot')
			//   pawn.LeaveWorld();
			   
		    foreach AllActors(class'ScriptedPawn', pawn, 'DefenceTroopers')
			   pawn.LeaveWorld();
        }

        //�������� ����� ����� ������� � �������
        if (flags.GetBool('MS_C5TitanConvoPlayed'))
		{
		   Player.StartDataLinkTransmission("DL_TitansTask");
		   Player.GoalCompleted('TalkToTitan');

           //��������� ������� ��������
		   foreach AllActors(class'Trigger', trig, 'TitanConvoTrigger')
			   trig.SetCollision(False);
        }
    }

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

	if (localURL == "05_NORTHLABS_TRAINSTATION")
	{
		if (!flags.GetBool('MS_C5TrainAmbushAppeared'))
		{
		    foreach AllActors(class'RussianArmy', RA, 'BSSoldier')
			   RA.LeaveWorld();
		    foreach AllActors(class'RussianArmy_2', RA2, 'BSSoldier')
			   RA2.LeaveWorld();
        }

		Player.StartDataLinkTransmission("DL_AboutWeather");
    }

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

	if (localURL == "05_MOSCOW_CAFE")
	{
        //Remove thug
        if(flags.GetBool('MS_C4_ChineseThug_Dead'))
        {
        	foreach AllActors(class'ScriptedPawn', pawn, 'ChineseThug')
				pawn.LeaveWorld();
        }
	}

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

	if (localURL == "05_MOSCOW_METRO")
	{
		//Remove datacube with alien
        if(!flags.GetBool('MS_C4_Nikolay_Appears'))
        {
        	foreach AllActors(class'Actor', a, 'AlienKpk')
        		a.bHidden = True;
        		
        	foreach AllActors(class'Actor', a, 'AlienPhoto')
        		a.bHidden = True;
        }
        
        if (!flags.GetBool('MS_Global_Amrita_Complete'))
		{
			foreach AllActors(class'ComputerPublic', compPublic)
			{
				compPublic.bulletinTag = '5_BulletinMenu2';
			}
			
			//Remove bonuses in case Omars are dead
			foreach AllActors(class'Actor', a, 'OmarBonus')
			{
            	a.Destroy();
			}
		}
		else
		{
			//Remove preys if Omars have won
			foreach AllActors(class'Actor', a, 'Prey')
			{
            	a.Destroy();
			}
		}
		
		if(flags.GetBool('MS_Global_Amrita_Complete') || flags.GetBool('MS_C4_JanitorDead'))
		{
			foreach AllActors(class'Actor', a, 'Janitor')
			{
            	a.Destroy();
			}
		}
	}

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

	if (localURL == "05_MOSCOW_STREETS")
	{
		//Count police troops
		if (!flags.GetBool('MS_C5TroopsCounted'))
		{
		    count = 0;

		    foreach AllActors(class'CombatBot', cbot)
				count++;

		    foreach AllActors(class'RussianMilitia', RM)
				count++;

                    TroopsCount = count;

		    flags.SetBool('MS_C5TroopsCounted', True,, 6);
        }
        
        //Remove Nikolay
        if(!flags.GetBool('MS_C4_Nikolay_Appears'))
        {
        	foreach AllActors(class'ScriptedPawn', pawn, 'Nikolay')
				pawn.LeaveWorld();
        }
        
        //Hide mechs
		if (!flags.GetBool('MS_C5AmbushMechsHidden'))
		{
			foreach AllActors(class'ScriptedPawn', pawn, 'BolshevikAmbushWarrior')
				pawn.LeaveWorld();
				
			foreach AllActors(class'ScriptedPawn', pawn, 'BolshevikTankWarrior')
				pawn.LeaveWorld();

			flags.SetBool('MS_C5AmbushMechsHidden', True,, 6);
		}
        
		//Damage bot if mechs are storming the streets
		if (flags.GetBool('MS_Global_Amrita_Complete') && !flags.GetBool('MS_C5GarageBotDamaged'))
		{
			foreach AllActors(class'GuardBot', bot, 'GarageBot')
			{
				bot.Health = 25;
				bot.TakeDamage(10, bot, bot.Location, vect(0,0,0), 'Shot');
			}
			
			//And remove civilians
			/*foreach AllActors(class'ScriptedPawn', pawn, 'Janitor')
				pawn.LeaveWorld();
				
			foreach AllActors(class'ScriptedPawn', pawn, 'MiddleClass')
				pawn.LeaveWorld();*/
			
			flags.SetBool('MS_C5GarageBotDamaged', True,, 6);
		}
		
		//Change the outro map
		if (!flags.GetBool('MS_Global_Amrita_Complete') && !flags.GetBool('MS_C5OutroChanged'))
		{
	    	foreach AllActors(class'MapExit', exit, 'OutroEntity')
	    	{
	    		exit.DestMap = "06_MtWeather_Entrance";
	    		exit.LoadScreen = ES_MtWeather_Entrance;
	    		break;
	    	}
    
			flags.SetBool('MS_C5OutroChanged', True,, 6);
		}
	}

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

	if (localURL == "05_MOSCOW_BANDITS")
	{
	    flags.SetBool('MS_C5FarAway', True,, 6);

        //Remove the smugglers
		if ((flags.GetBool('MS_Global_BanditsRage') && flags.GetBool('MS_C4_KilledBanditBefore')) || flags.GetBool('MS_C4BanditsLeaderDead') || flags.GetBool('MS_C4BanditsLeaderKilled') || !flags.GetBool('C4_Bandits_Complete'))
		{
			foreach AllActors(class'ScriptedPawn', pawn)
				pawn.Destroy();
				
			foreach AllActors(class'Actor', actor, 'M4FromBoris')
				actor.Destroy();
				
			flags.SetBool('MS_Global_BanditsRage', True,, 7);
		}

        //Remove the Boris
		if (!flags.GetBool('MS_Global_BanditsRage') && !flags.GetBool('MS_C5_BanditsCleared'))
		{
			if(flags.GetBool('MS_C4BanditBorisKilled') || flags.GetBool('MS_C4BanditBorisDead'))
			{
		  	      foreach AllActors(class'Boris', bor)
				      bor.LeaveWorld();
				      
				  foreach AllActors(class'Actor', actor, 'M4FromBoris')
					  actor.Destroy();
			}

	        flags.SetBool('MS_C5_BanditsCleared', True,, 6);
		}
	}

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

	if (localURL == "05_MOSCOW_VLADIMIR")
	{
		if (!flags.GetBool('MS_C5VladimirLeaved') && flags.GetBool('MS_C5FarAway'))
		{
            foreach AllActors(class'VladimirGrigoryev', VG)
                 VG.LeaveWorld();

			flags.SetBool('MS_C5VladimirLeaved', True,, 6);
		}
    }

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

	if (localURL == "05_MOSCOW_HOME")
	{
	   flags.SetBool('MS_C5FarAway', True,, 6);
	   
	   if (flags.GetBool('MS_Global_OlegKilled'))
	   {
	   		 foreach AllActors(class'ScriptedPawn', pawn, 'OlegPavlov')
                 pawn.LeaveWorld();
	   }
	   
	   if(!flags.GetBool('Global_ItalianMad') || flags.GetBool('MS_Global_ItalianDead'))
	   {
	   		foreach AllActors(class'ScriptedPawn', pawn, 'Italian')
                 pawn.LeaveWorld();
	   }
    }
}

defaultproperties
{
	bAutosave=True
	AutosaveName="North labs"
}