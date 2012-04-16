public class ApplicantRegistrationLoginController {
    public class InternalException extends Exception {}    
    public User user { get; set; }
    public Contact con { get; set; }
    public Account account;
    public Contact[] Leadcon;
    public List<Lead> lead;
    public String fname { get; set; }
    public String lname { get; set; }
    public String email { get; set; }
    public String email1 { get; set; }
    public string agentEmail{get;set;}
    public String password1 { get; set; }
    public String password { get; set; }
    public String confirmPassword { get; set; }
    public String communityNickname{get; set;}
    public String oldcontact { get; set; }
    public static ID PORTAL_ACCOUNT_ID = [select Id from Account where Name = 'Undecided Accounts' limit 1].id;
    public static ID applicant_recordtype_id = [select Id from recordtype where Name = 'Hult Applicant' and sobjecttype='contact' limit 1].id;
    public String userType {get; set;} 
    
    private Map <Id, Country__c> countries = new Map <Id, Country__c> ([Select Id, Name FROM Country__c]);
    
    public static String getusername(Integer len) {
        Blob blobKey = crypto.generateAesKey(128);
        String key = EncodingUtil.convertToHex(blobKey);
        return key.substring(0,len);
    }
    
    
    public ApplicantRegistrationLoginController() {
        countries.put (null, new Country__c ()); // to avoid null pointer exception when page loads with no country selected
        con = new Contact ();
        user = new User ();
        userType = UserInfo.getUserType();        
    }
    
    public PageReference RedirectHome () {        
        if (UserInfo.getUserType() == 'CSPLitePortal')
        return Page.ApplicantProgramLocation;
        
        else return null;
    }
    public boolean isAgent;
    public PageReference agentPage(){
        isAgent = true;
        return null;
    
    }
    
    public PageReference step1() {
      
        Profile profileid = [select Id from Profile where Name = 'Applicant Customer Portal User'];
        
        if (fname.trim() == '')
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.error, 'Please enter a valid first name'));
        if (lname.trim() == '')
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.error, 'Please enter a valid last name'));
        if(isAgent==true && agentEmail.trim()=='')
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.error, 'Please enter agent email address'));
        if (password.trim() == '')
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.error, 'Please enter password'));
        if (confirmPassword.trim() == '')
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.error, 'Please confirm password'));
        if (confirmPassword.trim() != password.trim())
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.error, 'Passwords do not match'));
        
        if (ApexPages.hasMessages() == false) {
            // Code for Convert lead to contact
               try{
                    // Get Lead 
                    lead = [select Program_Primary__r.Id, Program_Primary__r.Name, Applicant_email__c from Lead where Applicant_email__c= :email limit 1]; //Added Program_Primary__r.Id by Mahesh Gaddam 11/23/2011
                    Leadcon = [select id from contact where email != null and email=:lead[0].Applicant_email__c limit 1];
                    if (lead.size() > 0 && Leadcon.size()==0 ) {
                    // Get Account id from lead program name
                        try {
                            account = [select OwnerId from Account where Name = :lead[0].Program_Primary__r.Name limit 1];
                        } 
                        catch(Exception pException) { 
                            account = [select OwnerId from Account where Id = :PORTAL_ACCOUNT_ID limit 1];
                           // ApexPages.addmessages(pException);
                          //  return null;
                        }
                        
                        // Change Lead status
                        Database.LeadConvert leadConvert = new Database.LeadConvert();
                        leadConvert.setAccountId(account.Id);
                        leadConvert.setOwnerId(account.OwnerId);        
                        
                        // Set Lead Status
                        LeadStatus convertStatus = [Select Id, MasterLabel from LeadStatus where IsConverted=true limit 1];
                        leadConvert.setConvertedStatus(convertStatus.MasterLabel);
                        leadConvert.setDoNotCreateOpportunity(false);                        
                        leadConvert.setLeadId(lead[0].id);
                        // leadConvert.setSendNotificationEmail(false);
                        
                        // Run the conversion
                        
                        Database.LeadConvertResult leadConvertResult = Database.convertLead(leadConvert, false);
                        
                        if (leadConvertResult.isSuccess()) {
                            List<contact> cc = [select email from contact where id=:leadConvertResult.getContactId() limit 1];
                            if(cc.size()>0){
                                cc[0].email=lead[0].Applicant_email__c;
                                update cc[0];
                            }
                            // Update information on the new opportunity
                            Opportunity opportunity = new Opportunity(Id = leadConvertResult.getOpportunityId());
                            opportunity.Contact__c = leadConvertResult.getContactId();
                            opportunity.Program__c = lead[0].Program_Primary__r.Id;
                            //opportunity.Program_and_Location_Tab_Complete__c = true;
                            update opportunity;
                            
                            //addMessage(ApexPages.Severity.Confirm, 'Lead has been converted');            
                        } else {            
                            //ApexPages.addMessage(new ApexPages.message(ApexPages.severity.error, 'Lead did not convert: ' + leadConvertResult));
                            //updateLead(email);
                            
                        }        
                       // ApexPages.addMessage(new ApexPages.message(ApexPages.severity.error, 'Lead Converted'));
                       
                        
                    }
                    else{
                         //updateLead(email);
                    }
               }
               catch(exception e){                            
               }
            // End code for convert lead
            
                List<User> userList = [select id from user where email = :email limit 1];
                List<Contact> contactList = [select id from contact where email = :email limit 1];
                
                if ((userList.size() == 0) && (contactList.size() == 0)) {
                    //write code here to create new user where user and contact not found
                    User user = new User(); 
                    user.CommunityNickname = fname+getusername(9);
                    user.Username = email;
                    user.firstname = fname;
                    user.lastname= lname;
                    user.email = email;
                    user.IsActive = true;
                    user.ProfileID = profileid.Id;
                    
                    try {
                        
                        String userId = Site.createPortalUser(user, PORTAL_ACCOUNT_ID , password);
                        updateContact (userId); 
                        insertContactOpportunity(userId);
                        // Deactive Lead in exist
                        updateLead(user.email);
                        return Site.login(user.Username, password, '/ApplicantMypage');
                        
                    } catch (Exception e) { 
                        ApexPages.addMessages(e);
                        return null;
                    }    
                } else if((userList.size() == 0) && (contactList.size() == 1)) {
                    User user = new User();
                    user.Email = email;
                    user.ProfileId = profileId.Id;
                    user.FirstName = fname;
                    user.LastName = lname;
                    user.Username = email;
                    user.CommunityNickname = fname+getusername(9);
                    user.ContactId = contactList[0].Id;
                    user.Alias = getusername(8);
                    user.TimeZoneSidKey = 'America/New_York';
                    user.LocaleSidKey = 'en_US';
                    user.EmailEncodingKey = 'UTF-8';
                    user.LanguageLocaleKey = 'en_US';
                    user.IsActive = true;
                    
                    try {
                        insert user;
                        // update country of residence and state if applicable
                        updateContact (user.Id); 
                       // insertContactOpportunity(user.Id);                   
                        
                        // Set the password to a default value
                        system.setPassword(user.Id, password);
                        
                        // Deactive Lead in exist                    
                         updateLead(user.email);
                         
                        return Site.login(user.Username, password, '/ApplicantMypage');
                    } catch (Exception e) {
                        ApexPages.addMessages (e);  
                    }
                } else {
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'User with this email address is already registered in our system. Please use \'Forgot your password?\' to get login details or use a different email address.'));   
                }
                
        }
        
        return null;
    }
    
    public void updateContact (String uId) {
        User user = [SELECT Id, ContactId FROM User WHERE Id =:uId];
        Contact contact = [SELECT Agent_Email_Address__c, Id, Country_Of_Residence__c, MailingState FROM Contact WHERE Id = :user.contactId];
        contact.Country_Of_Residence__c = con.Country_Of_Residence__c; 
        contact.MailingCountry = countries.get(con.Country_Of_Residence__c).name;
        contact.Mailing_Country__c = con.Country_Of_Residence__c;
        contact.MailingState = con.MailingState;
        contact.Agent_Email_Address__c = agentEmail;
        // code for set recordtype
        contact.recordtypeid=applicant_recordtype_id;
        update contact;
    }
    
    public void updateLead(String email){
        List<lead> lead = [select id,Convert_Now__c,Status from lead where Applicant_Email__c!=null and Applicant_Email__c=:email and Convert_Now__c=false and IsConverted=false];
        if(lead.size()>0){
            List<lead> newLead = new List<lead>();
            for(lead ll : lead){
                ll.status = 'Duplicate';
                ll.Convert_Now__c = true;
                newLead.add(ll);
            }
            update newLead;
        }        
    }
    
    public void insertContactOpportunity(String userId) {
        User user = [
            select Name
                 , Contact.Account.Name
                 , Contact.AccountId
                 , Contact.OwnerId
              from User
             where Id = :userId
        ];
        
        if (user == null) 
            throw new InternalException('ApplicantRegistrationLoginController.insertContactOpportunity(): unable to select user record');
        if (user.Contact == null) 
            throw new InternalException('ApplicantRegistrationLoginController.insertContactOpportunity(): user record is not related to portal contact record');
        if (user.Contact.AccountId == null) 
            throw new InternalException('ApplicantRegistrationLoginController.insertContactOpportunity(): contact record is missing an AccountId');
     
        
        // Does the contact (for whatever reason) already have an opp associated?
        Integer opportunityCount = [
            select count()
              from Opportunity
             where Contact__c = :user.Contact.Id
        ];
        
        if (0 != opportunityCount)
            throw new InternalException('ApplicantRegistrationLoginController.insertContactOpportunity(): contact record is already associate to at least one application');
        
        // Try to find the "Undecided-Undecided" program
        Program__c[] programUndecidedList1 = [
            select Id
              from Program__c
             where Name = 'Undecided-Undecided'
             limit 1
        ];
        
        Program__c[] programUndecidedList2 = [
            select Id
              from Program__c
             where Name = 'Undecided'
             limit 1
        ];
        
        Opportunity opportunity = new Opportunity();
        opportunity.AccountId = user.Contact.AccountId;
        opportunity.Application_Status__c = 'Active';
        opportunity.CloseDate = Date.today();
        opportunity.Contact__c = user.Contact.Id;
        opportunity.Name = user.Name;
        opportunity.OwnerId = user.Contact.OwnerId;
        opportunity.StageName = 'Qualified Lead';
        
        // Try to find an undecided program to put them under
        if (programUndecidedList1.size() == 1)
            opportunity.Program__c = programUndecidedList1[0].Id;
        else if (programUndecidedList2.size() == 1)
            opportunity.Program__c = programUndecidedList2[0].Id;
        
        insert opportunity;
        
    }
    
    public PageReference login() {
        try {
            return Site.login(email1, password1, '/ApplicantMypage');
        } catch (Exception e) {
            ApexPages.addmessages(e);
        }
        
        return null;
    }
    
    // Code for country list 
    public List<SelectOption> getclist() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','-Select-'));
        
        for(Country__c country: [
            select Name 
              from Country__c 
             where Name != '-Did Not Respond-' 
          order by Name asc
        ]) options.add(new SelectOption(country.Id, country.Name));
        
        return options;
    }
    
    
    
    public  List<SelectOption> getStatesList () {
        return renderStatesList ();
    }
    
    private  List<SelectOption> renderStatesList () {
        
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','-Select-')); 
        
        for (States__c s: [SELECT Name, Country__c, StateShortName__c FROM States__c WHERE Country__c = :countries.get(con.Country_Of_Residence__c).Name ORDER BY Name]) {
            options.add (new SelectOption (s.Name, s.Name));
        }
        
        return options;
    }
     
}