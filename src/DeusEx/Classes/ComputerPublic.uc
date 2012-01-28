//=============================================================================
// ComputerPublic.
//=============================================================================
class ComputerPublic extends Computers;

var() name bulletinTag;

enum ESkin
{
	ES_Default,
    ES_Russian
};

var() ESkin SkinType;

/*
var MMUIGameData MMUIGL;

struct DownloadedTextDataStruct
{
	var String title;
	var String text;
};

var int TotalDataRows;
var DownloadedTextDataStruct DownloadedTextData[255];

function int GetTotalDataRows(){
	return TotalDataRows;
}
function SetTotalDataRows(int num){
	TotalDataRows = num;
}

function SetData(String title, String text, int id){
	DownloadedTextData[id].title = title; 
	DownloadedTextData[id].text = text;
}

function String GiveDataText(int id){
	return DownloadedTextData[id].text; 
}

function String GiveDataTitle(int id){
	return DownloadedTextData[id].title; 
}

// ----------------------------------------------------------------------
// Invoke()
// ----------------------------------------------------------------------

function bool Invoke()
{
	local DeusExPlayer player;

	if (termwindow != None)
		return False;

	player = curFrobber;
	if (player != None)
	{
		player.InvokeComputerScreen(self, lastHackTime, Level.TimeSeconds);
		SetOwner(Player);
	}

	return True;
}

// ----------------------------------------------------------------------
// Frob()
// ----------------------------------------------------------------------

function Frob(Actor Frobber, Inventory frobWith)
{
		MMUIGL = Spawn(class'MMUIGameData',,,location);
		if(MMUIGL != None){
			MMUIGL.GiveUsOwner(self);
	        	MMUIGL.CustomFunction();
		}

	Super.Frob(Frobber, frobWith);

}

// ----------------------------------------------------------------------
// CloseOut()
// ----------------------------------------------------------------------

function CloseOut()
{
   if (curFrobber != None)
   {
      //curFrobber = None;
      GotoState('Off');
   }
}
*/
function BeginPlay()
{
	Super.BeginPlay();

	switch (SkinType)
	{
		case ES_Russian:
			MultiSkins[0] = Texture'GameMedia.Skins.ComputerPublicTex1Rus';
            break;
	}
}

defaultproperties
{
     terminalType=Class'DeusEx.NetworkTerminalPublic'
     ItemName="������������ ��������"
     Physics=PHYS_None
     Mesh=LodMesh'DeusExDeco.ComputerPublic'
     ScaleGlow=2.000000
     CollisionHeight=49.139999
     BindName="ComputerPublic"
}
