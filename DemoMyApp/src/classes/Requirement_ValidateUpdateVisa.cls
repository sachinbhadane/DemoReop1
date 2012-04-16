public virtual with sharing class Requirement_ValidateUpdateVisa extends RequirementTrigger {
    // This propery may have ot be set when doing mass updates/deletes during part of a 
    // defined business process.
    public static Boolean IsDisabled { set; get; }
    
    static final Map<Id, Profile> profileMap = new Map<Id, Profile>([
        select Name
             , PermissionsModifyAllData
          from Profile
         limit 10000
    ]);
    
    static final Map<Id, RecordType> recordTypeMap = new Map<Id, RecordType>([
        select Name
          from RecordType
         where SobjectType = :SobjectType.Requirement__c.Name
         limit 10000
    ]);
    
    protected Requirement_ValidateUpdateVisa(Requirement__c[] requirementOldList, Requirement__c[] requirementNewList) {
        super(requirementOldList, requirementNewList);
    }
    
    public override virtual void execute() {
        if (Requirement_ValidateUpdateVisa.IsDisabled == true)
            return;
        
        for(Requirement__c requirementNew : requirementNewList) {
            if (requirementNew.RecordTypeId == null)
                continue;
            if ('Visa'.equalsIgnoreCase(requirementNew.RecordTypeId) == false)
                continue; // this isn't a visa record type.
            if (profileMap.get(UserInfo.getProfileId()).PermissionsModifyAllData)
                continue; // user can do whatever they want.
            if ('10.0 Hult Visa Coordinator'.equalsIgnoreCase(profileMap.get(UserInfo.getProfileId()).Name))
                continue; // this is actually a visa coordinator
            
            requirementNew.addError('Only a Visa Coordinator or a System Administrator is allowed to modify this requirement.');
        }
    }
}