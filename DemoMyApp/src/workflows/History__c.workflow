<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>History_SetVerifiedDateToBlank</fullName>
        <field>Verified_Date__c</field>
        <name>History_SetVerifiedDateToBlank</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>History_SetVerifiedDateToToday</fullName>
        <field>Verified_Date__c</field>
        <formula>TODAY()</formula>
        <name>History_SetVerifiedDateToToday</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>History_UpdateSummaryOnEducation</fullName>
        <field>Summary__c</field>
        <formula>IF(ISBLANK(Account__c), Account_Override__c, Account__r.Name) + &apos; (&apos; + IF(ISBLANK(Start_Date__c), &apos;?&apos;, Start_Year__c) + &apos; - &apos; + IF(ISBLANK(End_Date__c), &apos;?&apos;, End_Year__c) + &apos;)&apos;</formula>
        <name>History_UpdateSummaryOnEducation</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>History_UpdateSummaryOnEmployment</fullName>
        <field>Summary__c</field>
        <formula>IF(ISBLANK(Account__c), Account_Override__c, Account__r.Name) + &apos; (&apos; + IF(ISBLANK(Start_Date__c), &apos;?&apos;, Start_Year__c) + &apos; - &apos; + IF(ISBLANK(End_Date__c), &apos;?&apos;, End_Year__c) + &apos;)&apos;</formula>
        <name>History_UpdateSummaryOnEmployment</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
</Workflow>
