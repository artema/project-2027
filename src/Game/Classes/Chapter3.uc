class Chapter3 expands MissionScript;

var int ContainmentLength, ContainmentLength2;

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
	local int count;
	local Xander xander;
	local Keypad1 pad1;
    local Cop cop;
	local Dispatcher disp;
    local AllianceTrigger ATrig;
	local ScriptedPawn pawn;
	local Trigger trig;
	local Button1 but;
	local Inventory item, nextItem;

	Super.FirstFrame();

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

    if (localURL == "03_PARIS_LAB")
	{
		flags.SetBool('MS_C3_VisitedLab', True,, 6);
		
	    foreach AllActors(class'Button1', but, 'ContainementButtonIn')
			ContainmentLength = but.buttonLitTime;

	    foreach AllActors(class'Button1', but, 'ContainementButton')
			ContainmentLength2 = but.buttonLitTime;

		if (!flags.GetBool('MS_C3_ParisLab_Visited'))
		{
			flags.SetBool('MS_C3_ParisLab_Visited', True,, 7);
			flags.SetBool('C3_Containment_CanUseMiddle', True,, 4);
		}
	}

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

    if (localURL == "03_PARIS_HOME")
	{		
		//Startup
		if(!flags.GetBool('MS_ParisStartUp'))
		{
			Player.bProcessingData = False;
			
			Player.RestoreAllHealth();			
			Player.GenerateTotalHealth();

			Player.SetInHandPending(None);
			Player.SetInHand(None);
		
			Player.bInHandTransition = False;
			
			Player.StopProcessingDataMax();
			
			count = 0;
			
			while(Player.Inventory != None)
			{
				nextItem = Player.Inventory;
				
				if(!nextItem.IsA('NanoKeyRing'))
				{
					Player.DeleteInventory(nextItem);
					nextItem.Destroy();
				}
				
				count++;
				
				if(count > 9000)
					break;
			}
			
			Player.CreateKeyRing();
			
			Player.Energy  = Player.Default.Energy;
			
			flags.SetBool('MS_ParisStartUp', True,, 6);
		}
		

		//If player has failed the first misssion, change the troops alliance from the beginning
		//if (flags.GetBool('MS_Global_CIAFailed'))
		//	flags.SetBool('MS_Global_ParisTroopsRage', True,, 6);
    }
    
	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

    if (localURL == "03_PARIS_CELLAR")
	{
    }
    
	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

    if (localURL == "03_PARIS_LATINQUARTER")
	{			
		//Remove Arman from the club after we left
		if(flags.GetBool('MS_C3ClubVisited') && flags.GetBool('C3_ArmanFirstMeetPlayed') && !flags.GetBool('MS_C3ArmanDeletedFromClub'))
		{
			flags.SetBool('MS_C3ArmanDeletedFromClub', True,, 4);
		}
		
		//Hide junkie and his friends
		if (!flags.GetBool('MS_C3_JunkiesDeleted'))
		{
			foreach AllActors(class'ScriptedPawn', pawn)
			{
				if((pawn.Tag == 'ClubJunkie') || (pawn.Tag == 'ClubJunkieFriend'))
					pawn.LeaveWorld();
			}
			
			flags.SetBool('MS_C3_JunkiesDeleted', True,, 4);
		}
		
        //Hide all ambush cops
		if (!flags.GetBool('MS_C3AmbushHidden'))
		{
		    foreach AllActors(class'ScriptedPawn', pawn)
			{
				if((pawn.Tag == 'AmbushPostMJ12_1') || (pawn.Tag == 'AmbushPostMJ12_2') || (pawn.Tag == 'GunShopPolice_1') || (pawn.Tag == 'GunShopPolice_2') || (pawn.Tag == 'BarPolice_1') || (pawn.Tag == 'BarPolice_2'))
					pawn.LeaveWorld();
			}

	        flags.SetBool('MS_C3AmbushHidden', True,, 4);
		}
		
		//Hide all MJ12 troops
		if (!flags.GetBool('MS_C3MJ12Hidden'))
		{
			foreach AllActors(class'ScriptedPawn', pawn)
			{
				if((pawn.Tag == 'MJ12Troopers') || (pawn.Tag == 'MJ12Bot'))
					pawn.LeaveWorld();
			}
			
			flags.SetBool('MS_C3MJ12Hidden', True,, 4);
		}
		
		//Unhide MJ12 troops after player has been spotted
		if (flags.GetBool('MS_Global_ParisTroopsRage') && !flags.GetBool('MS_C3MJ12UnHidden'))
		{
			flags.SetBool('MS_C3MJ12UnHidden', True,, 4);
		}
	}
	
	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

    if (localURL == "03_PARIS_OLDQUARTER")
	{
		//Remove the HH ambush
		if (!flags.GetBool('MS_C3_Ambush_Prepared'))
		{
			foreach AllActors(class'ScriptedPawn', pawn, 'BiotechAgents')
				pawn.LeaveWorld();
			
			foreach AllActors(class'ScriptedPawn', pawn, 'HHAgent')
				pawn.LeaveWorld();					
				
			flags.SetBool('MS_C3_Ambush_Prepared', True,, 4);
		}
		
        //Remove Arman and the black gang before the final mission for smugglers
		if (!flags.GetBool('MS_C3Job3Hidden'))
		{
		    foreach AllActors(class'ScriptedPawn', pawn)
			{
				if((pawn.Tag == 'Arman') || (pawn.Tag == 'BlackGang') || (pawn.Tag == 'BlackGangLeader'))
					pawn.LeaveWorld();
			}

	        flags.SetBool('MS_C3Job3Hidden', True,, 4);
		}

        //Remove Arman after the mission
		if (flags.GetBool('C3_Job3_Done') && !flags.GetBool('MS_C3ArmanLeaved') && !flags.GetBool('MS_C3ArmanDead'))
		{
			foreach AllActors(class'ScriptedPawn', pawn, 'Arman')
					pawn.LeaveWorld();

			flags.SetBool('MS_C3ArmanLeaved', True,, 4);
		}

        //Remove hitman
		if (!flags.GetBool('C3_Hitman_Started') && !flags.GetBool('MS_C3_Hitman_Hidden'))
		{
			foreach AllActors(class'ScriptedPawn', pawn, 'Hitman')
				pawn.LeaveWorld();

	    	flags.SetBool('MS_C3_Hitman_Hidden', True,, 4);
		}

        //Remove the black gang leader after the prison mission completed
		if (flags.GetBool('C3_Job_Prison_Done') && !flags.GetBool('MS_C3OldQuarterLeaderDeleted'))
		{
			foreach AllActors(class'ScriptedPawn', pawn, 'BlackGandLeader')
					pawn.LeaveWorld();

			flags.SetBool('MS_C3OldQuarterLeaderDeleted', True,, 4);
		}	
		
		//Remove the scuba diver
		if((!flags.GetBool('C3_ScubaDived') && !flags.GetBool('MS_C3_ScubaRemoved')) ||
        (flags.GetBool('MS_C3_VisitedLab') && flags.GetBool('MS_C3_ScubaAdded')))
		{
			count = 0;
			
			foreach AllActors(class'ScriptedPawn', pawn, 'ScubaDiver')
			{
				count++;
				pawn.LeaveWorld();
			}
			
			if(count == 0)
			{
				flags.SetBool('MS_C3_ScubaDead', True,, 4);
			}
			
			flags.SetBool('MS_C3_ScubaRemoved', True,, 4);
		}	
		
		//Remove stalker
        if ((!flags.GetBool('Global_Smugglers_Complete') && !flags.GetBool('MS_C3_Stalker_Removed')) ||
        (flags.GetBool('MS_C3_VisitedLab') && flags.GetBool('MS_C3_Stalker_Added')))
		{
			foreach AllActors(class'ScriptedPawn', pawn, 'Stalker')
				pawn.LeaveWorld();
				
			flags.SetBool('MS_C3_Stalker_Removed', True,, 4);
		}
	}
	
	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

    if (localURL == "03_PARIS_SMUGGLERS")
	{
        //Remove the italian
		if (!flags.GetBool('MS_C3ItalianHidden'))
		{
			foreach AllActors(class'ScriptedPawn', pawn, 'Italian')
				pawn.LeaveWorld();

	    	flags.SetBool('MS_C3ItalianHidden', True,, 4);
		}

        //Remove Arman when we go out on the final mission
		if (flags.GetBool('MS_C3Job3Ready') && !flags.GetBool('MS_C3ArmanGoneWithUs'))
		{
			foreach AllActors(class'ScriptedPawn', pawn, 'Arman')
				pawn.LeaveWorld();

	    	flags.SetBool('MS_C3ArmanGoneWithUs', True,, 4);
		}

        //Delete Arman if he is dead
		if (flags.GetBool('MS_C3ArmanDead') && !flags.GetBool('MS_C3ArmanDeleted'))
		{
			foreach AllActors(class'ScriptedPawn', pawn, 'Arman')
				pawn.LeaveWorld();

	    	flags.SetBool('MS_C3ArmanDeleted', True,, 4);
		}
	}

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

    if (localURL == "03_PARIS_CLUB")
	{
        //Remove the black gang leader if he is in prison or dead
		if ((!flags.GetBool('C3_Job_Prison_Done') || (flags.GetBool('C3_Job_Prison_Done') && flags.GetBool('C3_Job_Prison_Died'))) && !flags.GetBool('MS_C3ClubBlackLeaderHidden'))
		{
		    foreach AllActors(class'ScriptedPawn', pawn)
				if(pawn.Tag == 'BlackGandLeader')
					pawn.LeaveWorld();

	        flags.SetBool('MS_C3ClubBlackLeaderHidden', True,, 4);
		}

        //Remove Arman after the first meet in the club
		if (flags.GetBool('C3_ArmanFirstMeetPlayed') && flags.GetBool('MS_C3ArmanDeletedFromClub') && !flags.GetBool('MS_C3ArmanPawnDeletedFromClub'))
		{
		    foreach AllActors(class'ScriptedPawn', pawn)
				if(pawn.Tag == 'Arman')
					pawn.LeaveWorld();

	        flags.SetBool('MS_C3ArmanPawnDeletedFromClub', True,, 4);
		}
		
		//Remove Arman's wife after the phone convo with Arman
		if (flags.GetBool('C3_ArmanTalkedAboutPhone') && !flags.GetBool('MS_C3ArmanWifeDeletedFromClub'))
		{
		    foreach AllActors(class'ScriptedPawn', pawn, 'DatingWoman')
				pawn.LeaveWorld();

	        flags.SetBool('MS_C3ArmanWifeDeletedFromClub', True,, 4);
		}
		
		//Remove italian
		if (!flags.GetBool('MS_C3ClubItalianHidden'))
		{
			foreach AllActors(class'ScriptedPawn', pawn, 'Italian')
				pawn.LeaveWorld();

	    	flags.SetBool('MS_C3ClubItalianHidden', True,, 4);
		}
		
		//Remove italian again when he goes to the smugglers' lair
		if (flags.GetBool('MS_C3ItalianReady') && !flags.GetBool('MS_C3ClubItalianHidden2'))
		{
			foreach AllActors(class'ScriptedPawn', pawn, 'Italian')
				pawn.LeaveWorld();

	    	flags.SetBool('MS_C3ClubItalianHidden2', True,, 4);
		}
		
		//Remove junkie from the club
		if(flags.GetBool('MS_C3_ClubJunkieLeft') && !flags.GetBool('MS_C3_ClubJunkieDeleted'))
		{
			foreach AllActors(class'ScriptedPawn', pawn, 'ClubJunkie')
				pawn.LeaveWorld();

	    	flags.SetBool('MS_C3_ClubJunkieDeleted', True,, 4);	
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

	Super.PreTravel();

// = ��������� ������� = //

    if (localURL == "03_PARIS_LATINQUARTER")
	{
	}

// = ������ ������� = //

    if (localURL == "03_PARIS_OLDQUARTER")
	{
		//Stop watching for the black gang leader's prison break
		if(flags.GetBool('C3_Job_Prison_Done') && !flags.GetBool('C3_StopWatch_BlackLeader'))
			flags.SetBool('C3_StopWatch_BlackLeader', True,, 4);
	}

// = �������������� = //

    if (localURL == "03_PARIS_SMUGGLERS")
	{
	}

// = ���� = //

    if (localURL == "03_PARIS_CLUB")
	{
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
	local int count;
	local int NewCount;
	local int TempCount;
	local Cat ct;
	local Dispatcher disp;
    local Cop cop;
    local Keypad pad;
	local Keypad1 pad1;
	local Keypad2 pad2;
	local Trigger trig;
    local AllianceTrigger ATrig;
	local ScriptedPawn pawn, pawn2;
	local Robot rob;
	local int TroopsCount;
	local DeusExDecoration deco;
	local FolderBig folder;
	local SpawnPoint SP;
	local SecurityCamera camera;
	local Vector loc;
	local AlarmUnit alarm;
	local Rotator rot;
	local DeusExMover M;
	local Button1 but;
	local DeusExCarcass carc;
	local Actor actor;
	local BiotechAgentCarcass bioCarc;
	local ItalianCarcass itcarc;
	local HitmanCarcass hitcarc;
	local AndreCarcass andrecarc;
	local AugmentationCannister aug;

	Super.Timer();

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	//Start the data analysis
	if (flags.GetBool('C3_DataAnalysisStarted') && !flags.GetBool('MS_C3_DataAnalysisStarted'))
	{
		Player.StartProcessingData();
		flags.SetBool('MS_C3_DataAnalysisStarted', True,, 4);
	}
	
	//Finish the data analysis
	if (flags.GetBool('C3_DataAnalysisComplete') && !flags.GetBool('MS_C3_DataAnalysisComplete'))
	{
		Player.StopProcessingData();
		flags.SetBool('MS_C3_DataAnalysisComplete', True,, 4);
	}

	if(Player.bProcessingData && flags.GetBool('C3_DataAnalysisComplete'))
	{
		Player.bProcessingData = False;	
	}

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

    if (localURL == "03_PARIS_HOME")
	{
		//Open the home door after talked to Xander
		if (flags.GetBool('C3_XanderIntroConvoPlayed') && !flags.GetBool('MS_C3_HomeDoorOpened'))
		{
			foreach AllActors(class'DeusExMover', M, 'ExitDoor')
			{
				M.bLocked = False;
				M.bHighlight = True;
				M.bFrobbable = True;
			}
			
			flags.SetBool('MS_C3_HomeDoorOpened', True,, 4);	
		}
	}
	
	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

    if (localURL == "03_PARIS_BAR")
	{
		//Send datalink when we know who killed Christoph
		if (flags.GetBool('Global_ChristophKillersFound'))
		{
		    Player.StartDataLinkTransmission("DL_DeadChristoph3");
	    }
	}
	
	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

    if (localURL == "03_PARIS_OLDQUARTER")
	{
		//Draw the explosion
		if (!flags.GetBool('MS_C3BarrelExplosionSpawned'))
		{
             foreach AllActors(class'DeusExMover', M, 'ExplosiveBarrel')
             {
	             if (M.bDestroyed)
	             {
					foreach AllActors(class'Dispatcher', disp, 'ExplosionDispatcher')
				    	disp.Trigger(None, None);
				             
					foreach AllActors(class'SpawnPoint', SP, 'ExplosiveBarrelSpawn')
					{
						Spawn(class'BigBarrelExplosion',,, SP.Location);
						break;
	                }
	                
					flags.SetBool('MS_C3BarrelExplosionSpawned', True,, 6);
					break;
				}
             }
        }
        
		//Start the HH ambush after the lab mission
		if (flags.GetBool('C3_Tech_HasDisc') && flags.GetBool('C3_PlayerSuspected') && !flags.GetBool('C3_DataAnalysisComplete') && !flags.GetBool('MS_C3_Ambush_Started'))
		{
			foreach AllActors(class'ScriptedPawn', pawn, 'BiotechAgents')
			{
				pawn.EnterWorld();
				pawn.bHidden = False;	
			}
			
			//Add agent if he is not dead
			if(!flags.GetBool('MS_C3_AgentDead'))
			{
				foreach AllActors(class'ScriptedPawn', pawn, 'HHAgent')
					pawn.EnterWorld();
			}
			
			foreach AllActors(class'DeusExMover', M, 'QuarterExitDoors')
			{
				M.bLocked = True;
				
				if(M.KeyNum != 0)
					M.Trigger(None, None);
			}
				
			flags.SetBool('MS_C3_Ambush_Started', True,, 4);
		}
		
		//Activate the hitman task
		if (flags.GetBool('C3_BlackGangClub_Talked2') && !flags.GetBool('MS_C3_Hitman_TaskPrepared'))
		{
			foreach AllActors(class'Trigger', trig, 'StartHitmanTrigger')
				trig.SetCollision(True);
				
			flags.SetBool('MS_C3_Hitman_TaskPrepared', True,, 4);
		}
		
        //Add hitman to the map
		if (flags.GetBool('C3_Hitman_Started') && !flags.GetBool('MS_C3_Hitman_Ready'))
		{
		    foreach AllActors(class'ScriptedPawn', pawn, 'Hitman')
				pawn.EnterWorld();

			flags.SetBool('MS_C3_Hitman_Ready', True,, 4);
		}

		//Hitman turns on the lights when he enters his room
		if (flags.GetBool('C3_Hitman_Entered2') && !flags.GetBool('MS_C3_Hitman_Done2'))
		{
		    foreach AllActors(class'DeusExDecoration', deco, 'HitmanSwitch2')
		    {
				if(AdvLightSwitch(deco).IsOn() == False)
					AdvLightSwitch(deco).TurnOn();
			}

			flags.SetBool('MS_C3_Hitman_Done2', True,, 4);
		}
		
		if (flags.GetBool('C3_Hitman_Entered') && !flags.GetBool('MS_C3_Hitman_Done'))
		{
		    foreach AllActors(class'DeusExDecoration', deco, 'HitmanSwitch')
		    {
				if(AdvLightSwitch(deco).IsOn() == False)
					AdvLightSwitch(deco).TurnOn();
			}

			flags.SetBool('MS_C3_Hitman_Done', True,, 4);
		}

		//Check if hitman is dead
		if (flags.GetBool('MS_C3_Hitman_Ready') && !flags.GetBool('MS_C3Killer_Done'))
		{
			foreach AllActors(class'HitmanCarcass', hitcarc)
			{
				Player.GoalCompleted('Club_Job_Killer');
				flags.SetBool('MS_C3Killer_Done', True,, 4);
				
				if(hitcarc.bNotDead)
				{
					Player.SkillPointsAdd(400);
				}
				else
				{
					Player.SkillPointsAdd(200);
					flags.SetBool('MS_C3Killer_Killed', True,, 4);
					
					if(hitcarc.bGibbed)
						flags.SetBool('MS_C3Killer_Gibbed', True,, 4);
				}				
				
				break;
			}
		}
		
		//Check if hitman's carcass has been destroyed
		if (flags.GetBool('MS_C3Killer_Done') && !flags.GetBool('MS_C3Killer_Gibbed'))
		{
			foreach AllActors(class'HitmanCarcass', hitcarc)
			{
				if(hitcarc.bGibbed)
				{
					flags.SetBool('MS_C3Killer_Killed', True,, 4);
					flags.SetBool('MS_C3Killer_Gibbed', True,, 4);
				}
				break;
			}
		}
		
		//Remove hitman's carcass after the mission
		if (flags.GetBool('C3_KillerTaskComplete') && !flags.GetBool('MS_C3KillerCarcass_Removed'))
		{
			foreach AllActors(class'HitmanCarcass', hitcarc)
			{
				hitcarc.Destroy();
			}
			
			flags.SetBool('MS_C3KillerCarcass_Removed', True,, 4);
		}
		

        //Add Arman and the back gang
		if (flags.GetBool('C3_Job3_Played') && !flags.GetBool('MS_Global_SmugglersRage') && !flags.GetBool('MS_C3Job3Ready'))
		{
		    foreach AllActors(class'ScriptedPawn', pawn)
			{
				if((pawn.Tag == 'Arman') || (pawn.Tag == 'BlackGang') || (pawn.Tag == 'BlackGangLeader'))
				{
					if(pawn.Tag == 'BlackGangLeader')
					{
						if(!flags.GetBool('C3_Job_Prison_Died') && flags.GetBool('C3_Job_Prison_Done'))
						{
							pawn.EnterWorld();
						}
						else
						{
							pawn.LeaveWorld();
							flags.SetBool('C3_Job_Prison_Died', True,, 7);							
						}
					}
					else
						pawn.EnterWorld();
				}
			}

			flags.SetBool('MS_C3Job3Ready', True,, 4);
		}

		if(flags.GetBool('MS_C3Job3Ready') && flags.GetBool('C3_Job_Prison_Died') && !flags.GetBool('MS_C3_LeaderKilledInPrison'))
		{
			foreach AllActors(class'ScriptedPawn', pawn2, 'BlackGandLeader')
			{								
				pawn2.Health = 1;
				pawn2.TakeDamage(100, pawn2, pawn2.Location, vect(0,0,0), 'Shot');
				
			}
							
			flags.SetBool('MS_C3_LeaderKilledInPrison', True,, 4);
		}

        //Player has attacked the black gang
		if (flags.GetBool('C3_Job3_Played') && !flags.GetBool('MS_C3Job3Attacked'))
		{
		    foreach AllActors(class'ScriptedPawn', pawn)
			{
				if(pawn.Tag == 'BlackGang' || pawn.Tag == 'BlackGangLeader')
				{
					if(pawn.Health < pawn.Default.Health)
					{
                  		foreach AllActors(class'Trigger', trig, 'SetRiverBanditsAlliance')
		           			trig.Trigger(None, None);
		           			
						flags.SetBool('MS_C3Job3Attacked', True,, 4);
						break;
					}
				}
			}
		}

		//Check if Arman is dead
		if (flags.GetBool('MS_C3Job3Ready') && !flags.GetBool('MS_C3ArmanDead') && !flags.GetBool('MS_C3ArmanLeaved'))
		{
			count = 0;
			foreach AllActors(class'ScriptedPawn', pawn, 'Arman')
				count++;

			if (count == 0)
				flags.SetBool('MS_C3ArmanDead', True,, 4);
		}

        //Count the black gang troops
		if (flags.GetBool('MS_C3Job3Ready') && !flags.GetBool('C3_Job3_Done'))
		{
			count = 0;
			foreach AllActors(class'ScriptedPawn', pawn, 'BlackGang')
				if(pawn.bInWorld)
					count++;
					
			foreach AllActors(class'ScriptedPawn', pawn, 'BlackGangLeader')
				if(pawn.bInWorld)
					count++;

			//Everyone is dead?
			if (count == 0)
			{
                foreach AllActors(class'Dispatcher', disp, 'Job3Disp')
		           	disp.Trigger(None, None);

				Player.GoalCompleted('Smugglers_Job_3');
				flags.SetBool('MS_Global_BlackGangRage', True,, 7);
				flags.SetBool('C3_Job3_Done', True,, 4);
			}
		}

        //Check if the black gang leader is dead or alive during the prison mission
		if (!flags.GetBool('C3_StopWatch_BlackLeader'))
		{
			count = 0;
			foreach AllActors(class'ScriptedPawn', pawn, 'BlackGandLeader')
				count++;

			//Is he dead?
			if (count == 0)
			{
				Player.GoalFailed('Club_Job_Prison');
				flags.SetBool('MS_Global_BlackGangRage', True,, 7);
				flags.SetBool('C3_Job_Prison_Done', True,, 4);
				flags.SetBool('C3_Job_Prison_Died', True,, 7);
				flags.SetBool('C3_StopWatch_BlackLeader', True,, 4);
			}
			else
			{
				//Mission complete
				if(flags.GetBool('C3_PrisonArrived') && !flags.GetBool('C3_Job_Prison_Done'))
				{
					Player.GoalCompleted('Club_Job_Prison');
					Player.SkillPointsAdd(400);
					flags.SetBool('C3_Job_Prison_Done', True,, 4);
				}
			}
		}

		//Unlock the lab door
        if (flags.GetBool('Global_BlackGang_Complete') && !flags.GetBool('MS_C3_LabDoorUnlocked'))
		{
			foreach AllActors(class'DeusExMover', M, 'TunnelsDoor')
			{
				M.bLocked = False;
				break;
			}
			
			flags.SetBool('MS_C3_LabDoorUnlocked', True,, 4);
		}

		//----------------------------------------------
		// Stalker and generator

		//Add stalker
        if (flags.GetBool('Global_Smugglers_Complete') && !flags.GetBool('MS_C3_Stalker_Added'))
		{
			foreach AllActors(class'ScriptedPawn', pawn, 'Stalker')
				pawn.EnterWorld();
				
			flags.SetBool('MS_C3_Stalker_Added', True,, 4);
		}
		
		//Check if stalker is dead
		if (flags.GetBool('MS_C3_Stalker_Added') && !flags.GetBool('MS_C3_StalkerDied'))
		{
			count = 0;
			foreach AllActors(class'ScriptedPawn', pawn, 'Stalker')
				count++;

			if (count == 0)
				flags.SetBool('MS_C3_StalkerDied', True,, 4);
		}

		//Stalker goes to the door
        if (flags.GetBool('C3_Stalker_StartPlayed') && !flags.GetBool('MS_C3_Stalker_DoorChecked'))
		{
			foreach AllActors(class'DeusExMover', M)
			{
				if (M.Tag == 'TunnelsDoor')
				{
					if(M.bLocked == True)
					{
						foreach AllActors(class'Trigger', trig, 'Stalker_StopAtDoorTrigger')
							trig.SetCollision(True);
							
                        flags.SetBool('MS_C3_Stalker_DoorLocked', True,, 4);
					}
				}            
			}

			flags.SetBool('MS_C3_Stalker_DoorChecked', True,, 4);
        }

		//Door is opened
        if (flags.GetBool('MS_C3_Stalker_DoorLocked') && !flags.GetBool('MS_C3_Stalker_DoorOpened'))
		{
			foreach AllActors(class'DeusExMover', M)
			{
				if (M.Tag == 'TunnelsDoor')
				{
					if(M.bLocked == False)
					{
						foreach AllActors(class'Trigger', trig, 'Stalker_StopAtDoorTrigger')
							trig.SetCollision(False);
						foreach AllActors(class'Dispatcher', disp, 'Stalker_WhenDoorOpened')
							disp.Trigger(None, None);

                        flags.SetBool('MS_C3_Stalker_DoorOpened', True,, 4);
					}
				}
             }
         }

		//Change the lab door button state based on the generator
		if(!flags.GetBool('C3_LabDoorOpened'))
		{		
			foreach AllActors(class'Actor', actor, 'LabDoorSwitch')
			{
				if(flags.GetBool('C3_GeneratorOff'))
				{
					actor.Event = 'DoorWhileOff';
					AdvSwitch2(actor).bOnceOnly = False;
				}
				else
				{
					actor.Event = 'DoorWhileOn';
					AdvSwitch2(actor).bOnceOnly = True;	
				}
			
				break;	
			}
		}
		else if(!flags.GetBool('MS_C3_LabDoorSwitchFixed'))
		{
			foreach AllActors(class'Actor', actor, 'LabDoorSwitch')
			{
				actor.Event = '';
				AdvSwitch2(actor).bOnceOnly = True;
				AdvSwitch2(actor).bNoMore = True;
				break;	
			}
			
			flags.SetBool('MS_C3_LabDoorSwitchFixed', True,, 4);	
		}
		
		//Check if scuba diver should appear
		if(!flags.GetBool('C3_ScubaDived') && !flags.GetBool('C3_LabDoorOpened') && (
				((flags.GetBool('MS_Global_SmugglersRage') && !flags.GetBool('Global_Smugglers_Complete')) && (flags.GetBool('C3_Job_Prison_Died') || flags.GetBool('MS_Global_BlackGangRage'))) //Both jobs failed
				||
				(flags.GetBool('Global_BlackGang_Complete')) //Black gang job complete
				||
				((flags.GetBool('MS_C3_StalkerDied') && !flags.GetBool('C3_LabDoorOpened')) && (flags.GetBool('C3_Job_Prison_Died') || flags.GetBool('MS_Global_BlackGangRage'))) //Stalker is dead
			)
		)
		{
				flags.SetBool('C3_ScubaDived', True,, 4);
		}
		
		//Enable the stalker's scripts
		if(flags.GetBool('C3_Stalker_Completed') && !flags.GetBool('MS_C3_StalkerDied') && !flags.GetBool('MS_C3_StalkerEnabled'))
		{
			foreach AllActors(class'Trigger', trig, 'PlayerAtDoorTrig')
				trig.SetCollision(True);
				
			flags.SetBool('MS_C3_StalkerEnabled', True,, 4);
		}
		
		//Disable the stalker's scripts
		if(flags.GetBool('MS_C3_StalkerDied') && !flags.GetBool('MS_C3_StalkerDisabled'))
		{
			foreach AllActors(class'Trigger', trig, 'PlayerAtDoorTrig')
				trig.SetCollision(False);
				
			flags.SetBool('MS_C3_StalkerDisabled', True,, 4);
		}
		
		//Remove stalker after the door has been opened
		if(flags.GetBool('C3_LabDoorOpened') && !flags.GetBool('MS_C3_StalkerDoneAndRemoved'))
		{
			foreach AllActors(class'ScriptedPawn', pawn, 'Stalker')
				pawn.LeaveWorld();
				
			flags.SetBool('MS_C3_StalkerDoneAndRemoved', True,, 4);
		}
		
		//Add the scuba diver
		if(flags.GetBool('C3_ScubaDived') && !flags.GetBool('MS_C3_ScubaAdded'))
		{
			foreach AllActors(class'ScriptedPawn', pawn, 'ScubaDiver')
				pawn.EnterWorld();
					
			foreach AllActors(class'Trigger', trig, 'SpawnFlareTrigger')
				trig.SetCollision(True);
							
			foreach AllActors(class'Dispatcher', disp, 'DiverOpensDoor')
				disp.Trigger(None, None);
			
			foreach AllActors(class'Actor', actor, 'LabDoorSwitch')
			{
				AdvSwitch2(actor).bNoMore = True;
			}
								
			flags.SetBool('MS_C3_ScubaAdded', True,, 4);
		}
		
		//Spawn the flare when the player is nearby
		if(flags.GetBool('C3_SpawnFlare') && !flags.GetBool('MS_C3_FlareSpawned'))
		{
			foreach AllActors(class'Actor', actor, 'FlareSpawn')
			{
	        	Spawn(class'P_Flare',,, actor.Location);
	        	break;
			}
	              	 
			flags.SetBool('MS_C3_FlareSpawned', True,, 4);	
		}
	}

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

    if (localURL == "03_PARIS_CELLAR")
	{
		//Player has killed the cat
		if(!flags.GetBool('MS_DrunksCatKilled'))
		{
			count = 0;
			foreach AllActors(class'Cat', ct)
				count++;

			if (count == 0)
				flags.SetBool('MS_DrunksCatKilled', True,, 4);
		}

        //Player has the armory code
		if(flags.GetBool('C3_HasArmoryCode') && !flags.GetBool('MS_C3GunDCodeRecieved'))
		{
			foreach AllActors(class'Keypad2', pad2, 'RealAmmoPad')
				pad2.bAlwaysWrong = False;

			flags.SetBool('MS_C3GunDCodeRecieved', True,, 4);
		}
		
		//Player hacked the armory keypad
		if(!flags.GetBool('C3_HasArmoryCode') && !flags.GetBool('MS_C3HackedArmory'))
		{
			foreach AllActors(class'Keypad', pad, 'RealAmmoPad')
			{
				if(pad.hackStrength <= 0.0)
				{
					foreach AllActors(class'Dispatcher', disp, 'RageTrader')
						disp.Trigger(None, None);
				
					flags.SetBool('MS_C3HackedArmory', True,, 4);
					break;
				}
			}
		}
    }

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

    if (localURL == "03_PARIS_SMUGGLERS")
	{
		//Player has the safe code
		if(flags.GetBool('C3_HasLegionSafeCode') && !flags.GetBool('MS_C3_HasLegionSafeCode'))
		{
			foreach AllActors(class'Keypad2', pad2, 'LegionKeypad')
			{
				pad2.bAlwaysWrong = False;
				break;
			}

			flags.SetBool('MS_C3_HasLegionSafeCode', True,, 4);
		}
		
        //Check if some of the smugglers was killed
		if (!flags.GetBool('MS_Global_SmugglersRage'))
		{
			count = 0;

			foreach AllActors(class'DeusExCarcass', carc)
			{
				if(!carc.bAnimalCarcass)
					count++;
			}

			if (count > 0)
				flags.SetBool('MS_Global_SmugglersRage', True,, 7);
		}
		
		//Check if italian is killed
		if (!flags.GetBool('MS_Global_ItalianDead'))
		{
			count = 0;
			
			foreach AllActors(class'ItalianCarcass', itcarc)
				count++;

			if (count > 0)
				flags.SetBool('MS_Global_ItalianDead', True,, 7);
		}

        //Change the alliance
		if (flags.GetBool('MS_Global_SmugglersRage') && !flags.GetBool('MS_C3SmugglersAllianceChanged'))
		{
			foreach AllActors(class'AllianceTrigger', ATrig, 'ChangeSmugglersAlliance')
				ATrig.Trigger(None, None);

			flags.SetBool('MS_C3SmugglersAllianceChanged', True,, 4);
		}

        //Open the nazi room
		if (flags.GetBool('C3_Job2_Done') && !flags.GetBool('MS_Global_SmugglersRage') && !flags.GetBool('MS_C3_NaziReady'))
		{
            foreach AllActors(class'Dispatcher', disp, 'NaziDisp')
				disp.Trigger(None, None);

			flags.SetBool('MS_C3_NaziReady', True,, 4);
		}

        //Spawn Arman after the final mission
		if (flags.GetBool('C3_Job3_Done') && !flags.GetBool('MS_C3ArmanDead') && !flags.GetBool('MS_Global_SmugglersRage') && !flags.GetBool('MS_C3ArmanReturned'))
		{
		        foreach AllActors(class'ScriptedPawn', pawn, 'Arman')
					pawn.EnterWorld();

		        foreach AllActors(class'SpawnPoint', SP, 'ArmanSpawn')
                {
                    loc = SP.Location;
                    rot = SP.Rotation;

					foreach AllActors(class'ScriptedPawn', pawn, 'Arman')
					{
						pawn.SetLocation(loc);
						pawn.SetRotation(rot);
						pawn.bUseHome = False;
						pawn.HomeTag = 'ArmanHome';
						pawn.InitializeHomeBase();
						pawn.SetOrders('Standing', 'ArmanHome');
					}
                }

			flags.SetBool('MS_C3ArmanReturned', True,, 4);
		}

        //Add Italian too
		if (flags.GetBool('C3_Job3_Finished') /*&& !flags.GetBool('MS_C3ArmanDead')*/ && !flags.GetBool('MS_C3ItalianReady'))
		{
		    foreach AllActors(class'ScriptedPawn', pawn, 'Italian')
				pawn.EnterWorld();

			flags.SetBool('MS_C3ItalianReady', True,, 4);
		}

		//Remove the italian again
		if (flags.GetBool('MS_C3ItalianReady') && flags.GetBool('C3_DataAnalysisComplete') && !flags.GetBool('MS_C3ItalianHiddenAgain'))
		{
			foreach AllActors(class'ScriptedPawn', pawn, 'Italian')
				pawn.LeaveWorld();

	    	flags.SetBool('MS_C3ItalianHiddenAgain', True,, 4);
		}

		//Check if the leader was killed
		if (!flags.GetBool('MS_C3WeaponLeader_Killed'))
		{
			count = 0;
			foreach AllActors(class'ScriptedPawn', pawn, 'SmugglersLeader')
				count++;

			if (count == 0)
			{
				Player.GoalCompleted('Club_Job_KillLeader');
				Player.SkillPointsAdd(800);
				flags.SetBool('MS_C3WeaponLeader_Killed', True,, 4);
				flags.SetBool('MS_Global_SmugglersLeaderDead', True,, 8);	
			}
		}

	}

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

    if (localURL == "03_PARIS_LATINQUARTER")
	{
		// =========================== //
		// =========================== //

        //Startup
		if (flags.GetBool('MS_ParisStartUp') && !flags.GetBool('MS_ParisStartUpPlayed'))
		{
		    Player.StartDataLinkTransmission("DL_Startup");
	        flags.SetBool('MS_ParisStartUpPlayed', True,, 4);
        }

		//Data analysis is complete
		if (flags.GetBool('C3_DataAnalysisStarted') && !flags.GetBool('C3_DataAnalysisComplete'))
		{
			Player.StartDataLinkTransmission("DL_AboutDisc2");
	        flags.SetBool('C3_DataAnalysisComplete', True,, 4);
		}

        //Count the cops and HH troops
		if (!flags.GetBool('MS_Global_ParisTroopsRage'))
		{
			count = 0;

			foreach AllActors(class'DeusExCarcass', carc)
			{
				if((carc.Alliance == 'Cops' || carc.Alliance == 'mj12') && carc.KillerBindName == "JCDenton")
					count++;
			}
			
			//Someone is dead
			if (count > 0)
			{
				flags.SetBool('MS_Global_ParisTroopsRage', True,, 4);				
			}
		}
		
		//Check if HH agent is dead
		if(!flags.GetBool('MS_C3_AgentDead'))
		{
			foreach AllActors(class'BiotechAgentCarcass', bioCarc)
			{
				flags.SetBool('MS_C3_AgentDead', True,, 4);
				break;
			}		 	
		}

		//Remove HH agent from the map after the ambush started
		if(flags.GetBool('MS_C3_Ambush_Started') && !flags.GetBool('MS_C3_AgentRemoved'))
		{
			foreach AllActors(class'ScriptedPawn', pawn, 'HHAgent')
				pawn.LeaveWorld();
					
			flags.SetBool('MS_C3_AgentRemoved', True,, 4);	
		}
		
		//Player is suspected
		if (flags.GetBool('MS_Global_ParisTroopsRage') && !flags.GetBool('C3_PlayerSuspected'))
		{
			flags.SetBool('C3_PlayerSuspected', True,, 4);
		}		

        //Count the gun shop cops
		if (!flags.GetBool('MS_Global_ParisTroopsRage') && flags.GetBool('C3_StartShopAmbush'))
		{
			TempCount = 0;

			foreach AllActors(class'ScriptedPawn', pawn, 'GunShopPolice_1')
				TempCount++;

			foreach AllActors(class'ScriptedPawn', pawn, 'GunShopPolice_2')
				TempCount++;


			if (TempCount < 2)
			{
				flags.SetBool('MS_Global_ParisTroopsRage', True,, 4);
			}
		}
		
        //Count the bar cops
		if (!flags.GetBool('MS_Global_ParisTroopsRage') && flags.GetBool('C3_StartBarAmbush'))
		{
			TempCount = 0;

			foreach AllActors(class'ScriptedPawn', pawn, 'BarPolice_1')
				TempCount++;

			foreach AllActors(class'ScriptedPawn', pawn, 'BarPolice_2')
				TempCount++;


			if (TempCount < 2)
			{
				flags.SetBool('MS_Global_ParisTroopsRage', True,, 4);
			}
		}

        //Change the alliance of the troops
		if (flags.GetBool('MS_Global_ParisTroopsRage') && !flags.GetBool('MS_C3ParisTroopsAllianceChanged'))
		{
			foreach AllActors(class'AllianceTrigger', ATrig, 'ChangeTroopsAlliance')
				ATrig.Trigger(None, None);

			foreach AllActors(class'AllianceTrigger', ATrig, 'ChangePostAlliance')
				ATrig.Trigger(None, None);
				
			foreach AllActors(class'SecurityCamera', camera)
				camera.bNoAlarm = false;

			Player.StartDataLinkTransmission("DL_AboutAngryMJ12");

			flags.SetBool('MS_C3ParisTroopsAllianceChanged', True,, 4);
		}

		//Remove barman from club and kill him
		if(flags.GetBool('C3_BarmanShouldDie') && !flags.GetBool('MS_C3BarmanKilled'))
		{
			foreach AllActors(class'SpawnPoint', SP, 'AndreSpawnPoint')
			{
				Spawn(class'AndreCarcass',,, SP.Location, SP.Rotation);
				break;
            }
	                
			flags.SetBool('MS_C3BarmanKilled', True,, 4);
		}

		// =========================== //
		// =========================== //

        //Spawn the police station troops
		if (flags.GetBool('C3_StartPostAmbush') && !flags.GetBool('MS_C3PostAmbushActivated'))
		{
			foreach AllActors(class'Trigger', trig, 'StopMJ12AmbushTrigger')
				trig.SetCollision(True);

		    foreach AllActors(class'ScriptedPawn', pawn)
			{
				if((pawn.Tag == 'AmbushPostMJ12_1') || (pawn.Tag == 'AmbushPostMJ12_2'))
					pawn.EnterWorld();
			}

			flags.SetBool('MS_C3PostAmbushActivated', True,, 4);
		}

        //Spawn the gun shop cops
		if (flags.GetBool('C3_StartShopAmbush') && !flags.GetBool('MS_C3ShopAmbushActivated') && !flags.GetBool('C3_GunshopPanelHacked'))
		{
			foreach AllActors(class'Trigger', trig, 'GunShopTrigger')
				trig.SetCollision(True);

		    foreach AllActors(class'ScriptedPawn', pawn)
			{
				if((pawn.Tag == 'GunShopPolice_1') || (pawn.Tag == 'GunShopPolice_2'))
					pawn.EnterWorld();
			}

			flags.SetBool('MS_C3ShopAmbushActivated', True,, 4);
		}
		
		//Disable the gun shop alarm
		if (flags.GetBool('C3_GunshopPanelHacked') && !flags.GetBool('MS_C3GunshopOffline'))
		{
			foreach AllActors(class'Trigger', trig, 'StartShopAmbush')
			{
				trig.bInitiallyActive = false;				
			}

			foreach AllActors(class'AlarmUnit', alarm, 'GunShopAlarm')
			{
				alarm.bDisabled = true;
				alarm.alarmTimeout = 0;
				alarm.Tag = 'GunShopAlarm1';				
			}
				
			flags.SetBool('MS_C3GunshopOffline', True,, 4);
		}
		
		//Spawn the bar cops
		if (flags.GetBool('C3_StartBarAmbush') && !flags.GetBool('MS_C3BarAmbushActivated'))
		{
			foreach AllActors(class'Trigger', trig, 'BarTrigger')
				trig.SetCollision(True);

		    foreach AllActors(class'ScriptedPawn', pawn)
			{
				if((pawn.Tag == 'BarPolice_1') || (pawn.Tag == 'BarPolice_2'))
					pawn.EnterWorld();
			}

			flags.SetBool('MS_C3BarAmbushActivated', True,, 4);
		}
		
		//Spawn junkie and his friends
		if (flags.GetBool('C3_JunkieSold') && !flags.GetBool('MS_C3_ClubJunkieLeft'))
		{
		    foreach AllActors(class'ScriptedPawn', pawn)
			{
				if((pawn.Tag == 'ClubJunkie') || (pawn.Tag == 'ClubJunkieFriend'))
					pawn.EnterWorld();
			}
			
			foreach AllActors(class'Trigger', trig, 'MeetJunkieTrigger')
				trig.SetCollision(True);

			flags.SetBool('MS_C3_ClubJunkieLeft', True,, 4);
		}
		
		//Enable the junkie ambush trigger
		if (flags.GetBool('C3_JunkieStreetMet') && !flags.GetBool('MS_C3_ClubJunkieAmbushStarted'))
		{
			foreach AllActors(class'Trigger', trig, 'JunkiesTrigger')
				trig.SetCollision(True);
				
			flags.SetBool('MS_C3_ClubJunkieAmbushStarted', True,, 4);
		}
		
		//Unhide MJ12 troops after player has been spotted
		if (flags.GetBool('MS_C3MJ12UnHidden') && !flags.GetBool('MS_C3MJ12Placed'))
		{
			foreach AllActors(class'ScriptedPawn', pawn)
			{
				if((pawn.Tag == 'MJ12Troopers') || (pawn.Tag == 'MJ12Bot'))
					pawn.EnterWorld();
			}
			
			flags.SetBool('MS_C3MJ12Placed', True,, 4);
		}
		
		//Hide the documents at the police station
		if (!flags.GetBool('MS_C3PoliceDocUnSpawned'))
		{
			foreach AllActors(class'FolderBig', folder, 'QuestFolder')
			{
				folder.bHidden = True;
				folder.bHighlight = False;
				folder.bCanBeTaken = False;
			}
			
			foreach AllActors(class'DeusExDecoration', deco, 'QuestFolderNote')
			{
				deco.bHidden = True;
				deco.bHighlight = False;
			}

			flags.SetBool('MS_C3PoliceDocUnSpawned', True,, 4);
		}
		
		//Show the documents at the police station after the task has been received
		if (flags.GetBool('C3_Job2_Played') && !flags.GetBool('MS_C3PoliceDocSpawned'))
		{
			foreach AllActors(class'FolderBig', folder, 'QuestFolder')
			{
				folder.bHidden = False;
				folder.bHighlight = True;
				folder.bCanBeTaken = True;
			}
			
			foreach AllActors(class'DeusExDecoration', deco, 'QuestFolderNote')
			{
				deco.bHidden = False;
				deco.bHighlight = True;
			}

			flags.SetBool('MS_C3PoliceDocSpawned', True,, 4);
		}
		
            /// --+==Trader==+-- \\\

	        if (flags.GetBool('C3_OrderedKitBombs') && !flags.GetBool('MS_C3Buy_Grenades_Spawned'))
	        {
		        foreach AllActors(class'SpawnPoint', SP, 'BuyPoint_Grenades_1')
                {
                      loc = SP.Location;
                      rot = SP.Rotation;
                      Spawn(class'WeaponLAMGrenade',,, loc, rot);
                }

		        foreach AllActors(class'SpawnPoint', SP, 'BuyPoint_Grenades_2')
                {
                      loc = SP.Location;
                      rot = SP.Rotation;
                      Spawn(class'WeaponPulseGrenade',,, loc, rot);
                }

		        foreach AllActors(class'SpawnPoint', SP, 'BuyPoint_Grenades_3')
                {
                      loc = SP.Location;
                      rot = SP.Rotation;
                      Spawn(class'WeaponPulseGrenade',,, loc, rot);
                }

				flags.SetBool('MS_C3Buy_Grenades_Spawned', True,, 4);
	        }

	        if (flags.GetBool('C3_OrderedKitSniper') && !flags.GetBool('MS_C3Buy_Sniper_Spawned'))
	        {
		        foreach AllActors(class'SpawnPoint', SP, 'BuyPoint_Sniper_1')
                {
                      loc = SP.Location;
                      Spawn(class'WeaponSniperRifle',,, loc);
                }

		        foreach AllActors(class'SpawnPoint', SP, 'BuyPoint_Sniper_2')
                {
                      loc = SP.Location;
                      rot = SP.Rotation;
                      Spawn(class'RAmmo3006',,, loc, rot);
                }

		        foreach AllActors(class'SpawnPoint', SP, 'BuyPoint_Sniper_3')
                {
                      loc = SP.Location;
                      rot = SP.Rotation;
                      Spawn(class'NightVision',,, loc, rot);
                }

				flags.SetBool('MS_C3Buy_Sniper_Spawned', True,, 4);
	        }

	        if (flags.GetBool('C3_OrderedKitAmmo') && !flags.GetBool('MS_C3Buy_Ammo_Spawned'))
	        {
		        foreach AllActors(class'SpawnPoint', SP, 'BuyPoint_Ammo_1')
                {
                      loc = SP.Location;
                      rot = SP.Rotation;
                      Spawn(class'RAmmo556mm',,, loc, rot);
                }

		        foreach AllActors(class'SpawnPoint', SP, 'BuyPoint_Ammo_2')
                {
                      loc = SP.Location;
                      rot = SP.Rotation;
                      Spawn(class'RAmmo556mm',,, loc, rot);
                }

		        foreach AllActors(class'SpawnPoint', SP, 'BuyPoint_Ammo_3')
                {
                      loc = SP.Location;
                      rot = SP.Rotation;
                      Spawn(class'RAmmo556mm',,, loc, rot);
                }

				flags.SetBool('MS_C3Buy_Ammo_Spawned', True,, 4);
	        }

	        if (flags.GetBool('C3_OrderedKitMods') && !flags.GetBool('MS_C3Buy_Tools_Spawned'))
	        {
		        foreach AllActors(class'SpawnPoint', SP, 'BuyPoint_Tools_1')
                {
                      loc = SP.Location;
                      rot = SP.Rotation;
                      Spawn(class'WeaponModAccuracy',,, loc, rot);
                }

				flags.SetBool('MS_C3Buy_Tools_Spawned', True,, 4);
	        }

			if (flags.GetBool('C3_OrderedKitMedic') && !flags.GetBool('MS_C3Buy_Medic_Spawned'))
	        {
	        	foreach AllActors(class'Keypad', pad, 'MedBotKeypad')
				{
					pad.bAlwaysWrong = False;
					break;
				}
			
	        	flags.SetBool('MS_C3Buy_Medic_Spawned', True,, 4);
	        }

            ///==========================\\\
	}

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

    if (localURL == "03_PARIS_CLUB")
	{
		if(!flags.GetBool('MS_C3ClubVisited'))
		{
			flags.SetBool('MS_C3ClubVisited', True,, 4);
		}
		
		//Enable the convo trigger after the first convo with Arman
		if (flags.GetBool('C3_ArmanFirstMeetPlayed') && !flags.GetBool('MS_C3_ArmanFirstMeetPlayed'))
		{			
			foreach AllActors(class'Trigger', trig, 'ArmanCoupleConvo')
				trig.SetCollision(True);
				
			flags.SetBool('MS_C3_ArmanFirstMeetPlayed', True,, 4);
		}
							
        //Add black gang leader if he was saved
		if ((flags.GetBool('C3_Job_Prison_Done') && !flags.GetBool('C3_Job_Prison_Died')) && !flags.GetBool('MS_C3ClubBlackLeaderUnHidden'))
		{
		    foreach AllActors(class'ScriptedPawn', pawn)
				if(pawn.Tag == 'BlackGandLeader')
					pawn.EnterWorld();

			foreach AllActors(class'Trigger', trig, 'BlackGangTrig_1')
				trig.SetCollision(False);

			foreach AllActors(class'Trigger', trig, 'BlackGangTrig_2')
				trig.SetCollision(True);

	        flags.SetBool('MS_C3ClubBlackLeaderUnHidden', True,, 4);
		}

		//Remove the black gang if they gone to the old quarter
		if(flags.GetBool('MS_C3Job3Ready') && !flags.GetBool('MS_C3_BlackGang_LeavedClub'))
		{
			foreach AllActors(class'ScriptedPawn', pawn)
				if(pawn.Tag == 'BlackGandLeader' || pawn.Tag == 'BlackGangMember' || pawn.Tag == 'Gerard')
					pawn.LeaveWorld();
					
			flags.SetBool('MS_C3_BlackGang_LeavedClub', True,, 4);
		}

		//Add italian back when Aram leaves the club
		if (!flags.GetBool('MS_C3ItalianReady') && flags.GetBool('MS_C3ArmanDeletedFromClub') && !flags.GetBool('MS_C3ClubItalianUnHidden'))
		{
			foreach AllActors(class'ScriptedPawn', pawn, 'Italian')
				pawn.EnterWorld();

	    	flags.SetBool('MS_C3ClubItalianUnHidden', True,, 4);
		}
		
		//No gangs in the club
		if(flags.GetBool('MS_C3_BlackGang_LeavedClub') && flags.GetBool('MS_C3ArmanDeletedFromClub') && !flags.GetBool('MS_C3_ClubIsEmpty'))
		{
			flags.SetBool('MS_C3_ClubIsEmpty', True,, 4);
		}
		
		//Barman is dead
		if(flags.GetBool('MS_C3BarmanKilled') && !flags.GetBool('MS_C3BarmanRemoved'))
		{
			foreach AllActors(class'ScriptedPawn', pawn, 'Andre')
				pawn.LeaveWorld();
					
			flags.SetBool('MS_C3BarmanRemoved', True,, 4);
		}
		
		if (flags.GetBool('MS_C3WeaponLeader_Killed') && flags.GetBool('MS_C3Killer_Done') && flags.GetBool('MS_C3ClubBlackLeaderUnHidden') && !flags.GetBool('MS_C3_BlackGang_LeavedClub') && !flags.GetBool('MS_C3Aug_Spawned'))
        {
	        foreach AllActors(class'SpawnPoint', SP, 'AugSpawnPoint')
            {
                  aug = Spawn(class'AugmentationCannister',,, SP.Location);
                  
                  if(aug != None)
                  {
                  		aug.AddAugs[0] = 'AugEnviro';
                  }
            }
            
            flags.SetBool('MS_C3Aug_Spawned', True,, 4);
        }
	}

	//------------------------------------------------------------------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------------------------------------------------------------------

    if (localURL == "03_PARIS_LAB")
	{
		//Startup
		if (!flags.GetBool('MS_LabStartUp'))
		{
		    Player.StartDataLinkTransmission("DL_AtLab");
	        flags.SetBool('MS_LabStartUp', True,, 4);
        }
        
        //Kill the scuba diver
		if (!flags.GetBool('MS_C3_ScubasKilled'))
		{
			foreach AllActors(class'ScriptedPawn', pawn)
			{
				if (pawn.BindName == "ScubaDiver")
                {
					pawn.Health = 1;
					pawn.TakeDamage(10, pawn, pawn.Location, vect(0,0,0), 'PoisonGas');
                }
			}

			flags.SetBool('MS_C3_ScubasKilled', True,, 4);
		}

		foreach AllActors(class'Button1', but)
		{
			if(!flags.GetBool('C3_Containment_CanUseMiddle'))
			{
				if ((but.Tag == 'ContainementButtonIn' || but.Tag == 'ContainementButtonOut' || but.Tag == 'ContainementButton') && but.isPressed == False)
                {
					but.buttonLitTime = 1;
					but.buttonSound1 = Sound'DeusExSounds.Generic.Buzz1';
                }
			}
			else
			{
				if ((but.Tag == 'ContainementButtonIn' || but.Tag == 'ContainementButtonOut' || but.Tag == 'ContainementButton') && but.isPressed == False)
                {
					if(but.Tag == 'ContainementButton')
						but.buttonLitTime = ContainmentLength2;
					else
						but.buttonLitTime = ContainmentLength;

					but.buttonSound1 = Sound'DeusExSounds.Generic.Beep1';
                }
			}
		}
	}
}

defaultproperties
{
	bAutosave=True
	AutosaveName="Paris"
}