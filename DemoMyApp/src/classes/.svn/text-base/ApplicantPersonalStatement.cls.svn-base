// Class for Final Submission and test class TestForApplicantPersonalStatement
public without sharing class ApplicantPersonalStatement{
        User user;
        public Opportunity opp{get;set;}
        public static boolean Essay_Tab_Complete_c{get;set;}
        public static string contactid;
        public static boolean finalsubmit{get;set;}
        public boolean tab2{get;set;}
        public boolean tab4{get;set;}
        public String proName{get;set;}
        public boolean isEMBA{get;set;}
        public ApplicantPersonalStatement(){getopp();
        // to lock visualforce page----
                 try{
                 ApplicantFinalController contrl= new ApplicantFinalController();
                 contrl.getopp();
                 proName=contrl.proName;
                 finalsubmit=ApplicantFinalController.finalsubmit;}
                 catch(exception e){}
        }

        
        
        public PageReference  getopp(){
            User user1 = [SELECT contact.id from user WHERE id = :UserInfo.getUserId()];
            contactid=user1.contact.id;
            Opportunity opp=new Opportunity();
            try{
            opp=[select Primary_Program_Choice__c, Program_and_Location_Tab_Complete__c, Essay_Tab_Complete__c from Opportunity where Contact__c=:contactid ];
                  Essay_Tab_Complete_c=opp.Essay_Tab_Complete__c;  
                  if(opp.Primary_Program_Choice__c=='Executive MBA'){
                      isEMBA = true;
                  }                
                 {tab2=true;} 
                 if(opp.Program_and_Location_Tab_Complete__c==true)
                 {tab4=true;} 
            }catch(Exception e) {
            finalsubmit=false;
                       // ApexPages.addMessages(e);
                    }
             return null;
        }
        
        
        public static PageReference eassysaveandcontinue(){
        if(Essay_Tab_Complete_c==false){
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please check \'Please check the box to the right to affirm that you have read and understand the Personal Statment/Essay Requirement\''));
        }
        
        if(!apexpages.hasmessages()) {
        User user1 = [SELECT contact.id from user WHERE id = :UserInfo.getUserId()];
        contactid=user1.contact.id;
        Opportunity opp1=new Opportunity();
        try{
        opp1=[select Essay_Tab_Complete__c from Opportunity where Contact__c=:contactid ];
        opp1.Essay_Tab_Complete__c=Essay_Tab_Complete_c;
        //opp1.Final_Submission_Tab_Complete__c=true;
        update opp1;
       // finalsubmit=true;
        //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.confirm,'Application has been submitted successfully '));
        }catch(exception e){
              
              }
        try
        {
        Requirement__c rc=[select Essay_Requirement_Affirmation__c from Requirement__c where recordtype.name='Essay' and Opportunity__c=:opp1.id limit 1];
        rc.Essay_Requirement_Affirmation__c=true;
        update rc;
        }
        catch(exception e){}      
             
        }
        else
        {
        return null;
        }
         //return page.ApplicantReferenceDetail;
         return page.ApplicantPayment;
        }

  public PageReference eassysaveandcontinueandlogout() {
        if (eassysaveandcontinue() == null)
            return null; // eassysaveandcontinue() returning null means there were errors, so drop back to the page.
        return new PageReference('/secur/logout.jsp');
    }  
    

}