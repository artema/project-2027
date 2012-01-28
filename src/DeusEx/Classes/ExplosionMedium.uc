//=============================================================================
// ExplosionMedium.
//=============================================================================
class ExplosionMedium extends AnimatedSprite;

function PostBeginPlay()
{
     local DeusExPlayer player;
     local int i;

	Super.PostBeginPlay();

     player = DeusExPlayer(GetPlayerPawn());

     if (player.bNoResurrection)
     {
        animSpeed=0.010000;
        numFrames=6;
        frames[0]=Texture'DeusExItems.Skins.FlatFXTex14';
        frames[1]=Texture'DeusExItems.Skins.FlatFXTex15';
        frames[2]=Texture'DeusExItems.Skins.FlatFXTex16';
        frames[3]=Texture'DeusExItems.Skins.FlatFXTex17';
        frames[4]=Texture'DeusExItems.Skins.FlatFXTex18';
        frames[5]=Texture'DeusExItems.Skins.FlatFXTex19';
        Texture=Texture'DeusExItems.Skins.FlatFXTex14';
     }

	for (i=0; i<3; i++)
		Spawn(class'FireComet', None);
}

defaultproperties
{
     ScaleFactor=0.35000
     GlowFactor=0.900000
     animSpeed=0.030000
     numFrames=17
     frames(0)=Texture'GameMedia.Effects.ef_ExMed001'
     frames(1)=Texture'GameMedia.Effects.ef_ExMed002'
     frames(2)=Texture'GameMedia.Effects.ef_ExMed003'
     frames(3)=Texture'GameMedia.Effects.ef_ExMed004'
     frames(4)=Texture'GameMedia.Effects.ef_ExMed005'
     frames(5)=Texture'GameMedia.Effects.ef_ExMed006'
     frames(6)=Texture'GameMedia.Effects.ef_ExMed007'
     frames(7)=Texture'GameMedia.Effects.ef_ExMed008'
     frames(8)=Texture'GameMedia.Effects.ef_ExMed009'
     frames(9)=Texture'GameMedia.Effects.ef_ExMed010'
     frames(10)=Texture'GameMedia.Effects.ef_ExMed011'
     frames(11)=Texture'GameMedia.Effects.ef_ExMed012'
     frames(12)=Texture'GameMedia.Effects.ef_ExMed013'
     frames(13)=Texture'GameMedia.Effects.ef_ExMed014'
     frames(14)=Texture'GameMedia.Effects.ef_ExMed015'
     frames(15)=Texture'GameMedia.Effects.ef_ExMed016'
     frames(16)=Texture'GameMedia.Effects.ef_ExMed017'
     Texture=Texture'GameMedia.Effects.ef_ExMed001'
}
