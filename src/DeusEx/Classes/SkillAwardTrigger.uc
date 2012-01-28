//=============================================================================
// SkillAwardTrigger.
//=============================================================================
class SkillAwardTrigger expands Trigger;

// Gives the player skill points when touched or triggered
// Set bCollideActors to False to make it triggered

enum EMessage
{
	MSG_CustomMessage,
	MSG_ExplorationBonus,
	MSG_AreaLocationBonus,
	MSG_BonusForCreativity,
	MSG_PrimaryGoalComplete,
	MSG_SecondaryGoalComplete
};

var() int skillPointsAdded;
var() localized String awardMessage;
var() EMessage Message;

var localized String msgExplorationBonus;
var localized String msgAreaLocationBonus;
var localized String msgBonusForCreativity;
var localized String msgPrimaryGoalComplete;
var localized String msgSecondaryGoalComplete;

function Trigger(Actor Other, Pawn Instigator)
{
	local DeusExPlayer player;

	Super.Trigger(Other, Instigator);

	player = DeusExPlayer(GetPlayerPawn());

	if (player != None)
	{
		player.SkillPointsAdd(skillPointsAdded);

		if(Message == MSG_CustomMessage && awardMessage != "")
			player.ClientMessage(awardMessage);
		else
			player.ClientMessage(GetMessage(Message));
	}

	if( bTriggerOnceOnly )
		Tag='SkillAwardTrigger';
}

function Touch(Actor Other)
{
	local DeusExPlayer player;

	Super.Touch(Other);

	if (IsRelevant(Other))
	{
		player = DeusExPlayer(GetPlayerPawn());

		if (player != None)
		{
			player.SkillPointsAdd(skillPointsAdded);

			if(Message == MSG_CustomMessage && awardMessage != "")
				player.ClientMessage(awardMessage);
			else
				player.ClientMessage(GetMessage(Message));
		}
	}
}

function String GetMessage(EMessage messageType)
{
	switch(messageType)
	{
		case MSG_ExplorationBonus:
			return msgExplorationBonus;

		case MSG_AreaLocationBonus:
			return msgAreaLocationBonus;

		case MSG_BonusForCreativity:
			return msgBonusForCreativity;

		case MSG_PrimaryGoalComplete:
			return msgPrimaryGoalComplete;

		case MSG_SecondaryGoalComplete:
			return msgSecondaryGoalComplete;
	}

	return "";
}

defaultproperties
{
     skillPointsAdded=100
     awardMessage=""
     bTriggerOnceOnly=True
     msgExplorationBonus="Exploration bonus"
     msgAreaLocationBonus="Area location bonus"
     msgBonusForCreativity="Bonus for creativity"
     msgPrimaryGoalComplete="Primary goal complete bonus"
     msgSecondaryGoalComplete="Secondary goal complete bonus"
}
