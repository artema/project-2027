//=============================================================================
// ElectricityEmitter.
//=============================================================================
class TeslaEmitter extends ElectricityEmitter;

function PostPostBeginPlay()
{
	Super.PostPostBeginPlay();

	if (proxy != None){
		proxy.Mesh = LODMesh'GameMedia.Lightning';
		//proxy.Multiskins[1] = Texture'GameMedia.Effects.Effect_Lightning1';
	}
}

defaultproperties
{
}
