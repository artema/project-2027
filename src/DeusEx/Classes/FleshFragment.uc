//=============================================================================
// FleshFragment.
//=============================================================================
class FleshFragment expands DeusExFragment
	abstract;

var() bool bRandomSize;

auto state Flying
{
	function BeginState()
	{
		Super.BeginState();

		Velocity = VRand() * 300;
		
		if(bRandomSize)
			DrawScale = FRand() + 1.5;
	}
}

function Tick(float deltaTime)
{
	local DeusExFragment blood;
	
	Super.Tick(deltaTime);
	
	if (!IsInState('Dying'))
	{
		if (FRand() < 0.5)
		{
			blood = Spawn(class'BloodDrop',,, Location);
			blood.bKeepForever = bKeepForever;
		}
	}
}

function AddRandomSmoke()
{
	if(!IsInState('Dying') && (smokeGen == None) && FRand() < 0.2)
	{
		AddSmoke();
	}
}
/*
     Fragments(0)=LodMesh'DeusExItems.FleshFragment1'
     Fragments(1)=LodMesh'DeusExItems.FleshFragment2'
     Fragments(2)=LodMesh'DeusExItems.FleshFragment3'
     Fragments(3)=LodMesh'DeusExItems.FleshFragment4'
     numFragmentTypes=4
     Mesh=LodMesh'DeusExItems.FleshFragment1'
*/
defaultproperties
{
	 bKeepForever=True
     elasticity=0.400000
     ImpactSound=Sound'DeusExSounds.Generic.FleshHit1'
     MiscSound=Sound'DeusExSounds.Generic.FleshHit2'
     CollisionRadius=2.000000
     CollisionHeight=2.000000
     Mass=5.000000
     Buoyancy=5.500000
     bVisionImportant=True
}