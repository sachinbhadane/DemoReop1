/***************************************************************************************
Trigger Name     : Lead_EmailDuplicatepreventer 
Author           : Mahesh Gaddam
Created Date     : January 09, 2012
Usage            : This triggers is on Lead on Before Insert& Before Update. 
                 : This trigger prevents user from creating duplicate email ids for email ids already existing in Contact.               
Revision History :                 
****************************************************************************************/
trigger Lead_EmailDuplicatepreventer on Lead (before insert, before update)
{
    new Lead_EmailDuplicatepreventer (trigger.old, trigger.new).execute();
}