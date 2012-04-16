<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Calculated_Single_Annual_Fee_Shanghai</fullName>
        <field>Single_Annual__c</field>
        <formula>Single_Monthly_Fee_Shanghai_Only__c  *  Number_of_Months_Shanghai_Only__c</formula>
        <name>Calculated Single Annual Fee:Shanghai</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Set Annual Shanghai Accommodation Fee</fullName>
        <actions>
            <name>Calculated_Single_Annual_Fee_Shanghai</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Program__c.CurrencyIsoCode</field>
            <operation>contains</operation>
            <value>CNY</value>
        </criteriaItems>
        <description>Calculates the Annual Accomodation Fee for a shared double in Shanghai</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
