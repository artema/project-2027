//=============================================================================
// ����������� �����. �������� Ded'�� ��� ���� 2027
// Card Reader. Copyright (C) 2003 Ded
//=============================================================================
class CardReader extends ElectronicDevices;

var() name KeyIDNeeded;

var localized String msgNoKey;
var localized String msgUseKey;

var DeusExPlayer Player;

function Frob(Actor Frobber, Inventory frobWith)
{
	local DeusExPlayer Player;
	
	Player = DeusExPlayer(GetPlayerPawn());
	
	if (frobWith != None && frobWith.IsA('NanoKeyRing'))
	{
		if ((KeyIDNeeded != ''))
		{
			NanoKeyRing(frobWith).PlayUseAnim();
			
			if (NanoKeyRing(frobWith).HasKey(KeyIDNeeded))
			{
	        	RunEvent(player);
				PlaySound(Sound'DeusExSounds.Generic.Beep3', SLOT_Misc, 4,, 512);
			}
	        else
	        {
			   Player.ClientMessage(msgNoKey);
			   PlaySound(Sound'DeusExSounds.Generic.Buzz1', SLOT_Misc, 4,, 512);
	        }	
		}
	}
	else
	{
		Player.ClientMessage(msgUseKey);
	}
}

// ----------------------------------------------------------------------
// RunEvent()
// ----------------------------------------------------------------------
function RunEvent(DeusExPlayer Player)
{
   local Actor A;

   if (Event != '')
   {
      foreach AllActors(class 'Actor', A, Event)
         A.Trigger(Self, Player);
   }
}

defaultproperties
{
     Physics=PHYS_None
     Rotation=(Roll=49134)
     Mesh=LodMesh'DeusExDeco.CardReader'
     bCollideWorld=False
     CollisionRadius=4.000000
     CollisionHeight=7.000000
     Mass=5.000000
     Buoyancy=5.000000
}
