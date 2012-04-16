// Commented by Mahesh G, 3/1/12 to fix deployment issues with test class.
public without sharing class ApplicantRegistrationController{
public boolean finalsubmit{get;set;}
public User user{get;set;}
public String nomap{get;set;}
public String yno{get;set;}
public Opportunity opp{get;set;}
public static Opportunity oppstatic{get;set;}
public string Primary_Campus_c{get;set;}
public string Secondary_Campus_c{get;set;}
public static string Start_Term_c{get;set;}
public static Boolean Global_Campus_Rotation_Program_c{get;set;}
public static string Number_of_Rotations_c{get;set;}
public static string Rotation_Second_Choice_c{get;set;}
public static string Rotation_First_Choice_c{get;set;}
public static string Primary_Interest_c{get;set;} 
public static string contactid;
public string Primary_Program_Choice_c{get;set;}
public string Secondary_Program_Choice_c{get;set;}
public string Masters_Program_Choice_c{get;set;}
public string Secondary_Masters_Program_Choice_c{get;set;}
public static boolean spro1{get;set;}
public static boolean spro2{get;set;}
public static string pro_code{get;set;}
public static program__c prog;
public static boolean master1{get;set;}
public static boolean master2{get;set;}
public string pagename{get;set;}
public string ReqStar{get;set;}
public string ReqStar1{get;set;}
public Boolean termFlag1{get;set;}
public Boolean termFlag2{get;set;}
public Boolean tab1{get;set;}
public string birthday{get;set;}
public string birthmonth{get;set;}
public string birthyear{get;set;}
public boolean showSpecific1{get;set;}
public boolean showSpecific2{get;set;}
Date myDate;
public boolean interestedsec{get;set;}
public string oppStage = 'Qualified Lead';
public boolean Specialization_Taken_c{get;set;}
public string newMessage1{get;set;}
public string newMessage2{get;set;}
public boolean isnewMessageShow{get;set;}
public Map<Integer, Opportunity> m{get;set;} //= new Map<Integer, Opportunity>();
public Contact con {get; set;}

private Map <Id, Country__c> countries = new Map <Id, Country__c> ([Select Id, Name FROM Country__c]);


    public ApplicantRegistrationController()
    {
             countries.put (null, new Country__c ()); // to avoid null pointer exception when page loads with no country selected
                
                nomap='No Map';
                opp = new Opportunity();
                user = [SELECT contact.accountid, contact.title, contact.firstname,contact.lastname, id, email, username, usertype, communitynickname, timezonesidkey, languagelocalekey, firstname, lastname, phone, title,
                street, city, country, postalcode, state, localesidkey, mobilephone, extension, fax, contact.email,  contactId,              
                contact.Mailing_Country__c,
                contact.Suffix__c,
                contact.Gender__c,
                contact.Country_Of_Citizenship__c,
                contact.Country_Of_Origin__c,
                contact.Country_Of_Residence__c,
                contact.Birthdate,
                contact.Program_Primary__c,               
                contact.Program_Secondary__c,
                contact.mailingstreet,
                contact.mailingcity, 
                contact.mailingstate,
                contact.mailingpostalcode,
                contact.Language__c,
                contact.isEnglishNative__c,
                contact.Language_English_Speaking__c,
                contact.Language_English_Listening__c,
                contact.Language_English_Writing__c,
                contact.Language_English_Reading__c,
                contact.Language_Other__c,
                contact.Agent_Email__c,
                contact.Agent_Name__c,
                contact.Applicant_Email__c,
                contact.LeadSource,
                contact.Lead_Source_User_Supplied__c,
                contact.id,
                Contact.Nationality__c,
                contact.Home_Phone_Country_Code__c, contact.Home_Phone_Area_Code__c, contact.Home_Phone_Main_Number__c,
                contact.Mobile_Phone_Country_Code__c, contact.Mobile_Phone_Area_Code__c, contact.Mobile_Phone_Main_Number__c                
                FROM User  WHERE id = :UserInfo.getUserId()];
               contactid=user.contactid;
               
               con = new Contact ();
               con = [SELECT Id, Language__c,
                Language_English_Speaking__c,
                Language_English_Listening__c,
                Language_English_Writing__c,
                Language_English_Reading__c,
                Language_Other__c, Country_Of_Residence__c, MailingState FROM Contact WHERE Id = :contactId];
               
               
               if(user.contact.Birthdate!=null){
               birthmonth=string.valueof(user.contact.Birthdate.month());
               birthday=string.valueof(user.contact.Birthdate.day());
               birthyear=string.valueof(user.contact.Birthdate.year());}
                   if(user.contact.Language__c!='English')
                    {
                        ReqStar='*';
                    }
               
                    try{
                         opp=[select Primary_Program_Choice__c, Secondary_Program_Choice__c, Primary_Campus__c,Secondary_Campus__c, id,name,Global_Campus_Rotation_Program__c,Number_of_Rotations__c from Opportunity where contact__c=:user.contact.id limit 1];
                         Secondary_Campus_c=opp.Secondary_Campus__c;
                         tab1=true;
                      } 
                    catch(exception e) 
                     {
                        Opportunity opp = new Opportunity();                      
                        tab1=false;
                     }
    
    // to lock visualforce page----
                     try{
                     ApplicantFinalController contrl= new ApplicantFinalController();
                     contrl.getopp();
                     finalsubmit=ApplicantFinalController.finalsubmit;
                        }
                     catch(exception e)
                        {}
    } 
    public PageReference oppdata()
    {
                if(Primary_Program_Choice_c == 'Bachelor of International Business Administration'){
                    termFlag2 = true;
                    termFlag1 = false;
                }else{
                    termFlag1 = true;
                    termFlag2 = false;
                }
    User user1 = [SELECT contact.id from user WHERE id = :UserInfo.getUserId()];
    contactid=user1.contact.id;
    Opportunity opp3=new Opportunity();
        try{
                opp3=[select Specialization_Taken__c, Primary_Program_Choice__c,Secondary_Program_Choice__c,Masters_Program_Choice__c,Secondary_Masters_Program_Choice__c, Primary_Interest__c, Contact__c, Rotation_First_Choice__c, Rotation_Second_Choice__c, Number_of_Rotations__c, Global_Campus_Rotation_Program__c, Start_Term__c, Secondary_Campus__c,Primary_Campus__c from Opportunity where Contact__c=:contactid ];
                Specialization_Taken_c = opp3.Specialization_Taken__c;
                Rotation_First_Choice_c=opp3.Rotation_First_Choice__c;
                Primary_Campus_c=opp3.Primary_Campus__c;
                Secondary_Campus_c=opp3.Secondary_Campus__c;
                Start_Term_c=opp3.Start_Term__c;
                Global_Campus_Rotation_Program_c=opp3.Global_Campus_Rotation_Program__c;
                Number_of_Rotations_c=opp3.Number_of_Rotations__c;
                Rotation_Second_Choice_c=opp3.Rotation_Second_Choice__c;
                Rotation_First_Choice_c=opp3.Rotation_First_Choice__c;
                Primary_Interest_c=opp3.Primary_Interest__c;
                Primary_Program_Choice_c=opp3.Primary_Program_Choice__c;
                Secondary_Program_Choice_c=opp3.Secondary_Program_Choice__c;
                Masters_Program_Choice_c=opp3.Masters_Program_Choice__c;
                Secondary_Masters_Program_Choice_c=opp3.Secondary_Masters_Program_Choice__c;
                if(opp3.Secondary_Program_Choice__c!=null){interestedsec=true;}
                if ((Primary_Program_Choice_c=='Master\'s Program') || (Primary_Program_Choice_c=='Executive MBA')){ReqStar1='*';} else {ReqStar1='';}
                mibMessages();
                
           }
        catch(exception e)
           {
                opp3=new Opportunity();
           }
          return null;
    } 

    public static string procode(String str1, String str2 , string str3)
    {
    String code='';
    string ncode='';
        if((str1=='Executive MBA') && (str3==''))
        {
            code='EMBA';
        }
        else if(str1=='Master of Business Administration')
        {
            code='MBA';
        }
        else if((str1=='Master\'s Program') && (str3=='Master of International Business'))
        {
            code='MIB';
        }
        else if((str1=='Master\'s Program') && (str3=='Master of Finance'))
        {
            code='MFIN';
        }
        else if((str1=='Master\'s Program') && (str3=='Master International Marketing'))
        {
            code='MIM';
        }
        else if((str1=='Master\'s Program') && (str3=='Master of Social Entrepreneurship'))
        {
            code='MSE';
        }
        else if((str1=='Executive MBA') && (str3=='EMBA - Weekly Curriculum'))
        {
            code='EMBAw';
        }
        else if((str1=='Executive MBA') && (str3=='EMBA - Monthly Curriculum'))
        {
            code='EMBAm';
        }
        else if(str1=='Bachelor of International Business Administration')
        {
            code='Bachelor of International Business Administration';
        }
        if(str2=='Boston')
        {
            code =code+'-US-'+str2;
        }
        else if(str2=='Dubai')
        {
            code =code+'-UAE-'+str2;
        }
        else if(str2=='London')
        {
            code =code+'-UK-'+str2;
        }
        else if(str2=='San Francisco')
        {
            code =code+'-US-'+str2;
        }
        else if(str2=='Shanghai')
        {
            code =code+'-China-'+str2;
        }
    code=code.trim();
    system.debug('######'+code);
        if(code!=null)
        {
            try
            {
                prog=[select id from program__c where name=:code];
                ncode=prog.id;
            }
            catch(exception e)
            {
                ncode=null;
            }
        }
        system.debug('Program Code ID######'+ncode);
    return ncode;
    }
    public static string accountname(String str1, String str2 , string str3)
    {
    String code='';
    string ncode='';
        if(str1=='Executive MBA' && str3=='')
        {
            code='EMBA';
        }
        else if(str1=='Master of Business Administration')
        {
            code='MBA';
        }
        else if((str1=='Master\'s Program') && (str3=='Master of International Business'))
        {
            code='MIB';
        }
        else if((str1=='Master\'s Program') && (str3=='Master of Finance'))
        {
            code='MFIN';
        }
        else if((str1=='Master\'s Program') && (str3=='Master International Marketing'))
        {
            code='MIM';
        }
        else if((str1=='Master\'s Program') && (str3=='Master of Social Entrepreneurship'))
        {
            code='MSE';
        }
        else if((str1=='Executive MBA') && (str3=='EMBA - Weekly Curriculum'))
        {
            code='EMBAw';
        }
        else if((str1=='Executive MBA') && (str3=='EMBA - Monthly Curriculum'))
        {
            code='EMBAm';
        }
        else if(str1=='Bachelor of International Business Administration')
        {
            code='Bachelor of International Business Administration';
        }
        if(str2=='Boston')
        {
            code =code+'-US-'+str2;
        }
        else if(str2=='Dubai')
        {
            code =code+'-UAE-'+str2;
        }
        else if(str2=='London')
        {
            code =code+'-UK-'+str2;
        }
        else if(str2=='San Francisco')
        {
            code =code+'-US-'+str2;
        }
        else if(str2=='Shanghai')
        {
            code =code+'-China-'+str2;
        }
    code=code.trim();
    system.debug('Code for Account######'+code);
        if(code!=null)
        {
            try
            {
                Account ac=[select id from account where name=:code limit 1];
                ncode=ac.id;
            }
            catch(exception e)
            {
                ncode=null;
            }
        }
        system.debug('Account Id######'+ncode);
    return ncode;
    }
public static string pcome1{get;set;}
public static string pcome2{get;set;}

    public PageReference step3(){
            try{
          
                 if(Primary_Program_Choice_c==null){
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please select Primary Choice of Program'));
                 }                
                 if((Primary_Program_Choice_c=='Master\'s Program') || (Primary_Program_Choice_c=='Executive MBA')){
                     if(Masters_Program_Choice_c==null){
                         ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please select Specific Program'));
                      }                  
                 }          
                 if((Primary_Campus_c==null) && (Primary_Program_Choice_c!=null)){
                     ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please select Choice of Campus'));
                 }                 
                 if((Start_Term_c==null) ){
                     ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please select Start Term in'));
                 }
                 if(Primary_Program_Choice_c=='Executive MBA' && Masters_Program_Choice_c=='EMBA - Weekly Curriculum' && Primary_Campus_c=='Shanghai' ){
                     ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please select the monthly option if you want to study the Executive MBA program in Shanghai.'));
                 }
                  
            User user1 = [SELECT contact.id,name from user WHERE id = :UserInfo.getUserId()];
            if(!apexpages.hasmessages()) 
              {  
            contactid=user1.contact.id;
            
            pcome1=procode(Primary_Program_Choice_c,Primary_Campus_c,Masters_Program_Choice_c);
            pcome2=procode(Secondary_Program_Choice_c,Secondary_Campus_c,Secondary_Masters_Program_Choice_c);
            // code to update contact account
           /* String acid=accountname(Primary_Program_Choice_c,Primary_Campus_c,Masters_Program_Choice_c);
            user.contact.accountid=acid;*/           
            user.contact.Program_Primary__c=pcome1;
            user.contact.Program_Secondary__c=pcome2;
            update user.contact;
            system.debug('****'+pcome1);
            
            try{
            if (isnewMessageShow==false){
                Specialization_Taken_c = false;
            }
            Opportunity opp1=new Opportunity();
            opp1=[select Specialization_Taken__c, id, StageName, Program__c,Secondary_Program__c, Primary_Program_Choice__c,Secondary_Program_Choice__c,Masters_Program_Choice__c,Secondary_Masters_Program_Choice__c,Contact__c, Rotation_First_Choice__c, Rotation_Second_Choice__c, Number_of_Rotations__c, Global_Campus_Rotation_Program__c, Start_Term__c, Secondary_Campus__c,Primary_Campus__c from Opportunity where Contact__c=:contactid ];           
            opp1.Specialization_Taken__c = Specialization_Taken_c;
            opp1.contact__c=contactid;
            opp1.Primary_Campus__c=Primary_Campus_c;
            opp1.Secondary_Campus__c=Secondary_Campus_c;
            opp1.Start_Term__c=Start_Term_c;
            opp1.Global_Campus_Rotation_Program__c=Boolean.valueof(Global_Campus_Rotation_Program_c);
            opp1.Number_of_Rotations__c=Number_of_Rotations_c;
            opp1.Rotation_Second_Choice__c=Rotation_Second_Choice_c;
            opp1.Rotation_First_Choice__c=Rotation_First_Choice_c;
            opp1.Primary_Program_Choice__c=Primary_Program_Choice_c;
            opp1.Secondary_Program_Choice__c=Secondary_Program_Choice_c;
            opp1.Masters_Program_Choice__c=Masters_Program_Choice_c;
            opp1.Secondary_Masters_Program_Choice__c=Secondary_Masters_Program_Choice_c;
            opp1.Program__c=pcome1;
            opp1.Secondary_Program__c=pcome2;
            opp1.Program_and_Location_Tab_Complete__c=true;
            opp1.Application_Status__c='Active';
            //opp1.StageName=oppStage;
            update opp1;
            } catch(exception e){
            Opportunity opp2 = new Opportunity(
            Specialization_Taken__c = Specialization_Taken_c,
            contact__c=contactid,
            Primary_Campus__c=Primary_Campus_c,
            Secondary_Campus__c=Secondary_Campus_c,
            Start_Term__c=Start_Term_c,
            Global_Campus_Rotation_Program__c=Boolean.valueof(Global_Campus_Rotation_Program_c),
            Number_of_Rotations__c=Number_of_Rotations_c,
            Rotation_Second_Choice__c=Rotation_Second_Choice_c,
            Rotation_First_Choice__c=Rotation_First_Choice_c,
            Primary_Program_Choice__c=Primary_Program_Choice_c,
            Secondary_Program_Choice__c=Secondary_Program_Choice_c,
            Masters_Program_Choice__c=Masters_Program_Choice_c,
            Secondary_Masters_Program_Choice__c=Secondary_Masters_Program_Choice_c,
            Program_and_Location_Tab_Complete__c=true,
            Program__c=pcome1,
            Secondary_Program__c=pcome2,
            CloseDate=date.today(),name=user1.name,StageName=oppStage,Application_Status__c='Active'
            );
            insert opp2;
            
            }
            
            
             if(pagename==null)
            return Page.registration1;            
            else
            return Page.ApplicantPersonalInformation; 
            }
            else
            {
            return null;
            }
    
            } 
            catch(DmlException e) 
            {
                ApexPages.addMessages(e);
                return null;
            }
    }

public List<SelectOption> getMasterProlist()
{    
List<SelectOption> options = new List<SelectOption>();    
options.add(new SelectOption('','-Select-')); 
    if(Primary_Program_Choice_c == 'Master\'s Program') 
    {        
        options.add(new SelectOption('Master of International Business','Master of International Business'));             
        options.add(new SelectOption('Master of Finance','Master of Finance'));             
        options.add(new SelectOption('Master International Marketing','Master International Marketing'));        
        options.add(new SelectOption('Master of Social Entrepreneurship','Master of Social Entrepreneurship'));        
        showSpecific1=true;
    
    }
   else if (Primary_Program_Choice_c == 'Executive MBA') 
   {
        options.add(new SelectOption('EMBA - Weekly Curriculum','EMBA - Weekly Curriculum'));             
        options.add(new SelectOption('EMBA - Monthly Curriculum','EMBA - Monthly Curriculum'));             
        showSpecific1=true;
   }
   else
   {
       showSpecific1=false;
   }    
return options;
}

public List<SelectOption> getMasterProlistSec()
{
    List<SelectOption> options = new List<SelectOption>();
    options.add(new SelectOption('','-Select-'));
    if(Secondary_Program_Choice_c == 'Master\'s Program') 
    {        
        options.add(new SelectOption('Master of International Business','Master of International Business'));             
        options.add(new SelectOption('Master of Finance','Master of Finance'));             
        options.add(new SelectOption('Master International Marketing','Master International Marketing'));        
        options.add(new SelectOption('Master of Social Entrepreneurship','Master of Social Entrepreneurship'));
        showSpecific2=true;
    }
   else if (Secondary_Program_Choice_c == 'Executive MBA') 
   {
        options.add(new SelectOption('EMBA - Weekly Curriculum','EMBA - Weekly Curriculum'));             
        options.add(new SelectOption('EMBA - Monthly Curriculum','EMBA - Monthly Curriculum'));             
        showSpecific2=true;
   }
   else
   {
       showSpecific2=false;
   }
    return options;
}


public void MasterProlist1()
{ 
if ((Primary_Program_Choice_c=='Master\'s Program') || (Primary_Program_Choice_c=='Executive MBA')){ReqStar1='*';} else {ReqStar1='';}
if(Primary_Program_Choice_c == 'Bachelor of International Business Administration'){
    termFlag2 = true;
    termFlag1 = false;
}else{
    termFlag1 = true;
    termFlag2 = false;
}
mibMessages();
}


public List<SelectOption> getsellist()
{
List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','-Select-'));     
            
           return options;
}
public List<SelectOption> getprimaryProlist()
{
List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','-Select-'));     
        options.add(new SelectOption('Bachelor of International Business Administration','Bachelor of International Business Administration'));     
        options.add(new SelectOption('Master\'s Program','Master\'s Program'));     
        options.add(new SelectOption('Master of Business Administration','Master of Business Administration'));
        options.add(new SelectOption('Executive MBA','Executive MBA'));     
           return options;
}
// Code for title--
public List<SelectOption> gettitleitems() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','-Select-'));     
        options.add(new SelectOption('Mr.','Mr.'));     
        options.add(new SelectOption('Ms.','Ms.'));     
        options.add(new SelectOption('Mrs.','Mrs.'));
                options.add(new SelectOption('Dr.','Dr.'));     
        options.add(new SelectOption('Prof.','Prof.'));     


        return options;
    }
    
