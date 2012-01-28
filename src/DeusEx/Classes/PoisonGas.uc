//=============================================================================
// PoisonGas.
//=============================================================================
class PoisonGas extends Cloud;

#exec obj load file="..\2027\Textures\GameEffects.utx" package=GameEffects

function PostBeginPlay()
{
     local DeusExPlayer player;

	Super.PostBeginPlay();

     player = DeusExPlayer(GetPlayerPawn());

     if (player.bNoResurrection)
     {
        Texture=WetTexture'Effects.Smoke.Gas_Poison_A';
        DrawScale = 1;
     }
}

defaultproperties
{
     DrawScale=0.25
     maxDrawScale=1.000000
     Texture=WetTexture'GameEffects.Smoke.PoisonCld_1A'
}
