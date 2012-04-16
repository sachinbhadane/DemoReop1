<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>EXAM_Set_Verified_Date_to_Blank</fullName>
        <field>Verified_Date__c</field>
        <name>EXAM:Set Verified Date to Blank</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Exam_Set_Verified_Date_to_Today</fullName>
        <field>Exam_Date__c</field>
        <formula>TODAY()</formula>
        <name>Exam:Set Verified Date to Today</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Exam_Set_Verified_Date_to_Today2</fullName>
        <field>Verified_Date__c</field>
        <formula>TODAY()</formula>
        <name>Exam:Set Verified Date to Today2</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Set Verified Date to Blank%3AExam</fullName>
        <actions>
            <name>EXAM_Set_Verified_Date_to_Blank</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Exam__c.Verified__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Verified Date to Today%3AExam</fullName>
        <actions>
            <name>Exam_Set_Verified_Date_to_Today2</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Exam__c.Verified__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
