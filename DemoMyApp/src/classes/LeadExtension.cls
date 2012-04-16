public virtual with sharing class LeadExtension {
    Id leadId;
    
    public LeadExtension(Id leadId) {
        this.leadId = leadId;
    }
    
    public LeadExtension(ApexPages.StandardController controller) {
        this.leadId = controller.getId();
    }
    
    public Id getLeadId() {
        return leadId;
    }
}