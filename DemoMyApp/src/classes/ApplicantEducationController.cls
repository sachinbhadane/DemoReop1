// Class for Education and test class TestForApplicantEducationController
public without sharing class ApplicantEducationController {
    public User user;    
    public Education__c Undergraduate;
    public Education__c getUndergraduate()
    {
    return Undergraduate;
    }
    public String nomap{get;set;}
    public recordType recid;
    public Opportunity opp{get;set;}
    public Boolean finalsubmit{get;set;}
    public boolean tab2{get;set;}
    public string GraduateDateFrom_day{get;set;}
    public string GraduateDateFrom_month{get;set;}
    public string GraduateDateFrom_year{get;set;}
    public date GraduateDateFrom;
    public string GraduateDateTo_day{get;set;}
    public string GraduateDateTo_month{get;set;}
    public string GraduateDateTo_year{get;set;}
    public date GraduateDateTo;
    public string Date_Graduated_day{get;set;}
    public string Date_Graduated_month{get;set;}
    public string Date_Graduated_year{get;set;}
    public date Date_Graduated;
    public string DegreeDateFrom_day{get;set;}
    public string DegreeDateFrom_month{get;set;}
    public string DegreeDateFrom_year{get;set;}
    public date DegreeDateFrom;
    public string DegreeDateTo_day{get;set;}
    public string DegreeDateTo_month{get;set;}
    public string DegreeDateTo_year{get;set;}
    public date DegreeDateTo;
    public boolean is_Edit{get;set;}
    public string proName{get;set;}
    // Create constructor
    public ApplicantEducationController ()
    {    
        Date_Graduated_year = '';
        Date_Graduated_month = '';
        Date_Graduated_day = '';
          Undergraduate = new Education__c();
          //get current user 
           user = [SELECT contact.id FROM User  WHERE id = :UserInfo.getUserId()];
            try{
                 opp=[select Program_and_Location_Tab_Complete__c, id from Opportunity where contact__c=:user.contact.id limit 1];           
                     if(opp.Program_and_Location_Tab_Complete__c==true)
                     {
                         tab2=true;
                     }
                 } 
            catch(exception e)
                 {
                     Opportunity opp = new Opportunity();
                 }
              // Select history recored 
             
                    
                     //apexpages.addmessages(e);
                     Undergraduate= new Education__c();
                 
              
                 // to lock visualforce page----
                 try{
                 ApplicantFinalController contrl= new ApplicantFinalController();
                 contrl.getopp();
                 proName=contrl.proName;
                 finalsubmit=ApplicantFinalController.finalsubmit;}
                 catch(exception e){}
    } 
        public List<SelectOption> getItems() 
        {
            List<SelectOption> options = new List<SelectOption>();
            Schema.DescribeFieldResult F = Education__c.Highest_Degree_Attained__c.getDescribe();
            List<Schema.PicklistEntry> P = F.getPicklistValues();
            options.add(new SelectOption('','--Select--'));            
            for(Schema.PicklistEntry pickListvalues : P)
            {   
                options.add(new SelectOption(pickListvalues.getvalue(),pickListvalues.getvalue())); 
            }
            return options;
        }    
   public List<Education__c> geteList()
   {
    List<Education__c> eList;
    try{
    eList=[select id,name ,Undergraduate_School_Attended__c          
                     ,GraduateDateFrom__c,EducationSpeciality__c,GraduateDateTo__c,
                     School_attended_for_Highest_Degree__c,DegreeDateFrom__c,
                     Highest_Degree_Attained__c,DegreeSpeciality__c,DegreeDateTo__c
                     ,High_School_Attended__c,Date_Graduated__c,High_School_Grade_Point_Average__c,High_School_SAT_ACT__c
                     ,International_Baccalaureate_Score__c
                     from Education__c where Application__c=:opp.id];
                     
                     }
                     catch(exception e)
                     {
                     
                     }
                     return elist; 
   }
   
    //Method for create or update hostory record and set opportunity -> Education_Tab_Complete__c flag true
 public pagereference saveUndergraduate()    
    {    
        if((System.currentPagereference().getParameters().get('saveandc')!=null) && (Undergraduate.Highest_Degree_Attained__c==null))
        {
               if(proName=='Bachelor of International Business Administration-UK-London')
                {
                    return new PageReference('/ApplicantExamInfo');
                }
                else
                {
                    return new PageReference('/ApplicantEmployment');
                }
        }    
         
         if(Undergraduate.Highest_Degree_Attained__c==null)
          {
              ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please select Highest Degree attained'));
          }         
          
          
               if(Undergraduate.Undergraduate_School_Attended__c==null)
                {
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter School attended'));
                }
                if((GraduateDateFrom_day.trim()=='') || (GraduateDateFrom_month.trim()=='') || (GraduateDateFrom_year.trim()==''))
                {
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter  Date attended from (dd/mm/yyyy)'));
                }
                else
                {
                    try
                    {
                         GraduateDateFrom=date.valueof(GraduateDateFrom_year+'-'+GraduateDateFrom_month+'-'+GraduateDateFrom_day);   
                    }
                    catch(exception e)
                    {
                        apexpages.addmessages(e);
                    }
                }
               
                    
               if((GraduateDateTo_day.trim()=='') || (GraduateDateTo_month.trim()=='') || (GraduateDateTo_year.trim()==''))
               {
                   ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter     Date attended to (dd/mm/yyyy)'));
               }
               else
               {
                    try
                    {
                     GraduateDateTo=date.valueof(GraduateDateTo_year+'-'+GraduateDateTo_month+'-'+GraduateDateTo_day);   
                    }
                    catch(exception e)
                    {
                    apexpages.addmessages(e);
                    }
               }
               if(GraduateDateFrom  > GraduateDateTo)
              {
                  ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Date attended from (dd/mm/yyyy) should not be greater than Date attended to (dd/mm/yyyy)'));
              }
              if(Undergraduate.EducationSpeciality__c==null && Undergraduate.Highest_Degree_Attained__c!= 'High School')
               {
                   ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter  Major and/or Speciality'));
               }
          
          if(!apexpages.hasmessages()) 
          {          
             try{ 
                 opp.Education_Tab_Complete__c=true;                       
                 update opp;
                 Undergraduate.recordtypeid=getrecordtype(Undergraduate.Highest_Degree_Attained__c);
                 //Undergraduate.recordtypeid=getrecordtype('Master\'s Degree');
                 if(Undergraduate.Highest_Degree_Attained__c=='High School'){
                     Undergraduate.High_School_Attended__c =Undergraduate.Undergraduate_School_Attended__c;
                     Undergraduate.Undergraduate_School_Attended__c = null;
                 }
                 else{
                     Undergraduate.High_School_Attended__c = null;
                 }                 
                 Undergraduate.Application__c=opp.id;
                 Undergraduate.GraduateDateFrom__c=GraduateDateFrom;
                 Undergraduate.GraduateDateTo__c=GraduateDateTo;                 
                 upsert Undergraduate;
                 
                } 
             catch(exception e){
                //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,e.getMessage()));
                 return null;
             }
                  PageReference page= new PageReference('/ApplicantEducation');
                  return page;
           }
          else
          {
              return null;
          }
    }
   
   public void edit()
   {
   Undergraduate=[select High_School_Attended__c, High_School_Grade_Point_Average__c, High_School_SAT_ACT__c,International_Baccalaureate_Score__c, id,Highest_Degree_Attained__c,Undergraduate_School_Attended__c          
                     ,GraduateDateFrom__c,GraduateDateTo__c,EducationSpeciality__c
                     from Education__c where id=:System.currentPagereference().getParameters().get('id')];

    if(Undergraduate.GraduateDateFrom__c!=null)
    {
    GraduateDateFrom_day=string.valueof(Undergraduate.GraduateDateFrom__c.day());
    GraduateDateFrom_month=string.valueof(Undergraduate.GraduateDateFrom__c.month());
    GraduateDateFrom_year=string.valueof(Undergraduate.GraduateDateFrom__c.year());
    }
    if(Undergraduate.GraduateDateTo__c!=null)
    {
    GraduateDateTo_day=string.valueof(Undergraduate.GraduateDateTo__c.day());
    GraduateDateTo_month=string.valueof(Undergraduate.GraduateDateTo__c.month());
    GraduateDateTo_year=string.valueof(Undergraduate.GraduateDateTo__c.year());
    }
    if(Undergraduate.Highest_Degree_Attained__c=='High School'){
        Undergraduate.Undergraduate_School_Attended__c = Undergraduate.High_School_Attended__c;
    }
    is_Edit=true;   
   }
   public void is_Cancel()
   {
       Undergraduate = new Education__c();
       GraduateDateFrom_day = '';
       GraduateDateFrom_month = '';
       GraduateDateFrom_year = '';
       GraduateDateTo_day = '';
       GraduateDateTo_month = '';
       GraduateDateTo_year = '';
       is_Edit=false;   
   }
   
   public void is_delete()
   {
   try
   {
   Education__c edu=[select id from Education__c where id=:System.currentPagereference().getParameters().get('id')];
   delete edu;
   ApexPages.addmessage(new ApexPages.message(ApexPages.severity.confirm,'Record has been deleted'));
   }
   catch(exception e)
   {
   ApexPages.addmessages(e);
   }
   }
    
   public String getrecordtype(String hdegree)
   {
      recordtype recid;
      if((hdegree=='Master\'s Degree') || (hdegree=='Doctoral Degree'))
      {
          recid=[select id from recordtype where name='Graduate' and sobjectType='Education__c'];
      }
      else if(hdegree=='Bachelor\'s Degree')
      {
          recid=[select id from recordtype where name='Undergraduate' and sobjectType='Education__c'];
      }
      else if(hdegree=='High School')
      {
         recid=[select id from recordtype where name='High School' and sobjectType='Education__c'];
      }
      return recid.id;
   }
   
   public PageReference saveandcontinueandlogout() 
   {
        integer chk;         
        if (saveUndergraduate() == null)
        {
            chk=1;
        }
        if(chk > 0)
        return null;      
        return new PageReference('/secur/logout.jsp');
    }
    
   public PageReference saveandcontinue() 
   {
       integer chk;          
       if (saveUndergraduate() == null)
        {
            chk=1;
        }
        if(chk > 0)
        return null;      
        if(proName=='Bachelor of International Business Administration-UK-London')
        {
        return new PageReference('/ApplicantExamInfo');
        }
        else
        {
        return new PageReference('/ApplicantEmployment');
        }
    }

}