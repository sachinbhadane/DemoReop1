// test class for ApplicantEducationController
@IsTest
private class TestForAppRecommendationController {
static testMethod void testPosativeEducation() 
    {  
        //get a user with System Administrator profile and with any role
        User userAccount = [ Select id,userroleid from user where profile.name = 'System Administrator' and userroleid!=null and isactive=true limit 1];
        
        // get profile id for 'Applicant Customer Portal User'
        ID ProfileID = [ Select id from Profile where name = 'Applicant Customer Portal User'].id;
        
        //insert country
        Country__c country = new Country__c(Name='Test Country');
        insert country;
        
        // insert program
        Program__c pro=new Program__c(name='MIB-US-Boston',Country__c=country.id);
        insert pro;
        
        // insert account
        Account A1 = new Account(Name = pro.name,ownerid=userAccount.id);
        insert A1;        
        
        
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
            Requirement__c pReq = new Requirement__c();
            pReq.name='Professional Recommentation (1 of 2)';
            pReq.Country__c = country.id;
            insert pReq;
                //Requirement__c r=[select id,name from Requirement__c where id=:pReq limit 1] ;
                Requirement__c req=new Requirement__c();
                req.name = pReq.name;
                req.Recommendation_SWOT__c='dd';
                req.Recommendation_Background__c='test';
                req.Recommendation_Level_Of_Planning__c='test';
                req.Recommendation_Stress_Management__c='test';
                req.Recommendation_Work_Experience__c='test';
                req.Recommendation_Personal_Motivation__c='test';
                req.Recommendation_Potential_For_Growth__c='test';
                req.Recommendation_Analytical_Ability__c='test';
                req.Recommendation_Comments__c='test';
                req.Recommendation_English_Ability__c='test';
                req.Opportunity__c = opp.id;
                //req.contact__c = c1.id;
                req.Parent__c = pReq.id;
               // req.Recommendation_Contact__c =c1.id;
                insert req;
                System.currentPagereference().getParameters().put('contactid',req.id);
                String encoded = EncodingUtil.urlEncode('test-user@fakeemail.com', 'UTF-8');     
                System.currentPagereference().getParameters().put('c',encoded);    
                ApplicationRecommendationController controller = new ApplicationRecommendationController();
                             
                controller.req.Recommendation_SWOT__c='dd';
                controller.req.Recommendation_Background__c='test';
                controller.req.Recommendation_Level_Of_Planning__c='test';
                controller.req.Recommendation_Stress_Management__c='test';
                controller.req.Recommendation_Work_Experience__c='test';
                controller.req.Recommendation_Personal_Motivation__c='test';
                controller.req.Recommendation_Potential_For_Growth__c='test';
                controller.req.Recommendation_Analytical_Ability__c='test';
               controller.req.Recommendation_Comments__c='test';
                controller.req.Recommendation_English_Ability__c='test';           
                controller.saveandcontinue();
                
                controller.req.Recommendation_SWOT__c='';
                controller.req.Recommendation_Background__c='';
                controller.req.Recommendation_Level_Of_Planning__c='';
                controller.req.Recommendation_Stress_Management__c='';
                controller.req.Recommendation_Work_Experience__c=null;
                controller.req.Recommendation_Personal_Motivation__c=null;
                controller.req.Recommendation_Potential_For_Growth__c=null;
                controller.req.Recommendation_Analytical_Ability__c=null;
                controller.req.Recommendation_Comments__c=null;
                controller.req.Recommendation_English_Ability__c=null;           
                controller.saveandcontinue();

         /* System.runAs(currentUser){
            ApplicationRecommendationController controller = new ApplicationRecommendationController();
         } */
     
  
    }
}