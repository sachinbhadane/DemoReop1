@IsTest
private class MessageTriggerTest {
    public class ImplementedTestMessageTrigger extends MessageTrigger {
        public ImplementedTestMessageTrigger(Message__c[] messageOldList, Message__c[] messageNewList) {
            super(messageOldList, messageNewList);
        }
        
        public override void execute() {
            messageOld(messageNewList[0].Id);
            getText(getMessage(messageNewList[0]), 'account/name');
        }
    }
    
    public static testmethod void test() {
        Message__c[] messageList = new Message__c[] { 
            new Message__c(
                Name = 'Test',
                Data__c = '<message><account><name>Account Name</name></account></message>'
            )};
        
        insert messageList ;
        new ImplementedTestMessageTrigger(messageList , messageList).execute();
    }
}