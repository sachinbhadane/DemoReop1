trigger RoutingTable_ValidateQueueId on Routing_Table__c (after insert, after update) {
    new RoutingTable_ValidateQueueId(trigger.old, trigger.new).execute();
}