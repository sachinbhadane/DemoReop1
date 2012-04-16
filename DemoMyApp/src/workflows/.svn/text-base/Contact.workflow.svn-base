<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Applicant_Copy_Email_to_Applicant_Email</fullName>
        <field>Applicant_Email__c</field>
        <formula>Email</formula>
        <name>Applicant:Copy Email to Applicant Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Applicant_Set_Start_Date_2014</fullName>
        <field>Start_Term__c</field>
        <literalValue>September 2014</literalValue>
        <name>Applicant:Set Start Date 2014</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Applicant_Set_Start_Term_2011</fullName>
        <field>Start_Term__c</field>
        <literalValue>September 2011</literalValue>
        <name>Applicant:Set Start Term 2011</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Applicant_Set_Start_Term_2012</fullName>
        <field>Start_Term__c</field>
        <literalValue>September 2012</literalValue>
        <name>Applicant:Set Start Term 2012</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Applicant_Set_Start_Term_2013</fullName>
        <field>Start_Term__c</field>
        <literalValue>September 2013</literalValue>
        <name>Applicant:Set Start Term 2013</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Contact_Copy_Email_to_Applicant_Email</fullName>
        <description>Copy email address to Applicant Email Address if blank</description>
        <field>Applicant_Email__c</field>
        <formula>Email</formula>
        <name>Contact:Copy Email to Applicant Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Contact_SetApplyRoutingRecruiting</fullName>
        <field>Apply_Routing_Type__c</field>
        <literalValue>Recruiting</literalValue>
        <name>Contact_SetApplyRoutingRecruiting</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Assign Contact to new Owner</fullName>
        <actions>
            <name>Contact_SetApplyRoutingRecruiting</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>AND( ! ISNEW(),
       ! ISPICKVAL(Apply_Routing_Type__c ,&quot;Recruiting&quot;))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Copy Email to Applicant Email</fullName>
        <actions>
            <name>Applicant_Copy_Email_to_Applicant_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>Email  &lt;&gt;  Applicant_Email__c</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Copy Email to Applicant Email Address</fullName>
        <actions>
            <name>Contact_Copy_Email_to_Applicant_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.Email</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.Applicant_Email__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Delayed Assign Contact to new Owner</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Contact.Apply_Routing_Type__c</field>
            <operation>notEqual</operation>
            <value>Recruiting</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Set Start Term%3A2011</fullName>
        <actions>
            <name>Applicant_Set_Start_Term_2011</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Contact.OP_Start_Term__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.OP_Start_Term__c</field>
            <operation>contains</operation>
            <value>September 2011</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Start Term%3A2012</fullName>
        <actions>
            <name>Applicant_Set_Start_Term_2012</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.OP_Start_Term__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.OP_Start_Term__c</field>
            <operation>contains</operation>
            <value>September 2012</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Start Term%3A2013</fullName>
        <actions>
            <name>Applicant_Set_Start_Term_2013</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Contact.OP_Start_Term__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.OP_Start_Term__c</field>
            <operation>contains</operation>
            <value>September 2013</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Start Term%3A2014</fullName>
        <actions>
            <name>Applicant_Set_Start_Date_2014</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Contact.OP_Start_Term__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.OP_Start_Term__c</field>
            <operation>contains</operation>
            <value>September 2014</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>UpdateConfirmationDeadline</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Contact.Confirmation_Deadline__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
