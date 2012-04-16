// test class for ApplicantExamController 
@IsTest
private class TestForApplicantExamController  {
// Test Method
    
    static testMethod void testExam() 
    {  
         //get a user with System Administrator profile and with any role
        User userAccount = [ Select id,userroleid from user where profile.name = 'System Administrator' and userroleid!=null and isactive=true limit 1];
         // get profile id for 'Applicant Customer Portal User'
        ID ProfileID = [ Select id from Profile where name = 'Applicant Customer Portal User'].id;
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
          // insert opportunity
         Opportunity opp = new Opportunity();
            opp.Name = 'Test Opportunity';
            opp.Contact__c = C1.Id;
            opp.StageName ='Accepted';
            opp.CloseDate = Date.today();
           // opp.Program__c=pro.id;
            opp.Education_Tab_Complete__c=false;
            insert opp;
       // get current user
      
        System.runAs(u1) 
        {
                
                 RecordType recid=[select id from recordtype where name='Exam' and sobjectType='History__c'];
                 ApplicantExamController controller = new ApplicantExamController();
                 
                 //controller.hist.Name='test';
                // controller.hist.Years__c='2010';
                // controller.hist.Month__c='05';
                 controller.hist.Exam_Type__c='Test';
                 controller.hist.Planned_Test_Date__c=date.today();
                 controller.hist.Planned_Test_Location__c='test';
                 controller.hist.Exam_Location__c='test';
                 controller.hist.Exam_Score__c='100';
                 controller.hist.NeedofTest__c=true;
                 controller.Planned_Test_Date_day='01';
                 controller.Planned_Test_Date_month='01';
                 controller.Planned_Test_Date_year='2020';                 
                 system.assert(controller.saveandcontinue()!=null);
                 
                 //controller.hist.TakenTest__c=true;
                 controller.hist.Exam_Type__c='Test';
                 controller.hist.Planned_Test_Date__c=date.today();
                 controller.hist.Planned_Test_Location__c='test';
                 controller.hist.Exam_Location__c='test';
                 controller.hist.Exam_Score__c='100';
                 controller.hist.NeedofTest__c=true;
                 controller.Exam_Date_day='01';
                 controller.Exam_Date_month='01';
                 controller.Exam_Date_year='1900';
                 system.assert(controller.saveandcontinue()!=null);
                 
                 controller.hist.TakenTest__c=true;
                 controller.hist.Exam_Type__c=null;                 
                 controller.hist.Planned_Test_Location__c=null;
                 controller.hist.Exam_Location__c=null;
                 controller.hist.Exam_Score__c=null;
                 controller.Exam_Date_day='';
                 controller.Exam_Date_month='';
                 controller.Exam_Date_year='';
                 system.assert(controller.saveandcontinue()==null);
                 system.assert(controller.saveandcontinueandlogout()==null);               
                 controller.allrecord();
                 Exam__c his=new Exam__c(Application__c=opp.id,
                 Planned_Test_Date__c=date.today(),
                 Exam_Date__c=date.today()
                 );
                 insert his;
                
                System.currentPagereference().getParameters().put('hid',his.id);
                controller.edit();
                system.assert(controller.isedit==true);
                controller.hisdelete();
                system.assert(controller.isedit==false);
                controller.cancel();
                system.assert(controller.isedit==false);
                controller.saveandsave();
                controller.Onlinesaveandcontinue();
        }  

     }
}