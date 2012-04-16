trigger RoutingTable_ValidateDepartmentId on Routing_Table__c (after insert, after update) {
    new RoutingTable_ValidateDepartmentId(trigger.old, trigger.new).execute();
}