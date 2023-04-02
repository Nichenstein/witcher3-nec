/***********************************************************************/
/** 	© 2015 CD PROJEKT S.A. All rights reserved.
/** 	THE WITCHER® is a trademark of CD PROJEKT S. A.
/** 	The Witcher game is based on the prose of Andrzej Sapkowski.
/***********************************************************************/



class CNPCStrengthsWeakeness extends CNewNPC
{	
	function FireWeakness(npc : CCharacterStats, appropriateSource : bool) : float
	{
		if(!appropriateSource) return 0;
		
		if(npc.HasAbility('mon_archespor_base')
		|| npc.HasAbility('mon_bear_berserker')
		|| npc.HasAbility('mon_werewolf_base')
		|| npc.HasAbility('mon_mq7018_basilisk')
		|| npc.HasAbility('mon_kikimore_base')
		|| npc.HasAbility('mon_spooncollector')
		|| npc.HasAbility('mon_waterhag')
		) return 0.21;
		
		if(npc.HasAbility('mon_boar_base') 
		|| npc.HasAbility('mon_boar_ep2_base')
		|| npc.HasAbility('mon_siren_base')
		|| npc.HasAbility('mon_ice_golem')
		|| npc.HasAbility('mon_wild_hunt_minion_weak')
		|| npc.HasAbility('mon_wild_hunt_minion_lesser')
		|| npc.HasAbility('mon_wild_hunt_minion')
		|| npc.HasAbility('mon_wild_hunt_minionMH')
		|| npc.HasAbility('mon_cloud_giant')
		|| npc.HasAbility('mon_sprigan_base')
		|| npc.HasAbility('mon_drowner')
		) return 0.23;
		
		if(npc.HasAbility('mon_lessog_base') 
		) return 0.33;
		
		return 0;
	}
	
	function ForceWeakness(npc : CCharacterStats, appropriateSource : bool) : float
	{
		if(!appropriateSource) return 0;
		
		if(npc.HasAbility('mon_archespor_base') 
		|| npc.HasAbility('mon_siren_base')
		|| npc.HasAbility('mon_black_spider_ep2_base')
		|| npc.HasAbility('mon_black_spider_base')
		) return 0.17;
		
		if(npc.HasAbility('mon_basilisk') 
		|| npc.HasAbility('mon_cockatrice')
		|| npc.HasAbility('mon_wyvern_base')
		|| npc.HasAbility('mon_draco_base')
		|| npc.HasAbility('mon_harpy_base')
		|| npc.HasAbility('mon_gryphon_lesser')
		|| npc.HasAbility('mon_gryphon')
		|| npc.HasAbility('mon_gryphon_stronger')
		|| npc.HasAbility('mon_gryphon_volcanic')
		|| npc.HasAbility('mon_waterhag')
		|| npc.HasAbility('mon_sharley_base')
		) return 0.37;
		
		if(npc.HasAbility('mon_elemental_fire_q211')
		|| npc.HasAbility('mon_elemental_fire')
		) return 0.33;
		
		return 0;
	}  

	function FrostWeakness(npc : CCharacterStats, appropriateSource : bool) : float
	{		
		if(!appropriateSource) return 0;
		
		if(npc.HasAbility('mh202_nekker')
		|| npc.HasAbility('mon_nekker_base')
		|| npc.HasAbility('mon_nekker_warrior')
		|| npc.HasAbility('mon_waterhag')
		) return 0.37;
		
		return 0;
	}
	
