global virtual without sharing class Contact_RouteByRecruitingServicer implements rC_Core.MessageServicer.Servicer {
    global virtual void processMessage(rC_Core__Message__c message, Dom.Document payload) {
        if (Pattern.matches('^queue://Contact_RouteByRecruitingServicer$', message.rC_Core__Endpoint__c) == false)
            return;
        
        Set<Id> contactIds = new Set<Id> {};
        
        for(Dom.XmlNode xmlNode : payload.getRootElement().getChildElements())
            contactIds.add(xmlNode.getAttributeValue('id', null));
        
        Contact[] contactList = [
            select Name
                 , Age_Range__c
                 , RecordTypeId
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
        
        Contact_RouteByRecruiting.applyRouting(contactList);
        /*
        for(Contact c : contactList){
            c.Alumnus__c = true;
        }
        */
        update contactList;
        
        // Mark the message as processed, set the deletion date/time
        message.rC_Core__Processed_Date__c = DateTime.now();
        message.rC_Core__Deletable_Date__c = DateTime.now().addMinutes(message.rC_Core__Deletable_Cache_Time__c.intValue());
    }
    
    public static testmethod void test() {
        Account account = [select Id from Account limit 1];
        Country__c country = [select Id from Country__c limit 1];
        Program__c program = [select Id from Program__c limit 1];
        
        Contact contact = new Contact();
        contact.AccountId = account.Id;
        contact.FirstName = 'FirstName';
        contact.LastName = 'LastName';
        contact.Email = '8a8f55414f779750c8c068c4a172e725@example.com';
        contact.Program_Primary__c = program.Id;
        contact.Country_Of_Residence__c = country.Id;
        contact.Start_Term__c = 'Undecided';
        insert contact;
        
        rC_Core__Message__c message = new rC_Core__Message__c();
        message.rC_Core__Endpoint__c = 'queue://Contact_RouteByRecruitingServicer';
        message.rC_Core__Data__c = '<message><contact id="' + contact.Id + '" /></message>';
        message.rC_Core__Deletable_Cache_Time__c = 5;
        insert message;
        
        Dom.Document doc = new Dom.Document();
        doc.load(message.rC_Core__Data__c);
        
        new Contact_RouteByRecruitingServicer().processMessage(message, doc);
    }
}