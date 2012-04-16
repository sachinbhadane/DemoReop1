// test class for CandidateOnlineAccountController
@IsTest
private class TestForCandidateOnlineAccountController {
         static testMethod void testOnlineAccount() 
    {  
       User userAccount = [ Select id,userroleid from user where profile.name = 'System Administrator' and userroleid!=null and isactive=true limit 1];
        ID ProfileID = [ Select id from Profile where name = 'Applicant Customer Portal User'].id;
        Program__c pro=new Program__c(name='MIB-US-Boston');
        insert pro;
        Account A1 = new Account(Name = pro.name,ownerid=userAccount.id);
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
        
        
                Opportunity opp1 = new Opportunity();
                opp1.Name = 'Test Opportunity';
                opp1.Contact__c = currentUser.Contact.Id;
                opp1.StageName ='Accepted';
                opp1.CloseDate = Date.today();
                opp1.Program__c =pro.id;
                opp1.Secondary_Program__c=pro.id; 
                opp1.Rotation_First_Choice__c='Boston';
                opp1.Primary_Campus__c='Boston';
                opp1.Secondary_Campus__c='Boston';
                opp1.Start_Term__c='September 2011';
                opp1.Global_Campus_Rotation_Program__c=true;
                opp1.Number_of_Rotations__c='1';
                opp1.Rotation_Second_Choice__c='Boston';
                opp1.Rotation_First_Choice__c='Boston';
                opp1.Primary_Interest__c='Career Change';
                opp1.Primary_Program_Choice__c='Master\'s Program';
                opp1.Secondary_Program_Choice__c='Master\'s Program';
                opp1.Masters_Program_Choice__c='Master of International Business';
                opp1.Secondary_Masters_Program_Choice__c='Master of International Business';
                insert opp1;
                Opportunity_Finance__c oppfin= new Opportunity_Finance__c();
                oppfin.Opportunity__c=opp1.id;
                oppfin.CurrencyIsoCode='USD';
                oppfin.Payment_Plan__c='Regular';
                oppfin.Insurance__c='Waived';
                oppfin.I_agree_to_Hult_Terms_and_Conditions__c=true;
                insert oppfin;
        System.runAs(currentUser) 
        {
                
                CandidateOnlineAccountController controller = new CandidateOnlineAccountController();
                controller.getPlanitems();
                controller.id=oppfin.id;
                controller.saveandcontinue();
                controller.candidatestatement();
                controller.saveandcontinueandlogout();
        }  

     } 
}