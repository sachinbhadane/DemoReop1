public class ApplicantNewPasswordController {
public boolean loginpanel{get;set;}
public String password{get;set;}
public String password1{get;set;}
public String userid{get;set;}
        public ApplicantNewPasswordController()
        {
            if(System.currentPagereference().getParameters().get('id')!=null)
            {
                userid=System.currentPagereference().getParameters().get('id').substring(0,18);
                password=System.currentPagereference().getParameters().get('id').substring(18);
            }
        }
        

         public PageReference login() 
         {
             try
             {
                 User user = [SELECT username,id FROM User WHERE id=:userid];
                 String startUrl ='/ApplicantChangePassword?uid='+user.id;
                 loginpanel=true;
                 PageReference page=  Site.login(user.username, password, startUrl);
                 return page;
             }
             catch(exception e)
             {
                 loginpanel=true;
             }
             return null;
         }
 
         public PageReference ApplicantResetpassword()
         {
              if(password.trim()=='')
              {
                  ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter New Password'));
              }
              if(password1.trim()=='')
              {
                  ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter Confirm New Password'));
              }
              if(password1.trim()!=password.trim())
              {
                  ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'New Password and Confirm New Password did not match'));
              }
              if(!apexpages.hasmessages()) 
              { 
                  try
                  {
                      String uid=System.currentPagereference().getParameters().get('uid');
                      system.SetPassword(uid,password);
                      //return Page.ApplicantProgramLocation;
                      return Page.ApplicantMypage;
                  }
                  Catch(exception e)
                  {
                      ApexPages.addMessages(e);
                      //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'You can not use old password'));
                      return null;
                  }                  
              }
           return null;   
         }
         
          
}