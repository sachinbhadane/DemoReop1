trigger RegionSet on Contact (before insert, before update) {
    Map<Id, Contact> newConMap = trigger.newMap;
    Map<Id, Contact> oldConMap = trigger.oldMap;

    // Region to AccountId map
    Map<String, String> accountIdMap = new Map<String, String>();
    accountIdMap.put('Asia', '001U0000003Fofc');
    accountIdMap.put('Europe', '001U0000003Caob');
    accountIdMap.put('Lat Am', '001U0000003wrsc');
    accountIdMap.put('North Am', '001U0000003wroH');
    accountIdMap.put('MEA', '001U0000003FpBE');
    accountIdMap.put('Eurasia', '001U0000003Caoh');
    
    if(trigger.isInsert){
        List<Contact> conList = new List<Contact>();
        for(Id id : newConMap.keySet()){
            if(newConMap.get(id).Region__c != null)
                conList.add(newConMap.get(id));
        }
        for(Contact c : conList){
            c.AccountId = accountIdMap.get(c.Region__c);
        }        
    }else{
        List<Contact> conList = new List<Contact>();
        for(Id id : newConMap.keySet()){
            if(newConMap.get(id).Region__c != null && oldConMap.get(id).Region__c != newConMap.get(id).Region__c){
                conList.add(newConMap.get(id));                    
            }
        }
        //List<Contact> finalUpdatable = new List<Contact>();
        for(Contact c : conList){
            c.AccountId = accountIdMap.get(c.Region__c);
            //finalUpdatable.add(c);
        }
        //update finalUpdatable;
    }
}