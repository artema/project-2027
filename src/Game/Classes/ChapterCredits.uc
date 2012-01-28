//=============================================================================//
//                              Титры                                          //
//                    Сделанно Ded'ом для мода 2027                            //
//                                                                             //
//                             Credits                                         //
//                      Copyright (C) 2004 Ded                                 //
//=============================================================================//
class ChapterCredits extends MissionScript;

// ----------------------------------------------------------------------
// FirstFrame()
// 
// Stuff to check at first frame
// ----------------------------------------------------------------------

function FirstFrame()
{
	Super.FirstFrame();

	if (Player != None)
		DeusExRootWindow(Player.rootWindow).ResetFlags();
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
// Timer()
//
// Main state machine for the mission
// ----------------------------------------------------------------------

function Timer()
{
	Super.Timer();

	FinishCinematic();

}

// ----------------------------------------------------------------------
// FinishCinematic()
// ----------------------------------------------------------------------

function FinishCinematic()
{
	local CameraPoint cPoint;
	local TruePlayer TPlayer;

	foreach player.AllActors(class'CameraPoint', cPoint)
		cPoint.nextPoint = None;

	SetTimer(0, False);


	TPlayer = TruePlayer(GetPlayerPawn());
	TPlayer.ShowCredits(True);
}

defaultproperties
{
}
