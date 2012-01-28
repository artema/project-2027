//=============================================================================
// ExplosionSmall.
//=============================================================================
class ExplosionSmall extends AnimatedSprite;

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

	Spawn(class'FireComet', None);
}

defaultproperties
{
     ScaleFactor=0.20000
     GlowFactor=0.900000
     animSpeed=0.030000
     numFrames=16
     frames(0)=Texture'GameMedia.Effects.ef_ExSml001'
     frames(1)=Texture'GameMedia.Effects.ef_ExSml002'
     frames(2)=Texture'GameMedia.Effects.ef_ExSml003'
     frames(3)=Texture'GameMedia.Effects.ef_ExSml004'
     frames(4)=Texture'GameMedia.Effects.ef_ExSml005'
     frames(5)=Texture'GameMedia.Effects.ef_ExSml006'
     frames(6)=Texture'GameMedia.Effects.ef_ExSml007'
     frames(7)=Texture'GameMedia.Effects.ef_ExSml008'
     frames(8)=Texture'GameMedia.Effects.ef_ExSml009'
     frames(9)=Texture'GameMedia.Effects.ef_ExSml010'
     frames(10)=Texture'GameMedia.Effects.ef_ExSml011'
     frames(11)=Texture'GameMedia.Effects.ef_ExSml012'
     frames(12)=Texture'GameMedia.Effects.ef_ExSml013'
     frames(13)=Texture'GameMedia.Effects.ef_ExSml014'
     frames(14)=Texture'GameMedia.Effects.ef_ExSml015'
     frames(15)=Texture'GameMedia.Effects.ef_ExSml016'
     Texture=Texture'GameMedia.Effects.ef_ExSml001'
}
