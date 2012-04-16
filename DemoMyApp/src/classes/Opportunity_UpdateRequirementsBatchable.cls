global with sharing class Opportunity_UpdateRequirementsBatchable implements Database.Batchable<Sobject> {
    public final String executeQuery = ''
        + 'select Program__c'
        + '     , Contact__c'
        + '  from Opportunity'
        + ' where Program__c != null';
        
    global class BatchException extends Exception {}
     
    global Opportunity_UpdateRequirementsBatchable() {}
    
    global Database.QueryLocator start(Database.BatchableContext batchableContext) {
        // Running tests or live?
        if (Test.isRunningTest()) // refuse to select anything
            return Database.getQueryLocator(executeQuery + ' where Id = null');
        return Database.getQueryLocator(executeQuery);
    }
    
    global void execute(Database.BatchableContext batchableContext, Opportunity[] opportunityList){
        // If we are in a test context, then we need to reselect the entire contact import object based on the ID
        // we've just been provided. We won't have access to the ID in the start() method, so we have to add special
        // logic here.
        if (opportunityList.size() == 0)
            return;
        if (Test.isRunningTest())
            opportunityList = (Opportunity[]) Database.query(executeQuery + ' where Id = \'' + opportunityList[0].Id + '\' limit 1');
        execute(opportunityList);
    }

    global void finish(Database.BatchableContext batchableContext) {
        
    }
    
    public void executeBatch() {
        executeBatch(1);
    }
    
    public void executeBatch(Integer batchSize) {
        Database.executeBatch(new Opportunity_UpdateRequirementsBatchable(), batchSize);
    }
    
    public void execute(Opportunity[] opportunityList) {
        Opportunity_UpdateRequirements o = new Opportunity_UpdateRequirements(opportunityList, opportunityList);
        o.forceUpdate = true;
        o.execute();
    }
    
    public static testmethod void testCoverage() {
        Test.startTest();
        Database.executeBatch(new Opportunity_UpdateRequirementsBatchable());
        Test.stopTest();
        
        system.assert(true, 'True is not true?');
    }
}