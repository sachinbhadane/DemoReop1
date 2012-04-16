public without sharing class Lead_ApplyRoutingTable extends LeadTrigger {
    public Lead_ApplyRoutingTable(Lead[] leadOldList, Lead[] leadNewList) {  
        super(leadOldList, leadNewList);
    }
    
    @future
    public static void executeFuture(Set<Id> leadIds) {
        Lead[] leadOldList = new Lead[] {};
        Lead[] leadNewList = [
            select Apply_Routing_Type__c
                 , IsConverted
                 , Lat__c
                 , Lon__c
                 , LeadSource
                 , PostalCode
                 , City
                 , Country
                 , OwnerId
                 , State
                 , Status
                 
                 // Hult fields
                 , Country_Of_Residence__c
                 , Country_Of_Residence_Name__c
                 , Age_Range__c
                 , Work_Load__c
                 , Department_Name_Primary__c
                 , Department_Name_Secondary__c
                 , Department_Name_Third__c
                 , Program_Primary__c
                 , Program_Secondary__c
                 , Program_Third__c
                 , Do_Not_Route__c
              from Lead
             where Id in :leadIds
        ];
        
        new Lead_ApplyRoutingTable(leadOldList, leadNewList).execute(false);
        update leadNewList;
    }
    
    public void executeFromTriggerUpdateAsQueueMessage() {
        if (RoutingAnalysis.getSetting().Is_Disabled__c == true)
            return;
        if (RoutingAnalysis.getSetting().Is_Disabled_On_Update__c == true)
            return;
        if (leadNewList.size() == 0) 
            return;
        
        Dom.Document doc = new Dom.Document();
        doc.createRootElement('message', null, null);
        
        for(Lead leadNew : leadNewList) {
            Lead leadOld = leadOld(leadNew.Id);
            
            Boolean isRoutable = leadNew.Program_Primary__c != leadNew.Program_Primary__c
                              || leadNew.Country_Of_Residence__c != leadNew.Country_Of_Residence__c
                              || leadNew.Apply_Routing_Type__c != null
                              || leadNew.Do_Not_Route__c != true && leadNew.Do_Not_Route__c == true;
            
            if (isRoutable == false)
                continue;
            
            Dom.XmlNode xml = doc.getRootElement().addChildElement('lead', null, null);
            xml.setAttribute('id', leadNew.Id);
        }
        
        if (doc.getRootElement().getChildElements().size() == 0)
            return;
        
        rC_Core__Message__c message = new rC_Core__Message__c();
        message.rC_Core__Endpoint__c = 'queue://Lead_RouteByRecruitingServicer';
        message.rC_Core__Data__c = doc.toXmlString();
        insert message;
    }
    
    public void execute(Boolean isInsert) {
        if (RoutingAnalysis.getSetting().Is_Disabled__c == true)
            return;
        if (RoutingAnalysis.getSetting().Is_Disabled_On_Insert__c == true && isInsert == true)
            return;
        if (RoutingAnalysis.getSetting().Is_Disabled_On_Update__c == true && isInsert == false)
            return;
        if (leadNewList == null || leadNewList.size() == 0)
            return;
        
        Lead[] routingByPostalCodeList = new Lead[] {};
        Lead[] routingByProximityList = new Lead[] {};
        Lead[] routingByRecruitingList = new Lead[] {};
        
        for(Lead leadNew : leadNewList) {
            if (leadNew == null)
                continue;
            if (leadNew.Apply_Routing_Type__c == null)
                continue;
            if (RoutingAnalysis.RoutingTypePostalCode.equalsIgnoreCase(leadNew.Apply_Routing_Type__c))
                routingByPostalCodeList.add(leadNew);
            if (RoutingAnalysis.RoutingTypeProximity.equalsIgnoreCase(leadNew.Apply_Routing_Type__c))
                routingByProximityList.add(leadNew);
            if (RoutingAnalysis.RoutingTypeRecruiting.equalsIgnoreCase(leadNew.Apply_Routing_Type__c))
                routingByRecruitingList.add(leadNew);
        }
        
        system.debug('routingByPostalCodeList = ' + routingByPostalCodeList);
        system.debug('routingByProximityList = ' + routingByProximityList);
        system.debug('routingByRecruitingList = ' + routingByRecruitingList);
        
        // For inserted records, we actually have to update this async.
        if (isInsert == true && routingByPostalCodeList.size() != 0)
            executeFuture(new Map<Id, Lead>(routingByPostalCodeList).keySet());
        if (isInsert == true && routingByProximityList.size() != 0)
            executeFuture(new Map<Id, Lead>(routingByProximityList).keySet());
        if (isInsert == true && routingByRecruitingList.size() != 0)
            executeFuture(new Map<Id, Lead>(routingByRecruitingList).keySet());
        
        // Updates (or async post-inserts) get executed now.
        if (isInsert == false && routingByPostalCodeList.size() != 0)
            Lead_RouteByPostalCode.applyRouting(routingByPostalCodeList);
        if (isInsert == false && routingByProximityList.size() != 0)
            Lead_RouteByProximity.applyRouting(routingByProximityList);
        if (isInsert == false && routingByRecruitingList.size() != 0)
            Lead_RouteByRecruiting.applyRouting(routingByRecruitingList);
    }
 }