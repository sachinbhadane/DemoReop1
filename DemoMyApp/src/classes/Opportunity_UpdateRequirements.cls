/*Ian's Code: commented by Mahesh on 1/19/2012 at 11:33 AM EST to fix routing issue in prod
public without sharing class Opportunity_UpdateRequirements extends OpportunityTrigger {
    public Boolean forceUpdate { set; get; }
    
    public class ProcessingException extends Exception {}
    
    public Opportunity_UpdateRequirements(Opportunity[] opportunityOldList, Opportunity[] opportunityNewList) {
        super(opportunityOldList, opportunityNewList);
        forceUpdate = false;
    }
    
    // This trigger applies when the program has changed
    
    public virtual override void execute() {
        // Disabled at a global level?
        if (getDisabledSetting().Opportunity_UpdateRequirements__c == true)
            return;
        
        // Extra a list of programs from the opportunities
        Set<Id> opportunityProgramIds = new Set<Id> {};
        Set<Id> opportunityProgramCountryIds = new Set<Id> {};
        Set<Id> opportunityProgramDepartmentIds = new Set<Id> {};
        
        for(Opportunity opportunityNew : opportunityNewList) {
            opportunityProgramIds.add(opportunityNew.Program__c);
            opportunityProgramCountryIds.add(opportunityNew.Program_Country__c);
            opportunityProgramDepartmentIds.add(opportunityNew.Program_Department__c);
        }
        
        // Maps for insert/delete recognition
        Map<String, Requirement__c> requirementOldMap = new Map<String, Requirement__c> {}; 
        Map<String, Requirement__c> requirementNewMap = new Map<String, Requirement__c> {}; 
        
        // Build the old map
        for(Requirement__c requirementOld : [
            select Opportunity__c
                 , Parent__r.Comparison_Key__c
              from Requirement__c
             where Opportunity__c in :opportunityOldList
               and Parent__c != null
        ]) requirementOldMap.put(generateComparisonKey(requirementOld.Opportunity__c, requirementOld.Parent__r), requirementOld);
        
        system.debug('Opportunity_UpdateRequirements: requirementOldMap = ' + requirementOldMap);
        
        // Find the new needed requirements
        Requirement__c[] requirementAggregatedList = [
            select Name
                 , Comparison_Key__c
                 , Country__c
                 , Department__c
                 , Description__c
                 , Program__c
                 , RecordTypeId
                 , Required_By__c
                 , Required_For__c
              from Requirement__c
             where ((Country__c != null and Country__c in :opportunityProgramCountryIds)
                or  (Department__c != null and Department__c in :opportunityProgramDepartmentIds)
                or  (Program__c != null and Program__c in :opportunityProgramIds))
               and Contact__c = null
               and Opportunity__c = null
               and Parent__c = null
        ];
        
        system.debug('Opportunity_UpdateRequirements: requirementAggregatedList = ' + requirementAggregatedList);
        
        // For efficiency, map each country, department, and program to requirement lists
        Map<Id, Requirement__c[]> requirementCountryMap = new Map<Id, Requirement__c[]> {};
        Map<Id, Requirement__c[]> requirementDepartmentMap = new Map<Id, Requirement__c[]> {};
        Map<Id, Requirement__c[]> requirementProgramMap = new Map<Id, Requirement__c[]> {};
        
        for(Requirement__c requirementAggregated : requirementAggregatedList) {
            putRequirement(requirementCountryMap, requirementAggregated.Country__c, requirementAggregated);
            putRequirement(requirementDepartmentMap, requirementAggregated.Department__c, requirementAggregated);
            putRequirement(requirementProgramMap, requirementAggregated.Program__c, requirementAggregated);
        }
        
        system.debug('Opportunity_UpdateRequirements: requirementCountryMap = ' + requirementCountryMap);
        system.debug('Opportunity_UpdateRequirements: requirementDepartmentMap = ' + requirementDepartmentMap);
        system.debug('Opportunity_UpdateRequirements: requirementProgramMap = ' + requirementProgramMap);
        
        // Upsert and delete lists
        Requirement__c[] requirementUpsertList = new Requirement__c[] {};
        Requirement__c[] requirementDeleteList = new Requirement__c[] {};
        
        // Build a map of desired requirements
        for(Opportunity opportunityNew : opportunityNewList) {
            Requirement__c[] requirementTemplateList = new Requirement__c[] {};
            requirementTemplateList.addAll(getRequirementList(requirementCountryMap, opportunityNew.Program_Country__c));
            requirementTemplateList.addAll(getRequirementList(requirementDepartmentMap, opportunityNew.Program_Department__c));
            requirementTemplateList.addAll(getRequirementList(requirementProgramMap, opportunityNew.Program__c));
            
            system.debug('Opportunity_UpdateRequirements: opportunityNew.Id = ' + opportunityNew.Id);
            system.debug('Opportunity_UpdateRequirements: requirementTemplateList = ' + requirementTemplateList);
            
            // Check each and see if it exists already
            for(Requirement__c requirementTemplate : requirementTemplateList) {
                String comparisonKey = generateComparisonKey(opportunityNew.Id, requirementTemplate);
                
                // Try to find the pre-existing requirement
                Requirement__c requirementNew = requirementOldMap.get(comparisonKey);
                
                // If requirementNew is null, then this is a new requirement and we clone the template.
                if (requirementNew == null)
                    requirementNew = requirementTemplate.clone(false, false);
                else // if not new, clear out the key reference so what's left over gets deleted
                    requirementOldMap.remove(comparisonKey);
                
                // Whether new or merged, set certain field data
                requirementNew.Program__c = null;    // clear this out so the related lists don't get polluted.
                requirementNew.Country__c = null;    // this too
                requirementNew.Department__c = null; // this too
                requirementNew.Opportunity__c = opportunityNew.Id;
                requirementNew.Contact__c = opportunityNew.Contact__c;
                
                // Maintain integrity
                requirementNew.Description__c = requirementTemplate.Description__c;
                requirementNew.Name = requirementTemplate.Name;
                requirementNew.Parent__c = requirementTemplate.Id;
                requirementNew.RecordTypeId = requirementTemplate.RecordTypeId;
                requirementNew.Required_For__c = requirementTemplate.Required_For__c;
                requirementUpsertList.add(requirementNew);
            }
        }
        
        // Scan through the old map and mark for deletion anything that isn't supplied, verified, approved, or waived
        for(Requirement__c requirementOld : requirementOldMap.values()) {
            if (requirementOld.Approved__c == true)
                continue;
            if (requirementOld.Supplied__c == true)
                continue;
            if (requirementOld.Verified__c == true)
                continue;
            if (requirementOld.Waived__c == true)
                continue;
            requirementDeleteList.add(requirementOld);
        }
        
        // Run DML
        if (requirementDeleteList.size() != 0)
            delete requirementDeleteList;
        if (requirementUpsertList.size() != 0)
            upsert requirementUpsertList;
    }
    
    public Requirement__c[] getRequirementList(Map<Id, Requirement__c[]> requirementMap, Id referenceId) {
        return requirementMap.get(referenceId) == null ? new Requirement__c[] {} : requirementMap.get(referenceId);
    }
    
    public void putRequirement(Map<Id, Requirement__c[]> requirementMap, Id referenceId, Requirement__c requirement) {
        if (requirementMap == null || referenceId == null || requirement == null)
            return;
        else if (requirementMap.get(referenceId) != null)
            requirementMap.get(referenceId).add(requirement);
        else
            requirementMap.put(referenceId, new Requirement__c[] { requirement });
    }
    
    public String generateComparisonKey(Id opportunityId, Requirement__c parentRequirement) {
        if (parentRequirement != null && parentRequirement.Comparison_Key__c != null)
            return opportunityId + ':' + parentRequirement.Comparison_Key__c;
        if (parentRequirement != null && parentRequirement.Id != null)
            return opportunityId + ':' + parentRequirement.Id;
        throw new ProcessingException('Unable to generate a unique identifier');
    }
}
*/// Ian's code ends here..

