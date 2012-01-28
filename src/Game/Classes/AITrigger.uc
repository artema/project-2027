//=============================================================================
// AI �������. ������� Ded'�� ��� ���� 2027
// AI trigger. Copyright (C) 2003 Ded
//=============================================================================
class AITrigger expands Trigger;

var() Bool bPawnDefendHome;
var() Bool bPawnDrawnWeapon;
var() Bool bPawnAvoidAim;
var() name NewHomeBase;
var() float    MaxRange;
var() float    MinRange;

function Trigger(Actor Other, Pawn Instigator)
{
	if (StartPatrolling())
	{
		Super.Trigger(Other, Instigator);

		if (bTriggerOnceOnly)
			Destroy();
	}
}

singular function Touch(Actor Other)
{
	if (!IsRelevant(Other))
		return;

	if (StartPatrolling())
		if (bTriggerOnceOnly)
			Destroy();
}

function bool StartPatrolling()
{
	local ScriptedPawn P;

	if (Event != '')
    {
		foreach AllActors (class'ScriptedPawn', P, Event)
        {
			  P.bDefendHome = bPawnDefendHome;
			  P.bKeepWeaponDrawn = bPawnDrawnWeapon;
			  P.bAvoidAim = bPawnAvoidAim;

			  if(MaxRange != -1)
			  {
			      P.MaxRange = MaxRange;
			  }
			  
			  if(MinRange != -1)
			  {
			      P.MinRange = MinRange;
			  }

	          if (NewHomeBase != '')
              {
				  P.bUseHome = False;
				  P.HomeTag = NewHomeBase;
				  P.InitializeHomeBase();
              }
		}
    }

	return True;
}

defaultproperties
{
	 MinRange=-1
	 MaxRange=-1
     bTriggerOnceOnly=True
     CollisionRadius=96.000000
}
