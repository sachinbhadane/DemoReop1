@IsTest
private class AttachmentTriggerTest {
    public class ImplementedTestAttachmentTrigger extends AttachmentTrigger {
        public ImplementedTestAttachmentTrigger(Attachment[] attachmentOldList, Attachment[] attachmentNewList) {
            super(attachmentOldList, attachmentNewList);
        }
        
        public override void execute() {
            attachmentOld(attachmentNewList[0].Id);
        }
    }
    
    public static testmethod void test() {
        Attachment[] attachmentList = new Attachment[] { 
            new Attachment(
                ParentId = [select Id from Account limit 1].Id,
                Body = Blob.valueOf('Test'),
                Name = 'Attachment Name',
                ContentType = 'text/plain'
            )};
        
        insert attachmentList ;
        new ImplementedTestAttachmentTrigger(attachmentList , attachmentList).execute();
    }
}