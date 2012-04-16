<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Education_Set_Verified_Date_to_Blank</fullName>
        <field>Verified_Date__c</field>
        <name>Education:Set Verified Date to Blank</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Education_Set_Verified_Date_to_Today</fullName>
        <field>Verified_Date__c</field>
        <formula>TODAY()</formula>
        <name>Education:Set Verified Date to Today</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Education_Update_Summary</fullName>
        <field>Summary__c</field>
        <formula>IF(ISBLANK(Account__c), Account_Override__c, Account__r.Name) + &apos; (&apos; + IF(ISBLANK(Start_Date__c), &apos;?&apos;, Start_Year__c) + &apos; - &apos; + IF(ISBLANK(End_Date__c), &apos;?&apos;, End_Year__c) + &apos;)&apos;</formula>
        <name>Education:Update Summary</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Set Verified Date to Blank%3AEducation</fullName>
        <actions>
            <name>Education_Set_Verified_Date_to_Blank</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Education__c.Verified__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Set Verified Date to Today%3AEducation</fullName>
        <actions>
            <name>Education_Set_Verified_Date_to_Today</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Education__c.Verified__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Summary%3AEducation</fullName>
        <actions>
            <name>Education_Update_Summary</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>True</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
