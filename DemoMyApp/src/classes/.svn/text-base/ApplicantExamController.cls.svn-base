// Class for Exam Infromation and test class name TestForApplicantExamController
public without sharing class ApplicantExamController {
        public User user;
        public Exam__c hist{get;set;}
        //public History__c gethist(){return hist;}
        public List<Exam__c> elist{get;set;}
        public String nomap{get;set;}
        public recordType recid;
        public boolean isedit{get;set;}
        public Opportunity opp{get;set;}
        public boolean tab4{get;set;}
        public boolean finalsubmit{get;set;}
        public String Planned_Test_Date_day{get;set;}
        public string Planned_Test_Date_month{get;set;}
        public string Planned_Test_Date_year{get;set;}
        public String Exam_Date_day{get;set;}
        public string Exam_Date_month{get;set;}
        public string Exam_Date_year{get;set;}
        Date pdate;
        Date edate;
        public string saveandc;
        //public string getnomap(){return nomap;}{set;}
        public ApplicantExamController()
        {
        user = [SELECT contact.id FROM User
                        WHERE id = :UserInfo.getUserId()];
        try{
                 opp=[select Employment_Tab_Complete__c, Program_and_Location_Tab_Complete__c, id from Opportunity where contact__c=:user.contact.id limit 1];
                    if(opp.Program_and_Location_Tab_Complete__c){tab4=true;}
                    elist=allrecord();
                    } catch (exception e) {Opportunity opp = new Opportunity();} 
        hist=new Exam__c();
        
         // to lock visualforce page----
                 try{
                 ApplicantFinalController contrl= new ApplicantFinalController();
                 contrl.getopp();
                 finalsubmit=ApplicantFinalController.finalsubmit;}
                 catch(exception e){}
        } 
        
        public list<Exam__c> allrecord()
        {
        recid=[select id from recordtype where name='Exam' and sobjectType='History__c'];
        
         user = [SELECT contact.id FROM User WHERE id = :UserInfo.getUserId()];
               
                 elist=[select id,name, Exam_Type__c, NeedofTest__c,Planned_Test_Date__c,
                 Planned_Test_Location__c,TakenTest__c,Exam_Score__c,Exam_Location__c,
                 Exam_Date__c from Exam__c where Application__c=:opp.id order by createddate desc];
              
        return elist;
        }
        
        public pagereference saveandcontinue()
        {
            saveandc=System.currentPagereference().getParameters().get('saveandc');
            if((saveandc!=null) && (hist.Exam_Type__c==null))
            {
                 return page.ApplicantSponsorship;
            }
                if(hist.Exam_Type__c==null)
                    {
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please select Test'));
                    }
                    
                    if(hist.NeedofTest__c == true )
                    {
                        if((Planned_Test_Date_day.trim()=='') || (Planned_Test_Date_month.trim()=='') || (Planned_Test_Date_year.trim()==''))
                        {
                            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter Planned Test Date '));
                        
                        }
                        else
                        {
                        try{
                        pdate=date.valueof(Planned_Test_Date_year+'-'+Planned_Test_Date_month+'-'+Planned_Test_Date_day);
                             }
                         catch(exception e)
                         {
                         ApexPages.addMessages(e);
                          
                         }
                        }
                        
                                            
                        if(pdate < date.today())
                        {
                            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Planned Test Date should not less than today date '));
                        }
                        /* 
                        if(hist.Planned_Test_Location__c==null)
                        {
                            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter Test Location '));
                        }
                        */  
                    }
                    
                    if(hist.TakenTest__c== true)
                     {
                        if((Exam_Date_day.trim()=='') || (Exam_Date_month.trim()=='') || (Exam_Date_year.trim()==''))
                        {
                            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter Date Taken'));
                        }
                        else
                        {
                        try{
                        edate=date.valueof(Exam_Date_year+'-'+Exam_Date_month+'-'+Exam_Date_day);
                             }
                         catch(exception e)
                         {
                         ApexPages.addMessages(e);
                          
                         }
                        }
                        if(edate > date.today())
                        {
                            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Date Taken should not greater than today date'));
                        }
                         /*   
                        if(hist.Exam_Location__c==null)
                        {
                            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter Test Location'));
                        }  
                        
                        */      
                           if(hist.Exam_Score__c==null)
                        {
                            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter Test Score'));
                        }   
                     }     
                             
                     if(((hist.TakenTest__c == false) && (hist.NeedofTest__c == false) && (hist.Exam_Type__c!= 'No test required')))
                     {
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please select either I need to take my test or I have already taken my test '));
                     }
                                                       
                 if(!apexpages.hasmessages()) 
                 {  
                    try{
                    hist.Planned_Test_Date__c=pdate;
                    hist.Exam_Date__c=edate;
                    hist.Application__c=opp.id;
                    upsert hist;
                    }
                    catch(dmlexception e)
                    {
                    ApexPages.addMessages(e);
                    return null;
                    }
                    opp.Exam_History_Tab_Complete__c=true;
                    update opp;
                    hist=new Exam__c();
                    elist=allrecord();
                    
                    if(isedit==true){
                    isedit=false;
                    return null;
                    }else {
                    isedit=false;
                    return page.ApplicantSponsorship;}
                }
                else
                {
                    return null;
                }
             
            
     }
     public void edit()
     {
        hist=[select id,name, Exam_Type__c,NeedofTest__c,Planned_Test_Date__c,
        Planned_Test_Location__c,TakenTest__c,Exam_Score__c,Exam_Location__c,
        Exam_Date__c from Exam__c where id=:System.currentPagereference().getParameters().get('hid') order by createddate desc];
        isedit=true;
        if(hist.Planned_Test_Date__c!=null)
        {
            Planned_Test_Date_day=string.valueof(hist.Planned_Test_Date__c.day());
            Planned_Test_Date_month=string.valueof(hist.Planned_Test_Date__c.month());
            Planned_Test_Date_year=string.valueof(hist.Planned_Test_Date__c.year());
        }
        if(hist.Exam_Date__c!=null)
        {
            Exam_Date_day=string.valueof(hist.Exam_Date__c.day());
            Exam_Date_month=string.valueof(hist.Exam_Date__c.month());
            Exam_Date_year=string.valueof(hist.Exam_Date__c.year());
        }
      }
      
      public void hisdelete()
      {
        hist=[select id from Exam__c where id=:System.currentPagereference().getParameters().get('hid') order by createddate desc];
        delete hist;
        hist=new Exam__c();
        elist=allrecord();
        if(elist.size()==0){
        opp.Exam_History_Tab_Complete__c=false;
        update opp;}
        isedit=false;
       }
        
       public void cancel()
       {
        hist=new Exam__c();
        elist=allrecord();
        isedit=false;
       }
       public PageReference saveandcontinueandlogout() {
        if (saveandcontinue() == null)
            return null; // step2() returning null means there were errors, so drop back to the page.
        return new PageReference('/secur/logout.jsp');
    }
    public PageReference saveandsave() {
        if ((saveandcontinue() == null))
            return null; // step2() returning null means there were errors, so drop back to the page.
        //return Page.ApplicantExamInfo;
        return null;
    }
    
    public PageReference Onlinesaveandcontinue(){
        if ((saveandcontinue() == null))
            return null; // step2() returning null means there were errors, so drop back to the page.
        return Page.CheckReverences;
        
    }
}