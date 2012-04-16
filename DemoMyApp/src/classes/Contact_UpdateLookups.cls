public without sharing class Contact_UpdateLookups extends ContactTrigger {
    // ^ ignore profile permissions.
     
    public Contact_UpdateLookups(Contact[] contactOldList, Contact[] contactNewList) {
        super(contactOldList, contactNewList);
    }
    
    public virtual override void execute() {
        executeForCountries();
    }
    
    //
    // The applicant portal UI allows for applicants to pick their countries from a long list, by name. In order to 
    // support this flexibility, we need to match up the name of the country override field to the actual country id.
    // 
    
    void executeForCountries() {
        Map<String, Id> countryMap = new Map<String, Id> {};
        
        for(Contact contactNew : contactNewList) 
        {
        	if (contactNew.Country_Of_Citizenship_Override__c != null)
                countryMap.put(contactNew.Country_Of_Citizenship_Override__c.toLowerCase(), null);
            if (contactNew.Country_Of_Residence_Override__c != null)
                countryMap.put(contactNew.Country_Of_Residence_Override__c.toLowerCase(), null);
        }
        
        for(Country__c country : [
            select Name_Lower_Case__c
              from Country__c
             where Name_Lower_Case__c in :countryMap.keySet()
             limit 10000
        ]) countryMap.put(country.Name_Lower_Case__c, country.Id);
        
        for(Contact contactNew : contactNewList) {
            if (contactNew.Country_Of_Citizenship_Override__c != null)
                contactNew.Country_Of_Citizenship__c = countryMap.get(contactNew.Country_Of_Citizenship_Override__c.toLowerCase());
            if (contactNew.Country_Of_Residence_Override__c != null)
                contactNew.Country_Of_Residence__c = countryMap.get(contactNew.Country_Of_Residence_Override__c.toLowerCase());
        }
    }
}