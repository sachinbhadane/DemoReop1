public without sharing class Contact_UpdateAccount extends ContactTrigger {
    public Contact_UpdateAccount(Contact[] contactOldList, Contact[] contactNewList) {
        super(contactOldList, contactNewList);
    }
    
    public virtual override void execute() {
        Map<Id, Program__c> contactProgramMap = new Map<Id, Program__c> {};
        
        for(Contact contactNew : contactNewList) {
            contactProgramMap.put(contactNew.Program_Primary__c, null);
        }
        
        System.debug(' 1. contactProgramMap ==>'+contactProgramMap);
        // Select them now
        contactProgramMap = new Map<Id, Program__c>([
            select Name
              from Program__c
             where Id in :contactProgramMap.keySet()
        ]);
        
        System.debug(' 2. After firing query contactProgramMap ==>'+contactProgramMap);
        
        // Build a map of names to account ids
        Map<String, Id> programAccountMap = new Map<String, Id> {};
        
        for(Program__c program : contactProgramMap.values())
            programAccountMap.put(program.Name, null);
        
        for(Account account : [
            select Name
              from Account
             where Name in :programAccountMap.keySet()
        ]) programAccountMap.put(account.Name, account.Id);
        
        System.debug('Created Map with Account Name and the Account Id'+programAccountMap);
        
        // Finally, remap to the opp
        for(Contact contactNew : contactNewList) {
            Program__c program = contactProgramMap.get(contactNew.Program_Primary__c);
            
            if (program == null) continue;
            if (programAccountMap.containsKey(program.Name) == false) continue;
            
            /*
            	Line Commented by : Niket
            	Summary 		  : Contact Account is not updated in the "Contact_RouteByRecruiting" Class
            */
            //contactNew.AccountId = programAccountMap.get(program.Name);
        }
    }
}