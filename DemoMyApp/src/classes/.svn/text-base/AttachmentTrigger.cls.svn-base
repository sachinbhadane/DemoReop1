public virtual with sharing class AttachmentTrigger {
    protected final Map<Id, Attachment> attachmentOldMap = new Map<Id, Attachment>();
    protected final Attachment[] attachmentNewList = new Attachment[] {};
    protected final Attachment[] attachmentOldList = new Attachment[] {};
    private static Schema.DescribeSObjectResult describeResult;
    
    protected AttachmentTrigger(Attachment[] attachmentOldList, Attachment[] attachmentNewList) {
        this.attachmentNewList.addAll(attachmentNewList == null ? new Attachment[] {} : attachmentNewList);
        this.attachmentOldList.addAll(attachmentOldList == null ? new Attachment[] {} : attachmentOldList);
        this.attachmentOldMap.putAll(this.attachmentOldList);
    }
    
    protected Attachment attachmentOld(Id attachmentId) {
        Attachment attachment = attachmentOldMap.get(attachmentId);
        return attachment == null ? new Attachment() : attachment;
    }
    
    public virtual void execute() {}
}