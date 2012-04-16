trigger Opportunity_EnforcePerContactLimit on Opportunity (after insert, after undelete) {
    new Opportunity_EnforcePerContactLimit(trigger.old, trigger.new).execute();
}