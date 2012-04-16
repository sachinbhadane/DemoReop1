public without sharing class Contact_UpdateOpportunities extends ContactTrigger {
	public static boolean contactTriggerCalled = false;  // Static variable for sync ; OW-Owner, Included by Mahesh to make this trigger bisync with Opportunity_syncOwner trigger. 11/28/2011
    public Contact_UpdateOpportunities(Contact[] contactOldList, Contact[] contactNewList) {
        super(contactOldList, contactNewList);
    }
    
    public virtual override void execute() {
    	System.debug('::Contact_UpdateOpportunties::execute::Start::===>');
        // Sanity check: this has to be done from an update trigger context only, because we need to know
        // that the trigger.oldMap contains valid prior Contact records. The isAfter requirement is needed
        // because the routing engine operates on the before update side, so by the time the code path gets
        // to here, the correct contact CwnerId would have already been set.
        system.assert(trigger.isUpdate && trigger.isAfter, 'Must be executed from an after update trigger only');
        // System.debug(':::Contact_UpdateOpportunities::execute::End');
        // This set will keep track of all of the contacts that actually changed OwnerId
        Set<Id> contactChangedIds = new Set<Id> {};
        
        // For each contact in this trigger batch, compare the old OwnerId with the new OwnerId and
        for(Contact contactNew : contactNewList) {
            Contact contactOld = contactOld(contactNew.Id);
            system.assert(null != contactNew, 'Internal error: contactNew is null');
            system.assert(null != contactOld, 'Internal error: contactOld is null');
            
            if (contactNew.OwnerId == contactOld.OwnerId || contactNew.OwnerId != contactOld.OwnerId )
            {
            	// Whether owner has changed or not, contactChangedIds should be added with Newcontact 
                // becuase the routing by recruiting was not updating the opportunity owner when
                // there was a mismatch on opp owner and contact owner was correct as per routing.
	            contactChangedIds.add(contactNew.Id);
	            System.debug('::Contact_UpdateOpportunties::execute:: 1===>' +contactChangedIds.size()); 
	            System.debug('::Contact_UpdateOpportunties::execute:: 2===>' +contactChangedIds); 
            }
            
            /*
            	Code Change : Niket
            	Summary     : If contact accountId is get changed then all the opportunities respective with contact
            					will have same AccountId.
            */
            if(contactNew.AccountId != contactOld.AccountId){
            	contactChangedIds.add(contactNew.Id);
            }
        }
        
         // This list will hold the opportunities that have been update with new OwnerId values.
        Opportunity[] opportunityUpdateList = new Opportunity[] {};
        
        // Find all of the opps associated with those changed contact records (using the Contact__c custom field)
        Opportunity[] opportunityList = [
            select OwnerId
                 , Contact__c
                 , AccountId
              from Opportunity
             where Contact__c in :contactChangedIds
        ];
        
           
         // Now, for each opp, use the Contact__c field to lookup the original contact record from the
        // trigger data, and copy the correct OwnerId value from the contact over to the opp.
        Map<Id, Contact> contactNewMap = new Map<Id, Contact>(contactNewList);
        
        for(Opportunity opportunity : opportunityList) 
        {
            Contact contactNew = contactNewMap.get(opportunity.Contact__c);
            
            system.assert(null != contactNew, 'Internal error: contactNew is null on the opportunity 2nd pass');
            
            // Again whether the opportuntiy owner is same or different than contactNew, adding it to the list to be updated.
            if (opportunity.OwnerId == contactNew.OwnerId || opportunity.OwnerId != contactNew.OwnerId)
               //continue;
            opportunity.OwnerId = contactNew.OwnerId;
            /*
            	Code Change : Niket
            	Summary     : Updating the accountId of the opportunity as per 
            				  the contact.
            */
            opportunity.AccountId = contactNew.AccountId;
             
            opportunityUpdateList.add(opportunity);
            
           // System.debug(':::Contact_UpdateOpportunities::execute::End'); // Included by G.Mahesh for testing of bidirectionalsync,11/28/2011
            System.debug('::Contact_UpdateOpportunties::execute::opp-for loop 3===>');
        }
        
        // No opportunities updated? Maybe some contacts don't have opps, or the opp was already owned by the
        // right person. In any case, if the update list is empty, there is nothing to do.
        system.debug('**************************** opportunityUpdateList:'+opportunityUpdateList);
        if (opportunityUpdateList.size() == 0)
            return;
        Contact_UpdateOpportunities.setContactTriggerCalled();  
        update opportunityUpdateList;
    }
    
    public static boolean hasContactTriggerCalled(){
    	return contactTriggerCalled;
    }
    
    public static void setContactTriggerCalled(){
    	contactTriggerCalled = true;
    }
}