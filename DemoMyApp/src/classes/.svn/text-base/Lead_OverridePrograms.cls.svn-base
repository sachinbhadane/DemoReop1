global with sharing class Lead_OverridePrograms extends rC_Core.LeadTrigger {
    public Lead_OverridePrograms(Lead[] leadOldList, Lead[] leadNewList) {
        super(leadOldList, leadNewList);
    }
    
    global override void execute() {
        if (Setting_Disabled__c.getInstance().Lead_OverridePrograms__c == true)
            return; // Disabled at a global level
        
        Map<String, Id> programNameMap = new Map<String, Id> {};
        
        for(Lead leadNew : leadNewList) {
            programNameMap.put(leadNew.Program_Primary_Override__c, null);
            programNameMap.put(leadNew.Program_Secondary_Override__c, null);
            programNameMap.put(leadNew.Program_Third_Override__c, null);
        }
        
        if (programNameMap.size() == 0)
            return;
        
        for(Program__c program : [
            select Name
              from Program__c
             where Name in :programNameMap.keySet()
        ]) programNameMap.put(program.Name, program.Id);
        
        for(Lead leadNew : leadNewList) {
            Id program1 = programNameMap.get(leadNew.Program_Primary_Override__c);
            Id program2 = programNameMap.get(leadNew.Program_Secondary_Override__c);
            Id program3 = programNameMap.get(leadNew.Program_Third_Override__c);
            
            if (leadNew.Program_Primary_Override__c != null && program1 != null) {
                leadNew.Program_Primary__c = program1;
                leadNew.Program_Primary_Override__c = null;
            }
            
            if (leadNew.Program_Secondary_Override__c != null && program2 != null) {
                leadNew.Program_Secondary__c = program2;
                leadNew.Program_Secondary_Override__c = null;
            }
            
            if (leadNew.Program_Third_Override__c != null && program3 != null) {
                leadNew.Program_Third__c = program3;
                leadNew.Program_Third_Override__c = null;
            }
        }
    }
}