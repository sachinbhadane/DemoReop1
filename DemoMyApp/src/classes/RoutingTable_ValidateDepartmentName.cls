public without sharing class RoutingTable_ValidateDepartmentName extends RoutingTableTrigger { 
    public RoutingTable_ValidateDepartmentName(Routing_Table__c[] routingOldList, Routing_Table__c[] routingNewList) {
        super(routingOldList, routingNewList);
    }
    
    public override void execute() {
        if (RoutingAnalysis.getSetting().Is_Validation_Disabled__c == true)
            return;
        if (RoutingAnalysis.getSetting().Is_Validation_Disabled_Department_Name__c == true)
            return;
        
        system.assert(Trigger.isAfter, 'RoutingTable_ValidateDepartmentName: This code must be run as an after trigger.');
        
        // build a list of all specified queue ids
        Map<String, Department__c> routingDepartmentMap = new Map<String, Department__c>();
        
        for(Routing_Table__c routing : getRoutingTableNewList()) {
            if (routing == null)
                continue;
            if (RoutingAnalysis.RoutedByDepartmentName.equalsIgnoreCase(routing.Routed_By__c) == false)
                continue;
            if (routing.Routed_To__c == null)
                throw new RoutingAnalysis.RoutingException('RoutingTable_ValidateDepartmentName: routing.Routed_To__c == null: should have been pre-validated');
            
            routingDepartmentMap.put(routing.Routed_To__c, null);
        }
        
        if (routingDepartmentMap.size() == 0)
            return;
        
        for(Department__c department : [
            select Name
              from Department__c
             where Name in :routingDepartmentMap.keySet()
        ]) routingDepartmentMap.put(department.Name, department);
        
        for(Routing_Table__c routing : getRoutingTableNewList()) {
            if (routing == null)
                continue;
            if (RoutingAnalysis.RoutedByDepartmentName.equalsIgnoreCase(routing.Routed_By__c) == false)
                continue;
            if (routingDepartmentMap.get(routing.Routed_To__c) != null)
                continue;
            routing.Routed_To__c.addError('Department not found');
        }
    }
}