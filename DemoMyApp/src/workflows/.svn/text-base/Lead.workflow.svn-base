<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Event_Set_Interview_Booked_Date_to_Today</fullName>
        <field>Interview_Date_Booked__c</field>
        <formula>TODAY()</formula>
        <name>Event:Set Interview Booked Date to Today</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>LeadInterviewStatusBooked</fullName>
        <field>Interview_Status__c</field>
        <literalValue>Booked</literalValue>
        <name>LeadInterviewStatusBooked</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>LeadInterviewStatusCompleted</fullName>
        <field>Interview_Status__c</field>
        <literalValue>Completed</literalValue>
        <name>LeadInterviewStatusCompleted</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Lead_Copy_Applicant_Email_to_Email</fullName>
        <field>Email</field>
        <formula>Applicant_Email__c</formula>
        <name>Lead:Copy Applicant Email to Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Lead_SetCompanyToProgram</fullName>
        <field>Company</field>
        <formula>Program_Primary__r.Name</formula>
        <name>Lead_SetCompanyToProgram</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Lead_SetCompanyToUndecidedApplicant</fullName>
        <field>Company</field>
        <formula>&quot;Undecided Applicant&quot;</formula>
        <name>Lead_SetCompanyToUndecidedApplicant</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Lead_Set_Convert_Now_True</fullName>
        <field>Convert_Now__c</field>
        <literalValue>1</literalValue>
        <name>Lead:Set Convert Now True</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Lead_Set_Interview_Status_to_Rescheduled</fullName>
        <field>Interview_Status__c</field>
        <literalValue>Rescheduled</literalValue>
        <name>Lead:Set Interview Status to Rescheduled</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Lead_Set_Rescheduled_Booked_Date</fullName>
        <field>Rescheduled_Date_Booked__c</field>
        <formula>TODAY()</formula>
        <name>Lead:Set Rescheduled Booked Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Lead_Set_Rescheduled_Booked_to_Today</fullName>
        <field>Rescheduled_Date_Booked__c</field>
        <formula>TODAY()</formula>
        <name>Lead:Set Rescheduled Booked to Today</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Copy Applicant Email to Email</fullName>
        <actions>
            <name>Lead_Copy_Applicant_Email_to_Email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Applicant_Email__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Copy the Applicant Email Field,which is set to be unique, to the Standard Email Field</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Lead Interview Status Booked</fullName>
        <actions>
            <name>LeadInterviewStatusBooked</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Interview_Date_Booked__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Company To Program Name</fullName>
        <actions>
            <name>Lead_SetCompanyToProgram</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>NOT(ISBLANK(Program_Primary__c))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Set Company To Undecided Applicant</fullName>
        <actions>
            <name>Lead_SetCompanyToUndecidedApplicant</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(ISBLANK(Program_Primary__c))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Set Convert Now</fullName>
        <actions>
            <name>Lead_Set_Convert_Now_True</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Lead_Stage__c</field>
            <operation>equals</operation>
            <value>Interested Next Year,Interested,Qualified for Other Program,Strongly Interested,Interview Request</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Set Interview Booked Date to Today</fullName>
        <actions>
            <name>Event_Set_Interview_Booked_Date_to_Today</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Interview_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Interview Rescheduled Date to Today</fullName>
        <actions>
            <name>Lead_Set_Interview_Status_to_Rescheduled</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Lead_Set_Rescheduled_Booked_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Lead_Set_Rescheduled_Booked_to_Today</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Rescheduled_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Program</fullName>
        <active>false</active>
        <formula>True</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
