//=============================================================================
// AI триггер. Сделано Ded'ом для мода 2027
// AI trigger. Copyright (C) 2003 Ded
//=============================================================================
class DoorBlockTrigger expands Trigger;

var bool bLocked;
var bool bPickable;
var bool bIsDoor;

var() name unTriggerEvent;

function PostBeginPlay()
{
	local DeusExMover M;

	if(Event != '')
	{
		foreach AllActors(class'DeusExMover', M, Event)
		{
			bLocked = M.bLocked;
			bPickable = M.bPickable;
			bIsDoor = M.bIsDoor;
		}
	}
		
	Super.PostBeginPlay();
}

function Touch(Actor Other)
{
	local DeusExMover M;

	if (!IsRelevant(Other))
		return;

	if(Event != '')
	{
		foreach AllActors(class'DeusExMover', M, Event)
		{
			M.bLocked = true;
			M.bPickable = false;
			M.bIsDoor = false;
			M.bHighlight = false;
			M.bFrobbable = false;
		}
	}
}

function UnTouch(Actor Other)
{
	local DeusExMover M;
	local Actor A;

	if (!IsRelevant(Other))
		return;

	if(Event != '')
	{
		foreach AllActors(class'DeusExMover', M, Event)
		{
			M.bLocked = bLocked;
			M.bPickable = bPickable;
			M.bIsDoor = bIsDoor;
			M.bHighlight = true;
			M.bFrobbable = true;
		}

		if(unTriggerEvent != '')
		{
			foreach AllActors(class'Actor', A, unTriggerEvent)
				A.Trigger(Other, GetPlayerPawn());
		}
	}
}

function Trigger(Actor Other, Pawn Instigator)
{
	Super.Trigger(Other, Instigator);
}

function UnTrigger(Actor Other, Pawn Instigator)
{
	Super.UnTrigger(Other, Instigator);
}

defaultproperties
{
}
