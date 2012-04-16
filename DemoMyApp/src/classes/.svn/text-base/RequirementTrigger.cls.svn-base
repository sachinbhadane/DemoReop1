public virtual with sharing class RequirementTrigger {
    protected final Map<Id, Requirement__c> requirementOldMap = new Map<Id, Requirement__c>();
    protected final Requirement__c[] requirementNewList = new Requirement__c[] {};
    protected final Requirement__c[] requirementOldList = new Requirement__c[] {};
    private static Schema.DescribeSObjectResult describeResult;
    
    protected RequirementTrigger(Requirement__c[] requirementOldList, Requirement__c[] requirementNewList) {
        this.requirementNewList.addAll(requirementNewList == null ? new Requirement__c[] {} : requirementNewList);
        this.requirementOldList.addAll(requirementOldList == null ? new Requirement__c[] {} : requirementOldList);
        this.requirementOldMap.putAll(this.requirementOldList);
    }
    
    protected Requirement__c requirementOld(Id requirementId) {
        Requirement__c requirement = requirementOldMap.get(requirementId);
        return requirement == null ? new Requirement__c() : requirement;
    }
    
    public virtual void execute() {}
    
    public static Schema.DescribeSObjectResult getDescribe() {
        if (describeResult == null)
            describeResult = Requirement__c.SobjectType.getDescribe();
        return describeResult;
    }
}