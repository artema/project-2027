//=============================================================================
// ���� - ������. �������� Ded'�� ��� ���� 2027
// Corpse - Daniel. Copyright (C) 2003 Ded
//=============================================================================
class DanielCarcass extends DeusExCarcass;

// ----------------------------------------------------------------------
// PostPostBeginPlay()
// ----------------------------------------------------------------------

function PostPostBeginPlay()
{
	local TruePlayer player;

	Super.PostPostBeginPlay();

	foreach AllActors(class'TruePlayer', player)
		break;

	SetSkin(player);
}

// ----------------------------------------------------------------------
// SetSkin()
// ----------------------------------------------------------------------

function SetSkin(DeusExPlayer player)
{
	if (player != None)
	{
		switch(player.PlayerSkin)
		{
			case 0:	
			MultiSkins[0] = Texture'GameMedia.Characters.DanielTex0_0'; 
			break;
			
			case 1:	
			//Mesh2=LodMesh'DeusExCharacters.GM_Trench_F_CarcassB';
     		//Mesh3=LodMesh'DeusExCharacters.GM_Trench_F_CarcassC';
     		//Mesh=LodMesh'DeusExCharacters.GM_Trench_F_Carcass';
			MultiSkins[0] = Texture'GameMedia.Characters.DanielTex0_1'; 
			MultiSkins[6] = Texture'DeusExCharacters.Skins.FramesTex2'; 
			MultiSkins[7] = Texture'DeusExCharacters.Skins.LensesTex3'; 
			//Fatness = 127;
			break;
			
			case 2:	
			MultiSkins[0] = Texture'GameMedia.Characters.DanielTex0_2'; 
			MultiSkins[6] = Texture'GameMedia.Characters.FramesSquare'; 
			MultiSkins[7] = Texture'DeusExCharacters.Skins.LensesTex3'; 
			//Fatness = 127;
			break;
		}
	}
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     Mesh2=LodMesh'DeusExCharacters.GM_Trench_CarcassB'
     Mesh3=LodMesh'DeusExCharacters.GM_Trench_CarcassC'
     Mesh=LodMesh'DeusExCharacters.GM_Trench_Carcass'
     MultiSkins(0)=Texture'GameMedia.Characters.DanielTex0_0'
     MultiSkins(1)=Texture'GameMedia.Characters.DanielTex2'
     MultiSkins(2)=Texture'GameMedia.Characters.DanielTex3'
     MultiSkins(3)=Texture'GameMedia.Characters.DanielTex0'
     MultiSkins(4)=Texture'GameMedia.Characters.DanielTex1'
     MultiSkins(5)=Texture'GameMedia.Characters.DanielTex2'
     MultiSkins(6)=Texture'DeusExCharacters.Skins.FramesTex4'
     MultiSkins(7)=Texture'DeusExCharacters.Skins.LensesTex3'
     CollisionRadius=40.000000
}
