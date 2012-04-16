@IsTest
private class Opportunity_UpdateContactRolesTest {
    public static testmethod void test() {
        Opportunity opportunity = [select AccountId from Opportunity limit 1];
        
        Contact contact = new Contact();
        contact.AccountId = opportunity.AccountId;
        contact.LastName = 'LastName';
        contact.Email = 'email@example.com';
        insert contact;
        
        system.assert(contact.Id != [
            select Contact__c
              from Opportunity
             where Id = :opportunity.Id
             limit 1
        ].Contact__c);
        
        system.assertEquals(0, [
            select count()
              from OpportunityContactRole
             where OpportunityId = :opportunity.Id
               and ContactId = :contact.Id
        ]);
        
        opportunity.Contact__c = contact.Id;
        update opportunity;
        
        system.assert(contact.Id == [
            select Contact__c
              from Opportunity
             where Id = :opportunity.Id
             limit 1
        ].Contact__c);
        
        system.assertEquals(1, [
            select count()
              from OpportunityContactRole
             where OpportunityId = :opportunity.Id
               and ContactId = :contact.Id
        ]);
    }
}