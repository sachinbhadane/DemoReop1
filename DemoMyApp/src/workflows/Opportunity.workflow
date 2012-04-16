<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Admission_Decision_Notification</fullName>
        <description>Admission Decision Notification</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>Hult_Email_Templates/Notify_Recruiter_Applicant_has_been_Accepted</template>
    </alerts>
    <alerts>
        <fullName>Application_CAXRiskNotifcation</fullName>
        <ccEmails>adam.kitzis@roundcorner.com</ccEmails>
        <description>Application CAXRiskNotifcation</description>
        <protected>false</protected>
        <recipients>
            <type>accountOwner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Hult_Email_Templates/CAX_Notification</template>
    </alerts>
    <alerts>
        <fullName>Application_Campus_change_to_Boston_notice_to_Application_Owner_SS_VCs</fullName>
        <ccEmails>student.services.boston@hult.edu</ccEmails>
        <ccEmails>student.visas.boston@ef.com</ccEmails>
        <description>Notify SSs and VCs of campus change to Boston</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>Hult_Email_Templates/Notify_SSs_and_VCs_of_campus_change_Boston_Restart_Visa_Process</template>
    </alerts>
    <alerts>
        <fullName>Application_Campus_change_to_London_notice_to_Application_Owner_SS_VCs</fullName>
        <ccEmails>student.services.london@hult.edu</ccEmails>
        <ccEmails>student.visas@ef.com</ccEmails>
        <description>Notify SSs and VCs of campus change to London</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>Hult_Email_Templates/Notify_SSs_and_VCs_of_campus_change_London_Restart_Visa_Process</template>
    </alerts>
    <alerts>
        <fullName>Application_Notify_Applicant_Stage_Stuck_in_Partial</fullName>
        <description>Application:Notify Applicant Stage Stuck in Partial</description>
        <protected>false</protected>
        <recipients>
            <field>Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>Hult_Email_Templates/Application_Stalled_in_Partial_Stage</template>
    </alerts>
    <alerts>
        <fullName>Application_Notify_Applicant_Started_Application</fullName>
        <description>Application:Notify Applicant Started Application</description>
        <protected>false</protected>
        <recipients>
            <field>Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>Hult_Email_Templates/Notify_Applicant_of_Stated_Application</template>
    </alerts>
    <alerts>
        <fullName>Application_Notify_Applicant_of_Application_Submission_Confirmation</fullName>
        <description>Application:Notify Applicant of Application Submission Confirmation</description>
        <protected>false</protected>
        <recipients>
            <field>Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>Hult_Email_Templates/Notify_Applicant_of_Application_Submission_Confirmation</template>
    </alerts>
    <alerts>
        <fullName>Application_Notify_Recruiter_Applicant_has_been_Accepted</fullName>
        <description>Application:Notify Recruiter Applicant has been Accepted</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>Hult_Email_Templates/Notify_Recruiter_Applicant_has_been_Accepted</template>
    </alerts>
    <alerts>
        <fullName>Application_Notify_Recruiter_Applicant_has_been_Admissions_Endorsed</fullName>
        <description>Application:Notify Recruiter Applicant has been Admissions Endorsed</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>Hult_Email_Templates/Notify_Recruiter_Applicant_has_been_Admissions_Endorsed</template>
    </alerts>
    <alerts>
        <fullName>Application_Notify_Recruiter_Applicant_has_been_Conditionally_Accepted</fullName>
        <description>Application:Notify Recruiter Applicant has been Conditionally Accepted</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>Hult_Email_Templates/Notify_Recruiter_Applicant_has_been_Conditionally_Accepted</template>
    </alerts>
    <alerts>
        <fullName>Application_Notify_Recruiter_Applicant_has_been_Rejected</fullName>
        <description>Application:Notify Recruiter Applicant has been Rejected</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>Hult_Email_Templates/Notify_Recruiter_Applicant_has_been_Rejected</template>
    </alerts>
    <alerts>
        <fullName>Application_Notify_Recruiter_Confirmation_Deadline_Approaching</fullName>
        <description>Application:Notify Recruiter Confirmation Deadline Approaching</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>Hult_Email_Templates/Notification_to_Recruiter_Applicant_Confirmaiton_Deadline_is_Approaching</template>
    </alerts>
    <alerts>
        <fullName>Application_Notify_Recruiter_of_Application_Submission_Confirmation</fullName>
        <description>Application:Notify Recruiter of Application Submission Confirmation</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>Hult_Email_Templates/Notify_Applicant_of_Application_Submission_Confirmation</template>
    </alerts>
    <alerts>
        <fullName>Notifiy_Recruiter_Application_Working_to_Complete</fullName>
        <description>Notifiy Recruiter Application Working to Complete</description>
        <protected>false</protected>
        <recipients>
            <field>Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>Hult_Email_Templates/Notify_Recruiter_Application_Working_to_Complete</template>
    </alerts>
    <alerts>
        <fullName>Notify_Recruiter_of_change_of_campus</fullName>
        <description>Notify Recruiter of change of campus</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Hult_Email_Templates/Notify_Recruiter_of_change_of_campus</template>
    </alerts>
    <alerts>
        <fullName>Notify_SSs_and_VCs_of_campus_change_to_Dubai</fullName>
        <ccEmails>student.services.dubai@hult.edu</ccEmails>
        <ccEmails>student.visas.dubai@hult.edu</ccEmails>
        <description>Notify SSs and VCs of campus change to Dubai</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>Hult_Email_Templates/Notify_SSs_and_VCs_of_campus_change_Dubai_Restart_Visa_Process</template>
    </alerts>
    <alerts>
        <fullName>Notify_SSs_and_VCs_of_campus_change_to_San_Francisco</fullName>
        <ccEmails>student.services.sanfrancisco@hult.edu</ccEmails>
        <ccEmails>student.visas.sanfrancisco@hult.edu</ccEmails>
        <description>Notify SSs and VCs of campus change to San Francisco</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>Hult_Email_Templates/Notify_SSs_and_VCs_of_campus_change_San_Francisco_Restart_Visa_Process</template>
    </alerts>
    <alerts>
        <fullName>Notify_SSs_and_VCs_of_campus_change_to_Shanghai</fullName>
        <ccEmails>student.services.shanghai@hult.edu</ccEmails>
        <description>Notify SSs and VCs of campus change to Shanghai</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>Hult_Email_Templates/Notify_SSs_and_VCs_of_campus_change_Shanghai_Restart_Visa_Process</template>
    </alerts>
    <alerts>
        <fullName>Opportunity_EmailNotificationToApplicant</fullName>
        <ccEmails>adam.kitzis@roundcorner.com</ccEmails>
        <ccEmails>ian.zepp@roundcorner.com</ccEmails>
        <description>Opportunity_EmailNotificationToApplicant</description>
        <protected>false</protected>
        <recipients>
            <field>Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Hult_Email_Templates/Applicant_Notification_Test</template>
    </alerts>
    <alerts>
        <fullName>Opportunity_Recruiter_Assistance_Email_Template</fullName>
        <description>Opportunity Recruiter Assistance Email Template</description>
        <protected>false</protected>
        <recipients>
            <type>accountOwner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Hult_Email_Templates/Recruiter_Assistance_Required</template>
    </alerts>
    <alerts>
        <fullName>Send_Email_Notification_Application_Stuck_In_Progress</fullName>
        <description>Send Email Notification Application Stuck In Progress</description>
        <protected>false</protected>
        <recipients>
            <field>Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>Hult_Email_Templates/Application_Stalled_in_In_Progress</template>
    </alerts>
    <alerts>
        <fullName>Send_Email_Notification_Application_Stuck_in_Stage</fullName>
        <description>Send Email Notification Application Stuck in Stage</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Hult_Email_Templates/Stalled_Application_Stage</template>
    </alerts>
    <alerts>
        <fullName>Send_Recruiter_Email_Notification_Application_Stuck_In_Progress</fullName>
        <description>Send Recruiter Email Notification Application Stuck In Progress</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>Hult_Email_Templates/Application_Stalled_in_In_Progress</template>
    </alerts>
    <alerts>
        <fullName>Sent_Applicant_Portal_Registration_Email</fullName>
        <description>Sent Applicant Portal Registration Email</description>
        <protected>false</protected>
        <recipients>
            <field>Contact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Hult_Email_Templates/ApplicantLoginDetails</template>
    </alerts>
    <fieldUpdates>
        <fullName>APPLICATION_Enable_Online_Account</fullName>
        <field>Applicant_Confirmation__c</field>
        <literalValue>Yes</literalValue>
        <name>APPLICATION:Enable Online Account</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>APPLICATION_Set_App_Complete_Date</fullName>
        <field>Completed_Application_Date__c</field>
        <formula>Today()</formula>
        <name>APPLICATION: Set App. Complete Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>APPPLICATION_Update_Notified_Date</fullName>
        <field>Notified_Date__c</field>
        <formula>Today()</formula>
        <name>APPPLICATION: Update Notified Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Appeal_Decision_Change</fullName>
        <field>Decision__c</field>
        <literalValue>Accept</literalValue>
        <name>Appeal: Decision Change</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Appeal_Reject_Checkbox</fullName>
        <description>unchecks the rejected checkbox when appeal granted</description>
        <field>Rejected__c</field>
        <literalValue>0</literalValue>
        <name>Appeal: Reject Checkbox</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Appeal_Rejected_Date</fullName>
        <description>Removes rejected date when the appeal is granted</description>
        <field>Rejected_Date__c</field>
        <name>Appeal: Rejected Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Appeal_Stage_Change</fullName>
        <field>StageName</field>
        <literalValue>Accepted</literalValue>
        <name>Appeal: Stage Change</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Application_Appeal_Granted_Date</fullName>
        <field>Appeal_Granted_Date__c</field>
        <formula>TODAY()</formula>
        <name>Application: Appeal Granted Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Application_Appeal_Request_Date</fullName>
        <field>Appeal_Request_Date__c</field>
        <formula>TODAY()</formula>
        <name>Application: Appeal Request Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Application_Clear_Confirmation_Date</fullName>
        <field>Confirmed_Date__c</field>
        <name>Application:Clear Confirmation Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Application_Clear_Confirmation_Deadline</fullName>
        <field>Confirmation_Deadline__c</field>
        <name>Application:Clear Confirmation Deadline</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Application_MagicPackSendDateDatestamp</fullName>
        <description>Field Update to populate the field &apos;Magic Pack Send Date&apos; with the date of when &apos;send magic pack&apos; is checked.</description>
        <field>Magic_Pack_Send_Date__c</field>
        <formula>TODAY()</formula>
        <name>Application:MagicPackSendDateDatestamp</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Application_Remove_Online_Account_Access</fullName>
        <field>Applicant_Confirmation__c</field>
        <literalValue>No</literalValue>
        <name>Application:Remove Online Account Access</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Application_Set_Close_Date</fullName>
        <field>CloseDate</field>
        <formula>DATEVALUE(&quot;2020-01-01&quot;)</formula>
        <name>Application:Set Close Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Application_Set_Lead_Source_to_Online_Ap</fullName>
        <field>LeadSource</field>
        <literalValue>Online Application</literalValue>
        <name>Application:Set Lead Source to Online Ap</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Application_Set_Stage_to_In_Progress</fullName>
        <field>StageName</field>
        <literalValue>In Progress</literalValue>
        <name>Application:Set Stage to In Progress</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Application_Set_Stage_to_Partial_App</fullName>
        <field>StageName</field>
        <literalValue>Partial Application</literalValue>
        <name>Application:Set Stage to Partial App</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ConfirmedDateStamp</fullName>
        <field>Confirmed_Date__c</field>
        <formula>TODAY()</formula>
        <name>ConfirmedDateStamp</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>EndorsedDateStamp</fullName>
        <field>Endorsed_Date__c</field>
        <formula>TODAY()</formula>
        <name>EndorsedDateStamp</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>EnrolledDateStamp</fullName>
        <field>Enrolled_Date__c</field>
        <formula>TODAY()</formula>
        <name>EnrolledDateStamp</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>InProgressDateStamp</fullName>
        <field>In_Progress_Date__c</field>
        <formula>TODAY()</formula>
        <name>InProgressDateStamp</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Magic_Pack_Ship_Date_Update</fullName>
        <description>Update Magic Pack Ship Date</description>
        <field>Magic_Pack_Ship_Date__c</field>
        <formula>Today()</formula>
        <name>Magic Pack Ship Date Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Opportunity_Assign_Recruiter</fullName>
        <field>OwnerId</field>
        <lookupValue>jim.delaney@roundcorner.com.hult.fullqc</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Opportunity:Assign Recruiter</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Opportunity_SetAcceptedDateToday</fullName>
        <field>Accepted_Date__c</field>
        <formula>TODAY()</formula>
        <name>Opportunity_SetAcceptedDateToday</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Opportunity_SetAcceptedTrue</fullName>
        <field>Accepted__c</field>
        <literalValue>1</literalValue>
        <name>Opportunity_SetAcceptedTrue</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Opportunity_SetAppStatusWithdrawn</fullName>
        <field>Application_Status__c</field>
        <literalValue>Withdrawn</literalValue>
        <name>Opportunity_SetAppStatusWithdrawn</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Opportunity_SetCancellationDateToday</fullName>
        <field>Cancellation_Date__c</field>
        <formula>TODAY()</formula>
        <name>Opportunity_SetCancellationDateToday</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Opportunity_SetDecisionDateToday</fullName>
        <field>Decision_Date__c</field>
        <formula>TODAY()</formula>
        <name>Opportunity_SetDecisionDateToday</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Opportunity_SetDeferredDateToday</fullName>
        <field>Deferred_Date__c</field>
        <formula>TODAY()</formula>
        <name>Opportunity_SetDeferredDateToday</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Opportunity_SetDeferredTrue</fullName>
        <field>Deferred__c</field>
        <literalValue>1</literalValue>
        <name>Opportunity_SetDeferredTrue</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Opportunity_SetIdealName</fullName>
        <field>Name</field>
        <formula>Contact__r.FirstName + &apos; &apos; + Contact__r.LastName + &apos;: &apos; + Program__r.Name</formula>
        <name>Opportunity_SetIdealName</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Opportunity_SetMPSendDateToday</fullName>
        <field>Magic_Pack_Send_Date__c</field>
        <formula>TODAY()</formula>
        <name>Opportunity_SetMPSendDateToday</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Opportunity_SetRejectedTrue</fullName>
        <field>Rejected__c</field>
        <literalValue>1</literalValue>
        <name>Opportunity_SetRejectedTrue</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Opportunity_SetSSCEmailDateToday</fullName>
        <field>SSC_Email_Date__c</field>
        <formula>TODAY()</formula>
        <name>Opportunity_SetSSCEmailDateToday</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Opportunity_SetSSCPreArrivalDateToday</fullName>
        <field>SSC_Pre_Arrival_Call_Date__c</field>
        <formula>TODAY()</formula>
        <name>Opportunity_SetSSCPreArrivalDateToday</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Opportunity_SetStageRejected</fullName>
        <field>StageName</field>
        <literalValue>Rejected</literalValue>
        <name>Opportunity_SetStageRejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Opportunity_SetSubmission_Date</fullName>
        <field>Submitted_Date__c</field>
        <formula>TODAY()</formula>
        <name>Opportunity SetSubmission Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Opportunity_SetWithdrawnDateToday</fullName>
        <field>Withdrawn_Date__c</field>
        <formula>TODAY()</formula>
        <name>Opportunity_SetWithdrawnDateToday</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Opportunity_Set_Pgm_Start_Date_Sept_2012</fullName>
        <field>Program_Start_Date__c</field>
        <formula>Program__r.September_2012_Start_Date__c</formula>
        <name>Opportunity:Set Pgm Start Date Sept 2012</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Opportunity_Set_Primary_Campus_to_Dubai</fullName>
        <field>Primary_Campus__c</field>
        <literalValue>Dubai</literalValue>
        <name>Opportunity:Set Primary Campus to Dubai</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Opportunity_Set_Start_Term_2011</fullName>
        <field>Start_Term__c</field>
        <literalValue>September 2011</literalValue>
        <name>Opportunity:Set Start Term 2011</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Opportunity_Set_Start_Term_2012</fullName>
        <field>Start_Term__c</field>
        <literalValue>September 2012</literalValue>
        <name>Opportunity:Set Start Term 2012</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Opportunity_Set_Start_Term_2013</fullName>
        <field>Start_Term__c</field>
        <literalValue>September 2013</literalValue>
        <name>Opportunity:Set Start Term 2013</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Opportunity_Set_Start_Term_2014</fullName>
        <field>Start_Term__c</field>
        <literalValue>September 2014</literalValue>
        <name>Opportunity:Set Start Term 2014</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Opportunity_Update_Primary_Campus_Boston</fullName>
        <field>Primary_Campus__c</field>
        <literalValue>Boston</literalValue>
        <name>Opportunity:Update Primary Campus-Boston</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Opportunity_Update_Primary_Campus_Lond</fullName>
        <field>Primary_Campus__c</field>
        <literalValue>London</literalValue>
        <name>Opportunity:Update Primary Campus - Lond</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Opportunity_Update_Primary_Campus_Shang</fullName>
        <field>Primary_Campus__c</field>
        <literalValue>Shanghai</literalValue>
        <name>Opportunity:Update Primary Campus- Shang</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Opportunity_update_Primary_Campus_San_Fr</fullName>
        <field>Primary_Campus__c</field>
        <literalValue>San Francisco</literalValue>
        <name>Opportunity update Primary Campus San Fr</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PartialAppDateStamp</fullName>
        <field>Partial_Application_Date__c</field>
        <formula>TODAY()</formula>
        <name>PartialAppDateStamp</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ReadyforreviewDateStamp</fullName>
        <field>Ready_for_Review_Date__c</field>
        <formula>TODAY()</formula>
        <name>ReadyforreviewDateStamp</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>RejectedDateStamp</fullName>
        <field>Rejected_Date__c</field>
        <formula>TODAY()</formula>
        <name>RejectedDateStamp</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SIFT_Offer_Date</fullName>
        <field>SIFT_Offer_Sent_Date__c</field>
        <formula>TODAY()</formula>
        <name>SIFT Offer Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SSC_Welcome_Call_Date</fullName>
        <field>SSC_Welcome_Call_Date__c</field>
        <formula>TODAY()</formula>
        <name>SSC Welcome Call Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Application_Fee_Checkbox</fullName>
        <field>Paid_Application_Fee__c</field>
        <literalValue>1</literalValue>
        <name>Set Application Fee Checkbox</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Data_Time_Compete_Personal_Info_Tab</fullName>
        <field>Personal_Information_Complete_Date_Time__c</field>
        <formula>Now()</formula>
        <name>Set Data/Time Compete-Personal Info Tab</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Date_Time_Complete_Application_Fee</fullName>
        <field>Application_Fee_Date_Time__c</field>
        <formula>Now()</formula>
        <name>Set Date/Time Complete- Application Fee</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Date_Time_Complete_Attachments_Tab</fullName>
        <field>Attachments_Complete_Date_Time__c</field>
        <formula>now()</formula>
        <name>Set Date/Time Complete-Attachments Tab</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Date_Time_Complete_Education_Tab</fullName>
        <field>Education_Complete_Date_Time__c</field>
        <formula>Now()</formula>
        <name>Set Date/Time Complete-Education Tab</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Date_Time_Complete_Employment_Tab</fullName>
        <field>Employment_Complete_Date_Time__c</field>
        <formula>Now()</formula>
        <name>Set Date/Time Complete-Employment Tab</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Date_Time_Complete_Essay_Tab</fullName>
        <field>Essay_Complete_Date_Time__c</field>
        <formula>now()</formula>
        <name>Set Date/Time Complete- Essay Tab</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Date_Time_Complete_Exam_Tab</fullName>
        <field>Exam_History_Complete_Date_Time__c</field>
        <formula>Now()</formula>
        <name>Set Date/Time Complete-Exam Tab</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Date_Time_Complete_Program_Loc_Tab</fullName>
        <field>Program_and_Location_Complete_Date_Time__c</field>
        <formula>Now()</formula>
        <name>Set Date/Time Complete-Program &amp; Loc Tab</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Date_Time_Complete_Sponsorsip_Tab</fullName>
        <field>Sponsorship_Complete_Date_Time__c</field>
        <formula>now()</formula>
        <name>Set Date/Time Complete-Sponsorsip Tab</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Date_Time_Completed_Final_Submission</fullName>
        <field>Final_Submission_Complete_Date_Time__c</field>
        <formula>now()</formula>
        <name>Set Date/Time Completed-Final Submission</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Date_Time_Completed_Reference_Tab</fullName>
        <field>Reference_Complete_Date_Time__c</field>
        <formula>now()</formula>
        <name>Set Date/Time Completed-Reference Tab</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Uncheck_Specialization_Taken</fullName>
        <field>Specialization_Taken__c</field>
        <literalValue>0</literalValue>
        <name>Uncheck Specialization Taken?</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UnderReviewDateStamp</fullName>
        <field>Under_Review_Date__c</field>
        <formula>TODAY()</formula>
        <name>UnderReviewDateStamp</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Acceptance_Date</fullName>
        <field>Accepted_Date__c</field>
        <formula>Today()</formula>
        <name>Update Acceptance Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Visa_Notice_Date</fullName>
        <field>Visa_Notice_Sent_Date__c</field>
        <formula>TODAY()</formula>
        <name>Visa Notice Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>WCD_Application_Stage_Date_Update</fullName>
        <field>Status_Date__c</field>
        <formula>Today()</formula>
        <name>WCD Application Stage Date Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>WaitingforreviewDateStamp</fullName>
        <field>Waiting_for_Review_Date__c</field>
        <formula>TODAY()</formula>
        <name>WaitingforreviewDateStamp</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>WaitlistedFieldUpdate</fullName>
        <field>Waitlisted_Date__c</field>
        <formula>TODAY()</formula>
        <name>WaitlistedFieldUpdate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <outboundMessages>
        <fullName>ListenerForMyHult</fullName>
        <apiVersion>24.0</apiVersion>
        <description>When there is stage field updated matching a specific critera, a message willl be sent to myhult</description>
        <endpointUrl>http://myhultdevservices.hult.edu/salesforceOMListener.asmx</endpointUrl>
        <fields>Activate_My_Hult__c</fields>
        <fields>Contact__c</fields>
        <fields>Id</fields>
        <includeSessionId>false</includeSessionId>
        <integrationUser>s4s.apiuser@ef.com.fullqc</integrationUser>
        <name>ListenerForMyHult</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <outboundMessages>
        <fullName>OpportunityUpdateNotification</fullName>
        <apiVersion>24.0</apiVersion>
        <description>Test for Hult Service</description>
        <endpointUrl>http://209.196.29.102/LeadOMListener.asmx</endpointUrl>
        <fields>Contact__c</fields>
        <fields>Id</fields>
        <includeSessionId>false</includeSessionId>
        <integrationUser>zeeshan.zuberi@hult.edu</integrationUser>
        <name>OpportunityUpdateNotification</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <rules>
        <fullName>Application Accepted</fullName>
        <actions>
            <name>Update_Acceptance_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Application_Status__c</field>
            <operation>equals</operation>
            <value>Active</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Conditionally Accepted,Accepted,Admissions Endorsed</value>
        </criteriaItems>
        <description>back end date stamp</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Application Admissions Endorsed</fullName>
        <actions>
            <name>Application_Notify_Recruiter_Applicant_has_been_Admissions_Endorsed</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>EndorsedDateStamp</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Application_Status__c</field>
            <operation>equals</operation>
            <value>Active</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Admissions Endorsed</value>
        </criteriaItems>
        <description>back end date stamp</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Application Cancelled</fullName>
        <actions>
            <name>Opportunity_SetCancellationDateToday</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Cancellation</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Application Complete Application</fullName>
        <actions>
            <name>APPLICATION_Set_App_Complete_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Application_Status__c</field>
            <operation>equals</operation>
            <value>Active</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Partial Application</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Application_Substage__c</field>
            <operation>equals</operation>
            <value>Completed Application</value>
        </criteriaItems>
        <description>Used in the back end to snapshot the date of  partial/completed application stage/sub-stage</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Application Confirmed</fullName>
        <actions>
            <name>ConfirmedDateStamp</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Application_Status__c</field>
            <operation>equals</operation>
            <value>Active</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Admissions Endorsed Confirmed,Waitlisted Confirmed,Conditionally Confirmed,Confirmed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Confirmed_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>back end date stamp</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Application Decision Recruiter</fullName>
        <actions>
            <name>Admission_Decision_Notification</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Admission_Decision</name>
            <type>Task</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Conditionally Accepted,Accepted,Admissions Endorsed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Application_Status__c</field>
            <operation>equals</operation>
            <value>Active</value>
        </criteriaItems>
        <description>Notify recruiter of application decision</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Application Deferred</fullName>
        <actions>
            <name>Opportunity_SetDeferredDateToday</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Opportunity_SetDeferredTrue</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Application_Status__c</field>
            <operation>equals</operation>
            <value>Deferred</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Application Enrolled</fullName>
        <actions>
            <name>EnrolledDateStamp</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Application_Status__c</field>
            <operation>equals</operation>
            <value>Active</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Enrolled</value>
        </criteriaItems>
        <description>back end date stamp</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Application In Progress</fullName>
        <actions>
            <name>Application_Set_Stage_to_In_Progress</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>InProgressDateStamp</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Program_and_Location_Tab_Complete__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Personal_Information_Complete__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Application_Status__c</field>
            <operation>equals</operation>
            <value>Active</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Qualified Lead</value>
        </criteriaItems>
        <description>Use to set the stage to In Progress and timestampt the date in the back end</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Application Magic Pack Shipped Date</fullName>
        <actions>
            <name>Magic_Pack_Ship_Date_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Application_Status__c</field>
            <operation>equals</operation>
            <value>Active</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Magic_Pack_Status__c</field>
            <operation>equals</operation>
            <value>Shipped</value>
        </criteriaItems>
        <description>To populate &apos;Magic Pack Ship Date&apos; with current date when &apos;Magic Pack Status&apos; is set to &quot;Shipped&quot;.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Application Notified Date Stamp</fullName>
        <actions>
            <name>APPPLICATION_Update_Notified_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Application_Status__c</field>
            <operation>equals</operation>
            <value>Active</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Conditionally Accepted,Accepted,Admissions Endorsed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Application_Substage__c</field>
            <operation>equals</operation>
            <value>Notified</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Notified_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Used in the back end to snapshot the date of Notified sub-stage</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Application Partial Application</fullName>
        <actions>
            <name>Application_Set_Stage_to_Partial_App</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>PartialAppDateStamp</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3 AND 4 AND (5 OR 6)</booleanFilter>
        <criteriaItems>
            <field>Opportunity.Application_Status__c</field>
            <operation>equals</operation>
            <value>Active</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>In Progress</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Final_Submission_Tab_Complete__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Partial_Application_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Application_Fee_Complete__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Paid_Application_Fee__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Used in the back end to snapshot the date of partial app stage</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Application Rejected</fullName>
        <actions>
            <name>Application_Notify_Recruiter_Applicant_has_been_Rejected</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>RejectedDateStamp</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Application_Status__c</field>
            <operation>equals</operation>
            <value>Active</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Rejected</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Rejected_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>back end date stamp</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Application Stage Accepted</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.Application_Status__c</field>
            <operation>equals</operation>
            <value>Active</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Conditionally Accepted,Accepted,Admissions Endorsed</value>
        </criteriaItems>
        <description>Create a task for the recruiter when the application stage goes to Accepted, Conditionally Accepted, and Endorsed.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Application Submitted Date</fullName>
        <actions>
            <name>Opportunity_SetSubmission_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Partial Application</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Application_Substage__c</field>
            <operation>equals</operation>
            <value>Completed Application</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Application_Status__c</field>
            <operation>equals</operation>
            <value>Active</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Application Under Review</fullName>
        <actions>
            <name>UnderReviewDateStamp</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Application_Status__c</field>
            <operation>equals</operation>
            <value>Active</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Under Review</value>
        </criteriaItems>
        <description>back end date stamps</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Application Waiting For Review</fullName>
        <actions>
            <name>ReadyforreviewDateStamp</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>WaitingforreviewDateStamp</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Application_Status__c</field>
            <operation>equals</operation>
            <value>Active</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Waiting for Review</value>
        </criteriaItems>
        <description>Backend date stamp for app stage</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Application Waitlisted</fullName>
        <actions>
            <name>WaitlistedFieldUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Waitlisted__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Application Withdrawn</fullName>
        <actions>
            <name>Opportunity_SetAppStatusWithdrawn</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Opportunity_SetWithdrawnDateToday</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Withdrawn_By__c</field>
            <operation>equals</operation>
            <value>Applicant,Hult</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Application%3A Appeal Granted</fullName>
        <actions>
            <name>Appeal_Decision_Change</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Appeal_Reject_Checkbox</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Appeal_Rejected_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Application_Appeal_Granted_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Appeal_Granted__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Application%3A Appeal Requested</fullName>
        <actions>
            <name>Application_Appeal_Request_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Appeal_Requested__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>CAX Risk Notification</fullName>
        <actions>
            <name>Application_CAXRiskNotifcation</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.CAX_Risk__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>When the checkbox is checked, email is sent to recruiter</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Deactivated-Application Magic Pack Shipped Date</fullName>
        <actions>
            <name>Magic_Pack_Ship_Date_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.Application_Status__c</field>
            <operation>equals</operation>
            <value>Active</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Magic_Pack_Status__c</field>
            <operation>equals</operation>
            <value>Shipped</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Magic_Pack_Ship_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Used in the back end to snapshot the date of Magic Pack Shipped</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Deactivated-Magic Pack Send Date</fullName>
        <actions>
            <name>Opportunity_SetMPSendDateToday</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.Magic_Pack_Status__c</field>
            <operation>equals</operation>
            <value>Shipped</value>
        </criteriaItems>
        <description>Auto-fills the magic pack send date when the send magic pack is clicked true</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Decision Rendered%3A Accepted</fullName>
        <actions>
            <name>Opportunity_SetAcceptedDateToday</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Opportunity_SetAcceptedTrue</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Opportunity_SetDecisionDateToday</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Application_Status__c</field>
            <operation>equals</operation>
            <value>Active</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Conditionally Accepted,Accepted,Admissions Endorsed</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Decision Rendered%3A Rejected</fullName>
        <actions>
            <name>Opportunity_SetDecisionDateToday</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Opportunity_SetRejectedTrue</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Opportunity_SetStageRejected</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Application_Status__c</field>
            <operation>equals</operation>
            <value>Active</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Decision__c</field>
            <operation>equals</operation>
            <value>Reject</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Email Notification Recruiter Confirmation Deadline Approaching</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Confirmation_Deadline__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Confirmed_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Conditionally Accepted,Accepted,Admissions Endorsed</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Enable Online Account at App Completion</fullName>
        <actions>
            <name>APPLICATION_Enable_Online_Account</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 AND 2 AND 3) OR 4</booleanFilter>
        <criteriaItems>
            <field>Opportunity.Final_Submission_Tab_Complete__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Partial Application</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Application_Substage__c</field>
            <operation>equals</operation>
            <value>Completed Application</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Conditionally Accepted,Withdrawn,Cancellation,Enrolled,Waitlisted Confirmed,Waiting for Review,Admissions Endorsed,Rejected,Admissions Endorsed Confirmed,Confirmed,Conditionally Confirmed,Accepted,Deferral</value>
        </criteriaItems>
        <description>Sets the Applicant Confirmation Flag that enables the Online Account to be seen in the portal</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Magic Pack AAM Notification</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Send_Magic_Pack__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Magic Pack Send Date</fullName>
        <actions>
            <name>Opportunity_SetMPSendDateToday</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Send_Magic_Pack__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>To populate &apos;Magic Pack Send Date&apos; with the current date when &apos;Send Magic Pack&apos; is checked.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification  Application is Stalled in Stage -  Partial Application</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.Application_Status__c</field>
            <operation>equals</operation>
            <value>Active</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Partial Application</value>
        </criteriaItems>
        <description>Notification that Application has been stalled in the stage for longer than allowed</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification  Application is Stalled in Stage -  Waiting for Review</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.Application_Status__c</field>
            <operation>equals</operation>
            <value>Active</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Waiting for Review</value>
        </criteriaItems>
        <description>Notification that Application has been stalled in the stage for longer than allowed</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification  Application is Stalled in Stage - Accepted</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.Application_Status__c</field>
            <operation>equals</operation>
            <value>Active</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Accepted</value>
        </criteriaItems>
        <description>Notification that Application has been stalled in the stage for longer than allowed</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification  Application is Stalled in Stage - Confirmed</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.Application_Status__c</field>
            <operation>equals</operation>
            <value>Active</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Confirmed</value>
        </criteriaItems>
        <description>Notification that Application has been stalled in the stage for longer than allowed</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification  Application is Stalled in Stage - Endorsed</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.Application_Status__c</field>
            <operation>equals</operation>
            <value>Active</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Endorsed</value>
        </criteriaItems>
        <description>Notification that Application has been stalled in the stage for longer than allowed</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification  Application is Stalled in Stage - In Progress</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Application_Status__c</field>
            <operation>equals</operation>
            <value>Active</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>In Progress</value>
        </criteriaItems>
        <description>Notification that  Application has been stalled in the stage for longer than allowed</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification  Application is Stalled in Stage - Qualified Lead</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.Application_Status__c</field>
            <operation>equals</operation>
            <value>Active</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Qualified Lead</value>
        </criteriaItems>
        <description>Notification that Application has been stalled in the stage for longer than allowed</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification  Application is Stalled in Stage -Endorsed Confirmed</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.Application_Status__c</field>
            <operation>equals</operation>
            <value>Active</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Endorsed Confirmed</value>
        </criteriaItems>
        <description>Notification that Application has been stalled in the stage for longer than allowed</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notify Applicant</fullName>
        <actions>
            <name>Application_Notify_Applicant_Started_Application</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>In Progress</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Application_Substage__c</field>
            <operation>equals</operation>
            <value>Working to Complete App</value>
        </criteriaItems>
        <description>Send Email to Applicant when they start an Application</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notify Applicant of Application Submission Confirmation</fullName>
        <actions>
            <name>Application_Notify_Applicant_of_Application_Submission_Confirmation</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Application_Notify_Recruiter_of_Application_Submission_Confirmation</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Partial Application</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Application_Fee_Complete__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Final_Submission_Tab_Complete__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notify Applicant of Started Application</fullName>
        <actions>
            <name>Application_Notify_Applicant_Started_Application</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>In Progress</value>
        </criteriaItems>
        <description>Send Email to Applicant when they start an Application</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notify Recruiter Applicant has been Accepted</fullName>
        <actions>
            <name>Application_Notify_Recruiter_Applicant_has_been_Accepted</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Conditionally Accepted,Accepted</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notify Recruiter Applicant has been Admissions Endorsed</fullName>
        <actions>
            <name>Application_Notify_Recruiter_Applicant_has_been_Admissions_Endorsed</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Admissions Endorsed</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notify Recruiter Applicant has been Conditionally Accepted</fullName>
        <actions>
            <name>Application_Notify_Recruiter_Applicant_has_been_Conditionally_Accepted</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Conditionally Accepted</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notify Recruiter Applicant has been Rejected</fullName>
        <actions>
            <name>Application_Notify_Recruiter_Applicant_has_been_Rejected</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Rejected</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notify Recruiter Application Substage set to Working to Complete</fullName>
        <actions>
            <name>Notifiy_Recruiter_Application_Working_to_Complete</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <formula>AND( ISPICKVAL( StageName ,&quot;Waiting for Review&quot; ),  ISPICKVAL( Application_Substage__c ,&quot;Working to Complete App&quot;)  ,   CONTAINS($Profile.Name , &quot;AAM&quot;) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Notify Recruiter of change of campus</fullName>
        <actions>
            <name>Notify_Recruiter_of_change_of_campus</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>Reminder sent to recruiter when campus changes on a candidate. They will need to update the financial section including scholarship to the new currency</description>
        <formula>ischanged(Campus_parsed_from_Program__c) &amp;&amp;  if(counter_partials__c=1,true,false)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Notify SSs and VCs of campus change to Boston</fullName>
        <actions>
            <name>Application_Campus_change_to_Boston_notice_to_Application_Owner_SS_VCs</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <formula>ischanged( Campus_parsed_from_Program__c ) &amp;&amp; (PRIORVALUE(  Campus_parsed_from_Program__c)  &lt;&gt; &quot;Boston&quot;) &amp;&amp; if(Counter_Confirmed__c=1,true,false)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Notify SSs and VCs of campus change to Dubai</fullName>
        <actions>
            <name>Notify_SSs_and_VCs_of_campus_change_to_Dubai</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <formula>ischanged( Campus_parsed_from_Program__c ) &amp;&amp; (PRIORVALUE(  Campus_parsed_from_Program__c)  &lt;&gt; &quot;Dubai&quot;) &amp;&amp; if(Counter_Confirmed__c=1,true,false)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Notify SSs and VCs of campus change to London</fullName>
        <actions>
            <name>Application_Campus_change_to_London_notice_to_Application_Owner_SS_VCs</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <formula>ischanged( Campus_parsed_from_Program__c ) &amp;&amp; (PRIORVALUE(  Campus_parsed_from_Program__c)  &lt;&gt; &quot;London&quot;) &amp;&amp; if(Counter_Confirmed__c=1,true,false)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Notify SSs and VCs of campus change to San Francisco</fullName>
        <actions>
            <name>Notify_SSs_and_VCs_of_campus_change_to_San_Francisco</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <formula>ischanged( Campus_parsed_from_Program__c ) &amp;&amp; (PRIORVALUE(  Campus_parsed_from_Program__c)  &lt;&gt; &quot;San Francisco&quot;) &amp;&amp; if(Counter_Confirmed__c=1,true,false)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Notify SSs and VCs of campus change to Shanghai</fullName>
        <actions>
            <name>Notify_SSs_and_VCs_of_campus_change_to_Shanghai</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <formula>ischanged( Campus_parsed_from_Program__c ) &amp;&amp; (PRIORVALUE(  Campus_parsed_from_Program__c)  &lt;&gt; &quot;Shanghai&quot;) &amp;&amp; if(Counter_Confirmed__c=1,true,false)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>OportunityActivateMyHult</fullName>
        <actions>
            <name>ListenerForMyHult</name>
            <type>OutboundMessage</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Activate_My_Hult__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Workflow requested by Suresh to request myHult connectivity</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>OpportunityUpdateNotification</fullName>
        <actions>
            <name>OpportunityUpdateNotification</name>
            <type>OutboundMessage</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Confirmed</value>
        </criteriaItems>
        <description>This rule sends a notification when an opportunity is updated
Test WF</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Recruiter Assistance Required</fullName>
        <actions>
            <name>Opportunity_Recruiter_Assistance_Email_Template</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Recruiter_Assistance_Required__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>When the checkbox is checked, email is sent to recruiter</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Recruiter Assistance Required-Email to Recruiter</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.Recruiter_Assistance_Required__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Withdrawn,Cancellation,Waitlisted Confirmed,Admissions Endorsed Confirmed,Deferral,Confirmed,Conditionally Confirmed</value>
        </criteriaItems>
        <description>To notify recruiter that a student has been marked as RAC</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Remove Access to Online Account If Stage InProgress</fullName>
        <actions>
            <name>Application_Clear_Confirmation_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Application_Clear_Confirmation_Deadline</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Application_Remove_Online_Account_Access</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 AND 2) OR 3</booleanFilter>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>In Progress</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Application_Substage__c</field>
            <operation>notEqual</operation>
            <value>Completed Application</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Qualified Lead</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>SIFT Offer Sent</fullName>
        <actions>
            <name>SIFT_Offer_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Sift_Offer_Letter_Sent__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>SSC Email Date</fullName>
        <actions>
            <name>Opportunity_SetSSCEmailDateToday</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.SSC_Email_Sent__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>SSC Pre-Arrival Call Date</fullName>
        <actions>
            <name>Opportunity_SetSSCPreArrivalDateToday</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.SSC_Pre_Arrival_Call_Completed__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>SSC Welcome Call</fullName>
        <actions>
            <name>SSC_Welcome_Call_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.SSC_Welcome_Call_Completed__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Welcome Call Date autofilled</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send Applicant Portal Registration Email</fullName>
        <actions>
            <name>Sent_Applicant_Portal_Registration_Email</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.IsClosed</field>
            <operation>notEqual</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Application_Status__c</field>
            <operation>equals</operation>
            <value>Active,Qualified</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Personal_Information_Complete__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Program_and_Location_Tab_Complete__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Close Date</fullName>
        <actions>
            <name>Application_Set_Close_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.IsClosed</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Set Date%2FTime Complete-Application Fee</fullName>
        <actions>
            <name>Set_Date_Time_Complete_Application_Fee</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Application_Fee_Complete__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Top_Apply_Account_Id__c</field>
            <operation>equals</operation>
            <value></value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Date%2FTime Complete-Attachments Tab</fullName>
        <actions>
            <name>Set_Date_Time_Complete_Attachments_Tab</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.Attachments_Tab_Complete__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Date%2FTime Complete-Education Tab</fullName>
        <actions>
            <name>Set_Date_Time_Complete_Education_Tab</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Education_Tab_Complete__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Date%2FTime Complete-Employment Tab</fullName>
        <actions>
            <name>Set_Date_Time_Complete_Employment_Tab</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Employment_Tab_Complete__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Date%2FTime Complete-Essay Tab</fullName>
        <actions>
            <name>Set_Date_Time_Complete_Essay_Tab</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Essay_Tab_Complete__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Date%2FTime Complete-Exam Tab</fullName>
        <actions>
            <name>Set_Date_Time_Complete_Exam_Tab</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Essay_Tab_Complete__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Date%2FTime Complete-Final Submission Tab</fullName>
        <actions>
            <name>Set_Date_Time_Completed_Final_Submission</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Final_Submission_Tab_Complete__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Date%2FTime Complete-Personal Information Tab</fullName>
        <actions>
            <name>Set_Data_Time_Compete_Personal_Info_Tab</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Personal_Information_Complete__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Date%2FTime Complete-Program %26 Loc Tab</fullName>
        <actions>
            <name>Set_Date_Time_Complete_Program_Loc_Tab</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Program_and_Location_Tab_Complete__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Date%2FTime Complete-Reference Tab</fullName>
        <actions>
            <name>Set_Date_Time_Completed_Reference_Tab</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Reference_Tab_Complete__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Date%2FTime Complete-Sponsorship Tab</fullName>
        <actions>
            <name>Set_Date_Time_Complete_Sponsorsip_Tab</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Sponsorship_Tab_Complete__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Ideal Name</fullName>
        <actions>
            <name>Opportunity_SetIdealName</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Set Lead Source to Online Application</fullName>
        <actions>
            <name>Application_Set_Lead_Source_to_Online_Ap</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.CreatedDate</field>
            <operation>equals</operation>
            <value>TODAY</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.LeadSource</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>User.UserType</field>
            <operation>equals</operation>
            <value>High Volume Portal</value>
        </criteriaItems>
        <description>Set the Lead Source to Online Application If the Application is new and the Lead Source is blank and the Owner is a Portal User</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Opp Owner</fullName>
        <active>false</active>
        <formula>TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Set Program Start Date%3ASept 2012</fullName>
        <actions>
            <name>Opportunity_Set_Pgm_Start_Date_Sept_2012</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.IsClosed</field>
            <operation>notEqual</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Start_Term__c</field>
            <operation>equals</operation>
            <value>September 2012</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Set Specialization Taken%3F to false</fullName>
        <actions>
            <name>Uncheck_Specialization_Taken</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Specialization_Name__c</field>
            <operation>equals</operation>
            <value>Not Applicable</value>
        </criteriaItems>
        <description>This rule un-checks the &apos;Specialization Taken?&apos; Field when the Specialization is Not Applicable</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Start Term to 2011</fullName>
        <actions>
            <name>Opportunity_Set_Start_Term_2011</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.OP_Start_Term__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.OP_Start_Term__c</field>
            <operation>contains</operation>
            <value>September 2011</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Start Term to 2012</fullName>
        <actions>
            <name>Opportunity_Set_Start_Term_2012</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.OP_Start_Term__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.OP_Start_Term__c</field>
            <operation>contains</operation>
            <value>September 2012</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Start Term to 2013</fullName>
        <actions>
            <name>Opportunity_Set_Start_Term_2013</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.OP_Start_Term__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.OP_Start_Term__c</field>
            <operation>contains</operation>
            <value>September 2013</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Start Term to 2014</fullName>
        <actions>
            <name>Opportunity_Set_Start_Term_2014</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.OP_Start_Term__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.OP_Start_Term__c</field>
            <operation>contains</operation>
            <value>September 2014</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Under Review</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.Application_Status__c</field>
            <operation>equals</operation>
            <value>Active</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Under Review</value>
        </criteriaItems>
        <description>Notification that Application has been stalled in the stage for longer than allowed</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Owner</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.OwnerId</field>
            <operation>notEqual</operation>
            <value></value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Primay Campus when Program changed- Boston</fullName>
        <actions>
            <name>Opportunity_Update_Primary_Campus_Boston</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED( Program__c) &amp;&amp;Program__r.Campus__c = &apos;Boston&apos;</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Primay Campus when Program changed- Dubai</fullName>
        <actions>
            <name>Opportunity_Set_Primary_Campus_to_Dubai</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED(  Program__c ) &amp;&amp; Program__r.Campus__c = &apos;Dubai&apos;</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Primay Campus when Program changed- London</fullName>
        <actions>
            <name>Opportunity_Update_Primary_Campus_Lond</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED( Program__c) &amp;&amp; Program__r.Campus__c = &apos;London&apos;</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Primay Campus when Program changed- San Francisco</fullName>
        <actions>
            <name>Opportunity_update_Primary_Campus_San_Fr</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED( Program__c ) &amp;&amp;Program__r.Campus__c = &apos;San Francisco&apos;</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Primay Campus when Program changed-Shanghai</fullName>
        <actions>
            <name>Opportunity_Update_Primary_Campus_Shang</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED( Program__c) &amp;&amp; Program__r.Campus__c = &apos;Shanghai&apos;</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Visa Notice Sent Date</fullName>
        <actions>
            <name>Visa_Notice_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Visa_Notice_Sent_to_Student__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>WCD Application Stage Date</fullName>
        <actions>
            <name>WCD_Application_Stage_Date_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.WCD_Application_Stage__c</field>
            <operation>equals</operation>
            <value>Withdrawn,Deferral,Cancellation</value>
        </criteriaItems>
        <description>back end date stamp</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>timetrigger</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.CreatedDate</field>
            <operation>equals</operation>
            <value>TODAY</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <tasks>
        <fullName>Admission_Decision</fullName>
        <assignedToType>owner</assignedToType>
        <description>One of your applicants has an admission decision.</description>
        <dueDateOffset>1</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>High</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Admission Decision</subject>
    </tasks>
</Workflow>
