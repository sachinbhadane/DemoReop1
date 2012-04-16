public with sharing class Attachment_SetRequirementSupplied extends AttachmentTrigger {
    public Attachment_SetRequirementSupplied(Attachment[] attachmentOldList, Attachment[] attachmentNewList) {
        super(attachmentOldList, attachmentNewList);
    }
    
    // This trigger applies when an attachment has been uploaded to a requirement.
    
    public virtual override void execute() {
        Set<Id> attachmentParentIds = new Set<Id> {};
        
        for(Attachment attachmentNew : attachmentNewList)
            attachmentParentIds.add(attachmentNew.ParentId);
        
        Requirement__c[] requirementUpdateList = [
            select Id
              from Requirement__c
             where Id in :attachmentParentIds
               and Supplied__c = false
        ];
        
        for(Requirement__c requirement : requirementUpdateList) {
            requirement.Supplied__c = true;
            requirement.Supplied_Date__c = Date.today();
        }
        
        update requirementUpdateList;
    }
}