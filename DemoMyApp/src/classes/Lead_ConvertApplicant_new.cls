public class Lead_ConvertApplicant_new {
    public class ConversionException extends Exception {}
    
    public String id;
    public Account account;
    public Contact[] con;
    public Lead lead;
    string pageRef;
    public Boolean showbutton{get;set;}
    
    public Lead_ConvertApplicant_new() {
        if (System.currentPagereference() != null) {
            id=System.currentPagereference().getParameters().get('id');
        }
    }
    
    public PageReference convert()
    {
        // Get Lead 
        lead = [
            select Program_Primary__c
                 , status 
                 , Convert_Now__c
                 , Program_Primary__r.Name
                 , Program_Primary__r.Campus__c
                 , Applicant_Email__c 
                 , Email
                 , Name
                 , Start_Term__c
              from Lead 
             where Id = :id 
             limit 1
        ]; //Added Program_Primary__r.Id by Mahesh Gaddam 11/23/2011
        
        if (lead.Convert_Now__c)
            return addMessage(ApexPages.Severity.Error, 'Unable to convert: This Lead is already converted.');
        if (lead.status == 'Duplicate')
            return addMessage(ApexPages.Severity.Error, 'Unable to convert: This is a duplicate lead.');

        if (lead.Program_Primary__c == null)
            return addMessage(ApexPages.Severity.Error, 'Unable to convert: Missing value for Primary Program field. This field is required at the converted Application level.');
        if (lead.Applicant_Email__c == null)
            return addMessage(ApexPages.Severity.Error, 'Unable to convert: Missing value for Applicant Email field.');
        if (lead.Start_Term__c == null)
            return addMessage(ApexPages.Severity.Error, 'Unable to convert: Missing value for Start Term field. This field is required at both the converted Applicant and Application level.');
        
        con = [
            select Id 
              from Contact 
             where (Email != null and Email = :lead.Email)
                or (Applicant_Email__c != null and Applicant_Email__c = :lead.Email) 
                or (Email != null and Email = :lead.Applicant_Email__c)
                or (Applicant_Email__c != null and Applicant_Email__c = :lead.Applicant_Email__c) 
        ];
        
        if (con.size() != 0)
            return addMessage(ApexPages.Severity.Error, 'Unable to convert: Email already in contact: ' + con);
        
        // Get Account id from lead program name
        try {
            account = [select OwnerId from Account where Name = :lead.Program_Primary__r.Name limit 1];
        } catch(Exception pException) { 
            account = [select OwnerId from Account where Id = :ApplicantRegistrationLoginController.PORTAL_ACCOUNT_ID limit 1];
        }
        
        // Change Lead status
        Database.LeadConvert leadConvert = new Database.LeadConvert();
        leadConvert.setAccountId(account.Id);
        leadConvert.setOwnerId(account.OwnerId);
        //leadConvert.setphone(lead.mobilePhone);
        
        // Set Lead Status
        LeadStatus convertStatus = [Select Id, MasterLabel from LeadStatus where IsConverted=true limit 1];
        leadConvert.setConvertedStatus(convertStatus.MasterLabel);
        leadConvert.setDoNotCreateOpportunity(false);
        leadConvert.setLeadId(id);
        // leadConvert.setSendNotificationEmail(false);
        
        // Run the conversion
        System.Savepoint pSavepoint = Database.setSavepoint();
        
        try {
            Database.LeadConvertResult leadConvertResult = Database.convertLead(leadConvert, false);
            
            if (leadConvertResult.isSuccess() == true) {
                // Update information on the new opportunity
                Opportunity opportunity = new Opportunity(Id = leadConvertResult.getOpportunityId());
                opportunity.Contact__c = leadConvertResult.getContactId();
                opportunity.Program__c = lead.Program_Primary__c;
                opportunity.Primary_Campus__c = lead.Program_Primary__r.Campus__c;
                opportunity.Start_Term__c = lead.Start_Term__c;
                opportunity.Name = lead.Name + ': ' + lead.Program_Primary__r.Name;
                update opportunity;
                
                addMessage(ApexPages.Severity.Confirm, 'Lead has been converted');
                showbutton = true;
            } else {
                return addMessage(ApexPages.Severity.Error, 'Lead did not convert: ' + leadConvertResult);
            }
        } catch (Exception pException) {
            Database.rollback(pSavepoint);
            throw pException;
        }
        
        return  null;
    }
    
    public PageReference back() {
        return new PageReference('/'+id);
    }
    
    public PageReference addMessage(ApexPages.Severity severity, String message) {
        if (System.currentPageReference() == null && severity == ApexPages.Severity.Error)
            throw new Lead_ConvertApplicant_new.ConversionException(message);
        else if (System.currentPageReference() != null)
            ApexPages.addMessage(new ApexPages.message(severity, message));
        return null;
    }
}