public List<SelectOption> getyesno() 
{
        List<SelectOption> options = new List<SelectOption>();
       // options.add(new SelectOption('','-Select-'));     
        options.add(new SelectOption('true','Yes'));     
        options.add(new SelectOption('false','No'));     
        return options;
}    
public List<SelectOption> getinterestitems() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','-Select-'));     
        options.add(new SelectOption('Bachelor of International Business Administration','Bachelor of International Business Administration'));     
        options.add(new SelectOption('Master\'s Pragram','Master\'s Pragram'));     
        options.add(new SelectOption('Master of Business','Master of Business'));     
        options.add(new SelectOption('Administration','Administration'));     


        return options;
    }
    
public List<SelectOption> getdlist() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','-No Map-'));            


        return options;
    }  
    
    public List<SelectOption> getfcampusModule() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','-Select-'));            
        options.add(new SelectOption('Boston','Boston'));            
        options.add(new SelectOption('London','London'));            
        options.add(new SelectOption('San Francisco','San Francisco'));            
        options.add(new SelectOption('Dubai','Dubai'));   
        options.add(new SelectOption('Shanghai','Shanghai'));
        return options;
    }
    
    public List<SelectOption> getfcampusSec() {
        List<SelectOption> options = new List<SelectOption>();
        
         if(Secondary_Program_Choice_c == 'Bachelor of International Business Administration') 
            {
            options.add(new SelectOption('','-Select-'));  
            options.add(new SelectOption('London','London'));
            }
            else if(Secondary_Program_Choice_c == 'Executive MBA') 
            {
            options.add(new SelectOption('','-Select-'));  
            options.add(new SelectOption('London','London'));
            options.add(new SelectOption('Dubai','Dubai'));
            options.add(new SelectOption('Shanghai','Shanghai'));
            //fix to have shanghai as a monthly only
              /*  if (Secondary_Masters_Program_Choice_c == 'EMBA - Monthly Curriculum'){
                    options.add(new SelectOption('Shanghai','Shanghai'));
                }*/
                
            }
            else if((Secondary_Program_Choice_c == 'Master\'s Program') && (Secondary_Masters_Program_Choice_c == null) ) 
            {
            options.add(new SelectOption('','-Select-')); 
            }
            else if((Secondary_Program_Choice_c == 'Master\'s Program') && (Secondary_Masters_Program_Choice_c == 'Master International Marketing') ) 
            {
            options.add(new SelectOption('','-Select-'));  
            options.add(new SelectOption('London','London'));
            options.add(new SelectOption('San Francisco','San Francisco'));
            options.add(new SelectOption('Dubai','Dubai'));
            }
            else if((Secondary_Program_Choice_c == 'Master\'s Program') && (Secondary_Masters_Program_Choice_c == 'Master of Finance') ) 
            {
            options.add(new SelectOption('','-Select-'));  
            options.add(new SelectOption('London','London'));            
            options.add(new SelectOption('Shanghai','Shanghai'));
            }
            else if((Secondary_Program_Choice_c == 'Master\'s Program') && (Secondary_Masters_Program_Choice_c == 'Master of Digital Marketing') ) 
            {
            options.add(new SelectOption('','-Select-'));  
            options.add(new SelectOption('London','London'));
            options.add(new SelectOption('San Francisco','San Francisco'));
            options.add(new SelectOption('Dubai','Dubai'));
            }
            else if((Secondary_Program_Choice_c == 'Master\'s Program') && (Secondary_Masters_Program_Choice_c == 'Master of Social Entrepreneurship') ) 
            {
            options.add(new SelectOption('','-Select-'));  
            options.add(new SelectOption('London','London'));
            options.add(new SelectOption('San Francisco','San Francisco'));
            }
            else 
            {
            options.add(new SelectOption('','-Select-'));
            options.add(new SelectOption('Boston','Boston'));
            options.add(new SelectOption('London','London'));
            options.add(new SelectOption('San Francisco','San Francisco'));
            options.add(new SelectOption('Dubai','Dubai'));
            options.add(new SelectOption('Shanghai','Shanghai'));
            } 
        
        return options;
    }     
    
    public List<SelectOption> getfcampus() {
        List<SelectOption> options = new List<SelectOption>();
        
           if(Primary_Program_Choice_c == 'Bachelor of International Business Administration') 
            {
            options.add(new SelectOption('','-Select-'));  
            options.add(new SelectOption('London','London'));
            Global_Campus_Rotation_Program_c=false;
            }
            else if(Primary_Program_Choice_c == 'Executive MBA') 
            {
            
            options.add(new SelectOption('','-Select-'));  
            options.add(new SelectOption('London','London'));
            options.add(new SelectOption('Dubai','Dubai'));
            options.add(new SelectOption('Shanghai','Shanghai'));
                    //fix to have shanghai as a monthly only
               /* if (Masters_Program_Choice_c == 'EMBA - Monthly Curriculum'){
                    options.add(new SelectOption('Shanghai','Shanghai'));
                }*/
           
            }
            else if((Primary_Program_Choice_c == 'Master\'s Program') && (Masters_Program_Choice_c == null) ) 
            {
            options.add(new SelectOption('','-Select-'));
            }
            else if((Primary_Program_Choice_c == 'Master\'s Program') && (Masters_Program_Choice_c == 'Master International Marketing') ) 
            {
            options.add(new SelectOption('','-Select-'));  
            options.add(new SelectOption('London','London'));
            options.add(new SelectOption('San Francisco','San Francisco'));
            options.add(new SelectOption('Dubai','Dubai'));
            }
            else if((Primary_Program_Choice_c == 'Master\'s Program') && (Masters_Program_Choice_c == 'Master of Finance') ) 
            {
            options.add(new SelectOption('','-Select-'));  
            options.add(new SelectOption('London','London'));            
            options.add(new SelectOption('Shanghai','Shanghai'));
            }
            else if((Primary_Program_Choice_c == 'Master\'s Program') && (Masters_Program_Choice_c == 'Master of Digital Marketing') ) 
            {
            options.add(new SelectOption('','-Select-'));  
            options.add(new SelectOption('London','London'));
            options.add(new SelectOption('San Francisco','San Francisco'));
            options.add(new SelectOption('Dubai','Dubai'));
            }
            else if((Primary_Program_Choice_c == 'Master\'s Program') && (Masters_Program_Choice_c == 'Master of Social Entrepreneurship') ) 
            {
            options.add(new SelectOption('','-Select-'));  
            options.add(new SelectOption('London','London'));
            options.add(new SelectOption('San Francisco','San Francisco'));
            }
            else 
            {
            options.add(new SelectOption('','-Select-'));
            options.add(new SelectOption('Boston','Boston'));
            options.add(new SelectOption('London','London'));
            options.add(new SelectOption('San Francisco','San Francisco'));
            options.add(new SelectOption('Dubai','Dubai'));
            options.add(new SelectOption('Shanghai','Shanghai'));
            } 
        
        return options;
    }      
    
    public List<SelectOption> getintcampue() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','-Select-'));            
        options.add(new SelectOption('Yes','Yes'));
        options.add(new SelectOption('No','No'));
        return options;
    }  

 public List<SelectOption> getnum() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','-Select-'));            
