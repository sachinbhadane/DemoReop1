/***************************************************************************************
Class Name      : Contact_syncProgramTest
Author          : Mahesh Gaddam
Created Date    : November 27, 2011
Usage           : This is test class for Contact_syncProgram trigger is for Opportunity_syncProgram trigger which updates Start_Term__c field                
                : on Contact when the Start_Term__c is updated on Opportunity.    
Revision History: 
****************************************************************************************/
@IsTest 
private class Contact_syncProgramTest {
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
        
        system.assertEquals(contact.Program_Primary__c, [
            select Program__c
              from Opportunity
             where Id = :opportunity.Id
             limit 1
        ].Program__c);
        
        // Set to synchronous mode
        Setting_Disabled__c setting = Setting_Disabled__c.getInstance();
        setting.Contact_syncProgram__c = false; // ensures the relevant code runs
        setting.Contact_syncProgramServicer__c = true; // ensures the async mode is disabled
        upsert setting;
        
        Test.startTest();
        contact.Program_Primary__c = program2.Id;
        update contact;
        Test.stopTest();
        
        system.assertEquals(contact.Program_Primary__c, [
            select Program__c
              from Opportunity
             where Id = :opportunity.Id
             limit 1
        ].Program__c);
    }
}