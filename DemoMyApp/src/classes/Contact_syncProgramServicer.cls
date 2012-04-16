global with sharing class Contact_syncProgramServicer implements rc_Messaging.MessageServicer.Servicer {
    public static final String ENDPOINT = 'hult://Contact_syncProgramServicer';
    public Opportunity[] opportunityUpdateList { get; private set; }
    
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
        opportunityUpdateList = new Opportunity[] {};
        
        // Build a map of contact IDs
        Map<Id, Contact> contactMap = new Map<Id, Contact> {};
        
        for(rC_Messaging__Message__c message : messageList) {
            contactMap.put(message.rC_Messaging__Related_Record__c, null);
        }
        
        // Find the related contact
        Opportunity[] opportunityList = [
            select Contact__r.Program_Primary__c
                 , Program__c
              from Opportunity
             where Contact__c in :contactMap.keySet()
               and Contact__c != null
               and IsClosed = false
        ];
        
        for(Opportunity opportunity : opportunityList) {
            if (opportunity.Contact__r.Program_Primary__c == opportunity.Program__c)
                continue;
            
            opportunity.Program__c = opportunity.Contact__r.Program_Primary__c;
            opportunityUpdateList.add(opportunity);
        }
    }
    
    public virtual void processDML() {
        if (opportunityUpdateList.size() == 0)
            return;
        update opportunityUpdateList;
    }
    
    public virtual Boolean getIsEndpointMatching(String queueName) {
        return ENDPOINT.equalsIgnoreCase(queueName);
    }
}