trigger Opportunity_UpdateRollups on Opportunity (before insert, before update) 
{
	if(Trigger.isUpdate)
    	new Opportunity_UpdateRollups(trigger.old, trigger.new).execute();
}