options.add(new SelectOption('1','1'));
options.add(new SelectOption('2','2'));

        return options;
    } 
    

public List<SelectOption> getstartterm() 
{

List<SelectOption> options = new List<SelectOption>();
Schema.DescribeFieldResult F = Opportunity.Start_Term__c.getDescribe();
List<Schema.PicklistEntry> P = F.getPicklistValues();
options.add(new SelectOption('','--Select--'));            
for(Schema.PicklistEntry pickListvalues : P){
if((Primary_Program_Choice_c=='Bachelor of International Business Administration'))
{
    if (pickListValues.getValue() != 'September 2011') // remove september 2011 option
options.add(new SelectOption(pickListvalues.getvalue(),pickListvalues.getvalue()));            
}
else if((pickListvalues.getvalue()!='January 2012') && (pickListvalues.getvalue()!='January 2013') && (pickListvalues.getvalue()!='January 2014'))
{
    if (pickListValues.getValue() != 'September 2011') // remove september 2011 option
options.add(new SelectOption(pickListvalues.getvalue(),pickListvalues.getvalue()));            
}
}
return options; 
}     
        
// End code for Title  
// Code for Primary Interest list 
 public List<SelectOption> getintlist() {

        List<SelectOption> options = new List<SelectOption>();
        
        options.add(new SelectOption('','-Select-'));
        options.add(new SelectOption('Career Change','Career Change'));            
        options.add(new SelectOption('Advance with current employer/profession','Advance with current employer/profession'));                    
        options.add(new SelectOption('Start career in a new country','Start career in a new country'));            
        options.add(new SelectOption('Learn new skills or for professional development','Learn new skills or for professional development'));                            


        return options;
    } 
 
