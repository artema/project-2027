//=============================================================================
// Триггер диалога. Сделанно Ded'ом для мода 2027
// Convo trigger. Copyright (C) 2003 Ded
//=============================================================================
class CutConvoTrigger extends Trigger;

var() name conversationTag;
var() string BindName;
var() name checkFlag;
var() bool bCheckFalse;
var() bool bConAvoidState;
var() bool bConForcePlay;

singular function Trigger(Actor Other, Pawn Instigator)
{
	local DeusExPlayer player;
	local bool bSuccess;
	local Actor A, conOwner;

	player = DeusExPlayer(Instigator);
	bSuccess = True;

	if (player == None)
		return;

	if (checkFlag != '')
	{
		if (!player.flagBase.GetBool(checkFlag))
			bSuccess = bCheckFalse;
		else
			bSuccess = !bCheckFalse;
	}

	if ((BindName != "") && (conversationTag != ''))
	{
		foreach AllActors(class'Actor', A)
			if (A.BindName == BindName)
			{
				conOwner = A;
				break;
			}
			

		if (bSuccess)
			if (player.StartConversationByName(conversationTag, conOwner, bConAvoidState, bConForcePlay))
				Super.Trigger(Other, Instigator);
	}
}

singular function Touch(Actor Other)
{
	local DeusExPlayer player;
	local bool bSuccess;
	local Actor A, conOwner;

	player = DeusExPlayer(Other);
	bSuccess = True;

	if (player == None)
		return;

	if (checkFlag != '')
	{
		if (!player.flagBase.GetBool(checkFlag))
			bSuccess = bCheckFalse;
		else
			bSuccess = !bCheckFalse;
	}

	if ((BindName != "") && (conversationTag != ''))
	{
		foreach AllActors(class'Actor', A)
			if (A.BindName == BindName)
			{
				conOwner = A;
				break;
			}
			

		if (bSuccess)
			if (player.StartConversationByName(conversationTag, conOwner, bConAvoidState, bConForcePlay))
				Super.Touch(Other);
	}
}

defaultproperties
{
     bTriggerOnceOnly=True
     CollisionRadius=96.000000
}
