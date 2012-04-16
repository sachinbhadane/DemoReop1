public with sharing class RoutingTable_SetName extends RoutingTableTrigger { 
    public RoutingTable_SetName(Routing_Table__c[] routingOldList, Routing_Table__c[] routingNewList) {
        super(routingOldList, routingNewList);
    }
    
    public override void execute() {
        for(Routing_Table__c routing : getRoutingTableNewList()) {
            if (routing == null)
                continue;
            if (routing.Matching__c == null)
                continue;
            routing.Matching__c = routing.Matching__c.replaceAll('[^0-9A-Za-z\\-\\.,]', '').toUpperCase();
        }
    }
}