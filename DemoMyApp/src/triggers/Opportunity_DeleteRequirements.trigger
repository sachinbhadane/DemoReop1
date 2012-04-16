trigger Opportunity_DeleteRequirements on Opportunity (before delete) {
    new Opportunity_DeleteRequirements(trigger.old, trigger.new).execute();
}