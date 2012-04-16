trigger RoutingTable_SetName on Routing_Table__c (before insert, before update) {
    new RoutingTable_SetName(trigger.old, trigger.new).execute();
}