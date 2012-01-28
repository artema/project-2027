//=============================================================================
// 12мм гильза - Сабот. Сделанно Ded'ом для мода 2027
// 12mm shell - Sabot. Copyright (C) 2003 Ded 
// Автор модели/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class ShellSabot extends Shell;

function PostBeginPlay()
{
     local DeusExPlayer player;

	Super.PostBeginPlay();

     player = DeusExPlayer(GetPlayerPawn());

     if (player.bNoResurrection)
     {
         Fragments[0]=LodMesh'DeusExItems.ShellCasing2';
         Mesh=LodMesh'DeusExItems.ShellCasing2';
     }
}

defaultproperties
{
     Fragments(0)=LodMesh'GameMedia.12mmSShell'
     numFragmentTypes=1
     elasticity=0.400000
     ImpactSound=Sound'GameMedia.Weapons.ShotGunShell'
     MiscSound=Sound'GameMedia.Weapons.ShotGunShell'
     Mesh=LodMesh'GameMedia.12mmSShell'
     CollisionRadius=2.570000
     CollisionHeight=0.620000
}
