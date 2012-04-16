Public without sharing  Class StudentFinancialInformationController
{
    public User user{get;set;}
    public Opportunity opp{get;set;}
    public Opportunity_Finance__c oppfin{get;set;}
    public Decimal Percent_Complete_c{get;set;}
    public boolean Unlock_Student_Financial_Information_c{get;set;}
    public boolean Paid_Application_Fee_c{get;set;}
    public boolean isAcceptanceletter{get;set;}
    public string proname{get;set;}
    public boolean isPayConfirmationDeposit{get;set;}
    public StudentFinancialInformationController() {
        user = new User();
        opp = new Opportunity();
        oppfin = new Opportunity_Finance__c();
        Percent_Complete_c = 0;
        Unlock_Student_Financial_Information_c = false;
        
        User[] userList = [
            select Contact.FirstName
                 , Contact.LastName 
              from User 
             where Id = :UserInfo.getUserId()
        ];
        
        if (userList.size() == 0)
            return;
            
        user = userList[0];
        
        // Find the opportunity record
        Opportunity[] opportunityList = [
            select Name
                 , Program__r.Name
                 , StageName
                 , Application_Substage__c
                 , Percent_Complete__c,
                 Paid_Application_Fee__c
              from Opportunity 
             where Contact__c = :user.Contact.Id
        ];
        
        if (opportunityList.size() == 0)
            return;
        
        opp = opportunityList[0];
        Percent_Complete_c=opp.Percent_Complete__c;
        Paid_Application_Fee_c=opp.Paid_Application_Fee__c;
        proname=opp.Program__r.Name;
        
       /* if((opp.stageName=='Confirmed') || (opp.stageName=='Cond. Accepted') || (opp.stageName=='Endorsed') ){
            isAcceptanceletter = true;
        }*/
        if ((opp.stageName=='Accepted' || opp.stageName=='Conditionally Accepted' || opp.stageName=='Admissions Endorsed') && opp.Application_Substage__c=='Notified'){
            isAcceptanceletter = true;
            isPayConfirmationDeposit = true;
        }
        else if(    opp.stageName=='Confirmed' || opp.stageName=='Conditionally Confirmed'
                 || opp.stageName=='Endorsed Confirmed' || opp.stageName=='Waitlisted Confirmed'
                 || opp.stageName=='Cancellation' || opp.stageName=='Deferral'
                 || opp.stageName=='Enrolled' || opp.stageName=='Admissions Endorsed Confirmed' ){
            isAcceptanceletter = true;
        }
        else{
            isAcceptanceletter = false;
        }
        
        
        
        
        // Find the opportunity finance record
        Opportunity_Finance__c[] opportunityFinanceList = [
            select Unlock_Student_Financial_Information__c 
              from Opportunity_Finance__c 
             where Opportunity__c = :opp.id
        ];
        
        if (opportunityFinanceList.size() == 0)
            return;
        oppfin = opportunityFinanceList[0];
        Unlock_Student_Financial_Information_c = oppfin.Unlock_Student_Financial_Information__c;
    }
        
   static testMethod void testPStudentFinancialInformation() {  
        
         User currentUser = [select id,contact.id, title, firstname, lastname, email FROM User WHERE Profile.Name  = 'Applicant Customer Portal User' and IsActive  = true limit 1];      
                program__c pro =[select id from program__c where name='MIB-US-Boston'];
                try{
                Opportunity opp1 = new Opportunity();
                opp1.Name = 'Test Opportunity';
                opp1.Contact__c = currentUser.Contact.Id;
                opp1.StageName ='Accepted';
                opp1.CloseDate = Date.today();
                opp1.Program__c =pro.id;
                insert opp1;
                Opportunity_Finance__c oppfin= new Opportunity_Finance__c();
                oppfin.Opportunity__c=opp1.id;
                oppfin.CurrencyIsoCode='USD';
                oppfin.Payment_Plan__c='Regular';
                oppfin.I_agree_to_Hult_Terms_and_Conditions__c=true;
                oppfin.Unlock_Student_Financial_Information__c=true;
                insert oppfin;} catch (exception e){}
        
        
        System.runAs(currentUser) 
        {
           
           StudentFinancialInformationController controller = new StudentFinancialInformationController();
            
        }  
        }
        
    static testMethod void testNStudentFinancialInformation(){  
        
         User currentUser = [select id,contact.id, title, firstname, lastname, email FROM User WHERE Profile.Name  = 'Applicant Customer Portal User' and IsActive  = true limit 1];   
         try{
         Opportunity opp1 = new Opportunity();
                opp1.Name = 'Test Opportunity';
                opp1.Contact__c = currentUser.Contact.Id;
                opp1.StageName ='Accepted';
                opp1.CloseDate = Date.today();               
                insert opp1;} catch (exception e){}
         System.runAs(currentUser) 
         {    
                StudentFinancialInformationController controller = new StudentFinancialInformationController();
            
        }

     }     

}