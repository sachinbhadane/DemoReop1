Public without sharing  Class FinanceStatementController
{

 public User user{get;set;} 
    public Opportunity opp{get;set;}
    public Requirement__c req{get;set;}
    public String firstname{get;set;}
    public string lastname{get;set;}
    Public string nomap{get;set;} 
    public double Total_Fees_Due_FS_c{get;set;}
    public double Go_Ed_Loan_Amount_FS_c{get;set;}
    public double Scholarship_Amount_FS_c{get;set;}  
    public double Housing_Fee_FS_c{get;set;}
    Public double Payment_Amount_1st_c{get;set;}
    Public double Payment_Amount_2nd_c{get;set;}
    Public Date Payment_Due_Date_1st_c{get;set;}
    Public Date Payment_Due_Date_2nd_c{get;set;}
    Public String Payment_Plan_c{get;set;}
    Public boolean I_agree_to_Hult_Terms_and_Conditions_c{get;set;}
    public String Program_c{get;set;}
    public String stage{get;set;}
    public string id{get;set;}
    public double Total_Tuition_Amount_c{get;set;}
    public Double Scholarship_Amount_c{get;set;}
    public double Go_Ed_Loan_Amount_c{get;set;}
    public string Dubai_Housing_Bursary_Amount_c{get;set;}
    public Double Early_Bird_Scholarship_Amount_c{get;set;}
    public string Bertil_Hult_Scholarship_Amount_c{get;set;}
    public string Relocation_Scholarship_Amount_c{get;set;}
    public string Go_Ed_MEFA_Replacement_Loan_Amount_c{get;set;}
    public double Total_Financial_Aid_Amount_c{get;set;}
    public double Course_Deposit_Amount_c{get;set;}
    public Opportunity_Finance__c oppfin{get;set;}
    public String Primary_Program_Choice_c{get;set;}    
    public double Net_Amount_Due_c{get;set;}
    public double Current_Balance_Due_Portal_c{get;set;}
    public date Deposit_Date_Paid_c{get;set;}
    public double Deposit_Paid_c{get;set;}
    public string hultID{get;set;}
    public string CurrencyIsoCode{get;set;}
    public double Student_Resources_Activities_c{get;set;}
    public double Toolbox_Case_Study_Pack_c{get;set;}
    public double Erika_Insurance_Price_c{get;set;}
    public boolean Unlock_Student_Financial_Information_c{get;set;}
    public string App_ID_c{get;set;}
    public double Insurance_Fee_c{get;set;}
    public double Visa_Fee_c{get;set;}
    public double Specialization_Fee_FS_new_c{get;set;}
    public double IEBA_IEMS_Program_Fee_FS_c{get;set;}
    public double Partner_Program_Insurance_Fee_FS_c{get;set;}
    public double Installment_Plan_Fee_FS_c{get;set;}    
    public double Deposit_Amount_Due_FS_c{get;set;}  
    public double Dean_Scholarship_Amount_FS_c{get;set;}
    public double Bertil_Hult_Scholarship_Amount_FS_c{get;set;}
    public double Relocation_Scholarship_Amount_FS_c{get;set;}
    public double Total_Financial_Aid_FS_c{get;set;}
    public double Total_Balance_Due_FS_c{get;set;}
    public double Early_Bird_Scholarship_Amount_FS_c{get;set;}
    public string Insurance_Company_FS_c{get;set;}
    public string Insurance_Type_FS_c{get;set;}
    public double Adjustment_Amount_c{get;set;}
    public date DatePrinted = date.today();
    public date getDatePrinted(){
        return DatePrinted;
    }
    public string Aetna_Insurance_c{get;set;}
    public double Aetna_Insurance_Price_c{get;set;}
    public string Installment_Plan_c{get;set;}   
    public string Go_Ed_Loan_Note_FS_c{get;set;}
    public string ccode{get;set;}
    public string Housing_Accommodation_c{get;set;}
    public boolean isShow{get;set;}
    public double paytostudyAmount;
    public double paytostudyAmount1;
    public double paytostudyAmount2;
    public double Payment_Amount_3rd_c{get;set;}
    public double Payment_Amount_4th_c{get;set;}
    public double Payment_Amount_5th_c{get;set;}
    public double Payment_Amount_6th_c{get;set;}
    public double Payment_Amount_7th_c{get;set;}
    public double Payment_Amount_8th_c{get;set;}
    public date Payment_Due_Date_3rd_c{get;set;}
    public date Payment_Due_Date_4th_c{get;set;}
    public date Payment_Due_Date_5th_c{get;set;}
    public date Payment_Due_Date_6th_c{get;set;}
    public date Payment_Due_Date_7th_c{get;set;}
    public date Payment_Due_Date_8th_c{get;set;}    
    
        public FinanceStatementController()
        {
            try{
                nomap='No Map';
                // This condition use for create PDF from admin
                if(System.currentPagereference().getParameters().get('contactid')==null){
                    user = [SELECT contact.Mailing_Country__r.Country_Code__c,contact.Mailing_Country__r.Calling_Code__c, contact.Mailing_Country__r.Country_Code_for_PaytoStudy__c, contact.Mobile_Phone_Main_Number__c, contact.Home_Phone_Main_Number__c, contact.email, contact.Birthdate, contact.Salutation, contact.MailingStreet, contact.mailingpostalcode,contact.Mailingstate, contact.Mailingcity, contact.Mailing_Country__r.name, contact.id,contact.firstname,contact.lastname FROM User WHERE id = :UserInfo.getUserId()];
                }
                else{
                    user = [SELECT contact.Mailing_Country__r.Country_Code__c,contact.Mailing_Country__r.Calling_Code__c, contact.Mailing_Country__r.Country_Code_for_PaytoStudy__c, contact.Mobile_Phone_Main_Number__c, contact.Home_Phone_Main_Number__c, contact.email, contact.Birthdate, contact.Salutation, contact.MailingStreet, contact.mailingpostalcode,contact.Mailingstate, contact.Mailingcity, contact.Mailing_Country__r.name, contact.id,contact.firstname,contact.lastname FROM User WHERE contact.id = :System.currentPagereference().getParameters().get('contactid') limit 1];
                }
                opp=[select Primary_Program_Choice__c, PaytoStudy_Registration__c, Primary_Campus__c, program__r.CurrencyIsoCode,            
                App_ID__c, id, name,Program__r.name,StageName from Opportunity where contact__c=:user.contact.id limit 1];
                Program_c=opp.Program__r.name;
                stage=opp.StageName;
                App_ID_c = opp.App_ID__c;  
                Primary_Program_Choice_c = opp.Primary_Program_Choice__c;
                if (opp.Primary_Campus__c=='London'){
                        ccode= 'GBP';
                    }
                else{
                       ccode= 'USD';
                }
                              
                try{
                oppfin=[select 
                Payment_Amount_3rd__c,
                Payment_Amount_4th__c,
                Payment_Amount_5th__c,
                Payment_Amount_6th__c,
                Payment_Amount_7th__c,
                Payment_Amount_8th__c,
                Payment_Due_Date_3rd__c,
                Payment_Due_Date_4th__c,
                Payment_Due_Date_5th__c,
                Payment_Due_Date_6th__c,
                Payment_Due_Date_7th__c,
                Payment_Due_Date_8th__c, 
                Housing_Accommodation__c,
                Tuition_Fees_Balance_Due__c,             
                Go_Ed_Loan_Note_FS__c,
                Adjustment_Amount__c, 
                Total_Fees_Due_FS__c,
                Go_Ed_Loan_Amount_FS__c,
                Scholarship_Amount_FS__c,
                Housing_Fee_FS__c,
                Early_Bird_Scholarship_Amount_FS__c,
                Total_Balance_Due_FS__c,
                Total_Financial_Aid_FS__c,
                Relocation_Scholarship_Amount_FS__c,
                Bertil_Hult_Scholarship_Amount_FS__c,
                Dean_Scholarship_Amount_FS__c,
                Deposit_Amount_Due_FS__c,
                Insurance_Type_FS__c,           
                Insurance_Company_FS__c,
                Installment_Plan_Fee_FS__c,
                Partner_Program_Insurance_Fee_FS__c,
                IEBA_IEMS_Program_Fee_FS__c,
                Specialization_Fee_FS_new__c,
                Visa_Fee__c,  
                Insurance_Fee__c,
                Installment_Plan__c,  
                Aetna_Insurance__c,       
                Aetna_Insurance_Price__c,
                Unlock_Student_Financial_Information__c,
                Toolbox_Case_Study_Pack__c,
                Erika_Insurance_Price__c,
                Student_Resources_Activities__c,
                CurrencyIsoCode,            
                Deposit_Paid__c,
                Deposit_Date_Paid__c, 
                Course_Deposit_Amount__c,
                Total_Tuition_Amount__c,
                Net_Amount_Due__c,
                Current_Balance_Due_Portal__c,
                Scholarship_Amount__c,Go_Ed_Loan_Amount__c,Dubai_Housing_Bursary_Amount__c,Early_Bird_Scholarship_Amount__c,Bertil_Hult_Scholarship_Amount__c,
                Relocation_Scholarship_Amount__c,Go_Ed_MEFA_Replacement_Loan_Amount__c,Total_Financial_Aid_Amount__c, id, Payment_Amount_1st__c,Payment_Amount_2nd__c,Payment_Due_Date_1st__c,Payment_Due_Date_2nd__c,Payment_Plan__c,I_agree_to_Hult_Terms_and_Conditions__c, name from Opportunity_Finance__c where Opportunity__c=:opp.id];
                Housing_Accommodation_c = oppfin.Housing_Accommodation__c;
                Go_Ed_Loan_Note_FS_c = oppfin.Go_Ed_Loan_Note_FS__c;
                Adjustment_Amount_c = oppfin.Adjustment_Amount__c;
                Housing_Fee_FS_c = oppfin.Housing_Fee_FS__c;
                Aetna_Insurance_c = oppfin.Aetna_Insurance__c;
                Aetna_Insurance_Price_c = oppfin.Aetna_Insurance_Price__c;
                id=oppfin.id;
                Go_Ed_Loan_Amount_FS_c = oppfin.Go_Ed_Loan_Amount_FS__c;
                Scholarship_Amount_FS_c = oppfin.Scholarship_Amount_FS__c;
                Installment_Plan_c = oppfin.Installment_Plan__c;
                hultID = oppfin.name;
                Total_Fees_Due_FS_c = oppfin.Total_Fees_Due_FS__c;
                Deposit_Paid_c=oppfin.Deposit_Paid__c;
                Deposit_Date_Paid_c=oppfin.Deposit_Date_Paid__c;
                Current_Balance_Due_Portal_c=oppfin.Current_Balance_Due_Portal__c;
                Net_Amount_Due_c=oppfin.Net_Amount_Due__c;
                Total_Tuition_Amount_c=oppfin.Total_Tuition_Amount__c;
                Course_Deposit_Amount_c=oppfin.Course_Deposit_Amount__c;
                Payment_Amount_1st_c=oppfin.Payment_Amount_1st__c;
                Payment_Amount_2nd_c=oppfin.Payment_Amount_2nd__c;
                Payment_Due_Date_1st_c=oppfin.Payment_Due_Date_1st__c;
                Payment_Due_Date_2nd_c=oppfin.Payment_Due_Date_2nd__c;
                Payment_Plan_c=oppfin.Payment_Plan__c;
                I_agree_to_Hult_Terms_and_Conditions_c=oppfin.I_agree_to_Hult_Terms_and_Conditions__c;
                Total_Tuition_Amount_c=oppfin.Total_Tuition_Amount__c;
                Scholarship_Amount_c=oppfin.Scholarship_Amount__c;
                Go_Ed_Loan_Amount_c=oppfin.Go_Ed_Loan_Amount__c;
                Dubai_Housing_Bursary_Amount_c=string.valueof(oppfin.Dubai_Housing_Bursary_Amount__c);
                Early_Bird_Scholarship_Amount_c=oppfin.Early_Bird_Scholarship_Amount__c;
                Bertil_Hult_Scholarship_Amount_c=string.valueof(oppfin.Bertil_Hult_Scholarship_Amount__c);
                Relocation_Scholarship_Amount_c=string.valueof(oppfin.Relocation_Scholarship_Amount__c);
                Go_Ed_MEFA_Replacement_Loan_Amount_c=string.valueof(oppfin.Go_Ed_MEFA_Replacement_Loan_Amount__c);
                Total_Financial_Aid_Amount_c=oppfin.Total_Financial_Aid_Amount__c;
                CurrencyIsoCode = oppfin.CurrencyIsoCode;
                Student_Resources_Activities_c = oppfin.Student_Resources_Activities__c;
                Toolbox_Case_Study_Pack_c = oppfin.Toolbox_Case_Study_Pack__c;
                Erika_Insurance_Price_c = oppfin.Erika_Insurance_Price__c;
                Insurance_Fee_c = oppfin.Insurance_Fee__c;            
                Visa_Fee_c = oppfin.Visa_Fee__c;
                Specialization_Fee_FS_new_c = oppfin.Specialization_Fee_FS_new__c;
                IEBA_IEMS_Program_Fee_FS_c = oppfin.IEBA_IEMS_Program_Fee_FS__c;
                Partner_Program_Insurance_Fee_FS_c = oppfin.Partner_Program_Insurance_Fee_FS__c;
                Installment_Plan_Fee_FS_c = oppfin.Installment_Plan_Fee_FS__c;
                Insurance_Company_FS_c = oppfin.Insurance_Company_FS__c;
                Total_Fees_Due_FS_c = oppfin.Total_Fees_Due_FS__c;
                Insurance_Type_FS_c = oppfin.Insurance_Type_FS__c;
                Deposit_Amount_Due_FS_c = oppfin.Deposit_Amount_Due_FS__c;
                Dean_Scholarship_Amount_FS_c = oppfin.Dean_Scholarship_Amount_FS__c;
                Bertil_Hult_Scholarship_Amount_FS_c = oppfin.Bertil_Hult_Scholarship_Amount_FS__c;
                Relocation_Scholarship_Amount_FS_c = oppfin.Relocation_Scholarship_Amount_FS__c;
                Total_Financial_Aid_FS_c = oppfin.Total_Financial_Aid_FS__c;
                Total_Balance_Due_FS_c = oppfin.Total_Balance_Due_FS__c;
                Early_Bird_Scholarship_Amount_FS_c = oppfin.Early_Bird_Scholarship_Amount_FS__c;
                paytostudyAmount1 = oppfin.Payment_Amount_1st__c;
                paytostudyAmount2 = oppfin.Tuition_Fees_Balance_Due__c;
                Payment_Amount_3rd_c = oppfin.Payment_Amount_3rd__c;
                Payment_Amount_4th_c = oppfin.Payment_Amount_4th__c;
                Payment_Amount_5th_c = oppfin.Payment_Amount_5th__c;
                Payment_Amount_6th_c = oppfin.Payment_Amount_6th__c;
                Payment_Amount_7th_c = oppfin.Payment_Amount_7th__c;
                Payment_Amount_8th_c = oppfin.Payment_Amount_8th__c;
                Payment_Due_Date_3rd_c = oppfin.Payment_Due_Date_3rd__c;
                Payment_Due_Date_4th_c = oppfin.Payment_Due_Date_4th__c;
                Payment_Due_Date_5th_c = oppfin.Payment_Due_Date_5th__c;
                Payment_Due_Date_6th_c = oppfin.Payment_Due_Date_6th__c;
                Payment_Due_Date_7th_c = oppfin.Payment_Due_Date_7th__c;
                Payment_Due_Date_8th_c = oppfin.Payment_Due_Date_8th__c; 
                
                
                if(oppfin.Unlock_Student_Financial_Information__c){
                    Unlock_Student_Financial_Information_c =true;
                }
                else{
                    Unlock_Student_Financial_Information_c = false;
                }
                isShow = true;
                }
                catch (exception e){
                    Unlock_Student_Financial_Information_c = false;
                    isShow = false;
                //ApexPages.addMessages(e);
                //oppfin=new Opportunity_Finance__c();
                }
            }    
            catch(exception e){
                apexpages.addmessages(e);
            } 
            
           
            
               
        }
        
       // Code for currency convert       
       List<DatedConversionRate> ExchRateCache = [SELECT ISOCode, ConversionRate, StartDate, NextStartDate 
                FROM DatedConversionRate];
                 
       public double nRate(String cCode, date dDateFieldValue){
           double nRate = -1;
                for (DatedConversionRate exchRate : ExchRateCache) {
                    // Looping through the cached DatedConversionRate object
                    if (exchRate.ISOCode == cCode 
                    && exchRate.StartDate <= dDateFieldValue 
                    && exchRate.NextStartDate > dDateFieldValue) {
                        // Look for a match for CURRENCYCODE and within the Date Ranges
                        nRate = exchRate.ConversionRate;
                        break;
                    }
                }
                return nRate;
       }
              
       public double currencyConvert(double amount,string cCode, Date dDateFieldValue){
           double cValue;
           try{
               cValue = ((nRate(opp.program__r.CurrencyIsoCode,dDateFieldValue))/nRate(cCode ,dDateFieldValue))*amount;
           } 
           Catch(exception e){
               cvalue=amount;
           }
           return cValue;
       } 
       
        // end code for convert currency
        
        public List<FinanceStatementController.WrapObj>  getfTransactionList(){
            //List<Finance_Transactions__c> sList = [select Transaction_Type__c,Amount_Received__c, CurrencyIsoCode,Transaction_Date_Time__c from Finance_Transactions__c where Finance__r.Opportunity__c=: opp.id and Transaction_Type__c!='Application Fee' and Transaction_Status__c='Success'];
            List<Finance_Transactions__c> sList = [select createddate, Transaction_Type__c,Amount_Received__c, CurrencyIsoCode,Transaction_Date_Time__c from Finance_Transactions__c where Finance__r.Opportunity__c=: opp.id and (Transaction_Status__c='Success' or Transaction_Status__c='Manually Processed') and Transaction_Type__c!='Application Fee' order by createddate desc];
            
            List<FinanceStatementController.WrapObj> wrapList = new List<FinanceStatementController.WrapObj>();
            for(Finance_Transactions__c f : sList){
                wrapList.add(new FinanceStatementController.WrapObj(f.Transaction_Date_Time__c, currencyConvert(double.valueof(f.Amount_Received__c),f.CurrencyIsoCode,date.valueof(f.createddate)), f.Transaction_Type__c, opp.program__r.CurrencyIsoCode));
            }
            return wrapList;
      }
      
      public class WrapObj {
          public DateTime d{get;set;}
          public String tType{get;set;}
          public double aRec{get;set;}
          public String ccode{get;set;}
          public WrapObj(Datetime d, double aRec, String tType, String ccode){
              this.d= d;
              this.aRec= aRec;
              this.tType = tType;
              this.ccode = ccode;
          }
      }
      
      public List<SelectOption> getInstallmentPlan(){
            
            List<SelectOption> options = new List<SelectOption>();
            Schema.DescribeFieldResult F = Opportunity_Finance__c.Installment_Plan__c.getDescribe();
            List<Schema.PicklistEntry> P = F.getPicklistValues();
            options.add(new SelectOption('','--Select--'));            
            for(Schema.PicklistEntry pickListvalues : P){            
            options.add(new SelectOption(pickListvalues.getvalue(),pickListvalues.getvalue()));
            }
            return options; 
    }
    
    public PageReference isSubmit(){
        if(Installment_Plan_c==null){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please select Hult Installment Plan'));
            return null;
        }

        try{
        oppfin.Installment_Plan__c = Installment_Plan_c;
        update oppfin;
        }
        catch(exception e){
            apexpages.addmessages(e);
        }
        return null;
    } 
    public Finance_Transactions__c ft;
    public string payMethod = 'PaytoStudy';
    public double amount;
     public PageReference PayToStudy1() {
        ft = new Finance_Transactions__c();
        ft.Finance__c = oppfin.id;
        ft.CurrencyIsoCode = ccode;
        ft.Transaction_Method__c = payMethod;
        ft.Transaction_Type__c = 'PtS 1st Payment';        
        try{
            insert ft;
            opp.PaytoStudy_Registration__c = true;
            update opp;                    
        }
        catch(exception e){
            apexpages.addmessages(e);        
            return null;
        }
        PageReference acctPage = System.Page.PayToStudy;
      acctPage.getParameters().put('payid',ft.id);
       acctPage.getParameters().put('ins','1');
      acctPage.setRedirect(true);
      return acctPage;
        //return Page.PayToStudy;
    }
    
    public PageReference PayToStudy2() {
        ft = new Finance_Transactions__c();
        ft.Finance__c = oppfin.id;
        ft.CurrencyIsoCode = ccode;
        ft.Transaction_Method__c = payMethod;
        ft.Transaction_Type__c = 'PtS 2nd Payment';        
        try{
            insert ft;
            opp.PaytoStudy_Registration__c = true;     
            update opp; 
             
        }
        catch(exception e){
            apexpages.addmessages(e);        
            return null;
        }
      PageReference acctPage = System.Page.PayToStudy;
      acctPage.getParameters().put('payid',ft.id);
      acctPage.getParameters().put('ins','2');
      acctPage.setRedirect(true);
      return acctPage;
        //return Page.PayToStudy;
    }
    
    public string setnumber(string num){
        if(integer.valueof(num)<9){
            return '0'+num;
        }
        return num;
    }
    
    public string getpaytoStudyURL(){    
        String getData;
        paytostudyAmount =0;
        string ft = System.currentPagereference().getParameters().get('payid');
        if(System.currentPagereference().getParameters().get('ins')!=null && System.currentPagereference().getParameters().get('ins')=='1'){
            paytostudyAmount= paytostudyAmount1;
        }
        else{
            paytostudyAmount = paytostudyAmount2;
        }
        getData ='?external_unique_id='+ft+'&cu_id_number='+opp.App_ID__c+'&title='+user.contact.Salutation.replace('.','')+'&first_name='+user.contact.firstname+'&last_name='+user.contact.lastname+'&__date_of_birth_day='+setnumber(string.valueof(user.contact.Birthdate.day()))+'&__date_of_birth_month='+setnumber(string.valueof(user.contact.Birthdate.month()))+'&__date_of_birth_year='+user.contact.Birthdate.year()+'&email='+user.contact.email+'&suburban_city='+user.contact.Mailingcity+'&country='+user.contact.Mailing_Country__r.Country_Code_for_PaytoStudy__c+'&home_address='+EncodingUtil.urlEncode(user.contact.MailingStreet+'\n'+user.contact.mailingpostalcode+'\n'+user.contact.Mailingstate, 'UTF-8')+'&__home_phone_number_international_dialing_code='+user.contact.Mailing_Country__r.Country_Code__c.toLowerCase()+' '+user.contact.Mailing_Country__r.Calling_Code__c+'&__home_phone_number_mobile_phone='+user.contact.Mobile_Phone_Main_Number__c+'&__mobile_number_international_dialing_code='+user.contact.Mailing_Country__r.Country_Code__c.toLowerCase()+' '+user.contact.Mailing_Country__r.Calling_Code__c+'&__mobile_number_mobile_phone='+user.contact.Home_Phone_Main_Number__c+'&__tuition_fees_price='+paytostudyAmount;
        if(opp.program__r.CurrencyIsoCode== 'GBP'){
            return 'https://hult-uk.studentfees.com/'+getData;
        }
        else if(opp.program__r.CurrencyIsoCode== 'USD'){
            return 'https://hult-usd.studentfees.com/'+getData;
        }
        else if(opp.program__r.CurrencyIsoCode== 'AED'){
            return 'https://hult-aed.studentfees.com/'+getData;
        }
        else if(opp.program__r.CurrencyIsoCode== 'CNY'){
            return 'https://hult-cny.studentfees.com/'+getData;
        }
        return null;
    }     
}