/***************************************************************************************
Trigger Name    : Opportunity_syncStartTerm
Author          : Mahesh Gaddam
Created Date    : November 27, 2011
Usage           : This trigger updates Start_Term__c field on Contact when the Start_Term__c is updated on Opportunity.                  
Revision History: 
****************************************************************************************/
trigger Opportunity_syncStartTerm on Opportunity (after insert, after update) {
    new Opportunity_syncStartTerm(trigger.old, trigger.new).execute();
}