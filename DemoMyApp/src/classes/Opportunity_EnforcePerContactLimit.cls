public without sharing class Opportunity_EnforcePerContactLimit extends OpportunityTrigger {
    public Opportunity_EnforcePerContactLimit(Opportunity[] opportunityOldList, Opportunity[] opportunityNewList) {
        super(opportunityOldList, opportunityNewList);
    }
    
    public virtual override void execute() {
        Set<Id> opportunityContactIds = new Set<Id> {};
        
        for(Opportunity opportunityNew : opportunityNewList) {
            opportunityContactIds.add(opportunityNew.Contact__c);
        }
        
        // Build a Contact=>Opp mapping of existing opps
        Map<Id, Opportunity> opportunityExistingMap = new Map<Id, Opportunity> {};
        
        for(Opportunity opportunityExisting : [
            select Contact__c
              from Opportunity
             where Contact__c in :opportunityContactIds
               and Contact__c != null
               and Id not in :opportunityNewList
        ]) opportunityExistingMap.put(opportunityExisting.Contact__c, opportunityExisting);
        
        // Scan the incoming opps, and flag duplicates
        for(Opportunity opportunityNew : opportunityNewList) {
            if (opportunityNew.Contact__c == null)
                continue;
            if (opportunityExistingMap.containsKey(opportunityNew.Contact__c) == false)
                continue;
            opportunityNew.Contact__c.addError('There is already an application linked to this contact.');
        }
    }
}