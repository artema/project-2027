//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// I just renamed all Carone elevator files, so they work even if the HC mod is installed.
// -- Ded
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

//=============================================================================
// CESequenceDispatcher: receives one trigger (corresponding to its name) as input, 
// then triggers a set of specified Sequence-events with optional delays.
// Modified by Carone
//=============================================================================
class GameCESequenceDispatcher extends Triggers;


//-----------------------------------------------------------------------------
// Dispatcher variables.

var() float CEOutDelays[8]; // Relative delays before generating events.
var() int   CESeqnums[8];   // Keyframe.
var int i;                // Internal counter.

//=============================================================================
// Dispatcher logic.

//
// When dispatcher is triggered...
//
function Trigger( actor Other, pawn EventInstigator )
{
	Instigator = EventInstigator;
	gotostate('Dispatch');
}


function CESendSeqEvent()
{

local Mover M;

	if (Event != '')
			foreach AllActors(class'Mover', M, Event)
			{
				if (GameCaroneElevator(M) !=None)
					GameCaroneElevator(M).SetSeq(CESeqNums[i]);
				if (MultiMover(M) != None)
					MultiMover(M).SetSeq(CESeqNums[i]);
				else if (ElevatorMover(M) != None)
					ElevatorMover(M).SetSeq(CESeqNums[i]);
			}
}



//
// Dispatch events.
//
state Dispatch
{
Begin:
	disable('Trigger');
	for( i=0; i<ArrayCount(CESeqnums); i++ )
	{
		if ((CESeqnums[i] != -1) && ( CESeqnums[i] < 8 ))
		{
			Sleep( CEOutDelays[i] );

			CESendSeqEvent();
			
		}
	}
	enable('Trigger');
}

defaultproperties
{
    CESeqnums(0)=-1
    CESeqnums(1)=-1
    CESeqnums(2)=-1
    CESeqnums(3)=-1
    CESeqnums(4)=-1
    CESeqnums(5)=-1
    CESeqnums(6)=-1
    CESeqnums(7)=-1
    Texture=Texture'Engine.S_Dispatcher'
}
