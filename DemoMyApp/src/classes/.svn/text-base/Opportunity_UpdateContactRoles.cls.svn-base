public without sharing class Opportunity_UpdateContactRoles extends OpportunityTrigger {
    public Opportunity_UpdateContactRoles(Opportunity[] opportunityOldList, Opportunity[] opportunityNewList) {
        super(opportunityOldList, opportunityNewList);
    }
    
    public override void execute() {
        Set<String> opportunityContactRoleSet = new Set<String> {};
        
        for(OpportunityContactRole opportunityContactRole : [
            select OpportunityId
                 , ContactId
              from OpportunityContactRole
             where OpportunityId in :opportunityNewList
        ]) opportunityContactRoleSet.add(opportunityContactRole.OpportunityId + ':' + opportunityContactRole.ContactId);
        
        Map<Id, Id> opportunityContactRoleMissingMap = new Map<Id, Id> {};
        
        for(Opportunity opportunityNew : opportunityNewList) {
            if (opportunityNew == null || opportunityNew.Contact__c == null)
                continue;
            if (opportunityContactRoleSet.contains(opportunityNew.Id + ':' + opportunityNew.Contact__c))
                continue;
            opportunityContactRoleMissingMap.put(opportunityNew.Id, opportunityNew.Contact__c);
        }
        
        if (opportunityContactRoleMissingMap.size() == 0)
            return;
        
        OpportunityContactRole[] opportunityContactRoleList = new OpportunityContactRole[] {};
        
        for(Id opportunityId : opportunityContactRoleMissingMap.keySet()) {
            OpportunityContactRole opportunityContactRole = new OpportunityContactRole();
            opportunityContactRole.ContactId = opportunityContactRoleMissingMap.get(opportunityId);
            opportunityContactRole.OpportunityId = opportunityId;
            opportunityContactRole.Role = 'Applicant';
            opportunityContactRole.IsPrimary = true;
            opportunityContactRoleList.add(opportunityContactRole);
        }
        
        insert opportunityContactRoleList;
    }
}