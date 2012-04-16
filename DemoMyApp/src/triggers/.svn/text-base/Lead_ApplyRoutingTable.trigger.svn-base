trigger Lead_ApplyRoutingTable on Lead (after insert, after update) {
    new Lead_ApplyRoutingTable(trigger.old, trigger.new).executeFromTriggerUpdateAsQueueMessage();
}