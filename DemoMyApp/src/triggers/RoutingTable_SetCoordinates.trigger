trigger RoutingTable_SetCoordinates on Routing_Table__c (before insert, before update) {
    new RoutingTable_SetCoordinates(trigger.old, trigger.new).execute();
}