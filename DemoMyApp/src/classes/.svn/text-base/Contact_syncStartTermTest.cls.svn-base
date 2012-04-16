/***************************************************************************************
Class Name      : Contact_syncStartTermTest
Author          : Mahesh Gaddam
Created Date    : November 27, 2011
Usage           : This is test class for Contact_syncStartTerm trigger is for Opportunity_syncStartTerm trigger which updates Start_Term__c field                
                : on Contact when the Start_Term__c is updated on Opportunity.    
Revision History: 
****************************************************************************************/
@IsTest 
private class Contact_syncStartTermTest {
    static testmethod void test() {
        Contact contact = new Contact();
        contact.FirstName = 'FirstName';
        contact.Start_Term__c = 'Jan 2011';
        contact.LastName = 'LastName';
        insert contact;
        
        Opportunity opportunity = new Opportunity();
        opportunity.Contact__c = contact.Id;
        opportunity.Name = 'OpportunityName';
        opportunity.StageName = 'StageName';
        opportunity.CloseDate = Date.today();
        insert opportunity;
        
        system.assertEquals(null, [
            select Start_Term__c
              from Opportunity
             where Id = :opportunity.Id
             limit 1
        ].Start_Term__c);
        
        // Set to synchronous mode
        Setting_Disabled__c setting = Setting_Disabled__c.getInstance();
        setting.Contact_syncStartTerm__c = false; // ensures the relevant code runs
        setting.Contact_syncStartTermServicer__c = true; // ensures the async mode is disabled
        upsert setting;
        
        Test.startTest();
        contact.Start_Term__c = 'Sep 2012';
        update contact;
        Test.stopTest();
        
        system.assertEquals(contact.Start_Term__c, [
            select Start_Term__c
              from Opportunity
             where Id = :opportunity.Id
             limit 1
        ].Start_Term__c);
    }
}