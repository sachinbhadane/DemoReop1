@IsTest 
private class RoutingTable_ValidateUserNameTest {
    final static String RoutedToName1 = 'ABC123';
    final static String RoutedToName2 = '321BCA';
    final static User[] UserList = [
        select Username
          from User
         where Id = :UserInfo.getUserId()
         limit 1
    ];
    
    public static testmethod void testOk() {
        if (UserList.size() == 0)
            return; // can't test
        
        Routing_Table__c routing1 = new Routing_Table__c();
        routing1.RecordTypeId = RoutingAnalysis.RecordTypePostalCode;
        routing1.Matching__c = RoutedToName1;
        routing1.Is_Active__c = true;
        routing1.Routed_By__c = RoutingAnalysis.RoutedByUserName;
        routing1.Routed_To__c = UserList[0].Username;
        insert routing1;
        
        system.assert(null != [
            select Uniqueness_ID__c
              from Routing_Table__c
             where Id = :routing1.Id
        ].Uniqueness_ID__c);
    }
    
    public static testmethod void testExpectedFailure() {
        if (UserList.size() == 0)
            return; // can't test
        
        Routing_Table__c routing1 = new Routing_Table__c();
        routing1.RecordTypeId = RoutingAnalysis.RecordTypePostalCode;
        routing1.Matching__c = RoutedToName1;
        routing1.Is_Active__c = true;
        routing1.Routed_By__c = RoutingAnalysis.RoutedByUserName;
        routing1.Routed_To__c = UserList[0].Id;
        
        try {
            insert routing1;
            system.assert(false);
        } catch (System.DmlException pException) {
            system.assertEquals(StatusCode.FIELD_CUSTOM_VALIDATION_EXCEPTION, pException.getDmlType(0));
        }
    }


}