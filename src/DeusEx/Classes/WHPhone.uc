//=============================================================================
// WHPhone.
//=============================================================================
class WHPhone extends WashingtonDecoration;

enum ERingSound
{
	RS_Office1,
	RS_Office2
};

enum EAnswerSound
{
	AS_Dialtone,
	AS_Busy,
	AS_OutOfService,
	AS_CircuitsBusy
};

var() ERingSound RingSound;
var() float ringFreq;
var() Sound RingSound1;
var() Sound RingSound2;
var() Sound RingSound3;
var() Sound RingSound4;
var float ringTimer;
var bool bUsing;
var() bool bNoSound;

function Tick(float deltaTime)
{
	Super.Tick(deltaTime);

	ringTimer += deltaTime;

	if ((ringTimer >= 1.0) && !bNoSound)
	{
		ringTimer -= 1.0;

		if (FRand() < ringFreq)
		{
			switch (RingSound)
			{
				case RS_Office1:	PlaySound(sound'PhoneRing1', SLOT_Misc,,, 256); break;
				case RS_Office2:	PlaySound(sound'PhoneRing2', SLOT_Misc,,, 256); break;
			}
		}
	}

}

function Timer()
{
	bUsing = False;
}

function Frob(actor Frobber, Inventory frobWith)
{
	local float rnd;

	Super.Frob(Frobber, frobWith);

	if (bUsing)
		return;

	SetTimer(3.0, False);
	bUsing = True;

	rnd = FRand();


     if (!IsInState('Conversation') || !bNoSound)
     {

	if (rnd < 0.25)
		PlaySound(RingSound1, SLOT_Misc,,, 256);
	else if (rnd < 0.5)
		PlaySound(RingSound2, SLOT_Misc,,, 256);
	else if (rnd < 0.75)
		PlaySound(RingSound3, SLOT_Misc,,, 256);
	else
		PlaySound(RingSound4, SLOT_Misc,,, 256);
     }
}

defaultproperties
{
	 BindName="Phone"
     RingSound1=Sound'PhoneVoice1'
     RingSound2=Sound'PhoneVoice2'
     RingSound3=Sound'PhoneVoice3'
     RingSound4=Sound'PhoneBusy'
     ringFreq=0.010000
     FragType=Class'DeusEx.PlasticFragment'
     ItemName="�������"
     Mesh=LodMesh'DeusExDeco.WHPhone'
     CollisionRadius=7.000000
     CollisionHeight=1.500000
     Mass=20.000000
     Buoyancy=5.000000
     bInvincible=True
     FragType=Class'DeusEx.PlasticFragment'
     bPushable=False
}
