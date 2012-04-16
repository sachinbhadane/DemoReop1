public without sharing class Opportunity_UpdateAccount extends OpportunityTrigger {
    public Opportunity_UpdateAccount(Opportunity[] opportunityOldList, Opportunity[] opportunityNewList) {
        super(opportunityOldList, opportunityNewList);
    }
    
    public virtual override void execute() {
        
        Map<String,Id> mapAccountName = new Map<String,Id>(); 		// Map holds the values of Account Name and id.
        Map<Id,String> MapConIdRegionName = new Map<Id,String>();			// Map Contact Id and Contact Region
        Map<Id,String> MapProdIdDeptName = new Map<Id,String>();		// Map Product Id and DepartmentName 
        
        // Map Account Name and Id
        Map<Id,String> programAccountMap = new Map<Id,String> {};
        
         // Trigger Need to be fire only when we are going to change the program related with opprtunity
        Set<Id> setContactId = new Set<Id>();
        Set<String> setDeptRegion = new Set<String>();
        Set<String> setProgramId = new Set<String>();
        
        for(Opportunity objOppNew : opportunityNewList)
        {
        	if(opportunityOldMap != null && opportunityOldMap.size() > 0)
        	{
	        	Opportunity objOppOld = opportunityOldMap.get(objOppNew.Id);
	        	if(objOppOld.Program__c != objOppNew.Program__c)
	        	{
	        		setContactId.add(objOppNew.Contact__c);
	        		setProgramId.add(objOppNew.Program__c);
	        	}
        	}
        }
        if(setContactId.size() == 0 || setProgramId.size() == 0)
        	return;
        	
    	for(Contact objCon : [Select c.Region__c, c.Program_Primary__r.Department__r.Name, c.Program_Primary__c From Contact c where Id In : setContactId])
        	MapConIdRegionName.put(objCon.Id,objCon.Region__c);
    	
    	for(Program__c objProgram : [select Id,Name, Department__r.Name from Program__c where id In : setProgramId])
    		MapProdIdDeptName.put(objProgram.Id,objProgram.Department__r.Name);
    	
        for(Opportunity objOppNew : opportunityNewList)
        {
        	// Created Key Dept - region to get matching accounts
        	setDeptRegion.add(MapProdIdDeptName.get(objOppNew.Program__c)+'-'+MapConIdRegionName.get(objOppNew.Contact__c));
        	
        	// Created Map Primary program and the Region
        	programAccountMap.put(objOppNew.Program__c,MapProdIdDeptName.get(objOppNew.Program__c)+'-'+MapConIdRegionName.get(objOppNew.Contact__c));
        }
        
        System.debug('setDeptRegion ===============>'+setDeptRegion);
        
		for(Account account : [
            select Name
              from Account
             where Name in : setDeptRegion
        ]) mapAccountName.put(account.Name, account.Id);
        
        
        // Finally, remap to the opp
        system.debug('***********************opportunityNewList'+opportunityNewList);
        for(Opportunity opportunityNew : opportunityNewList){
        	//if(mapAccountName.ContainsKey(programAccountMap.get(opportunityNew.Program__c)))
            	system.debug('Inside Loop***********8');
            	opportunityNew.AccountId = mapAccountName.get(programAccountMap.get(opportunityNew.Program__c));
        }
        //Original Code Commented
        /*****Changes by : Niket******/
        /*if(setContactId.size() > 0 && setProgramId.size() > 0)
        {
        	for(Contact objCon : [Select c.Region__c, c.Program_Primary__r.Department__r.Name, c.Program_Primary__c From Contact c where Id In : setContactId])
            	MapConIdRegionName.put(objCon.Id,objCon.Region__c);
        	
        	for(Program__c objProgram : [select Id,Name, Department__r.Name from Program__c where id In : setProgramId])
        		MapProdIdDeptName.put(objProgram.Id,objProgram.Department__r.Name);
        	
	        for(Opportunity objOppNew : opportunityNewList)
	        {
	        	// Created Key Dept - region to get matching accounts
	        	setDeptRegion.add(MapProdIdDeptName.get(objOppNew.Program__c)+'-'+MapConIdRegionName.get(objOppNew.Contact__c));
	        	
	        	// Created Map Primary program and the Region
	        	programAccountMap.put(objOppNew.Program__c,MapProdIdDeptName.get(objOppNew.Program__c)+'-'+MapConIdRegionName.get(objOppNew.Contact__c));
	        }
	        
	        System.debug('setDeptRegion ===============>'+setDeptRegion);
	        
			for(Account account : [
	            select Name
	              from Account
	             where Name in : setDeptRegion
	        ]) mapAccountName.put(account.Name, account.Id);
	        
	        
	        // Finally, remap to the opp
	        for(Opportunity opportunityNew : opportunityNewList){
	        	//if(mapAccountName.ContainsKey(programAccountMap.get(opportunityNew.Program__c)))
	            	opportunityNew.AccountId = mapAccountName.get(programAccountMap.get(opportunityNew.Program__c));
	        }
        }
        */
        /*
        Old Logic		: Account are fetching on the program name 
        Commneted By 	: Niket
                
        // Map<Id, Program__c> opportunityProgramMap = new Map<Id, Program__c> {};
        
        for(Opportunity opportunityNew : opportunityNewList) 
        {
            opportunityProgramMap.put(opportunityNew.Program__c, null);
        }
        
        // Select them now
        opportunityProgramMap = new Map<Id, Program__c>([
            select Name
              from Program__c
             where Id in :opportunityProgramMap.keySet()
        ]);
        
        // Build a map of names to account ids
        Map<String, Id> programAccountMap = new Map<String, Id> {};
        
        for(Program__c program : opportunityProgramMap.values())
            programAccountMap.put(program.Name, null);
        
        for(Account account : [
            select Name
              from Account
             where Name in :programAccountMap.keySet()
        ]) programAccountMap.put(account.Name, account.Id);
        
        // Finally, remap to the opp
        for(Opportunity opportunityNew : opportunityNewList) {
            Program__c program = opportunityProgramMap.get(opportunityNew.Program__c);
            
            if (program == null) continue;
            if (programAccountMap.containsKey(program.Name) == false) continue;
            
           // opportunityNew.AccountId = programAccountMap.get(program.Name);
        }*/
    }
}