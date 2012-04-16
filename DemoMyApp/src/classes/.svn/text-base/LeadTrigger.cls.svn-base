public virtual with sharing class LeadTrigger {
    protected final Map<Id, Lead> leadOldMap = new Map<Id, Lead>();
    protected final Lead[] leadNewList = new Lead[] {};
    protected final Lead[] leadOldList = new Lead[] {};
    
    protected LeadTrigger(Lead[] leadOldList, Lead[] leadNewList) {
        this.leadNewList.addAll(leadNewList == null ? new Lead[] {} : leadNewList);
        this.leadOldList.addAll(leadOldList == null ? new Lead[] {} : leadOldList);
        this.leadOldMap.putAll(this.leadOldList);
    }
    
    protected Lead leadOld(Id leadId) {
        Lead lead = leadOldMap.get(leadId);
        return lead == null ? new Lead() : lead;
    }
    
    public virtual void execute() {}
}