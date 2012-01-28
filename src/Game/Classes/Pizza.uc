//=============================================================================
// �����. ������� Ded'�� ��� ���� 2027
// Pizza. Copyright (C) 2003 Ded
// ����� ������/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class Pizza extends DeusExDecoration;

var localized String msgActivated;
var localized String msgnoperk;
var localized String msgyesperk;

function Frob(Actor Frobber, Inventory frobWith)
{
	local DeusExPlayer player;
	local Actor A;

	Player = DeusExPlayer(Frobber);

	if (Player != None)
	{
		Player.ClientMessage(msgActivated);
		player.HealPlayer(8, False);
		PlaySound(sound'GameMedia.Misc.FoodSound');
		
		if(Event != '')
			foreach AllActors(class 'Actor', A, Event)
				A.Trigger(Self, Pawn(Frobber));
		
		Destroy();
	}
}

defaultproperties
{
     bInvincible=True
     bPushable=False
     FragType=Class'DeusEx.PaperFragment'
     HitPoints=25
     Mesh=LodMesh'GameMedia.Pizza'
     bBlockActors=True
     CollisionRadius=11.000000
     CollisionHeight=0.400000
     Mass=15.000000
     Buoyancy=5.000000
}
