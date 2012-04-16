@IsTest
private class RoutingTable_SetNameTest {
    public static testmethod void testOk() {
        Routing_Table__c routing = new Routing_Table__c();
        routing.RecordTypeId = RoutingAnalysis.RecordTypePostalCode;
        routing.Matching__c = ' A b12 - 34b 5 ';
        routing.Is_Active__c = true;
        routing.Routed_By__c = RoutingAnalysis.RoutedByUserId;
        routing.Routed_To__c = UserInfo.getUserId();
        insert routing;
        
        system.assertEquals('AB12-34B5', [
            select Matching__c
              from Routing_Table__c
             where Id = :routing.Id
             limit 1
        ].Matching__c);
    }
}