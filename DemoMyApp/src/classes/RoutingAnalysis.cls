public with sharing class RoutingAnalysis { 
    public final static String RoutingTypeGeocodedProximity = 'Geocoded Proximity';
    public final static String RoutingTypeGeocodedProximityPending = 'Geocoded Proximity (Pending)';
    public final static String RoutingTypePostalCode = 'Zip/Postal Code';
    public final static String RoutingTypeProximity = 'Proximity';
    public final static String RoutingTypeRecruiting = 'Recruiting';
    
    public final static String RoutedByDepartmentName = 'Department Name';
    public final static String RoutedByDepartmentId = 'Department ID';
    public final static String RoutedByQueueName = 'Queue Name';
    public final static String RoutedByQueueId = 'Queue ID';
    public final static String RoutedByUserName = 'User Name';
    public final static String RoutedByUserId = 'User ID';
    
    public final static Schema.DescribeSObjectResult DescribeResult = Routing_Table__c.sObjectType.getDescribe();
    public final static Map<String, Schema.RecordTypeInfo> RecordTypeMap = DescribeResult.getRecordTypeInfosByName();
    public final static Id RecordTypePostalCode = RecordTypeMap.get(RoutingTypePostalCode).getRecordTypeId();
    public final static Id RecordTypeProximity = RecordTypeMap.get(RoutingTypeProximity).getRecordTypeId();
    public final static Id RecordTypeRecruiting = RecordTypeMap.get(RoutingTypeRecruiting).getRecordTypeId();
    
    public final static Map<String, String> postalCodeMap = new Map<String, String>();
    public final static Set<String> canadianLetters = new Set<String> {
        'A', // NL
        'B', // NS
        'C', // PE
        'E', // NB
        'G', 'H', 'J', // QC
        'K', 'L', 'M', 'N', 'P', // ON
        'R', // MB
        'S', // SK
        'T', // AB
        'V', // BC
        'X', // NU/NT
        'Y' // YT
    };
    
    public final static Decimal PI_180 = 3.14159265 / 180;
    public final static Decimal RADIUS  = 6366.71;
    public static Setting__c setting;
    
    // Internal classes
    public class RoutingException extends Exception {}
    public class RoutingProximity {
        public Decimal distance { set; get; }
        public Routing_Table__c routing { set; get; }
    }
    
    // Instance vars
    public String routingObjectType { set; get; }
    public String routingType { set; get; }
    public Routing_Table__c[] routingList { set; get; }
    public RoutingProximity[] proximityList { set; get; }
    public Lead lead { set; get; }
    public Contact contact { set; get; }
    
    public RoutingAnalysis() {}
    
    public PageReference initialize() {
        routingObjectType = ApexPages.currentPage().getParameters().get('objectType');
        routingType = RoutingTypeRecruiting;
        routingList = new Routing_Table__c[] {};
        proximityList = new RoutingProximity[] {};
        
        // Always blank init the objects
        lead = new Lead();
        contact = new Contact();
        
        // Are we routing from a blank page, or importing a lead?
        String recordId = ApexPages.currentPage().getParameters().get('recordId');
        
        if (routingObjectType == null || routingObjectType == '')
            routingObjectType = 'Lead';
        
        if (getIsLead() && recordId != null && recordId != '')
            initializeLeadFromRecordId(recordId);
        else if (getIsContact() && recordId != null && recordId != '')
            initializeContactFromRecordId(recordId);
        return lead.Id == null && contact.Id == null ? null : analyze();
    }
    
    void initializeLeadFromRecordId(String recordId) {
        lead = [
            select State
                 , City
                 , Department_Name_Primary__c 
                 , Department_Name_Secondary__c 
                 , Department_Name_Third__c 
                 , Program_Primary__c
                 , Program_Secondary__c
                 , Program_Third__c
                 , Country_of_Residence__c
                 , Country_of_Residence_Name__c
                 , Age_Range__c
                 , Work_Load__c
                 , LeadSource
                 , Status
              from Lead
             where Id = :recordId
             limit 1
        ];
    }
    
    void initializeContactFromRecordId(String recordId) {
        contact = [
            select MailingState
                 , MailingCity
                 , Department_Name_Primary__c 
                 , Department_Name_Secondary__c 
                 , Department_Name_Third__c 
                 , Program_Primary__c
                 , Program_Secondary__c
                 , Program_Third__c
                 , Country_of_Residence__c
                 , Country_of_Residence_Name__c
                 , Age_Range__c
                 , Work_Load__c
              from Contact
             where Id = :recordId
             limit 1
        ];
    }
    
    public PageReference analyze() {
        if (getIsPostalCode())
            return analyzeByPostalCode();
        if (getIsProximity())
            return analyzeByProximity();
        if (getIsRecruiting())
            return analyzeByRecruiting();
        return null;
    }
    
    public PageReference analyzeByPostalCode() {
        routingList = Lead_RouteByPostalCode.getRoutingTableList(new Lead[] { lead });
        return null;
    }
    
    public PageReference analyzeByProximity() {
        routingList = Lead_RouteByProximity.getRoutingTableList(new Lead[] { lead });
        proximityList = Lead_RouteByProximity.getSortedRoutingTableList(lead, routingList);
        return null;
    }
    
    public PageReference analyzeByRecruiting() {
        if (getIsContact())
            routingList = Contact_RouteByRecruiting.getRoutingTableList(new Contact[] { contact });
        else if (getIsLead())
            {
            	routingList = Lead_RouteByRecruiting.getRoutingTableList(new Lead[] { lead });
            	System.debug('routingList =================>'+routingList);
            }
        else
            routingList = new Routing_Table__c[] {};
        return null;
    }
    
    public Integer getRoutingTotalCount() {
        return [select COUNT() from Routing_Table__c];
    }

    public Integer getRoutingTotalActiveCount() {
        return [select COUNT() from Routing_Table__c where Is_Active__c = true];
    }
    
    public Integer getRoutingCountLeadSourceOnly() {
        return [select COUNT() from Routing_Table__c where Lead_Source__c in (null, :lead.LeadSource)];
    }

    public Integer getRoutingCountLeadStatusOnly() {
        return [select COUNT() from Routing_Table__c where Lead_Status__c in (null, :lead.Status)];
    }
    
    public Boolean getIsPostalCode() {
        return RoutingTypePostalCode.equalsIgnoreCase(routingType);
    }

    public Boolean getIsProximity() {
        return RoutingTypeProximity.equalsIgnoreCase(routingType);
    }

    public Boolean getIsRecruiting() {
        return RoutingTypeRecruiting.equalsIgnoreCase(routingType);
    }
    
    public Boolean getIsContact() {
        return 'Contact'.equalsIgnoreCase(routingObjectType);
    }
    
    public Boolean getIsLead() {
        return 'Lead'.equalsIgnoreCase(routingObjectType);
    }
    
    // Static helper functions
    
    public static Setting__c getSetting() {
        if (setting == null)
            setting = Setting__c.getInstance();
        if (setting == null)
            setting = new Setting__c();
        return setting;
    }
    
    public static String getStandardizedPostalCode(String postalCode, String countryCode) {
        if (setting.Is_Strict__c == true)
            return postalCode;
        if (postalCode == null)
            return postalCode;
        if (postalCodeMap.containsKey(postalCode))
            return postalCodeMap.get(postalCode);
        
        postalCode = postalCode.toUpperCase();
        postalCode = postalCode.replaceAll('[^0-9A-Z]', '');
        
        if (postalCode == null || postalCode.length() == 0)
            postalCodeMap.put(postalCode, null);
        else if ('US'.equalsIgnoreCase(countryCode))
            postalCodeMap.put(postalCode, getStandardizedPostalCodeForUS(postalCode));
        else if ('CA'.equalsIgnoreCase(countryCode))
            postalCodeMap.put(postalCode, getStandardizedPostalCodeForCA(postalCode));
        else if ('MX'.equalsIgnoreCase(countryCode))
            postalCodeMap.put(postalCode, getStandardizedPostalCodeForMX(postalCode));
        else if (canadianLetters.contains(postalCode.substring(0, 1)))
            postalCodeMap.put(postalCode, getStandardizedPostalCodeForCA(postalCode));
        else // default to US
            postalCodeMap.put(postalCode, getStandardizedPostalCodeForUS(postalCode));
        return postalCodeMap.get(postalCode);
    }
    
    public static String getStandardizedPostalCodeForUS(String postalCode) {
        if (postalCode.length() == 1)
            postalCode = '0000' + postalCode;
        else if (postalCode.length() == 2)
            postalCode = '000' + postalCode;
        else if (postalCode.length() == 3)
            postalCode = '00' + postalCode;
        else if (postalCode.length() == 4)
            postalCode = '0' + postalCode;
        else if (postalCode.length() >= 6)
            postalCode = postalCode.substring(0, 5);
        return postalCode;
    }
    
    public static String getStandardizedPostalCodeForCA(String postalCode) {
        if (postalCode.length() != 6)
            return postalCode;
        return postalCode.substring(0, 3) + ' ' + postalCode.substring(3, 6);
    }
    
    public static String getStandardizedPostalCodeForMX(String postalCode) {
        return postalCode;
    }
    
    public static Map<String, Id> getRoutingQueueMap(Routing_Table__c[] routingList) {
        Map<String, Id> routingQueueMap = new Map<String, Id>();
        
        for(Routing_Table__c routing : routingList) {
            if (RoutedByQueueName.equalsIgnoreCase(routing.Routed_By__c))
                routingQueueMap.put(routing.Routed_To__c, null);
        }
        
        for(QueueSobject queueSobject : [
            select Queue.Name
              from QueueSobject
             where Queue.Name in :routingQueueMap.keySet()
               and SobjectType = 'Lead' 
        ]) routingQueueMap.put(queueSobject.Queue.Name, queueSobject.Queue.Id);
        
        return routingQueueMap;
    }
    
    public static Map<String, Id> getRoutingUserMap(Routing_Table__c[] routingList) {
        Map<String, Id> routingUserMap = new Map<String, Id>();
        
        for(Routing_Table__c routing : routingList) {
            if (RoutedByUserName.equalsIgnoreCase(routing.Routed_By__c))
                routingUserMap.put(routing.Routed_To__c, null);
        }
        
        for(User user : [
            select Username
              from User
             where Username in :routingUserMap.keySet()
               and IsActive = true
        ]) routingUserMap.put(user.Username, user.Id);
        
        return routingUserMap;
    }
}