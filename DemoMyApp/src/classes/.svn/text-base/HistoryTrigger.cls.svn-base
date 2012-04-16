public virtual with sharing class HistoryTrigger {
    protected final Map<Id, History__c> historyOldMap = new Map<Id, History__c>();
    protected final History__c[] historyNewList = new History__c[] {};
    protected final History__c[] historyOldList = new History__c[] {};
    private static Schema.DescribeSObjectResult describeResult;
    
    protected HistoryTrigger(History__c[] historyOldList, History__c[] historyNewList) {
        this.historyNewList.addAll(historyNewList == null ? new History__c[] {} : historyNewList);
        this.historyOldList.addAll(historyOldList == null ? new History__c[] {} : historyOldList);
        this.historyOldMap.putAll(this.historyOldList);
    }
    
    protected History__c historyOld(Id historyId) {
        History__c history = historyOldMap.get(historyId);
        return history == null ? new History__c() : history;
    }
    
    public virtual void execute() {}
    
    public static Schema.DescribeSObjectResult getDescribe() {
        if (describeResult == null)
            describeResult = History__c.SobjectType.getDescribe();
        return describeResult;
    }
}