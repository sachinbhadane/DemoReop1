@IsTest
private class Opportunity_DeleteRequirementsTest {
    public static testmethod void test() {
        // Find a department requirement
        Requirement__c requirement = [
            select Department__c
              from Requirement__c
             where Department__c != null
             limit 1
        ];
        
        // Find a program in that department
        Program__c program = [
            select Id
              from Program__c
             where Department__c = :requirement.Department__c
             limit 1
        ];
        
        Account account = new Account();
        account.Name = 'Account';
        insert account;
        
        Opportunity opportunity = new Opportunity();
        opportunity.AccountId = account.Id;
        opportunity.Name = 'Opportunity';
        opportunity.CloseDate = Date.today();
        opportunity.StageName = 'StageName';
        opportunity.Program__c = program.Id;
        insert opportunity;
        
        // Save to later
        String opportunityId = opportunity.Id;
        
        // should be requirements now
        system.assert(0 != [
            select count()
              from Requirement__c
             where Opportunity__c = :opportunityId
        ], 'Failed to find any mapped requirements for the new opp. Expected at least one...');
        
        // delete and re-test
        delete opportunity;
        
        system.assert(0 == [
            select count()
              from Requirement__c
             where Opportunity__c = :opportunityId
        ], 'Opp requirements were not deleted as expected.');
    }
}