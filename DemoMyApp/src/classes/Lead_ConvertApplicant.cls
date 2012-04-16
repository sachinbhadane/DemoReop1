public virtual with sharing class Lead_ConvertApplicant extends LeadController {
    public Lead_ConvertApplicant(ApexPages.StandardController controller) {
        super(controller);
    }

    public override virtual PageReference initialize() {
        super.initialize();
        
        Lead lead = [
            select Program_Primary__r.Name
              from Lead
             where Id = :getId()
             limit 1
        ];
        
        Account account = [
            select OwnerId
              from Account
             where Name = :lead.Program_Primary__r.Name
             limit 1
        ];
        
        Database.LeadConvert leadConvert = new Database.LeadConvert();
        leadConvert.setAccountId(account.Id);
        leadConvert.setConvertedStatus('Closed - Converted');
        leadConvert.setDoNotCreateOpportunity(false);
        leadConvert.setLeadId(getId());
        leadConvert.setOwnerId(account.OwnerId);
        leadConvert.setSendNotificationEmail(false);
        
        // Run the conversion
        
        Database.LeadConvertResult leadConvertResult = Database.convertLead(leadConvert, false);
        
        system.assert(leadConvertResult.isSuccess(), 'Failed to convert lead');
        
        // Update information on the new opportunity
        Opportunity opportunity = new Opportunity(Id = leadConvertResult.getOpportunityId());
        opportunity.Contact__c = leadConvertResult.getContactId();
        opportunity.Program__c = lead.Program_Primary__r.Id;
        update opportunity;
        
        return new PageReference('/' + opportunity.Id);
    }
}