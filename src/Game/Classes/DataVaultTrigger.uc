//======================================================================
// Триггер для изображений. Автор - Steve Tack
// Datavault trigger.  Copyright (C) 2003 Steve Tack
//======================================================================
class DataVaultTrigger extends Trigger;

var() Class<Inventory> transferItem;
var localized String msgImageAdded;

singular function Trigger(Actor Other, Pawn Instigator)
{
     local Inventory invItemTo;
     local DeusExPlayer player;

     local ConPlay con;
     local ConWindowActive cw;

	if (transferItem != None)
	{
		player = DeusExPlayer(GetPlayerPawn());

		if (player != None)
		{
			invItemTo = Spawn(transferItem);

			if (invItemTo.IsA('DataVaultImage'))
			{
				invItemTo.GiveTo(player);
				player.AddImage(DataVaultImage(invItemTo));
                                player.ClientMessage(Sprintf(msgImageAdded));

                     con = player.conPlay;
                     cw = con.conWinThird;
                     cw.ShowReceivedItem(invItemTo, 1);

			}
			else	
			{	
				invItemTo.GiveTo(player);
				player.UpdateBeltText(invItemTo);
                                player.ClientMessage(Sprintf(msgImageAdded));

                     con = player.conPlay;
                     cw = con.conWinThird;
                     cw.ShowReceivedItem(invItemTo, 1);
			}

		}
	}



}

defaultproperties
{
     msgImageAdded="Получено изображение - Сверьтесь с базой данных"
     bTriggerOnceOnly=True
     CollisionRadius=0.000000
}
