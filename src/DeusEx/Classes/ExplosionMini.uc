//=============================================================================
// ExplosionMini.
//=============================================================================
class ExplosionMini extends AnimatedSprite;

function PostBeginPlay()
{
     local DeusExPlayer player;

	Super.PostBeginPlay();

     player = DeusExPlayer(GetPlayerPawn());

     if (player.bNoResurrection)
     {
        ScaleFactor=0.70000;
        animSpeed=0.100000;
        numFrames=8;
        frames[0]=Texture'DeusExItems.Skins.FlatFXTex20';
        frames[1]=Texture'DeusExItems.Skins.FlatFXTex21';
        frames[2]=Texture'DeusExItems.Skins.FlatFXTex22';
        frames[3]=Texture'DeusExItems.Skins.FlatFXTex23';
        frames[4]=Texture'DeusExItems.Skins.FlatFXTex24';
        frames[5]=Texture'DeusExItems.Skins.FlatFXTex25';
        frames[6]=Texture'DeusExItems.Skins.FlatFXTex26';
        frames[7]=Texture'DeusExItems.Skins.FlatFXTex27';
        Texture=Texture'DeusExItems.Skins.FlatFXTex20';
     }
}

defaultproperties
{
     ScaleFactor=1.50000
     GlowFactor=1.500000
     animSpeed=0.0500
     numFrames=16
     frames(0)=Texture'GameMedia.Effects.ef_ExpMini001'
     frames(1)=Texture'GameMedia.Effects.ef_ExpMini002'
     frames(2)=Texture'GameMedia.Effects.ef_ExpMini003'
     frames(3)=Texture'GameMedia.Effects.ef_ExpMini004'
     frames(4)=Texture'GameMedia.Effects.ef_ExpMini005'
     frames(5)=Texture'GameMedia.Effects.ef_ExpMini006'
     frames(6)=Texture'GameMedia.Effects.ef_ExpMini007'
     frames(7)=Texture'GameMedia.Effects.ef_ExpMini008'
     frames(8)=Texture'GameMedia.Effects.ef_ExpMini009'
     frames(9)=Texture'GameMedia.Effects.ef_ExpMini010'
     frames(10)=Texture'GameMedia.Effects.ef_ExpMini011'
     frames(11)=Texture'GameMedia.Effects.ef_ExpMini012'
     frames(12)=Texture'GameMedia.Effects.ef_ExpMini013'
     frames(13)=Texture'GameMedia.Effects.ef_ExpMini014'
     frames(14)=Texture'GameMedia.Effects.ef_ExpMini015'
     frames(15)=Texture'GameMedia.Effects.ef_ExpMini016'
     Texture=Texture'GameMedia.Effects.ef_ExpMini001'
}
