// test class for testforLead_ConvertApplicant_new
// Below code is updated by Mahesh G with 2 fields on 12/9/2011 in order to update with Lead Validation rules.
@IsTest
private class TestFortestforLead_ConvertApplicant_new {
    static testMethod void testforLead_ConvertApplicant() { 
        
    Country__c country1 = [select Id from Country__c limit 1];
    Program__c pro = [select id from Program__c limit 1];
    
        Lead lead= new lead(FirstName='Yogendra', 
                            LastName='Rathi',
                            company='netsutra.com',
                            Email='user@netsutra.com', 
                            Applicant_Email__c ='user@netsutra.com', 
                            Country_Of_Residence__c = country1.Id, //Added by Mahesh G
                            LeadSource = 'GMASS',//Added by Mahesh G
                            Program_Primary__c = pro.id,
                            HasOptedOutOfEmail=false);
        insert lead;
        System.currentPagereference().getParameters().put('id',lead.id);  
        Lead_ConvertApplicant_new controller = new Lead_ConvertApplicant_new();
        controller.convert();
        controller.back();
    } 
}