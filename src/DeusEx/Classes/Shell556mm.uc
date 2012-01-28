//=============================================================================
// 5.56мм гильза. Сделанно Ded'ом для мода 2027
// 5.56mm shell. Copyright (C) 2003 Ded 
// Автор модели/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class Shell556mm extends Shell;

function PostBeginPlay()
{
     local DeusExPlayer player;

	Super.PostBeginPlay();

     player = DeusExPlayer(GetPlayerPawn());

     if (player.bNoResurrection)
     {
         Fragments[0]=LodMesh'DeusExItems.ShellCasing';
         Mesh=LodMesh'DeusExItems.ShellCasing';
     }
}

defaultproperties
{
     Fragments(0)=LodMesh'GameMedia.556mmShell'
     numFragmentTypes=1
     ImpactSound=Sound'GameMedia.Weapons.Shell2'
     MiscSound=Sound'GameMedia.Weapons.Shell2'
     Mesh=LodMesh'GameMedia.556mmShell'
     CollisionRadius=0.600000
     CollisionHeight=0.300000
}
