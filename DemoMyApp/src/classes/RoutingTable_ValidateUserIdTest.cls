@IsTest 
private class RoutingTable_ValidateUserIdTest {
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
    }
    
    public static testmethod void testExpectedFailure() {
        Routing_Table__c routing1 = new Routing_Table__c();
        routing1.RecordTypeId = RoutingAnalysis.RecordTypePostalCode;
        routing1.Matching__c = RoutedToName1;
        routing1.Is_Active__c = true;
        routing1.Routed_By__c = RoutingAnalysis.RoutedByUserId;
        routing1.Routed_To__c = String.valueOf(UserInfo.getUserId()).substring(0, 12) + '000';
        
        try {
            insert routing1;
            system.assert(false);
        } catch (System.DmlException pException) {
            system.assertEquals(StatusCode.FIELD_CUSTOM_VALIDATION_EXCEPTION, pException.getDmlType(0));
        }
    }

}