public without sharing class Opportunity_UpdateRequirements extends OpportunityTrigger 
{
    public Boolean forceUpdate { set; get; }
    
    public class ProcessingException extends Exception {}
    
    public Opportunity_UpdateRequirements(Opportunity[] opportunityOldList, Opportunity[] opportunityNewList) {
        super(opportunityOldList, opportunityNewList);
        forceUpdate = false;
    }
    
    // This trigger applies when the program has changed
    
    public virtual override void execute() {
        // return; // Temporarily disabled by Mahesh to fix issues , conflicting with other trigger. 
        // Disabled at a global level?
        if (getDisabledSetting().Opportunity_UpdateRequirements__c == true)
            return;
        
        // Extra a list of programs from the opportunities
        Set<Id> opportunityProgramIds = new Set<Id> {};
        Set<Id> opportunityProgramCountryIds = new Set<Id> {};
        Set<Id> opportunityProgramDepartmentIds = new Set<Id> {};
        Set<String> opportunityCountryResidence = new set<String>();
        
        // Maps for insert/delete recognition
        Map<String, Requirement__c> requirementOldMap = new Map<String, Requirement__c> {}; 
        Map<String, Requirement__c> requirementNewMap = new Map<String, Requirement__c> {};
        Map<String,String> OppIdOfProCountry = new Map<String,String>(); 
        
        // getting Visa Requirement Type Id 
        String strRequirementTypeVisa = getVisaRequirementId();
                
        // Upsert and delete lists
        Requirement__c[] requirementUpsertList = new Requirement__c[] {};
        Requirement__c[] requirementDeleteList = new Requirement__c[] {};
        
        // Created set for upadted oppotunity
        for(Opportunity opportunityNew : opportunityNewList)
        {
        	/*
        	  Code Updated by : Niket Chandane
        	  Summary         : Added a line to fill the Map with opp id 
        	*/
        	opportunityCountryResidence.add(opportunityNew.Country_Of_Residence__c);
        	opportunityProgramIds.add(opportunityNew.Program__c);
            opportunityProgramCountryIds.add(opportunityNew.Program_Country__c);
            opportunityProgramDepartmentIds.add(opportunityNew.Program_Department__c);
        }
        
        // Get the Map of Opp Id and the Opportunity Programs Country 
        OppIdOfProCountry = getMapOppOfProgramCountry(opportunityCountryResidence);
        
        List<Requirement__c> lstOldRequirement = getOldRequirement(opportunityOldList);
        
        System.debug('Original Old Requirement ================>'+lstOldRequirement);
        // Build the old map
        if(lstOldRequirement != null && lstOldRequirement.size() > 0){
        	for(Requirement__c requirementOld : lstOldRequirement)
        		requirementOldMap.put(generateComparisonKey(requirementOld.Opportunity__c, requirementOld.Parent__r), requirementOld);
        }
        
        System.debug('Old requirement Map   =====>'+requirementOldMap);
        
        /*Creating set of new requiment as per updated opportunity country, dept and program */
        Requirement__c[] requirementAggregatedList = CollectRequirementForUpdatedOpportunity(opportunityProgramCountryIds,opportunityProgramDepartmentIds,opportunityProgramIds);
        
        System.debug('New Requirements to be Created ===> '+requirementAggregatedList); 
        
        //For efficiency, map each country, department, and program to requirement lists
        Map<Id, Requirement__c[]> requirementCountryMap = new Map<Id, Requirement__c[]> {};
        Map<Id, Requirement__c[]> requirementDepartmentMap = new Map<Id, Requirement__c[]> {};
        Map<Id, Requirement__c[]> requirementProgramMap = new Map<Id, Requirement__c[]> {};
       
        for(Requirement__c requirementAggregated : requirementAggregatedList) {
        	//requirementTemplateList.add(requirementAggregated);
            putRequirement(requirementCountryMap, requirementAggregated.Country__c, requirementAggregated);
            putRequirement(requirementDepartmentMap, requirementAggregated.Department__c, requirementAggregated);
            putRequirement(requirementProgramMap, requirementAggregated.Program__c, requirementAggregated);
        }
        
        // Build a map of desired requirements
        // Pick all the Requremets as per the Country, Program ,Department
        for(Opportunity opportunityNew : opportunityNewList){
            Requirement__c[] requirementTemplateList = new Requirement__c[] {};
            requirementTemplateList.addAll(getRequirementList(requirementCountryMap, opportunityNew.Program_Country__c));
            requirementTemplateList.addAll(getRequirementList(requirementDepartmentMap, opportunityNew.Program_Department__c));
            requirementTemplateList.addAll(getRequirementList(requirementProgramMap, opportunityNew.Program__c));
            
            // Need to avoid the requirements which are getting inserted duplicately
            requirementTemplateList = generateUniqueRequirementList(requirementTemplateList);
            
            System.debug('requirementTemplateList ===>'+requirementTemplateList);
            
            // Check each and see if it exists already
            Integer iCount = 0 ; 
            
            if(requirementTemplateList != null && requirementTemplateList.size() > 0)
            {
	            for(Requirement__c requirementTemplate : requirementTemplateList) 
	            {
	                String comparisonKey = generateComparisonKey(opportunityNew.Id, requirementTemplate);
	                String strCountryId;
	                Requirement__c requirementNew;
	                // Try to find the pre-existing requirement
					if(requirementOldMap!= null && comparisonKey != null && requirementOldMap.ContainsKey(comparisonKey))
	                 {	
	                 	Requirement__c requirementOld = requirementOldMap.get(comparisonKey);
	                 	requirementNew = requirementOld.clone(false,false);
	                 }
	                
	                if(requirementNew == null)
	                	requirementNew = requirementTemplate.clone(false, false);
	                
	                /* Code commented by Niket 
	                	to delete all the old requirements 
	                    Code Commented : else{requirementOldMap.remove(comparisonKey);}*/
	                
	                // Whether new or merged, set certain field data
	                requirementNew.Program__c = null;    // clear this out so the related lists don't get polluted.
	                requirementNew.Country__c = null;    // this too
	                requirementNew.Department__c = null; // this too
	                requirementNew.Opportunity__c = opportunityNew.Id;
	                requirementNew.Contact__c = opportunityNew.Contact__c;
	                
	                // Maintain integrity
	                requirementNew.Description__c = requirementTemplate.Description__c;
	                requirementNew.Name = requirementTemplate.Name;
	                requirementNew.Parent__c = requirementTemplate.Id;
	                requirementNew.RecordTypeId = requirementTemplate.RecordTypeId;
	                requirementNew.Required_For__c = requirementTemplate.Required_For__c;
	                
	                /*  
	                	Code Modified :Niket Chandane
	                	Summary       :Need To check that if Opportunity Country and Opportunity Program => Country 
	                				   is same then Visa requrement should not be added  
	                */
	                if(opportunityNew.Country_Of_Residence__c != null)
	                	strCountryId = OppIdOfProCountry.get(opportunityNew.Country_Of_Residence__c).subString(0,15);
	                if(strCountryId != null && !strCountryId.equals(opportunityNew.Program_Country__c))
	                	requirementUpsertList.add(requirementNew);
	                else{
	                	if(!String.valueOf(requirementNew.RecordTypeId).equals(strRequirementTypeVisa))
	                		requirementUpsertList.add(requirementNew);
	                }
	            }
            }
        }
        
        // Scan through the old map and mark for deletion anything that isn't supplied, verified, approved, or waived
        // Need to delete the Old Requrement
        //for(Requirement__c requirementOld : requirementOldMap.values())
        for(Requirement__c requirementOld : lstOldRequirement)
           requirementDeleteList.add(requirementOld);
        
        // Run DML
       if (requirementDeleteList.size() != 0)
            delete requirementDeleteList;
            
       if (requirementUpsertList.size() != 0)
       	   insert requirementUpsertList;
    }
    
    /*
       Method Created BY : Niket Chandane
       Parameters        : N/A
       Summary 			 : Method returns the VISA recordtype id.  
       Return 			 : String
    */
    public String getVisaRequirementId(){
    	return [Select r.SobjectType, r.Name, r.Id From RecordType r where r.SobjectType ='Requirement__c' and Name ='Visa'][0].Id;
    } 
    
    /*
       Method Created BY : Niket Chandane
       Parameters        : Set<String> setCountryName
       Summary 			 : Method accepts the set of Country name 
       					   and returns the Map of Country Name and Country id.  
       Return 			 : Map<String,String>
    */
    public Map<String,String> getMapOppOfProgramCountry(Set<String> setCountryName){
    	Map<String,String> mapProgramIdwithCountries = new Map<String,String>();
    	for(Country__c objCountry : [Select c.Name, c.Id From Country__c c where c.Name in : setCountryName])
    		mapProgramIdwithCountries.put(objCountry.Name,objCountry.Id);
    	
    	return mapProgramIdwithCountries;
    }
    
     /*
       Method Created BY : Niket Chandane
       Parameters        : set<Id> opportunityProgramCountryIds, set<Id> opportunityProgramDepartmentIds,set<Id> opportunityProgramIds
       Summary 			 : Method accepts the set of Country,Dept,Program
       					   and returns the list of the requirements
       Return 			 : Requirement__c[]
    */
    
    public Requirement__c[] CollectRequirementForUpdatedOpportunity(set<Id> opportunityProgramCountryIds, set<Id> opportunityProgramDepartmentIds,set<Id> opportunityProgramIds)
    {
    	return [
            select Name
                 , Comparison_Key__c
                 , Country__c
                 , Department__c
                 , Description__c
                 , Program__c
                 , RecordTypeId
                 , Required_By__c
                 , Required_For__c
              from Requirement__c
             where ((Country__c != null and Country__c in :opportunityProgramCountryIds)
                or (Department__c != null and Department__c in :opportunityProgramDepartmentIds)
                or (Program__c != null and Program__c in :opportunityProgramIds))
               and Contact__c = null
               and Opportunity__c = null
               and Parent__c = null
        ];
    }
    
    /*
       Method Created BY : Niket Chandane
       Parameters 	     : Opportunity[] opportunityOldList
       Summary 			 : Method accepts the list of the Old Opportunity
       					   and returns the list of the requirements
       Return            : Requirement__c[] 				   
    */
    
    public  Requirement__c[] getOldRequirement(Opportunity[] opportunityOldList)
    {
       return [select Id
            	 , Opportunity__c
                 , Parent__r.Comparison_Key__c
                 , Approved__c
                 , Supplied__c
                 , Waived__c
                 , Verified__c
              from Requirement__c
             where Opportunity__c in :opportunityOldList
               and Parent__c != null];
    }
    
    
    public Requirement__c[] getRequirementList(Map<Id, Requirement__c[]> requirementMap, Id referenceId) 
    {
    	return requirementMap.get(referenceId) == null ? new Requirement__c[] {} : requirementMap.get(referenceId);
    }
    
    public void putRequirement(Map<Id, Requirement__c[]> requirementMap, Id referenceId, Requirement__c requirement) 
    {
        if (requirementMap == null || referenceId == null || requirement == null)
            return;
        else if (requirementMap.get(referenceId) != null)
            requirementMap.get(referenceId).add(requirement);
        else
            requirementMap.put(referenceId, new Requirement__c[] { requirement });
    }
    
    public String generateComparisonKey(Id opportunityId, Requirement__c parentRequirement) {
        if (parentRequirement != null && parentRequirement.Comparison_Key__c != null)
        {
            return opportunityId + ':' + parentRequirement.Comparison_Key__c;
        }
        if (parentRequirement != null && parentRequirement.Id != null)
        {
            return opportunityId + ':' + parentRequirement.Id;
        }
        throw new ProcessingException(Label.Unable_to_generate_a_unique_identifier);
    }
    
    public  Requirement__c[] generateUniqueRequirementList( Requirement__c[] requirementList)
    { 
    	if(requirementList != null && requirementList.size() < 1)
    	return null;
    	set<String> setkey = new set<String>();
    	Map<String,Requirement__c> MapKeyReq = new Map<String,Requirement__c>(); 
    	for(Requirement__c objReq : requirementList)
    	{
    		/*
    		      objReq.Required_For__c is formula field
    			 	IF(NOT(ISBLANK(Parent__r.Country__c)), 'Country',
					IF(NOT(ISBLANK(Parent__r.Department__c)), 'Department',
					IF(NOT(ISBLANK(Parent__r.Program__c)), 'Program', 'Other')))
    		*/
    		
    		String strRequired_For;
    		if(objReq.Country__c != null)
    			strRequired_For = objReq.Country__c;
    		else if(objReq.Department__c != null)
    			strRequired_For = objReq.Department__c;
    		else if(objReq.Program__c != null)
    			strRequired_For = objReq.Program__c;
    			
    		String strCommanKey = objReq.Name + objReq.RecordTypeId + strRequired_For;
    		
    		// Need to fill the Set ans Map with same key
    		setkey.add(strCommanKey);
			MapKeyReq.put(strCommanKey,objReq);
    	}
    	// Clear all parent requirement list to avoid duplication
    	requirementList.clear();
    	
    	// Fill the unique requirement
    	for(String strSetKey : setkey){
    		requirementList.add(MapKeyReq.get(strSetKey));
    	}
		return requirementList;
    }
}