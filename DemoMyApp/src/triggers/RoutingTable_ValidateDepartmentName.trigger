trigger RoutingTable_ValidateDepartmentName on Routing_Table__c (after insert, after update) {
    new RoutingTable_ValidateDepartmentName(trigger.old, trigger.new).execute();
}