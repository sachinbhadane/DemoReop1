/***************************************************************************************
Class Name      : Opportunity_syncProgramTest
Author          : Mahesh Gaddam; Ian Zepp
Created Date    : November 27, 2011
Usage           : This is test class for Opportunity_syncProgram trigger which updates Program__c field
                : on Contact when the Program__c is updated on Opportunity.
Revision History: 
****************************************************************************************/
@IsTest 
private class Opportunity_syncProgramTest {
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
        opportunity.StageName = 'StageName';
        opportunity.CloseDate = Date.today();
        opportunity.Program__c = program1.Id;
        insert opportunity;
        
        system.assertEquals(opportunity.Program__c, [
            select Program_Primary__c
              from Contact
             where Id = :contact.Id
             limit 1
        ].Program_Primary__c);
        
        // Set to synchronous mode
        Setting_Disabled__c setting = Setting_Disabled__c.getInstance();
        setting.Opportunity_syncProgram__c = false; // ensures the relevant code runs
        setting.Opportunity_syncProgramServicer__c = true; // ensures the async mode is disabled
        upsert setting;
        
        Test.startTest();
        opportunity.Program__c = program2.Id;
        update opportunity;
        Test.stopTest();
        
        system.assertEquals(opportunity.Program__c, [
            select Program_Primary__c
              from Contact
             where Id = :contact.Id
             limit 1
        ].Program_Primary__c);
    }
}