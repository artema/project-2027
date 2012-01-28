//=============================================================================
// ExplosionLarge.
//=============================================================================
class ExplosionLarge extends AnimatedSprite;

function PostBeginPlay()
{
     local DeusExPlayer player;
     local int i;

	Super.PostBeginPlay();

     player = DeusExPlayer(GetPlayerPawn());

     if (player.bNoResurrection)
     {
        animSpeed=0.160000;
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

	for (i=0; i<4; i++)
		Spawn(class'FireComet', None);


	for (i=0; i<3; i++)
		Spawn(class'Rockchip', None);

		Spawn(class'ExplosionSmoke', None);
}

defaultproperties
{
     ScaleFactor=1.100000
     GlowFactor=1.000000
     animSpeed=0.030000
     numFrames=24
     frames(0)=Texture'GameMedia.Effects.ef_ExLrg001'
     frames(1)=Texture'GameMedia.Effects.ef_ExLrg002'
     frames(2)=Texture'GameMedia.Effects.ef_ExLrg003'
     frames(3)=Texture'GameMedia.Effects.ef_ExLrg004'
     frames(4)=Texture'GameMedia.Effects.ef_ExLrg005'
     frames(5)=Texture'GameMedia.Effects.ef_ExLrg006'
     frames(6)=Texture'GameMedia.Effects.ef_ExLrg007'
     frames(7)=Texture'GameMedia.Effects.ef_ExLrg008'
     frames(8)=Texture'GameMedia.Effects.ef_ExLrg009'
     frames(9)=Texture'GameMedia.Effects.ef_ExLrg010'
     frames(10)=Texture'GameMedia.Effects.ef_ExLrg011'
     frames(11)=Texture'GameMedia.Effects.ef_ExLrg012'
     frames(12)=Texture'GameMedia.Effects.ef_ExLrg013'
     frames(13)=Texture'GameMedia.Effects.ef_ExLrg014'
     frames(14)=Texture'GameMedia.Effects.ef_ExLrg015'
     frames(15)=Texture'GameMedia.Effects.ef_ExLrg016'
     frames(16)=Texture'GameMedia.Effects.ef_ExLrg017'
     frames(17)=Texture'GameMedia.Effects.ef_ExLrg018'
     frames(18)=Texture'GameMedia.Effects.ef_ExLrg019'
     frames(19)=Texture'GameMedia.Effects.ef_ExLrg020'
     frames(20)=Texture'GameMedia.Effects.ef_ExLrg021'
     frames(21)=Texture'GameMedia.Effects.ef_ExLrg022'
     frames(22)=Texture'GameMedia.Effects.ef_ExLrg023'
     frames(23)=Texture'GameMedia.Effects.ef_ExLrg024'
     Texture=Texture'GameMedia.Effects.ef_ExLrg001'
}
