global virtual without sharing class Lead_RouteByRecruitingServicer implements rC_Core.MessageServicer.Servicer {
    public static void schedule() {
        rC_Core.MessageServicerSchedulable.schedule(new rC_Core.MessageServicer.Servicer[] {
            new Lead_RouteByRecruitingServicer()
        });
    }
    
    global virtual void processMessage(rC_Core__Message__c message, Dom.Document payload) {
        if (Pattern.matches('^queue://Lead_RouteByRecruitingServicer$', message.rC_Core__Endpoint__c) == false)
            return;
        
        Set<Id> leadIds = new Set<Id> {};
        
        for(Dom.XmlNode xmlNode : payload.getRootElement().getChildElements())
            leadIds.add(xmlNode.getAttributeValue('id', null));
        
        Lead[] leadList = [
            select Name
                 , FirstName //Added by Mahesh G
                 , LastName // Added by Mahesh G
                 , Apply_Routing_Type__c
                 , IsConverted
                 , Lat__c
                 , Lon__c
                 , LeadSource
                 , PostalCode
                 , City
                 , Country
                 , OwnerId
                 , State
                 , Status
                 
                 // Hult fields
                 , Country_Of_Residence__c
                 , Country_Of_Residence_Name__c
                 , Age_Range__c
                 , Work_Load__c
                 , Department_Name_Primary__c
                 , Department_Name_Secondary__c
                 , Department_Name_Third__c
                 , Program_Primary__c
                 , Program_Secondary__c
                 , Program_Third__c
                 , Do_Not_Route__c
              from Lead
             where Id in :leadIds
               and IsConverted = false
        ];
        
        Lead_RouteByRecruiting.applyRouting(leadList);
        update leadList;
        
        // Mark the message as processed, set the deletion date/time
        message.rC_Core__Processed_Date__c = DateTime.now();
        message.rC_Core__Deletable_Date__c = DateTime.now().addMinutes(message.rC_Core__Deletable_Cache_Time__c.intValue());
    }
    
    public static testmethod void test() {
        QueueSobject[] queueSobjectList = [
            select Queue.Name
              from QueueSobject
             where SobjectType = 'Lead'
               and Queue.Name != null
             limit 1
        ];
        Program__c pro = [select id from Program__c limit 1];
        Country__c country = new Country__c();
        country.Name = 'TEST_COUNTRY';
        insert country;
        
        Routing_Table__c routing1 = new Routing_Table__c();
        routing1.RecordTypeId = RoutingAnalysis.RecordTypeRecruiting;
        routing1.Country__c = 'TEST_COUNTRY';
        routing1.Is_Active__c = true;
        routing1.Routed_By__c = RoutingAnalysis.RoutedByQueueId;
        routing1.Routed_To__c = queueSobjectList[0].Queue.Id;
        routing1.Region__c = 'RegionTarget';
        insert routing1;
        
        Lead lead = new Lead();
        lead.Country_Of_Residence__c = country.Id;
        lead.FirstName = 'FirstName';
        lead.LastName = 'LastName';
        lead.Email = 'email@example.com'; 
        lead.Applicant_Email__c = 'email@example.com';
        lead.Company = 'Company';
        lead.Country_Of_Residence__c = country.Id; //Added by Mahesh G
        lead.LeadSource = 'GMASS';//Added by Mahesh G
        lead.Program_Primary__c = pro.id;
        insert lead;
        
        rC_Core__Message__c message = new rC_Core__Message__c();
        message.rC_Core__Endpoint__c = 'queue://Lead_RouteByRecruitingServicer';
        message.rC_Core__Data__c = '<message><lead id="' + lead.Id + '" /></message>';
        message.rC_Core__Deletable_Cache_Time__c = 5;
        insert message;
        
        Dom.Document doc = new Dom.Document();
        doc.load(message.rC_Core__Data__c);
        
        new Lead_RouteByRecruitingServicer().processMessage(message, doc);
        
        system.assert(null != message.rC_Core__Processed_Date__c);
        system.assertEquals(false, message.rC_Core__Errors__c);
        
        system.assertEquals(queueSobjectList[0].Queue.Id, [
            select OwnerId
              from Lead
             where Id = :lead.Id
        ].OwnerId);
        
        system.assertEquals('RegionTarget', [
            select Region__c
              from Lead
             where Id = :lead.Id
        ].Region__c);
    }
}