trigger Contact_ChangeTaskOwners on Contact (after update) {
    new Contact_ChangeTaskOwners(trigger.old, trigger.new).execute();
}