trigger RoutingTable_ValidateUserId on Routing_Table__c (after insert, after update) {
    new RoutingTable_ValidateUserId(trigger.old, trigger.new).execute();
}