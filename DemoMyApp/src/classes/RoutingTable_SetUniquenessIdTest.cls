@IsTest 
private class RoutingTable_SetUniquenessIdTest {
    final static String RoutedToName1 = 'ABC123';
    final static String RoutedToName2 = '321BCA';
    
    public static testmethod void testOk() {
        Routing_Table__c routing1 = new Routing_Table__c();
        routing1.RecordTypeId = RoutingAnalysis.RecordTypePostalCode;
        routing1.Matching__c = RoutedToName1;
        routing1.Is_Active__c = true;
        routing1.Routed_By__c = RoutingAnalysis.RoutedByUserId;
        routing1.Routed_To__c = UserInfo.getUserId();
        insert routing1;
        
        system.assert(null != [
            select Uniqueness_ID__c
              from Routing_Table__c
             where Id = :routing1.Id
        ].Uniqueness_ID__c);
        
        Routing_Table__c routing2 = new Routing_Table__c();
        routing2.RecordTypeId = RoutingAnalysis.RecordTypePostalCode;
        routing2.Matching__c = RoutedToName2;
        routing2.Is_Active__c = true;
        routing2.Routed_By__c = RoutingAnalysis.RoutedByUserId;
        routing2.Routed_To__c = UserInfo.getUserId();
        insert routing2;
        
        system.assert(null != [
            select Uniqueness_ID__c
              from Routing_Table__c
             where Id = :routing2.Id
        ].Uniqueness_ID__c);
    }
    
    public static testmethod void testExpectedFailure() {
        Routing_Table__c routing1 = new Routing_Table__c();
        routing1.RecordTypeId = RoutingAnalysis.RecordTypePostalCode;
        routing1.Matching__c = RoutedToName1;
        routing1.Is_Active__c = true;
        routing1.Routed_By__c = RoutingAnalysis.RoutedByUserId;
        routing1.Routed_To__c = UserInfo.getUserId();
        
        Routing_Table__c routing2 = new Routing_Table__c();
        routing2.RecordTypeId = RoutingAnalysis.RecordTypePostalCode;
        routing2.Matching__c = RoutedToName1;
        routing2.Is_Active__c = true;
        routing2.Routed_By__c = RoutingAnalysis.RoutedByUserId;
        routing2.Routed_To__c = UserInfo.getUserId();
        
        try {
            insert routing1;
            insert routing2;
            system.assert(false);
        } catch (System.DmlException pException) {
            system.assertEquals(StatusCode.DUPLICATE_VALUE, pException.getDmlType(0));
        }
    }
}