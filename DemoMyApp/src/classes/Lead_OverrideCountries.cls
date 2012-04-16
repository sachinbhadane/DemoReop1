global with sharing class Lead_OverrideCountries extends rC_Core.LeadTrigger {
    public Lead_OverrideCountries(Lead[] leadOldList, Lead[] leadNewList) {
        super(leadOldList, leadNewList);
    }
    
    global override void execute() {
        if (Setting_Disabled__c.getInstance().Lead_OverrideCountries__c == true)
            return; // Disabled at a global level
        
        Map<String, Id> countryMap = new Map<String, Id> {};
        
        for(Lead leadNew : leadNewList) {
            countryMap.put(leadNew.Country_Of_Citizenship_Override__c, null);
            countryMap.put(leadNew.Country_Of_Origin_Override__c, null);
            countryMap.put(leadNew.Country_Of_Residence_Override__c, null);
        }
        
        if (countryMap.size() == 0)
            return;
        
        // First, find all the variants
        for(Country_Variant__c variant : [
            select Name
                 , Country__c
              from Country_Variant__c
             where Name in :countryMap.keySet()
        ]) countryMap.put(variant.Name, variant.Country__c);
        
        // Now, search for countries by name, overwriting variants if duplicated
        for(Country__c country : [
            select Name
              from Country__c
             where Name in :countryMap.keySet()
        ]) countryMap.put(country.Name, country.Id);
        
        // Finally, search by alpha 2 code. This is considered the most exact match 
        for(Country__c country : [
            select Alpha_2__c
              from Country__c
             where Alpha_2__c in :countryMap.keySet()
        ]) countryMap.put(country.Alpha_2__c, country.Id);
        
        // Run through the leads, and pull out matches
        for(Lead leadNew : leadNewList) {
            Id countryOfCitizenship = countryMap.get(leadNew.Country_Of_Citizenship_Override__c);
            Id countryOfOrigin = countryMap.get(leadNew.Country_Of_Origin_Override__c);
            Id countryOfResidence = countryMap.get(leadNew.Country_Of_Residence_Override__c);
            
            if (leadNew.Country_Of_Citizenship_Override__c != null && countryOfCitizenship != null) {
                leadNew.Country_Of_Citizenship__c = countryOfCitizenship;
                leadNew.Country_Of_Citizenship_Override__c = null;
            }
            
            if (leadNew.Country_Of_Origin_Override__c != null && countryOfOrigin != null) {
                leadNew.Country_Of_Origin__c = countryOfOrigin;
                leadNew.Country_Of_Origin_Override__c = null;
            }
            
            if (leadNew.Country_Of_Residence_Override__c != null && countryOfResidence != null) {
                leadNew.Country_Of_Residence__c = countryOfResidence;
                leadNew.Country_Of_Residence_Override__c = null;
            }
        }
    }
}