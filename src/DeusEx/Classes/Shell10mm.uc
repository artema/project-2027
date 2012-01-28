//=============================================================================
// 10мм гильза. Сделанно Ded'ом для мода 2027
// 10mm shell. Copyright (C) 2003 Ded
// Автор модели/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class Shell10mm extends Shell;

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
     Fragments(0)=LodMesh'GameMedia.10mmShell'
     numFragmentTypes=1
     ImpactSound=Sound'GameMedia.Weapons.Shell2'
     MiscSound=Sound'GameMedia.Weapons.Shell2'
     Mesh=LodMesh'GameMedia.10mmShell'
     CollisionRadius=0.600000
     CollisionHeight=0.300000
}
