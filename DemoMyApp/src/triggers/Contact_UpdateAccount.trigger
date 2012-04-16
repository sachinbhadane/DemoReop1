trigger Contact_UpdateAccount on Contact (before insert, before update) {
    new Contact_UpdateAccount(trigger.old, trigger.new).execute();
}