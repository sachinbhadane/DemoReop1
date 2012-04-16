public virtual with sharing class ContactExtension {
    Id contactId;
    
    public ContactExtension(Id contactId) {
        this.contactId = contactId;
    }
    
    public ContactExtension(ApexPages.StandardController controller) {
        this.contactId = controller.getId();
    }
    
    public Id getContactId() {
        return contactId;
    }
}