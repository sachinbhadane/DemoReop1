public with sharing class ApplicantForgottenPasswordController{
public String username {get; set;}   
public boolean success1{get;set;}
public String url= site.getCurrentSiteUrl();
    
    public ApplicantForgottenPasswordController() {}
    
    public static String getranpassword(Integer len)
    {
        Blob blobKey = crypto.generateAesKey(128);
        String key = EncodingUtil.convertToHex(blobKey);
        return key.substring(0,len);
    } 

    public PageReference forgotPassword() 
    {
          try{
              String password=getranpassword(8);
              User user=[select contact.Agent_Email_Address__c, id,name,email from user where username=:username and isactive=true];
              system.setpassword(user.id,password);
              sendmail(user.email,user.name,user.id,password,user.contact.Agent_Email_Address__c);
              
              success1=true;
              ApexPages.addmessage(new ApexPages.message(ApexPages.severity.confirm,'Email has been sent to change password.'));
          }
          catch(exception e)
          {
              ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Email address does not exist.'));
              //apexpages.addmessages(e);
          }
          return null;
    }

    public void sendmail(String email,String name,String id,String password,string agentEmail)
    {
            
            String msg='Dear '+name+',<br /><br />You requested to have your password reset. Use the link below to access our secure password reset function.<br /><br />';
            msg +='<a href=\''+url+'ApplicantNewPassword?id='+id+password+'\'>Click here to change password</a>';
            msg +='<br /><br />';
            msg +='If you have any questions please don&#39;t hesitate to contact us!'; 
            msg +='<br /><br />';
            msg +='Best regards,<br />Hult International Business School';
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            String[] toAddresses;
            if(agentEmail!=null){
               toAddresses = new String[] {email,agentEmail}; 
            }
            else{
               toAddresses = new String[] {email}; 
            }
            mail.setToAddresses(toAddresses);
            mail.setSubject('Change password');
            mail.setBccSender(false);                   
            mail.setHtmlBody(msg);
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
}