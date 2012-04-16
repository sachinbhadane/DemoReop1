trigger Lead_OverridePrograms on Lead (before insert, before update) {
    new Lead_OverridePrograms(trigger.old, trigger.new).execute();
}