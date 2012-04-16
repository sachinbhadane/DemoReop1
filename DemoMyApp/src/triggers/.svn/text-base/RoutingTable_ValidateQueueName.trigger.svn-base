trigger RoutingTable_ValidateQueueName on Routing_Table__c (after insert, after update) {
    new RoutingTable_ValidateQueueName(trigger.old, trigger.new).execute();
}