trigger RoutingTable_SetBounds on Routing_Table__c (before insert, before update) {
    new RoutingTable_SetBounds(trigger.old, trigger.new).execute();
}