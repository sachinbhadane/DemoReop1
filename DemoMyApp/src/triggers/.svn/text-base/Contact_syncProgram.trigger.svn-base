/***************************************************************************************
Trigger Name    : Contact_syncProgram
Author          : Mahesh Gaddam
Created Date    : November 20, 2011
Usage           : This trigger updates Program__c field on Opportunities when the Primary_Program__c is updated on Contact.                 
Revision History: 
****************************************************************************************/
trigger Contact_syncProgram on Contact (after insert, after update) {
    new Contact_syncProgram(trigger.old, trigger.new).execute();
}