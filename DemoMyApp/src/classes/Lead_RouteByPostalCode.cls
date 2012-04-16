public with sharing class Lead_RouteByPostalCode extends LeadExtension {
    final Id leadId;
    
    public Lead_RouteByPostalCode(ApexPages.StandardController controller) {
        super(controller);
        this.leadId = controller.getId();
    }
    
    public PageReference execute() {
        update new Lead(Id = leadId, Apply_Routing_Type__c = RoutingAnalysis.RoutingTypePostalCode);
        return new PageReference('/' + leadId);
    }
    
    public static void applyRouting(Lead[] leadNewList) {
        /** Commented out to reduce code usage.
          * - Ian Zepp
          
        // Build a list of lead postal codes
        Lead[] leadRoutableList = new Lead[] {};
        
        for(Lead leadNew : leadNewList) {
            if (leadNew == null)
                continue;
            if (leadNew.PostalCode == null)
                continue;
            
            // Turn of the lead routing flag
            leadNew.Apply_Routing_Type__c = null;
            
            // Save the postal code
            String postalCode = RoutingAnalysis.getStandardizedPostalCode(leadNew.PostalCode, leadNew.Country);
            
            if (postalCode == null)
                continue;
            
            leadRoutableList.add(leadNew);
        }
        
        if (leadRoutableList.size() == 0)
            return;
        
        final Routing_Table__c[] routingList = getRoutingTableList(leadRoutableList);
        
        if (routingList.size() == 0)
            return; // can't route on an empty table
        
        final Map<String, Id> routingQueueMap = RoutingAnalysis.getRoutingQueueMap(routingList);
        final Map<String, Id> routingUserMap = RoutingAnalysis.getRoutingUserMap(routingList);
        
        // Rewrite the routing table with the actual ids
        for(Routing_Table__c routing : routingList) {
            if (RoutingAnalysis.RoutedByQueueName.equalsIgnoreCase(routing.Routed_By__c))
                routing.Routed_To__c = routingQueueMap.get(routing.Routed_To__c);
            if (RoutingAnalysis.RoutedByUserName.equalsIgnoreCase(routing.Routed_By__c))
                routing.Routed_To__c = routingUserMap.get(routing.Routed_To__c);
        }
        
        // Assign ownership on matching leads
        system.debug('Lead_RouteByPostalCode: leadRoutableList = ' + leadRoutableList);
        
        for(Lead leadNew : leadRoutableList) {
            // Find the relevant route
            String postalCode = RoutingAnalysis.getStandardizedPostalCode(leadNew.PostalCode, leadNew.Country);
            Routing_Table__c routing;
            
            for(Routing_Table__c r : routingList) {
                if (r.Lower_Bound__c > postalCode)
                    continue;
                if (r.Upper_Bound__c < postalCode)
                    continue;
                if (r.Lead_Source__c != null && r.Lead_Source__c.equalsIgnoreCase(leadNew.LeadSource) == false)
                    continue;
                if (r.Lead_Status__c != null && r.Lead_Status__c.equalsIgnoreCase(leadNew.Status) == false)
                    continue;
                if (r.Country__c != null && leadNew.Country != null && r.Country__c.equalsIgnoreCase(leadNew.Country) == false)
                    continue;
                if (r.Routed_To__c == null)
                    continue;
                
                routing = r;
                break;
            }
            
            if (routing == null)
                continue;
            
            // Debug userMap
            system.debug('Lead_RouteByPostalCode: applying owner of lead ' + leadNew.Id + ' to ' + routing.Routed_To__c);
            
            // Apply the owner
            leadNew.OwnerId = routing.Routed_To__c;
            
            // Override the Country?
            if (RoutingAnalysis.getSetting().Override_Lead_Country__c == true && routing.Country__c != '' && routing.Country__c != null)
                leadNew.Country = routing.Country__c;
            else if (RoutingAnalysis.getSetting().Override_Lead_Country__c == true && RoutingAnalysis.getSetting().Override_When_Blank__c == true)
                leadNew.Country = null;
            
            // Override the State?
            if (RoutingAnalysis.getSetting().Override_Lead_State__c == true && routing.State__c != '' && routing.State__c != null)
                leadNew.State = routing.State__c;
            else if (RoutingAnalysis.getSetting().Override_Lead_State__c == true && RoutingAnalysis.getSetting().Override_When_Blank__c == true)
                leadNew.State = null;
            
            // Override the City?
            if (RoutingAnalysis.getSetting().Override_Lead_City__c == true && routing.City__c != '' && routing.City__c != null)
                leadNew.City = routing.City__c;
            else if (RoutingAnalysis.getSetting().Override_Lead_City__c == true && RoutingAnalysis.getSetting().Override_When_Blank__c == true)
                leadNew.City = null;
        }
        */
    }
    
    public static Routing_Table__c[] getRoutingTableList(Lead[] leadList) {
        return new Routing_Table__c[] {};
        
        /** Commented out to reduce code usage.
          * - Ian Zepp
          
        Set<String> leadSourceSet = new Set<String> { null }; // must include by default
        Set<String> leadStatusSet = new Set<String> { null }; // must include by default
        Set<String> leadCountrySet = new Set<String> { null }; // must include by default
        String lowerBound;
        String upperBound;
        
        for(Lead lead : leadList) {
            // Save the postal code
            String postalCode = RoutingAnalysis.getStandardizedPostalCode(lead.PostalCode, lead.Country);
            
            // Set the bounds
            if (lowerBound == null || lowerBound > postalCode)
                lowerBound = postalCode;
            if (upperBound == null || upperBound < postalCode)
                upperBound = postalCode;
            
            // If the lead has a country set, use it
            if (lead.Country != null && lead.Country.trim().length() != 0)
                leadCountrySet.add(lead.Country.trim().toUpperCase());
            
            // Save reference
            leadSourceSet.add(lead.LeadSource);
            leadStatusSet.add(lead.Status);
        }
        
        // Debug postalCodeSet
        system.debug('Lead_RouteByPostalCode: lowerBound: ' + lowerBound);
        system.debug('Lead_RouteByPostalCode: upperBound: ' + upperBound);
        system.debug('Lead_RouteByPostalCode: leadSourceSet: ' + leadSourceSet);
        system.debug('Lead_RouteByPostalCode: leadStatusSet: ' + leadStatusSet);
        
        return [
            select Name
                 , City__c
                 , Country__c
                 , Granularity__c
                 , Lead_Source__c
                 , Lead_Status__c
                 , Lower_Bound__c
                 , Priority__c
                 , Priority_Value__c
                 , Routed_By__c
                 , Routed_To__c
                 , State__c
                 , Upper_Bound__c
              from Routing_Table__c
             where Is_Active__c = true
               and RecordTypeId = :RoutingAnalysis.RecordTypePostalCode
               and Lead_Source__c in :leadSourceSet
               and Lead_Status__c in :leadStatusSet
               and (Lower_Bound__c <= :lowerBound or Upper_Bound__c >= :upperBound)
               and (Country__c = null or Country__c in :leadCountrySet)
          order by Priority_Value__c desc
                 , Granularity__c desc
                 , Country__c desc
        ]; // yes, we are selecting all routing table entries (although with preconditions) 
        
        */
    }
}