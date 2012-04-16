// test class for ApplicantDocumentsController 
@IsTest
private class TestForApplicantDocumentsController {
    static testMethod void testApplicant() 
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
        Recordtype rectype=[select id from recordType where name='Other' and sobjecttype='Requirement__c'];
                Opportunity opp1 = new Opportunity();
                opp1.Name = 'Test Opportunity';
                opp1.Contact__c = C1.Id;
                opp1.StageName ='Accepted';
                opp1.CloseDate = Date.today();
                opp1.Program__c=pro.id;
                opp1.Attachments_Tab_Complete__c=false;
                insert opp1;
            
                
        System.runAs(u1) 
        {
                
               
                ApplicantDocumentsController controller = new ApplicantDocumentsController();                
                controller.hist.name='Statement of Purpose';
                controller.hist.contact__c=C1.id;
                controller.hist.Opportunity__c=opp1.id;
                controller.hist.recordtypeid=rectype.id;
               
                controller.attach.name=controller.hist.name;
                controller.attach.parentid=C1.id;
                controller.attach.Description='Test';
                controller.attach.body=blob.valueof('ddd');
                Requirement__c req=new Requirement__c(name=controller.hist.name,
                contact__c=C1.id,Opportunity__c=opp1.id,recordtypeid=rectype.id);
                insert req;
                controller.reqtype='Admissions';              
                system.assert(controller.getexamtype()==null);
                controller.getreclist1();
                system.assert(controller.isdoc==true);
                system.assert(controller.saveandcontinue()!=null);                
                system.assert(controller.saveandcontinueandlogout()==null);                
                system.assert(controller.saveand()==null);
                controller.attachdocssaveand();
                controller.attachdocsaveandcontinue();
                /*req=new Requirement__c(name=controller.hist.name,
                contact__c=C1.id,Opportunity__c=opp1.id,recordtypeid=rectype.id);
                insert req;*/
                attachment at=new Attachment(name='test',description='test',
                body=blob.valueof('test'),parentid=req.id);
                insert at;
                System.currentPagereference().getParameters().put('att',at.id);  
                System.currentPagereference().getParameters().put('rid',req.id);  
                system.assert(controller.delattachment()!=null);
                controller.updateflag();
                attachment att1=new Attachment(name='test',description='test',
                body=blob.valueof('test'),parentid=req.id);
                insert att1;
                System.currentPagereference().getParameters().put('att',att1.id);  
                System.currentPagereference().getParameters().put('rid',req.id);
                controller.attachdocsdelattachment();
                 
        }  

     }
}