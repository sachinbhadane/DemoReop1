@isTest(SeeAllData=true)
    private class Email_Counters_Updater_TestClass {
        public static testMethod void validate_Email_Counters_Updater() {

        Country__c country = [select Id from Country__c limit 1];
        Program__c program = [select Id from Program__c limit 1];
        
        Lead lead = new Lead();
        lead.FirstName = 'FirstName';
        lead.LastName = 'LastName';
        lead.Company = 'Company';
        lead.LeadSource = 'Undecided';
        lead.Email = 'cccded1d8f725170a1aad6a8147af7a8@example.com';
        lead.Applicant_Email__c = 'cccded1d8f725170a1aad6a8147af7a8@example.com'; // Added by Mahesh G, 3/12
        lead.Do_Not_Route__c = true;
        lead.Program_Primary__c = program.Id;
        lead.Country_of_Residence__c = country.Id;
        insert lead;
        
        Lead lead2 = new Lead();
        lead2.FirstName = 'FirstName';
        lead2.LastName = 'LastName';
        lead2.Company = 'Company';
        lead2.LeadSource = 'Undecided';
        lead2.Email = 'ccccded1d8f725170a1aad6a8147af7a8@example.com';
        lead2.Applicant_Email__c = 'ccccded1d8f725170a1aad6a8147af7a8@example.com'; // Added by Mahesh G, 3/12
        lead2.Do_Not_Route__c = true;
        lead2.Program_Primary__c = program.Id;
        lead2.Country_of_Residence__c = country.Id;
        lead2.Number_Central_Emails__c = NULL;
        insert lead2;

        campaign c= [select Id from campaign where id = '701U00000001ZZn'];    
        
        campaign c2= [select Id from campaign where id = '701U00000001YCN'];     
        
        xtma_Individual_Email_Result__c b = new xtma_Individual_Email_Result__c(Name='Behind the Cloud'
        , Lead__c=lead.id, Campaign__c=c.id);
     
        insert b;
        
        xtma_Individual_Email_Result__c b2 = new xtma_Individual_Email_Result__c(Name='Behind the Cloud'
        , Lead__c=lead2.id, Campaign__c=c2.id);
        
        insert b2;
        }
    }