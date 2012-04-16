<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Finance_Transaction_Notify_Applicant_Tuition_Payment_has_been_Received</fullName>
        <description>Finance Transaction: Notify Applicant Tuition Payment has been Received</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>Hult_Email_Templates/Notify_Applicant_Tuition_Payment_has_been_Received</template>
    </alerts>
    <alerts>
        <fullName>Finance_Transaction_Notify_Recruiter_HK_Finance_Wire_Transfer_Success</fullName>
        <ccEmails>jp.delaneyjr@roundcorner.com</ccEmails>
        <description>Finance Transaction:Notify Recruiter HK Finance Wire Transfer Success</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>Hult_Email_Templates/Notify_Recruiter_HK_Finance_Wire_Transfer_Success</template>
    </alerts>
    <alerts>
        <fullName>Finance_Transaction_Notify_Recruiter_Successful_Deposit_Payment_via_Credit_Card</fullName>
        <description>Finance Transaction:Notify Recruiter Successful Deposit Payment via Credit Card</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Hult_Email_Templates/Notify_Recruiter_Successful_Deposit_Payment_via_Credit_Card</template>
    </alerts>
    <alerts>
        <fullName>Finance_Transaction_Notify_Recruiter_Unsuccessful_Deposit_Payment_via_Credit_Car</fullName>
        <description>Finance Transaction:Notify Recruiter Unsuccessful Deposit Payment via Credit Card</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>Hult_Email_Templates/Notify_Recruiter_Unsuccessful_Deposit_Payment_via_Credit_Card</template>
    </alerts>
    <alerts>
        <fullName>Finance_Trasaction_Notify_Applicant_Confirmation_Deposit_has_been_Received</fullName>
        <description>Finance Trasaction:Notify Applicant Confirmation Deposit has been Received</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>Hult_Email_Templates/Notify_Applicant_Confirmation_Deposit_has_been_Received</template>
    </alerts>
    <alerts>
        <fullName>NotifyRecruiterAppliantHasSuccessfullyPaidConfirmationDepositWithCinSalesforce</fullName>
        <description>Notify Recruiter Applicant has successfully paid Confirmation Deposit via CC in Salesforce</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>Hult_Email_Templates/Notify_Recruiter_of_Success_Deposit_payment_via_Salesforce_Credit_Card</template>
    </alerts>
    <fieldUpdates>
        <fullName>FinTrans_Set_Tran_Status_to_Timed_Out</fullName>
        <field>Transaction_Status__c</field>
        <literalValue>Transaction Timed Out</literalValue>
        <name>FinTrans:Set Tran Status to Timed Out</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Finance_Transaction</fullName>
        <field>Amount_Received__c</field>
        <formula>OP_Deposit_Amount_Du__c</formula>
        <name>Finance Transaction</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Finance_Transaction_Set_App_Fee_Amt_Paid</fullName>
        <field>Amount_Received__c</field>
        <formula>OP_Application_Fee_Due__c</formula>
        <name>Finance Transaction:Set App Fee Amt Paid</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Finance_Transaction_Set_Trans_Stat_Manua</fullName>
        <field>Transaction_Status__c</field>
        <literalValue>Manually Processed</literalValue>
        <name>Finance Transaction:Set Trans Stat Manua</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Finance_Transaction_Timeout_PtS_Payment</fullName>
        <field>Transaction_Status__c</field>
        <literalValue>Transaction Timed Out</literalValue>
        <name>Finance Transaction:Timeout PtS Payment</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Credit Card Transaction Timeout</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Finance_Transactions__c.Transaction_Method__c</field>
            <operation>equals</operation>
            <value>CC Charged Via Salesforce</value>
        </criteriaItems>
        <criteriaItems>
            <field>Finance_Transactions__c.Transaction_Status__c</field>
            <operation>equals</operation>
            <value>Pending</value>
        </criteriaItems>
        <description>When a Credit Card Transaction via Salesforce is in the Pending state for at least an hour, the status will be set to Transaction Timed Out</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notify Applicant Confirmation Deposit has been Received</fullName>
        <actions>
            <name>Finance_Trasaction_Notify_Applicant_Confirmation_Deposit_has_been_Received</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Finance_Transactions__c.Transaction_Type__c</field>
            <operation>equals</operation>
            <value>Confirmation Deposit</value>
        </criteriaItems>
        <criteriaItems>
            <field>Finance_Transactions__c.Transaction_Status__c</field>
            <operation>equals</operation>
            <value>Success,Manually Processed</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notify Applicant Tuition Payment has been Received</fullName>
        <actions>
            <name>Finance_Transaction_Notify_Applicant_Tuition_Payment_has_been_Received</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Finance_Transactions__c.Transaction_Type__c</field>
            <operation>equals</operation>
            <value>Tuition Fee Payment</value>
        </criteriaItems>
        <criteriaItems>
            <field>Finance_Transactions__c.Transaction_Status__c</field>
            <operation>equals</operation>
            <value>Success,Manually Processed</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notify Recruiter Confirmation Deposit Success via Salesforce CC</fullName>
        <actions>
            <name>NotifyRecruiterAppliantHasSuccessfullyPaidConfirmationDepositWithCinSalesforce</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Finance_Transactions__c.Transaction_Type__c</field>
            <operation>equals</operation>
            <value>Confirmation Deposit</value>
        </criteriaItems>
        <criteriaItems>
            <field>Finance_Transactions__c.Transaction_Status__c</field>
            <operation>equals</operation>
            <value>Success</value>
        </criteriaItems>
        <criteriaItems>
            <field>Finance_Transactions__c.Transaction_Method__c</field>
            <operation>equals</operation>
            <value>CC Charged Via Salesforce</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notify Recruiter HK Finance Wire Transfer Success</fullName>
        <actions>
            <name>Finance_Transaction_Notify_Recruiter_HK_Finance_Wire_Transfer_Success</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Finance_Transactions__c.Transaction_Type__c</field>
            <operation>equals</operation>
            <value>Confirmation Deposit</value>
        </criteriaItems>
        <criteriaItems>
            <field>Finance_Transactions__c.Transaction_Status__c</field>
            <operation>equals</operation>
            <value>Manually Processed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Finance_Transactions__c.Transaction_Method__c</field>
            <operation>equals</operation>
            <value>Wire Transfer</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notify Recruiter Successful Deposit Payment via Credit Card</fullName>
        <actions>
            <name>Finance_Transaction_Notify_Recruiter_Successful_Deposit_Payment_via_Credit_Card</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Finance_Transactions__c.Transaction_Type__c</field>
            <operation>equals</operation>
            <value>Confirmation Deposit</value>
        </criteriaItems>
        <criteriaItems>
            <field>Finance_Transactions__c.Transaction_Status__c</field>
            <operation>equals</operation>
            <value>Success</value>
        </criteriaItems>
        <criteriaItems>
            <field>Finance_Transactions__c.Transaction_Method__c</field>
            <operation>equals</operation>
            <value>CC Charged Via Salesforce</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notify Recruiter Unsuccessful Deposit Payment via Credit Card</fullName>
        <actions>
            <name>Finance_Transaction_Notify_Recruiter_Unsuccessful_Deposit_Payment_via_Credit_Car</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Finance_Transactions__c.Transaction_Type__c</field>
            <operation>equals</operation>
            <value>Confirmation Deposit</value>
        </criteriaItems>
        <criteriaItems>
            <field>Finance_Transactions__c.Transaction_Status__c</field>
            <operation>equals</operation>
            <value>Decline</value>
        </criteriaItems>
        <criteriaItems>
            <field>Finance_Transactions__c.Transaction_Method__c</field>
            <operation>equals</operation>
            <value>CC Charged Via Salesforce</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set App Fee Paid</fullName>
        <actions>
            <name>Finance_Transaction_Set_App_Fee_Amt_Paid</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Finance_Transactions__c.Transaction_Type__c</field>
            <operation>equals</operation>
            <value>Application Fee</value>
        </criteriaItems>
        <criteriaItems>
            <field>Finance_Transactions__c.Transaction_Status__c</field>
            <operation>equals</operation>
            <value>Success</value>
        </criteriaItems>
        <criteriaItems>
            <field>Finance_Transactions__c.Transaction_Method__c</field>
            <operation>equals</operation>
            <value>Manual Transaction,CC Charged Via Salesforce,CC Charged via HK,Manual Credit Card</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set App ID on Finance Transaction</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Finance_Transactions__c.CreatedDate</field>
            <operation>equals</operation>
            <value>TODAY</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Deposit Amount Paid for SixCards CC Transactions</fullName>
        <actions>
            <name>Finance_Transaction</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Finance_Transactions__c.Error_Code__c</field>
            <operation>equals</operation>
            <value>0</value>
        </criteriaItems>
        <criteriaItems>
            <field>Finance_Transactions__c.Transaction_Method__c</field>
            <operation>equals</operation>
            <value>CC Charged Via Salesforce</value>
        </criteriaItems>
        <criteriaItems>
            <field>Finance_Transactions__c.Transaction_Type__c</field>
            <operation>equals</operation>
            <value>Confirmation Deposit</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Transaction Status to Manual</fullName>
        <actions>
            <name>Finance_Transaction_Set_Trans_Stat_Manua</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Finance_Transactions__c.Transaction_Method__c</field>
            <operation>equals</operation>
            <value>CC Charged via HK,Manual Credit Card,Wire Transfer,From Top Apply</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Timeout PaytoStudy Transaction</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Finance_Transactions__c.Transaction_Status__c</field>
            <operation>equals</operation>
            <value>Pending</value>
        </criteriaItems>
        <criteriaItems>
            <field>Finance_Transactions__c.Transaction_Type__c</field>
            <operation>equals</operation>
            <value>PtS 2nd Payment,PtS 1st Payment</value>
        </criteriaItems>
        <criteriaItems>
            <field>Finance_Transactions__c.Transaction_Status__c</field>
            <operation>notEqual</operation>
            <value>Success</value>
        </criteriaItems>
        <description>Set the Transaction Status to Timed Out if the Transaction Status equal Pending and the Transaction Type is either a PtS 1st Payment or a PtS 2nd Payment</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
