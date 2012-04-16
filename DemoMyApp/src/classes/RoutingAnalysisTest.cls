@IsTest 
private class RoutingAnalysisTest {
    public static testmethod void test() {
        RoutingAnalysis routingAnalysis = new RoutingAnalysis();
        routingAnalysis.initialize();
        //routingAnalysis.analyzeByPostalCode();
        //routingAnalysis.analyzeByProximity();
        routingAnalysis.getRoutingTotalCount();
        routingAnalysis.getRoutingTotalActiveCount();
        routingAnalysis.getRoutingCountLeadSourceOnly();
        routingAnalysis.getRoutingCountLeadStatusOnly();
        routingAnalysis.getIsPostalCode();
        routingAnalysis.getIsProximity();
        
        system.assert(routingAnalysis != null);
        system.assert(routingAnalysis.getIsPostalCode() != null);
        system.assert(routingAnalysis.getIsProximity() != null);
    }
}