public virtual with sharing class ContactTrigger {
    protected final Map<Id, Contact> contactOldMap = new Map<Id, Contact>();
    protected final Contact[] contactNewList = new Contact[] {};
    protected final Contact[] contactOldList = new Contact[] {};
    private static Schema.DescribeSObjectResult describeResult;
    
    protected ContactTrigger(Contact[] contactOldList, Contact[] contactNewList) {
        this.contactNewList.addAll(contactNewList == null ? new Contact[] {} : contactNewList);
        this.contactOldList.addAll(contactOldList == null ? new Contact[] {} : contactOldList);
        this.contactOldMap.putAll(this.contactOldList);
    }
    
    protected Contact contactOld(Id contactId) {
        Contact contact = contactOldMap.get(contactId);
        return contact == null ? new Contact() : contact;
    }
    
    public virtual void execute() {}
    
    public static Schema.DescribeSObjectResult getDescribe() {
        if (describeResult == null)
            describeResult = Contact.SobjectType.getDescribe();
        return describeResult;
    }
}