Public without sharing  Class CandidateOnlineAccountController
{
 public User user{get;set;} 
    public Opportunity opp{get;set;}
    public Requirement__c req{get;set;}
    public String firstname{get;set;}
    public string lastname{get;set;}
    Public string nomap{get;set;}   
    Public String Payment_Amount_1st_c{get;set;}
    Public String Payment_Amount_2nd_c{get;set;}
    Public Date Payment_Due_Date_1st_c{get;set;}
    Public Date Payment_Due_Date_2nd_c{get;set;}
    Public String Payment_Plan_c{get;set;}
    Public boolean I_agree_to_Hult_Terms_and_Conditions_c{get;set;}
    public String Program_c{get;set;}
    public String stage{get;set;}
    public string id{get;set;}
    public string Tuition_Fee_c{get;set;}
    public string Scholarship_Amount_c{get;set;}
    public string Go_Ed_Loan_Amount_c{get;set;}
    public string Dubai_Housing_Bursary_Amount_c{get;set;}
    public string Early_Bird_Scholarship_Amount_c{get;set;}
    public string Bertil_Hult_Scholarship_Amount_c{get;set;}
    public string Relocation_Scholarship_Amount_c{get;set;}
    public string Go_Ed_MEFA_Replacement_Loan_Amount_c{get;set;}
    public string Total_Financial_Aid_Amount_c{get;set;}
    public double Course_Deposit_Amount_c{get;set;}
    public Opportunity_Finance__c oppfin{get;set;}
    public String Primary_Program_Choice_c{get;set;}
    public double Total_Tuition_Amount_c{get;set;}
    public double Net_Amount_Due_c{get;set;}
    public double Net_Balance_Due_c{get;set;}
    public date Deposit_Date_Paid_c{get;set;}
    public double Deposit_Paid_c{get;set;}
        public CandidateOnlineAccountController()
        {
            nomap='No Map';
            user = [SELECT contact.id,contact.firstname,contact.lastname FROM User WHERE id = :UserInfo.getUserId()];
            opp=[select id, name,Program__r.name,StageName from Opportunity where contact__c=:user.contact.id];
            Program_c=opp.Program__r.name;
            stage=opp.StageName;
            try{
            oppfin=[select
            Deposit_Paid__c,
            Deposit_Date_Paid__c, 
            Course_Deposit_Amount__c,
            Total_Tuition_Amount__c,
            Net_Amount_Due__c,
            Net_Balance_Due__c,
            Tuition_Fee__c,Scholarship_Amount__c,Go_Ed_Loan_Amount__c,Dubai_Housing_Bursary_Amount__c,Early_Bird_Scholarship_Amount__c,Bertil_Hult_Scholarship_Amount__c,
            Relocation_Scholarship_Amount__c,Go_Ed_MEFA_Replacement_Loan_Amount__c,Total_Financial_Aid_Amount__c, id, Payment_Amount_1st__c,Payment_Amount_2nd__c,Payment_Due_Date_1st__c,Payment_Due_Date_2nd__c,Payment_Plan__c,I_agree_to_Hult_Terms_and_Conditions__c, name from Opportunity_Finance__c where Opportunity__c=:opp.id];
            id=oppfin.id;
            Deposit_Paid_c=oppfin.Deposit_Paid__c;
            Deposit_Date_Paid_c=oppfin.Deposit_Date_Paid__c;
            Net_Balance_Due_c=oppfin.Net_Balance_Due__c;
            Net_Amount_Due_c=oppfin.Net_Amount_Due__c;
            Total_Tuition_Amount_c=oppfin.Total_Tuition_Amount__c;
            Course_Deposit_Amount_c=oppfin.Course_Deposit_Amount__c;
            Payment_Amount_1st_c=string.valueof(oppfin.Payment_Amount_1st__c);
            Payment_Amount_2nd_c=string.valueof(oppfin.Payment_Amount_2nd__c);
            Payment_Due_Date_1st_c=oppfin.Payment_Due_Date_1st__c;
            Payment_Due_Date_2nd_c=oppfin.Payment_Due_Date_2nd__c;
            Payment_Plan_c=oppfin.Payment_Plan__c;
            I_agree_to_Hult_Terms_and_Conditions_c=oppfin.I_agree_to_Hult_Terms_and_Conditions__c;
            Tuition_Fee_c=string.valueof(oppfin.Tuition_Fee__c);
            Scholarship_Amount_c=string.valueof(oppfin.Scholarship_Amount__c);
            Go_Ed_Loan_Amount_c=string.valueof(oppfin.Go_Ed_Loan_Amount__c);
            Dubai_Housing_Bursary_Amount_c=string.valueof(oppfin.Dubai_Housing_Bursary_Amount__c);
            Early_Bird_Scholarship_Amount_c=string.valueof(oppfin.Early_Bird_Scholarship_Amount__c);
            Bertil_Hult_Scholarship_Amount_c=string.valueof(oppfin.Bertil_Hult_Scholarship_Amount__c);
            Relocation_Scholarship_Amount_c=string.valueof(oppfin.Relocation_Scholarship_Amount__c);
            Go_Ed_MEFA_Replacement_Loan_Amount_c=string.valueof(oppfin.Go_Ed_MEFA_Replacement_Loan_Amount__c);
            Total_Financial_Aid_Amount_c=string.valueof(oppfin.Total_Financial_Aid_Amount__c);
            }
            catch (exception e){oppfin=new Opportunity_Finance__c();}
        }
        
        public List<SelectOption> getPlanitems() {
            List<SelectOption> options = new List<SelectOption>();
            options.add(new SelectOption('','--Select--'));
            options.add(new SelectOption('Installment','Yes, sign me up for the installment plan, I agree to term and deadlines'));
            options.add(new SelectOption('Regular','No, I will pay 50% 60 days before the start of class and the remaining 50% 30 days before the start of class '));
            return options;
        }
        
        public pagereference saveandcontinue()
        {
        if(Payment_Plan_c==null)
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please select Installment Decision'));
            }    
        if(I_agree_to_Hult_Terms_and_Conditions_c==false)
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please check I agree to Hult International School Terms and Conditions'));
            }    
        if(!apexpages.hasmessages()) 
            {    
                Opportunity_Finance__c oppfin1=[select id, Payment_Amount_1st__c,Payment_Amount_2nd__c,Payment_Due_Date_1st__c,Payment_Due_Date_2nd__c,Payment_Plan__c,I_agree_to_Hult_Terms_and_Conditions__c, name from Opportunity_Finance__c where id=:id];
                oppfin1.Payment_Plan__c=Payment_Plan_c;
                oppfin1.I_agree_to_Hult_Terms_and_Conditions__c=I_agree_to_Hult_Terms_and_Conditions_c;
                update oppfin1;
            }
            else
            {
            return null;
            }
        return page.CandidateOnlineAccount;
        }
        
        public pagereference candidatestatement()
        {
        return null;
        }
     public PageReference saveandcontinueandlogout() {
        if (saveandcontinue() == null)
            return null; // saveandcontinue() returning null means there were errors, so drop back to the page.
        return new PageReference('/secur/logout.jsp');
    }   
     

}