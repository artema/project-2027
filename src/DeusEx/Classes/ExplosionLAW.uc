//=============================================================================
// ExplosionLAW.
//=============================================================================
class ExplosionLAW extends AnimatedSprite;

function PostBeginPlay()
{
     local DeusExPlayer player;
     local int i;

	Super.PostBeginPlay();

     player = DeusExPlayer(GetPlayerPawn());

     if (player.bNoResurrection)
     {
        animSpeed=0.010000;
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

	for (i=0; i<7; i++)
		Spawn(class'FireComet', None);


	for (i=0; i<3; i++)
		Spawn(class'Rockchip', None);
}

defaultproperties
{
     ScaleFactor=2.500000
     GlowFactor=1.500000
     animSpeed=0.040000
     numFrames=26
     frames(0)=Texture'GameMedia.Effects.ef_ExBig001'
     frames(1)=Texture'GameMedia.Effects.ef_ExBig002'
     frames(2)=Texture'GameMedia.Effects.ef_ExBig003'
     frames(3)=Texture'GameMedia.Effects.ef_ExBig004'
     frames(4)=Texture'GameMedia.Effects.ef_ExBig005'
     frames(5)=Texture'GameMedia.Effects.ef_ExBig006'
     frames(6)=Texture'GameMedia.Effects.ef_ExBig007'
     frames(7)=Texture'GameMedia.Effects.ef_ExBig008'
     frames(8)=Texture'GameMedia.Effects.ef_ExBig009'
     frames(9)=Texture'GameMedia.Effects.ef_ExBig010'
     frames(10)=Texture'GameMedia.Effects.ef_ExBig011'
     frames(11)=Texture'GameMedia.Effects.ef_ExBig012'
     frames(12)=Texture'GameMedia.Effects.ef_ExBig013'
     frames(13)=Texture'GameMedia.Effects.ef_ExBig014'
     frames(14)=Texture'GameMedia.Effects.ef_ExBig015'
     frames(15)=Texture'GameMedia.Effects.ef_ExBig016'
     frames(16)=Texture'GameMedia.Effects.ef_ExBig017'
     frames(17)=Texture'GameMedia.Effects.ef_ExBig018'
     frames(18)=Texture'GameMedia.Effects.ef_ExBig019'
     frames(19)=Texture'GameMedia.Effects.ef_ExBig020'
     frames(20)=Texture'GameMedia.Effects.ef_ExBig021'
     frames(21)=Texture'GameMedia.Effects.ef_ExBig022'
     frames(22)=Texture'GameMedia.Effects.ef_ExBig023'
     frames(23)=Texture'GameMedia.Effects.ef_ExBig024'
     frames(24)=Texture'GameMedia.Effects.ef_ExBig023'
     frames(25)=Texture'GameMedia.Effects.ef_ExBig024'
     Texture=Texture'GameMedia.Effects.ef_ExBig001'
}
