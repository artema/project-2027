//=============================================================================
// ������������ ���������. ������� Ded'�� ��� ���� 2027
// Personal computer. Copyright (C) 2003 Ded
//=============================================================================
class GameComputerPersonal extends ComputerPersonal;

enum EComputerInfo
{
	CI_Default,
	CI_ParHomeNet,
	CI_MosCityNet,
	CI_MoscowPolice,
	CI_Titan,
	CI_HumanHorizon,
	CI_Omars,
	CI_ParisPolice,
	CI_MJ12
};

enum ESkin
{
	ES_Empty,
    ES_Biology,
    ES_General,
    ES_Observing
};

var() ESkin SkinType;
var() EComputerInfo ComputerInfo;

var GameComputerInfo infoData;

function BeginPlay()
{
	Super.BeginPlay();

	switch (SkinType)
	{
		case ES_Empty:

                          MultiSkins[0] = Texture'GameMedia.Skins.PC0Tex0';
                                                                     break;

		case ES_Biology:

	          if ((FRand() > 0.0) && (FRand() < 0.35))
	                  MultiSkins[0] = Texture'GameMedia.Skins.PC1Tex0';
	          else if ((FRand() > 0.35) && (FRand() < 0.65))
	                  MultiSkins[0] = Texture'GameMedia.Skins.PC1Tex1';
                  else
	                  MultiSkins[0] = Texture'GameMedia.Skins.PC1Tex2';

                                                                     break;

		case ES_General:

	          if ((FRand() > 0.0) && (FRand() < 0.35))
	                  MultiSkins[0] = Texture'GameMedia.Skins.PC2Tex0';
	          else if ((FRand() > 0.35) && (FRand() < 0.65))
	                  MultiSkins[0] = Texture'GameMedia.Skins.PC2Tex1';
                  else
	                  MultiSkins[0] = Texture'GameMedia.Skins.PC2Tex2';

                                                                     break;

		case ES_Observing:

	          if ((FRand() > 0.0) && (FRand() < 0.35))
	                  MultiSkins[0] = Texture'GameMedia.Skins.PC3Tex0';
	          else if ((FRand() > 0.35) && (FRand() < 0.65))
	                  MultiSkins[0] = Texture'GameMedia.Skins.PC3Tex1';
                  else
	                  MultiSkins[0] = Texture'GameMedia.Skins.PC3Tex2';

                                                                     break;
	}
	
	infoData = Spawn(class'GameComputerInfo');
	infoData.SetComputerInfo(Int(ComputerInfo));
}

function String GetNodeName()
{
	return infoData.nodeName;
}

function String GetNodeDesc()
{
	return infoData.titleString;
}

function String GetNodeAddress()
{
	return infoData.nodeAddress;
}

function Texture GetNodeTexture()
{
	return infoData.titleTexture;
}

defaultproperties
{
	 ComputerInfo=CI_Default
     SkinType=ES_General
     Mesh=LodMesh'DeusExDeco.ComputerPersonal'
     MultiSkins(0)=Texture'GameMedia.Skins.PC0Tex0'
}
