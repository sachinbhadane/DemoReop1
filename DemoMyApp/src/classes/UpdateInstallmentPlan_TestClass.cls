@isTest(SeeAllData=true)
    private class UpdateInstallmentPlan_TestClass {
        public static testMethod void validate_UpdateInstallmentPlan() {

        Opportunity opp= [select id from Opportunity where id = '006U00000030BRf'];      
        
        Opportunity_Finance__c oppFin= [select id from Opportunity_Finance__c where id = 'a0XU0000000A50c']; 
        
        opp.Program__c = 'a0JU00000009Jm9';
        update opp;
        
        opp.Program__c = 'a0JU00000009Jm0';
        update opp;
        
        update oppFin;
        }
    }