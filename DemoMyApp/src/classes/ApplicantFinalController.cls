// Class for Final Submission and test class TestForApplicantFinalController
public without sharing class ApplicantFinalController{
        User user;
        public Opportunity opp{get;set;}
        public static string Applicant_Confirmation_c{get;set;}
        public static string contactid;
        public static boolean finalsubmit{get;set;}
        public boolean tab2{get;set;}
        public ApplicantFinalController(){getopp();}
        public static boolean Paid_Application_Fee_c{get;set;}
        public String proName{get;set;}  
        public static string sucMessages; 
        public List<SelectOption> getItems() {
                    List<SelectOption> options = new List<SelectOption>();
                    options.add(new SelectOption('','--Select--'));
                    options.add(new SelectOption('Yes','Yes'));
                    options.add(new SelectOption('No','No'));
                    
                    return options;
                }
        
        public PageReference  getopp(){
            User user1 = [SELECT contact.id from user WHERE id = :UserInfo.getUserId()];
            contactid=user1.contact.id;
            Opportunity opp=new Opportunity();
            try{
            opp=[select Program__r.Name,  Paid_Application_Fee__c, Program_and_Location_Tab_Complete__c, Applicant_Confirmation__c from Opportunity where Contact__c=:contactid ];
                  Applicant_Confirmation_c=opp.Applicant_Confirmation__c;
                  Paid_Application_Fee_c=opp.Paid_Application_Fee__c;
                  proName=opp.Program__r.Name;
                  if(Applicant_Confirmation_c=='Yes'){finalsubmit=true;} else {finalsubmit=false;}
                   if(opp.Program_and_Location_Tab_Complete__c==true)
                 {tab2=true;}  
            }catch(Exception e) {
            finalsubmit=false;
                       // ApexPages.addMessages(e);
                    }
             return null;
        }
        
        
        public static PageReference finalsaveandcontinue(){
        if(Applicant_Confirmation_c==null){
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please select a Confirmation'));
        }
        if((Applicant_Confirmation_c !=null) && Applicant_Confirmation_c.trim()=='No'){
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'You must select \'Yes\' to submit your application'));
        }if(!apexpages.hasmessages()) {
        User user1 = [SELECT contact.id from user WHERE id = :UserInfo.getUserId()];
        contactid=user1.contact.id;
        Opportunity opp1=new Opportunity();
        try{
        opp1=[select Applicant_Confirmation__c from Opportunity where Contact__c=:contactid ];
        opp1.Applicant_Confirmation__c=Applicant_Confirmation_c;
        opp1.Final_Submission_Tab_Complete__c=true;
        update opp1;
        finalsubmit=true;
        sucMessages ='Your application has been successfully submitted!<br /><br />';
                      sucMessages += 'To complete your application you will need to provide the documents required by the Hult admission committee. The required documents differ by program and our admission support team will'; 
                      sucMessages += '&nbsp;contact you shortly regarding what is needed in your specific case. You may be asked to supply documents such as:<br /><br />';                                     
                      sucMessages += '&bull;Statement of Purpose/Personal Statement<br />'; 
                      sucMessages += '&bull;CV/Resume<br />'; 
                      sucMessages += '&bull;Exam results (GMAT,GRE,SAT,TOEFL, etc)<br />'; 
                      sucMessages += '&bull;Transcripts (Undergraduate, high school, etc)<br />'; 
                      sucMessages += '&bull;References/Letters of Recommendation<br /><br />'; 
                      sucMessages += 'We look forward to working with you on the completion of your application to Hult<br />'; 

        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.confirm,sucMessages));
        }catch(exception e){
              
              }
             
        }
        else
        {
        return null;
        }
         return page.ApplicantFinal;
        }

  public PageReference finalsaveandcontinueandlogout() {
        if (finalsaveandcontinue() == null)
            return null; // saveandcontinue() returning null means there were errors, so drop back to the page.
        return new PageReference('/secur/logout.jsp');
    }  
    

}