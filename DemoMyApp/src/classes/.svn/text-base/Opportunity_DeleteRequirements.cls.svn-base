public without sharing class Opportunity_DeleteRequirements extends OpportunityTrigger {
    public Opportunity_DeleteRequirements(Opportunity[] opportunityOldList, Opportunity[] opportunityNewList) {
        super(opportunityOldList, opportunityNewList);
    }
    
    // This trigger applies when the program has changed
    
    public virtual override void execute() {
        // Disabled at a global level?
        if (getDisabledSetting().Opportunity_DeleteRequirements__c == true)
            return;
        
        delete [
            select Id 
              from Requirement__c 
             where Opportunity__c in :opportunityNewList
        ];
    }
}