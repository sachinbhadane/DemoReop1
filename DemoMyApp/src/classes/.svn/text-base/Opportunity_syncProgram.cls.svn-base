/***************************************************************************************
Class Name      : Opportunity_syncProgram
Author          : Mahesh Gaddam; Ian Zepp
Created Date    : November 21, 2011
Usage           : This class is used by Opportunity_syncProgram trigger which updates Primary_Program__c field in Contact when Program__c field on Opportunities is updated or inserted .                 
Revision History: 
****************************************************************************************/

public without sharing class Opportunity_syncProgram extends OpportunityTrigger {
    public Opportunity_syncProgram(Opportunity[] opportunityOldList, Opportunity[] opportunityNewList) {
        super(opportunityOldList, opportunityNewList);
    }
    
    public virtual override void execute() {
        if (Setting_Disabled__c.getInstance().Opportunity_syncProgram__c == true)
            return;
        
        rC_Messaging__Message__c[] messageInsertList = new rC_Messaging__Message__c[] {};
        
        for(Opportunity opportunityNew : opportunityNewList) {
            Opportunity opportunityOld = opportunityOld(opportunityNew.Id);
            
            if (opportunityNew == null || opportunityOld == null)
                continue;
            if (opportunityNew.Program__c == opportunityOld.Program__c)
                continue; // no change
            
            rC_Messaging__Message__c message = new rC_Messaging__Message__c();
            message.rC_Messaging__Endpoint__c = Opportunity_syncProgramServicer.ENDPOINT;
            message.rC_Messaging__Effective_Date__c = DateTime.now();
            message.rC_Messaging__Related_Method__c = null;
            message.rC_Messaging__Related_Record__c = opportunityNew.Id;
            messageInsertList.add(message);
        }
        
        if (messageInsertList.size() == 0)
            return;
        
        // If the servicer is "disabled", then run the code immediately, otherwise use the delayed
        // async aspect of the servicer. This can also be toggled in unit tests.
        if (Setting_Disabled__c.getInstance().Opportunity_syncProgramServicer__c == true) {
            Opportunity_syncProgramServicer opportunityServicer = new Opportunity_syncProgramServicer();
            opportunityServicer.processMessageBatch(messageInsertList);
            opportunityServicer.processDML();
        } else {
            insert messageInsertList;
        }
    }
}