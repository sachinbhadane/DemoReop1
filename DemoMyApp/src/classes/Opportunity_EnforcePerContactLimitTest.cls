@IsTest
private class Opportunity_EnforcePerContactLimitTest {
    public static testmethod void test() {
        Account account = new Account();
        account.Name = 'Opportunity_EnforcePerContactLimitTest';
        insert account;
        
        Contact contact = new Contact();
        contact.FirstName = 'FirstName';
        contact.LastName = 'LastName';
        contact.AccountId = account.Id;
        insert contact;
        
        Program__c program = new Program__c();
        program.Name = 'Opportunity_EnforcePerContactLimitTest';
        insert program;
        
        // Expected ok
        Opportunity opportunity = new Opportunity();
        opportunity.Name = 'Opportunity_EnforcePerContactLimitTest';
        opportunity.AccountId = account.Id;
        opportunity.StageName = 'StageName';
        opportunity.CloseDate = Date.today();
        opportunity.Program__c = program.Id;
        opportunity.Contact__c = contact.Id;
        insert opportunity;
        
        // Expected failure
        try {
            opportunity = opportunity.clone(false, false);
            insert opportunity;
            system.assert(false, 'Test failed.');
        } catch (System.DmlException pException) {
            system.assert(pException.getMessage().contains('There is already an application linked to this contact.'), 'Test Failed');
        }
    }
}