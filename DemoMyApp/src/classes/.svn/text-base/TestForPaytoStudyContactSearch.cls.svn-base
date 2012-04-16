// test class for PaytoStudyContactSearch 
@IsTest
private class TestForPaytoStudyContactSearch {
    static testMethod void testPaYsearch() 
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
        
          
        System.runAs(userAccount)
       {
        
        contact cc = [select name,Student_ID__c from contact limit 1];
        PaytoStudyContactSearch  con = new PaytoStudyContactSearch();   
        con.name = cc.name;
        con.id = cc.Student_ID__c;     
        con.contactSearch();
        con.name= '';
        con.id = '';
        con.contactSearch();
            
        }  

     }
}