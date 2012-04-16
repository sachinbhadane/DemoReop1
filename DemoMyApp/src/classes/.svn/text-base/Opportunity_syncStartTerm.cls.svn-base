/***************************************************************************************
Class Name      : Opportunity_syncStartTerm
Author          : Mahesh Gaddam
Created Date    : November 27, 2011
Usage           : This class is for Opportunity_syncStartTerm trigger which updates Start_Term__c field
                : on Contact when the Start_Term__c is updated on Opportunity.    
Revision History: 
****************************************************************************************/

public without sharing class Opportunity_syncStartTerm extends OpportunityTrigger {
    public Opportunity_syncStartTerm(Opportunity[] opportunityOldList, Opportunity[] opportunityNewList) {
        super(opportunityOldList, opportunityNewList);
    }
    
    public virtual override void execute() {
        if (Setting_Disabled__c.getInstance().Opportunity_syncStartTerm__c == true)
            return;
        
        rC_Messaging__Message__c[] messageInsertList = new rC_Messaging__Message__c[] {};
        
        for(Opportunity opportunityNew : opportunityNewList) {
            Opportunity opportunityOld = opportunityOld(opportunityNew.Id);
            
            if (opportunityNew == null || opportunityOld == null)
                continue;
            if (opportunityNew.Start_Term__c == opportunityOld.Start_Term__c)
                continue; // no change
            
            rC_Messaging__Message__c message = new rC_Messaging__Message__c();
            message.rC_Messaging__Endpoint__c = Opportunity_syncStartTermServicer.ENDPOINT;
            message.rC_Messaging__Effective_Date__c = DateTime.now();
            message.rC_Messaging__Related_Method__c = null;
            message.rC_Messaging__Related_Record__c = opportunityNew.Id;
            messageInsertList.add(message);
        }
        
        if (messageInsertList.size() == 0)
            return;
        
        // If the servicer is "disabled", then run the code immediately, otherwise use the delayed
        // async aspect of the servicer. This can also be toggled in unit tests.
        if (Setting_Disabled__c.getInstance().Opportunity_syncStartTermServicer__c == true) {
            Opportunity_syncStartTermServicer opportunityServicer = new Opportunity_syncStartTermServicer();
            opportunityServicer.processMessageBatch(messageInsertList);
            opportunityServicer.processDML();
        } else {
            insert messageInsertList;
        }
    }
}