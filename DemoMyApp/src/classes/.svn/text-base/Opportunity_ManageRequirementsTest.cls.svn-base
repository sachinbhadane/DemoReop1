@IsTest
private class Opportunity_ManageRequirementsTest {
    @IsTest
    public static void test() {
        //get a user with System Administrator profile and with any role
        User userAccount = [
            select UserRoleId 
              from User 
             where Profile.Name = 'System Administrator' 
               and UserRoleId != null 
               and IsActive = true 
             limit 1
        ]; 
        
        
        Id profileId = [
            select Id 
              from Profile 
             where Name = 'Applicant Customer Portal User'
             limit 1
        ].Id;
        
        // insert program
        Program__c program = new Program__c();
        program.Name = 'MBA-China-Shanghai_TEST';
        insert program;
        
        // insert account
        Account account = new Account();
        account.Name = program.Name;
        account.OwnerId = userAccount.Id;
        insert account;
        
        //insert country
        Country__c country = new Country__c();
        country.Name = 'Test Country';
        insert country;
        
        // insert contact for CPM user
        Contact contact = new Contact();
        contact.AccountId = account.Id;
        contact.FirstName = 'Test';
        contact.LastName = 'User';
        contact.Email = 'test-user@fakeemail.com';
        insert contact;
        
        Opportunity opportunity = new Opportunity();
        opportunity.AccountId = account.Id;
        opportunity.Name = 'Test Opportunity';
        opportunity.Contact__c = contact.Id;
        opportunity.StageName = 'Accepted';
        opportunity.CloseDate = Date.today();
        opportunity.Program__c = program.id;
        insert opportunity;
        
        Requirement__c requirement = new Requirement__c();
        requirement.Opportunity__c = opportunity.Id;
        requirement.Contact__c = contact.Id;
        requirement.Waived__c = true;
        requirement.Verified__c = true;
        requirement.Unlocked__c = true;
        requirement.Supplied__c= true;
        requirement.Required_For__c = 'Enrolled';
        requirement.Name = 'Undergraduate Transcript';
        requirement.Approved__c = true;
        insert requirement;
         
        Attachment attachment = new Attachment();
        attachment.Name = 'Content';
        attachment.ContentType = 'text/plain';
        attachment.Body = Blob.valueOf('Content');
        attachment.ParentId = requirement.Id;
        insert attachment;
        
        User user = new User();
        user.Email = 'test-user@fakeemail.com';
        user.ContactId = contact.Id;
        user.Profileid = ProfileId;
        user.UserName = 'test-user@fakeemail.com';
        user.Alias = 'tuser1';
        user.CommunityNickName = 'tuser1';
        user.TimeZoneSidKey = 'America/New_York';
        user.LocaleSidKey = 'en_US';
        user.EmailEncodingKey = 'ISO-8859-1'; 
        user.LanguageLocaleKey = 'en_US';
        user.FirstName = 'Test';
        user.LastName = 'User';
        insert user;
        
        // get current user
        User currentUser = [
            select ContactId
                 , Title
                 , FirstName
                 , LastName
                 , Email 
              from User 
             where Id = :user.id
             limit 1
        ];
        
        //Create an instance of the standard controller
        ApexPages.currentPage().getParameters().put('id', opportunity.Id);
        
        Opportunity_ManageRequirements controller = new Opportunity_ManageRequirements(new ApexPages.StandardController(opportunity));
        controller.initialize();
        
        // do asserts and test and whatever needs to be tested
        Requirement__c selectedRequirement = new Map<Id, Requirement__c>(controller.requirementList).get(requirement.Id);
        
        system.assert(null != selectedRequirement, 'Controller class did not select all the desired requirements: ' + controller.requirementList);
        
        selectedRequirement.Waived__c = false;
        selectedRequirement.Verified__c = true;
        selectedRequirement.Supplied__c = false;
        
        controller.save();
        controller.saveandreturn();
        
        Requirement__c validateRequirement = [
            select Waived__c
                 , Verified__c
                 , Supplied__c
              from Requirement__c
             where Id = :requirement.Id
             limit 1
        ];
        
        system.assertEquals(selectedRequirement.Waived__c, validateRequirement.Waived__c);
        system.assertEquals(selectedRequirement.Verified__c, validateRequirement.Verified__c);
        system.assertEquals(selectedRequirement.Supplied__c, validateRequirement.Supplied__c);
       
        controller.cancel();
    }
}