trigger Contact_UpdateLookups on Contact (before insert, before update) {
    new Contact_UpdateLookups(trigger.old, trigger.new).execute();
}