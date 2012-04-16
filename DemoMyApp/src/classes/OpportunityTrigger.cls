public virtual with sharing class OpportunityTrigger { 
    protected final Map<Id, Opportunity> opportunityOldMap = new Map<Id, Opportunity>();
    protected final Opportunity[] opportunityNewList = new Opportunity[] {};
    protected final Opportunity[] opportunityOldList = new Opportunity[] {};
    protected Setting_Disabled__c settingDisabled;
    private static Schema.DescribeSObjectResult describeResult;
    
    protected OpportunityTrigger(Opportunity[] opportunityOldList, Opportunity[] opportunityNewList) {
        this.opportunityNewList.addAll(opportunityNewList == null ? new Opportunity[] {} : opportunityNewList);
        this.opportunityOldList.addAll(opportunityOldList == null ? new Opportunity[] {} : opportunityOldList);
        this.opportunityOldMap.putAll(this.opportunityOldList);
    }
    
    protected Opportunity opportunityOld(Id opportunityId) {
        Opportunity opportunity = opportunityOldMap.get(opportunityId);
        return opportunity == null ? new Opportunity() : opportunity;
    }
    
    public virtual void executeWithUpdate() {
        execute();
        update opportunityNewList;
    }
    
    public virtual void execute() {}
    
    public static Schema.DescribeSObjectResult getDescribe() {
        if (describeResult == null)
            describeResult = Opportunity.SobjectType.getDescribe();
        return describeResult;
    }
    
    public Setting_Disabled__c getDisabledSetting() {
        if (settingDisabled == null)
            settingDisabled = Setting_Disabled__c.getInstance();
        if (settingDisabled == null)
            settingDisabled = new Setting_Disabled__c();
        return settingDisabled;
    }
}