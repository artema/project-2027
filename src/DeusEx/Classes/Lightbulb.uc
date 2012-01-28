//=============================================================================
// Lightbulb.
//=============================================================================
class Lightbulb extends DeusExDecoration;

simulated function Tick(float deltaTime)
{
     local DeusExPlayer player;

      Super.Tick(deltaTime);

     player = DeusExPlayer(GetPlayerPawn());

     if (player.bNoResurrection)
     {
         bUnlit=True;
         Mesh=LodMesh'DeusExDeco.Lightbulb';
     }
     else
     {
         bUnlit=False;
         Mesh=LodMesh'GameMedia.Lightlamp';
     }
}

defaultproperties
{
     HitPoints=5
     FragType=Class'DeusEx.GlassFragment'
     bHighlight=False
     ItemName="Лампочка"
     bPushable=False
     Physics=PHYS_None
     Mesh=LodMesh'GameMedia.Lightlamp'
     ScaleGlow=2.000000
     bUnlit=False
     bInvincible=True
     CollisionRadius=1.600000
     CollisionHeight=2.900000
     Mass=3.000000
     Buoyancy=2.000000
}
