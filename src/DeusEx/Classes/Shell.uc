//=======================================================
// ������. �������� Ded'�� ��� ���� 2027
// Shell. Copyright (C) 2003 Ded
//=======================================================
class Shell extends DeusExFragment
     abstract;

function PostBeginPlay()
{
     local DeusExPlayer player;

	Super.PostBeginPlay();

     player = DeusExPlayer(GetPlayerPawn());

     if (player.bNoResurrection)
     {
        LifeSpan=2.000000;
	LifeSpan += FRand()*4.0;
     }
     else
     {
        LifeSpan=10.000000 + (FRand()*4.0);
     }
}

defaultproperties
{
     LifeSpan=10.000000
}
