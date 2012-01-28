//=============================================================================
// ������������ ���������. ������� Ded'�� ��� ���� 2027
// Personal computer. Copyright (C) 2003 Ded
//=============================================================================
class GameComputerInfo extends Actor;

var string nodeName;
var string nodeAddress;
var string titleString;
var Texture titleTexture;

struct sComputerInfo
{
	var localized string nodeName;
	var localized string nodeDesc;
	var string nodeAddress;
	var Texture nodeTexture;
};

var localized sComputerInfo ComputerInfo[20];

function SetComputerInfo(int i)
{
	local sComputerInfo info;
	
	info = ComputerInfo[i];
	
	nodeName = info.nodeName;
	titleString = info.nodeDesc;
	nodeAddress = Sprintf(info.nodeAddress, GenerateIP());
	titleTexture = info.nodeTexture;
}

function String GenerateIP()
{
	local String ip;
	local Int i;
	local String chars[16];
	
	chars[0] = "0";
	chars[1] = "1";
	chars[2] = "2";
	chars[3] = "3";
	chars[4] = "4";
	chars[5] = "5";
	chars[6] = "6";
	chars[7] = "7";
	chars[8] = "8";
	chars[9] = "9";
	chars[10] = "A";
	chars[11] = "B";
	chars[12] = "C";
	chars[13] = "D";
	chars[14] = "E";
	chars[15] = "F";
	
	for(i=0; i<4; i++)
	{
		if(i>0)
			ip = ip $ ":";	
			
		ip = ip $ chars[Rand(15)+1] $ chars[Rand(16)] $ chars[Rand(16)] $ chars[Rand(16)];
	}
	
	return ip;
}

defaultproperties
{
	 bHidden=True
     ComputerInfo(0)=(nodeName="Undefined network",nodeDesc="Undefined network area",nodeAddress="UNDEFINED//%s",nodeTexture=None)
     ComputerInfo(1)=(nodeName="Paris.Net",nodeDesc="Paris public network",nodeAddress="PUBLIC/PARIS//%s",nodeTexture=Texture'Game.Logos.ParHomeNetLogo')
     ComputerInfo(2)=(nodeName="Moscow.Net",nodeDesc="Moscow public network",nodeAddress="PUBLIC/MOSCOW//%s",nodeTexture=Texture'Game.Logos.MosCityNetLogo')
     ComputerInfo(3)=(nodeName="RPN",nodeDesc="Russian Police Network",nodeAddress="POLICE//%s",nodeTexture=Texture'Game.Logos.MosCityNetLogo')
     ComputerInfo(4)=(nodeName="Titan infonet",nodeDesc="Titan military network",nodeAddress="MILITARY/TITAN//%s",nodeTexture=Texture'Game.Logos.Titanlogo')
     ComputerInfo(5)=(nodeName="Human Horizon",nodeDesc="Human Horizon Intranet",nodeAddress="HH/INTRANET//%s",nodeTexture=Texture'Game.Logos.CIAlogo')
     ComputerInfo(6)=(nodeName="Omars",nodeDesc="Omars Communication Platform",nodeAddress="GLOBAL/OMARS//%s",nodeTexture=Texture'Game.Logos.Titanlogo')
     ComputerInfo(7)=(nodeName="CSS",nodeDesc="Civil Security Service",nodeAddress="CSS/PARIS//%s",nodeTexture=Texture'Game.Logos.ParHomeNetLogo')
     ComputerInfo(8)=(nodeName="Majestic 12",nodeDesc="Majestic 12 Intranet",nodeAddress="MJ12/INTRANET//%s",nodeTexture=Texture'Game.Logos.MJ12logo')
}