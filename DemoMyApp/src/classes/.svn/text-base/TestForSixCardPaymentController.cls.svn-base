// test class for SixCardPaymentController
@IsTest
private class TestForSixCardPaymentController {
    static testMethod void testforposative() 
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
        // Select Record Type
        Recordtype rectype=[select id from recordType where name='Other' and sobjecttype='Requirement__c'];
                
                // Create application
                Opportunity opp1 = new Opportunity();
                opp1.Name = 'Test Opportunity';
                opp1.Contact__c = C1.Id;
                opp1.StageName ='Accepted';
                opp1.CloseDate = Date.today();
                opp1.Program__c=pro.id;
                opp1.Attachments_Tab_Complete__c=false;
                insert opp1;
                // CReate finace Record
                Opportunity_Finance__c fin = new Opportunity_Finance__c();
               // fin.CurrencyIsoCode = 'USD';
                fin.Opportunity__c = opp1.id;
                insert fin;
                // Create finace transation record
                Finance_Transactions__c ft = new Finance_Transactions__c();
                ft.Finance__c = fin.id;
                insert ft;

    System.currentPagereference().getParameters().put('trx_merchant_reference',fin.id);
    System.currentPagereference().getParameters().put('trx_merchant_reference_2','Application Fee');                
    System.currentPagereference().getParameters().put('TrxID','9952E6CE-50F2-479C-893B-6F8D29C61289');
    System.currentPagereference().getParameters().put('TrxState','CQ');
    System.currentPagereference().getParameters().put('AuthCode','193324');
    System.currentPagereference().getParameters().put('ErrorCode','0');
    System.currentPagereference().getParameters().put('ErrorText','APPROVED');
    System.currentPagereference().getParameters().put('CardType','VS');
    System.currentPagereference().getParameters().put('Card4Digits','4242');
    System.currentPagereference().getParameters().put('CardExpiry','1301');
    System.currentPagereference().getParameters().put('authorise_info_action_message','1301');
    System.currentPagereference().getParameters().put('authorise_info_authorise_code','1301');
    
    SixCardPaymentController controller = new SixCardPaymentController();
    system.assert(controller.PaymentSuccess()==null);
    system.assert(controller.PaymentFailure()==null);
    
    // code for Confirmation deposit fee
    System.currentPagereference().getParameters().put('trx_merchant_reference',ft.id);
    System.currentPagereference().getParameters().put('trx_merchant_reference_2','Confirmation Deposit');
    SixCardPaymentController controller1 = new SixCardPaymentController();    
    system.assert(controller1.PaymentSuccess()==null);
    system.assert(controller1.PaymentFailure()==null);
    }
    
    static testMethod void testforNagative() 
    {
    SixCardPaymentController controller = new SixCardPaymentController();
  //  system.assert(controller.PaymentSuccess()==null);
   // system.assert(controller.PaymentFailure()==null);
    
    }
}