// Code for programe----

// Code for country list 
 public List<SelectOption> getclist() {
 integer i=0;
        List<SelectOption> options = new List<SelectOption>();
        List<Country__c> cou=[select id,name from country__c where name != '-Did Not Respond-' order by name asc]; // remove -Did Not Respond- country from picklist
        options.add(new SelectOption('','-Select-'));            
        for(i=0;i<cou.size();i++){
        options.add(new SelectOption(cou[i].id,cou[i].name));            
        }


        return options;
    } 
    
    //list of states for country of residence
    
    public  List<SelectOption> getStatesList () {
        
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','-Select-')); 
        
        for (States__c s: [SELECT Name, Country__c, StateShortName__c FROM States__c WHERE Country__c = :countries.get(user.contact.Mailing_Country__c).Name]) {
            options.add (new SelectOption (s.Name, s.Name));
        }
        
        return options;
    }
 

// Code for country list 
 public List<SelectOption> getcountryCode() {
 integer i=0;
        List<SelectOption> options = new List<SelectOption>();
        List<Country__c> cou=[select id,name,Calling_Code__c from country__c where Calling_Code__c!=null order by name asc];
        options.add(new SelectOption('','-Select-'));            
        for(i=0;i<cou.size();i++){
        options.add(new SelectOption(string.valueof(cou[i].Calling_Code__c),cou[i].name+'('+cou[i].Calling_Code__c+')'));            
        }


        return options;
    } 
 

