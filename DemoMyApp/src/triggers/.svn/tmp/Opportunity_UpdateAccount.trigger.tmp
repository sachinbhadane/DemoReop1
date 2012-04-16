trigger Opportunity_UpdateAccount on Opportunity (before insert, before update) 
{
	// Change By : Niket Chandane 
	// Comment 	 : 
	if(Trigger.isUpdate)
    	new Opportunity_UpdateAccount(trigger.old, trigger.new).execute();
}