public class ApplicantMypageController {
    PageReference newPage;
    public Opportunity opp;
    User user;
    //integer tLogin;
    public pagereference lastlogin()
    {
        user = [SELECT contact.Total_Login__c, contact.Last_Log_In__c FROM User
        WHERE id = :UserInfo.getUserId()];
        //tLogin = user.contact.Total_Login__c;
        user.contact.Last_Log_In__c=datetime.now();
        if(user.contact.Total_Login__c == null){
            user.contact.Total_Login__c = 1;
        }
        else{
            user.contact.Total_Login__c = user.contact.Total_Login__c+1;
        }
        update user.contact;
        
        // Code for redirect after complete payment
            try{
             opp=[select Applicant_Confirmation__c from Opportunity where contact__c=:user.contact.id limit 1];
                if(opp.Applicant_Confirmation__c=='Yes'){
                    newPage = Page.ApplicantaccountDetails;        
                    //newPage = Page.ApplicantProgramLocation;
                }
                else{
                    newPage = Page.ApplicantProgramLocation;
                }
                
            } 
            catch (exception e){
                newPage = Page.ApplicantProgramLocation;
            }     
        
        return newPage.setRedirect(true);
    }

}