@IsTest 
private class RoutingTable_SetBoundsTest {
    final static String RoutedToName1 = 'ABC123';
    final static String RoutedToName2 = '321BCA';
    
    public static testmethod void testSingleName() {
        Routing_Table__c routing = new Routing_Table__c();
        routing.RecordTypeId = RoutingAnalysis.RecordTypePostalCode;
        routing.Matching__c = RoutedToName1;
        routing.Is_Active__c = true;
        routing.Routed_By__c = RoutingAnalysis.RoutedByUserId;
        routing.Routed_To__c = UserInfo.getUserId();
        insert routing;
        
        system.assertEquals(RoutedToName1, [
            select Lower_Bound__c
              from Routing_Table__c
             where Id = :routing.Id
             limit 1
        ].Lower_Bound__c);
        
        system.assertEquals(RoutedToName1, [
            select Upper_Bound__c
              from Routing_Table__c
             where Id = :routing.Id
             limit 1
        ].Upper_Bound__c);
    }

    public static testmethod void testRange() {
        Routing_Table__c routing = new Routing_Table__c();
        routing.RecordTypeId = RoutingAnalysis.RecordTypePostalCode;
        routing.Matching__c = RoutedToName1 + ' - ' + RoutedToName2;
        routing.Is_Active__c = true;
        routing.Routed_By__c = RoutingAnalysis.RoutedByUserId;
        routing.Routed_To__c = UserInfo.getUserId();
        insert routing;
        
        system.assertEquals(RoutedToName1, [
            select Lower_Bound__c
              from Routing_Table__c
             where Id = :routing.Id
             limit 1
        ].Lower_Bound__c);
        
        system.assertEquals(RoutedToName2, [
            select Upper_Bound__c
              from Routing_Table__c
             where Id = :routing.Id
             limit 1
        ].Upper_Bound__c);
    }
}