// test class for ApplicantReferenceController
@IsTest
private class TestForApplicantReferenceController {
    // Create Test Method  
   static testMethod void testPositiveRefrence() 
    { 
      User admin = [SELECT Id, UserRoleID FROM user where profile.Name = 'System Administrator' and userroleid!=null and isactive=true limit 1];
      Account A1 = new Account(Name = 'Test Account', OwnerId = admin.Id);
      insert A1;
       ID ProfileID = [ Select id from Profile where name = 'Applicant Customer Portal User'].id;
         
        
        Country__c country = new Country__c(Name='Test Country');
        insert country;
        List<Contact> ContactList = new List<Contact>();
        Contact C1 = new Contact( AccountID = A1.id, FirstName = 'Test', LastName = 'User', 
        email = 'test-user@fakeemail.com' );
        c1.Firstname = 'Test name';
        c1.Gender__c = 'Male';
        c1.Country_Of_Citizenship__c = country.Id;
        c1.Country_Of_Origin__c = country.Id;
        c1.Country_Of_Residence__c = country.Id;
        c1.Birthdate = Date.today();
        c1.LeadSource = 'Alumni';
        c1.mailingstreet = 'test';
        c1.mailingcity = 'New York';
        c1.mailingstate = 'Test';
        c1.mailingpostalcode = '1W2E4R';
        c1.Home_Phone_Country_Code__c = '011';
        c1.Home_Phone_Area_Code__c = '292';
        c1.Home_Phone_Main_Number__c = '2153648';
        c1.Language__c = 'English';
        c1.Language_English_Speaking__c = 'Fluently';
        c1.Language_English_Listening__c = 'Fluently';
        c1.Language_English_Writing__c = 'Fluently';
        c1.Language_English_Reading__c = 'Fluently';
        insert C1;
 
        User u1 = new User( email='test-user@fakeemail.com', contactid = c1.id, profileid = profileid, 
                UserName='test-user@fakeemail.com', alias='tuser1', CommunityNickName='tuser1', 
        TimeZoneSidKey='America/New_York', LocaleSidKey='en_US', EmailEncodingKey='ISO-8859-1', 
        LanguageLocaleKey='en_US', FirstName = 'Test', LastName = 'User' );
        insert u1;
       // User currentUser = [select id,contact.id, title, firstname, lastname, email FROM User WHERE Profile.Name  = 'Applicant Customer Portal User' and IsActive  = true limit 1];      
        User currentUser = [select id,contact.id, title, firstname, lastname, email FROM User WHERE id=:u1.id ];      
        Program__c pro = new Program__c(
        name='MIM-US-San Franscisco'
        );        
        insert pro;
        Opportunity opp1 = new Opportunity();
      
        
            opp1.Name = 'Test Opportunity';
            opp1.Primary_Program_Choice__c=pro.id;
            opp1.Contact__c = currentUser.Contact.Id;
            opp1.StageName ='Accepted';
            opp1.CloseDate = Date.today();
            //opp1.Program__c=pro.id;
            insert opp1; 
            
            Requirement__c req0=new Requirement__c();
            req0.Name = 'Professional Recommentations';
            insert req0;
           RecordType recid=[select id from recordtype where name='Recommendation' and sobjecttype='Requirement__c'];
            Requirement__c req1=new Requirement__c();
            //req1.contact__c=currentUser.contact.id;
            req1.recordtypeid=recid.id;
            req1.Opportunity__c = opp1.Id;
            req1.Name = 'Professional Recommentation (1 of 2)';
            req1.Parent__c = req0.Id;
            insert req1;
            
            Requirement__c req2=new Requirement__c();
            //req1.contact__c=currentUser.contact.id;
            req2.recordtypeid=recid.id;
            req2.Opportunity__c = opp1.Id;
            req2.Name = 'Professional Recommentation (2 of 2)';
            req2.Parent__c = req0.Id;
            insert req2; 
       
        System.runAs(currentUser) 
        {
            
            
            ApplicantReferenceController controller = new ApplicantReferenceController();
            controller.forname1='test1';
            controller.forname2='test2';
            controller.surname1='tets';
            controller.surname2='test';
            controller.comname1='test';
            controller.comname2='test';
            controller.email1='test@test.com';
            controller.email2='test@test.com';
            controller.cemail1='test@test.com';
            controller.cemail2='test@test.com';
            controller.saveandcontinue(); 
            System.currentPagereference().getParameters().put('mailrefID',req1.id);  
            controller.emailSend();
            controller.saveandcontinueandlogout();   

        }  

     } 
     static testMethod void testNegativeRefrence() 
    {  
      
    
    User userAccount = [ Select id,userroleid from user where profile.name = 'System Administrator' and userroleid!=null and isactive=true limit 1];
    
        ID ProfileID = [ Select id from Profile where name = 'Applicant Customer Portal User'].id;
        Account A1 = new Account(Name = 'Test Account',ownerid=userAccount.id);
        insert A1;
        
        Country__c country = new Country__c(Name='Test Country');
        insert country;
        List<Contact> ContactList = new List<Contact>();
        Contact C1 = new Contact( AccountID = A1.id, FirstName = 'Test', LastName = 'User', 
        email = 'test-user@fakeemail.com' );
        c1.Firstname = 'Test name';
        c1.Gender__c = 'Male';
        c1.Country_Of_Citizenship__c = country.Id;
        c1.Country_Of_Origin__c = country.Id;
        c1.Country_Of_Residence__c = country.Id;
        c1.Birthdate = Date.today();
        c1.LeadSource = 'Alumni';
        c1.mailingstreet = 'test';
        c1.mailingcity = 'New York';
        c1.mailingstate = 'Test';
        c1.mailingpostalcode = '1W2E4R';
        c1.Home_Phone_Country_Code__c = '011';
        c1.Home_Phone_Area_Code__c = '292';
        c1.Home_Phone_Main_Number__c = '2153648';
        c1.Language__c = 'English';
        c1.Language_English_Speaking__c = 'Fluently';
        c1.Language_English_Listening__c = 'Fluently';
        c1.Language_English_Writing__c = 'Fluently';
        c1.Language_English_Reading__c = 'Fluently';
        insert C1;
 
        User u1 = new User( email='test-user@fakeemail.com', contactid = c1.id, profileid = profileid, 
        UserName='test-user@fakeemail.com', alias='tuser1', CommunityNickName='tuser1', 
        TimeZoneSidKey='America/New_York', LocaleSidKey='en_US', EmailEncodingKey='ISO-8859-1', 
        LanguageLocaleKey='en_US', FirstName = 'Test', LastName = 'User' );
        insert u1;
       // User currentUser = [select id,contact.id, title, firstname, lastname, email FROM User WHERE Profile.Name  = 'Applicant Customer Portal User' and IsActive  = true limit 1];      
        User currentUser = [select id,contact.id, title, firstname, lastname, email FROM User WHERE id=:u1.id ];      
        Program__c pro = new Program__c(
        name='MIM-US-San Franscisco'
        );        
        insert pro;
        Opportunity opp1 = new Opportunity();
       
        
            opp1.Name = 'Test Opportunity';
            opp1.Primary_Program_Choice__c=pro.id;
            opp1.Contact__c = currentUser.Contact.Id;
            opp1.StageName ='Accepted';
            opp1.CloseDate = Date.today();
            //opp1.Program__c=pro.id;
            insert opp1; 
            
            Requirement__c req0=new Requirement__c();
            req0.Name = 'Professional Recommentations';
            insert req0;
           
            RecordType recid=[select id from recordtype where name='Recommendation' and sobjecttype='Requirement__c'];
            Requirement__c req1=new Requirement__c();
            //req1.contact__c=currentUser.contact.id;
            req1.recordtypeid=recid.id;
            req1.Opportunity__c = opp1.Id;
            req1.Name = 'Professional Recommentation (1 of 2)';
            req1.Recommendation_Background__c ='dd';
            req1.Parent__c = req0.Id;
            insert req1;
            
             Requirement__c req2=new Requirement__c();
            //req1.contact__c=currentUser.contact.id;
            req1.recordtypeid=recid.id;
            req2.Opportunity__c = opp1.Id;
            req2.Name = 'Professional Recommentation (2 of 2)';
            req2.Parent__c = req0.Id;
            req2.Recommendation_Background__c ='dd';
            insert req2;
       
        System.runAs(currentUser) 
        {
            
            
            ApplicantReferenceController controller = new ApplicantReferenceController();
           
            controller.forname1='';
            controller.forname2='';
            controller.surname1='';
            controller.surname2='';
            controller.comname1='';
            controller.comname2='';
            controller.email1='';
            controller.email2='';
            controller.cemail1='';
            controller.cemail2='';
            controller.saveandcontinue();   
            System.currentPagereference().getParameters().put('id',req1.id);
            controller.sendemailfromAdmin();
            controller.isBack();

        }  

     } 
}