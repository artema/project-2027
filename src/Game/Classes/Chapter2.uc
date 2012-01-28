class Chapter2 expands MissionScript;

function InitStateMachine()
{
    super.InitStateMachine();
    FirstFrame();
}

function FirstFrame()
{
	Super.FirstFrame();
}

function PreTravel()
{
	Super.PreTravel();
}

function Timer()
{
	local int count;
	local Inventory item, nextItem;
	local DeusExDecoration deco;
	local MagnusAthersJrCarcass MagnusCarc;
	local Dispatcher disp;
	
	Super.Timer();

	if (localURL == "02_WASHINGTON_CIA")
	{
        //Startup
		if (!flags.GetBool('MS_CIAStartUp'))
		{
		    //Player.StartDataLinkTransmission("DL_CIAStartup");

			foreach AllActors(class'Dispatcher', disp, 'StartupDispatcher')
				disp.Trigger(None, None);

			Player.bProcessingData = False;
			
			Player.RestoreAllHealth();			
			Player.GenerateTotalHealth();

			Player.SetInHandPending(None);
			Player.SetInHand(None);
		
			Player.bInHandTransition = False;
			
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
			
			flags.SetBool('MS_CIAStartUp', True,, 6);
        }
        
        //Check if player "killed" Magnus
		if (!flags.GetBool('MS_Global_MagnusWasAttacked'))
		{
			count = 0;
			
        	foreach AllActors(class'MagnusAthersJrCarcass', MagnusCarc)
			{
				if (MagnusCarc.KillerBindName == "JCDenton")
					count++;
			}
			
			if(count >= 1)
			{
				flags.SetBool('MS_Global_MagnusWasAttacked', True,, 7);
			}
		}
        
        //------------------------------------------------------------------------------------------------------------------------------------------------------------
		//------------------------------------------------------------------------------------------------------------------------------------------------------------
		
		//Start the data analysis
		if (flags.GetBool('C3_TitanHack') && !flags.GetBool('MS_C2_DataAnalysisStarted'))
		{
			foreach AllActors(class'DeusExDecoration', deco, 'HackComputer')
			{
				deco.bHighlight = False;
				break;
			}
			
			
			Player.StartProcessingDataMax();
			flags.SetBool('MS_C2_DataAnalysisStarted', True,, 4);
		}
	}
}
// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
}