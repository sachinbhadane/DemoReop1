@IsTest
private class Attachment_SetRequirementSuppliedTest {
    public static testmethod void test() {
        Requirement__c requirement = new Requirement__c();
        requirement.Name = 'Requirement Name';
        insert requirement;
        
        system.assertEquals(false, [
            select Supplied__c
              from Requirement__c
             where Id = :requirement.Id
        ].Supplied__c);
        
        Attachment attachment = new Attachment();
        attachment.Body = Blob.valueOf('Attachment Data');
        attachment.ContentType = 'text/plain';
        attachment.Name = 'Attachment Name';
        attachment.ParentId = requirement.Id;
        insert attachment;
        
        system.assertEquals(true, [
            select Supplied__c
              from Requirement__c
             where Id = :requirement.Id
        ].Supplied__c);
    }
}