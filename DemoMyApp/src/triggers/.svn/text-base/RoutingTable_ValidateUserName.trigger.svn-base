trigger RoutingTable_ValidateUserName on Routing_Table__c (after insert, after update) {
    new RoutingTable_ValidateUserName(trigger.old, trigger.new).execute();
}