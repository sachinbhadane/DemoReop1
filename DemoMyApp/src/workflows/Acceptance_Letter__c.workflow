<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>ACCEPTANCE_LETTER_Set_Date_To_Today</fullName>
        <field>Date_Letter_Sent_Attached__c</field>
        <formula>TODAY()</formula>
        <name>ACCEPTANCE LETTER:Set Date To Today</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Acceptance_Letter_Set_Acceptance_Letter</fullName>
        <field>Acceptance_Letter__c</field>
        <formula>Application__r.Contact__r.FirstName  + &quot; &quot; + Application__r.Contact__r.LastName</formula>
        <name>Acceptance Letter: Set Acceptance Letter</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>acceptance_letter_add_title</fullName>
        <field>Acceptance_Letter__c</field>
        <name>acceptance letter: add title</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Set Date Sent%2FAttached</fullName>
        <actions>
            <name>ACCEPTANCE_LETTER_Set_Date_To_Today</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Acceptance_Letter__c.CreatedDate</field>
            <operation>equals</operation>
            <value>TODAY</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Name on Acceptance Letter</fullName>
        <actions>
            <name>Acceptance_Letter_Set_Acceptance_Letter</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>acceptance_letter_add_title</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Acceptance_Letter__c.CreatedDate</field>
            <operation>equals</operation>
            <value>TODAY</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
