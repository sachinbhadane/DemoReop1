/***************************************************************************************
Trigger Name    : Contact_syncStartTerm
Author          : Mahesh Gaddam
Created Date    : November 27, 2011
Usage           : This trigger updates Start_Term__c field on Opportunities when the Start_Term__c is updated on Contact.                  
Revision History: 
****************************************************************************************/
trigger Contact_syncStartTerm on Contact (after update) {
    new Contact_syncStartTerm(trigger.old, trigger.new).execute();
}