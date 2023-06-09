/***********************************************************************/
/** 	© 2015 CD PROJEKT S.A. All rights reserved.
/** 	THE WITCHER® is a trademark of CD PROJEKT S. A.
/** 	The Witcher game is based on the prose of Andrzej Sapkowski.
/***********************************************************************/
class BTTaskAdditiveHitListener extends IBehTreeTask
{
	public var playHitSound 					: bool;
	public var sounEventName 					: string;
	public var boneName 						: name;
	public var manageIgnoreSignsEvents 			: bool;
	public var angleToIgnoreSigns				: float;
	public var chanceToUseAdditive				: float;
	public var increaseHitCounterOnlyOnMeleeDmg : bool;
	public var processCounter 		 			: bool;
	
	private var damageIsMelee 					: bool;
	private var timeStamp 						: float;
	private var hitsToRaiseGuard 				: float;
	private var raiseGuardChance 				: float;
	private var hitsToCounter 					: float;
	private var counterChance 					: float;
	private var counterStaminaCost 				: float;
	// modEnemiesOfRivia
	private var parryStaminaCost 				: float;
	// modEnemiesOfRivia
	
	default timeStamp = 0;
	
	
	
	
	function OnActivate() : EBTNodeStatus
	{
		GetActor().AddAbility( 'AdditiveHits' );
		return BTNS_Active;
	}
	
	
	
	function CheckGuardOrCounter() : bool
	{
		var npc : CNewNPC = GetNPC();
		var hitCounter : int;
		
		
		GetStats();
		hitCounter = npc.GetHitCounter();
		if ( hitCounter >= hitsToRaiseGuard && npc.CanGuard() )
		{
			
			if( Roll( raiseGuardChance ) && npc.GetStat( BCS_Stamina ) >= parryStaminaCost )
			{		
				if ( npc.RaiseGuard() )
				{
					npc.SignalGameplayEvent('HitReactionTaskCompleted');
					return true;
				}
			}
		}
		if ( !npc.IsHuman() && GetActor().GetMovingAgentComponent().GetName() != "wild_hunt_base" && hitCounter >= hitsToCounter  )
		{
			if( Roll( counterChance ) && npc.GetStat( BCS_Stamina ) >= counterStaminaCost )
			{
				npc.SignalGameplayEvent('LaunchCounterAttack');
				return true;
			}
		}
		
		return false;
	}
	
	
	
	function GetStats()
	{
		var raiseGuardMultiplier 	: int;
		var counterMultiplier 		: int;
		var actor 					: CActor = GetActor();
				
		// modEnemiesOfRivia

		
		hitsToRaiseGuard = (int)CalculateAttributeValue(actor.GetAttributeValue('hits_to_raise_guard'));
		raiseGuardChance = (int)MaxF(0, 100*CalculateAttributeValue(actor.GetAttributeValue('raise_guard_chance')));
		hitsToCounter = (int)CalculateAttributeValue(actor.GetAttributeValue('hits_to_roll_counter'));
		counterChance = (int)MaxF(0, 100*CalculateAttributeValue(actor.GetAttributeValue('counter_chance')));
		counterStaminaCost = CalculateAttributeValue(actor.GetAttributeValue( 'counter_stamina_cost' ));
		parryStaminaCost = CalculateAttributeValue(actor.GetAttributeValue('parry_stamina_cost'));
		
		if( hitsToRaiseGuard < 0 )
			hitsToRaiseGuard = 65536;
		// modEnemiesOfRivia
	}
	
	
	
	function Roll( chance : float ) : bool
	{
		if ( chance >= 100 )
			return true;
		else if ( RandRange(100) < chance )
		{
			return true;
		}
		
		return false;
	}
	
	
	
	function OnGameplayEvent( eventName : name ) : bool
	{		
		var owner 	: CNewNPC = GetNPC();
		var data 	: CDamageData;
		
		
		if ( eventName == 'BeingHit' && timeStamp + 0.4 <= GetLocalTime() )
		{
			data = (CDamageData) GetEventParamBaseDamage();
			if ( data.additiveHitReactionAnimRequested )
			{
				if ( processCounter )
				{
					damageIsMelee = data.isActionMelee;
					if ( !increaseHitCounterOnlyOnMeleeDmg || (increaseHitCounterOnlyOnMeleeDmg && damageIsMelee) )
					{
						owner.IncHitCounter();
					}
					CheckGuardOrCounter();
				}
				if( playHitSound && sounEventName != "None" && sounEventName != "")
				{
					if(owner.GetBoneIndex(boneName) != -1)
					{
						owner.SoundEvent(sounEventName, boneName);
					}
					else
					{
						owner.SoundEvent(sounEventName);
					}
				}
				owner.RaiseEvent('AdditiveHit');
				theGame.GetBehTreeReactionManager().CreateReactionEventIfPossible( owner, 'ActorInHitReaction', -1, 30.0f, -1.f, -1, true ); 
				timeStamp = GetLocalTime();
			}
		}
		
		return false;
	}
	
	function OnListenedGameplayEvent( eventName : name ) : bool
	{
		var npc 				: CNewNPC = GetNPC();
		var playerToOwnerAngle 	: float;
		
		
		if ( manageIgnoreSignsEvents )
		{
			if ( eventName == 'IgnoreSigns' )
			{
				playerToOwnerAngle = AbsF( NodeToNodeAngleDistance( thePlayer, npc ) );
				
				if( npc.UseAdditiveCriticalState() && !npc.IsUnstoppable() && playerToOwnerAngle <= angleToIgnoreSigns )
				{
					npc.RaiseEvent( 'IgnoreSigns' );
				}
				return true;
			}
			
			if ( eventName == 'IgnoreSignsEnd' )
			{
				npc.RaiseEvent( 'IgnoreSignsEnd' );
				return true;
			}
		}
		return false;
	}
}

class BTTaskAdditiveHitListenerDef extends IBehTreeTaskDefinition
{
	default instanceClass = 'BTTaskAdditiveHitListener';

	editable var playHitSound 						: bool;
	editable var sounEventName 						: string;
	editable var boneName 							: name;
	editable var manageIgnoreSignsEvents			: bool;
	editable var angleToIgnoreSigns					: float;
	editable var chanceToUseAdditive				: float;
	editable var increaseHitCounterOnlyOnMeleeDmg 	: bool;
	editable var processCounter 		 			: bool;
	
	default angleToIgnoreSigns = 45;
	
	function InitializeEvents()
	{
		super.InitializeEvents();
		listenToGameplayEvents.PushBack( 'IgnoreSigns' );
		listenToGameplayEvents.PushBack( 'IgnoreSignsEnd' );
	}
}

