public without sharing class ApplicantPaymentController{
public User user{get;set;}
public boolean tab2{get;set;}
public Opportunity opp{get;set;}
public string Program_c{get;set;}
public Integer amount{get;set;}
public double amount1{get;set;}
public string appid{get;set;}
public boolean Paid_Application_Fee_c{get;set;}
public boolean isfinanceRecord{get;set;}
public string Merchant_ID_c{get;set;}
public string Validation_Code_c{get;set;}
public string App_ID_c{get;set;}
public String url=site.getCurrentSiteUrl();
public Opportunity_Finance__c f{get;set;}
public string financeID{get;set;}
public double Deposit_Amount_Due_FS_c{get;set;}
public boolean Confirmation_Deposit_Paid_c{get;set;}
public boolean I_agree_to_Hult_Terms_and_Conditions_c{get;set;}
public boolean I_agree_to_Terms_Cond_for_App_Fee_c{get;set;}
public double Payment_Amount_1st_c{get;set;}
public double Payment_Amount_2nd_c{get;set;}
//public double txnAmount{get;set;}
public string ccode{get;set;} 
public string ftname{get;set;}
public string btnLable{get;set;}
public integer paymentType{get;set;}
public string geturl()
{
return url;
}
    public ApplicantPaymentController()
    {
            btnLable = 'Go';
            paymentType = 1;
            user = [SELECT contact.id, contact.Sponsor_Of_Education__c, 
            contact.Sponsor_Employer_or_Organization__c, 
            contact.Sponsor_Contact_Person__c, contact.Sponsor_Job_Title__c,
            contact.Sponsor_Address__c, contact.Sponsor_Phone_Number__c,
            contact.Sponsor_Fax_Number__c FROM User  WHERE id = :UserInfo.getUserId()];
             
            try{
                     opp=[select Program__r.Confirmation_Deposit__c, Primary_Program_Choice__c, Program_Currency__c, CurrencyIsoCode, Primary_Campus__c, Paid_Application_Fee__c, Program__r.name, id,Program_and_Location_Tab_Complete__c from Opportunity where contact__c=:user.contact.id limit 1];
                     if(opp.Program_and_Location_Tab_Complete__c==true)
                     {
                         tab2=true;
                     }
                     
                     getamount(opp.Program__r.name);
                     Program_c=opp.Program__r.name;
                     Paid_Application_Fee_c=opp.Paid_Application_Fee__c;
                     appid=opp.id;     
                    if (opp.Primary_Campus__c=='London'){
                        ccode= 'GBP';
                    }
                    else{
                        ccode= 'USD';
                    }
                

                     
           } 
            catch (exception e){
                Opportunity opp = new Opportunity();
           } 
        
    }
    
    public void createFinaceRecord(){        
            try{
            // Get Fincce Record
                f= [select I_agree_to_Terms_Cond_for_App_Fee__c, Payment_Amount_1st__c,Payment_Amount_2nd__c, I_agree_to_Hult_Terms_and_Conditions__c, id,Deposit_Amount_Due_FS__c,Confirmation_Deposit_Paid__c,Course_Deposit_Paid__c from Opportunity_Finance__c where Opportunity__c=:opp.id];                            
            }
            catch(exception e){
                //apexpages.addmessages(e);
                f = new Opportunity_Finance__c();
                f.Opportunity__c=opp.id;

                // SJ: Currency copy wasn't working for some reason. Comented for now. Jim will write work flow
                f.CurrencyIsoCode = opp.Program_Currency__c;            

                insert f;              
            }
            isfinanceRecord =true;
            financeID = f.id;
            Deposit_Amount_Due_FS_c = f.Deposit_Amount_Due_FS__c;  
            //Confirmation_Deposit_Paid_c = f.Confirmation_Deposit_Paid__c;
            I_agree_to_Hult_Terms_and_Conditions_c = f.I_agree_to_Hult_Terms_and_Conditions__c;
            I_agree_to_Terms_Cond_for_App_Fee_c = f.I_agree_to_Terms_Cond_for_App_Fee__c; 
            termtypev = f.I_agree_to_Terms_Cond_for_App_Fee__c;   
            if(f.Course_Deposit_Paid__c > 0){
                    btnLable = 'Pay Remaining Payment';
                    paymentType = 2;
            } 
            if(double.valueof(opp.Program__r.Confirmation_Deposit__c) <= double.valueof(f.Course_Deposit_Paid__c)){
                Confirmation_Deposit_Paid_c = true;
            }       
            
    }
    
    public Finance_Transactions__c ft;
    public Pagereference createFinancetxn(){
        if(ccode==null){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please Select Currency'));
        }
        if (I_agree_to_Hult_Terms_and_Conditions_c==false){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please Check I agree to Hult Terms and Conditions'));
        }
        if(apexpages.hasmessages()){
            return null;
        } 
        ft = new Finance_Transactions__c();
        ft.Finance__c = financeID;
        ft.CurrencyIsoCode = ccode;
        ft.Transaction_Method__c = 'CC Charged Via Salesforce';
        ft.Transaction_Type__c = 'Confirmation Deposit';        
        try{
        insert ft;
        // Set term and condition flag of Finance
        f.I_agree_to_Hult_Terms_and_Conditions__c = I_agree_to_Hult_Terms_and_Conditions_c;
        update f;
        }
        catch(exception e){
        apexpages.addmessages(e);        
        }
        ftname = ft.id;
                       
        //return null;
        return page.PayConfirmationDeposit;

    }
    
    //public double amount;
    public double txnAmount1{get;set;}
    public integer gettxnAmount(){    
        txnAmount1= [select OP_Deposit_Amount_Du__c from Finance_Transactions__c where id=:ft.id limit 1].OP_Deposit_Amount_Du__c;        
        return integer.valueof(txnAmount1*100);        
    }
    
    public string gettxnUrl(){
        if (ccode==null){
        ccode = 'USD';
        }
        return [select Gateway_URL__c from SixCards_Gateway_URL__c where CurrencyIsoCode=:ccode limit 1].Gateway_URL__c;
    }
    
    public string gettncURL(){
        List<string> prcode = Program_c.split('-');
        if(prcode[0]=='Bachelor of International Business Administration'){
            return 'http://www.hult.edu/en/Programs/Bachelor/Admissions/Terms-and-Conditions/~/media/2AA8E3048E4A49B0B9C997E972144B64.pdf';
        }
        else if(prcode[0]=='MBA'){
            return 'http://www.hult.edu/en/Programs/MBA/Admissions/Terms-and-Conditions/~/media/FE1CF42676AF41EB87D1230D597A4E02.pdf';
        }
        else if(prcode[0]=='EMBA' || prcode[0]=='EMBAm' || prcode[0]=='EMBAw'){
            return 'http://ak-media.hult.edu/~/media/Hult/Downloads/Files/Hult-EMBA-Terms-and-Conditions.pdf';
        }
        else if(prcode[0]=='MIB'){
            return 'http://www.hult.edu/en/Programs/Master/International-Business/Admissions/Terms-and-Conditions/~/media/7D2D704086564A0F8C3E724632034F1A.pdf';
        }
        else if(prcode[0]=='MFIN'){
            return 'http://www.hult.edu/en/Programs/Master/Finance/Admissions/Terms-and-Conditions/~/media/7D2D704086564A0F8C3E724632034F1A.pdf';
        }
        else if(prcode[0]=='MIM'){
            return 'http://www.hult.edu/en/Programs/Master/International-Marketing/Admissions/Terms-and-Conditions/~/media/7D2D704086564A0F8C3E724632034F1A.pdf';
        }
        else if(prcode[0]=='MSE'){
            return 'http://www.hult.edu/en/Programs/Master/Social-Entrepreneurship/Admissions/Terms-and-Conditions/~/media/7D2D704086564A0F8C3E724632034F1A.pdf';
        }
        else {
            return '#';
        }
    }
    
    public string getproblemURL(){
        string url=null;
        document[] att =[select id from document where name='PDF - HULT HOW TO PAY YOUR CONF. DEP VIA WIRE TRANSFER 2012 DRAFT.pdf' limit 1];
        if(att.size()>0){
        url = 'servlet/servlet.FileDownload?file='+att[0].id;
        }
        return url;
    
    }
    
    /* public List<SelectOption> getCurrencyIsoCode() 
    {
    
        List<SelectOption> options = new List<SelectOption>();
        Schema.DescribeFieldResult F = Finance_Transactions__c.CurrencyIsoCode.getDescribe();
        List<Schema.PicklistEntry> P = F.getPicklistValues();
        options.add(new SelectOption('','--Select--'));            
        for(Schema.PicklistEntry pickListvalues : P){
            if(pickListvalues.getvalue()=='USD' || pickListvalues.getvalue()=='GBP')
        options.add(new SelectOption(pickListvalues.getvalue(),pickListvalues.getvalue())); 
        }
        return options; 
    }  */

public void getamount(String pname)
{
string acname;
Application_Fee_Merchant_Services__c afee;
list<string> pn=pname.split('-');
acname=pn[0];
if(acname=='Bachelor of International Business Administration')
{
acname='BIBA';
}
else if((acname=='EMBAm') || (acname=='EMBAw'))
{
acname='EMBA';
}
try{
afee=[select Merchant_ID__c,Validation_Code__c, Application_Fee__c from Application_Fee_Merchant_Services__c where name=:acname];
amount=Integer.valueof(afee.Application_Fee__c*100);
amount1=afee.Application_Fee__c;
Merchant_ID_c=afee.Merchant_ID__c;
Validation_Code_c=afee.Validation_Code__c;
}
catch(exception e){
apexpages.addmessages(e);
}
}

public pagereference saveandcontinue()
{
return null;
            
}
public PageReference saveandcontinueandlogout() {
        if (saveandcontinue() == null)
            return null; // step2() returning null means there were errors, so drop back to the page.
        return new PageReference('/secur/logout.jsp');
}
    
    public boolean termtypev{get;set;}
    public void applicationTerm(){
        Opportunity_Finance__c fnew= [select I_agree_to_Terms_Cond_for_App_Fee__c from Opportunity_Finance__c where Opportunity__c=:opp.id];            
        
       // termtypev = System.currentPagereference().getParameters().get('termtype');
        
        fnew.I_agree_to_Terms_Cond_for_App_Fee__c = termtypev;
        update fnew;    
        I_agree_to_Terms_Cond_for_App_Fee_c= fnew.I_agree_to_Terms_Cond_for_App_Fee__c;
    }
    public string getapplicationtncURL(){
       
        if(opp.Primary_Program_Choice__c=='Bachelor of International Business Administration'){
            return 'http://ak-media.hult.edu/~/media/Hult/Downloads/Files/Hult-BIBA-Terms-and-Conditions.pdf';
        }
        else if(opp.Primary_Program_Choice__c=='Master\'s Program'){
            return 'http://www.hult.edu/en/programs/master/social-entrepreneurship/admissions/terms-and-conditions/~/media/7D2D704086564A0F8C3E724632034F1A.pdf';
        }
        else if(opp.Primary_Program_Choice__c=='Master of Business Administration'){
            return 'http://ak-media.hult.edu/~/media/Hult/Downloads/Files/Hult-MBA-Terms-and-Conditions.pdf';
        }
        else if(opp.Primary_Program_Choice__c=='Executive MBA'){
            return 'http://ak-media.hult.edu/~/media/Hult/Downloads/Files/Hult-EMBA-Terms-and-Conditions.pdf';
        }       
        else {
            return '#';
        }
    }
    
    public List<SelectOption> getpaymentValues() {
        List<SelectOption> options = new List<SelectOption>(); 
        options.add(new SelectOption('1','Pay Full Confirmation Deposit')); 
        options.add(new SelectOption('2','Pay 1/2 Confirmation Deposit')); 
        return options; 
    }
    
}