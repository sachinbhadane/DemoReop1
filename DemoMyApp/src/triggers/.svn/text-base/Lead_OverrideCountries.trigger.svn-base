trigger Lead_OverrideCountries on Lead (before insert, before update) {
    new Lead_OverrideCountries(trigger.old, trigger.new).execute();
}