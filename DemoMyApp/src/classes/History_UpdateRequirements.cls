public virtual with sharing class History_UpdateRequirements extends HistoryTrigger {
    public History_UpdateRequirements(History__c[] historyOldList, History__c[] historyNewList) {
        super(historyOldList, historyNewList);
    }
    
    public override virtual void execute() {
        
    }
    
    
}