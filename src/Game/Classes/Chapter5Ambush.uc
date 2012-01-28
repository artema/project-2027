class Chapter5Ambush expands CutSceneScript;

// ----------------------------------------------------------------------
// FirstFrame()
// 
// Stuff to check at first frame
// ----------------------------------------------------------------------
function FirstFrame()
{
	local MapExit exit;
	
	Super.FirstFrame();

	flags.SetBool('MS_StartFinalAmbush', True, True, 6);

    //Not met Vlad, so we know Omars
    //Default: Go to Moscow (metro)
	if(!flags.GetBool('MS_Global_VladimirComplete'))
	{
		foreach AllActors(class'MapExit', exit, 'ExitAmbushMap')
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
	    	foreach AllActors(class'MapExit', exit, 'ExitAmbushMap')
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
    			foreach AllActors(class'MapExit', exit, 'ExitAmbushMap')
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
    			foreach AllActors(class'MapExit', exit, 'ExitAmbushMap')
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

// ----------------------------------------------------------------------
// Timer()
//
// Main state machine for the mission
// ----------------------------------------------------------------------

function Timer()
{
	local Dispatcher disp;

	Super.Timer();

		if (flags.GetBool('MS_StartFinalAmbush'))
		{
                    foreach AllActors(class'Dispatcher', disp, 'AmbushPatcher')
		           disp.Trigger(None, None);
                }
}

// ----------------------------------------------------------------------
// PreTravel()
// 
// Set flags upon exit of a certain map
// ----------------------------------------------------------------------

function PreTravel()
{
	Super.PreTravel();
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
}
