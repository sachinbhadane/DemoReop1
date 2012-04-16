trigger Lead_ChangeTaskOwners on Lead (after update) {
    new Lead_ChangeTaskOwners(trigger.old, trigger.new).execute();
}