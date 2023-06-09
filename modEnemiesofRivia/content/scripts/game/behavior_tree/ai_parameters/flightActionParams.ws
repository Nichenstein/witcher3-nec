/***********************************************************************/
/** 	© 2015 CD PROJEKT S.A. All rights reserved.
/** 	THE WITCHER® is a trademark of CD PROJEKT S. A.
/** 	The Witcher game is based on the prose of Andrzej Sapkowski.
/***********************************************************************/


abstract class IFlightActionTree extends IAIActionTree
{

};


class CFlyToActionTree extends IFlightActionTree
{
	default aiTreeName = "resdef:ai\scripted_actions/fly_to";

	editable var acceptDistance 		: float;
	editable var targetTag 				: name;
	editable var rotateBeforeTakeOff	: bool;
	editable var landAtTargetLocation	: bool;
	editable var landingForwardOffset	: float;
	
	default acceptDistance				= 1.0;
	default rotateBeforeTakeOff			= false;
	default landAtTargetLocation		= true;
	default landingForwardOffset		= 7.0;
};


class CAIFlyOnCurve extends IFlightActionTree
{
	default aiTreeName = "resdef:ai\scripted_actions/fly_on_curve";
	
	editable var animationName		: name;
	editable var curveTag			: name;
	editable var curveDummyName		: string;
	editable var blendInTime		: float;
	editable var slotAnimation		: name;
	
	editable var animValPitch		: string;
	editable var animValYaw			: string;
	editable var maxPitchInput		: float;
	editable var maxPitchOutput		: float;
	editable var maxYawInput		: float;
	editable var maxYawOutput		: float;
	

	default animationName			= 'Move';
	default blendInTime				= 1.0;
	
	default animValPitch			= "FlyPitch";
	default animValYaw				= "FlyYaw";
	default maxPitchInput			= 17.0;
	default maxPitchOutput			= 1.0;
	default maxYawInput				= 32.0;
	default maxYawOutput			= 1.0;
};



class CAIFlyFindLandingSpotTree extends IFlightActionTree
{
	default aiTreeName = "gameplay/trees/scripted_actions/fly_find_landing_spot.w2behtree";
	
	editable inlined var landingAnimations : array< CAIFlyLandTree >;
};

class CAIFlyLandTree extends IFlightActionTree
{
	default aiTreeName = "gameplay/trees/scripted_actions/fly_landing_animation.w2behtree";
};



class CAIFlyInterruptableAction extends IFlightActionTree
{
	default aiTreeName = "resdef:ai\scripted_actions/fly_critical_state_interruptable_action";
	
	editable inlined var interruptableAction	: CAISubTree;
}



abstract class IAIFlightIdleTree extends CAIMainTree
{
}


class CAIFlightIdleRedefinitionParameters extends CAIRedefinitionParameters
{
	editable inlined var freeFlight : IAIFlightIdleTree;
};


class CAIFlightIdleAroundTargets extends IAIFlightIdleTree
{
	default aiTreeName = "gameplay/trees/idle/flight/idle_fly_around.w2behtree";
	
	editable var flightTargetTag : name;
	editable var flightAroundClosest : bool;
	editable var flightAroundReselect : bool;
	editable var flyAroundReselectDurationMin : float;
	editable var flyAroundReselectDurationMax : float;
	editable var idleFlightRadiusMin : float;
	editable var idleFlightRadiusMax : float;
	editable var idleFlightHeightMin : float;
	editable var idleFlightHeightMax : float;
	
	default flightAroundClosest = true;
	default flightAroundReselect = true;
	default flyAroundReselectDurationMin = 10.0;
	default flyAroundReselectDurationMax = 20.0;
	default idleFlightRadiusMin = 12.0;
	default idleFlightRadiusMax = 77.0;
	default idleFlightHeightMin = 12.0;
	default idleFlightHeightMax = 23.0;
};

class CAIFlightIdleFreeRoam extends IAIFlightIdleTree
{
	default aiTreeName = "gameplay/trees/idle/flight/idle_fly_wander.w2behtree";
	
	editable var flightHeight : float;
	editable var flyAround : bool;
	editable var flyAroundDurationMin : float;
	editable var flyAroundDurationMax : float;
	editable var flightAreaSelection : EAIAreaSelectionMode;
	editable var flightAreaOptionalTag : name;
	
	default flightHeight = 23.0;
	default flyAround = true;
	default flyAroundDurationMin = 3;
	default flyAroundDurationMax = 32;
	default flightAreaSelection = EAIASM_GuardArea;
	
	
};
