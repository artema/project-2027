//=============================================================================
// ���� ������� ������. ������� Ded'�� ��� ���� 2027
// NoWeapons zone. Copyright (C) 2005 Ded
//=============================================================================
class NoWeaponsZone expands ZoneInfo;

var() name PointName;

event ActorEntered(actor Other)
{
	local DeusExPlayer player;
	local Inventory item, nextItem;
	local SpawnPoint SP;
	local actor A;

	player = DeusExPlayer(GetPlayerPawn());

	if(Pawn(Other)!=None && Pawn(Other).bIsPlayer)
		if( ++ZonePlayerCount==1 && ZonePlayerEvent!='' )
			foreach AllActors( class 'Actor', A, ZonePlayerEvent )
				A.Trigger( Self, Pawn(Other) );


	if (Other.IsA('DeusExWeapon') || Other.IsA('SupportBotContainer'))
	{
		foreach AllActors(class'SpawnPoint', SP, PointName)
		{
			Other.SetLocation(SP.Location);
			Other.SetRotation(SP.Rotation);
		}
	}
	else if (Other.IsA('DeusExProjectile') || Other.IsA('DeusExDecoration'))
	{
		Other.Destroy();
	}
	else if (Other.IsA('DeusExPlayer'))
	{
		if (Player.Inventory != None)
		{
			item      = Player.Inventory;
			nextItem  = None;
			
			foreach AllActors(class'SpawnPoint', SP, PointName)
			{
				while((item != None) && (item.IsA('NanoKeyRing') || (!item.bDisplayableInv)))
					item = item.Inventory;
	
				if (item != None)
				{
					nextItem = item.Inventory;
					
					if (item.IsA('DeusExWeapon') || item.IsA('SupportBotContainer'))
					{
						Player.DeleteInventory(item);
						item.DropFrom(SP.Location);
					}
				}
					
				if (nextItem == None)
					break;	
				else
					item = nextItem;
			}
		}
	}
}

defaultproperties
{
     PointName="player_wpn"
}
