public without sharing class RoutingTable_ValidateDepartmentId extends RoutingTableTrigger {
    public RoutingTable_ValidateDepartmentId(Routing_Table__c[] routingOldList, Routing_Table__c[] routingNewList) {
        super(routingOldList, routingNewList);
    }
    
    public override void execute() {
        if (RoutingAnalysis.getSetting().Is_Validation_Disabled__c == true)
            return;
        if (RoutingAnalysis.getSetting().Is_Validation_Disabled_Department_ID__c == true)
            return;
        
        system.assert(Trigger.isAfter, 'RoutingTable_ValidateDepartmentId: This code must be run as an after trigger.');
        
        // build a list of all specified user ids
        Map<Id, Department__c> routingDepartmentMap = new Map<Id, Department__c>();
        
        for(Routing_Table__c routing : getRoutingTableNewList()) {
            if (routing == null)
                continue;
            if (RoutingAnalysis.RoutedByDepartmentId.equalsIgnoreCase(routing.Routed_By__c) == false)
                continue;
            if (routing.Routed_To__c == null)
                throw new RoutingAnalysis.RoutingException('RoutingTable_ValidateDepartmentId: routing.Routed_To__c == null: should have been pre-validated');
            
            routingDepartmentMap.put(routing.Routed_To__c, null);
        }
        
        if (routingDepartmentMap.size() == 0)
            return;
        
        for(Department__c department : [
            select Id
              from Department__c
             where Id in :routingDepartmentMap.keySet()
        ]) routingDepartmentMap.put(department.Id, department);
        
        for(Routing_Table__c routing : getRoutingTableNewList()) {
            if (routing == null)
                continue;
            if (RoutingAnalysis.RoutedByDepartmentId.equalsIgnoreCase(routing.Routed_By__c) == false)
                continue;
            if (routingDepartmentMap.get(routing.Routed_To__c) != null)
                continue;
            routing.Routed_To__c.addError('Department ID not found');
        }
    }
}