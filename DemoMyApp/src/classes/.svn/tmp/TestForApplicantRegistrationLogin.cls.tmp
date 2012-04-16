// test class for ApplicantRegistrationLoginController 
@IsTest
private class TestForApplicantRegistrationLogin{
     //Test Method
    static testmethod void testCasePositive()
    {
        country__c cou = new country__c();
        cou.name='india';
        insert cou;
        program__c pro = new program__c();
        pro.name='MBA-US-Boston';
        insert pro;
        Lead lead = new lead();
        lead.Applicant_email__c ='ramandeepsinghdutt@netsutra.com';
        lead.Country_Of_Residence__c = cou.id;
        lead.LeadSource = 'Agent';
        lead.Company = 'Undecided Accounts';
        lead.Program_Primary__c = pro.id;
        lead.Status = 'open';
        lead.lastname='test';
        lead.firstname='test';
        insert lead;
 
        User u = [select Id from User where Name = 'Applicant Portal Site Guest User'];
        System.runAs(u){
            ApplicantRegistrationLoginController contr = new ApplicantRegistrationLoginController();        
            contr.fname = 'Ramandeep';
            contr.lname = 'Singh123';
            contr.email = 'ramandeepsinghdutt@netsutra.com';
            contr.password = 'password123';
            contr.confirmPassword = 'password123';
           // contr.step1();            // Commented By : Niket Chandane (To avoid too many SOQL)
            Contact c = new Contact();
            c.LastName = 'Test Contact';
            c.Email = 'ramandeepsinghdutt@netsutra.com';
            insert c;
            contr = new ApplicantRegistrationLoginController();        
            contr.oldContact = 'ramandeep.singh@netsutra.com';
            contr.fname = 'Ramandeep';
            contr.lname = 'Singh123';
            contr.email = c.Email;
            contr.password = 'password123';
            contr.confirmPassword = 'password123';
            contr.step1();
            ApplicantRegistrationLoginController.getusername(10);
                        
            ApexPages.currentPage().getParameters().put('contact', c.Id);
            //contr.getDetails();
            
            contr.password1 = 'password123';
            contr.email1 = 'ramandeepsinghdutt@netsutra.com';
            contr.login();
           // contr.updateContact(u.id);
            contr.getclist();
            contr.getStatesList();
            contr.RedirectHome();
            Contact ec = new Contact();
            ec.LastName = 'Test Contact';
            ec.Email = 'test@netsutra.com';
            insert ec;
            contr.fname = 'Ramandeep';
            contr.lname = 'Singh123';
            contr.email = ec.Email;
            contr.password = 'password123';
            contr.confirmPassword = 'password1234';
            //contr.step1();		// Commented By : Niket Chandane (To avoid too many SOQL)
            contr.updateLead('ramandeepsinghduttdd@netsutra.com');
            //contr.sendemail(u.Id);
            // contr.sendcontactmail(c.Id); // not longer works in a test env.
        }
    }
    
    static testmethod void testCaseNegative(){
        ApplicantRegistrationLoginController contr = new ApplicantRegistrationLoginController();        
        contr.fname = '';
        contr.lname = '';
        contr.email = 'raman';
        contr.password = '';
        contr.confirmPassword = '';
        contr.step1();
        User userAccount = [ Select id,userroleid from user where profile.name = 'System Administrator' and userroleid!=null and isactive=true limit 1];
        // get profile id for 'Applicant Customer Portal User'
        ID ProfileID = [ Select id from Profile where name = 'Applicant Customer Portal User'].id;
        
        // insert program
        Program__c pro=new Program__c(name='MIB-US-Boston');
        insert pro;
        
        // insert account
        Account A1 = new Account(Name = pro.name,ownerid=userAccount.id);
        insert A1;
        
        //insert country
        Country__c country = new Country__c(Name='Test Country');
        insert country;
        // insert contact for CPM user
        
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
 
        // Insert User
        User u1 = new User( email='test-user@fakeemail.com', contactid = c1.id, profileid = profileid, 
        UserName='test-user@fakeemail.com', alias='tuser1', CommunityNickName='tuser1', 
        TimeZoneSidKey='America/New_York', LocaleSidKey='en_US', EmailEncodingKey='ISO-8859-1', 
        LanguageLocaleKey='en_US', FirstName = 'Test', LastName = 'User' );
        insert u1;
        contr.insertContactOpportunity(u1.id);
    }
}