public without sharing class Contact_ApplyRoutingTable extends ContactTrigger {
    public Contact_ApplyRoutingTable(Contact[] contactOldList, Contact[] contactNewList) {  
        super(contactOldList, contactNewList);
    }
    
    @future
    public static void executeFuture(Set<Id> contactIds) {
        Contact[] contactOldList = new Contact[] {};
        Contact[] contactNewList = [
            select Name
                 , Age_Range__c
                 , Apply_Routing_Type__c
                 , Department_Name_Primary__c
                 , Department_Name_Secondary__c
                 , Department_Name_Third__c
                 , Country_Of_Residence_Name__c
                 , Country_Of_Residence__c
                 , Do_Not_Route__c
                 , MailingPostalCode
                 , MailingCity
                 , MailingCountry
                 , MailingState
                 , OwnerId
                 , OtherPostalCode
                 , OtherCity
                 , OtherCountry
                 , OtherState
                 , Program_Primary__c
                 , Program_Secondary__c
                 , Program_Third__c
                 , Region__c
                 , Sub_Region__c
                 , Work_Load__c
              from Contact
             where Id in :contactIds
        ];
        
        new Contact_ApplyRoutingTable(contactOldList, contactNewList).execute(false);
        update contactNewList;
    }
    
    public void executeFromTriggerUpdateAsQueueMessage() {
        /* temp code by Rd
        Account acc = [select Id from Account where Name = 'TEST ACCOUNT - DO NOT DELETE'];
        for(Contact c : contactNewList){
            if (c.Region__c == 'Asia')
                c.AccountId = acc.Id;    
        } 
        */
        
        System.debug('RoutingAnalysis.getSetting().Is_Disabled__c ==>'+RoutingAnalysis.getSetting().Is_Disabled__c);
        if (RoutingAnalysis.getSetting().Is_Disabled__c == true)
            return;
        if (RoutingAnalysis.getSetting().Is_Disabled_On_Update__c == true)
            return;
        if (contactNewList.size() == 0) 
            return;
        
        Dom.Document doc = new Dom.Document();
        doc.createRootElement('message', null, null);
        
        for(Contact contactNew : contactNewList) {
            Contact contactOld = contactOld(contactNew.Id);
            
            Boolean isRoutable = contactNew.Program_Primary__c != contactOld.Program_Primary__c
                              || contactNew.Country_Of_Residence__c != contactOld.Country_Of_Residence__c
                              || contactNew.Apply_Routing_Type__c != null
                              || contactNew.Do_Not_Route__c != true && contactOld.Do_Not_Route__c == true;
            
            if (isRoutable == false)
                continue;
            
            Dom.XmlNode xml = doc.getRootElement().addChildElement('contact', null, null);
            xml.setAttribute('id', contactNew.Id);
        }
        
        if (doc.getRootElement().getChildElements().size() == 0)
            return;
        
        rC_Core__Message__c message = new rC_Core__Message__c();
        message.rC_Core__Endpoint__c = 'queue://Contact_RouteByRecruitingServicer';
        message.rC_Core__Data__c = doc.toXmlString();
        System.debug('message ===========>'+message);
        insert message;
    }
    
    public void execute(Boolean isInsert) {
    	system.debug('!!!!!!!!!!!!!!! 1');
        if (RoutingAnalysis.getSetting().Is_Disabled__c == true)
            return;
        if (RoutingAnalysis.getSetting().Is_Disabled_On_Insert__c == true && isInsert == true)
            return;
        if (RoutingAnalysis.getSetting().Is_Disabled_On_Update__c == true && isInsert == false)
            return;
        if (contactNewList.size() == 0) 
            return;
        
        Contact[] routingByRecruitingList = new Contact[] {};
        
        for(Contact contactNew : contactNewList) {
            if (contactNew == null)
                continue;
            if (contactNew.Apply_Routing_Type__c == null)
                continue;
            if (RoutingAnalysis.RoutingTypeRecruiting.equalsIgnoreCase(contactNew.Apply_Routing_Type__c))
                routingByRecruitingList.add(contactNew);
        }
        
        system.debug('routingByRecruitingList = ' + routingByRecruitingList);
        
        // For inserted records, we actually have to update this async.
        if (isInsert == true && routingByRecruitingList.size() != 0)
            executeFuture(new Map<Id, Contact>(routingByRecruitingList).keySet());
        // Updates (or async post-inserts) get executed now.
        if (isInsert == false && routingByRecruitingList.size() != 0)
            Contact_RouteByRecruiting.applyRouting(routingByRecruitingList);
    }
    
}