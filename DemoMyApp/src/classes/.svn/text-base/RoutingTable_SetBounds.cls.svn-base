public with sharing class RoutingTable_SetBounds extends RoutingTableTrigger { 
    // Matching "12345 - 12346" or "1T0 345-2Z4"
    final static Pattern namePattern1 = Pattern.compile('^(.+?)-(.+)$');
    
    // Matching "12345" or "1T0 345"
    final static Pattern namePattern2 = Pattern.compile('^([0-9a-zA-Z ]+?)$');
    
    public RoutingTable_SetBounds(Routing_Table__c[] routingOldList, Routing_Table__c[] routingNewList) {
        super(routingOldList, routingNewList);
    }
    
    public override void execute() {
        system.assert(Trigger.isBefore, 'RoutingTable_SetBounds: This code must be run as a before trigger.');
        
        for(Routing_Table__c routing : getRoutingTableNewList()) {
            if (routing == null)
                continue;
            if (routing.RecordTypeId != RoutingAnalysis.RecordTypePostalCode)
                continue;
            if (routing.Matching__c == null)
                routing.addError('RoutingTable_SetBounds: routing.Matching__c == null');
            
            // Consistency
            routing.Matching__c = routing.Matching__c.toUpperCase().trim();
            
            // Matches?
            Matcher nameMatcher1 = namePattern1.matcher(routing.Matching__c);
            Matcher nameMatcher2 = namePattern2.matcher(routing.Matching__c);
            
            if (nameMatcher1.matches()) {
                routing.Lower_Bound__c = nameMatcher1.group(1).toUpperCase().trim();
                routing.Upper_Bound__c = nameMatcher1.group(2).toUpperCase().trim();
            } else if (nameMatcher2.matches()) {
                routing.Lower_Bound__c = routing.Matching__c;
                routing.Upper_Bound__c = routing.Matching__c;
            } else {
                routing.Matching__c.addError('Invalid format for matching a zip/postal code: ' + routing.Matching__c);
            }
        }
    }
}