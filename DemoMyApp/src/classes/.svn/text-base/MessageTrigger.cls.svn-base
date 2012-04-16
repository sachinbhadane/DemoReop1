public virtual with sharing class MessageTrigger {
    protected final Map<Id, Message__c> messageOldMap = new Map<Id, Message__c>();
    protected final Message__c[] messageNewList = new Message__c[] {};
    protected final Message__c[] messageOldList = new Message__c[] {};
    private static Schema.DescribeSObjectResult describeResult;
    
    protected MessageTrigger(Message__c[] messageOldList, Message__c[] messageNewList) {
        this.messageNewList.addAll(messageNewList == null ? new Message__c[] {} : messageNewList);
        this.messageOldList.addAll(messageOldList == null ? new Message__c[] {} : messageOldList);
        this.messageOldMap.putAll(this.messageOldList);
    }
    
    protected Message__c messageOld(Id messageId) {
        Message__c message = messageOldMap.get(messageId);
        return message == null ? new Message__c() : message;
    }
    
    public virtual void execute() {}
    
    public static Schema.DescribeSObjectResult getDescribe() {
        if (describeResult == null)
            describeResult = Message__c.SobjectType.getDescribe();
        return describeResult;
    }
    
    protected Dom.XmlNode getMessage(Message__c message) {
        Dom.Document doc = new Dom.Document();
        doc.load(message.Data__c);
        return doc.getRootElement();
    }
    
    protected String getText(Dom.XmlNode element, String path) {
        if (path == null || path == '') return null;
        
        for(String name : path.split('/', 0)) {
            if (element == null || name == null || name == '')
                continue;
            element = element.getChildElement(name, null);
        }
        
        return element == null ? null : element.getText();
    }
}