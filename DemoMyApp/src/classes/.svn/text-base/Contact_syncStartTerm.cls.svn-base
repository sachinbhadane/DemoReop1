/***************************************************************************************
Class Name      : Contact_syncStartTerm
Author          : Mahesh Gaddam
Created Date    : November 27, 2011
Usage           : This class is for Contact_syncStartTerm trigger which updates Start_Term__c field                
                : on Opportunities when the Start_Term__c is updated on Contact.    
Revision History: 
****************************************************************************************/
public without sharing class Contact_syncStartTerm extends ContactTrigger {
    public Contact_syncStartTerm(Contact[] contactOldList, Contact[] contactNewList) {
        super(contactOldList, contactNewList);
    }
    
    public virtual override void execute() {
        if (Setting_Disabled__c.getInstance().Contact_syncStartTerm__c == true)
            return;
        
        rC_Messaging__Message__c[] messageInsertList = new rC_Messaging__Message__c[] {};
        
        for(Contact contactNew : contactNewList) {
            Contact contactOld = contactOld(contactNew.Id);
            
            if (contactNew == null || contactOld == null)
                continue;
            if (contactNew.Start_Term__c == contactOld.Start_Term__c)
                continue; // no change
            
            rC_Messaging__Message__c message = new rC_Messaging__Message__c();
            message.rC_Messaging__Endpoint__c = Contact_syncStartTermServicer.ENDPOINT;
            message.rC_Messaging__Effective_Date__c = DateTime.now();
            message.rC_Messaging__Related_Method__c = null;
            message.rC_Messaging__Related_Record__c = contactNew.Id;
            messageInsertList.add(message);
        }
        
        if (messageInsertList.size() == 0)
            return;
        
        // If the servicer is "disabled", then run the code immediately, otherwise use the delayed
        // async aspect of the servicer. This can also be toggled in unit tests.
        if (Setting_Disabled__c.getInstance().Contact_syncStartTermServicer__c == true) {
            Contact_syncStartTermServicer contactServicer = new Contact_syncStartTermServicer();
            contactServicer.processMessageBatch(messageInsertList);
            contactServicer.processDML();
        } else {
            insert messageInsertList;
        }
    }
}