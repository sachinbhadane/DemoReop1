@IsTest
private class Lead_RouteByPostalCodeTest {
    /** Commented out to reduce code usage.
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
        
        Routing_Table__c routing1 = new Routing_Table__c();
        routing1.RecordTypeId = RoutingAnalysis.RecordTypePostalCode;
        routing1.Matching__c = RoutedToName1;
        routing1.Is_Active__c = true;
        routing1.Routed_By__c = RoutingAnalysis.RoutedByQueueId;
        routing1.Routed_To__c = QueueSobjectList[0].Queue.Id;
        insert routing1;
        
        Lead lead = new Lead();
        lead.Company = 'Company';
        lead.FirstName = 'FirstName';
        lead.LastName = 'LastName';
        lead.Email = 'sample@example.com';
        lead.PostalCode = RoutedToName1;
        lead.OwnerId = UserInfo.getUserId();
        insert lead;
        
        Test.startTest();
        Lead_RouteByPostalCode leadController = new Lead_RouteByPostalCode(new ApexPages.StandardController(lead));
        leadController.getLeadId();
        leadController.execute();
        Test.stopTest();
    }
    */
}