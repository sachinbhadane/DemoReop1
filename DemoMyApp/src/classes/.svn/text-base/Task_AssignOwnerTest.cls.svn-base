/***************************************************************************************
Class Name      : Task_AssignOwnerTest
Author          : Mahesh Gaddam
Created Date    : March 12, 2011
Usage           : This test class is for Task_AssignOwner trigger.                
                : This trigger updates Owner on new Tasks to the owner of the contact if the 
                  task is created by s4s.apiuser@ef.com.fullqc
Revision        : 
****************************************************************************************/
@IsTest 
private class Task_AssignOwnerTest {
    public static Program__c program1 = [select Id from Program__c limit 1];
  	 static Country__c country ; 
     static testMethod void test0() {
    	User[] userList = [
            select UserRoleId 
              from User 
             where Profile.Name = 'System Administrator' 
               and UserRoleId != null 
               and IsActive = true 
             limit 3
        ]; 
        
	    country = new Country__c(Name='Test Country');
	    insert country;
        
        Account account = new Account();
        account.name = 'Testing account';
        account.ownerId = userList[0].Id;
        insert account;
        System.debug(' ::Task_AssignOwnerTest:: step 1' +account.Id); 
        
        Contact contact = new Contact();
    	contact.FirstName = 'FirstName';
        contact.Start_Term__c = 'Jan 2011';
        contact.LastName = 'LastName';
        contact.Program_Primary__c = program1.Id;
        contact.OwnerId = userList[0].Id;
        contact.AccountId = account.Id;
        contact.Country_Of_Citizenship__c = country.Id;
        contact.Country_Of_Origin__c = country.Id;
        contact.Country_Of_Residence__c = country.Id;
        insert contact;
        System.debug(' ::Task_AssignOwnerTest:: step 2' +contact.Id);
        
        Opportunity opportunity = new Opportunity();
        opportunity.Contact__c = contact.Id;
        opportunity.Name = 'OpportunityName';
        opportunity.StageName = 'StageName';
        opportunity.CloseDate = Date.today();
        opportunity.Program__c = program1.Id;
        opportunity.OwnerId = userList[0].Id;
        insert opportunity;
        System.debug(' ::Task_AssignOwnerTest:: step 3' +opportunity.Id);
        
        User[] user = [
        select Id, ProfileID 
          from User 
         where IsActive = true
           and username = 's4s.apiuser@ef.com.fullqc'
          limit 1
        ];
        
        if(!user.isEmpty())
    	 
    	{ 
        System.debug(' ::Task_AssignOwnerTest:: step 4' +user[0].id);
        
        try {
        	System.RunAs(user[0]){
        	Task[] taskList = new Task[] {
            new Task (WhoId = contact.Id, OwnerId = userList[1].Id),
            new Task (WhoId = null),
            new Task (WhoId = opportunity.Id, OwnerId = userList[1].Id)
            };
        insert taskList;
           }
         } catch (System.dmlException e) {
            System.debug ('Assigned to actual owner !!!  This is good');
        }
      }
     }  
       
      static testMethod void test1(){
      
      	User[] userList1 = [
            select UserRoleId 
              from User 
             where Profile.Name = 'System Administrator' 
               and UserRoleId != null 
               and IsActive = true 
             limit 3
        ]; 
        
        Account account1 = new Account();
        account1.name = 'Testing account';
        account1.ownerId = userList1[0].Id;
        insert account1;
        System.debug(' ::Task_AssignOwnerTest:: step 1' +account1.Id); 
        
        Contact contact1 = new Contact();
    	contact1.FirstName = 'FirstName';
        contact1.Start_Term__c = 'Jan 2011';
        contact1.LastName = 'LastName';
        contact1.Program_Primary__c = program1.Id;
        contact1.OwnerId = userList1[0].Id;
        contact1.AccountId = account1.Id;
        insert contact1;
        System.debug(' ::Task_AssignOwnerTest:: step 2' +contact1.Id);
        
        Opportunity opportunity1 = new Opportunity();
        opportunity1.Contact__c = contact1.Id;
        opportunity1.Name = 'OpportunityName';
        opportunity1.StageName = 'StageName';
        opportunity1.CloseDate = Date.today();
        opportunity1.Program__c = program1.Id;
        opportunity1.OwnerId = userList1[0].Id;
        insert opportunity1;
        System.debug(' ::Task_AssignOwnerTest:: step 3' +opportunity1.Id);
        
        if(!userList1.isEmpty()){
    	System.debug(' ::Task_AssignOwnerTest:: step 4' +userList1[0].id);
        System.RunAs(userList1[0]){
    	Task[] taskList1 = new Task[] {
        new Task (WhoId = contact1.Id, OwnerId = userList1[1].Id)
    	};
        insert taskList1;
        }
      }
  	} 
  }