//=============================================================================
// ������ ������. �������� Ded'�� ��� ���� 2027
// Dummy traget. Copyright (C) 2003 Ded
//=============================================================================
class DummyTarget extends Robot;

// ----------------------------------------------------------------------
// TakeDamageBase()
// ----------------------------------------------------------------------
function TakeDamageBase(int Damage, Pawn instigatedBy, Vector hitlocation, Vector momentum, name damageType, bool bPlayAnim)
{
	return;
}

function Explode(vector HitLocation)
{
}

function bool PlayTurnHead(ELookDirection newLookDir, float rate, float tweentime) {  }
function PlayRunningAndFiring() {  }
function PlayReloadBegin() {  }
function PlayReload() {  }
function PlayReloadEnd() {  }
function TweenToShoot(float tweentime) {  }
function PlayShoot() {  }
function TweenToCrouchShoot(float tweentime) {  }
function PlayCrouchShoot() {  }
function TweenToAttack(float tweentime) {  }
function PlayAttack() {  }
function PlayTurning() {  }
function TweenToWalking(float tweentime) {  }
function PlayWalking() {  }
function TweenToRunning(float tweentime) {  }
function PlayRunning() {  }
function PlayPanicRunning() {  }
function TweenToWaiting(float tweentime) {  }
function PlayWaiting() {  }
function PlayIdle() {  }
function PlayDancing() {  }
function PlaySittingDown() {  }
function PlaySitting() {  }
function PlayStandingUp() {  }
function PlayRubbingEyesStart() {  }
function PlayRubbingEyes() {  }
function PlayRubbingEyesEnd() {  }
function PlayCowerBegin() {  }
function PlayCowering() {  }
function PlayCowerEnd() {  }
function PlayStunned() {  }
function TweenToSwimming(float tweentime) {  }
function PlaySwimming() {  }
function PlayFalling() {  }
function PlayLanded(float impactVel) {  }
function PlayDuck() {  }
function PlayRising() {  }
function PlayCrawling() {  }
function PlayPushing() {  }
function PlayTakingHit(EHitLocation hitPos) {  }
function PlayWeaponSwitch(Weapon newWeapon) {  }
function PlayDying(name damageType, vector hitLoc) {  }
function LoopBaseConvoAnim() {  }
function LoopHeadConvoAnim() {  }
function LipSynch(float deltaTime) {  }

defaultproperties
{
	 bReactFutz=False
     bHighlight=False
     bInvincible=True
     bHidden=True
     Physics=PHYS_None
     Orders=Idle
     WalkingSpeed=0.000000
     GroundSpeed=0.000000
     WaterSpeed=0.000000
     AirSpeed=0.000000
     AccelRate=0.000000
     Health=250
     UnderWaterTime=0.000000
     AttitudeToPlayer=ATTITUDE_Ignore
     CollisionRadius=5.000000
     CollisionHeight=5.000000
     Mesh=LodMesh'DeusExItems.TestBox'
     Mass=1.000000
     Buoyancy=1.000000
}
