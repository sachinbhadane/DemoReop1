global with sharing class Opportunity_syncStartTermServicer implements rc_Messaging.MessageServicer.Servicer {
    public static final String ENDPOINT = 'hult://Opportunity_syncStartTermServicer';
    public Contact[] contactUpdateList { get; private set; }
    
    global virtual void processMessage(rC_Messaging__Message__c message, Dom.Document payload) {
        if (message == null)
            throw new rc_Messaging.MessageServicer.ServicerException('Invalid Message');
        if (message.rC_Messaging__Endpoint__c == null)
            throw new rc_Messaging.MessageServicer.ServicerException('Invalid Message Endpoint');
        if (getIsEndpointMatching(message.rC_Messaging__Endpoint__c) == false)
            return; // no endpoint match
        
        processMessageBatch(new rC_Messaging__Message__c[] { message });
        processDML();
        processMessageFinished(message);
    }
    
    public virtual void processMessageFinished(rC_Messaging__Message__c message) {
        if (message.rC_Messaging__Deletable_Cache_Time__c == null) {
            message.rC_Messaging__Processed_Date__c = DateTime.now();
            message.rC_Messaging__Deletable_Date__c = DateTime.now();
        } else {
            message.rC_Messaging__Processed_Date__c = DateTime.now();
            message.rC_Messaging__Deletable_Date__c = DateTime.now().addMinutes(message.rC_Messaging__Deletable_Cache_Time__c.intValue());
        }
    }
    
    public virtual void processMessageBatch(rC_Messaging__Message__c[] messageList) {
        // Reset the update list
        contactUpdateList = new Contact[] {};
        
        // Build a map of opportunity IDs
        Map<Id, Opportunity> opportunityMap = new Map<Id, Opportunity> {};
        
        for(rC_Messaging__Message__c message : messageList) {
            opportunityMap.put(message.rC_Messaging__Related_Record__c, null);
        }
        
        // Find the related opportunities
        Opportunity[] opportunityList = [
            select Contact__r.Start_Term__c
                 , Start_Term__c
              from Opportunity
             where Id in :opportunityMap.keySet()
               and Contact__c != null
               and IsClosed = false
        ];
        
        for(Opportunity opportunity : opportunityList) {
            if (opportunity.Contact__r.Start_Term__c == opportunity.Start_Term__c)
                continue;
            
            Contact contact = new Contact(Id = opportunity.Contact__r.Id);
            contact.Start_Term__c = opportunity.Start_Term__c;
            contactUpdateList.add(contact);
        }
    }
    
    public virtual void processDML() {
        if (contactUpdateList.size() == 0)
            return;
        update contactUpdateList;
    }
    
    public virtual Boolean getIsEndpointMatching(String queueName) {
        return ENDPOINT.equalsIgnoreCase(queueName);
    }
}