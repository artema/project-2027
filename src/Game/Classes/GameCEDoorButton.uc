//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// I just renamed all Carone elevator files, so they work even if the HC mod is installed.
// -- Ded
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

//=============================================================================
// CEDoorButton. A button that opens the Doors of a CaroneElevator
// Put the Tag of the CaroneElevator in Event!!
//=============================================================================
class GameCEDoorButton extends Button1;


function Frob(Actor Frobber, Inventory frobWith)
{
	local GameCaroneElevator CE;
	local Pawn P;
	
	P = Pawn(Frobber);

	Super.Frob(Frobber, frobWith);

	foreach AllActors(class 'GameCaroneElevator', CE, Event)
			{
			CE.CEGetMoverInfo();
			CE.CECheckSlave();
			if ((!CE.bIsMoving) && (CE.bCESlaveClosed) && (CE.bCEDoorsClosed))
				{
					CE.bCESlaveClosed=false;
					CE.bCEDoorsClosed=false;
					CE.CETrigger();
					CE.CESlaveTrigger();
				}
			else if ((!CE.bIsMoving) && (CE.bCESlaveOpen) && (CE.bCEDoorsOpen))
				{
					CE.bCESlaveOpen=false;
					CE.bCEDoorsOpen=false;
					CE.CETrigger();
					CE.CESlaveTrigger();
				}

			}
}
defaultproperties
{
}
