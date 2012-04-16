public without sharing class RoutingTable_ValidateUserId extends RoutingTableTrigger {
    public RoutingTable_ValidateUserId(Routing_Table__c[] routingOldList, Routing_Table__c[] routingNewList) {
        super(routingOldList, routingNewList);
    }
    
    public override void execute() {
        if (RoutingAnalysis.getSetting().Is_Validation_Disabled__c == true)
            return;
        if (RoutingAnalysis.getSetting().Is_Validation_Disabled_User_ID__c == true)
            return;
        
        system.assert(Trigger.isAfter, 'RoutingTable_ValidateUserId: This code must be run as an after trigger.');
        
        // build a list of all specified user ids
        Map<Id, User> routingUserMap = new Map<Id, User>();
        
        for(Routing_Table__c routing : getRoutingTableNewList()) {
            if (routing == null)
                continue;
            if (RoutingAnalysis.RoutedByUserId.equalsIgnoreCase(routing.Routed_By__c) == false)
                continue;
            if (routing.Routed_To__c == null)
                throw new RoutingAnalysis.RoutingException('RoutingTable_ValidateUserId: routing.Routed_To__c == null: should have been pre-validated');
            
            routingUserMap.put(routing.Routed_To__c, null);
        }
        
        if (routingUserMap.size() == 0)
            return;
        
        for(User user : [
            select Id
              from User
             where Id in :routingUserMap.keySet()
        ]) routingUserMap.put(user.Id, user);
        
        for(Routing_Table__c routing : getRoutingTableNewList()) {
            if (routing == null)
                continue;
            if (RoutingAnalysis.RoutedByUserId.equalsIgnoreCase(routing.Routed_By__c) == false)
                continue;
            if (routingUserMap.get(routing.Routed_To__c) != null)
                continue;
            routing.Routed_To__c.addError('User ID not found');
        }
    }
}