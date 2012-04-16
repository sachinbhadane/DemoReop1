public with sharing class RoutingTable_SetCoordinates extends RoutingTableTrigger { 
    // Matching "37.423021,-122.083739" or "37,-122"
    final static Pattern namePattern1 = Pattern.compile('^(.+?),(.+)$');

    public RoutingTable_SetCoordinates(Routing_Table__c[] routingOldList, Routing_Table__c[] routingNewList) {
        super(routingOldList, routingNewList);
    }
    
    public override void execute() {
        for(Routing_Table__c routing : getRoutingTableNewList()) {
            if (routing == null)
                continue;
            if (routing.RecordTypeId != RoutingAnalysis.RecordTypeProximity)
                continue;
            if (routing.Matching__c == null)
                routing.addError('RoutingTable_SetBounds: routing.Matching__c == null');
            
            // Consistency
            routing.Matching__c = routing.Matching__c.toUpperCase().trim();
            
            // Matches?
            Matcher nameMatcher1 = namePattern1.matcher(routing.Matching__c);
            
            if (nameMatcher1.matches()) {
                routing.Lat__c = Decimal.valueOf(nameMatcher1.group(1).toUpperCase().trim());
                routing.Lon__c = Decimal.valueOf(nameMatcher1.group(2).toUpperCase().trim());
                
                // Sanity checks on the latitude
                if (routing.Lat__c > +90)
                    routing.Matching__c.addError('Latitude is greater than +90 degrees.. did you reverse the lat/lon order?');
                if (routing.Lat__c < -90)
                    routing.Matching__c.addError('Latitude is less than -90 degrees.. did you reverse the lat/lon order?');
            } else {
                routing.Matching__c.addError('Invalid format for matching proximity to a latitude/longitude: ' + routing.Matching__c);
            }
            
        }
        
    }
}