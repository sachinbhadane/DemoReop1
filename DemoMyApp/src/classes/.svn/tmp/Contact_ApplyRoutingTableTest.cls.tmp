@IsTest 
private class Contact_ApplyRoutingTableTest {
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
    
    public static Contact newContact(String postalCode, String routingType) {
        return newContact(postalCode, null, routingType);
    }
    
    public static Contact newContact(String postalCode, String countryCode, String routingType) {
        Country__c country = new Country__c();
        country.Name = countryCode;
        insert country;
        
        Contact contact = new Contact();
        contact.FirstName = 'FirstName';
        contact.LastName = 'LastName';
        contact.MailingPostalCode = postalCode;
        contact.MailingState = null;
        contact.Country_Of_Residence__c = country.Id;
        contact.Apply_Routing_Type__c = routingType;
        return contact;
    }
    
    //
    // Recruiting tests
    //
    
    	public static testmethod void testRoutingByRecruitingAndUserId() {
        Routing_Table__c routing = new Routing_Table__c();
        routing.RecordTypeId = RoutingAnalysis.RecordTypeRecruiting;
        routing.Matching__c = RoutedToCountry;
        routing.Is_Active__c = true;
        routing.Routed_By__c = RoutingAnalysis.RoutedByUserId;
        routing.Routed_To__c = UserInfo.getUserId();
        routing.Region__c = RoutedToRegion;
        insert routing;
        
        test.startTest();
        Contact contact = newContact(RoutedToName1, RoutedToCountry, RoutingAnalysis.RoutingTypeRecruiting);
        insert contact;
        Test.stopTest();
        
        system.assertEquals(UserInfo.getUserId(), [
            select OwnerId
              from Contact
             where Id = :contact.Id
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
        routing.Region__c = RoutedToRegion;
        insert routing;
        
        Test.startTest();
        Contact contact = newContact(RoutedToName1, RoutedToCountry, RoutingAnalysis.RoutingTypeRecruiting);
        insert contact;
        Test.stopTest();
        
        system.assertEquals(UserInfo.getUserId(), [
            select OwnerId
              from Contact
             where Id = :contact.Id
             limit 1
        ].OwnerId);
    }
}