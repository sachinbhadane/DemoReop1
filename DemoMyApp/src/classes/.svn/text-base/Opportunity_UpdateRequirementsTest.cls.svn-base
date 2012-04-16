/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class Opportunity_UpdateRequirementsTest 
{

    static testMethod void UpdateRequirementsTest() 
    {
    	Test.startTest();
    	// TO DO: implement unit test
    
        //Create Country Data
        Country__c objCountry = new Country__c( Name = 'DemoCountry',Calling_Code__c = 00,Country_Code__c  = 'pp',Region__c = 'MEA11'); //,CurrencyIsoCode = 'USD-U.S. Dollar'
        insert objCountry;
        
        //Create Requirements for Country Data
        Requirement__c objReqCountry = new Requirement__c(Name = 'CR',Country__c = objCountry.Id); //,CurrencyIsoCode = 'USD-U.S. Dollar'
        insert objReqCountry;
        
        //Create Department Data
        Department__c objDept = new Department__c(Name = 'Dept1');
        insert objDept;
        
        //Create Requirements for Department Data
        Requirement__c objReqDept = new Requirement__c(Name = 'CR00',Department__c = objDept.Id); //RecordTypeId = '012K0000000Cm9LIAS',
        insert objReqDept;
        
        //Create Program Data
        Program__c objProgram = new Program__c(Name = 'Program1',Country__c= objCountry.Id,Department__c = objDept.Id);
        insert objProgram;
        
        Program__c objProgramUpdate = new Program__c(Name = 'Program2',Country__c= objCountry.Id,Department__c = objDept.Id);
        insert objProgramUpdate;
        
        Requirement__c objReqProUpdate = new Requirement__c(Name = 'CR01',Program__c = objProgramUpdate.Id);
        insert objReqProUpdate;
        
        Requirement__c objReqProUpdate2 = new Requirement__c(Name = 'CR02',Program__c = objProgramUpdate.Id);
        insert objReqProUpdate2;
        
        //Create Requirements for Program Data
        Requirement__c objReqPro = new Requirement__c(Name = 'CR111',Program__c = objProgram.Id); //RecordTypeId = '012K0000000Cm9LIAS',
        insert objReqPro;
        
        
        //Requirements for Organization
       // Requirement__c objReq2 = new Requirement__c(RecordTypeId = '012K0000000Cm9LIAS',Name = 'CR111',CurrencyIsoCode = 'USD-U.S. Dollar', Account = objAccount.Id);
       // insert objReq2;
        
        //Applicant
        //Contact objContact = new Contact(LastName = 'Name1',Region__c = 'North Am',  Program_Primary__c = objProgram.Id ,Country_Of_Residence__c = objCountry.Id); //RecordTypeId = '012K0000000Cm9aIAC',
        //insert objContact;
        
        //Create Opportunity which contains above Three Data
        Account objAccount = new Account(Name = 'ORG1');
        insert objAccount;
        
        Opportunity opp = new Opportunity(StageName = 'Confirmed',Name = 'abc',CloseDate = System.today(),Program__c = objProgram.Id,AccountId = objAccount.Id); 
        insert opp;
        
        opp.Program__c = objProgramUpdate.Id;
        update opp;
        Test.stopTest();
    }
}