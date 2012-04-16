/***************************************************************************************
Trigger Name     : Lead_ConvertNow
Author           : Mahesh Gaddam
Created Date     : November 15, 2011
Usage            : This triggers is on Lead Object on After Insert, After Update.                
Revision History :                 
****************************************************************************************/
trigger Lead_ConvertNew on Lead (after insert,after update)
{
    new Lead_ConvertNew(trigger.old, trigger.new).execute();
}