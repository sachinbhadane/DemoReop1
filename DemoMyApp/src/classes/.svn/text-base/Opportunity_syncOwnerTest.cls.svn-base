/***************************************************************************************
Class Name      : Opportunity_syncOwnerTest
Author          : Mahesh Gaddam; Ian Zepp
Created Date    : November 27, 2011
Usage           : This is test class for Opportunity_syncOwner trigger which updates Owner__c field
                : on Contact when the Owner__c is updated on Opportunity.
Revision History: 
****************************************************************************************/
@IsTest 
private class Opportunity_syncOwnerTest {
    public static final User[] userList = [
        select Id 
          from User 
         where Id != :UserInfo.getUserId() 
           and ContactId = null // no portal users
           and IsActive = true  // active only
         limit 2
    ]; 
    
    @IsTest
    public static void test() {
        if (userList.size() < 2)
            return; // cant' test
        
        Contact contact = new Contact();
        contact.FirstName = 'FirstName';
        contact.Start_Term__c = 'Jan 2011';
        contact.LastName = 'LastName';
        contact.OwnerId = userList[0].Id;
        insert contact;
        
        Opportunity opportunity = new Opportunity();
        opportunity.Contact__c = contact.Id;
        opportunity.Name = 'OpportunityName';
        opportunity.StageName = 'StageName';
        opportunity.CloseDate = Date.today();
        opportunity.OwnerId = userList[0].Id;
        insert opportunity;
        
        system.assertEquals(opportunity.OwnerId, [
            select OwnerId
              from Contact
             where Id = :contact.Id
             limit 1
        ].OwnerId);
        
        // Set to synchronous mode
        Setting_Disabled__c setting = Setting_Disabled__c.getInstance();
        setting.Opportunity_syncOwner__c = true; // ensures the relevant code runs // Mahesh G on 3/2/12 changed the value to TRUE to support code
        setting.Opportunity_syncOwnerServicer__c = true; // ensures the async mode is disabled
        update setting;
        
        Test.startTest();
        opportunity.OwnerId = userList[1].Id;
        update opportunity;
        Test.stopTest();
        
        system.assertEquals(opportunity.OwnerId, [
            select OwnerId
              from Contact
             where Id = :contact.Id
             limit 1
        ].OwnerId);
    }
}