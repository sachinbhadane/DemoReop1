public without sharing class ApplicantSponsorshipController {
public User user{get;set;}
public Requirement__c req{get;set;}
public String nomap{get;set;}
public String recordtypeid;
public recordType recid;
public Opportunity opp{get;set;}
public boolean tab2{get;set;}
public boolean finalsubmit{get;set;}
public boolean selfset{get;set;}
public string proName{get;set;}
public string Sponser_c{get;set;}
public ApplicantSponsorshipController(){
nomap='No map';
recid=[select id,name from recordtype where name='Sponsorship' and sobjectType='Requirement__c'];
user = [SELECT contact.id, contact.Sponsor_Of_Education__c, 
        contact.Sponsor_Employer_or_Organization__c, 
        contact.Sponsor_Contact_Person__c, contact.Sponsor_Job_Title__c,
        contact.Sponsor_Address__c, contact.Sponsor_Phone_Number__c,
        contact.Sponsor_Fax_Number__c FROM User
                WHERE id = :UserInfo.getUserId()];
          try{
        req=[select id,name,
         Sponser__c,
         Employee__c,
         ContactPerson__c,
         Title__c,
         SponsorerAddress__c,
         Phone_Country_Code__c,
         Fax_CountryCode__c,
         PhoneAreaCode__c,
         FaxAreaCode__c,
         PhoneNo__c,
         FaxNo__c,
         Family_Sponsor__c
         from Requirement__c where contact__c=:user.contact.id and recordtypeid=:recid.id]; 
         Sponser_c=req.Sponser__c;
        // req.Sponser__c=Sponser_c;
           issetself();
            } catch(exception e){req=new Requirement__c();}  
            try{
         opp=[select id,Program_and_Location_Tab_Complete__c,Sponsor_of_Education__c from Opportunity where contact__c=:user.contact.id limit 1];
        // Primary_Program_Choice_c=opp.Primary_Program_Choice__c;
         if(opp.Program_and_Location_Tab_Complete__c==true)
                 {tab2=true;}
                 
                  } catch (exception e) {Opportunity opp = new Opportunity();} 
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
Schema.DescribeFieldResult F = Requirement__c.Sponser__c.getDescribe();
List<Schema.PicklistEntry> P = F.getPicklistValues();
options.add(new SelectOption('','--Select--'));            
for(Schema.PicklistEntry pickListvalues : P){
if((proName!='Bachelor of International Business Administration-UK-London') || (pickListvalues.getvalue()!='Employer'))
{
options.add(new SelectOption(pickListvalues.getvalue(),pickListvalues.getvalue()));            
}
}


return options;
}

    public void issetself()
    {
        if((Sponser_c=='') || (Sponser_c==null) || (Sponser_c=='Self') || (Sponser_c=='Undetermined'))
        {
        selfset=false;
        }
        else
        {
        selfset=true;
        }
        system.debug('*******'+selfset);
    }
    
public pagereference saveandcontinue()
{

            if(Sponser_c==null)
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please select Who will sponsor/fund your education?'));
            }
            
            if ((Sponser_c!=null) && (Sponser_c!='Self') && (Sponser_c!='Undetermined'))
            {
                    if((req.Family_Sponsor__c==null) && (Sponser_c=='Family'))
                    {
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please select Family Sponsor'));
                    }
                    
                    /*
                    if(req.ContactPerson__c==null)
                    {
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter Contact Person'));
                    }
                   if(req.SponsorerAddress__c==null)  
                    {
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter Address'));
                    }
                  if(req.Phone_Country_Code__c==null)
                    {
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please select Country'));
                    }
         
                  if(req.PhoneNo__c==null)
                    {
                        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter Main Number'));
                    }
                    */
            }  
 if(!apexpages.hasmessages()) 
            {
            if (Sponser_c=='Self')
            {
            req.Family_Sponsor__c=null;
            req.ContactPerson__c=null;
            req.SponsorerAddress__c=null;
            req.Phone_Country_Code__c=null;
            req.PhoneNo__c=null;
            req.Employee__c=null;
            req.Title__c=null;
            req.Fax_CountryCode__c=null;
            req.FaxNo__c=null;
            }       
            opp.Sponsorship_Tab_Complete__c=true;
            opp.Sponsor_of_Education__c = Sponser_c;
            update opp;
            req.recordtypeid=recid.id;
            req.Sponser__c=Sponser_c;
            req.contact__c=user.contact.id;
            req.Opportunity__c=opp.id;
            req.name='Sponsorship';
            upsert req;
            return page.ApplicantPersonalStatement;
            
}
else
{
return null;
}
}
public PageReference saveandcontinueandlogout() {
        if (saveandcontinue() == null)
            return null; // step2() returning null means there were errors, so drop back to the page.
        return new PageReference('/secur/logout.jsp');
    }

// Code for country list 
 public List<SelectOption> getcountryCode() {
 integer i=0;
        List<SelectOption> options = new List<SelectOption>();
        List<Country__c> cou=[select id,name,Calling_Code__c from country__c where Calling_Code__c!=null order by name asc];
        options.add(new SelectOption('','-Select-'));            
        for(i=0;i<cou.size();i++){
        options.add(new SelectOption(string.valueof(cou[i].id),cou[i].name+'('+cou[i].Calling_Code__c+')'));            
        }


        return options;
    } 
    
}