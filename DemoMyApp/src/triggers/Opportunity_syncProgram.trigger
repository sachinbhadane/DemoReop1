/***************************************************************************************
Trigger Name    : Opportunity_syncProgram
Author          : Mahesh Gaddam
Created Date    : November 21, 2011
Usage           : This trigger updates Primary_Program__c field in Contact when Program__c field on Opportunities is updated
                  or inserted .
Revision History: 
****************************************************************************************/
trigger Opportunity_syncProgram on Opportunity (after insert, after update) {
    new Opportunity_syncProgram(trigger.old, trigger.new).execute();
}