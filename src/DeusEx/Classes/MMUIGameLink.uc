//================================================================================
// MMUIGameLink. Made by Alex ~ http://www.dxalpha.com/
//================================================================================
class MMUIGameLink extends UBrowserHTTPClient;

var MMUIGameData MMUIGD;

function HTTPReceivedData(string _Data)
{
  if(MMUIGD != None)
  {
    MMUIGD.HTTPReceivedData(_Data);
  }

  Destroy();
}