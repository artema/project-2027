//================================================================================
// MMUIGameData. Made by Alex ~ http://www.dxalpha.com/
//================================================================================
class MMUIGameData extends Actor;

var ComputerPublic OurComputer;

var bool bIsBusy;
var String TextItems[255];
var String TmpTextItems[2];



function GiveUsOwner(ComputerPublic comp){
	OurComputer = comp;
}

function SplitTextItems(string str, bool prepare)
{
   local String temp[255];
   local bool bEOL;
   local string tempChar;
   local int precount, curcount, wordcount, strLength;
   local String div;

if(prepare)
	div = "|";
else
	div = "~";

   strLength = len(str);
   bEOL = false;
   precount = 0;
   curcount = 0;
   wordcount = 0;
 
   while(!bEOL)
   {
      tempChar = Mid(str, curcount, 1); //go up by 1 count
      if(tempChar != div)
         curcount++;
      else if(tempChar == div)
      {
	if(prepare)
        	TextItems[wordcount] = Mid(str, precount, curcount-precount);
	else
        	TmpTextItems[wordcount] = Mid(str, precount, curcount-precount);

         wordcount++;
         precount = curcount + 1; //removes the divider.
         curcount++;
      }
      if(curcount == strLength)//end of string, flush out the final word.
      {
	if(prepare)
        	TextItems[wordcount] = Mid(str, precount, curcount);
	else
        	TmpTextItems[wordcount] = Mid(str, precount, curcount);

         bEOL = true;
      }
   }
}


function CustomFunction()
{
	local DeusExPlayer Player;
	
	Player = DeusExPlayer(GetPlayerPawn());

	if(!bIsBusy){
		Browse(Player.InternetDomain, Player.InternetReadScript);
	}
}

function HTTPReceivedData(string _Data)
{
	/*local int i;

	SplitTextItems(_Data, true);
	i=0;
	while(i<255 && TextItems[i] != ""){
		SplitTextItems(TextItems[i], false);
		OurComputer.SetData(TmpTextItems[0], TmpTextItems[1], i);
		OurComputer.SetTotalDataRows(i);
		i++;
	}*/

	bIsBusy = False;
}

function Browse(string InAddress, string InURI)
{
    local MMUIGameLink MMUIGL;
    local DeusExPlayer Player;
	
    MMUIGL = Spawn(class'MMUIGameLink',,,location);
    if(MMUIGL != None)
    {
	Player = DeusExPlayer(GetPlayerPawn());
        MMUIGL.MMUIGD = self;
        MMUIGL.Browse(InAddress, "http://"$InAddress$"/"$InURI, 80, Int(Player.InternetTimeout));
        bIsBusy = True;
    }
}

defaultproperties
{
    bHidden=true
}