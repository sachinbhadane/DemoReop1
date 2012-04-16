<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>EMPLOYMENT_Set_Verified_Date_to_Blank</fullName>
        <field>Verified_Date__c</field>
        <name>EMPLOYMENT:Set Verified Date to Blank</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Employment_Set_Summary</fullName>
        <field>Summary__c</field>
        <formula>IF(ISBLANK(Account__c), Account_Override__c, Account__r.Name) + &apos; (&apos; + IF(ISBLANK(Start_Date__c), &apos;?&apos;, Start_Year__c) + &apos; - &apos; + IF(ISBLANK(End_Date__c), &apos;?&apos;, End_Year__c) + &apos;)&apos;</formula>
        <name>Employment:Set Summary</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Employment_Set_Verified_Date_to_Today</fullName>
        <field>Verified_Date__c</field>
        <formula>TODAY()</formula>
        <name>Employment:Set Verified Date to Today</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Set Verified Date to Blank%3AEMPLOYMENT</fullName>
        <actions>
            <name>EMPLOYMENT_Set_Verified_Date_to_Blank</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Employment__c.Verified__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Verified Date to Today%3AEmployment</fullName>
        <actions>
            <name>Employment_Set_Verified_Date_to_Today</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Employment__c.Verified__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Summary%3AEmployment</fullName>
        <actions>
            <name>Employment_Set_Summary</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
