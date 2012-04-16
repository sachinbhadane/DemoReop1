// test class for ApplicantRegistrationController
@IsTest
private class TestForApplicantRegistrationController {
    static User userAccount = [Select id,userroleid from user where profile.name = 'System Administrator' and UserRoleId != null and IsActive = true limit 1];
    static Id ProfileId = [Select id from Profile where name = 'Applicant Customer Portal User'].id;
    static Country__c country { get; set; }
    
    static Contact setupTestContact() {
        Program__c pro=new Program__c(name='Bachelor of International Business Administration');
        insert pro;
        
        Account A1 = new Account(Name = pro.name,ownerid=userAccount.id);
        insert A1;
        
        country = new Country__c(Name='Test Country');
        insert country;
        
        Contact contact = new Contact( AccountID = A1.id, FirstName = 'Test', LastName = 'User', email = 'test-user@fakeemail.com');
        contact.Firstname = 'Test name';
        contact.Gender__c = 'Male';
        contact.Country_Of_Citizenship__c = country.Id;
        contact.Country_Of_Origin__c = country.Id;
        contact.Country_Of_Residence__c = country.Id;
        contact.Birthdate = Date.today();
        contact.LeadSource = 'Alumni';
        contact.mailingstreet = 'test';
        contact.mailingcity = 'New York';
        contact.mailingstate = 'Test';
        contact.mailingpostalcode = '1W2E4R';
        contact.Home_Phone_Country_Code__c = '011';
        contact.Home_Phone_Area_Code__c = '292';
        contact.Home_Phone_Main_Number__c = '2153648';
        contact.Language__c = 'English';
        contact.Language_English_Speaking__c = 'Fluently';
        contact.Language_English_Listening__c = 'Fluently';
        contact.Language_English_Writing__c = 'Fluently';
        contact.Language_English_Reading__c = 'Fluently';
        insert contact;
        return contact;
    }
    
    static User setupTestAndReturnUser1() {
        Contact c1 = setupTestContact();
        
        Opportunity opp1 = new Opportunity();
        opp1.Name = 'Test Opportunity';
        opp1.Contact__c = c1.id;
        opp1.StageName ='Accepted';
        opp1.CloseDate = Date.today();
        opp1.Primary_Program_Choice__c = 'Bachelor of International Business Administration';
        opp1.Secondary_Program_Choice__c = 'Bachelor of International Business Administration';
        opp1.Primary_Campus__c = 'Boston';
        opp1.Secondary_Campus__c = 'Boston';
        opp1.Start_Term__c= 'September 2011';
        opp1.Global_Campus_Rotation_Program__c = false;
        insert opp1;
        
        User u1 = new User( email='test-user@fakeemail.com', contactid = c1.id, profileid = profileid, 
                UserName='test-user@fakeemail.com', alias='tuser1', CommunityNickName='tuser1', 
        TimeZoneSidKey='America/New_York', LocaleSidKey='en_US', EmailEncodingKey='ISO-8859-1', 
        LanguageLocaleKey='en_US', FirstName = 'Test', LastName = 'User' );
        insert u1;
        return u1;        
    } 

    static User setupTestAndReturnUser2() {
        Contact c2 = setupTestContact();
        
        Opportunity opp1 = new Opportunity();
        opp1.Name = 'Test Opportunity';
        opp1.Contact__c = c2.id;
        opp1.StageName ='Accepted';
        opp1.CloseDate = Date.today();
        opp1.Primary_Program_Choice__c = 'Bachelor of International Business Administration';
        opp1.Secondary_Program_Choice__c = 'Bachelor of International Business Administration';
        opp1.Primary_Campus__c = 'Boston';
        opp1.Secondary_Campus__c = 'Boston';
        opp1.Start_Term__c= 'September 2011';
        opp1.Global_Campus_Rotation_Program__c = false;
        insert opp1;
 
        User u2 = new User( email='test-user@fakeemail.com', contactid = c2.id, profileid = profileid, 
                UserName='test-user@fakeemail2.com', alias='tuser2', CommunityNickName='tuser2', 
        TimeZoneSidKey='America/New_York', LocaleSidKey='en_US', EmailEncodingKey='ISO-8859-1', 
        LanguageLocaleKey='en_US', FirstName = 'Test', LastName = 'User2' );
        insert u2;
        return u2;
    }
    
    //Test Method
    @IsTest
    static void testCasePositiveUser_Step3(){
        System.runAs(setupTestAndReturnUser1()){
            ApplicantRegistrationController contr = new ApplicantRegistrationController();
            //contr.oppdata(); 
            contr.Primary_Program_Choice_c = 'Bachelor of International Business Administration';
            contr.Secondary_Program_Choice_c = 'Bachelor of International Business Administration';
            contr.Primary_Campus_c = 'London';
            contr.Secondary_Campus_c = 'London';
            
            ApplicantRegistrationController.Primary_Interest_c = 'Test Interest';
            ApplicantRegistrationController.Start_Term_c= 'September 2011';
            ApplicantRegistrationController.Global_Campus_Rotation_Program_c = false;
            ApplicantRegistrationController.accountname('Bachelor of International Business Administration','Bachelor of International Business Administration','London');
            
            contr.user.contact.Lead_Source_User_Supplied__c = 'SMS';
            contr.user.contact.Mailing_Country__c = country.id;
            contr.user.contact.Language__c = 'Other';
            contr.step3();
            
            
            //contr.saveandcontinue();
            //contr.saveandcontinue1();
        }
    }
    
