@IsTest
private class Lead_RouteByRecruitingTest {
    /** Commented out to reduce code usage.
      * Also, unit test for this was moved to Lead_RouteByRecruitingServicer
      * - Ian Zepp
          
    final static String RoutedToName1 = 'ABC123';
    final static QueueSobject[] QueueSobjectList = [
        select Queue.Name
          from QueueSobject
         where SobjectType = 'Lead'
           and Queue.Name != null
         limit 1
    ];
    
    public static testmethod void test() {
        if (QueueSobjectList.size() == 0)
            return; // can't test
        
        Country__c country = new Country__c();
        country.Name = RoutedToName1;
        insert country;
        
        Routing_Table__c routing1 = new Routing_Table__c();
        routing1.RecordTypeId = RoutingAnalysis.RecordTypeRecruiting;
        routing1.Country__c = RoutedToName1;
        routing1.Is_Active__c = true;
        routing1.Routed_By__c = RoutingAnalysis.RoutedByQueueId;
        routing1.Routed_To__c = QueueSobjectList[0].Queue.Id;
        routing1.Region__c = 'RegionTarget';
        insert routing1;
        
        Lead lead = new Lead();
        lead.Company = 'Company';
        lead.FirstName = 'FirstName';
        lead.LastName = 'LastName';
        lead.Email = 'sample@example.com';
        lead.Country_Of_Residence__c = country.Id;
        lead.OwnerId = UserInfo.getUserId();
        insert lead;
        
        Test.startTest();
        Lead_RouteByRecruiting leadController = new Lead_RouteByRecruiting(new ApexPages.StandardController(lead));
        leadController.getLeadId();
        leadController.execute();
        Test.stopTest();
        
        system.assertEquals(QueueSobjectList[0].Queue.Id, [
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
    */
}