/***************************************************************************************
Trigger  Name   : Contact_UpdateOpportunities
Author          : Mahesh Gaddam
Created Date    : November 28, 2011
Usage           : This trigger updates Owner field in Opportunity when Owner field on Contact is updated  .   
Note            : Above trigger is commented as below trigger tries to sync this trigger with Opportunity_syncOwner trigger.              
Revision History: 
****************************************************************************************/

trigger Contact_UpdateOpportunities on Contact (after update)
{
    System.debug(':::Contact_UpdateOpportunities::Trigger:: Start===>'+Contact_UpdateOpportunities.hasContactTriggerCalled() );
     if (!Contact_UpdateOpportunities.hasContactTriggerCalled())
       {
          new Contact_UpdateOpportunities(trigger.old, trigger.new).execute();
       }
         System.debug(':::Contact_UpdateOpportunities::Trigger:: END===>' );
}