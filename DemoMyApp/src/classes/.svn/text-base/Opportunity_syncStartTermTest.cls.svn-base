/***************************************************************************************
Class Name      : Opportunity_syncStartTermTest
Author          : Mahesh Gaddam
Created Date    : November 27, 2011
Usage           : This is test class for Opportunity_syncStartTerm trigger which updates Program__c field
                : on Contact when the Program__c is updated on Opportunity.
Revision History: 
****************************************************************************************/
@IsTest 
private class Opportunity_syncStartTermTest {
    public static final Program__c program1 = [select Id from Program__c limit 1]; 
    public static final Program__c program2 = [select Id from Program__c where Id != :program1.Id limit 1]; 
    
    @IsTest
    public static void test() {
        Contact contact = new Contact();
        contact.FirstName = 'FirstName';
        contact.Start_Term__c = 'Jan 2011';
        contact.LastName = 'LastName';
        contact.Program_Primary__c = program1.Id;
        insert contact;
        
        Opportunity opportunity = new Opportunity();
        opportunity.Contact__c = contact.Id;
        opportunity.Name = 'OpportunityName';
        opportunity.Start_Term__c = 'Jan 2011';
        opportunity.StageName = 'StageName';
        opportunity.CloseDate = Date.today();
        opportunity.Program__c = program1.Id;
        insert opportunity;
        
        system.assertEquals(opportunity.Start_Term__c, [
            select Start_Term__c
              from Contact
             where Id = :contact.Id
             limit 1
        ].Start_Term__c);
        
        // Set to synchronous mode
        Setting_Disabled__c setting = Setting_Disabled__c.getInstance();
        setting.Opportunity_syncStartTerm__c = false; // ensures the relevant code runs
        setting.Opportunity_syncStartTermServicer__c = true; // ensures the async mode is disabled
        update setting;
        
        Test.startTest();
        opportunity.Start_Term__c = 'Mar 2012';
        update opportunity;
        Test.stopTest();
        
        system.assertEquals(opportunity.Start_Term__c, [
            select Start_Term__c
              from Contact
             where Id = :contact.Id
             limit 1
        ].Start_Term__c);
    }
}