// Class for Employment History and test class TestForApplicantEmploymentController
public without sharing  class ApplicantEmploymentController{
    public User user;
    public Employment__c hist1{get;set;}
    public List<Employment__c > elist{get;set;}
    public String nomap{get;set;}
    public recordType recid;
    public Opportunity opp{get;set;}
    public boolean isedit{get;set;}
    public boolean tab3{get;set;}
    public boolean finalsubmit{get;set;}
    public string empyear{get;set;}
    public string empmonth{get;set;}
    public double empyear1{get;set;}
    public double empmonth1{get;set;}
    public string DateFrom_day{get;set;}
    public string DateFrom_month{get;set;}
    public string DateFrom_year{get;set;}
    Date DateFrom;
    public string DateTo_day{get;set;}
    public string DateTo_month{get;set;}
    public string DateTo_year{get;set;}
    Date DateTo;
    // Code for country list 
 public List<SelectOption> getclist() {
 integer i=0;
        List<SelectOption> options = new List<SelectOption>();
        List<Country__c> cou=[select id,name from country__c order by name asc];
        options.add(new SelectOption('','Select'));            
        for(i=0;i<cou.size();i++){
        options.add(new SelectOption(cou[i].id,cou[i].name));            
        }


        return options;
    } 
        // Create Constructor 
        public ApplicantEmploymentController()
        {
        
        hist1= new Employment__c ();
        // Select current user
         user = [SELECT contact.id FROM User WHERE id = :UserInfo.getUserId()];                
                allrecord();
                 // Create opportunity object or select Opportunity record 
               try{
                     opp=[select Primary_Program_Choice__c, id,Program_and_Location_Tab_Complete__c from Opportunity where contact__c=:user.contact.id limit 1];
                   if(opp.Program_and_Location_Tab_Complete__c==true){tab3=true;}
                   
                   } 
               catch(exception e) 
                   {
                     Opportunity opp = new Opportunity();
                   }
            // to check final submission flag true for look application----
                     try{
                     ApplicantFinalController contrl= new ApplicantFinalController();
                     contrl.getopp();
                     finalsubmit=ApplicantFinalController.finalsubmit;}
                     catch(exception e){}        
        
        } 
          public list<Employment__c > allrecord()
        {
       elist=[select id,Name,Work_Experience_Years__c,Work_Experience_Months__c,Name__c, City__c,Address__c,
                     Country__r.name,ZipCode__c, EmploymentType__c, Position__c,Annual_Salary_In_USD__c,
                     ResponsibilitesOfJob__c, Company_Size__c,DateFrom__c, DateTo__c, isCurrent_Employer__c,
                     Industry_Sector__c from Employment__c where contact__c=:user.contact.id order by DateFrom__c desc];
                 if(elist.size()!=0){
                 empyear=string.valueof(elist[0].Work_Experience_Years__c);
                 empmonth=string.valueof(elist[0].Work_Experience_Months__c);
                 }
                 return elist;
        }
    
     // Method for update and create new employment histry and set Employment_Tab_Complete__c flag true
        public pagereference saveandcontinue()
        {
    
            if( opp.Primary_Program_Choice__c!='Master\'s Program' || hist1.Name__c!=null || hist1.City__c!=null || hist1.Address__c!=null || hist1.Country__c!=null || hist1.ZipCode__c!=null || (hist1.EmploymentType__c !=null && hist1.EmploymentType__c !='Select') || hist1.Position__c!=null || hist1.Annual_Salary_In_USD__c!=null || hist1.ResponsibilitesOfJob__c!=null || (hist1.Company_Size__c!=null && hist1.Company_Size__c!='Select') || DateFrom_month.trim()!='' || DateFrom_year.trim()!='' ||  DateTo_month.trim()!='' || DateTo_year.trim()!='' || (hist1.Industry_Sector__c!=null && hist1.Industry_Sector__c!='Select')){
            
                if((empyear=='0') && (empyear.trim()=='0') )
                  {
                       return page.ApplicantExamInfo;
                  }
                
                if((empyear==null) || (empyear.trim()=='') )
                  {
                       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter Total Employment Year'));
                  }
                  else
                  {
                      try
                      {
                          empyear1=integer.valueof(empyear);                 
                      } 
                      catch(exception e)
                      {
                          ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Invalid Total Employment Year'));
                      }
                  }
                  if((empmonth==null) || (empmonth.trim()==''))
                  {
                       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Total Employment Months'));
                  }
                  else
                  {
                      try
                      {                  
                          empmonth1=integer.valueof(empmonth);
                      } 
                      catch(exception e)
                      {
                          ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Invalid Total Employment Months'));
                      }
                  }
                  if(hist1.Name__c==null)
                  {
                       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter Employer'));
                  }  
                  if(hist1.City__c==null)
                  {
                       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter City'));
                  } 
                   if(hist1.Address__c==null)
                  {
                       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter Street Address'));
                  }            
                   if(hist1.Country__c==null)
                  {
                       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please select Country'));
                  }            
                   if(hist1.ZipCode__c==null)
                  {
                       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter Zip/Postcode'));
                  }   
                  
                  if(hist1.EmploymentType__c   ==null)
                  {
                       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please select Type of Employment'));
                  } 
                  if(hist1.Position__c==null)
                  {
                       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter Position/Job Title'));
                  }   
                  if(hist1.Annual_Salary_In_USD__c==null)
                  {
                       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter Annual Salary in USD $'));
                  }              
                  if(hist1.ResponsibilitesOfJob__c==null)
                  {
                       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter Summarize the overall responsibilities and nature of the job'));
                  }              
                  if(hist1.Company_Size__c==null)
                  {
                       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please select Company Size'));
                  }  
                  if((DateFrom_month.trim()=='') || (DateFrom_year.trim()==''))
                  {
                       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter Date Employed From (Month and Year)'));
                  }
                  else
                  {
                      try
                      {
                          DateFrom=date.valueof(DateFrom_year+'-'+DateFrom_month+'-'+1);
                      }
                      catch(exception e)
                      {
                          ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Invalid Date Employed From (Month and Year)'));
                      }
                  }  
                  if(((DateTo_month.trim()=='') || (DateTo_year.trim()=='')) && (hist1.isCurrent_Employer__c == false))
                  {
                       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter Date Employed To (Month and Year)'));
                  }
                  else
                  {
                      try
                      {     if (hist1.isCurrent_Employer__c) {
                                DateTo= null;
                            } else {
                                DateTo=date.valueof(DateTo_year+'-'+DateTo_month+'-'+1);
                            }
                      }
                      catch(exception e)
                      {
                          ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Invalid Date Employed To (Month and Year)'));
                      }
                  }
                    
                   if(DateTo < DateFrom)
                  {
                   ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Date Employed From (Month and Year) should not be greater than Date Employed To (Month and year)'));
                  }  
                
                 
                   if(hist1.Industry_Sector__c==null)
                  {
                       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please select Industry Sector'));
                  } 
                  
                 
                 if(!apexpages.hasmessages()) 
                  { 
                    
                    try{
                    opp.Employment_Tab_Complete__c=true;
                    update opp;      
                   
                    hist1.contact__c=user.contact.id;
                    hist1.Application__c=opp.id;
                    hist1.Work_Experience_Years__c=empyear1;
                    hist1.Work_Experience_Months__c=empmonth1;
                    hist1.DateTo__c=DateTo;
                    hist1.DateFrom__c=DateFrom;
                    upsert hist1;
                    DateTo_year='';
                    DateTo_month='';
                    DateFrom_year='';
                    DateFrom_Month='';
                    updateallyear(empyear,empmonth);
                    }
                    catch(dmlexception e){
                    ApexPages.addMessages(e);
                    return null;
                    }
                    elist=allrecord();
                    if(isedit==false){
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.confirm,'Employment History has been added'));
                    }
                    else
                    {
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.confirm,'Employment History has been updated'));
                    }
                    isedit=false;
                    
                    //hist1= new Employment__c ();
                    return page.ApplicantExamInfo;
                //return null;
                }
                else 
                {
                    isedit=false;
                    return null;
                }
           }
           else{
               return page.ApplicantExamInfo;
           
           }     
    }   
 public void updateallyear(String empyear ,string empmonth)
 {
 List<Employment__c> emp=[select Work_Experience_Years__c,Work_Experience_Months__c from Employment__c where Application__c=:opp.id order by createddate desc ];
 list<Employment__c> empnew = new list<Employment__c>();
    for(Employment__c con : emp)
    {
        con.Work_Experience_Years__c=integer.valueof(empyear);
        con.Work_Experience_Months__c=integer.valueof(empmonth);
        empnew.add(con);
    }
update empnew;   
 }
 
  public void edit()
  {
  isedit=true;
  hist1=[select id, Name,Work_Experience_Months__c,Work_Experience_Years__c,Name__c, City__c,Address__c,
                     Country__c,ZipCode__c, EmploymentType__c, Position__c,Annual_Salary_In_USD__c,
                     ResponsibilitesOfJob__c, Company_Size__c,DateFrom__c, DateTo__c, isCurrent_Employer__c,
                     Industry_Sector__c from Employment__c where id=:ApexPages.currentPage().getParameters().get('id')];
  
  if (hist1.DateTo__c != null) {
    DateTo_year=string.valueof(hist1.DateTo__c.year());
    DateTo_month=string.valueof(hist1.DateTo__c.month());
  }
  
  DateFrom_year=string.valueof(hist1.DateFrom__c.year());
  DateFrom_Month=string.valueof(hist1.DateFrom__c.month());                   
                
  }
 public void isDelete()
 {
 isedit=false;
 Employment__c emp=[select id from Employment__c where id=:ApexPages.currentPage().getParameters().get('id')];
 delete emp;
 ApexPages.addmessage(new ApexPages.message(ApexPages.severity.confirm,'Employment History has been deleted'));
elist=allrecord();                
 }
public void cancel()
{
isedit=false;
hist1= new Employment__c ();
} 

public pagereference saveandsave()
        {
        isedit=false;
        if(saveandcontinue()==null)
       { return null;} else {isedit=false;
hist1= new Employment__c ();
 return null;
}
}
public pagereference saveandedit()
        {
        
        if(saveandcontinue()==null)
       { 
       isedit=true;
       return null;} else {isedit=false;
hist1= new Employment__c ();
 return null;
}
        }  
 public PageReference saveandlogout() {
        if (saveandcontinue() == null)
            return null; // step2() returning null means there were errors, so drop back to the page.
        return new PageReference('/secur/logout.jsp');
    }       
        
}