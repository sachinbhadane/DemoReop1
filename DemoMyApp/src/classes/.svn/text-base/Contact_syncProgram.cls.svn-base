/***************************************************************************************
Class Name      : Contact_syncProgram
Author          : Mahesh Gaddam
Created Date    : November 20, 2011
Usage           : This class is for Contact_syncProgram trigger.                
                : This trigger updates Program__c field on Opportunities when the Primary_Program__c is updated on Contact.    
Revision History: 
****************************************************************************************/

public without sharing class Contact_syncProgram extends ContactTrigger {
    public Contact_syncProgram(Contact[] contactOldList, Contact[] contactNewList) {
        super(contactOldList, contactNewList);
    }
    
    public virtual override void execute() {
        if (Setting_Disabled__c.getInstance().Contact_syncProgram__c == true)
            return;
        
        rC_Messaging__Message__c[] messageInsertList = new rC_Messaging__Message__c[] {};
        
        for(Contact contactNew : contactNewList) {
            Contact contactOld = contactOld(contactNew.Id);
            
            if (contactNew == null || contactOld == null)
                continue;
            if (contactNew.Program_Primary__c == contactOld.Program_Primary__c)
                continue; // no change
            
            rC_Messaging__Message__c message = new rC_Messaging__Message__c();
            message.rC_Messaging__Endpoint__c = Contact_syncProgramServicer.ENDPOINT;
            message.rC_Messaging__Effective_Date__c = DateTime.now();
            message.rC_Messaging__Related_Method__c = null;
            message.rC_Messaging__Related_Record__c = contactNew.Id;
            messageInsertList.add(message);
        }
        
        if (messageInsertList.size() == 0)
            return;
        
        // If the servicer is "disabled", then run the code immediately, otherwise use the delayed
        // async aspect of the servicer. This can also be toggled in unit tests.
        if (Setting_Disabled__c.getInstance().Contact_syncProgramServicer__c == true) {
            Contact_syncProgramServicer contactServicer = new Contact_syncProgramServicer();
            contactServicer.processMessageBatch(messageInsertList);
            contactServicer.processDML();
        } else {
            insert messageInsertList;
        }
    }
}