public with sharing class Opportunity_ManageRequirements {
    public ApexPages.StandardController controller;
    public Requirement__c[] requirementList { set; get;}
    public Requirement__c[] requirementVisaList { set; get;}
    public string attid{get;set;}
    
    public Opportunity_ManageRequirements(ApexPages.StandardController controller){
        this.controller = controller;  
    }
    
    public PageReference initialize() {
        requirementlist = [
            select Waived__c                
                 , Verified__c
                 , Unlocked__c
                 , Supplied__c
                 , Status_UI__c
                 , Required_For__c
                 , Required_By__c
                 , RecordType.Name
                 , RecordTypeId
                 , Name
                 , Approved__c
                 , (select Name
                         , ContentType
                         , BodyLength
                         , createdby.Name
                      from Attachments) 
              from Requirement__c
             where Opportunity__c = :controller.getid()
               and Opportunity__c != null 
               and RecordType.name != 'Visa'
          order by Name asc
        ];
        
        requirementVisaList = [
            select Waived__c
                 , Verified__c
                 , Unlocked__c
                 , Supplied__c
                 , Status_UI__c
                 , Required_For__c
                 , Required_By__c
                 , RecordType.Name
                 , RecordTypeId
                 , Name
                 , Approved__c
                 , (select Name
                         , ContentType
                         , BodyLength
                         , createdby.Name
                      from Attachments) 
              from Requirement__c 
             where Opportunity__c = :controller.getid()
               and Opportunity__c != null
               and RecordType.Name = 'Visa'
          order by Name asc
        ];
        
        return null;
    }
    
    public PageReference save() {
        update requirementList;
        update requirementVisaList;
        return null;
    }
    
    public PageReference saveandreturn() {
        update requirementList;
        update requirementVisaList;
        return new PageReference('/' +controller.getid() );
    }
    
    public PageReference cancel() {
        return new PageReference('/' +controller.getid() );
    }
    
    public pagereference delAttachment(){   
        try{
            Attachment delAtt=[select id from Attachment where id=:attid];
            delete delAtt;
            initialize();
        }
        catch(exception e){
            apexpages.addmessages(e);
        }
        return null;
    }
}