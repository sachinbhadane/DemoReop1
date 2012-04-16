public virtual with sharing class SobjectController {
    public User user { public get; private set; }
    Setting__c setting = Setting__c.getInstance();
    Id sobjectId;
    
    protected SobjectController(Id sobjectId) {
        this.sobjectId = sobjectId;
    }
    
    protected SobjectController(ApexPages.StandardController controller) {
        this.sobjectId = controller.getId();
    }
    
    protected PageReference addMessage(ApexPages.Severity severity, String message) {
        ApexPages.addMessage(new ApexPages.Message(severity, message));
        return null;
    }
    
    protected PageReference addErrorMessage(String message) {
        return addMessage(ApexPages.Severity.Error, message);
    }
    
    protected PageReference addErrorMessage(Exception pException) {
        return addMessage(ApexPages.Severity.Error, pException.getTypeName() + ': ' + pException.getMessage());
    }
    
    protected Boolean hasErrorMessages() {
        return ApexPages.hasMessages(ApexPages.Severity.Error);
    }
    
    protected PageReference redirectTo(PageReference pageReference) {
        return redirectTo(pageReference, true);
    }
    
    protected PageReference redirectTo(PageReference pageReference, Boolean includeId) {
        if (includeId == true)
            pageReference.getParameters().put('id', sobjectId);
        pageReference.setRedirect(true);
        return pageReference;
    }
    
    protected String getParam(String paramName, String defaultValue) {
        String param = ApexPages.currentPage().getParameters().get(paramName);
        return param == null ? defaultValue : param;
    }
    
    protected String getParam(String paramName) {
        return getParam(paramName, '');
    }
    
    protected Id getId() {
        return sobjectId;
    }
    
    public virtual PageReference initialize() {
        user = [
            select FirstName
                 , LastName
                 , Email
                 , Phone
                 , Username
                 , Profile.Name
                 , Contact.Account.Name
              from User
             where Id = :UserInfo.getUserId()
             limit 1
        ];
        
        return null;
    }
    
    public virtual Schema.DescribeSObjectResult getDescribe() {
        return null; // will be override with the object describe
    }
    
    // Utility functions
    protected SelectOption[] buildSelectOptionList(Sobject[] sobjectRefList, String dataField, String nameField) {
        if (sobjectRefList == null || sobjectRefList.size() == 0)
            return new SelectOption[] {};
        if (dataField == null || dataField == '')
            return new SelectOption[] {};
        if (nameField == null || nameField == '')
            return new SelectOption[] {};
        
        SelectOption[] selectOptionList = new SelectOption[] {};
        
        for(Sobject sobjectRef : sobjectRefList) {
            selectOptionList.add(new SelectOption(
                sobjectRef.get(dataField) == null ? '' : (String) sobjectRef.get(dataField),
                sobjectRef.get(nameField) == null ? '' : (String) sobjectRef.get(nameField)
            ));
        }
        
        return selectOptionList;
    }
    
    protected Setting__c getSetting() {
        if (setting == null)
            setting = new Setting__c();
        return setting;
    }
}