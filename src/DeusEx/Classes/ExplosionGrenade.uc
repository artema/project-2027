//=============================================================================
// ExplosionLarge.
//=============================================================================
class ExplosionGrenade extends AnimatedSprite;

function PostBeginPlay()
{
     local DeusExPlayer player;
     local int i;

	Super.PostBeginPlay();

     player = DeusExPlayer(GetPlayerPawn());

     if (player.bNoResurrection)
     {
        animSpeed=0.060000;
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
     ScaleFactor=1.400000
     GlowFactor=1.000000
     animSpeed=0.020000
     numFrames=21
     frames(0)=Texture'GameMedia.Effects.ef_ExGrn001'
     frames(1)=Texture'GameMedia.Effects.ef_ExGrn002'
     frames(2)=Texture'GameMedia.Effects.ef_ExGrn003'
     frames(3)=Texture'GameMedia.Effects.ef_ExGrn004'
     frames(4)=Texture'GameMedia.Effects.ef_ExGrn005'
     frames(5)=Texture'GameMedia.Effects.ef_ExGrn006'
     frames(6)=Texture'GameMedia.Effects.ef_ExGrn007'
     frames(7)=Texture'GameMedia.Effects.ef_ExGrn008'
     frames(8)=Texture'GameMedia.Effects.ef_ExGrn009'
     frames(9)=Texture'GameMedia.Effects.ef_ExGrn010'
     frames(10)=Texture'GameMedia.Effects.ef_ExGrn011'
     frames(11)=Texture'GameMedia.Effects.ef_ExGrn012'
     frames(12)=Texture'GameMedia.Effects.ef_ExGrn013'
     frames(13)=Texture'GameMedia.Effects.ef_ExGrn014'
     frames(14)=Texture'GameMedia.Effects.ef_ExGrn015'
     frames(15)=Texture'GameMedia.Effects.ef_ExGrn016'
     frames(16)=Texture'GameMedia.Effects.ef_ExGrn017'
     frames(17)=Texture'GameMedia.Effects.ef_ExGrn018'
     frames(18)=Texture'GameMedia.Effects.ef_ExGrn019'
     frames(19)=Texture'GameMedia.Effects.ef_ExGrn020'
     frames(20)=Texture'GameMedia.Effects.ef_ExGrn021'
     Texture=Texture'GameMedia.Effects.ef_ExGrn001'
}
