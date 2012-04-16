// test class for ApplicantEducationController
@IsTest
private class TestForApplicantEducationController {
static testMethod void testPosativeEducation() 
    {  
        //get a user with System Administrator profile and with any role
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
       
       // get current user
        User currentUser = [select id,contact.id, title, firstname, lastname, email FROM User WHERE id=:u1.id ];      
        
           // insert opportunity
           Opportunity opp = new Opportunity();
            opp.Name = 'Test Opportunity';
            opp.Contact__c = currentUser.Contact.Id;
            opp.StageName ='Accepted';
            opp.CloseDate = Date.today();
            opp.Program__c=pro.id;
            opp.Education_Tab_Complete__c=false;
            insert opp;
            Education__c edu = new Education__c(
            Undergraduate_School_Attended__c='test',
            GraduateDateFrom__c=date.today(),
            GraduateDateTo__c=date.today(),
            application__c=opp.id,
            DegreeDateFrom__c=date.today(),
            DegreeDateTo__c=date.today(),
            Date_Graduated__c=date.today());
            insert edu;

        System.runAs(currentUser) 
        {
            
            
           
            ApplicantEducationController controller = new ApplicantEducationController();
                 controller.Undergraduate.Undergraduate_School_Attended__c='2010';
                 controller.GraduateDateFrom_year='2000';
                 controller.GraduateDateFrom_month='1';
                 controller.GraduateDateFrom_day='1';
                 controller.Undergraduate.EducationSpeciality__c = 'New Delhi';
                 controller.GraduateDateTo_year = '2000';
                 controller.GraduateDateTo_month = '1';
                 controller.GraduateDateTo_day = '1';
                 controller.Undergraduate.Highest_Degree_Attained__c = 'Doctoral Degree';
                 controller.Undergraduate.School_attended_for_Highest_Degree__c = 'Doctoral Degree';
                 controller.DegreeDateFrom_year  = '2000';
                 controller.DegreeDateFrom_month  = '1';
                 controller.DegreeDateFrom_day  = '1';
                 controller.Undergraduate.EducationSpeciality__c  = 'test';
                 controller.DegreeDateTo_year = '2000';
                 controller.DegreeDateTo_month = '1';
                 controller.DegreeDateTo_day = '1';
                 controller.Undergraduate.DegreeSpeciality__c='test';
                 controller.Date_Graduated_year='2000';
                 controller.Date_Graduated_month='2';
                 controller.Date_Graduated_day='2';                 
                 controller.saveUndergraduate();
                 controller.saveandcontinue();
                 controller.is_Cancel();
                 controller.getUndergraduate();
            controller.getItems();
            controller.geteList();
            Education__c edu1=new Education__c(
            GraduateDateTo__c=date.today(),
            GraduateDateFrom__c=date.today()
            );
            insert edu1;
            System.currentPagereference().getParameters().put('id',edu1.id);
            controller.edit();
            controller.is_delete();
            // Check for Education_Tab_Complete__c flag
            opportunity oppCheck = [select Education_Tab_Complete__c from opportunity where id=:opp.id];
            system.assert(oppcheck.Education_Tab_Complete__c==true);
            
            // Check insert history
           // Education__c his=[select id from Education__c where EducationSpeciality__c=:controller.hist.EducationSpeciality__c limit 1 ];
           // system.assert(his.id==controller.hist.id);
            controller.saveandcontinueandlogout();
            controller.Undergraduate.Undergraduate_School_Attended__c=null;
                 controller.Undergraduate.GraduateDateFrom__c=null;
                 controller.Undergraduate.EducationSpeciality__c = null;
                 controller.Undergraduate.GraduateDateTo__c =null;
                 controller.Undergraduate.Highest_Degree_Attained__c = null;
                 controller.Undergraduate.School_attended_for_Highest_Degree__c =null;
                 controller.Undergraduate.DegreeDateFrom__c  = null;
                 controller.Undergraduate.EducationSpeciality__c  = null;
                 controller.Undergraduate.DegreeDateTo__c = null;
                 controller.Undergraduate.DegreeSpeciality__c=null;             
                 controller.saveUndergraduate();
        }  

     } 
     
  
}