//=============================================================================
// 3006 гильза. Сделанно Ded'ом для мода 2027
// 3006 shell. Copyright (C) 2003 Ded 
// Автор модели/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class Shell3006 extends Shell;

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
     Fragments(0)=LodMesh'GameMedia.3006Shell'
     numFragmentTypes=1
     elasticity=0.400000
     ImpactSound=Sound'GameMedia.Weapons.Shell1'
     MiscSound=Sound'GameMedia.Weapons.Shell1'
     Mesh=LodMesh'GameMedia.3006Shell'
     CollisionRadius=0.600000
     CollisionHeight=0.300000
}
