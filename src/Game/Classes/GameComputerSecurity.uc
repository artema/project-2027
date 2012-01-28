//=============================================================================
// ��������� ������������. ������� Ded'�� ��� ���� 2027
// Security computer.  Copyright (C) 2003 Ded and Steve Tack
//=============================================================================
class GameComputerSecurity extends ComputerSecurity;

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

var() EComputerInfo ComputerInfo;
var GameComputerInfo infoData;

function BeginPlay()
{
	Super.BeginPlay();

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
     MultiSkins(0)=Texture'GameMedia.Skins.SecurityConsoleTex0'
     Mesh=LodMesh'DeusExDeco.ComputerSecurity'
}
