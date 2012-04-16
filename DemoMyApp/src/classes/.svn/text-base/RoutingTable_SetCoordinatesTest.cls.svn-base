@IsTest
private class RoutingTable_SetCoordinatesTest {
    final static Decimal RoutedToLat = 30.000;
    final static Decimal RoutedToLon = -122.0;
    
    public static testmethod void testOk() {
        Routing_Table__c routing = new Routing_Table__c();
        routing.RecordTypeId = RoutingAnalysis.RecordTypeProximity;
        routing.Matching__c = RoutedToLat + ',' + RoutedToLon;
        routing.Is_Active__c = true;
        routing.Routed_By__c = RoutingAnalysis.RoutedByUserId;
        routing.Routed_To__c = UserInfo.getUserId();
        insert routing;
        
        system.assertEquals(RoutedToLat, [
            select Lat__c
              from Routing_Table__c
             where Id = :routing.Id
             limit 1
        ].Lat__c);
        
        system.assertEquals(RoutedToLon, [
            select Lon__c
              from Routing_Table__c
             where Id = :routing.Id
             limit 1
        ].Lon__c);
    }

    public static testmethod void testExpectedFailure() {
        Routing_Table__c routing = new Routing_Table__c();
        routing.RecordTypeId = RoutingAnalysis.RecordTypeProximity;
        routing.Matching__c = RoutedToLon + ',' + RoutedToLat;
        routing.Is_Active__c = true;
        routing.Routed_By__c = RoutingAnalysis.RoutedByUserId;
        routing.Routed_To__c = UserInfo.getUserId();
        
        try {
            insert routing;
            system.assert(false);
        } catch (System.DmlException pException) {
            system.assertEquals(StatusCode.FIELD_CUSTOM_VALIDATION_EXCEPTION, pException.getDmlType(0));
        }
    }
}