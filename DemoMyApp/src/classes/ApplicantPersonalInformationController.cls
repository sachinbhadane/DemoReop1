public class ApplicantPersonalInformationController {
    
    public boolean finalsubmit{get;set;}
    public Contact con {get; set;}
    public User currentUser {get; set;}
    public string birthday{get;set;}
    public string birthmonth{get;set;}
    public string birthyear{get;set;}
    private Date birthdate;
    private Opportunity opp {get; set;}
    private Map <Id, Country__c> countries = new Map <Id, Country__c> ([Select Id, Name FROM Country__c]);
    
    public ApplicantPersonalInformationController () {
        
        countries.put (null, new Country__c ()); // to avoid null pointer exception when page loads with no country selected
        con = new Contact ();
        currentUser = new User ();
        opp = new Opportunity ();
        
        
        try {
            currentUser = [SELECT Id, ContactId FROM User WHERE Id = :UserInfo.getUserId()];
            con = [SELECT Id
                    , Name
                    , FirstName
                    , LastName
                    , Salutation
                    , Email
                    , MailingStreet
                    , MailingCity
                    , MailingState
                    , MailingPostalCode
                    , MailingCountry
                    , Mailing_Country__c
                    , Accountid
                    , Title
                    , Phone
                    , Suffix__c
                    , Gender__c
                    , Country_Of_Citizenship__c
                    , Country_Of_Origin__c
                    , Country_Of_Residence__c
                    , Birthdate
                    , Language__c
                    , isEnglishNative__c
                    , Language_English_Speaking__c
                    , Language_English_Listening__c
                    , Language_English_Writing__c
                    , Language_English_Reading__c
                    , Language_Other__c
                    , Agent_Email__c
                    , Agent_Name__c
                    , Applicant_Email__c
                    , LeadSource
                    , Lead_Source_User_Supplied__c
                    , Nationality__c
                    , Home_Phone_Country_Code__c
                    , Home_Phone_Area_Code__c
                    , Home_Phone_Main_Number__c
                    , Mobile_Phone_Country_Code__c
                    , Mobile_Phone_Area_Code__c
                    , Mobile_Phone_Main_Number__c 
                    
                FROM Contact WHERE Id = :currentUser.ContactId];
                
                //prepopulate fields when page loads
                if (con.Birthdate != null) {
                    birthday = string.valueOF(con.Birthdate.day());
                    birthmonth = string.valueOF(con.Birthdate.month());
                    birthyear = string.valueOF(con.Birthdate.year());
                }
                
                
                
        } catch (Exception e) {
            ApexPages.addmessages (e);
        }
        
        
        List <Opportunity> oppList = new List <Opportunity> ();
        oppList = [SELECT Id, Name FROM Opportunity WHERE Contact__c =:con.Id];
        
        if (oppList.isEmpty()) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.Warning, 'Please complete Program/Location Section'));
            
        }
        
        
        // to lock visualforce page----
         try {
            ApplicantFinalController contrl= new ApplicantFinalController();
            contrl.getopp();
            finalsubmit=ApplicantFinalController.finalsubmit;
         }
         catch (Exception e){
            ApexPages.addMessages(e);
         }

        
    }
    
    
    
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
            
            
            return renderStatesList();
        }
        
        private  List<SelectOption> renderStatesList () {
        
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','-Select-')); 
        
        for (States__c s: [SELECT Name, Country__c, StateShortName__c FROM States__c WHERE Country__c = :countries.get(con.Mailing_Country__c).Name ORDER BY Name]) {
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
        
        
         public PageReference SaveAndContinue() {
            
            if (con.isEnglishNative__c) {
                con.Language_English_Speaking__c = null;
                con.Language_English_Listening__c = null;
                con.Language_English_Writing__c = null;
                con.Language_English_Reading__c = null;
                con.Language__c = 'English';
            }
            
            if (con.firstname==null)
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter First Name'));
            if ((con.lastname.trim()=='') || (con.lastname==null))
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter Last Name'));
            if (con.Gender__c==null)
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please select Gender'));
            if (con.Country_Of_Origin__c == null)
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter Nationality'));
            if (con.Country_Of_Residence__c == null)
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter Country of Residence'));
           
            if((birthday.trim()=='') ||  (birthmonth.trim()=='') || (birthyear.trim()=='')) {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter Birthdate (mm/dd/yyyy)'));
            } else {
                try {
                    birthdate =  date.valueof(birthyear+'-'+birthmonth+'-'+birthday);
                } catch(exception e) {
                    apexpages.addmessages(e);
                }
            }//end if for birthdate
            
            if ((birthdate!=null) && (birthdate>date.today()))
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Birthdate should be less than today date'));
            if (con.Lead_Source_User_Supplied__c==null)
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please select "Where did you hear about Us?"'));
            if (con.mailingstreet==null)
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter Street'));
            if (con.mailingcity==null)
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter City'));
            if (con.mailingstate==null)
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter State/Province'));
            if (con.mailingpostalcode==null)
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter Zip/Postal Code'));
            if (con.Mailing_Country__c==null)
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please select Country'));
    
            if (con.Home_Phone_Country_Code__c==null)
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter phone country code'));
            if ((con.Home_Phone_Main_Number__c==null) || (con.Home_Phone_Main_Number__c.trim()=='')){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter main phone number'));}
            if (con.Language__c==null )
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter your native language'));
            
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
        
            
    
            if (apexpages.hasmessages())
                return null; 
            
          
            
            try { 
                opp = [ SELECT Primary_Program_Choice__c,Primary_Campus__c, stageName
                                ,  Personal_Information_Complete__c
                                , Contact__c, Primary_Interest__c 
                        FROM Opportunity
                        WHERE Contact__c=:con.id ];
                if(countries.get(con.Country_Of_Origin__c).name=='China' && opp.Primary_Program_Choice__c=='Executive MBA' && opp.Primary_Campus__c=='Shanghai') {
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Programs offered on Hult\'s Shanghai campus are not available for China nationals. We encourage Chinese nationals to apply to Hult\'s other campuses in Boston, San Francisco,London, and Dubai.'));
                    return null;
                }       
                
                con.Applicant_Email__c=con.email;
                con.Birthdate= birthdate;
                con.MailingCountry = countries.get(con.Mailing_Country__c).Name;
                update con;
                
               
                opp.contact__c = con.id;
                opp.Personal_Information_Complete__c = true;
                update opp;
                return Page.ApplicantEducation;
                
            } catch (Exception e) {
                ApexPages.addMessages(e); 
                return null;
            }

        }
        
        public PageReference SaveAndLogout() {
            if (SaveAndContinue() == null)
                return null; // step2() returning null means there were errors, so drop back to the page.
            return new PageReference('/secur/logout.jsp');
        }
        
        
        public static testMethod void testApplicantPersonalInformation () {
            
            Country__c country = new Country__c (Name='United States');
            insert country;
            
            States__c states = new States__c (Name='Test', StateShortName__c = 'TEST', Country__c = 'United States');
            insert states;
            
            User u = [select Id, Contact.Birthdate, Contact.Language__c, contact.Country_Of_Residence__c,
                                  contact.Country_Of_Origin__c,
                                  contact.mailingstreet,
                                  contact.mailingcity,
                                  contact.mailingstate,
                                  contact.mailingpostalcode,
                                  contact.mailingcountry,
                                  contact.mailing_country__c,
                                  contact.isEnglishNative__c
                                  from User where isActive=true AND ContactId != null LIMIT 1];
            // populate required field
            
            u.contact.birthdate = System.Today();
            u.contact.language__c = 'English';
            u.contact.Gender__c = 'Male';
            u.contact.Country_Of_Origin__c = country.Id;
            u.contact.Country_Of_Residence__c = country.Id;
            u.contact.MailingStreet = '123';
            u.contact.MailingCity = '123';
            u.contact.MailingState = 'Minnesota';
            u.contact.MailingPostalCode = '55555';
            u.contact.MailingCountry = 'United States';
            u.contact.Mailing_Country__c = country.id;
            u.contact.Language__c = 'English';
            u.contact.isEnglishNative__c = true;
            
            update u.contact;
            
            System.runAs(u){
                ApplicantPersonalInformationController test = new ApplicantPersonalInformationController ();
                test.birthday = '02';
                test.birthmonth = '11';
                test.birthyear = '1988';
                test.getclist();
                test.getcountrycode();
                test.getStatesList();
                test.saveAndContinue();
                test.SaveAndLogout();
            }
        }
        
        
}