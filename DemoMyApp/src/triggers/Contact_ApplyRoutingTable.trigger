trigger Contact_ApplyRoutingTable on Contact (before update) {
    //new Contact_ApplyRoutingTable(trigger.old, trigger.new).execute(trigger.isInsert);
    new Contact_ApplyRoutingTable(trigger.old, trigger.new).executeFromTriggerUpdateAsQueueMessage();
}