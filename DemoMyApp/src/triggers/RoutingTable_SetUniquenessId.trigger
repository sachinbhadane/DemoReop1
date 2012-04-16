trigger RoutingTable_SetUniquenessId on Routing_Table__c (before insert, before update) {
    new RoutingTable_SetUniquenessId(trigger.old, trigger.new).execute();
}