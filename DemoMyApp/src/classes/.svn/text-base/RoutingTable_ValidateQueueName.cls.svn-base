public without sharing class RoutingTable_ValidateQueueName extends RoutingTableTrigger { 
    public RoutingTable_ValidateQueueName(Routing_Table__c[] routingOldList, Routing_Table__c[] routingNewList) {
        super(routingOldList, routingNewList);
    }
    
    public override void execute() {
        if (RoutingAnalysis.getSetting().Is_Validation_Disabled__c == true)
            return;
        if (RoutingAnalysis.getSetting().Is_Validation_Disabled_Queue_Name__c == true)
            return;
        
        system.assert(Trigger.isAfter, 'RoutingTable_ValidateQueueName: This code must be run as an after trigger.');
        
        // build a list of all specified queue ids
        Map<String, Group> routingQueueMap = new Map<String, Group>();
        
        for(Routing_Table__c routing : getRoutingTableNewList()) {
            if (routing == null)
                continue;
            if (RoutingAnalysis.RoutedByQueueName.equalsIgnoreCase(routing.Routed_By__c) == false)
                continue;
            if (routing.Routed_To__c == null)
                throw new RoutingAnalysis.RoutingException('RoutingTable_ValidateQueueName: routing.Routed_To__c == null: should have been pre-validated');
            
            routingQueueMap.put(routing.Routed_To__c, null);
        }
        
        if (routingQueueMap.size() == 0)
            return;
        
        for(QueueSobject queueSobject : [
            select Queue.Name
              from QueueSobject
             where Queue.Name in :routingQueueMap.keySet()
               and SobjectType = 'Lead' 
        ]) routingQueueMap.put(queueSobject.Queue.Name, queueSobject.Queue);
        
        for(Routing_Table__c routing : getRoutingTableNewList()) {
            if (routing == null)
                continue;
            if (RoutingAnalysis.RoutedByQueueName.equalsIgnoreCase(routing.Routed_By__c) == false)
                continue;
            if (routingQueueMap.get(routing.Routed_To__c) != null)
                continue;
            routing.Routed_To__c.addError('Queue not found');
        }
    }
}