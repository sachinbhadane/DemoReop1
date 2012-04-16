trigger ContactSetPhones on Contact (before insert, before update) {
    for (Contact c : Trigger.new) {
    c.HomePhone = c.Home_Phone_Composite__c;
        c.MobilePhone = c.Mobile_Phone_Composite__c;
        c.OtherPhone = c.Other_Phone_Composite__c;
    }
}