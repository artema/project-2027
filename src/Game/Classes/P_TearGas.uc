//=============================================================================
// TearGas.
//=============================================================================
class P_TearGas extends Cloud;

#exec obj load file="..\2027\Textures\GameEffects.utx" package=GameEffects

function PostBeginPlay()
{
     local DeusExPlayer player;

	Super.PostBeginPlay();

     player = DeusExPlayer(GetPlayerPawn());

     if (player.bNoResurrection)
     {
        Texture=WetTexture'Effects.Smoke.Gas_Tear_A';
        DrawScale = 1;
        maxDrawScale=2.000000;
     }
}

defaultproperties
{
     DrawScale=0.25
     DamageType=TearGas
     maxDrawScale=0.500000
     Texture=WetTexture'GameEffects.Smoke.PoisonCld_2A'
}
