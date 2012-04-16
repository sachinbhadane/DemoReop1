// Class for Attach Documents and test class TestForApplicantDocumentsController
public without sharing class ApplicantDocumentsController {
public User user{get;set;}
public String nomap{get;set;}
public Requirement__c hist{get;set;}
public List<Requirement__c> elist{get;set;}
public Attachment attach{get;set;}
public recordType rectype;
public List<recordType> recid;
public string query{get;set;}
public boolean isdoc{get;set;}
public List<Requirement__c> hisList{get;set;}
public Opportunity opp{get;set;}
public boolean tab2{get;set;}
public String val{get;set;}
public string rectypeid{get;set;}
public String recName{get;set;}
public string reqtype{get;set;}
public boolean Paid_Application_Fee_c{get;set;}
public boolean finalsubmit{get;set;}
     // Create constructor
    public ApplicantDocumentsController ()
    {
            attach = new Attachment();
            nomap='No map';
            user = [SELECT contact.id, contact.Sponsor_Of_Education__c, 
            contact.Sponsor_Employer_or_Organization__c, 
            contact.Sponsor_Contact_Person__c, contact.Sponsor_Job_Title__c,
            contact.Sponsor_Address__c, contact.Sponsor_Phone_Number__c,
            contact.Sponsor_Fax_Number__c FROM User WHERE id = :UserInfo.getUserId()];
                try
                {
                 elist=[select name, id,recordtypeid,RecordType.name,(select id,description from attachments) from Requirement__c where contact__c=:user.contact.id and recordType.name!='Recommendation']; 
                 hisList = new List<Requirement__c>();
                 for(Requirement__c h : elist)
                 {
                     if(h.attachments.size() != 0)
                     hisList.add(h);       
                }
                
               } 
               catch(exception e)
              {
                elist=new List<Requirement__c>();
              }  
            try{
             opp=[select Program_and_Location_Tab_Complete__c, Attachments_Tab_Complete__c, id from Opportunity where contact__c=:user.contact.id limit 1];
                     if(opp.Program_and_Location_Tab_Complete__c==true)
                     {
                        tab2=true;
                     }
                } 
            catch(exception e) 
                {
                    Opportunity opp = new Opportunity();
                } 
       hist = new Requirement__c();
        // to lock visualforce page----
                 try{
                 ApplicantFinalController contrl= new ApplicantFinalController();
                 contrl.getopp();
                 Paid_Application_Fee_c=ApplicantFinalController.Paid_Application_Fee_c;
                  finalsubmit=ApplicantFinalController.finalsubmit;
                 }
                 catch(exception e){} 
                        
    }

   // Set Attachments_Tab_Complete__c flg false if no attachment 
    public void updateflag()
    {
    elist=[select name, id,recordtypeid,RecordType.name,(select id,description from attachments)
             from Requirement__c where contact__c=:user.contact.id and recordType.name!='Recommendation']; 
             hisList = new List<Requirement__c>();
             for(Requirement__c h : elist){
             if(h.attachments.size() != 0)
                 hisList.add(h);       
                    }
        if(hisList.size()==0)
        {
        try{
        opp=[select Attachments_Tab_Complete__c, id from Opportunity where contact__c=:user.contact.id limit 1];                
        opp.Attachments_Tab_Complete__c=false;
        update opp;} catch(exception e){}
        }
    }

        // Get record type of requirement object
        public pagereference getreclist1() 
        {       
        if((hist.name=='CAS Request Form') || (hist.name=='I-94') || (hist.name=='Proof of Financial Means') || (hist.name=='Scan of Current Passport') || (hist.name=='Student Enrollment Contract') || (hist.name=='Student Visa Checklist')){
        recName='Visa';
        }
        else if(hist.name=='Undergraduate Transcript'){
        recName='Transcript';
        }
        else if((hist.name=='Statement of Purpose') || (hist.name=='High School Diploma') || (hist.name=='Current Resume') ){
        recName='Other';
        }
        else if((hist.name=='Professional Recommendation (2 of 2)') || (hist.name=='Professional Recommendation (1 of 2)') ){
        recName='Recommendation';
        }
        else if((hist.name=='Language Proficiency') || (hist.name=='Graduate Test') ){
        recName='Exam';
        }
        rectype=[select id from recordType where name=:recName and sobjecttype='Requirement__c'];
        isdoc=true;
        rectypeid=rectype.id;
        return null;
        }

        // get exam Requirment list
        public List<SelectOption> options{get;set;}
            
        public pagereference getexamtype() 
        {
                    options= new List<SelectOption>();
                    options.add(new SelectOption('','-Select-'));
                    try{
                    List<Requirement__c> req;                    
                    if(reqtype=='Visa'){
                    req=[select name from Requirement__c where  Opportunity__c=:opp.id and recordtype.name!='Sponsorship' and recordtype.name!='Recommendation' and (recordtype.name='Visa' or name='Proof of Funds - Birth Certificate') order by name asc] ;
                    }
                    else if(reqtype=='Admissions'){
                    req=[select name from Requirement__c where  Opportunity__c=:opp.id and recordtype.name!='Sponsorship' and recordtype.name!='Recommendation' and recordtype.name!='Visa' and name !='Proof of Funds - Birth Certificate' order by name asc] ;
                    }
                    for(Requirement__c i : req){
                    options.add(new SelectOption(i.name,i.name));
                    }} catch(exception e){system.debug('#####'+e);}
                   return null;
         }
    // Attach document
    public pagereference saveandcontinue()
    {
   if((System.currentPagereference().getParameters().get('saveandc')!=null) && (reqtype==null) && (hist.name==null) && (attach.description==null) && (attach.body==null))
   {
      return page.ApplicantPayment;
   }
   
   
   if(reqtype==null)
      {
       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please select Requirements Type'));
      }
    if(hist.name==null)
      {
       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please select Document Type'));
      }
      //if(attach.description==null)
      //{
       //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter Description'));
      //}
      if(attach.body==null)
      {
       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please Choose a File'));
      }
    
      if(!apexpages.hasmessages()) 
      { 
    Requirement__c hist1; 
    try{
    hist1=[select Supplied__c, id,name,contact__c,Opportunity__c,recordtypeid from Requirement__c where name=:hist.name and Opportunity__c=:opp.id];
    } catch (exception e){hist1=new Requirement__c(); }
        hist1.name=hist.name;
        hist1.Supplied__c=true;
        hist1.contact__c=user.contact.id;
        hist1.Opportunity__c=opp.id;
        upsert hist1;
       
        attach.parentId = hist1.id;
        
        attach.name = attach.name;
        opp.Attachments_Tab_Complete__c=true;
        update opp; 
        
        try {
          insert attach;
        } catch (DMLException e) {
          ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading file'));
          return null;
        } finally {
          attach.body = null; 
          attach= new Attachment();
        }
    
            
                PageReference page;
                if(Paid_Application_Fee_c)
                page = System.Page.ApplicantFinal;
                else
                page = System.Page.ApplicantPayment;
                page.setRedirect(true);
                return page;
            
           
    }
    else {
    return null;
    }
    }
    // Delete attachment
    public pagereference delattachment()
    {
    attachment at=[select id from attachment where id=:System.currentPagereference().getParameters().get('att')];
    delete at;
    Requirement__c hist1;
    
    hist1=[select Supplied__c, id from Requirement__c where id=:System.currentPagereference().getParameters().get('rid')];
    hist1.Supplied__c=false;
    update hist1;
    
    PageReference page = System.Page.ApplicantDocuments;
            page.setRedirect(true);
            return page;
    }
public PageReference saveandcontinueandlogout() {
        if (saveandcontinue() == null)
            return null; // step2() returning null means there were errors, so drop back to the page.
        return new PageReference('/secur/logout.jsp');
    }
    public PageReference saveand() {
        if (saveandcontinue() == null)
            return null; // step2() returning null means there were errors, so drop back to the page.
            PageReference page;
           /* if(Paid_Application_Fee_c)
            page = System.Page.ApplicantFinal;
            else 
            page = System.Page.ApplicantPayment;
            page.setRedirect(true);
            return page;*/
            page = System.Page.applicantdocuments;
            page.setRedirect(true);
            return page;
            
    }
    
    public PageReference attachdocssaveand() {
        if (saveandcontinue() == null)
            return null; // step2() returning null means there were errors, so drop back to the page.
            PageReference page;           
            page = System.Page.attachdocs;
            page.setRedirect(true);
            return page;
            
    }
    
    public pagereference attachdocsaveandcontinue(){
        if(attachdocssaveand() == null){
            return null;
        }
        else{
           // return page.FinanceStatement;
           return page.applicantaccountdetails;
            /*PageReference page;           
            page = System.Page.attachdocs;
            page.setRedirect(true);
            return page;*/
        }
    }
   public pagereference attachdocsdelattachment(){
       if(delattachment()==null){
           return null;
       }
       else{
           PageReference page;           
            page = System.Page.attachdocs;
            page.setRedirect(true);
            return page;
           
       }
   } 
 
}