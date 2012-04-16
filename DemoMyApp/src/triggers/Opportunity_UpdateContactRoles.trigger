trigger Opportunity_UpdateContactRoles on Opportunity (after insert, after update) {
    new Opportunity_UpdateContactRoles(trigger.old, trigger.new).execute();
}