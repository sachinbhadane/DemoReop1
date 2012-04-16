public abstract class RoutingTableTrigger {
    Routing_Table__c[] routingOldList;
    Routing_Table__c[] routingNewList;
    
    public RoutingTableTrigger(Routing_Table__c[] routingOldList, Routing_Table__c[] routingNewList) {
        this.routingOldList = routingOldList;
        this.routingNewList = routingNewList;
    }
    
    protected Routing_Table__c[] getRoutingTableOldList() {
        return routingOldList;
    }
    
    protected Routing_Table__c[] getRoutingTableNewList() {
        return routingNewList;
    }
    
    public abstract void execute(); 
}