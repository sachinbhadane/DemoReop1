public with sharing class Opportunity_UpdateRollups extends OpportunityTrigger {
    public Opportunity_UpdateRollups(Opportunity[] opportunityOldList, Opportunity[] opportunityNewList) {
        super(opportunityOldList, opportunityNewList);
    }
    
    public virtual override void execute() {
    	
    }
}