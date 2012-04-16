@IsTest
private class TestForApplicantSponsorshipController {
    static testmethod void testCase(){
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
        User u=[select Id, ContactId from User where id=:u1.id limit 1];
        try{
        Opportunity opp1 = new Opportunity();
            opp1.Name = 'Test Opportunity';
            opp1.Contact__c = u.ContactId;
            opp1.StageName ='Accepted';
            opp1.CloseDate = Date.today();
            insert opp1;} catch (exception e){}
        System.runAs(u){
            RecordType recid=[select id from recordtype where name='Sponsorship' and sobjectType='Requirement__c'];
            ApplicantSponsorshipController contr = new ApplicantSponsorshipController();
            contr.req.Name= 'Test Requirement';
            contr.req.Contact__c = u.ContactId;
            contr.req.RecordTypeId = recid.Id;
            contr.Sponser_c = 'Employer';
            contr.req.ContactPerson__c = 'Test person';
            contr.req.SponsorerAddress__c = 'Test Address';
            contr.req.Phone_Country_Code__c = country.id;
            contr.req.PhoneAreaCode__c = '123';
            contr.req.PhoneNo__c = '123456';
            contr.req.Family_Sponsor__c='N/A';
            system.assert(contr.getcountryCode()!=null);   
            contr.issetself();
            contr.getItems();
            system.assert(contr.saveandcontinue()!=null);            
            
            system.assert(contr.saveandcontinueandlogout()!=null);
            contr.req.Name= 'Test Requirement';
            contr.req.Contact__c = u.ContactId;
            contr.req.RecordTypeId = recid.Id;
            contr.req.Sponser__c = 'Self';           
            contr.saveandcontinue();
            contr.req.Name= 'Test Requirement';
            contr.req.Contact__c = u.ContactId;
            contr.req.RecordTypeId = recid.Id;
            contr.req.Sponser__c = 'Employer';
            contr.req.ContactPerson__c = null;
            contr.req.SponsorerAddress__c = null;
            contr.req.Phone_Country_Code__c = null;
            contr.req.PhoneAreaCode__c = null;
            contr.req.PhoneNo__c = null;
            contr.req.Family_Sponsor__c=null;
           // system.assert(contr.saveandcontinue()==null);
            
            
        } 
    }
}