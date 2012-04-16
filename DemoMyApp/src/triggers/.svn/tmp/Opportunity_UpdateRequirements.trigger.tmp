trigger Opportunity_UpdateRequirements on Opportunity (after insert, after update) 
{
	
	/*
		Code Modified By : Niket Chandane
		Modified date    : 4 April 2012
		Summary 		 : Opportunity_UpdateRequirements trigger executing unnecessary to avoid 
							extra operation added if condition and condition to check program change
	*/
	if(Trigger.isAfter && Trigger.isUpdate)
	{
		for(Opportunity objOpp : trigger.new)
		{
			Opportunity objOldOpp = trigger.OldMap.get(objOpp.Id);
			if(objOpp.Program__c != objOldOpp.Program__c)
			{
				// We need to call Update reqirement when program is get updated
				new Opportunity_UpdateRequirements(trigger.old, trigger.new).execute();
			}
		}
		
	}
	else if(Trigger.isAfter && Trigger.isInsert)
	 	new Opportunity_UpdateRequirements(trigger.old, trigger.new).execute();
}