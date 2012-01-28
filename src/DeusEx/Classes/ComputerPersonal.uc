//=============================================================================
// ComputerPersonal.
//=============================================================================
class ComputerPersonal extends Computers;

defaultproperties
{
     terminalType=Class'DeusEx.NetworkTerminalPersonal'
     lockoutDelay=60.000000
     UserList(0)=(userName="USER2027",Password="USER2027")
     ItemName="Personal Computer Terminal"
     Mesh=LodMesh'DeusExItems.TestBox'
     CollisionRadius=36.000000
     CollisionHeight=7.400000
     BindName="ComputerPersonal"
}
