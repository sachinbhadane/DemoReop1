<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Event_Set_Record_Type_to_Applicant</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Applicant_Interview_Event_Record_Type</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Event:Set Record Type to Applicant</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Set Event Record Type to Application</fullName>
        <actions>
            <name>Event_Set_Record_Type_to_Applicant</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>!BEGINS(WhoId,  &quot;00QU00&quot;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