public List<SelectOption> getplist() {
integer i=0;
        List<SelectOption> options = new List<SelectOption>();
        List<Program__c> pro=[select id,name from Program__c order by name asc];
        options.add(new SelectOption('','-Select-'));     
        for(i=0;i<pro.size();i++){        
        options.add(new SelectOption(pro[i].id,pro[i].name));     
        }
        

        return options;
    }


public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('Test','Sufix'));     

        return options;
    }
    
public User getCreatedUser(){
    User u = [select FirstName, LastName from User where Id = :UserInfo.getUserId()];
    return u;
}        
   
    
    public PageReference step2andlogout() {
        if (step2() == null)
            return null; // step2() returning null means there were errors, so drop back to the page.
        return new PageReference('/secur/logout.jsp');
    }
    public PageReference step3andlogout() {
        if (step3() == null)

            return null; // step3() returning null means there were errors, so drop back to the page.
        return new PageReference('/secur/logout.jsp');
    }
    
    public PageReference step2() {
        if (user.contact.Language__c!='English')
            ReqStar='*';
        if (user.contact.firstname==null)
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter First Name'));
        if ((user.contact.lastname.trim()=='') || (user.contact.lastname==null))
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter Last Name'));
        if (user.contact.Gender__c==null)
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please select Gender'));
        if (user.contact.Country_Of_Origin__c == null)
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter Country of Origin'));
        if (user.contact.Country_Of_Residence__c == null)
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please select Country of Residence'));
       
        if((birthday.trim()=='') ||  (birthmonth.trim()=='') || (birthyear.trim()==''))
    {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter Birthdate (mm/dd/yyyy)'));
    }
        else
    {
        try
        {
            myDate =  date.valueof(birthyear+'-'+birthmonth+'-'+birthday);
        }
        catch(exception e)
        {
            apexpages.addmessages(e);
        }
    }
        
        if ((myDate!=null) && (myDate>date.today()))
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Birthdate should be less than today date'));
        if (user.contact.Lead_Source_User_Supplied__c==null)
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please select Where did you hear about Us?'));
        if (user.contact.mailingstreet==null)
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter Street'));
        if (user.contact.mailingcity==null)
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter City'));
        if (user.contact.mailingstate==null)
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter State/Province'));
        if (user.contact.mailingpostalcode==null)
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter Zip/Postal Code'));
        if (user.contact.Mailing_Country__c==null)
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please select Country'));

        if (user.contact.Home_Phone_Country_Code__c==null)
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter Primary Number Country Code'));
        if ((user.contact.Home_Phone_Main_Number__c==null) || (user.contact.Home_Phone_Main_Number__c.trim()=='')){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter Primary Number Main Number'));}
        if (con.Language__c==null )
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please select What is your Native Language'));
        
        if((con.Language__c!=null) && (con.Language__c!='English')) {
            if(con.Language_English_Speaking__c==null)
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please select Speaking Proficiency'));
            if(con.Language_English_Listening__c==null)
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please select Listening Proficiency'));
            if(con.Language_English_Writing__c==null)
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please select Writing  Proficiency'));
            if(con.Language_English_Reading__c==null)
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please select Reading  Proficiency'));
        }
    
        // Code for oppertunity object--
        User user1 = [SELECT contact.id,contact.firstname,name from user WHERE id = :UserInfo.getUserId()];

        if (apexpages.hasmessages() == true)
            return null; 
        
      
        
        try { 
            user.contact.Applicant_Email__c=user.contact.email;
            user.contact.Birthdate= myDate;
            user.contact.MAilingCountry = countries.get(user.contact.Mailing_Country__c).Name;
            update con;
            update user.contact;
           
        } catch (dmlexception e) {
            ApexPages.addMessages(e); 
            return null;
        }
        
        contactid=user1.contact.id;
        
        try {
            Opportunity opp1=new Opportunity();
            opp1=[select stageName,  Personal_Information_Complete__c, Contact__c, Primary_Interest__c from Opportunity where Contact__c=:contactid ];
            opp1.contact__c=contactid;
            opp1.Primary_Interest__c=Primary_Interest_c;
            opp1.Personal_Information_Complete__c=true;
            opp1.StageName=oppStage;
            update opp1;
        } catch(exception e) {
            Opportunity opp2 = new Opportunity(
                contact__c=contactid,
                Primary_Interest__c=Primary_Interest_c,
                Personal_Information_Complete__c=true,
                CloseDate=date.today(),
                name=user1.name,
                StageName=oppStage);
            insert opp2; 
        }
        
        // end code
        
        if(pagename==null)
            return Page.ApplicantEducation;
        
        tab1 = true; 
        return Page.ApplicantEducation; 
    }
   
  public PageReference saveandcontinue() {
    update user.contact;
       update con;
    return Page.ApplicantProgramLocation;
   
   }

   public PageReference saveandcontinue1() {

    return Page.ApplicantEducation;
  
   }
   
   public void mibMessages(){       
       if(Primary_Program_Choice_c == 'Master\'s Program' && Masters_Program_Choice_c == 'Master of International Business' && (Primary_Campus_c=='London' || Primary_Campus_c=='San Francisco' || Primary_Campus_c=='Shanghai' || Primary_Campus_c=='Boston' || Primary_Campus_c=='Dubai')){
       newMessage1 = 'Are you interested in our Project Management specialization?';
       newMessage2 = 'Please note there is an additional <9000 USD> <33,100 AED> <6700 GBP> <65000 CNY> fee';
       
       isnewMessageShow = true;
       }
       else if(Primary_Program_Choice_c == 'Master\'s Program' && Masters_Program_Choice_c == 'Master International Marketing' && (Primary_Campus_c=='London' || Primary_Campus_c=='San Francisco' || Primary_Campus_c=='Dubai')){
       newMessage1 = 'Are you interested in our Digital Marketing specialization? ';
       newMessage2 = 'Please note there is an additional <9000 USD> <33,100 AED> <6700 GBP> fee';
       isnewMessageShow = true;
       }
       else{
       isnewMessageShow = false;
       }
       
   }
  
}