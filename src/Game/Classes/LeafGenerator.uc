//=============================================================================
// Генератор листьев. Сделанно Ded'ом для мода 2027
// Leaf generator. Copyright (C) 2003 Ded
//=============================================================================
class LeafGenerator expands Effects;

enum ETrashType
{
	TT_OldLeaf,
	TT_OldLeaf2
};

var() float Frequency;
var() float WindSpeed;
var() ETrashType TrashType;
var float timer;

function Tick(float deltaTime)
{
	local Trash trash;

//    if (!bNotActive)
 //   {
	if (timer > 0.1)
	{
		timer = 0;

		if (FRand() < Frequency)
		{
			if (TrashType == TT_OldLeaf)
				trash = Spawn(class'Game.OldLeaf');
			else if (TrashType == TT_OldLeaf2)
				trash = Spawn(class'Game.OldLeaf');

			if (trash != None)
			{
				trash.SetPhysics(PHYS_Rolling);
				trash.rot = RotRand(True);
				trash.rot.Yaw = 0;
				trash.dir = Vector(Rotation) * WindSpeed;
				trash.dir.x += (WindSpeed*0.03) - 15 * FRand();
				trash.dir.y += (WindSpeed*0.03) - 15 * FRand();
				trash.dir.z = -10 - 5*FRand() - (WindSpeed*0.005);
				
				if(trash.dir.z >= 0)
					trash.dir.z = -10 - 5*FRand();
			}
		}
	}

 //   }

	timer += deltaTime;

	Super.Tick(deltaTime);
}

defaultproperties
{
     bStasis=False
     Frequency=0.040000
     WindSpeed=170.000000
     bHidden=True
     bDirectional=True
     DrawType=DT_Sprite
     Texture=Texture'Engine.S_Inventory'
     bFixedRotationDir=True
}
