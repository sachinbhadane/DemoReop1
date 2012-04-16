public without sharing class Contact_RouteByRecruiting extends ContactExtension {
    final Id contactId;
   
    public Contact_RouteByRecruiting(ApexPages.StandardController controller) {
        super(controller);
        this.contactId = controller.getId();
    }
    public PageReference execute() {
    	update new Contact(Id = contactId, Apply_Routing_Type__c = RoutingAnalysis.RoutingTypeRecruiting);
    	return new PageReference('/' + contactId);
    }
    public static void applyRouting(Contact[] contactNewList) 
    {
    	final Routing_Table__c[] routingList = getRoutingTableList(contactNewList);
    	
    	/*Changes by : Sachin Bhadane  */
    	/*Summary    : Removing Applicant which doesnot have record type as "Hult Applicant" 
    	               Only Hult Applicant will getting applied for Routing Engine */ 
    	contactNewList = getHultApplicantList(contactNewList);
    	if(contactNewList  == null || contactNewList.size() == 0)
    		return;
    	
    	// Map will store string Account name Vs List of Account
    	Map <String,List<Account>> departmentRegionRelatedAccountsMap = new Map <String,List<Account>>();
        String strAccountKey;
        
       // Clear the routing
        for (Contact contactNew : contactNewList)
            contactNew.Apply_Routing_Type__c = null;
            
        if (routingList.size() == 0)
            return; // can't route on an empty table  (for Undecided-undecided case)
            
        final Map<String, Id> routingUserMap = RoutingAnalysis.getRoutingUserMap(routingList);
        
        // Rewrite the routing table with the actual ids
        for(Routing_Table__c routing : routingList) 
        {  
            if (RoutingAnalysis.RoutedByUserName != null && RoutingAnalysis.RoutedByUserName.equalsIgnoreCase(routing.Routed_By__c))
                routing.Routed_To__c = routingUserMap.get(routing.Routed_To__c);
            else if (RoutingAnalysis.RoutedByUserId != null && RoutingAnalysis.RoutedByUserId.equalsIgnoreCase(routing.Routed_By__c) == false)
                routing.Routed_To__c = null; // contacts only support routing by user name or id.
        }
             
        
        // Fill the key as conmbination of Department and Region
        for(Routing_Table__c routing : routingList)
        {
        	//Setting Routing Key
        	strAccountKey = getAccountKey(routing);
        	
        	if(departmentRegionRelatedAccountsMap.containsKey(strAccountKey) == false)
        	   	departmentRegionRelatedAccountsMap.put(strAccountKey,new List<Account>());
        }
        
        // Fill Map of Account Name vs List of Accounts
        for(Account account : [
        	select Id,Name
        	from Account 
        	where Name in : departmentRegionRelatedAccountsMap.keySet()])
        {
        	if(account.Name != null && departmentRegionRelatedAccountsMap.containsKey((account.Name).toLowerCase()))
        		departmentRegionRelatedAccountsMap.get((account.Name).toLowerCase()).add(account);
        }
        /*****Change by : Niket******///End
        for(Contact contactNew : contactNewList) 
        {
        	String strRoutingKey;
        	String routingGroup = null;
            Routing_Table__c[] routingGroupList = new Routing_Table__c[] {};
            
            for(Routing_Table__c r : routingList) {
                if (r.Routed_To__c == null)
                    continue;
                    
                // NOTE: r.Region__c is ignored for routing purposes.
                if (definitiveNotMatched(r.Country__c, contactNew.Country_Of_Residence_Name__c))
                 	   continue;
                if (definitiveNotMatched(r.State__c, contactNew.MailingState))
                 	   continue;
                if (definitiveNotMatched(r.Age_Range__c, contactNew.Age_Range__c))
                	    continue;
                if (definitiveNotMatched(r.Work_Load__c, contactNew.Work_Load__c))
                 	   continue;
                if (definitiveNotMatched(r.Department__r.Name, contactNew.Department_Name_Primary__c))
                  	  continue;
                
                // So far, we've matched. If this is NOT a grouping, select the rule and break the loop.
                if (r.Priority_Grouping__c != true) {
                    routingGroupList.add(r);
                    break;
                }
                
                // Grouping logic: add only if the group is null (ie, first pass), or the priority matches
                if (routingGroup == null || routingGroup.equalsIgnoreCase(r.Priority__c)) {
                    routingGroup = r.Priority__c;
                    routingGroupList.add(r);
                }
            }
            if (routingGroupList.size() == 0)
                continue;
            
             /*  
            	Code Modified By : Sachin Bhadane 
             	Summary 		 : Pick up the 0th index route from routingGroupList 
             					   Pick a random route from the group.
          	 					   Integer randomIndex = math.floor(math.random() * routingGroupList.size()).intValue();
             					   Routing_Table__c routing = routingGroupList.get(randomIndex); */
            Routing_Table__c routing = routingGroupList.get(0);
            
            // Creating routing key	
            strRoutingKey = getAccountKey(routing);
            System.debug('strRoutingKey  =============>'+strRoutingKey);
            /* Updated the Account ID as per the  routing Department-Region */
            if(departmentRegionRelatedAccountsMap.containsKey(strRoutingKey)){
            	if(departmentRegionRelatedAccountsMap.get(strRoutingKey).size() > 0)
            		contactNew.AccountId = departmentRegionRelatedAccountsMap.get(strRoutingKey)[0].id;
            }
            else // If not able to set the account need to throw error
            	throw new RoutingException(Label.RoutingException_Unable_to_find_Parent_Account);
            	
            System.debug('contactNew.AccountId  =============>'+contactNew.AccountId );
            
            /*
            	Note :If do not route flag is checked then we are not going to route record
            		  but account will update as per the Dept-Region
            */ 
            if (contactNew.Do_Not_Route__c == true)
                continue;
            	
            	contactNew.OwnerId = routing.Routed_To__c;
            // Override the region?
            System.DEbug('***contactNew.OwnerId'+contactNew.OwnerId);
            System.Debug('***RoutingAnalysis.getSetting().Override_When_Blank__c==>'+RoutingAnalysis.getSetting().Override_When_Blank__c);
            if (RoutingAnalysis.getSetting().Override_Contact_Region__c == true && routing.Region__c == null && RoutingAnalysis.getSetting().Override_When_Blank__c == true) {
                contactNew.Region__c = routing.Region__c;
                System.Debug('***contactNew.Region__c1 ==>'+contactNew.Region__c );
                contactNew.Sub_Region__c = routing.Sub_Region__c;
            }
	        if (RoutingAnalysis.getSetting().Override_Contact_Region__c == true && routing.Region__c != null) {
	                contactNew.Region__c = routing.Region__c;
	                System.Debug('***contactNew.Region__c2 ==>'+contactNew.Region__c );
	                contactNew.Sub_Region__c = routing.Sub_Region__c;
             }
             System.debug('contactNew.Region__c  =============>'+contactNew.Region__c);
            
           }
            
           System.debug('contactNewList =============>'+contactNewList);
           
    }
    /*Changes by :: Sachin Bhadane  
        Summary :: Method to Return RecordType Id */
    static String getHultApplicantRecordTypeId()
    {
    	//String recordType = Label.HultApplicant_Record_Type;
    	return [Select Id From RecordType where Name =: Label.HultApplicant_Record_Type limit 1].Id;
    }
    /*  Summary :: Method to Return ApplicantList which contains only Hult Applicant. */
    static Contact[] getHultApplicantList(Contact[] applicantList)
    {
    	Contact[] hultApplicantList = new Contact[] {};
    	String strHultID = getHultApplicantRecordTypeId(); 
    	for(Contact objContact:applicantList)
    	{
    		System.Debug('strHultID===>>'+strHultID);
    		System.Debug('objContact.recordTypeId===>'+objContact.recordTypeId);
    		System.Debug('strHultID.equals(objContact.recordTypeId)===>>'+strHultID.equals(objContact.recordTypeId));
    		if(strHultID.equals(objContact.recordTypeId))
    			hultApplicantList.add(objContact);
    	}
    	return hultApplicantList;
    }
   /* Summary :: Method to Return Routing Key based on Department name and Region.*/
   static String getAccountKey(Routing_Table__c objRouting)
    {
    	String accountKey;
        if(objRouting.Department__r.Name  == null && objRouting.Region__c  == null)
        	accountKey = Label.Undecided_Account_Kay;
        else if(objRouting.Department__r.Name  != null && objRouting.Region__c  == null)
        	accountKey = objRouting.Department__r.Name + Label.Unknown;
        else if(objRouting.Department__r.Name  == null && objRouting.Region__c  != null)
        	accountKey = Label.Undecided + objRouting.Region__c;
        else if(objRouting.Department__r.Name  != null && objRouting.Region__c  != null)
        	accountKey = objRouting.Department__r.Name+'-'+ objRouting.Region__c;
       return accountKey.toLowerCase();
    }
   /*Changes by :: Sachin Bhadane  Ends Here */
    
    
    /*
    	Class 		: RoutingException
    	Created by 	: Niket Chandane
    	Summary   	: RoutingException class used for RoutingException (Custom Development)
    */
    public class RoutingException extends Exception {}
    
    public static Routing_Table__c[] getRoutingTableList(Contact[] contactList) 
    {
        Set<String> contactCountryIdSet = new Set<String> { null };
        Set<String> contactCountrySet = new Set<String> { null };
        Set<String> contactStateSet = new Set<String> { null };
        Set<String> contactDepartmentSet = new Set<String> { null };
        Set<String> contactAgeRangeSet = new Set<String> { null };
        Set<String> contactWorkLoadSet = new Set<String> { null };
        // Now search the contacts
        for(Contact contact : contactList) {
            contactCountrySet.add(contact.Country_Of_Residence_Name__c); // only if available; may not be populated from the analysis tool.
            contactCountryIdSet.add(contact.Country_Of_Residence__c);
            contactStateSet.add(contact.MailingState);
            contactDepartmentSet.add(contact.Department_Name_Primary__c);
            contactAgeRangeSet.add(contact.Age_Range__c);
            contactWorkLoadSet.add(contact.Work_Load__c);
        }
        // Special handling for the country of residence
        for(Country__c country : [
            select Name
              from Country__c
             where Id in :contactCountryIdSet
        ]) contactCountrySet.add(country.Name); 
        // When these contacts are coming in from the analysis tool, the formulas won't populate the departments
        // properly, so we have to do a manual search. We can tell if this is the origin, because the contact list
        // will be only 1 record long.
        if (contactList.size() == 1) {
            for(Program__c program : [
                select Department__r.Name
                  from Program__c
                 where Id = :contactList[0].Program_Primary__c
            ]) contactDepartmentSet.add(program.Department__r.Name);
        }
        return [
            select Name
                 , Age_Range__c
                 , City__c
                 , Country__c
                 , Comment__c
                 , Department__c
                 , Department__r.Name
                 , Granularity__c
                 , Lead_Source__c
                 , Lead_Status__c
                 , Priority__c
                 , Priority_Value__c
                 , Priority_Grouping__c
                 , Region__c
                 , Routed_By__c
                 , Routed_To__c
                 , State__c
                 , Sub_Region__c
                 , Work_Load__c
              from Routing_Table__c
             where Is_Active__c = true
               and RecordTypeId = :RoutingAnalysis.RecordTypeRecruiting
               and Country__c in :contactCountrySet
               and State__c in :contactStateSet
               and Department__r.Name in :contactDepartmentSet
               and Age_Range__c in :contactAgeRangeSet
               and Work_Load__c in :contactWorkLoadSet
          order by Priority_Value__c desc
                 , Granularity__c desc
        ]; // yes, we are selecting all routing table entries (although with preconditions) 
    }
    // Commonality
    static Boolean definitiveNotMatched(String value1, String value2) {
        return value1 != null && value2 != null && value1.equalsIgnoreCase(value2) == false;
    }
}