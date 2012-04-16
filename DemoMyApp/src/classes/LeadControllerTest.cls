// Below code is updated by Mahesh G with 3 fields on 12/9/2011 in order to update with Lead Validation rules.
@IsTest
private class LeadControllerTest {
    public static testmethod void test() {
        
    Country__c country1 = [select Id from Country__c limit 1];
    Program__c pro = [select id from Program__c limit 1];    
        Lead lead = new Lead();
        lead.Company = 'Company';
        lead.FirstName = 'FirstName';
        lead.FirstName = 'First Name';//Added by Mahesh G, updated test
        lead.LastName = 'LastName';
        lead.Email = 'lead123@testmail.com';
        lead.Applicant_Email__c = 'lead123@testmail.com';
        lead.Country_Of_Residence__c = country1.Id; //Added by Mahesh G
        lead.LeadSource = 'GMASS';//Added by Mahesh G
        lead.Program_Primary__c = pro.id;
        insert lead;
        
        new LeadController(new ApexPages.StandardController(lead)).initialize();
    }
}