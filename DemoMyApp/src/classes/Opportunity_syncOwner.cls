/***************************************************************************************
Class Name      : Opportunity_syncOwner
Author          : Mahesh Gaddam; Ian Zepp
Created Date    : November 21, 2011
Usage           : This class is used by Opportunity_syncOwner trigger which updates OwnerId field in Contact 
                  when OwnerId field on Opportunities is updated or inserted .                 
Revision History: 
****************************************************************************************/

public without sharing class Opportunity_syncOwner extends OpportunityTrigger {
    public Opportunity_syncOwner(Opportunity[] opportunityOldList, Opportunity[] opportunityNewList) {
        super(opportunityOldList, opportunityNewList);
    }
    
    public virtual override void execute() {
    	
    	// Opportunity_syncOwner__c was TRUE == TRUE thus entering the loop and not executing the trigger. 
        if (Setting_Disabled__c.getInstance().Opportunity_syncOwner__c == false)
        {
        	System.debug('::Opportunity_syncOwner::execute:: 1===>' +Setting_Disabled__c.Opportunity_syncOwner__c); 
        	return;
        }
            
           
        
        rC_Messaging__Message__c[] messageInsertList = new rC_Messaging__Message__c[] {};
        
        for(Opportunity opportunityNew : opportunityNewList) {
            Opportunity opportunityOld = opportunityOld(opportunityNew.Id);
            
            if (opportunityNew == null || opportunityOld == null)
                continue;
            if (opportunityNew.OwnerId == opportunityOld.OwnerId)
                continue; // no change
            
            System.debug('::Opportunity_syncOwner::execute:: 2===>'); 
            rC_Messaging__Message__c message = new rC_Messaging__Message__c();
            message.rC_Messaging__Endpoint__c = Opportunity_syncOwnerServicer.ENDPOINT;
            message.rC_Messaging__Effective_Date__c = DateTime.now();
            message.rC_Messaging__Related_Method__c = null;
            message.rC_Messaging__Related_Record__c = opportunityNew.Id;
            messageInsertList.add(message);
            
            System.debug('::Opportunity_syncOwner::execute:: 3===>'); 
        }
        
        if (messageInsertList.size() == 0)
            return;
        
        // If the servicer is "disabled", then run the code immediately, otherwise use the delayed
        // async aspect of the servicer. This can also be toggled in unit tests.
        if (Setting_Disabled__c.getInstance().Opportunity_syncOwnerServicer__c == true) {
        	System.debug('::Opportunity_syncOwner::execute:: 4===>'); 
            Opportunity_syncOwnerServicer opportunityServicer = new Opportunity_syncOwnerServicer();
            opportunityServicer.processMessageBatch(messageInsertList);
            opportunityServicer.processDML();
            System.debug('::Opportunity_syncOwner::execute:: 5===>'); 
        } else {
            insert messageInsertList;
            System.debug('::Opportunity_syncOwner::execute:: 6===>'); 
        }
    }
}