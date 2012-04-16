public with sharing class Lead_RouteByProximity extends LeadExtension {
    final Lead lead;
    
    public Lead_RouteByProximity(ApexPages.StandardController controller) {
        super(controller);
        this.lead = (Lead) controller.getRecord();
    }
    
    public PageReference execute() {
        lead.Apply_Routing_Type__c = RoutingAnalysis.RoutingTypeProximity;
        update lead;
        return new PageReference('/' + getLeadId());
    }
    
    public static void applyRouting(Lead[] leadNewList) {
        /** Commented out to reduce code usage.
          * - Ian Zepp
        
        // Build a list of lead postal codes
        Lead[] leadRoutableList = new Lead[] {};
        
        for(Lead leadNew : leadNewList) {
            if (leadNew == null)
                continue;
            if (leadNew.Lat__c == null || leadNew.Lon__c == null)
                continue;
            
            // Turn of the lead routing flag
            leadNew.Apply_Routing_Type__c = null;
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
        
        for(Lead leadNew : leadRoutableList) {
            RoutingAnalysis.RoutingProximity[] proximityList = getSortedRoutingTableList(leadNew, routingList);
            
            if (proximityList.size() == 0)
                continue;
            
            // Debug userMap
            system.debug('Lead_RouteByProximity: applying owner of lead ' + leadNew.Id + ' to ' + proximityList[0].routing.Routed_To__c);
            
            // Apply the owner
            leadNew.OwnerId = proximityList[0].routing.Routed_To__c;
        }
        */
    }
    
    public static Routing_Table__c[] getRoutingTableList(Lead[] leadList) {
        return new Routing_Table__c[] {};
        
        /** Commented out to reduce code usage.
          * - Ian Zepp
        
        Set<String> leadSourceSet = new Set<String> { null }; // must include by default
        Set<String> leadStatusSet = new Set<String> { null }; // must include by default
        
        Decimal latLowerBound;
        Decimal latUpperBound;
        Decimal lonLowerBound;
        Decimal lonUpperBound;
        
        for(Lead lead : leadList) {
            if (latLowerBound == null || latLowerBound > lead.Lat__c)
                latLowerBound = lead.Lat__c;
            if (latUpperBound == null || latUpperBound < lead.Lat__c)
                latUpperBound = lead.Lat__c;
            
            if (lonLowerBound == null || lonLowerBound > lead.Lon__c)
                lonLowerBound = lead.Lon__c;
            if (lonUpperBound == null || lonUpperBound < lead.Lon__c)
                lonUpperBound = lead.Lon__c;
            
            // Save reference
            leadSourceSet.add(lead.LeadSource);
            leadStatusSet.add(lead.Status);
        }
        
        // Simple temp fix: +/- 1 degree from each boundary point (~ 55-70 miles)
        latLowerBound --;
        latUpperBound ++;
        
        lonLowerBound --;
        lonUpperBound ++;
        
        // Debug postalCodeSet
        system.debug('Lead_RouteByProximity: leadList: ' + leadList);
        system.debug('Lead_RouteByProximity: latLowerBound: ' + latLowerBound);
        system.debug('Lead_RouteByProximity: latUpperBound: ' + latUpperBound);
        system.debug('Lead_RouteByProximity: lonLowerBound: ' + lonLowerBound);
        system.debug('Lead_RouteByProximity: lonUpperBound: ' + lonUpperBound);
        system.debug('Lead_RouteByProximity: leadSourceSet: ' + leadSourceSet);
        system.debug('Lead_RouteByProximity: leadStatusSet: ' + leadStatusSet);
        
        return [
            select Name
                 , Granularity__c
                 , Lead_Source__c
                 , Lead_Status__c
                 , Lat__c
                 , Lon__c
                 , Priority__c
                 , Priority_Value__c
                 , Routed_By__c
                 , Routed_To__c
              from Routing_Table__c
             where Is_Active__c = true
               and RecordTypeId = :RoutingAnalysis.RecordTypeProximity
               and Lat__c >= :latLowerBound // outside the box
               and Lat__c <= :latUpperBound
               and Lon__c >= :lonLowerBound
               and Lon__c <= :lonUpperBound
               and Lead_Source__c in :leadSourceSet
               and Lead_Status__c in :leadStatusSet
          order by Granularity__c desc
        ]; // yes, we are selecting all routing table entries (although with preconditions)
        
        */
    }
    
    public static RoutingAnalysis.RoutingProximity[] getSortedRoutingTableList(Lead lead, Routing_Table__c[] routingList) {
        return new RoutingAnalysis.RoutingProximity[] {};
        /** Commented out to reduce code usage.
          * - Ian Zepp
          
        Map<Decimal, Routing_Table__c[]> routingMap = new Map<Decimal, Routing_Table__c[]> {};
        RoutingAnalysis.RoutingProximity[] proximitySortedList = new RoutingAnalysis.RoutingProximity[] {};
            
        for(Routing_Table__c r : routingList) {
            if (r.Lead_Source__c != null && r.Lead_Source__c.equalsIgnoreCase(lead.LeadSource) == false)
                continue;
            if (r.Lead_Status__c != null && r.Lead_Status__c.equalsIgnoreCase(lead.Status) == false)
                continue;
            if (r.Routed_To__c == null)
                continue;
            
            // Calculate the actual distance
            Decimal lat1 = RoutingAnalysis.PI_180 * r.Lat__c;
            Decimal lon1 = RoutingAnalysis.PI_180 * r.Lon__c;
            
            Decimal lat2 = RoutingAnalysis.PI_180 * lead.Lat__c;
            Decimal lon2 = RoutingAnalysis.PI_180 * lead.Lon__c;
            
            // http://williams.best.vwh.net/avform.htm#Dist
            Decimal d = RoutingAnalysis.RADIUS * math.acos(math.sin(lat1) * math.sin(lat2) + 
                                                           math.cos(lat1) * math.cos(lat2) * math.cos(lon1 - lon2));
            
            system.debug('distance = ' + d);
            
            // Add the routing to the map
            if (routingMap.containsKey(d) == false)
                routingMap.put(d, new Routing_Table__c[] {});
            routingMap.get(d).add(r);
        }
        
        // Sort the distances
        Decimal[] distanceList = new List<Decimal>(routingMap.keySet());
        distanceList.sort();
        
        // Build the sorted list
        for(Decimal distance : distanceList) {
            for(Routing_Table__c routing : routingMap.get(distance)) {
                RoutingAnalysis.RoutingProximity proximity = new RoutingAnalysis.RoutingProximity();
                proximity.distance = distance;
                proximity.routing = routing;
                proximitySortedList.add(proximity);
            }
        }
        
        return proximitySortedList; 
        */
    }
}