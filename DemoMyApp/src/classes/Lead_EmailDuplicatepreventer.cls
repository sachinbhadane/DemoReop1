/***************************************************************************************
Class Name       : Lead_EmailDuplicatepreventer 
Author           : Mahesh Gaddam
Created Date     : January 09, 2012
Usage            : This triggers is on Lead on Before Insert& Before Update. 
                 : This trigger prevents user from creating duplicate email ids for email ids already existing in Contact.               
Revision History :                 
****************************************************************************************/
public without sharing class Lead_EmailDuplicatepreventer extends LeadTrigger {
    public Lead_EmailDuplicatepreventer(Lead[] leadOldList, Lead[] leadNewList) {
        super(leadOldList, leadNewList);
    }
    
    public override void execute() {
        //return; DISABLED TEMPORARILY
        
       
        // Build a list of all emails
        Set<String> leadEmails = new Set<String> {};
        
        for(Lead leadNew : leadNewList) {
            Lead leadOld = leadOld(leadNew.Id);
            
            if (leadNew.Email != null && leadNew.Email.equalsIgnoreCase(leadOld.Email) == false)
                leadEmails.add(leadNew.Email.toLowerCase()); 
            if (leadNew.Applicant_Email__c != null && leadNew.Applicant_Email__c.equalsIgnoreCase(leadOld.Applicant_Email__c) == false)
                leadEmails.add(leadNew.Applicant_Email__c.toLowerCase());
        }
            // Salesforce automatically lower cases emails, but the original data on the lead
            // might not yet be lower case, so we do it here.
        
        
        if (leadEmails.size() == 0)
            return;
        
        // Find all contacts with any of those
        Set<String> contactEmailsFound = new Set<String> {}; 
        
        Contact[] contactList = [
            select Email
                 , Applicant_Email__c
              from Contact
             where (Email in :leadEmails and Email != null) // just in case
                or (Applicant_Email__c in :leadEmails and Applicant_Email__c != null)
        ];
        
        if (contactList.size() == 0)
            return;
        
        for (Contact contact : contactList) { 
            if (contact.Email != null)
                contactEmailsFound.add(contact.Email);
            if (contact.Applicant_Email__c != null)
                contactEmailsFound.add(contact.Applicant_Email__c);
        } 
        
        // Reloop and add error messages
        for(Lead leadNew : leadNewList) {
            if (leadNew.Email != null && contactEmailsFound.contains(leadNew.Email))
                leadNew.Email.addError('Email already in use');
            if (leadNew.Applicant_Email__c != null && contactEmailsFound.contains(leadNew.Applicant_Email__c))
                leadNew.Applicant_Email__c.addError('Email already in use');
        }
     } 
}