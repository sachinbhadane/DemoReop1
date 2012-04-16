<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Contact_us_auto_reply_email</fullName>
        <ccEmails>daniel.bjarne@ef.com</ccEmails>
        <description>Contact us auto reply email</description>
        <protected>false</protected>
        <recipients>
            <field>ContactId</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>Hult_Email_Templates/test</template>
    </alerts>
    <rules>
        <fullName>Contact us - auto reply</fullName>
        <actions>
            <name>Contact_us_auto_reply_email</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Campaign.Name</field>
            <operation>equals</operation>
            <value>Contact Us</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