	function PoisonWeakness(npc : CCharacterStats, appropriateSource : bool) : float
	{
		if(!appropriateSource) return 0;
		
		if(npc.HasAbility('mon_toad_base') 
		|| npc.HasAbility('mon_gravehag_base')
		|| npc.HasAbility('mon_spooncollector')
		|| npc.HasAbility('mon_barghest_base')
		|| npc.HasAbility('mon_wraith_base')
		|| npc.HasAbility('mon_golem_base')
		|| npc.HasAbility('mon_noonwraith_base')
		|| npc.HasAbility('mon_nightwraith_iris')
		|| npc.HasAbility('mon_wraith_base')
		|| npc.HasAbility('mon_alghoul') 
		|| npc.HasAbility('mon_ghoul')
		|| npc.HasAbility('mon_ghoul_stronger')
		|| npc.HasAbility('mon_ghoul_lesser')
		) return -1.0;
		else if(npc.HasAbility('mon_garkain')
		) return 0.1;
		else if(npc.HasAbility('mon_bies_base')
		|| npc.HasAbility('mon_werewolf_base')
		|| npc.HasAbility('mon_fleder')
		|| npc.HasAbility('q704_mon_protofleder')
		) return 0.35;
		
		return 0;
	}   
	
	function ElementalWeakness(npc : CCharacterStats, appropriateSource : bool) : float
	{		
		if(!appropriateSource) return 0;
		
		return 0;
	} 

	function ShockWeakness(npc : CCharacterStats, appropriateSource : bool, IsInYrden: bool) : float
	{
		var modifier : float;
		modifier = 0;
		
		if(!appropriateSource) return 0;
				
		if(npc.HasAbility('qmh303_suc') 
		|| npc.HasAbility('mon_fugas_base')
		|| npc.HasAbility('mon_scolopendromorph_base')
		|| npc.HasAbility('mon_waterhag')
		|| npc.HasAbility('mon_gravehag_base')
		) modifier = 0.18;
		else if(npc.HasAbility('mon_toad_base') 
		|| npc.HasAbility('mon_spooncollector')
		|| npc.HasAbility('mon_knight_giant')
		|| npc.HasAbility('mon_cyclops')
		) modifier = 0.15;
		else if(npc.HasAbility('mon_boar_base') 
		|| npc.HasAbility('mon_boar_ep2_base') 
		|| npc.HasAbility('mon_golem_base')
		) modifier = 0.2;
		
		if( IsInYrden ) modifier *= 1.15f;
		
		return modifier;
	}   

	function YrdenWeakness_L(npc : CCharacterStats, IsInYrden: bool) : float
	{
		var modifier : float;
		modifier = 0;
		
		if(npc.HasAbility('mon_toad_base') 
		) modifier += 0.15;
		else if(npc.HasAbility('mon_boar_base') 
		|| npc.HasAbility('mon_boar_ep2_base') 
		|| npc.HasAbility('mon_scolopendromorph_base')
		|| npc.HasAbility('mon_gravehag_base')
		|| npc.HasAbility('mon_spooncollector')
		|| npc.HasAbility('mon_barghest_base')
		) modifier += 0.2;
		else if(npc.HasAbility('mon_golem_base')
		|| npc.HasAbility('mon_wraith_base')
		|| npc.HasAbility('mon_noonwraith_base')
		|| npc.HasAbility('mon_nightwraith_iris')
		|| npc.HasAbility('mon_vampiress_base')
		) modifier += 0.45;
		
		if(!IsInYrden) modifier *= -1;;
		
		return modifier;
	} 

	function QuenWeakness_L(npc : CCharacterStats) : float
	{		
		if(npc.HasAbility('mon_bear_base') 
		|| npc.HasAbility('mon_draco_base') 
		|| npc.HasAbility('qmh303_suc') 
		|| npc.HasAbility('mon_fugas_base') 
		|| npc.HasAbility('mon_waterhag')
		|| npc.HasAbility('mon_fogling_lesser')
		|| npc.HasAbility('mon_fogling')
		|| npc.HasAbility('mon_fogling_stronger')
		|| npc.HasAbility('mon_fogling_mh')
		|| npc.HasAbility('mon_fogling_doppelganger')
		|| npc.HasAbility('qmh108_fogling')
		|| npc.HasAbility('mon_gravehag_base')
		|| npc.HasAbility('mon_cyclops')
		|| npc.HasAbility('mon_knight_giant')
		|| npc.HasAbility('mon_ice_troll')
		|| npc.HasAbility('mon_ice_giant')
		|| npc.HasAbility('mon_troll_base')
		|| npc.HasAbility('q604_caretaker')
		) return 0.7;
		
		return 0;
	}   

