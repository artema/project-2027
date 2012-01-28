class SFXIcarusSphereEffect extends Effects;

#exec OBJ LOAD FILE=GameEffects

var float size;

simulated function Tick(float deltaTime)
{
	DrawScale = 3.0 * size * (Default.LifeSpan - LifeSpan) / Default.LifeSpan;
	ScaleGlow = 2.0 * (LifeSpan / Default.LifeSpan);
	
	 Skin=FireTexture'GameEffects.EMPBomb';
     Texture=FireTexture'GameEffects.EMPBomb';
     MultiSkins[0]=FireTexture'GameEffects.EMPBomb';
}

defaultproperties
{
     size=5.000000
     LifeSpan=0.700000
     DrawType=DT_Mesh
     Style=STY_Translucent
     Mesh=LodMesh'DeusExItems.SphereEffect'
     Skin=FireTexture'GameEffects.EMPBomb'
     Texture=FireTexture'GameEffects.EMPBomb'
     MultiSkins(0)=FireTexture'GameEffects.EMPBomb'
     bUnlit=True
}