@IsTest 
private class Lead_ApplyRoutingTableTest {
    /**
     *
     
    final static Decimal Latitude = 0.898748;
    final static Decimal Longitude = 0.037684;
    
    final static String RoutedToRegion = 'NA';
    final static String RoutedToCountry = 'MY_COUNTRY_TEST';
    final static String RoutedToCoords = Latitude + ',' + Longitude;
    final static String RoutedToName1 = '00010';
    final static String RoutedToName2 = '00020';
    final static String RoutedToNameTarget = '00015';
    
    public static final User ExecutingUser = [
        select Username
          from User
         where Id = :UserInfo.getUserId()
    ];
    
    public static Lead newLead(String postalCode, String routingType) {
        return newLead(postalCode, null, routingType);
    }
    
    public static Lead newLead(String postalCode, String countryCode, String routingType) {
        Country__c country = new Country__c();
        country.Name = countryCode;
        insert country;
        
        Lead lead = new Lead();
        lead.FirstName = 'FirstName';
        lead.LastName = 'LastName';
        lead.Company = 'Company';
        lead.PostalCode = postalCode;
        lead.Lat__c = Latitude + 1;
        lead.Lon__c = Longitude - 1;
        lead.Country_Of_Residence__c = country.Id;
        lead.Apply_Routing_Type__c = routingType;
        return lead;
    }
    
    public static Id newQueueId() {
        Group queue = new Group();
        
        system.runAs(ExecutingUser) {
            queue.Name = 'Lead_ApplyRoutingTableTest';
            queue.Type = 'Queue';
            insert queue;
            insert new QueueSobject(QueueId = queue.Id, SobjectType = 'Lead');
        }
        
        return queue.Id;
    }
    
    //
    // Postal code tests
    //
    
    public static testmethod void testRoutingByPostalCodeAndQueueId() {
        Id queueId = newQueueId();
        
        Routing_Table__c routing = new Routing_Table__c();
        routing.RecordTypeId = RoutingAnalysis.RecordTypePostalCode;
        routing.Matching__c = RoutedToName1;
        routing.Routed_By__c = RoutingAnalysis.RoutedByQueueId;
        routing.Routed_To__c = queueId;
        routing.Is_Active__c = true;
        insert routing;
        
        Test.startTest();
        Lead lead = newLead(RoutedToName1, RoutingAnalysis.RoutingTypePostalCode);
        insert lead;
        Test.stopTest();
        
        system.assertEquals(queueId, [
            select OwnerId
              from Lead
             where Id = :lead.Id
             limit 1
        ].OwnerId);
    }
    
    public static testmethod void testRoutingByPostalCodeAndQueueName() {
        Id queueId = newQueueId();
        
        Routing_Table__c routing = new Routing_Table__c();
        routing.RecordTypeId = RoutingAnalysis.RecordTypePostalCode;
        routing.Matching__c = RoutedToName1;
        routing.Routed_By__c = RoutingAnalysis.RoutedByQueueName;
        routing.Routed_To__c = 'Lead_ApplyRoutingTableTest';
        routing.Is_Active__c = true;
        insert routing;
        
        Test.startTest();
        Lead lead = newLead(RoutedToName1, RoutingAnalysis.RoutingTypePostalCode);
        insert lead;
        Test.stopTest();
        
        system.assertEquals(queueId, [
            select OwnerId
              from Lead
             where Id = :lead.Id
             limit 1
        ].OwnerId);
        
    }
    
    public static testmethod void testRoutingByPostalCodeAndUserId() {
        Routing_Table__c routing = new Routing_Table__c();
        routing.RecordTypeId = RoutingAnalysis.RecordTypePostalCode;
        routing.Matching__c = RoutedToName1;
        routing.Is_Active__c = true;
        routing.Routed_By__c = RoutingAnalysis.RoutedByUserId;
        routing.Routed_To__c = UserInfo.getUserId();
        routing.Country__c = RoutedToCountry;
        insert routing;
        
        Test.startTest();
        Lead lead = newLead(RoutedToName1, RoutingAnalysis.RoutingTypePostalCode);
        insert lead;
        Test.stopTest();
        
        system.assertEquals(UserInfo.getUserId(), [
            select OwnerId
              from Lead
             where Id = :lead.Id
             limit 1
        ].OwnerId);
    }
    
    public static testmethod void testRoutingByPostalCodeAndUserName() {
        Routing_Table__c routing = new Routing_Table__c();
        routing.RecordTypeId = RoutingAnalysis.RecordTypePostalCode;
        routing.Matching__c = RoutedToName1;
        routing.Is_Active__c = true;
        routing.Routed_By__c = RoutingAnalysis.RoutedByUserName;
        routing.Routed_To__c = ExecutingUser.Username;
        routing.Country__c = RoutedToCountry;
        insert routing;
        
        Test.startTest();
        Lead lead = newLead(RoutedToName1, RoutingAnalysis.RoutingTypePostalCode);
        insert lead;
        Test.stopTest();
        
        system.assertEquals(UserInfo.getUserId(), [
            select OwnerId
              from Lead
             where Id = :lead.Id
             limit 1
        ].OwnerId);
    }
    
    public static testmethod void testRoutingByPostalCodeAndRange() {
        Id queueId = newQueueId();
        
        Routing_Table__c routing = new Routing_Table__c();
        routing.RecordTypeId = RoutingAnalysis.RecordTypePostalCode;
        routing.Matching__c = RoutedToName1 + ' - ' + RoutedToName2;
        routing.Routed_By__c = RoutingAnalysis.RoutedByQueueId;
        routing.Routed_To__c = queueId;
        routing.Is_Active__c = true;
        insert routing;
        
        Test.startTest();
        Lead lead = newLead(RoutedToNameTarget, RoutingAnalysis.RoutingTypePostalCode);
        insert lead;
        Test.stopTest();
        
        system.assertEquals(queueId, [
            select OwnerId
              from Lead
             where Id = :lead.Id
             limit 1
        ].OwnerId);
    }

    //
    // Proximity tests
    //
    
    public static testmethod void testRoutingByProximityAndQueueId() {
        Id queueId = newQueueId();
        
        Routing_Table__c routing = new Routing_Table__c();
        routing.RecordTypeId = RoutingAnalysis.RecordTypeProximity;
        routing.Matching__c = RoutedToCoords;
        routing.Routed_By__c = RoutingAnalysis.RoutedByQueueId;
        routing.Routed_To__c = queueId;
        routing.Is_Active__c = true;
        routing.Country__c = RoutedToCountry;
        insert routing;
        
        Test.startTest();
        Lead lead = newLead(RoutedToName1, RoutingAnalysis.RoutingTypeProximity);
        insert lead;
        Test.stopTest();
        
        system.assertEquals(queueId, [
            select OwnerId
              from Lead
             where Id = :lead.Id
             limit 1
        ].OwnerId);
    }
    
    public static testmethod void testRoutingByProximityAndQueueName() {
        Id queueId = newQueueId();
        
        Routing_Table__c routing = new Routing_Table__c();
        routing.RecordTypeId = RoutingAnalysis.RecordTypeProximity;
        routing.Matching__c = RoutedToCoords;
        routing.Routed_By__c = RoutingAnalysis.RoutedByQueueName;
        routing.Routed_To__c = 'Lead_ApplyRoutingTableTest';
        routing.Is_Active__c = true;
        routing.Country__c = RoutedToCountry;
        insert routing;
        
        Test.startTest();
        Lead lead = newLead(RoutedToName1, RoutingAnalysis.RoutingTypeProximity);
        insert lead;
        Test.stopTest();
        
        system.assertEquals(queueId, [
            select OwnerId
              from Lead
             where Id = :lead.Id
             limit 1
        ].OwnerId);
    }
    
    public static testmethod void testRoutingByProximityAndUserId() {
        Routing_Table__c routing = new Routing_Table__c();
        routing.RecordTypeId = RoutingAnalysis.RecordTypeProximity;
        routing.Matching__c = RoutedToCoords;
        routing.Is_Active__c = true;
        routing.Routed_By__c = RoutingAnalysis.RoutedByUserId;
        routing.Routed_To__c = UserInfo.getUserId();
        routing.Country__c = RoutedToCountry;
        insert routing;
        
        Test.startTest();
        Lead lead = newLead(RoutedToName1, RoutingAnalysis.RoutingTypeProximity);
        insert lead;
        Test.stopTest();
        
        system.assertEquals(UserInfo.getUserId(), [
            select OwnerId
              from Lead
             where Id = :lead.Id
             limit 1
        ].OwnerId);
    }
    
    public static testmethod void testRoutingByProximityAndUserName() {
        
        Routing_Table__c routing = new Routing_Table__c();
        routing.RecordTypeId = RoutingAnalysis.RecordTypeProximity;
        routing.Matching__c = RoutedToCoords;
        routing.Is_Active__c = true;
        routing.Routed_By__c = RoutingAnalysis.RoutedByUserName;
        routing.Routed_To__c = ExecutingUser.Username;
        routing.Country__c = RoutedToCountry;
        insert routing;
        
        Test.startTest();
        Lead lead = newLead(RoutedToName1, RoutingAnalysis.RoutingTypeProximity);
        insert lead;
        Test.stopTest();
        
        system.assertEquals(UserInfo.getUserId(), [
            select OwnerId
              from Lead
             where Id = :lead.Id
             limit 1
        ].OwnerId);
    }

    //
    // Recruiting tests
    //
    
    public static testmethod void testRoutingByRecruitingAndQueueId() {
        Id queueId = newQueueId();
        
        Routing_Table__c routing = new Routing_Table__c();
        routing.RecordTypeId = RoutingAnalysis.RecordTypeRecruiting;
        routing.Country__c = RoutedToCountry;
        routing.Routed_By__c = RoutingAnalysis.RoutedByQueueId;
        routing.Routed_To__c = queueId;
        routing.Is_Active__c = true;
        routing.Country__c = RoutedToCountry;
        insert routing;
        
        Test.startTest();
        Lead lead = newLead(RoutedToName1, RoutedToCountry, RoutingAnalysis.RoutingTypeRecruiting);
        insert lead;
        Test.stopTest();
        
        system.assertEquals(queueId, [
            select OwnerId
              from Lead
             where Id = :lead.Id
             limit 1
        ].OwnerId);
    }
    
    public static testmethod void testRoutingByRecruitingAndQueueName() {
        Id queueId = newQueueId();
        
        Routing_Table__c routing = new Routing_Table__c();
        routing.RecordTypeId = RoutingAnalysis.RecordTypeRecruiting;
        routing.Matching__c = RoutedToCountry;
        routing.Routed_By__c = RoutingAnalysis.RoutedByQueueName;
        routing.Routed_To__c = 'Lead_ApplyRoutingTableTest';
        routing.Is_Active__c = true;
        routing.Country__c = RoutedToCountry;
        insert routing;
        
        Test.startTest();
        Lead lead = newLead(RoutedToName1, RoutedToCountry, RoutingAnalysis.RoutingTypeRecruiting);
        insert lead;
        Test.stopTest();
        
        system.assertEquals(queueId, [
            select OwnerId
              from Lead
             where Id = :lead.Id
             limit 1
        ].OwnerId);
    }
    
    public static testmethod void testRoutingByRecruitingAndUserId() {
        Routing_Table__c routing = new Routing_Table__c();
        routing.RecordTypeId = RoutingAnalysis.RecordTypeRecruiting;
        routing.Matching__c = RoutedToCountry;
        routing.Is_Active__c = true;
        routing.Routed_By__c = RoutingAnalysis.RoutedByUserId;
        routing.Routed_To__c = UserInfo.getUserId();
        routing.Country__c = RoutedToCountry;
        insert routing;
        
        Test.startTest();
        Lead lead = newLead(RoutedToName1, RoutedToCountry, RoutingAnalysis.RoutingTypeRecruiting);
        insert lead;
        Test.stopTest();
        
        system.assertEquals(UserInfo.getUserId(), [
            select OwnerId
              from Lead
             where Id = :lead.Id
             limit 1
        ].OwnerId);
    }
    
    public static testmethod void testRoutingByRecruitingAndUserName() {
        
        Routing_Table__c routing = new Routing_Table__c();
        routing.RecordTypeId = RoutingAnalysis.RecordTypeRecruiting;
        routing.Matching__c = RoutedToCountry;
        routing.Is_Active__c = true;
        routing.Routed_By__c = RoutingAnalysis.RoutedByUserName;
        routing.Routed_To__c = ExecutingUser.Username;
        routing.Country__c = RoutedToCountry;
        insert routing;
        
        Test.startTest();
        Lead lead = newLead(RoutedToName1, RoutedToCountry, RoutingAnalysis.RoutingTypeRecruiting);
        insert lead;
        Test.stopTest();
        
        system.assertEquals(UserInfo.getUserId(), [
            select OwnerId
              from Lead
             where Id = :lead.Id
             limit 1
        ].OwnerId);
    }
    
    */
}