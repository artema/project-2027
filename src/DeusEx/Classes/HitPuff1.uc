//=============================================================================
// ExplosionLarge.
//=============================================================================
class HitPuff1 extends AnimatedSprite;

simulated function Tick(float deltaTime)
{
	Super.Tick(deltaTime);

	if (Region.Zone.bWaterZone)
		Destroy();

}

function PostBeginPlay()
{
     local DeusExPlayer player;

	Super.PostBeginPlay();

     player = DeusExPlayer(GetPlayerPawn());

     if (player.bNoResurrection || Region.Zone.bWaterZone)
            Destroy();
}

defaultproperties
{
     ScaleFactor=0.400000
     GlowFactor=0.400000
     animSpeed=0.01500
     numFrames=30
     frames(0)=Texture'GameMedia.Effects.ef_HitPuff1_001'
     frames(1)=Texture'GameMedia.Effects.ef_HitPuff1_002'
     frames(2)=Texture'GameMedia.Effects.ef_HitPuff1_003'
     frames(3)=Texture'GameMedia.Effects.ef_HitPuff1_004'
     frames(4)=Texture'GameMedia.Effects.ef_HitPuff1_005'
     frames(5)=Texture'GameMedia.Effects.ef_HitPuff1_006'
     frames(6)=Texture'GameMedia.Effects.ef_HitPuff1_007'
     frames(7)=Texture'GameMedia.Effects.ef_HitPuff1_008'
     frames(8)=Texture'GameMedia.Effects.ef_HitPuff1_009'
     frames(9)=Texture'GameMedia.Effects.ef_HitPuff1_010'
     frames(10)=Texture'GameMedia.Effects.ef_HitPuff1_011'
     frames(11)=Texture'GameMedia.Effects.ef_HitPuff1_012'
     frames(12)=Texture'GameMedia.Effects.ef_HitPuff1_013'
     frames(13)=Texture'GameMedia.Effects.ef_HitPuff1_014'
     frames(14)=Texture'GameMedia.Effects.ef_HitPuff1_015'
     frames(15)=Texture'GameMedia.Effects.ef_HitPuff1_016'
     frames(16)=Texture'GameMedia.Effects.ef_HitPuff1_017'
     frames(17)=Texture'GameMedia.Effects.ef_HitPuff1_018'
     frames(18)=Texture'GameMedia.Effects.ef_HitPuff1_019'
     frames(19)=Texture'GameMedia.Effects.ef_HitPuff1_020'
     frames(20)=Texture'GameMedia.Effects.ef_HitPuff1_021'
     frames(21)=Texture'GameMedia.Effects.ef_HitPuff1_022'
     frames(22)=Texture'GameMedia.Effects.ef_HitPuff1_023'
     frames(23)=Texture'GameMedia.Effects.ef_HitPuff1_024'
     frames(24)=Texture'GameMedia.Effects.ef_HitPuff1_025'
     frames(25)=Texture'GameMedia.Effects.ef_HitPuff1_026'
     frames(26)=Texture'GameMedia.Effects.ef_HitPuff1_027'
     frames(27)=Texture'GameMedia.Effects.ef_HitPuff1_028'
     frames(28)=Texture'GameMedia.Effects.ef_HitPuff1_029'
     frames(29)=Texture'GameMedia.Effects.ef_HitPuff1_030'
     Texture=Texture'GameMedia.Effects.ef_HitPuff1_001'
}
