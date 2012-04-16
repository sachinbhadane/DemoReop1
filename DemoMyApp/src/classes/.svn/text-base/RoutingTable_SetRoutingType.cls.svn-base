public with sharing class RoutingTable_SetRoutingType extends RoutingTableTrigger { 
    public RoutingTable_SetRoutingType(Routing_Table__c[] routingOldList, Routing_Table__c[] routingNewList) {
        super(routingOldList, routingNewList);
    }
    
    public override void execute() {
        for(Routing_Table__c routing : getRoutingTableNewList()) {
            if (routing == null)
                continue;
          /*  if (routing.RecordTypeId == RecordTypePostalCode)
                routing.Routing_Type__c = RoutingTypePostalCode;
            if (routing.RecordTypeId == RecordTypeProximity)
                routing.Routing_Type__c = RoutingTypeProximity;
            if (routing.RecordTypeId == RecordTypeRecruiting)
                routing.Routing_Type__c = RoutingTypeRecruiting;*/
        }
    }
}