<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Set_task_as_completed</fullName>
        <description>Use when brochure request date is inserted</description>
        <field>Status</field>
        <literalValue>Completed</literalValue>
        <name>Set task as completed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Set brochure send date</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Task.Subject</field>
            <operation>equals</operation>
            <value>Follow up brochure request</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
