@IsTest 
private class Lead_EmailDuplicatePreventerTest { 
    public static final Country__c  country = [select Id, Name from Country__c limit 1]; 

    @IsTest
    public static void test1() {
        final String EMAIL_MIXED_CASE = 'TestContact@test1.com';
        final String EMAIL_LOWER_CASE = EMAIL_MIXED_CASE.toLowerCase();
          
        Account account = [select Id from Account limit 1];
        Program__c program = [select Id from Program__c limit 1];
        
        Contact contacts1 = new Contact();
        contacts1.LastName = 'TestContact';
        contacts1.Email = EMAIL_MIXED_CASE;
        contacts1.Applicant_Email__c = EMAIL_MIXED_CASE;
        contacts1.AccountId = account.Id;
        contacts1.Program_Primary__c = program.Id;
        contacts1.Country_Of_Residence__c = country.Id;
        contacts1.Start_Term__c = 'Undecided';
        insert contacts1;
        
        System.debug('::Lead_EmailDuplicatePreventerTest::test1() ::contacts1.Email ==>'+contacts1.Email);
        system.assertEquals( EMAIL_LOWER_CASE, [
            select Email
              from Contact
             where Id = :contacts1.Id
        ].Email);
        
        Lead lead1 = new Lead();
        lead1.FirstName = 'FirstName1';
        lead1.LastName = 'LastName1';
        lead1.Company = 'Company1';
        lead1.Email = 'testcontact@test2.com';
        lead1.Applicant_Email__c = 'testcontact@test2.com';
        lead1.LeadSource = 'Alumni';
        lead1.Status = 'Contacted';
        lead1.Country_Of_Citizenship__c = country.id;
        lead1.Country_Of_Residence__c = country.id;
        lead1.Program_Primary__c = program.id;
        insert lead1;
        
        Lead lead2 = new Lead();
        lead2.FirstName = 'FirstName1';
        lead2.LastName = 'LastName1';
        lead2.Company = 'Company1';
        lead2.Email = '';
        lead2.Applicant_Email__c = 'testcontact@test3.com';
        lead2.LeadSource = 'Alumni';
        lead2.Status = 'Contacted';
        lead2.Country_Of_Citizenship__c = country.id;
        lead2.Country_Of_Residence__c = country.id;
        lead2.Program_Primary__c = program.id;
        insert lead2; 
        
        try {
            lead2.Email = EMAIL_MIXED_CASE;
            update lead2;
          } catch (System.dmlException e) {
            System.debug ('Updating with duplicate failed !!!  This is good');
        }
    } 
 }