    @IsTest
    static void testCasePositiveUser_Step2(){
        System.runAs(setupTestAndReturnUser1()){
            ApplicantRegistrationController contr = new ApplicantRegistrationController();
            //contr.oppdata(); 
            contr.Primary_Program_Choice_c = 'Bachelor of International Business Administration';
            contr.Secondary_Program_Choice_c = 'Bachelor of International Business Administration';
            contr.Primary_Campus_c = 'London';
            contr.Secondary_Campus_c = 'London';
            
            ApplicantRegistrationController.Primary_Interest_c = 'Test Interest';
            ApplicantRegistrationController.Start_Term_c= 'September 2011';
            ApplicantRegistrationController.Global_Campus_Rotation_Program_c = false;
            ApplicantRegistrationController.accountname('Bachelor of International Business Administration','Bachelor of International Business Administration','London');
            
            contr.user.contact.Lead_Source_User_Supplied__c = 'SMS';
            contr.user.contact.Mailing_Country__c = country.id;
            contr.user.contact.Language__c = 'Other';
            contr.getfcampusModule();
            contr.getcountryCode();
           // contr.step2();
            
            
            //contr.saveandcontinue();
            //contr.saveandcontinue1();
        }
    }

    @IsTest
    static void testCasePositiveUser_Step2AndLogout(){
        System.runAs(setupTestAndReturnUser1()){
            ApplicantRegistrationController contr = new ApplicantRegistrationController();
            //contr.oppdata(); 
            contr.Primary_Program_Choice_c = 'Bachelor of International Business Administration';
            contr.Secondary_Program_Choice_c = 'Bachelor of International Business Administration';
            contr.Primary_Campus_c = 'London';
            contr.Secondary_Campus_c = 'London';
            
            ApplicantRegistrationController.Primary_Interest_c = 'Test Interest';
            ApplicantRegistrationController.Start_Term_c= 'September 2011';
            ApplicantRegistrationController.Global_Campus_Rotation_Program_c = false;
            ApplicantRegistrationController.accountname('Bachelor of International Business Administration','Bachelor of International Business Administration','London');
            
            contr.user.contact.Lead_Source_User_Supplied__c = 'SMS';
            contr.user.contact.Mailing_Country__c = country.id;
            contr.user.contact.Language__c = 'Other';
            contr.getfcampusModule();
            contr.getcountryCode();
           // contr.step2andlogout();
        }
    }
    @IsTest
    static void testCasePositiveUser2() {
        System.runAs(setupTestAndReturnUser2()) {
            ApplicantRegistrationController contr = new ApplicantRegistrationController();
            ApplicantRegistrationController.Primary_Interest_c = 'Test Interest';
            
            contr.oppdata(); 
            
            contr.step3();
           
            contr.step2(); 
            contr.getMasterProlist();
            contr.MasterProlist1();
            contr.getMasterProlistSec();
            contr.getsellist();
            contr.getprimaryProlist();
            contr.gettitleitems();
            contr.getyesno();
            contr.getinterestitems();
            contr.getdlist();
            contr.getfcampusSec();
            contr.getfcampus();
            contr.getintcampue();
            contr.getnum();
            contr.getstartterm();
            contr.getintlist();
            contr.getclist();
            contr.getplist();
            contr.getItems();
            contr.getCreatedUser();
            contr.step3andlogout();
        }
    }

    static void testCasePositiveUser_ProgramTests(String program1, String program2, String masters1, String masters2) {
        System.runAs(setupTestAndReturnUser2()) {
            ApplicantRegistrationController contr = new ApplicantRegistrationController();
            ApplicantRegistrationController.Primary_Interest_c = 'Test Interest';
            contr.Primary_Program_Choice_c = program1;
            contr.Secondary_Program_Choice_c = program2;
            contr.Masters_Program_Choice_c = masters1;
            contr.Secondary_Masters_Program_Choice_c = masters2;
            
            contr.getfcampusSec();
            contr.getfcampus();
            contr.getMasterProlist();
            contr.getMasterProlistSec();
            contr.saveandcontinue();
        }
    }
    
    @IsTest 
    static void testCasePositiveUser_ProgramTests1() {
        testCasePositiveUser_ProgramTests('Undergraduate Program', 'Undergraduate Program', null, null);
    }
    
    @IsTest 
    static void testCasePositiveUser_ProgramTests2() {
        testCasePositiveUser_ProgramTests('Executive MBA', 'Executive MBA', null, null);
    }
    
    @IsTest 
    static void testCasePositiveUser_ProgramTests3() {
        testCasePositiveUser_ProgramTests('Master\'s Program', 'Master\'s Program', 'Master of Finance', 'Master of Finance');
    }
    
    @IsTest 
    static void testCasePositiveUser_ProgramTests4() {
        testCasePositiveUser_ProgramTests('Master of Digital Marketing', 'Master\'s Program', 'Master of Digital Marketing', 'Master of Digital Marketing');
    }
    
    @IsTest 
    static void testCasePositiveUser_ProgramTests5() {
        testCasePositiveUser_ProgramTests('Master of Social Entrepreneurship', 'Master\'s Program', 'Master of Social Entrepreneurship', 'Master of Social Entrepreneurship');
    }
    
    @IsTest 
    static void testCasePositiveUser_ProgramTests6() {
        testCasePositiveUser_ProgramTests('Master\'s Program', null, null, null);
    }
    
    @IsTest 
    static void testCasePositiveUser_ProgramTests7() {
        testCasePositiveUser_ProgramTests(null, 'Master\'s Program', null, null);
    }
}