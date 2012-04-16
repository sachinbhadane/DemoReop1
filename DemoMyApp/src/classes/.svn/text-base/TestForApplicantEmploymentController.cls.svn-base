// test class for ApplicantEmploymentController
@IsTest
private class TestForApplicantEmploymentController {
// Test Methods for posative case
     
     static testMethod void testPosativeEmployment() 
    {  
        // Select a user id with System Administrator profile and any role 
        User userAccount = [ Select id,userroleid from user where profile.name = 'System Administrator' and userroleid!=null and isactive=true limit 1];
        // Select profile id for Applicant Customer Portal User
        ID ProfileID = [ Select id from Profile where name = 'Applicant Customer Portal User'].id;
        // insert a program
        Program__c pro=new Program__c(name='MIB-US-Boston');
        insert pro;
        // create a account with userAccount id
        Account A1 = new Account(Name = pro.name,ownerid=userAccount.id);
        insert A1;
        // insert a country
        Country__c country = new Country__c(Name='Test Country');
        insert country;
       // Create a contect for CPM User
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
        // create a CPM user
        User u1 = new User( email='test-user@fakeemail.com', contactid = c1.id, profileid = profileid, 
                UserName='test-user@fakeemail.com', alias='tuser1', CommunityNickName='tuser1', 
        TimeZoneSidKey='America/New_York', LocaleSidKey='en_US', EmailEncodingKey='ISO-8859-1', 
        LanguageLocaleKey='en_US', FirstName = 'Test', LastName = 'User' );
        insert u1;
       // Select current user
        User currentUser = [select id,contact.id, title, firstname, lastname, email FROM User WHERE id=:u1.id ];      
        // Create a oppurtunity
        Opportunity opp1 = new Opportunity();
            opp1.Name = 'Test Opportunity';
            opp1.Contact__c = currentUser.Contact.Id;
            opp1.StageName ='Accepted';
            opp1.CloseDate = Date.today();
            opp1.Employment_Tab_Complete__c=false;
            insert opp1;
        // Run test for Portal user 
        System.runAs(currentUser) 
        {
                 //RecordType recid=[select id from recordtype where name='Employment' and sobjectType='History__c'];
                 ApplicantEmploymentController controller = new ApplicantEmploymentController();
                // Employment__c hist1=new Employment__c();
                 controller.hist1.contact__c=currentUser.contact.id;
                 //hist1.recordtypeid=recid.id;
                 controller.hist1.Name__c='test';
                 controller.empyear='2010';
                 controller.empmonth='5';
                 controller.hist1.City__c = 'New Delhi';
                 controller.hist1.Address__c = 'New Delhi';
                 controller.hist1.Country__c = country.id;
                 controller.hist1.ZipCode__c = '1w1e3r';
                 controller.hist1.EmploymentType__c  = 'Full-Time';
                 controller.hist1.Position__c  = 'test';
                 controller.hist1.Annual_Salary_In_USD__c = 12345;
                 controller.hist1.ResponsibilitesOfJob__c = 'test job';
                 controller.hist1.Company_Size__c = '201-400';
                 controller.DateFrom_month = '02';
                 controller.DateFrom_year = '2000';
                 controller.DateTo_month = '2';
                 controller.DateTo_year = '2001';
                 
                 controller.hist1.Industry_Sector__c = 'Agriculture';
                 //insert hist1;
                 
                 system.assert(controller.saveandcontinue()!=null);
                 system.assert(controller.getclist()!=null);
                 Opportunity op=[select id,Employment_Tab_Complete__c from opportunity where id=:opp1.id];
                 system.assert(op.Employment_Tab_Complete__c==true);
                 
                 System.currentPagereference().getParameters().put('id',controller.hist1.id);
                 controller.edit();
                 controller.isDelete();
                 controller.cancel();
                 controller.saveandsave();
                 controller.saveandlogout();
                 controller.saveandedit();
                 
        }  
     }
 
}