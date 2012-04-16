global virtual without sharing class Lead_ConvertApplicantServicer implements rC_Core.MessageServicer.Servicer {
    public static final String QUEUE_NAME = 'queue://Lead_ConvertApplicantServicer';
    
    global virtual void processMessage(rC_Core__Message__c message, Dom.Document payload) {
        if (QUEUE_NAME.equalsIgnoreCase(message.rC_Core__Endpoint__c) == false)
            return;
        
        // Find the lead ID
        String leadId = payload.getRootElement().getAttribute('id', null);
        
        // Test check the lead
        Lead[] leadPrecheckList = [
            select IsConverted
              from Lead
             where Id = :leadId // properly handles the leadId = null also.
             limit 1
        ];
        
        System.debug(':::::: Lead_ConvertApplicantServicer :: leadPrecheckList ===>' + leadPrecheckList);
        
        // Only process the lead if (a) was found, and (b) isn't yet coverted.
        // Otherwise just skip and mark the message as processed.
        try {
            if (leadPrecheckList.size() != 0 && leadPrecheckList[0].IsConverted != true) {
                System.debug(':::::: Lead_ConvertApplicantServicer :: 1 ===>' );
                Lead_ConvertApplicant_new converter = new Lead_ConvertApplicant_new();
                converter.id = payload.getRootElement().getAttribute('id', null);
                System.debug(':::::: Lead_ConvertApplicantServicer :: 2 ===>' + converter.id);
                converter.convert();
            } else {
                System.debug(':::::: Lead_ConvertApplicantServicer :: precheck failed; lead not found or already converted. Skipping..');
            }
        } catch (Lead_ConvertApplicant_new.ConversionException pException) {
            if (pException.getMessage().contains('Email already in contact') == false)
                throw pException;
            
            // The lead is a duplicate. Update the lead status and fall through so the message is completed.
            Lead lead = new Lead(Id = payload.getRootElement().getAttribute('id', null));
            lead.Status = 'Duplicate';
            update lead; 
        }
        
        System.debug(':::::: Lead_ConvertApplicantServicer :: no exceptions so far');
        
        // If we got here with no exceptions, then mark the message as processed
        message.rC_Core__Processed_Date__c = DateTime.now();
        message.rC_Core__Deletable_Date__c = DateTime.now().addMinutes(message.rC_Core__Deletable_Cache_Time__c.intValue());
    }
}

/***************************************************************************************
Author          : Mahesh Gaddam
Created Date    : November 17, 2011      
Usage           : This class sends the Lead id's to Lead_ConvertApplicant_new for lead conversion        
Note            : 
Revision History: 
****************************************************************************************/   
/* 
global virtual without sharing class Lead_ConvertApplicantServicer implements rC_Core.MessageServicer.Servicer
 {
    public static final String QUEUE_NAME = 'queue://Lead_ConvertApplicantServicer';
    
    // Method to get the messages and covert the lead based on the lead id from the message.
    global virtual void processMessage(rC_Core__Message__c message, Dom.Document payload)
     {
        
        if (QUEUE_NAME.equalsIgnoreCase(message.rC_Core__Endpoint__c) == false)
            return;
     	
     	 // Get the lead id from the message
     	id leadId;
	    leadId = payload.getRootElement().getAttribute('id', null);
        System.debug(':::::: Lead_ConvertApplicationServicer :: 1 ===>' +leadId);
            
        // Get the required/additional fields of Lead basesd on lead id's     
    	
    	//Lead leadToConvert = [select 
          			 			//from Lead where Id = :leadId ];
          			 			
		Lead[] leadToConvert  = [select Program_Primary__r.Name from Lead where Id =:leadId];
		System.debug(':::::: Lead_ConvertApplicationServicer :: 2 ===>' +leadToConvert);
		if (leadToConvert.size() > 0)
		{
		 //Account a = lstAccount.get(0);
		Lead_ConvertApplicant_new converter = new Lead_ConvertApplicant_new();
        converter.id = leadId ;
        //converter.Lead = leadToConvert;
        converter.convert();
		}

   		 //System.debug(':::::: Lead_ConvertApplicationServicer :: 2 ===>' +leadToConvert);
   		// convert the leads
     }
 }*/