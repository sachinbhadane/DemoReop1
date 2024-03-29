<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Requirement_SetApprovedDateToBlank</fullName>
        <field>Approved_Date__c</field>
        <name>Requirement_SetApprovedDateToBlank</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Requirement_SetApprovedDateToToday</fullName>
        <field>Approved_Date__c</field>
        <formula>TODAY()</formula>
        <name>Requirement_SetApprovedDateToToday</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Requirement_SetIdentifierUnique</fullName>
        <field>Identifier_Unique__c</field>
        <formula>BLANKVALUE(RecordTypeId, &apos;&apos;) + &apos;:&apos; +
BLANKVALUE(Parent__r.Country__c, &apos;&apos;) + &apos;:&apos; +
BLANKVALUE(Parent__r.Department__c, &apos;&apos;) + &apos;:&apos; +
BLANKVALUE(Parent__r.Program__c, &apos;&apos;) + &apos;:&apos; +
BLANKVALUE(Opportunity__c, &apos;&apos;) + &apos;:&apos; +
BLANKVALUE(Name, &apos;&apos;)</formula>
        <name>Requirement_SetIdentifierUnique</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Requirement_SetSuppliedDateToBlank</fullName>
        <field>Supplied_Date__c</field>
        <name>Requirement_SetSuppliedDateToBlank</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Requirement_SetSuppliedDateToToday</fullName>
        <field>Supplied_Date__c</field>
        <formula>TODAY()</formula>
        <name>Requirement_SetSuppliedDateToToday</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Requirement_SetUnlockedDateToBlank</fullName>
        <field>Unlocked_Date__c</field>
        <name>Requirement_SetUnlockedDateToBlank</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Requirement_SetUnlockedDateToToday</fullName>
        <field>Unlocked_Date__c</field>
        <formula>TODAY()</formula>
        <name>Requirement_SetUnlockedDateToToday</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Requirement_SetVerifiedDateToBlank</fullName>
        <field>Verified_Date__c</field>
        <name>Requirement_SetVerifiedDateToBlank</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Requirement_SetVerifiedDateToToday</fullName>
        <field>Verified_Date__c</field>
        <formula>TODAY()</formula>
        <name>Requirement_SetVerifiedDateToToday</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Requirement_SetWaivedDateToBlank</fullName>
        <field>Waived_Date__c</field>
        <name>Requirement_SetWaivedDateToBlank</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Requirement_SetWaivedDateToToday</fullName>
        <field>Waived_Date__c</field>
        <formula>TODAY()</formula>
        <name>Requirement_SetWaivedDateToToday</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Set Approved Date%3A To Blank</fullName>
        <actions>
            <name>Requirement_SetApprovedDateToBlank</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Requirement__c.Approved__c</field>
            <operation>notEqual</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Approved Date%3A To Today</fullName>
        <actions>
            <name>Requirement_SetApprovedDateToToday</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Requirement__c.Approved__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Identifier %28Unique%29</fullName>
        <actions>
            <name>Requirement_SetIdentifierUnique</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>NOT(ISBLANK(Opportunity__c)) &amp;&amp; NOT(ISBLANK(Parent__c))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Set Supplied Date%3A To Blank</fullName>
        <actions>
            <name>Requirement_SetSuppliedDateToBlank</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Requirement__c.Supplied__c</field>
            <operation>notEqual</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Supplied Date%3A To Today</fullName>
        <actions>
            <name>Requirement_SetSuppliedDateToToday</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Requirement__c.Supplied__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Unlocked Date%3A To Blank</fullName>
        <actions>
            <name>Requirement_SetUnlockedDateToBlank</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Requirement__c.Unlocked__c</field>
            <operation>notEqual</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Unlocked Date%3A To Today</fullName>
        <actions>
            <name>Requirement_SetUnlockedDateToToday</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Requirement__c.Unlocked__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Verified Date%3A To Blank</fullName>
        <actions>
            <name>Requirement_SetVerifiedDateToBlank</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Requirement__c.Verified__c</field>
            <operation>notEqual</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Verified Date%3A To Today</fullName>
        <actions>
            <name>Requirement_SetVerifiedDateToToday</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Requirement__c.Verified__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Waived Date%3A To Blank</fullName>
        <actions>
            <name>Requirement_SetWaivedDateToBlank</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Requirement__c.Waived__c</field>
            <operation>notEqual</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Waived Date%3A To Today</fullName>
        <actions>
            <name>Requirement_SetWaivedDateToToday</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Requirement__c.Waived__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
