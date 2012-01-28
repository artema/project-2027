//=============================================================================
// 12мм гильза - Ўрапнель. —деланно Ded'ом дл€ мода 2027
// 12mm shell - Buckshot. Copyright (C) 2003 Ded 
// јвтор модели/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class ShellBuckshot extends Shell;

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
     Fragments(0)=LodMesh'GameMedia.12mmBShell'
     numFragmentTypes=1
     elasticity=0.400000
     ImpactSound=Sound'GameMedia.Weapons.ShotGunShell'
     MiscSound=Sound'GameMedia.Weapons.ShotGunShell'
     Mesh=LodMesh'GameMedia.12mmBShell'
     CollisionRadius=2.570000
     CollisionHeight=0.620000
}
