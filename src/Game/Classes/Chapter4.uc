class Chapter4 expands MissionScript;

var float xanderTimer;
var int BanditsCount;

var localized string RedOmarName;

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

function FirstFrame()
{
    local Robot bot;
    local Minidisk md;
	local Keypad2 pad2;
    local ScriptedPawn pawn;
	local MilitaryHelicopter mchopper;
	local Trigger trig;
	local RussianArmy RA;
	local DeusExMover M;
    local TruePlayer tplayer;
    local Actor a;

	Super.FirstFrame();

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

	//Send datalink from the saved Omar
	if(flags.GetBool('MS_Global_RedOmarSaved'))
	{
		Player.StartDataLinkTransmission("DL_OmarHelped");
	}

    if (localURL == "04_MOSCOW_STREETS")
	{
	    xanderTimer = Level.TimeSeconds;

	    flags.SetBool('MS_MoscowStartUp', True,, 6);

        //Spawn the MJ12 troops
		if (!flags.GetBool('MS_C4AmbushReady') && !flags.GetBool('MS_C4_AmbushHidden'))
		{
		        foreach AllActors(class'Robot', bot, 'AmbushBot')
			      bot.LeaveWorld();

		        foreach AllActors(class'ScriptedPawn', pawn, 'AmbushTroop')
			      pawn.LeaveWorld();

		        foreach AllActors(class'ScriptedPawn', pawn, 'AmbushCamoTroop')
			      pawn.LeaveWorld();

		        foreach AllActors(class'ScriptedPawn', pawn, 'AmbushMIB')
			      pawn.LeaveWorld();

		        foreach AllActors(class'ScriptedPawn', pawn, 'DummyDanielTarget')
			      pawn.LeaveWorld();
				
				foreach AllActors(class'Actor', a, 'BanditsDoorCrate')
				{
					a.bHidden = True;
					a.bDetectable = False;	
					a.SetCollision(false, false, false);
					a.bCollideWorld = false;
					a.SetPhysics(PHYS_None);
				}

	              flags.SetBool('MS_C4_AmbushHidden', True,, 5);
		}

        //Spawn bot at the garage
		if (!flags.GetBool('C4GaragePlayed') && !flags.GetBool('MS_C4_BotHidden'))
		{
		     foreach AllActors(class'Robot', bot, 'GarageAmbush')
			      bot.LeaveWorld();

	         flags.SetBool('MS_C4_BotHidden', True,, 5);
		}
    }

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

    if (localURL == "04_MOSCOW_VLADIMIR")
	{
		//Complete both goals if we have talked to Vladimir
		if (!flags.GetBool('MS_C4TalkedToVladimir'))
		{
	          flags.SetBool('MS_C4TalkedToVladimir', True,, 5);
		      Player.GoalCompleted('FindVladimir');
		      Player.GoalCompleted('FindTitan');
        }

		//Xander is waiting
		if (!flags.GetBool('MS_C4AmbushReady') && !flags.GetBool('MS_C4XanderPlaced'))
		{
			flags.SetBool('MS_C4Xander_OutOfTheCity', True,, 5);
	        flags.SetBool('MS_C4XanderPlaced', True,, 5);
        }
	}

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

    if (localURL == "04_MOSCOW_CAFE")
	{
		if (!flags.GetBool('C4OlegPlayed') && flags.GetBool('C4_DanielFoundVladimir'))
		{
	    	flags.SetBool('MS_C4Oleg_Late', True,, 5);
        }
	}

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

    if (localURL == "04_MOSCOW_BANDITS")
	{
		//Smugglers returns to the hideout after the garage mission
		if (flags.GetBool('C4_FinalInGaragePlayed') && !flags.GetBool('MS_C4_BanditsReturned'))
		{
	    	flags.SetBool('MS_C4_BanditsReturned', True,, 5);
        }
	}

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

    if (localURL == "04_MOSCOW_GARAGE")
	{
        //Remove soldiers before the attack
		if (!flags.GetBool('C4_UnhideFirstSquad') && !flags.GetBool('MS_C4_SquadsHidden'))
		{
		      foreach AllActors(class'RussianArmy', RA)
			       RA.LeaveWorld();

	          flags.SetBool('MS_C4_SquadsHidden', True,, 5);
        }

        //Kill all smugglers if player has left the garage during the battle
		if (flags.GetBool('MS_C4_DanielLeavedGarage') && !flags.GetBool('MS_C4_Garage_Completed'))
		{
			foreach AllActors(class'ScriptedPawn', pawn)
			{
				if (pawn.BindName != "RussianSWAT")
                {
					pawn.HealthHead = 0;
					pawn.Health = 0;
					pawn.TakeDamage(10, pawn, pawn.Location, vect(0,0,0), 'Shot');
                }
			}
		}

		//Delete all smugglers if they are angry
		if (flags.GetBool('MS_Global_BanditsRage'))
		{
			foreach AllActors(class'ScriptedPawn', pawn)
			{
				if (pawn.BindName != "RussianSWAT")
					pawn.LeaveWorld();
			}
		}

		//Change the music
		if(flags.GetBool('C4_GarageMusicNormal'))
		{
			Player.ClientSetMusic(Level.Song, 0, 0, MTRAN_FastFade);
		}
		else if(flags.GetBool('C4_GarageMusicCombat'))
		{
			Player.ClientSetMusic(Level.Song, 3, 0, MTRAN_FastFade);
		}		
	}

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

    if (localURL == "04_MOSCOW_RAILWAYSTATION")
	{
		flags.SetBool('C4_TraveledToStation', True,, 5);
	}

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

	if (localURL == "04_MOSCOW_CLUB")
	{
		if (!flags.GetBool('C4_Nikolay_Helped') || flags.GetBool('MS_C4_Nikolay_Killed'))
		{
		        foreach AllActors(class'ScriptedPawn', pawn, 'Nikolay')
			      pawn.LeaveWorld();
        }

		if (flags.GetBool('MS_C4_ClubMale_Killed') && !flags.GetBool('MS_C4_ClubMale_Deleted'))
		{
		        foreach AllActors(class'ScriptedPawn', pawn, 'ClubMale')
			      pawn.LeaveWorld();

		        //foreach AllActors(class'ScriptedPawn', pawn, 'ClubThugKiller')
			//      pawn.LeaveWorld();

	              flags.SetBool('MS_C4_ClubMale_Deleted', True,, 5);
        }
	}

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

	if (localURL == "04_MOSCOW_METRO")
	{
		//Hide Magnus
		if(!flags.GetBool('MS_C4_Magnus_Deleted'))
		{
			foreach AllActors(class'ScriptedPawn', pawn, 'MagnusAthers')
				pawn.LeaveWorld();	
				
			flags.SetBool('MS_C4_Magnus_Deleted', True,, 5);
		}
		
		//Hide Omars
		if (!flags.GetBool('MS_C4_Omars_Deleted'))
		{
			foreach AllActors(class'ScriptedPawn', pawn, 'OmarPrisoner')
				pawn.LeaveWorld();
				
			foreach AllActors(class'ScriptedPawn', pawn, 'OmarTrader')
				pawn.LeaveWorld();
				
			flags.SetBool('MS_C4_Omars_Deleted', True,, 5);
		}
	}
	
	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	if (localURL == "04_MOSCOW_ROOFTOP")
	{
		//Delete HH agents
		if (!flags.GetBool('C4_GotAmrita'))
		{
			foreach AllActors(class'ScriptedPawn', pawn, 'BiotechAgents')
				pawn.LeaveWorld();				
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

function PreTravel()
{
    local ScriptedPawn pawn;
    local AttackHelicopter chopper;
	local int count;

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

	if (localURL == "04_MOSCOW_BANDITS")
	{
		if (flags.GetBool('C4_Bandits_Job4Played') && !flags.GetBool('MS_C4_BanditsGoToGarage'))
		{
		        foreach AllActors(class'ScriptedPawn', pawn, 'Evgeny')
			      pawn.LeaveWorld();

		        foreach AllActors(class'ScriptedPawn', pawn, 'Boris')
			      pawn.LeaveWorld();

		        foreach AllActors(class'ScriptedPawn', pawn, 'Bandit')
			      pawn.LeaveWorld();

	            flags.SetBool('MS_C4_BanditsGoToGarage', True,, 6);
		}
	}

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

	if (localURL == "04_MOSCOW_GARAGE")
	{
	    flags.SetBool('MS_C4_DanielLeavedGarage', True,, 5);

		if (flags.GetBool('MS_C4_Garage_Completed') && flags.GetBool('MS_C4_FirstSquadIsDead') && flags.GetBool('MS_C4_SecondSquadIsDead') && !flags.GetBool('MS_C4_BanditsReturned'))
		{
			foreach AllActors(class'ScriptedPawn', pawn)
			{
				if (pawn.BindName != "RussianSWAT")
					pawn.LeaveWorld();
			}

	        flags.SetBool('MS_C4_BanditsReturned', True,, 6);
		}
	}

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

	if (localURL == "04_MOSCOW_PUSHKIN")
	{
		//Heli has landed without us
		if(!flags.GetBool('C4_RoofHeliLanded'))
		{
			flags.SetBool('C4_RoofHeliLanded', True,, 5);
		}
	}

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

	if (localURL == "04_MOSCOW_ROOFTOP")
	{
		//Remove heli
	    if (flags.GetBool('C4_RoofHeliFlyed') && !flags.GetBool('MS_C4_RoofHeliRoofRemoved'))
	    {
	    	foreach AllActors(class'AttackHelicopter', chopper, 'RoofHeli')
				chopper.LeaveWorld();
				
	    	flags.SetBool('MS_C4_RoofHeliRoofRemoved', True,, 5);
	    }
	}

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	if (localURL == "04_MOSCOW_SMUGGLER")
	{
		if (flags.GetBool('C4_Nikolay_Helped') && !flags.GetBool('MS_C4_Nikolay_Leaved') && !flags.GetBool('MS_C4_Nikolay_Killed'))
		{
		     foreach AllActors(class'ScriptedPawn', pawn, 'Nikolay')
			 	pawn.LeaveWorld();

	         flags.SetBool('MS_C4_Nikolay_Leaved', True,, 5);
        }
	}

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
    local Robot bot;
    local Boris bor;
    local Minidisk md;
    local Bandit B1;
    local Bandit2 B2;
    local ScriptedPawn pawn;
	local Trigger trig;
    local Keypad pad;
	local Dispatcher disp;
	local int count;
    local BumMale BM;
    local RussianMilitia RM;
	local RussianArmy RA;
	local DeusExMover M;
    local AllianceTrigger ATrig;
    local OrdersTrigger OTrig;
    local Evgeny evg;
    local EvgenyCarcass evgcarc;
    local TruePlayer tplayer;
    local BorisCarcass borcarc;
	local MilitaryHelicopter mchopper;
	local Thug1Carcass TCarc1;
	local Thug2Carcass TCarc2;
	local Omar1Carcass OmarCarc1;
	local Omar2Carcass OmarCarc2;
	local Thug3Carcass TMCarc;
	local SpawnPoint SP;
	local Vector loc;
	local Rotator rot;
	local bool bBanditFound;
	local Nikolay nik;
	local AttackHelicopter chopper;
	local bool bDoorFound;
	local Omar1Carcass omarCarcass;
	local SecurityCamera camera;
	local RussianMentCarcass mentCarc;
	local BumMale3Carcass bumCarc;
	local OlegPavlovCarcass olegCarc;
	local ChineseThugCarcass chineseThugCarc;
	local Mover mov;
	local Actor a;
	local VladimirGrigoryevCarcass vladcarc;
	local MetroPilotCarcass pilotcarc;
	local MagnusAthersCarcass magnuscarc;

	Super.Timer();

	//Check if all panels has been hacked
	if (
		flags.GetBool('C4_Work_Panel1Hacked') && 
		flags.GetBool('C4_Work_Panel2Hacked') && 
		flags.GetBool('C4_Work_Panel3Hacked') && 
		flags.GetBool('C4_Work_Panel4Hacked') &&
		!flags.GetBool('MS_C4_AllPanelsHacked')
	)
	{		
	    flags.SetBool('MS_C4_AllPanelsHacked', True,, 5);	    
    }
    
    //Check if all panels have been hacked and the satellite is disabled
	if (flags.GetBool('C4_SatelliteDisabled') && flags.GetBool('MS_C4_AllPanelsHacked') && !flags.GetBool('MS_Global_MoscowNetworkDisabled'))
	{
		flags.SetBool('MS_Global_MoscowNetworkDisabled', True,, 7);
		Player.GoalCompleted('OmarJob2');
	}
	
	//If player has talked to Vladimir, he will help us
	if(flags.GetBool('MS_C4TalkedToVladimir') && !flags.GetBool('MS_Global_VladimirComplete'))
	{
		flags.SetBool('MS_Global_VladimirComplete', True,, 7);	
	}
	
	//Play datalink when player can leave the city
	if(localURL == "04_MOSCOW_VLADIMIR" || localURL == "04_MOSCOW_CLUB")
	{
		if((flags.GetBool('MS_Global_Amrita_Complete') || flags.GetBool('MS_Global_VladimirComplete')) && !flags.GetBool('MS_C4_MissionCOmplete'))
		{
			flags.SetBool('MS_C4_MissionCOmplete', True,, 5);
			Player.StartDataLinkTransmission("DL_MissionComplete");
		}	
	}

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

	if(localURL == "04_MOSCOW_VLADIMIR")
	{
		//Check if Vladimir is dead
		if (!flags.GetBool('MS_Global_VladimirDead'))
		{
		    foreach AllActors(class'VladimirGrigoryevCarcass', vladcarc)
		    {
				flags.SetBool('MS_Global_VladimirDead', True,, 7);
				flags.SetBool('MS_C4_VladimirDead', True,, 7);
				Player.StartDataLinkTransmission("DL_VladimirKilled");
				break;	
		    }
		}
	}

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

	if (localURL == "04_MOSCOW_CAFE")
	{
		if (!flags.GetBool('MS_Global_OlegKilled'))
		{
			foreach AllActors(class'OlegPavlovCarcass', olegCarc)
			{
				flags.SetBool('MS_Global_OlegKilled', True,, 7);
				break;
			}
		}
		
		if (!flags.GetBool('MS_C4_ChineseThug_Dead'))
		{
			foreach AllActors(class'ChineseThugCarcass', chineseThugCarc)
			{
				flags.SetBool('MS_C4_ChineseThug_Dead', True,, 6);
				break;
			}
		}
	}

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

	if (localURL == "04_MOSCOW_HOME" || localURL == "04_MOSCOW_CAFE" || localURL == "04_MOSCOW_METRO")
	{		
		//Check if player cannot complete main quest
		if (!flags.GetBool('C4_TrainPilotWillHelp') || !flags.GetBool('C4_KnowAboutPushkin'))
		{
			if(flags.GetBool('MS_Global_BanditsRage') && (flags.GetBool('MS_C4Prison_OmarDead') || flags.GetBool('MS_Global_MetroOmars_Rage')))
			{
				Player.StartDataLinkTransmission("DL_MetroHint");
			}
		}
	}
	
	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

	if (localURL == "04_MOSCOW_STREETS" || localURL == "04_MOSCOW_PUSHKIN")
	{		
		//Check if player cannot complete main quest
		if (!flags.GetBool('MS_C4PlayerUnStucked'))
		{
			if(!flags.GetBool('C4_DanielFoundVladimir') && //Has not found Vladimir
			  (flags.GetBool('MS_Global_BanditsRage') || flags.GetBool('MS_C4BanditsLeaderDead')) && //and is not able to find him anymore
			   flags.GetBool('MS_Global_GaveAmritaToMagnus') //and cannot complete Omars' quest
			)
			{
				Player.StartDataLinkTransmission("DL_XanderStuck");
				flags.SetBool('MS_C4PlayerUnStucked', True,, 6);
			}
		}
	}

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

	if (localURL == "04_MOSCOW_STREETS")
	{
        //������ ������...
        //������ � ������������ ��������
		if (flags.GetBool('MS_MoscowStartUp') && !flags.GetBool('MS_MoscowStartUpPlayed'))
		{
            foreach AllActors(class'Dispatcher', disp, 'MapStartDispatcher')
		           disp.Trigger(None, None);

		    Player.StartDataLinkTransmission("DL_Startup");
	        flags.SetBool('MS_MoscowStartUpPlayed', True,, 5);
        }
////
// ������������ ��������� -------------------------------------
////
		if (!flags.GetBool('MS_C4DestroyFirstHeli'))
		{
		   if ((Level.TimeSeconds - xanderTimer >= 3.5) && !flags.GetBool('MS_C4CloakFirstHeli'))
                   {
		      foreach AllActors(class'MilitaryHelicopter', mchopper)
                      {
				if (mchopper.Tag == 'FirstHelicopter')
			           mchopper.GotoState('ActivateCamo');
                      }
	               flags.SetBool('MS_C4CloakFirstHeli', True,, 5);
                   }


		   if ((Level.TimeSeconds - xanderTimer >= 9.0) && flags.GetBool('MS_C4CloakFirstHeli') && !flags.GetBool('MS_C4DestroyFirstHeli'))
           {
		      foreach AllActors(class'MilitaryHelicopter', mchopper)
              {
			  		if (mchopper.Tag == 'FirstHelicopter')
			        	mchopper.LeaveWorld();
              }
              
	          flags.SetBool('MS_C4DestroyFirstHeli', True,, 5);
           }
		}
////
//-------------------------------------------------------------
////

        if (!flags.GetBool('C4GaragePlayed') && flags.GetBool('MS_C4_BanditsGoToGarage') && !flags.GetBool('MS_C4GarageDoorsOpened'))
		{
			foreach AllActors(class'DeusExMover', M, 'ExitDoor2')
            	M.bLocked = False;

			flags.SetBool('MS_C4GarageDoorsOpened', True,, 5);
        }

        if (!flags.GetBool('C4GaragePlayed') && flags.GetBool('MS_Global_BanditsRage'))
		{
			foreach AllActors(class'DeusExMover', M, 'ExitDoor2')
                M.bLocked = True;
        }

        //When player found Vladimir, turn on the cutscene trigger and unlock the door
		if (flags.GetBool('C4_DanielFoundVladimir') && !flags.GetBool('MS_C4VladimirAvailable'))
		{
			foreach AllActors(class'Trigger', trig, 'VladimirCutSceneTrigger')
				trig.SetCollision(True);
				
			foreach AllActors(class'DeusExMover', M, 'VladimirApartaments')
			{
				M.bHighlight = True;
				M.bFrobbable = True;
            }

	        flags.SetBool('MS_C4VladimirAvailable', True,, 5);
		}

        //Start the MJ12 ambush
		if (flags.GetBool('MS_C4VladimirPlayed') && !flags.GetBool('MS_C4AmbushReady'))
		{
			Player.StartDataLinkTransmission("DL_PreAmbush");

			foreach AllActors(class'Trigger', trig, 'AmbushBotsAITrig')
				trig.SetCollision(True);

		    foreach AllActors(class'Robot', bot, 'AmbushBot')
		    {
			    bot.EnterWorld();
			    bot.KillShadow();
		    }

		    foreach AllActors(class'ScriptedPawn', pawn, 'AmbushTroop')
			    pawn.EnterWorld();

		    foreach AllActors(class'ScriptedPawn', pawn, 'AmbushCamoTroop')
		    {
			    pawn.EnterWorld();
			    pawn.KillShadow();
		    }

		    foreach AllActors(class'ScriptedPawn', pawn, 'AmbushMIB')
			    pawn.EnterWorld();

		    foreach AllActors(class'ScriptedPawn', pawn, 'DummyDanielTarget')
			    pawn.EnterWorld();

			foreach AllActors(class'Actor', a, 'BanditsDoorCrate')
			{
				a.bHidden = False;
				a.bDetectable = True;
				a.SetCollision(True, True, True);
				a.bCollideWorld = True;
				a.SetPhysics(PHYS_Falling);
			}

	        flags.SetBool('MS_C4AmbushReady', True,, 5);
		}

        //Remove the camo from the troops after player talked to MIB
		if ((flags.GetBool('MS_C4AmbushReady')) && (flags.GetBool('MS_C4MIBPlayed')) && !flags.GetBool('MS_C4MIBPlayed2'))
		{
			foreach AllActors(class'ScriptedPawn', pawn, 'AmbushBot')
				pawn.EnableCloak(False);

			//foreach AllActors(class'ScriptedPawn', pawn, 'AmbushBot')
			//	pawn.EnableCloak(False);

			foreach AllActors(class'ScriptedPawn', pawn, 'AmbushMIB')
				pawn.bInvincible = False;

			foreach AllActors(class'ScriptedPawn', pawn, 'DummyDanielTarget')
				pawn.LeaveWorld();
				
			flags.SetBool('MS_C4MIBPlayed2', True,, 5);
        }
        
        //Check if MIB is dead
		if ((!flags.GetBool('MS_C4AmbushMIBDead')) && (flags.GetBool('MS_C4AmbushReady')))
		{
			count = 0;

			foreach AllActors(class'ScriptedPawn', pawn, 'AmbushMIB')
				count++;

			if (count == 0)
			{
				flags.SetBool('MS_C4AmbushMIBDead', True,, 7);
				
				if(!flags.GetBool('MS_C4MIBPlayed'))
				{
					flags.SetBool('MS_C4MIBPlayed', True,, 5);
					
					foreach AllActors(class'Dispatcher', disp, 'AmbushDispatcher')
		        		disp.Trigger(None, None);
				}
			}
        }

        //Check if all police is dead
		if (!flags.GetBool('MS_C4TroopsKilled'))
		{
			count = 0;
			foreach AllActors(class'RussianMilitia', RM)
				count++;

			if (count <= 0)
			{
				flags.SetBool('MS_C4TroopsKilled', True,, 6);
			}
		}

        //Spawn bot at the garage
		if ((flags.GetBool('C4GaragePlayed')) && (!flags.GetBool('MS_C4NearGarageReady')))
		{
			foreach AllActors(class'Robot', bot, 'GarageAmbush')
				bot.EnterWorld();

			//Remove the garage cutscene trigger
			foreach AllActors(class'Trigger', trig, 'GarageCutScene')
				trig.SetCollision(False);

			flags.SetBool('MS_C4NearGarageReady', True,, 5);
        }

        //Remove the garage cutscene trigger if smugglers are angry
		if (!flags.GetBool('MS_C4GaragePlayed') && flags.GetBool('MS_Global_BanditsRage') && !flags.GetBool('MS_C4GarageDeCollided'))
		{
			foreach AllActors(class'Trigger', trig, 'GarageCutScene')
				trig.SetCollision(False);

				flags.SetBool('MS_C4GarageDeCollided', True,, 5);
		}

        //Check if militarists are angry
		if (!flags.GetBool('MS_C4ThugsRage'))
		{
			count = 0;

			foreach AllActors(class'Thug1Carcass', TCarc1)
			{
				if (TCarc1.KillerBindName == "JCDenton")
					count++;
			}

			foreach AllActors(class'Thug2Carcass', TCarc2)
			{
				if (TCarc1.KillerBindName == "JCDenton")
					count++;
			}

			foreach AllActors(class'Omar1Carcass', OmarCarc1)
			{
				if (OmarCarc1.KillerBindName == "JCDenton")
					count++;
			}

			if (count > 0)
				flags.SetBool('MS_C4ThugsRage', True,, 5);
		}

        //Change the thugs alliance
		if (flags.GetBool('MS_C4ThugsRage') && !flags.GetBool('MS_C4ThugsChanged'))
		{
            foreach AllActors(class'AllianceTrigger', ATrig, 'ChangeThugsAlliance')
		    	ATrig.Trigger(None, None);

            foreach AllActors(class'OrdersTrigger', OTrig, 'SetThugsAttacking')
		    	OTrig.Trigger(None, None);

			flags.SetBool('MS_C4ThugsChanged', True,, 5);
		}

       /// --+==������� ������==+-- \\\

	        if (flags.GetBool('MS_C4Buy_SterylAug') && !flags.GetBool('MS_C4Buy_SterylAug_Spawned'))
	        {
		        foreach AllActors(class'SpawnPoint', SP, 'SpawnPlace1a')
                      Spawn(class'WeaponAutoShotgun',,, SP.Location, SP.Rotation);

		        foreach AllActors(class'SpawnPoint', SP, 'SpawnPlace1b')
                      Spawn(class'RAmmoSabot',,, SP.Location, SP.Rotation);

		        foreach AllActors(class'SpawnPoint', SP, 'SpawnPlace1c')
                      Spawn(class'RAmmoSabot',,, SP.Location, SP.Rotation);

				flags.SetBool('MS_C4Buy_SterylAug_Spawned', True,, 5);
	        }

	        if (flags.GetBool('MS_C4Buy_ColtCommando') && !flags.GetBool('MS_C4Buy_ColtCommando_Spawned'))
	        {
		        foreach AllActors(class'SpawnPoint', SP, 'SpawnPlace2a')
                      Spawn(class'WeaponAK74',,, SP.Location, SP.Rotation);

		        foreach AllActors(class'SpawnPoint', SP, 'SpawnPlace2b')
                      Spawn(class'RAmmo762mm',,, SP.Location, SP.Rotation);

		        foreach AllActors(class'SpawnPoint', SP, 'SpawnPlace2c')
                      Spawn(class'RAmmo762mm',,, SP.Location, SP.Rotation);

				flags.SetBool('MS_C4Buy_ColtCommando_Spawned', True,, 5);
	        }

	        if (flags.GetBool('MS_C4Buy_LAMs') && !flags.GetBool('MS_C4Buy_LAMs_Spawned'))
	        {
		        foreach AllActors(class'SpawnPoint', SP, 'SpawnPlace3a')
                      Spawn(class'WeaponLAMGrenade',,, SP.Location, SP.Rotation);

		        foreach AllActors(class'SpawnPoint', SP, 'SpawnPlace3b')
                      Spawn(class'WeaponLAMGrenade',,, SP.Location, SP.Rotation);

		        foreach AllActors(class'SpawnPoint', SP, 'SpawnPlace3c')
                      Spawn(class'WeaponLAMGrenade',,, SP.Location, SP.Rotation);

				flags.SetBool('MS_C4Buy_LAMs_Spawned', True,, 5);
	        }

	        if (flags.GetBool('MS_C4Buy_Grenades') && !flags.GetBool('MS_C4Buy_Grenades_Spawned'))
	        {
		        foreach AllActors(class'SpawnPoint', SP, 'SpawnPlace4a')
                	Spawn(class'WeaponPulseGrenade',,, SP.Location, SP.Rotation);

		        foreach AllActors(class'SpawnPoint', SP, 'SpawnPlace4b')
                    Spawn(class'WeaponRadioGrenade',,, SP.Location, SP.Rotation);

				flags.SetBool('MS_C4Buy_Grenades_Spawned', True,, 5);
	        }
	        
	        
	        //--------------------------------------------------------------------------------------------------------
	        // Omar's prison break	        
	        
	        //Check Omar's prison door
	        if (!flags.GetBool('MS_C4Prison_Opened') && !flags.GetBool('MS_C4Prison_OmarDead'))
	        {
	        	bDoorFound = false;
	        	
	        	foreach AllActors(class'DeusExMover', M, 'PrisonDoor')
				{
					if(M.bLocked)
					{
						bDoorFound = true;
						break;
					}
					else
					{
						M.bIsDoor = true;
					}
				}
				
				if(!bDoorFound)
				{
					flags.SetBool('MS_C4Prison_Opened', True,, 5);
				}
	        }
	        
	        //If it has been opened or destroyed, start the prison break
	        if(flags.GetBool('MS_C4Prison_Opened') && !flags.GetBool('MS_C4Prison_Started'))
	        {
	        	//Turn on the cloak
	        	foreach AllActors(class'ScriptedPawn', pawn, 'OmarPrisoner')
				{
					pawn.CloakThreshold = 9000;
				}
				
				foreach AllActors(class'Dispatcher', disp, 'PrisonBreakDispatcher')
		        	disp.Trigger(None, None);
				
				flags.SetBool('MS_C4Prison_Started', True,, 5);
	        }
	        
	        //Omar's camo has no energy
	        if(flags.GetBool('C4_Prison_CamoOff') && !flags.GetBool('MS_C4Prison_OmarLeaved') && !flags.GetBool('MS_C4Prison_OmarDead'))
	        {
	        	foreach AllActors(class'ScriptedPawn', pawn, 'OmarPrisoner')
				{
					pawn.CloakThreshold = 0;
				}
	        }
	        
	        //Check if Omar is dead or had leaved the map
	        if(!flags.GetBool('MS_C4Prison_OmarLeaved') && !flags.GetBool('MS_C4Prison_OmarDead'))
	        {
	        	count = 0;
	        	
				foreach AllActors(class'ScriptedPawn', pawn, 'OmarPrisoner')
					count++;
	
				if (count == 0)
				{
					foreach AllActors(class'Omar1Carcass', omarCarcass)
					{
						flags.SetBool('MS_C4Prison_OmarDead', True,, 5);
						break;
					}
					
					if(!flags.GetBool('MS_C4Prison_OmarDead'))
					{
						flags.SetBool('MS_C4Prison_OmarLeaved', True,, 5);
					}
				}
	        }

	        //Player has helper Omar
	        if(flags.GetBool('C4_Prison_Complete') && flags.GetBool('MS_C4Prison_OmarLeaved') && !flags.GetBool('MS_Global_RedOmarSaved'))
	        {
	        	flags.SetBool('MS_Global_RedOmarSaved', True,, 7);
	        	Player.GoalCompleted('OmarJob1');
	        	Player.StartDataLinkTransmission("DL_OmarHelped");
	        }
	        
	        //Player has helper Omar or Omar is dead
	        if((flags.GetBool('MS_Global_RedOmarSaved') || flags.GetBool('MS_C4Prison_OmarDead')) && !flags.GetBool('MS_C4Prison_OmarFinished'))
	        {
	        	flags.SetBool('MS_C4Prison_OmarFinished', True,, 5);
	        }
	        
	        //--------------------------------------------------------------------------------------------------------
	        // Ment
	        
	        //Check if player killed ment
	        if (!flags.GetBool('MS_Global_Ment_Killed'))
			{
				foreach AllActors(class'RussianMentCarcass', mentCarc)
				{
					Player.GoalCompleted('Job_KillMent');
					Player.SkillPointsAdd(300);
					flags.SetBool('MS_Global_Ment_Killed', True,, 7);
					break;
				}
			}
			
			//--------------------------------------------------------------------------------------------------------
	        // Bum
	        
	        //Check if player killed bum
	        if (!flags.GetBool('MS_C4YardBum_Killed'))
			{
				foreach AllActors(class'BumMale3Carcass', bumCarc)
				{
					flags.SetBool('MS_C4YardBum_Killed', True,, 7);
				}
			}
	}

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

	if (localURL == "04_MOSCOW_BANDITS")
	{
        //Check if player has killed Evgeny...
		if (!flags.GetBool('MS_C4BanditsLeaderKilled') && !flags.GetBool('MS_C4BanditsLeaderDead') && !flags.GetBool('MS_C4BanditsLeaved'))
		{
			count = 0;
			foreach AllActors(class'Evgeny', evg)
				count++;

			if (count == 0)
			{
				flags.SetBool('MS_C4BanditsLeaderKilled', True,, 7);
			}
		}

        //Check if player has killed Boris...
		if (!flags.GetBool('MS_C4BanditBorisKilled') && !flags.GetBool('MS_C4BanditBorisDead') && !flags.GetBool('MS_C4BanditsLeaved'))
		{
			count = 0;
			foreach AllActors(class'Boris', bor)
				count++;

			if (count == 0)
			{
				flags.SetBool('MS_C4BanditBorisKilled', True,, 7);
			}
		}

        //Check if player has killed any of the smugglers...
		if (!flags.GetBool('MS_C4BanditKilled') && !flags.GetBool('MS_C4BanditsLeaved'))
		{
			count = 0;

			foreach AllActors(class'Bandit', B1)
					count++;

			foreach AllActors(class'Bandit2', B2)
					count++;

			if (count <= 3)
				flags.SetBool('MS_C4BanditKilled', True,, 6);
		}

        //...and make them RAGE
		if (flags.GetBool('MS_C4BanditKilled') || flags.GetBool('MS_C4BanditsLeaderKilled') || flags.GetBool('MS_C4BanditBorisKilled'))
		{
			flags.SetBool('MS_Global_BanditsRage', True,, 7);
			flags.SetBool('MS_C4_KilledBanditBefore', True,, 6); //Killed before the garage mission
		}

		//Check if lockers are hacked
		if(!flags.GetBool('MS_Global_BanditsRage') && !flags.GetBool('MS_C4_BanditsLockersOpened'))
		{
			count = 0;
			
			foreach AllActors(class'DeusExMover', M)
			{
				if(M.Tag == 'Locker' || M.Tag == 'Locker2')
				{
					count++;
					
					if(M.lockStrength < 0.4 || M.doorStrength < 0.5)
					{
						if(flags.GetBool('MS_C4_BanditsGoToGarage') && !flags.GetBool('MS_C4_BanditsReturned'))
						{
						}
						else
						{
							flags.SetBool('MS_Global_BanditsRage', True,, 7);
						}						
						
						flags.SetBool('MS_C4_BanditsLockersOpened', True,, 6);
						
						break;
					}	
				}
			}
			
			if(count < 2)
			{
				if(flags.GetBool('MS_C4_BanditsGoToGarage') && !flags.GetBool('MS_C4_BanditsReturned'))
				{
				}
				else
				{	
					flags.SetBool('MS_Global_BanditsRage', True,, 7);
				}
				
				flags.SetBool('MS_C4_BanditsLockersOpened', True,, 6);
			}
		}

        //Change their alliance
		if (flags.GetBool('MS_Global_BanditsRage') && !flags.GetBool('MS_C4BanditsAllianceChanged'))
		{
            foreach AllActors(class'AllianceTrigger', ATrig, 'SetBanditsHateYou')
		    	ATrig.Trigger(None, None);

			flags.SetBool('MS_C4BanditsAllianceChanged', True,, 6);
		}

        //Return smugglers after the garage mission
		if (flags.GetBool('MS_C4_BanditsReturned') && !flags.GetBool('MS_C4_ReturnActed'))
		{
			if (!flags.GetBool('MS_C4BanditsLeaderKilled') && !flags.GetBool('MS_C4BanditsLeaderDead'))
			{
		  	      foreach AllActors(class'Evgeny', evg)
				      evg.EnterWorld();
			}

			if (!flags.GetBool('MS_C4BanditBorisKilled') && !flags.GetBool('MS_C4BanditBorisDead') && !flags.GetBool('MS_C4BanditsLeaderKilled') && !flags.GetBool('MS_C4BanditsLeaderDead'))
			{
		  	      foreach AllActors(class'Boris', bor)
				      bor.EnterWorld();
			}

			if (!flags.GetBool('MS_C4BanditsLeaderKilled') && !flags.GetBool('MS_C4BanditsLeaderDead'))
			{
		  	      foreach AllActors(class'Bandit', B1)
				      B1.EnterWorld();
			}

		  	foreach AllActors(class'Bandit2', B2)
				B2.LeaveWorld();

	        flags.SetBool('MS_C4_ReturnActed', True,, 5);
		}
	}

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

    if (localURL == "04_MOSCOW_METRO")
	{
		//Show Omars
		if (flags.GetBool('MS_Global_RedOmarSaved') && !flags.GetBool('MS_C4_Omars_UnDeleted'))
		{
			foreach AllActors(class'ScriptedPawn', pawn, 'OmarPrisoner')
				pawn.EnterWorld();
				
			foreach AllActors(class'ScriptedPawn', pawn, 'OmarTrader')
				pawn.EnterWorld();
			
			foreach AllActors(class'Dispatcher', disp, 'OmarsSpawn')
		    	disp.Trigger(None, None);
		    	
		    foreach AllActors(class'SecurityCamera', camera)	
		    	if(camera.Tag == 'omarCamera1' || camera.Tag == 'omarCamera2' || camera.Tag == 'omarCamera3')
		    		camera.bNoAlarm = true;
		    		
		    flags.SetBool('MS_C4_Omars_UnDeleted', True,, 5);		    	
		}
		
		//Check if player has killed any of them
		if(flags.GetBool('MS_Global_RedOmarSaved'))
		{
			count = 0;
			
			if(!flags.GetBool('MS_Global_KilledOmarPrisoner'))
			{
				foreach AllActors(class'Omar1Carcass', OmarCarc1)
				{
					//if (OmarCarc1.KillerBindName == "JCDenton")	
					//{
						flags.SetBool('MS_Global_KilledOmarPrisoner', True,, 7);		
						count++;
					//}
				}
			}
			
			if(!flags.GetBool('MS_C4_MetroOmars_Rage'))
			{
				foreach AllActors(class'Omar2Carcass', OmarCarc2)
				{
					//if (OmarCarc2.KillerBindName == "JCDenton")
					//{
						count++;
					//}
				}
			}
			
			if(count > 0 && !flags.GetBool('MS_Global_MetroOmars_Rage'))
			{
				flags.SetBool('MS_Global_MetroOmars_Rage', True,, 7);
				
				foreach AllActors(class'Dispatcher', disp, 'OmarsRage')
		    		disp.Trigger(None, None);
			}
		}
		
		//Rename the saved Omar when needed
		if(flags.GetBool('MS_Global_RedOmar_KnowName') && !flags.GetBool('MS_C4_MetroOmar_Renamed'))
		{
			foreach AllActors(class'ScriptedPawn', pawn, 'OmarPrisoner')
			{
				pawn.FamiliarName = RedOmarName;
			}
			
			flags.SetBool('MS_C4_MetroOmar_Renamed', True,, 5);
		}
		
		//Player has the hideout code
		if(flags.GetBool('C4_KnowOmarsMetroCode') && !flags.GetBool('MS_C4_OmarsMetroCodeReady'))
		{
			foreach AllActors(class'Keypad', pad, 'OmarHideoutKeypad')
			{
				pad.bAlwaysWrong = False;
				break;
			}

			flags.SetBool('MS_C4_OmarsMetroCodeReady', True,, 5);
		}
		
		//Player has the armory code
		if(flags.GetBool('C4_GotOmarSafeCode') && !flags.GetBool('MS_C4OmarSafeReady'))
		{
			foreach AllActors(class'Keypad', pad, 'OmarSafeKeypad')
			{
				pad.bAlwaysWrong = False;
			}

			flags.SetBool('MS_C4OmarSafeReady', True,, 5);
		}
		
		//Player has the safe code
		if(flags.GetBool('C4_GotOmarAugCode') && !flags.GetBool('MS_C4OmarAugReady'))
		{
			foreach AllActors(class'Keypad', pad, 'OmarSafeKeypad2')
			{
				pad.bAlwaysWrong = False;
			}

			flags.SetBool('MS_C4OmarAugReady', True,, 5);
		}

		//Add Magnus
		if((flags.GetBool('C4_DanielFoundVladimir') || flags.GetBool('C4_GotAmrita')) && !flags.GetBool('MS_C4MagnusAdded'))
		{
			foreach AllActors(class'ScriptedPawn', pawn, 'MagnusAthers')
				pawn.EnterWorld();
			
			flags.SetBool('MS_C4MagnusAdded', True,, 5);
		}

		//Check if Magnus is dead
		if (!flags.GetBool('MS_Global_MagnusDead') && flags.GetBool('MS_C4MagnusAdded'))
		{
			foreach AllActors(class'MagnusAthersCarcass', magnuscarc)
		    {
		    	flags.SetBool('MS_Global_MagnusDead', True,, 7);
		    	break;
		    }
        }
        
        //Check if janitor is dead
		if (!flags.GetBool('MS_C4_JanitorDead'))
		{
		    foreach AllActors(class'MetroPilotCarcass', pilotcarc)
		    {
				flags.SetBool('MS_C4_JanitorDead', True,, 6);
				break;	
		    }
		}
	}

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

    if (localURL == "04_MOSCOW_GARAGE")
	{
        //Make everyone mortal after the intro cutscene
		if (flags.GetBool('C4GaragePlayed') && !flags.GetBool('MS_C4HackActed'))
		{
		     foreach AllActors(class'ScriptedPawn', pawn)
			      pawn.bInvincible = False;

	         flags.SetBool('MS_C4HackActed', True,, 5);
        }

        //Spawn the first squad
		if (flags.GetBool('C4_FirstAttackStarted') && !flags.GetBool('MS_C4_FirstSquadReady'))
		{
		      foreach AllActors(class'RussianArmy', RA)
              {
					if ((RA.Tag == 'SpecnazGroup1') || (RA.Tag == 'SpecnazGroup2'))
			           RA.EnterWorld();
              }
              
              foreach AllActors(class'SpawnPoint', SP, 'GrenadeSpawn1')
              	 Spawn(class'P_SmokeGrenade',,, SP.Location);
              	 
              foreach AllActors(class'SpawnPoint', SP, 'GrenadeSpawn2')
              	 Spawn(class'P_SmokeGrenade',,, SP.Location);

			  foreach AllActors(class'Trigger', trig, 'FirstAttackTrigger')
				  trig.SetCollision(False);

	          flags.SetBool('MS_C4_FirstSquadReady', True,, 5);
        }
        
        if (flags.GetBool('C4_SecondAttackStarted') && !flags.GetBool('MS_C4_SecondAttackStarted'))
		{
			foreach AllActors(class'Trigger', trig, 'SecondAttackTrigger')
				  trig.SetCollision(False);
				  
			flags.SetBool('MS_C4_SecondAttackStarted', True,, 5);
		}

        //Spawn the second squad
		if (flags.GetBool('C4_UnhideSecondSquad') && !flags.GetBool('MS_C4_SecondSquadReady'))
		{
		      foreach AllActors(class'RussianArmy', RA)
              {
					if ((RA.Tag == 'SpecnazGroup3') || (RA.Tag == 'SpecnazGroup4'))
			           RA.EnterWorld();
              }

	          flags.SetBool('MS_C4_SecondSquadReady', True,, 5);
        }

        //Check if first squad is dead...
		if (!flags.GetBool('MS_C4_FirstSquadIsDead') && flags.GetBool('MS_C4_FirstSquadReady'))
		{
		    count = 0;

		    foreach AllActors(class'RussianArmy', RA, 'SpecnazGroup1')
				count++;

		    foreach AllActors(class'RussianArmy', RA, 'SpecnazGroup2')
				count++;

            if (count == 0)
		        flags.SetBool('MS_C4_FirstSquadIsDead', True,, 5);
        }

        //...and if they are, send smugglers to the 2nd level
        if (flags.GetBool('MS_C4_FirstSquadIsDead') && !flags.GetBool('C4_PrepearingStarted'))
		{
              foreach AllActors(class'Dispatcher', disp, 'Prepearing')
		           disp.Trigger(None, None);
        }

		if (flags.GetBool('C4_PrepearingStarted') && !flags.GetBool('MS_C4_HomeGivingFinished'))
		{
		        foreach AllActors(class'Evgeny', evg, 'Evgeny')
			      evg.HomeTag = 'EvgenyLowerHome';

		        foreach AllActors(class'Boris', bor, 'Boris')
			      bor.HomeTag = 'BorisLowerHome';

		        foreach AllActors(class'Bandit', B1, 'Bandit1')
			      B1.HomeTag = 'Bandit1LowerHome';

		        foreach AllActors(class'Bandit2', B2, 'Bandit2')
			      B2.HomeTag = 'Bandit2LowerHome';

		        foreach AllActors(class'Bandit', B1, 'Bandit3')
			      B1.HomeTag = 'Bandit3LowerHome';

	              flags.SetBool('MS_C4_HomeGivingFinished', True,, 5);
        }
        
        //Spawn the flare
        if (flags.GetBool('C4_GarageSpawnFlare') && !flags.GetBool('MS_C4_GarageFlareSpawned'))
		{
			foreach AllActors(class'SpawnPoint', SP, 'FlareSpawn1')
              	 Spawn(class'P_Flare',,, SP.Location);
              	 
			flags.SetBool('MS_C4_GarageFlareSpawned', True,, 5);
		}

        //Check if second squad is dead...
		if (!flags.GetBool('MS_C4_SecondSquadIsDead') && flags.GetBool('MS_C4_SecondSquadReady'))
		{
		    count = 0;

		    foreach AllActors(class'RussianArmy', RA, 'SpecnazGroup3')
				count++;

		    foreach AllActors(class'RussianArmy', RA, 'SpecnazGroup4')
				count++;

            if (count == 0)
		        flags.SetBool('MS_C4_SecondSquadIsDead', True,, 5);
        }

        //If both squads are dead, mission is complete
		if (flags.GetBool('MS_C4_FirstSquadIsDead') && flags.GetBool('MS_C4_SecondSquadIsDead') && !flags.GetBool('MS_C4_BanditsFlagsFinished'))
		{
   	           flags.SetBool('MS_C4_Garage_Completed', True,, 6);
   	           flags.SetBool('MS_C4_BanditsFlagsFinished', True,, 5);
		}

        //Check if player killed some of the smugglers...
		if ((flags.GetBool('MS_C4BanditsLeaderKilled') || flags.GetBool('MS_C4BanditBorisKilled') || flags.GetBool('MS_C4Bandit_After_SomeoneKilled')) && !flags.GetBool('MS_Global_BanditsRage'))
		{
   	           flags.SetBool('MS_Global_BanditsRage', True,, 7);
		}

        //...and change the alliance
		if (flags.GetBool('MS_Global_BanditsRage') && !flags.GetBool('MS_C4BanditsAllGChgd'))
		{
            foreach AllActors(class'AllianceTrigger', ATrig, 'SetBanditsHateYou')
		       ATrig.Trigger(None, None);

			flags.SetBool('MS_C4BanditsAllGChgd', True,, 5);
		}

        //If Evgeny and Boris are dead, mission is failed (so mark it as complete)
		if ((flags.GetBool('MS_C4BanditsLeaderKilled') || flags.GetBool('MS_C4BanditsLeaderDead')) && (flags.GetBool('MS_C4BanditBorisKilled') || flags.GetBool('MS_C4BanditBorisDead')) && !flags.GetBool('C4_FinalInGaragePlayed') && !flags.GetBool('MS_C4_BanditsFlags2Finished'))
		{
		   Player.GoalFailed('Job_Garage');
   	       flags.SetBool('MS_C4_BanditsFlags2Finished', True,, 5);
		}

        //If mission is complete, make one of the leaders run towards the player...
		if (flags.GetBool('MS_C4_BanditsFlagsFinished') && !flags.GetBool('MS_C4_BanditsGarageFinished') && !flags.GetBool('MS_C4_BanditsFlags2Finished'))
		{
			if (flags.GetBool('MS_C4BanditsLeaderDead') && !flags.GetBool('MS_C4BanditBorisDead'))
			{
           	 	foreach AllActors(class'OrdersTrigger', OTrig, 'BorisRunToDaniel')
    		       OTrig.Trigger(None, None);
			}
             else
			{
           	 	foreach AllActors(class'OrdersTrigger', OTrig, 'EvgenyRunToDaniel')
    		       OTrig.Trigger(None, None);
			}

			flags.SetBool('MS_C4_BanditsGarageFinished', True,, 5);
		}

		//...and if both of them are dead, use one of the alive smugglers
		if (flags.GetBool('MS_C4_BanditsFlagsFinished') && flags.GetBool('MS_C4BanditsLeaderDead') && flags.GetBool('MS_C4BanditBorisDead') && !flags.GetBool('MS_C4_BanditsGarageFinished2'))
		{
			bBanditFound = False;

			foreach AllActors(class'Bandit', B1, 'Bandit1')
			{
               	foreach AllActors(class'OrdersTrigger', OTrig, 'Bandit1RunToDaniel')
	    			OTrig.Trigger(None, None);

				bBanditFound = True;
			}

			if(!bBanditFound)
			{
				foreach AllActors(class'Bandit2', B2, 'Bandit2')
				{
       	           	foreach AllActors(class'OrdersTrigger', OTrig, 'Bandit2RunToDaniel')
		    			OTrig.Trigger(None, None);

					bBanditFound = True;
				}
			}

			if(!bBanditFound)
			{
				foreach AllActors(class'Bandit', B1, 'Bandit3')
				{
       	        	foreach AllActors(class'OrdersTrigger', OTrig, 'Bandit3RunToDaniel')
		    			OTrig.Trigger(None, None);

					bBanditFound = True;
				}
			}

			flags.SetBool('MS_C4_BanditsGarageFinished2', True,, 5);
		}

        //Check if Evgeny is dead...
		if (!flags.GetBool('MS_C4BanditsLeaderKilledTemp'))
		{
			count = 0;

			foreach AllActors(class'Evgeny', evg)
				count++;

			if (count <= 0)
				flags.SetBool('MS_C4BanditsLeaderKilledTemp', True,, 5);
		}

        //...and check if player killed him
		if (flags.GetBool('MS_C4BanditsLeaderKilledTemp') && !flags.GetBool('MS_C4EvgenySearched'))
		{
			count = 0;

			foreach AllActors(class'EvgenyCarcass', evgcarc)
			{
				if (evgcarc.KillerBindName == "JCDenton")
					count++;
			}

			if (count >= 1)
				flags.SetBool('MS_C4BanditsLeaderKilled', True,, 6);
			else
				flags.SetBool('MS_C4BanditsLeaderDead', True,, 6);

			flags.SetBool('MS_C4EvgenySearched', True,, 5);
		}

         //Check if Boris is dead...
		if (!flags.GetBool('MS_C4BanditBorisKilledTemp'))
		{
			count = 0;

			foreach AllActors(class'Boris', bor)
					count++;

			if (count <= 0)
				flags.SetBool('MS_C4BanditBorisKilledTemp', True,, 5);
		}

         //...and check if player killed him
		if (flags.GetBool('MS_C4BanditBorisKilledTemp') && !flags.GetBool('MS_C4BorisSearched'))
		{
			count = 0;

			foreach AllActors(class'BorisCarcass', borcarc)
			{
				if (borcarc.KillerBindName == "JCDenton")
					count++;
			}

			if (count >= 1)
				flags.SetBool('MS_C4BanditBorisKilled', True,, 7);
			else
				flags.SetBool('MS_C4BanditBorisDead', True,, 6);

			flags.SetBool('MS_C4BorisSearched', True,, 5);
		}

        //Check if any of the smugglers is dead
		if (flags.GetBool('MS_C4_BanditsFlagsFinished') && !(flags.GetBool('MS_C4Bandit_After_SomeoneKilled') || flags.GetBool('MS_C4_DanielLeavedGarage')))
		{
			if (!flags.GetBool('MS_C4Bandits_After_Counted'))
			{
				BanditsCount = 0;

			        foreach AllActors(class'Bandit', B1, 'Bandit1')
				      BanditsCount++;

			        foreach AllActors(class'Bandit2', B2, 'Bandit2')
				      BanditsCount++;

			        foreach AllActors(class'Bandit', B1, 'Bandit3')
				      BanditsCount++;

				flags.SetBool('MS_C4Bandits_After_Counted', True,, 5);
			}
			else
			{
				count = 0;

			        foreach AllActors(class'Bandit', B1, 'Bandit1')
				      count++;

			        foreach AllActors(class'Bandit2', B2, 'Bandit2')
				      count++;

			        foreach AllActors(class'Bandit', B1, 'Bandit3')
				      count++;

				if(count < BanditsCount)
					flags.SetBool('MS_C4Bandit_After_SomeoneKilled', True,, 5);
			}
		}
	}

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

    if (localURL == "04_MOSCOW_PUSHKIN" || localURL == "04_MOSCOW_STREETS" || localURL == "04_MOSCOW_METRO")
	{
		//Send message from Magnus
        if (flags.GetBool('C4_DanielFoundVladimir') && !flags.GetBool('MS_C4GotMagnusDatalink'))
	    {
	    	Player.StartDataLinkTransmission("DL_Magnus2");
	    	flags.SetBool('MS_C4GotMagnusDatalink', True,, 5);
	    }
	}

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

    if (localURL == "04_MOSCOW_PUSHKIN")
	{
        //Check if militia bots were destroyed
        if (!flags.GetBool('MS_C4BotsDestroyed'))
	    {
			count = 0;
			
			foreach AllActors(class'Robot', bot, 'MilitiaBot')
				if (bot.EMPHitPoints > 0)
				   count++;

			if(count == 4)
			{
				Player.StartDataLinkTransmission("DL_Bots4Left");
			}
			else if(count == 2)
			{
				Player.StartDataLinkTransmission("DL_Bots2Left");
			}
			else if (count == 0)
			{
				flags.SetBool('MS_C4BotsDestroyed', True,, 6);
				
				foreach AllActors(class'Dispatcher', disp, 'BotsJobComplete')
		        	disp.Trigger(None, None);
		        	
		        Player.StartDataLinkTransmission("DL_Bots0Left");
			}
	    }
	    
	    //Send message from Magnus
        if (flags.GetBool('C4_GotAmrita') && !flags.GetBool('MS_C4GotMagnusDatalink'))
	    {
	    	Player.StartDataLinkTransmission("DL_Magnus");
	    	flags.SetBool('MS_C4GotMagnusDatalink', True,, 5);
	    }
	    
	    //Check if helicopter has landed on the roof
        if (flags.GetBool('C4_RoofHeliLanded') && !flags.GetBool('MS_C4_RoofHeliDestroyed'))
	    {
	    	foreach AllActors(class'AttackHelicopter', chopper, 'RoofHeli')
				chopper.LeaveWorld();
            
            foreach AllActors(class'Dispatcher', disp, 'RoofHeliLanded')
		    	disp.Trigger(None, None);
              
	    	flags.SetBool('MS_C4_RoofHeliDestroyed', True,, 5);
	    }
	    
	    //Clean up after heli has flew away
	    if (flags.GetBool('C4_RoofHeliFlyed') && !flags.GetBool('MS_C4_RoofHeliPostFlyed'))
	    {
	    	foreach AllActors(class'AttackHelicopter', chopper, 'RoofHeli')
				chopper.LeaveWorld();
			
			if(flags.GetBool('C4_RoofHeliLanded'))
			{	
		    	foreach AllActors(class'Dispatcher', disp, 'RoofHeliFlyed')
			    	disp.Trigger(None, None);
			}
		    	
		    flags.SetBool('MS_C4_RoofHeliPostFlyed', True,, 5);
	    }
	    
	    //Hide ambush troops
        if (!flags.GetBool('MS_C4PushkinAmbush_Hidden'))
	    {
	    	foreach AllActors(class'ScriptedPawn', pawn, 'AmbushTroops')
				pawn.LeaveWorld();
				
			foreach AllActors(class'ScriptedPawn', pawn, 'AmbushTroopsBackup')
				pawn.LeaveWorld();
		    	
	    	flags.SetBool('MS_C4PushkinAmbush_Hidden', True,, 5);
	    }
	    
	    //Start the ambush when the Amrita quest has been complete
	    if (flags.GetBool('MS_Global_Amrita_Complete') && !flags.GetBool('MS_C4PushkinAmbush'))
	    {
	    	flags.SetBool('MS_C4PushkinAmbush', True,, 5);
	    }
	    
	    //Show ambush troops
        if (flags.GetBool('MS_C4PushkinAmbush') && !flags.GetBool('MS_C4PushkinAmbush_Started'))
	    {
	    	foreach AllActors(class'ScriptedPawn', pawn, 'AmbushTroops')
			{
				pawn.EnterWorld();
				pawn.bHidden = False;	
			}
				
			foreach AllActors(class'ScriptedPawn', pawn, 'AmbushTroopsBackup')
			{
				pawn.EnterWorld();
				pawn.bHidden = False;	
			}
		    
		    foreach AllActors(class'Trigger', trig, 'AmbushTrigger')
				trig.SetCollision(True);
		    	
	    	flags.SetBool('MS_C4PushkinAmbush_Started', True,, 5);
	    }
	}

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

	if (localURL == "04_MOSCOW_ROOFTOP")
	{
		//Remove heli
	    if (flags.GetBool('C4_RoofHeliGone') && !flags.GetBool('MS_C4_RoofHeliRoofRemoved'))
	    {
	    	foreach AllActors(class'AttackHelicopter', chopper, 'RoofHeli')
				chopper.LeaveWorld();
				
	    	flags.SetBool('MS_C4_RoofHeliRoofRemoved', True,, 5);
	    }

		//Add HH agents
		if (flags.GetBool('C4_GotAmrita') && !flags.GetBool('MS_C4_RooftopAgentsReady'))
		{
			foreach AllActors(class'ScriptedPawn', pawn, 'BiotechAgents')
				pawn.EnterWorld();	
				
			flags.SetBool('MS_C4_RooftopAgentsReady', True,, 5);			
		}
		
		//Unlock the safe keypad
		if(flags.GetBool('C4_PlayerKnowAmritaCode') && !flags.GetBool('MS_C4AmritaUnlocked'))
		{
			foreach AllActors(class'Keypad', pad, 'AmritaKeypad')
			{
				pad.bAlwaysWrong = False;
			}

			flags.SetBool('MS_C4AmritaUnlocked', True,, 5);
		}
	}

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

	if (localURL == "04_MOSCOW_CLUB")
	{
		//Nikolay appears in the club
		if (
			flags.GetBool('C4_Nikolay_Helped') //We have killed soldier and gave Nikolay a medkit
			&& !flags.GetBool('MS_C4_Nikolay_Killed') //And Nikolay is alive
			&& !flags.GetBool('MS_C4_Nikolay_Appears') //And has not yet appeared in the club		
		)
		{
		    foreach AllActors(class'ScriptedPawn', pawn, 'Nikolay')
				pawn.EnterWorld();

	        flags.SetBool('MS_C4_Nikolay_Appears', True,, 6);
        }
        
        //Open the VIP room
        if(flags.GetBool('C4_Club_VIP_Opened') && !flags.GetBool('MS_C4_Club_VIP_Opened'))
		{
			flags.SetBool('MS_C4_Club_VIP_Opened', True,, 5);
			
			foreach AllActors(class'Dispatcher', disp, 'OpenVipRoom')
	    		disp.Trigger(None, None);
		}
		
		//Player has the safe code
		if(flags.GetBool('C4_GotOmarClubAugCode') && !flags.GetBool('MS_C4OmarClubAugReady'))
		{
			foreach AllActors(class'Keypad', pad, 'OmarKeypad')
			{
				pad.bAlwaysWrong = False;
			}

			flags.SetBool('MS_C4OmarClubAugReady', True,, 5);
		}
	}

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

	if (localURL == "04_MOSCOW_SMUGGLER")
	{
		//Check if Nikolay is safe
		if(!flags.GetBool('MS_C4_Nickolay_Saved'))
		{
			count = 0;
			
			foreach AllActors(class'ScriptedPawn', pawn, 'NickKiller')
				count++;
				
			if(count == 0)
			{
				Player.SkillPointsAdd(300);
				flags.SetBool('MS_C4_Nickolay_Saved', True,, 5);
			}
		}
		
		//Check if Nikolay has been killed
		if (!flags.GetBool('MS_C4_Nikolay_Killed') && !flags.GetBool('MS_C4_Nikolay_Leaved'))
		{
		    foreach AllActors(class'ScriptedPawn', pawn, 'Nikolay')
			    count++;

			if(count == 0)
		        flags.SetBool('MS_C4_Nikolay_Killed', True,, 5);
		       
		    //Stop bleeding if we gave a medkit
		    if (flags.GetBool('C4_Nikolay_Helped') && !flags.GetBool('MS_C4_Nikolay_StopBleeding'))
			{
			        foreach AllActors(class'Nikolay', nik, 'Nikolay')
						nik.StopMyBleed();
	
			        flags.SetBool('MS_C4_Nikolay_StopBleeding', True,, 5);
			}
		}
	}
}

defaultproperties
{
	RedOmarName="Mikhail"
	bAutosave=True
	AutosaveName="Moscow"
}