@IsTest
private class ContactExtensionTest {
    public static testmethod void generateCodeCoverageOnly() {
        Contact contact = new Contact();
        contact.LastName = 'Name';
        contact.Email = 'contact@example.com';
        insert contact;
        
        new ContactExtension(new ApexPages.StandardController(contact));
        new ContactExtension(contact.Id).getContactId();
    }
}