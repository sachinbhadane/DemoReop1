public without sharing class RoutingTable_SetUniquenessId extends RoutingTableTrigger { 
    public RoutingTable_SetUniquenessId(Routing_Table__c[] routingOldList, Routing_Table__c[] routingNewList) {
        super(routingOldList, routingNewList);
    }
    
    public override void execute() {
        system.assert(Trigger.isBefore, 'RoutingTable_SetUniquenessId: This code must be run as a before trigger.');
        
        for(Routing_Table__c routing : getRoutingTableNewList()) {
            // NOTE: we do a replaceAll() because this is a before trigger, and the lower/upper bound
            // parser may not have run yet. So, in lieu, we just strip all spaces and hope it works.
            
            if (routing.Is_Active__c == true) {
                routing.Uniqueness_ID__c = blankValue(routing.Matching__c).replaceAll(' ', '') + ':'
                                         
                                         // All record types
                                         + blankValue(routing.Lead_Source__c) + ':'
                                         + blankValue(routing.Lead_Status__c) + ':'
                                         + blankValue(routing.Country__c) + ':'
                                         + blankValue(routing.State__c) + ':'
                                         
                                         // RecordType = Recruiting
                                         + blankValue(routing.Age_Range__c) + ':'
                                         + blankValue(routing.Department__c) + ':'
                                         + blankValue(routing.Region__c) + ':'
                                         + blankValue(routing.Work_Load__c);
                if (new Set<String> { 'Department Name', 'Department ID' }.contains(routing.Routed_By__c)) {
                    routing.Uniqueness_ID__c += ':' + 'Department';
                    routing.Uniqueness_ID__c += ':' + routing.Routed_To__c;
                }
                
                routing.Uniqueness_ID__c = routing.Uniqueness_Id__c.toUpperCase();
                routing.Uniqueness_ID__c = Crypto.generateDigest('MD5', Blob.valueOf(routing.Uniqueness_ID__c)).toString();
            } else {
                routing.Uniqueness_ID__c = null;
            }
        }
    }
    
    String blankValue(String value) {
        return value == null ? '' : value.trim();
    }
}