	function AxiiWeakness_L(npc : CCharacterStats, IsAxiied : bool) : float
	{				
		if(!IsAxiied) return 0;
		
		if(npc.HasAbility('mon_black_spider_ep2_base')
		|| npc.HasAbility('mon_black_spider_base')
		|| npc.HasAbility('mon_wild_hunt_minion_weak')
		|| npc.HasAbility('mon_wild_hunt_minion_lesser')
		|| npc.HasAbility('mon_wild_hunt_minion')
		|| npc.HasAbility('mon_wild_hunt_minionMH')
		|| npc.HasAbility('mon_alghoul') 
		|| npc.HasAbility('mon_wight')
		|| npc.HasAbility('mon_cyclops')
		|| npc.HasAbility('mon_barghest_base')
		) return 0.25;
		
		return 0;
	} 

	function IsBleedImmune(npc : CCharacterStats) : bool
	{		
		if(npc.HasAbility('mon_barghest_base')
		|| npc.HasAbility('mon_wraith_base')
		|| npc.HasAbility('mon_golem_base')
		|| npc.HasAbility('mon_noonwraith_base')
		|| npc.HasAbility('mon_nightwraith_iris')
		|| npc.HasAbility('mon_wraith_base')
		) return true;
		
		return false;
	}   
	
	function GetSpeciesSpeedModifier(stats : CCharacterStats, GetSfxTag : CName) : float
	{
		if(stats.HasAbility('mon_gryphon_base') 
		|| stats.HasAbility('mon_draco_base')
		|| stats.HasAbility('mon_fugas_base')
		|| stats.HasAbility('mon_golem_base')
		|| stats.HasAbility('mon_wolf_base')
		) 
			return 0.12;
		else if (stats.HasAbility('mon_lessog_base')
		)
			return 0.17;
		else if (stats.HasAbility('mon_gravehag_base')
		|| stats.HasAbility('mon_endriaga_base')
		)
			return 0.08;
		else if (GetSfxTag == 'sfx_wraith' 
		|| stats.HasAbility('mon_noonwraith_base')
		|| stats.HasAbility('mon_arachas_base')
		)
			return 0.15;
		else if(GetSfxTag == 'sfx_nekker'
		|| stats.HasAbility('mon_drowner_base')
		|| stats.HasAbility('mon_ghoul_base')
		)
			return 0.05;
		else if(stats.HasAbility('mon_werewolf_base'))
			return 0.17;
		else if(stats.HasAbility('mon_cyclops')
		|| stats.HasAbility('mon_knight_giant')
		|| stats.HasAbility('mon_cloud_giant')
		|| stats.HasAbility('mon_ice_giant')
		)return 0.12;
						
		return 0;
	} 
	
	function ApplyScalingOffset(CustomScalingEnabled: bool, stats : CCharacterStats, RandMod : int, GetIsMonsterTypeGroup: bool, EssenceValue : float, VitalityValue : float)
	{
			var ability_name : name;
			
			stats.RemoveAbilityAll('NPCStatsBonusNoLvl');
			stats.RemoveAbilityAll('MonsterStatsBonusGroupNoLvl');
			stats.RemoveAbilityAll('MonsterStatsBonusNoLvl');
			
			if(RandMod <= 0 || !CustomScalingEnabled) return;
			
			ability_name = '';
			
			if( EssenceValue < 0 || VitalityValue > 0 ) ability_name = 'NPCStatsBonusNoLvl';
			else if( GetIsMonsterTypeGroup) ability_name = 'MonsterStatsBonusGroupNoLvl';
			else ability_name = 'MonsterStatsBonusNoLvl';
			
			if(ability_name == '') return;
			
			stats.AddAbilityMultiple(ability_name, RandMod);
	}
	  	
}