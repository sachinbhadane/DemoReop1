trigger RoutingTable_SetRoutingType on Routing_Table__c (before insert, before update) {
    new RoutingTable_SetRoutingType(trigger.old, trigger.new).execute();
}