public without sharing class Lead_RouteByRecruiting extends LeadExtension {
    final Id leadId;
    
    public Lead_RouteByRecruiting(ApexPages.StandardController controller) {
        super(controller);
        this.leadId = controller.getId();
    }
    
    public PageReference execute() {
        update new Lead(Id = leadId, Apply_Routing_Type__c = RoutingAnalysis.RoutingTypeRecruiting);
        return new PageReference('/' + leadId);
    }

    public static void applyRouting(Lead[] leadNewList) {
        final Routing_Table__c[] routingList = getRoutingTableList(leadNewList);
        
        // Clear the routing
        for (Lead leadNew : leadNewList)
            leadNew.Apply_Routing_Type__c = null;
        
        system.debug('Lead_RouteByRecruiting.applyRouting(): leadNewList = ' + leadNewList);
        system.debug('Lead_RouteByRecruiting.applyRouting(): routingList = ' + routingList);
        
        if (routingList.size() == 0)
            return; // can't route on an empty table
        
        final Map<String, Id> routingQueueMap = RoutingAnalysis.getRoutingQueueMap(routingList);
        final Map<String, Id> routingUserMap = RoutingAnalysis.getRoutingUserMap(routingList);
        
        system.debug('Lead_RouteByRecruiting.applyRouting(): routingQueueMap = ' + routingQueueMap);
        system.debug('Lead_RouteByRecruiting.applyRouting(): routingUserMap = ' + routingUserMap);
        
        // Rewrite the routing table with the actual ids
        for(Routing_Table__c routing : routingList) {
            if (RoutingAnalysis.RoutedByQueueName.equalsIgnoreCase(routing.Routed_By__c))
                routing.Routed_To__c = routingQueueMap.get(routing.Routed_To__c);
            if (RoutingAnalysis.RoutedByUserName.equalsIgnoreCase(routing.Routed_By__c))
                routing.Routed_To__c = routingUserMap.get(routing.Routed_To__c);
        }
        
        // Map the country ids to names
        Map<Id, String> countryNameMap = new Map<Id, String> {};
        
        for(Lead leadNew : leadNewList) {
            countryNameMap.put(leadNew.Country_Of_Residence__c, null);
        }
        
        for(Country__c country : [
            select Name
              from Country__c
             where Id in :countryNameMap.keySet()
        ]) countryNameMap.put(country.Id, country.Name);
        
        system.debug('Lead_RouteByRecruiting.applyRouting(): countryNameMap = ' + countryNameMap);
        
        for(Lead leadNew : leadNewList) {
            Routing_Table__c routing;
            
            system.debug('Lead_RouteByRecruiting.applyRouting(): starting loop for leadNew = ' + leadNew);
            
            for(Routing_Table__c r : routingList) {
                system.debug('Lead_RouteByRecruiting.applyRouting(): starting loop for r = = ' + r);
                
                if (r.Routed_To__c == null)
                    continue;
                
                // NOTE: r.Region__c is ignored for routing purposes.
                
                if (definitiveNotMatched(r.Country__c, countryNameMap.get(leadNew.Country_Of_Residence__c)))
                    continue;
                if (definitiveNotMatched(r.State__c, leadNew.State))
                    continue;
                if (definitiveNotMatched(r.Age_Range__c, leadNew.Age_Range__c))
                    continue;
                if (definitiveNotMatched(r.Work_Load__c, leadNew.Work_Load__c))
                    continue;
                if (definitiveNotMatched(r.Department__r.Name, leadNew.Department_Name_Primary__c))
                    continue;
                if (definitiveNotMatched(r.Lead_Source__c, leadNew.LeadSource))
                    continue;
                if (definitiveNotMatched(r.Lead_Status__c, leadNew.Status))
                    continue;
                
                system.debug('Lead_RouteByRecruiting.applyRouting(): matched route');
                routing = r;
                break;
            }
            
            system.debug('Lead_RouteByRecruiting.applyRouting(): inner loop finished: routing = ' + routing);
            
            if (routing == null)
                continue;
            
            // I've put the do not route flag here so that the analysis is done normally, but
            // we bail at the last minute.
            if (leadNew.Do_Not_Route__c == true)
                continue; // routing turned off
            if (leadNew.IsConverted == true)
                continue;
            
            // Debug userMap
            system.debug('Lead_RouteByRecruiting.applyRouting(): applying owner = ' + routing.Routed_To__c);
            
            // Apply the owner
            leadNew.OwnerId = routing.Routed_To__c;
            
            // Override the region?
            if (RoutingAnalysis.getSetting().Override_Lead_Region__c == true && routing.Region__c == null && RoutingAnalysis.getSetting().Override_When_Blank__c == true) {
                leadNew.Region__c = routing.Region__c;
                leadNew.Sub_Region__c = routing.Sub_Region__c;
            }
            
            if (RoutingAnalysis.getSetting().Override_Lead_Region__c == true && routing.Region__c != null) {
                leadNew.Region__c = routing.Region__c;
                leadNew.Sub_Region__c = routing.Sub_Region__c;
            }
        }
        
        system.debug('Lead_RouteByRecruiting.applyRouting(): finished outer loop');
    }
    
    public static Routing_Table__c[] getRoutingTableList(Lead[] leadList) {
        Set<String> leadRegionSet = new Set<String> { null };
        Set<String> leadCountryIdSet = new Set<String> { null };
        Set<String> leadCountrySet = new Set<String> { null };
        Set<String> leadStateSet = new Set<String> { null };
        Set<String> leadDepartmentSet = new Set<String> { null };
        Set<String> leadAgeRangeSet = new Set<String> { null };
        Set<String> leadWorkLoadSet = new Set<String> { null };
        Set<String> leadSourceSet = new Set<String> { null };
        Set<String> leadStatusSet = new Set<String> { null };
        
        System.debug('Inside the getRouting table ===========>'+leadList);
        // Now search the leads
        for(Lead lead : leadList) {
            leadCountryIdSet.add(lead.Country_Of_Residence__c);
            leadStateSet.add(lead.State);
            leadDepartmentSet.add(lead.Department_Name_Primary__c);
            leadAgeRangeSet.add(lead.Age_Range__c);
            leadWorkLoadSet.add(lead.Work_Load__c);
            leadSourceSet.add(lead.LeadSource);
            leadStatusSet.add(lead.Status);
        }
        
        // Special handling for the country of residence
        for(Country__c country : [
            select Name
              from Country__c
             where Id in :leadCountryIdSet
        ]) leadCountrySet.add(country.Name);
        
       System.debug('Created country set ===========>'+leadCountrySet);
       System.debug('Created leadStateSet set ===========>'+leadStateSet);
        // When these leads are coming in from the analysis tool, the formulas won't populate the departments
        // properly, so we have to do a manual search. We can tell if this is the origin, because the lead list
        // will be only 1 record long.
        if (leadList.size() == 1) {
            for(Program__c program : [
                select Department__r.Name
                  from Program__c
                 where Id = :leadList[0].Program_Primary__c
            ]) leadDepartmentSet.add(program.Department__r.Name);
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
                 , Region__c
                 , Routed_By__c
                 , Routed_To__c
                 , State__c
                 , Sub_Region__c
                 , Work_Load__c
              from Routing_Table__c
             where Is_Active__c = true
               and RecordTypeId = :RoutingAnalysis.RecordTypeRecruiting
               and Country__c in :leadCountrySet
               and State__c in :leadStateSet
               and Department__r.Name in :leadDepartmentSet
               and Age_Range__c in :leadAgeRangeSet
               and Work_Load__c in :leadWorkLoadSet
               and Lead_Source__c in :leadSourceSet
               and Lead_Status__c in :leadStatusSet
          order by Priority_Value__c desc
                 , Granularity__c desc
        ]; // yes, we are selecting all routing table entries (although with preconditions) 
    }
    
    static Boolean definitiveNotMatched(String value1, String value2) {
        return value1 != null && value2 != null && value1.equalsIgnoreCase(value2) == false;
    }
}