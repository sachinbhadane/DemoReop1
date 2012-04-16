public without sharing class RouteTestController 
{
	public RouteTestController()
	{
		String StrID = ApexPages.currentPage().getParameters().get('id');
		List<Contact> contactNewList = [select Name
                 , Age_Range__c
                 , Apply_Routing_Type__c
                 , Department_Name_Primary__c
                 , Department_Name_Secondary__c
                 , Department_Name_Third__c
                 , Country_Of_Residence_Name__c
                 , Country_Of_Residence__c
                 , Do_Not_Route__c
                 , MailingPostalCode
                 , MailingCity
                 , MailingCountry
                 , MailingState
                 , OwnerId
                 , OtherPostalCode
                 , OtherCity
                 , OtherCountry
                 , OtherState
                 , Program_Primary__c
                 , Program_Secondary__c
                 , Program_Third__c
                 , Region__c
                 , Sub_Region__c
                 , Work_Load__c
              from Contact
             where Id =: StrID
            
       /*     List<Lead> contactNewList = [select Name
                 , Age_Range__c
                 , Apply_Routing_Type__c
                 , Department_Name_Primary__c
                 , Department_Name_Secondary__c
                 , Department_Name_Third__c
                 , Country_Of_Residence_Name__c
                 , Country_Of_Residence__c
                 , Do_Not_Route__c
                 , OwnerId
              	,Status
              	,State
              	,LeadSource
                 , Program_Primary__c
                 , Program_Secondary__c
                 , Program_Third__c
                 , Region__c
                 , Sub_Region__c
                 , Work_Load__c
              from Lead
             where Id =: StrID
             */
            
        ];
		//Lead_RouteByRecruiting.applyRouting(contactNewList);
		Contact_RouteByRecruiting.applyRouting(contactNewList);
	}
}